<?php
// classes/Category.php - Category Management Class

require_once APP_PATH . '/config/database.php';
require_once APP_PATH . '/utils/Security.php'; // Assuming logActivity uses Security or a similar utility

class Category {
    private $conn;
    private $table_name = "categories";

    public function __construct($db) {
        $this->conn = $db;
    }

    // Get all categories
    public function getAll() {
        try {
            $query = "SELECT c.*, COUNT(a.id) as artwork_count
                     FROM " . $this->table_name . " c
                     LEFT JOIN artworks a ON c.id = a.category_id AND a.status = 'approved'
                     GROUP BY c.id
                     ORDER BY c.name";
            
            $stmt = $this->conn->prepare($query);
            $stmt->execute();
            
            return ['success' => true, 'data' => $stmt->fetchAll()];
            
        } catch(Exception $e) {
            error_log("Get categories error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to retrieve categories'];
        }
    }

    // Get single category by ID
    public function getById($id) {
        try {
            $query = "SELECT c.*, 
                            (SELECT COUNT(a.id) FROM artworks a WHERE a.category_id = c.id AND a.status = 'approved') as artwork_count
                     FROM " . $this->table_name . " c
                     WHERE c.id = ?";
            $stmt = $this->conn->prepare($query);
            $stmt->execute([$id]);

            if ($stmt->rowCount() > 0) {
                return ['success' => true, 'data' => $stmt->fetch()];
            }

            return ['success' => false, 'message' => 'Category not found'];
        } catch(Exception $e) {
            error_log("Get category error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to retrieve category'];
        }
    }

    // Create new category
    public function create($name, $description = '') {
        try {
            $query = "INSERT INTO " . $this->table_name . " SET name = ?, description = ?";
            $stmt = $this->conn->prepare($query);
            
            if ($stmt->execute([$name, $description])) {
                $category_id = $this->conn->lastInsertId();
                // Assuming $_SESSION['user_id'] is available for logging in the API endpoint
                $this->logActivity($_SESSION['user_id'] ?? null, 'category_created', 'categories', $category_id);
                return ['success' => true, 'message' => 'Category created successfully', 'category_id' => $category_id];
            }
            
            return ['success' => false, 'message' => 'Failed to create category'];
            
        } catch(Exception $e) {
            if ($e->getCode() == 23000) { // Duplicate entry
                return ['success' => false, 'message' => 'Category name already exists'];
            }
            error_log("Create category error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Failed to create category'];
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
