<?php
// classes/User.php - User Management Class

require_once APP_PATH . '/config/database.php';
require_once APP_PATH . '/utils/Security.php';

class User {
    private $conn;
    private $table_name = "users";

    public function __construct($db) {
        $this->conn = $db;
    }

    // Get user by ID
    public function getById($id) {
        try {
            $query = "SELECT id, name, email, role, phone, bio, profile_image, status, 
                            email_verified, created_at, updated_at 
                     FROM " . $this->table_name . " WHERE id = ?";
            $stmt = $this->conn->prepare($query);
            $stmt->execute([$id]);
            
            if ($stmt->rowCount() > 0) {
                return ['success' => true, 'data' => $stmt->fetch()];
            }
            
            return ['success' => false, 'message' => 'User not found'];
            
        } catch(Exception $e) {
            error_log("Get user error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to retrieve user'];
        }
    }

    // Get all users with filters
    public function getAll($filters = []) {
        try {
            $where_conditions = [];
            $params = [];
            
            $query = "SELECT id, name, email, role, phone, status, email_verified, created_at
                     FROM " . $this->table_name;

            if (!empty($filters['role'])) {
                $where_conditions[] = "role = ?";
                $params[] = $filters['role'];
            }

            if (!empty($filters['status'])) {
                $where_conditions[] = "status = ?";
                $params[] = $filters['status'];
            }

            if (!empty($where_conditions)) {
                $query .= " WHERE " . implode(" AND ", $where_conditions);
            }

            $query .= " ORDER BY created_at DESC";

            $stmt = $this->conn->prepare($query);
            $stmt->execute($params);
            
            return ['success' => true, 'data' => $stmt->fetchAll()];
            
        } catch(Exception $e) {
            error_log("Get users error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to retrieve users'];
        }
    }

    // Update user profile
    public function updateProfile($id, $data) {
        try {
            $set_clauses = [];
            $params = [];
            
            $allowed_fields = ['name', 'phone', 'bio', 'profile_image'];
            
            foreach ($allowed_fields as $field) {
                if (array_key_exists($field, $data)) {
                    $set_clauses[] = "$field = ?";
                    $params[] = $data[$field];
                }
            }
            
            if (empty($set_clauses)) {
                return ['success' => false, 'message' => 'No valid fields to update'];
            }
            
            $params[] = $id;
            
            $query = "UPDATE " . $this->table_name . " SET " . implode(', ', $set_clauses) . " WHERE id = ?";
            $stmt = $this->conn->prepare($query);
            
            if ($stmt->execute($params)) {
                $this->logActivity($id, 'profile_updated', 'users', $id, null, $data);
                return ['success' => true, 'message' => 'Profile updated successfully'];
            }
            
            return ['success' => false, 'message' => 'Failed to update profile'];
            
        } catch(Exception $e) {
            error_log("Update profile error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to update profile'];
        }
    }

    // Change user role (staff only)
    public function changeRole($user_id, $new_role) {
        try {
            $query = "UPDATE " . $this->table_name . " SET role = ? WHERE id = ?";
            $stmt = $this->conn->prepare($query);
            
            if ($stmt->execute([$new_role, $user_id])) {
                $this->logActivity($_SESSION['user_id'], 'user_role_changed', 'users', $user_id, 
                                 null, ['new_role' => $new_role]);
                return ['success' => true, 'message' => 'User role updated successfully'];
            }
            
            return ['success' => false, 'message' => 'Failed to update user role'];
            
        } catch(Exception $e) {
            error_log("Change role error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to update user role'];
        }
    }

    // Log user activity (private method, assuming this is correct in the original)
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
