<?php
// utils/Security.php - Security Utilities

class Security {
    
    // Sanitize input
    public static function sanitizeInput($data) {
        if (is_array($data)) {
            return array_map([self::class, 'sanitizeInput'], $data);
        }
        return htmlspecialchars(trim($data), ENT_QUOTES, 'UTF-8');
    }

    // Validate email
    public static function validateEmail($email) {
        return filter_var($email, FILTER_VALIDATE_EMAIL) !== false;
    }

    // Validate username (requires two names, no numbers)
    public static function validateUsername($username) {
        // Remove extra spaces and trim
        $username = trim(preg_replace('/\s+/', ' ', $username));
        
        // Check if it contains at least two words (first and last name)
        $name_parts = explode(' ', $username);
        if (count($name_parts) < 2) {
            return ['valid' => false, 'message' => 'Username must contain at least two names (first and last name)'];
        }
        
        // Check if any part contains numbers
        foreach ($name_parts as $part) {
            if (preg_match('/\d/', $part)) {
                return ['valid' => false, 'message' => 'Names cannot contain numbers'];
            }
        }
        
        // Check if each name part is at least 2 characters long
        foreach ($name_parts as $part) {
            if (strlen($part) < 2) {
                return ['valid' => false, 'message' => 'Each name must be at least 2 characters long'];
            }
        }
        
        // Check if total length is reasonable (2-50 characters)
        if (strlen($username) < 4 || strlen($username) > 50) {
            return ['valid' => false, 'message' => 'Username must be between 4 and 50 characters'];
        }
        
        // Check if it contains only letters, spaces, hyphens, and apostrophes
        if (!preg_match('/^[a-zA-Z\s\'-]+$/', $username)) {
            return ['valid' => false, 'message' => 'Names can only contain letters, spaces, hyphens, and apostrophes'];
        }
        
        return ['valid' => true, 'message' => 'Username is valid'];
    }

    // Generate CSRF token
    public static function generateCSRFToken() {
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }
        
        if (!isset($_SESSION['csrf_token'])) {
            $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
        }
        
        return $_SESSION['csrf_token'];
    }

    // Verify CSRF token
    public static function verifyCSRFToken($token) {
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }
        
        return isset($_SESSION['csrf_token']) && hash_equals($_SESSION['csrf_token'], $token);
    }

    // Rate limiting
    public static function checkRateLimit($action, $limit = 5, $window = 300) {
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }
        
        $key = $action . '_' . ($_SERVER['REMOTE_ADDR'] ?? 'unknown');
        $current_time = time();
        
        if (!isset($_SESSION['rate_limits'])) {
            $_SESSION['rate_limits'] = [];
        }
        
        if (!isset($_SESSION['rate_limits'][$key])) {
            $_SESSION['rate_limits'][$key] = [];
        }
        
        // Clean old entries
        $_SESSION['rate_limits'][$key] = array_filter(
            $_SESSION['rate_limits'][$key], 
            function($timestamp) use ($current_time, $window) {
                return ($current_time - $timestamp) < $window;
            }
        );
        
        // Check limit
        if (count($_SESSION['rate_limits'][$key]) >= $limit) {
            return false;
        }
        
        // Add current request
        $_SESSION['rate_limits'][$key][] = $current_time;
        return true;
    }

    // Validate file upload
    public static function validateFileUpload($file, $allowed_types = ['jpg', 'jpeg', 'png', 'gif'], $max_size = 5242880) {
        if ($file['error'] !== UPLOAD_ERR_OK) {
            return ['success' => false, 'message' => 'File upload error'];
        }
        
        if ($file['size'] > $max_size) {
            return ['success' => false, 'message' => 'File size too large'];
        }
        
        $file_extension = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
        if (!in_array($file_extension, $allowed_types)) {
            return ['success' => false, 'message' => 'Invalid file type'];
        }
        
        // Check if it's actually an image
        $image_info = getimagesize($file['tmp_name']);
        if ($image_info === false) {
            return ['success' => false, 'message' => 'Invalid image file'];
        }
        
        return ['success' => true];
    }

    // Generate secure filename
    public static function generateSecureFilename($original_name) {
        $extension = strtolower(pathinfo($original_name, PATHINFO_EXTENSION));
        $filename = bin2hex(random_bytes(16)) . '.' . $extension;
        return $filename;
    }
}
