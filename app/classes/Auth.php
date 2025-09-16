<?php
// classes/Auth.php - Authentication Class

require_once APP_PATH . '/config/database.php';
require_once APP_PATH . '/utils/Security.php';

class Auth {
    private $conn;
    private $table_name = "users";

    public function __construct($db) {
        $this->conn = $db;
    }

    // Register new user
    public function register($name, $email, $password, $role = 'visitor') {
        try {
            // Validate username (requires two names, no numbers)
            $usernameValidation = Security::validateUsername($name);
            if (!$usernameValidation['valid']) {
                return ['success' => false, 'message' => $usernameValidation['message']];
            }
            
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
                return ['success' => true, 'message' => 'Registration successful', 'user_id' => $user_id];
            }
            
            return ['success' => false, 'message' => 'Registration failed'];
            
        } catch(Exception $e) {
            error_log("Registration error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Registration failed'];
        }
    }

    // Login user
    public function login($email, $password) {
        try {
            // Detect which password column exists: 'password' or 'password_hash'
            $colCheck = $this->conn->prepare("SHOW COLUMNS FROM " . $this->table_name . " LIKE 'password'");
            $colCheck->execute();
            $hasPassword = $colCheck->rowCount() > 0;

            if ($hasPassword) {
                $query = "SELECT id, name, email, password, role, status, email_verified 
                          FROM " . $this->table_name . " WHERE email = ? AND status = 'active'";
            } else {
                // Fallback to legacy schema using password_hash
                $query = "SELECT id, name, email, password_hash AS password, role, status, email_verified 
                          FROM " . $this->table_name . " WHERE email = ? AND status = 'active'";
            }

            $stmt = $this->conn->prepare($query);
            $stmt->execute([$email]);

            if ($stmt->rowCount() == 1) {
                $user = $stmt->fetch();
                
                if (!empty($user['password']) && password_verify($password, $user['password'])) {
                    // Start session and set user data
                    if (session_status() == PHP_SESSION_NONE) {
                        session_start();
                    }
                    
                    $_SESSION['user_id'] = $user['id'];
                    $_SESSION['user_name'] = $user['name'];
                    $_SESSION['user_email'] = $user['email'];
                    $_SESSION['user_role'] = $user['role'];
                    $_SESSION['logged_in'] = true;
                    
                    $this->logActivity($user['id'], 'user_login', 'users', $user['id']);
                    
                    return [
                        'success' => true, 
                        'message' => 'Login successful',
                        'user' => [
                            'id' => $user['id'],
                            'name' => $user['name'],
                            'email' => $user['email'],
                            'role' => $user['role']
                        ]
                    ];
                }
            }
            
            return ['success' => false, 'message' => 'Invalid credentials'];
            
        } catch(Exception $e) {
            error_log("Login error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Login failed'];
        }
    }

    // Logout user
    public function logout() {
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }
        
        if (isset($_SESSION['user_id'])) {
            $this->logActivity($_SESSION['user_id'], 'user_logout', 'users', $_SESSION['user_id']);
        }
        
        session_destroy();
        return ['success' => true, 'message' => 'Logged out successfully'];
    }

    // Check if user is logged in
    public function isLoggedIn() {
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }
        return isset($_SESSION['logged_in']) && $_SESSION['logged_in'] === true;
    }

    // Check user role
    public function hasRole($required_role) {
        if (!$this->isLoggedIn()) {
            return false;
        }
        
        $user_role = $_SESSION['user_role'];
        
        // Role hierarchy: staff > artist > visitor
        $role_hierarchy = ['visitor' => 1, 'artist' => 2, 'staff' => 3];
        
        return $role_hierarchy[$user_role] >= $role_hierarchy[$required_role];
    }

    // Get current user
    public function getCurrentUser() {
        if (!$this->isLoggedIn()) {
            return null;
        }
        
        return [
            'id' => $_SESSION['user_id'],
            'name' => $_SESSION['user_name'],
            'email' => $_SESSION['user_email'],
            'role' => $_SESSION['user_role']
        ];
    }

    // Validate password strength
    private function validatePassword($password) {
        return preg_match('/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/', $password);
    }

    // Log user activity
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
