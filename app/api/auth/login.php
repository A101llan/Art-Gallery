<?php
// api/auth/login.php

require_once APP_PATH . '/config/database.php';
require_once APP_PATH . '/classes/Auth.php';
require_once APP_PATH . '/utils/Security.php';

try {
    // Rate limiting
    if (!Security::checkRateLimit('login', 5, 300)) {
        http_response_code(429);
        echo json_encode(['success' => false, 'message' => 'Too many login attempts. Please try again later.']);
        exit;
    }
    
    $input = json_decode(file_get_contents('php://input'), true);

    // CSRF Token verification
    if (!isset($_SERVER['HTTP_X_CSRF_TOKEN']) || !Security::verifyCSRFToken($_SERVER['HTTP_X_CSRF_TOKEN'])) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'CSRF token mismatch.']);
        exit;
    }

    if (!$input || !isset($input['email']) || !isset($input['password'])) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Email and password required']);
        exit;
    }
    
    // Sanitize input
    $email = Security::sanitizeInput($input['email']);
    $password = $input['password']; // Don't sanitize password
    
    // Validate email format
    if (!Security::validateEmail($email)) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Invalid email format']);
        exit;
    }
    
    // Authenticate
    $database = new Database();
    $db = $database->getConnection();
    $auth = new Auth($db);
    
    $result = $auth->login($email, $password);
    
    if ($result['success']) {
        http_response_code(200);
        echo json_encode($result);
    } else {
        http_response_code(401);
        echo json_encode($result);
    }
    
} catch(Exception $e) {
    error_log("Login API error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Internal server error']);
}
exit;
