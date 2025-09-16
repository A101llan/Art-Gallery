<?php
// classes/Submission.php - Submission Management Class

require_once APP_PATH . '/config/database.php';
require_once APP_PATH . '/utils/Security.php';

class Submission {
    private $conn;
    private $table_name = "submissions";

    public function __construct($db) {
        $this->conn = $db;
    }

    // Get all submissions with filters
    public function getAll($filters = []) {
        try {
            $where_conditions = [];
            $params = [];
            
            $query = "SELECT s.*, a.title as artwork_title, a.image_url, a.thumbnail_url,
                            artist.name as artist_name, artist.email as artist_email,
                            reviewer.name as reviewer_name
                     FROM " . $this->table_name . " s
                     JOIN artworks a ON s.artwork_id = a.id
                     JOIN users artist ON s.artist_id = artist.id
                     LEFT JOIN users reviewer ON s.reviewed_by = reviewer.id";

            // Apply filters
            if (!empty($filters['status'])) {
                $where_conditions[] = "s.status = ?";
                $params[] = $filters['status'];
            }

            if (!empty($filters['artist_id'])) {
                $where_conditions[] = "s.artist_id = ?";
                $params[] = $filters['artist_id'];
            }

            if (!empty($filters['pending'])) {
                $where_conditions[] = "s.status IN ('pending', 'under_review')";
            }

            // Add WHERE clause
            if (!empty($where_conditions)) {
                $query .= " WHERE " . implode(" AND ", $where_conditions);
            }

            $query .= " ORDER BY s.submitted_at DESC";

            $stmt = $this->conn->prepare($query);
            $stmt->execute($params);
            
            return ['success' => true, 'data' => $stmt->fetchAll()];
            
        } catch(Exception $e) {
            error_log("Get submissions error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to retrieve submissions'];
        }
    }

    // Get submission by ID
    public function getById($id) {
        try {
            $query = "SELECT s.*, a.title as artwork_title, a.thumbnail_url, artist.name as artist_name, reviewer.name as reviewer_name
                     FROM " . $this->table_name . " s
                     JOIN artworks a ON s.artwork_id = a.id
                     JOIN users artist ON s.artist_id = artist.id
                     LEFT JOIN users reviewer ON s.reviewed_by = reviewer.id
                     WHERE s.id = ?";
            $stmt = $this->conn->prepare($query);
            $stmt->execute([$id]);

            if ($stmt->rowCount() > 0) {
                return ['success' => true, 'data' => $stmt->fetch()];
            }

            return ['success' => false, 'message' => 'Submission not found'];
        } catch(Exception $e) {
            error_log("Get submission by ID error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to retrieve submission'];
        }
    }

    // Review submission (approve/reject)
    public function review($submission_id, $action, $review_notes = '') {
        try {
            $reviewer_id = $_SESSION['user_id'];
            
            // Get submission details
            $query = "SELECT * FROM " . $this->table_name . " WHERE id = ?";
            $stmt = $this->conn->prepare($query);
            $stmt->execute([$submission_id]);
            
            if ($stmt->rowCount() == 0) {
                return ['success' => false, 'message' => 'Submission not found'];
            }
            
            $submission = $stmt->fetch();
            
            // Update submission
            $new_status = ($action === 'approve') ? 'approved' : 'rejected';
            $query = "UPDATE " . $this->table_name . " 
                     SET status = ?, review_notes = ?, reviewed_by = ?, reviewed_at = CURRENT_TIMESTAMP 
                     WHERE id = ?";
            $stmt = $this->conn->prepare($query);
            
            if ($stmt->execute([$new_status, $review_notes, $reviewer_id, $submission_id])) {
                // Update artwork status
                $artwork_status = ($action === 'approve') ? 'approved' : 'rejected';
                $artwork_query = "UPDATE artworks SET status = ? WHERE id = ?";
                $artwork_stmt = $this->conn->prepare($artwork_query);
                $artwork_stmt->execute([$artwork_status, $submission['artwork_id']]);
                
                $this->logActivity($reviewer_id, 'submission_reviewed', 'submissions', $submission_id, 
                                 $submission, ['status' => $new_status, 'action' => $action]);
                
                return ['success' => true, 'message' => 'Submission ' . $action . 'd successfully'];
            }
            
            return ['success' => false, 'message' => 'Failed to review submission'];
            
        } catch(Exception $e) {
            error_log("Review submission error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to review submission'];
        }
    }

    // Get submission by artwork ID
    public function getByArtworkId($artwork_id) {
        try {
            $query = "SELECT s.*, reviewer.name as reviewer_name
                     FROM " . $this->table_name . " s
                     LEFT JOIN users reviewer ON s.reviewed_by = reviewer.id
                     WHERE s.artwork_id = ?";
            $stmt = $this->conn->prepare($query);
            $stmt->execute([$artwork_id]);
            
            if ($stmt->rowCount() > 0) {
                return ['success' => true, 'data' => $stmt->fetch()];
            }
            
            return ['success' => false, 'message' => 'Submission not found'];
            
        } catch(Exception $e) {
            error_log("Get submission error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to retrieve submission'];
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
