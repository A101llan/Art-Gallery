<?php
// classes/Exhibition.php - Exhibition Management Class

require_once APP_PATH . '/config/database.php';
require_once APP_PATH . '/utils/Security.php'; // Assuming logActivity uses Security or a similar utility

class Exhibition {
    private $conn;
    private $table_name = "exhibitions";

    public function __construct($db) {
        $this->conn = $db;
    }

    // Create new exhibition
    public function create($data) {
        try {
            $query = "INSERT INTO " . $this->table_name . " 
                     SET name = ?, description = ?, start_date = ?, end_date = ?, 
                         featured_image = ?, status = ?, created_by = ?, max_artworks = ?";
            
            $stmt = $this->conn->prepare($query);
            
            if ($stmt->execute([
                $data['name'],
                $data['description'],
                $data['start_date'],
                $data['end_date'],
                $data['featured_image'] ?? '',
                $data['status'] ?? 'upcoming',
                $data['created_by'],
                $data['max_artworks'] ?? 50
            ])) {
                $exhibition_id = $this->conn->lastInsertId();
                $this->logActivity($data['created_by'], 'exhibition_created', 'exhibitions', $exhibition_id, null, $data);
                return ['success' => true, 'message' => 'Exhibition created successfully', 'exhibition_id' => $exhibition_id];
            }
            
            return ['success' => false, 'message' => 'Failed to create exhibition'];
            
        } catch(Exception $e) {
            error_log("Exhibition creation error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to create exhibition'];
        }
    }

    // Get all exhibitions
    public function getAll($filters = []) {
        try {
            $where_conditions = [];
            $params = [];
            
            $query = "SELECT e.*, u.name as created_by_name,
                            (SELECT COUNT(*) FROM exhibition_artworks ea WHERE ea.exhibition_id = e.id) as artwork_count
                     FROM " . $this->table_name . " e
                     LEFT JOIN users u ON e.created_by = u.id";

            // Apply filters
            if (!empty($filters['status'])) {
                $where_conditions[] = "e.status = ?";
                $params[] = $filters['status'];
            }

            if (!empty($filters['active'])) {
                $where_conditions[] = "e.start_date <= CURDATE() AND e.end_date >= CURDATE() AND e.status = 'active'";
            }

            // Add WHERE clause
            if (!empty($where_conditions)) {
                $query .= " WHERE " . implode(" AND ", $where_conditions);
            }

            $query .= " ORDER BY e.start_date DESC";

            $stmt = $this->conn->prepare($query);
            $stmt->execute($params);
            
            return ['success' => true, 'data' => $stmt->fetchAll()];
            
        } catch(Exception $e) {
            error_log("Get exhibitions error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to retrieve exhibitions'];
        }
    }

    // Auto-sync statuses based on dates
    public function syncStatuses() {
        try {
            // Active: today between start and end
            $this->conn->exec("UPDATE {$this->table_name} SET status = 'active' WHERE start_date <= CURDATE() AND end_date >= CURDATE() AND status <> 'active'");
            // Upcoming: starts in the future
            $this->conn->exec("UPDATE {$this->table_name} SET status = 'upcoming' WHERE start_date > CURDATE() AND status <> 'upcoming'");
            // Completed: ended in the past
            $this->conn->exec("UPDATE {$this->table_name} SET status = 'completed' WHERE end_date < CURDATE() AND status <> 'completed'");
        } catch (Exception $e) {
            error_log('Exhibition syncStatuses error: ' . $e->getMessage());
        }
    }

    // Get exhibition by ID with artworks
    public function getById($id) {
        try {
            $query = "SELECT e.*, u.name as created_by_name
                     FROM " . $this->table_name . " e
                     LEFT JOIN users u ON e.created_by = u.id
                     WHERE e.id = ?";
            $stmt = $this->conn->prepare($query);
            $stmt->execute([$id]);
            
            if ($stmt->rowCount() > 0) {
                $exhibition = $stmt->fetch();
                
                // Get artworks in this exhibition
                $artworks_query = "SELECT a.*, ea.display_order, c.name as category_name, u.name as artist_name
                                 FROM exhibition_artworks ea
                                 JOIN artworks a ON ea.artwork_id = a.id
                                 LEFT JOIN categories c ON a.category_id = c.id
                                 LEFT JOIN users u ON a.artist_id = u.id
                                 WHERE ea.exhibition_id = ?
                                 ORDER BY ea.display_order ASC, a.title ASC";
                $artworks_stmt = $this->conn->prepare($artworks_query);
                $artworks_stmt->execute([$id]);
                
                $exhibition['artworks'] = $artworks_stmt->fetchAll();
                
                return ['success' => true, 'data' => $exhibition];
            }
            
            return ['success' => false, 'message' => 'Exhibition not found'];
            
        } catch(Exception $e) {
            error_log("Get exhibition error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to retrieve exhibition'];
        }
    }

    // Update exhibition
    public function update($id, $data) {
        try {
            // Build dynamic update
            $allowed = ['name','description','start_date','end_date','featured_image','status','max_artworks'];
            $set = [];
            $params = [];
            foreach ($allowed as $field) {
                if (array_key_exists($field, $data)) {
                    $set[] = "$field = ?";
                    $params[] = $data[$field];
                }
            }
            if (empty($set)) {
                return ['success' => false, 'message' => 'No fields to update'];
            }
            $params[] = $id;
            $stmt = $this->conn->prepare("UPDATE {$this->table_name} SET " . implode(', ', $set) . " WHERE id = ?");
            if ($stmt->execute($params)) {
                $this->logActivity($_SESSION['user_id'], 'exhibition_updated', 'exhibitions', $id, null, $data);
                return ['success' => true, 'message' => 'Exhibition updated'];
            }
            return ['success' => false, 'message' => 'Failed to update exhibition'];
        } catch (Exception $e) {
            error_log('Exhibition update error: ' . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to update exhibition'];
        }
    }

    // Delete exhibition
    public function delete($id) {
        try {
            // Optionally remove relations
            $this->conn->prepare('DELETE FROM exhibition_artworks WHERE exhibition_id = ?')->execute([$id]);
            $stmt = $this->conn->prepare("DELETE FROM {$this->table_name} WHERE id = ?");
            if ($stmt->execute([$id])) {
                $this->logActivity($_SESSION['user_id'], 'exhibition_deleted', 'exhibitions', $id);
                return ['success' => true, 'message' => 'Exhibition deleted'];
            }
            return ['success' => false, 'message' => 'Failed to delete exhibition'];
        } catch (Exception $e) {
            error_log('Exhibition delete error: ' . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to delete exhibition'];
        }
    }

    // Add artwork to exhibition
    public function addArtwork($exhibition_id, $artwork_id, $display_order = 0) {
        try {
            $query = "INSERT INTO exhibition_artworks 
                     SET exhibition_id = ?, artwork_id = ?, display_order = ?, added_by = ?";
            $stmt = $this->conn->prepare($query);
            
            if ($stmt->execute([$exhibition_id, $artwork_id, $display_order, $_SESSION['user_id']])) {
                $this->logActivity($_SESSION['user_id'], 'artwork_added_to_exhibition', 'exhibition_artworks', $exhibition_id);
                return ['success' => true, 'message' => 'Artwork added to exhibition'];
            }
            
            return ['success' => false, 'message' => 'Failed to add artwork to exhibition'];
            
        } catch(Exception $e) {
            error_log("Add artwork to exhibition error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to add artwork to exhibition'];
        }
    }

    // Remove artwork from exhibition
    public function removeArtwork($exhibition_id, $artwork_id) {
        try {
            $query = "DELETE FROM exhibition_artworks WHERE exhibition_id = ? AND artwork_id = ?";
            $stmt = $this->conn->prepare($query);
            
            if ($stmt->execute([$exhibition_id, $artwork_id])) {
                $this->logActivity($_SESSION['user_id'], 'artwork_removed_from_exhibition', 'exhibition_artworks', $exhibition_id);
                return ['success' => true, 'message' => 'Artwork removed from exhibition'];
            }
            
            return ['success' => false, 'message' => 'Failed to remove artwork from exhibition'];
            
        } catch(Exception $e) {
            error_log("Remove artwork from exhibition error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to remove artwork from exhibition'];
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
