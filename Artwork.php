<?php
class Artwork {
    private $conn;
    private $table_name = "artworks";

    public function __construct($db) {
        $this->conn = $db;
    }

    // Create new artwork
    public function create($data) {
        try {
            $query = "INSERT INTO " . $this->table_name . " 
                     SET title = ?, description = ?, category_id = ?, artist_id = ?, 
                         image_url = ?, thumbnail_url = ?, dimensions = ?, medium = ?, 
                         year_created = ?, price = ?, status = ?";
            
            $stmt = $this->conn->prepare($query);
            
            if ($stmt->execute([
                $data['title'],
                $data['description'],
                $data['category_id'],
                $data['artist_id'],
                $data['image_url'],
                $data['thumbnail_url'] ?? '',
                $data['dimensions'] ?? '',
                $data['medium'] ?? '',
                $data['year_created'] ?? null,
                $data['price'] ?? null,
                $data['status'] ?? 'draft'
            ])) {
                $artwork_id = $this->conn->lastInsertId();
                $this->logActivity($data['artist_id'], 'artwork_created', 'artworks', $artwork_id, null, $data);
                return ['success' => true, 'message' => 'Artwork created successfully', 'artwork_id' => $artwork_id];
            }
            
            return ['success' => false, 'message' => 'Failed to create artwork'];
            
        } catch(Exception $e) {
            error_log("Artwork creation error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to create artwork'];
        }
    }

    // Get artwork by ID
    public function getById($id) {
        try {
            $query = "SELECT a.*, c.name as category_name, u.name as artist_name, u.email as artist_email
                     FROM " . $this->table_name . " a
                     LEFT JOIN categories c ON a.category_id = c.id
                     LEFT JOIN users u ON a.artist_id = u.id
                     WHERE a.id = ?";
            $stmt = $this->conn->prepare($query);
            $stmt->execute([$id]);
            
            if ($stmt->rowCount() > 0) {
                return ['success' => true, 'data' => $stmt->fetch()];
            }
            
            return ['success' => false, 'message' => 'Artwork not found'];
            
        } catch(Exception $e) {
            error_log("Get artwork error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to retrieve artwork'];
        }
    }

    // Get all artworks with filters
    public function getAll($filters = []) {
        try {
            $where_conditions = [];
            $params = [];
            
            // Base query
            $query = "SELECT a.*, c.name as category_name, u.name as artist_name
                     FROM " . $this->table_name . " a
                     LEFT JOIN categories c ON a.category_id = c.id
                     LEFT JOIN users u ON a.artist_id = u.id";

            // Apply filters
            if (!empty($filters['status'])) {
                $where_conditions[] = "a.status = ?";
                $params[] = $filters['status'];
            }

            if (!empty($filters['category_id'])) {
                $where_conditions[] = "a.category_id = ?";
                $params[] = $filters['category_id'];
            }

            if (!empty($filters['artist_id'])) {
                $where_conditions[] = "a.artist_id = ?";
                $params[] = $filters['artist_id'];
            }

            if (!empty($filters['featured'])) {
                $where_conditions[] = "a.featured = ?";
                $params[] = $filters['featured'];
            }

            if (!empty($filters['search'])) {
                $where_conditions[] = "(a.title LIKE ? OR a.description LIKE ? OR u.name LIKE ?)";
                $search_term = '%' . $filters['search'] . '%';
                $params[] = $search_term;
                $params[] = $search_term;
                $params[] = $search_term;
            }

            // Add WHERE clause if conditions exist
            if (!empty($where_conditions)) {
                $query .= " WHERE " . implode(" AND ", $where_conditions);
            }

            // Add ordering
            $query .= " ORDER BY a.created_at DESC";

            // Add pagination
            if (!empty($filters['limit'])) {
                $query .= " LIMIT " . intval($filters['limit']);
                if (!empty($filters['offset'])) {
                    $query .= " OFFSET " . intval($filters['offset']);
                }
            }

            $stmt = $this->conn->prepare($query);
            $stmt->execute($params);
            
            return ['success' => true, 'data' => $stmt->fetchAll()];
            
        } catch(Exception $e) {
            error_log("Get artworks error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to retrieve artworks'];
        }
    }

    // Update artwork
    public function update($id, $data) {
        try {
            // Get current data for logging
            $current = $this->getById($id);
            if (!$current['success']) {
                return $current;
            }

            $set_clauses = [];
            $params = [];
            
            // Build dynamic update query
            $allowed_fields = ['title', 'description', 'category_id', 'image_url', 'thumbnail_url', 
                             'dimensions', 'medium', 'year_created', 'price', 'status', 'featured'];
            
            foreach ($allowed_fields as $field) {
                if (array_key_exists($field, $data)) {
                    $set_clauses[] = "$field = ?";
                    $params[] = $data[$field];
                }
            }
            
            if (empty($set_clauses)) {
                return ['success' => false, 'message' => 'No valid fields to update'];
            }
            
            $params[] = $id; // Add ID for WHERE clause
            
            $query = "UPDATE " . $this->table_name . " SET " . implode(', ', $set_clauses) . " WHERE id = ?";
            $stmt = $this->conn->prepare($query);
            
            if ($stmt->execute($params)) {
                $this->logActivity($_SESSION['user_id'], 'artwork_updated', 'artworks', $id, 
                                 $current['data'], $data);
                return ['success' => true, 'message' => 'Artwork updated successfully'];
            }
            
            return ['success' => false, 'message' => 'Failed to update artwork'];
            
        } catch(Exception $e) {
            error_log("Artwork update error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to update artwork'];
        }
    }

    // Delete artwork
    public function delete($id) {
        try {
            // Get current data for logging
            $current = $this->getById($id);
            if (!$current['success']) {
                return $current;
            }

            $query = "DELETE FROM " . $this->table_name . " WHERE id = ?";
            $stmt = $this->conn->prepare($query);
            
            if ($stmt->execute([$id])) {
                $this->logActivity($_SESSION['user_id'], 'artwork_deleted', 'artworks', $id, 
                                 $current['data'], null);
                return ['success' => true, 'message' => 'Artwork deleted successfully'];
            }
            
            return ['success' => false, 'message' => 'Failed to delete artwork'];
            
        } catch(Exception $e) {
            error_log("Artwork deletion error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to delete artwork'];
        }
    }

    // Submit artwork for approval
    public function submit($artwork_id, $artist_id, $notes = '') {
        try {
            // Check if artwork exists and belongs to artist
            $artwork = $this->getById($artwork_id);
            if (!$artwork['success'] || $artwork['data']['artist_id'] != $artist_id) {
                return ['success' => false, 'message' => 'Artwork not found or unauthorized'];
            }

            // Create submission record
            $query = "INSERT INTO submissions 
                     SET artwork_id = ?, artist_id = ?, status = 'pending', submission_notes = ?
                     ON DUPLICATE KEY UPDATE 
                     status = 'pending', submission_notes = ?, submitted_at = CURRENT_TIMESTAMP";
            
            $stmt = $this->conn->prepare($query);
            
            if ($stmt->execute([$artwork_id, $artist_id, $notes, $notes])) {
                // Update artwork status
                $this->update($artwork_id, ['status' => 'submitted']);
                
                $this->logActivity($artist_id, 'artwork_submitted', 'submissions', $artwork_id);
                return ['success' => true, 'message' => 'Artwork submitted for approval'];
            }
            
            return ['success' => false, 'message' => 'Failed to submit artwork'];
            
        } catch(Exception $e) {
            error_log("Artwork submission error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to submit artwork'];
        }
    }

    // Increment view count
    public function incrementViews($id) {
        try {
            $query = "UPDATE " . $this->table_name . " SET views_count = views_count + 1 WHERE id = ?";
            $stmt = $this->conn->prepare($query);
            $stmt->execute([$id]);
        } catch(Exception $e) {
            error_log("View count error: " . $e->getMessage());
        }
    }

    // Log activity
    private function logActivity($user_id, $action, $table_name, $record_id, $old_values = null, $new_values = null) {
        try {
            $query = "INSERT INTO activity_logs 
                     SET user_id = ?, action = ?, table_name = ?, record_id = ?, 
                         old_values = ?, new_values = ?, ip_address = ?, user_agent = ?";
            $stmt = $this->conn->prepare($query);
            $stmt->execute([
                $user_id,
                $action,
                $table_name,
                $record_id,
                json_encode($old_values),
                json_encode($new_values),
                $_SERVER['REMOTE_ADDR'] ?? '',
                $_SERVER['HTTP_USER_AGENT'] ?? ''
            ]);
        } catch(Exception $e) {
            error_log("Activity logging error: " . $e->getMessage());
        }
    }
}