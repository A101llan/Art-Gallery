<?php
class Auth {
    private $conn;
    private $table_name = "users";

    public function __construct($db) {
        $this->conn = $db;
    }

    // Register new user
    public function register($name, $email, $password, $role = 'visitor') {
        try {
            // Check if email already exists
            $query = "SELECT id FROM " . $this->table_name . " WHERE email = ?";
            $stmt = $this->conn->prepare($query);
            $stmt->execute([$email]);
            
            if ($stmt->rowCount() > 0) {
                return ['success' => false, 'message' => 'Email already registered'];
            }

            // Validate password strength
            if (!$this->validatePassword($password)) {
                return ['success' => false, 'message' => 'Password must be at least 8 characters with uppercase, lowercase, number and special character'];
            }

            // Hash password
            $password_hash = password_hash($password, PASSWORD_BCRYPT, ['cost' => 12]);

            // Insert new user
            $query = "INSERT INTO " . $this->table_name . " 
                     SET name = ?, email = ?, password = ?, role = ?, status = 'active', email_verified = 0";
            $stmt = $this->conn->prepare($query);
            
            if ($stmt->execute([$name, $email, $password_hash, $role])) {
                $user_id = $this->conn->lastInsertId();
                $this->logActivity($user_id, 'user_registered', 'users', $user_id);
                return ['success' => true, 'message' => 'User role updated successfully'];
            }
            
            return ['success' => false, 'message' => 'Failed to update user role'];
            
        } catch(Exception $e) {
            error_log("Change role error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to update user role'];
        }
    }

    // Get artists with their artwork count
    public function getArtists() {
        try {
            $query = "SELECT u.id, u.name, u.email, u.phone, u.bio, u.profile_image, u.created_at,
                            COUNT(a.id) as artwork_count
                     FROM " . $this->table_name . " u
                     LEFT JOIN artworks a ON u.id = a.artist_id AND a.status = 'approved'
                     WHERE u.role = 'artist' AND u.status = 'active'
                     GROUP BY u.id
                     ORDER BY u.name";
            
            $stmt = $this->conn->prepare($query);
            $stmt->execute();
            
            return ['success' => true, 'data' => $stmt->fetchAll()];
            
        } catch(Exception $e) {
            error_log("Get artists error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to retrieve artists'];
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