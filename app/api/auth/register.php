<?php
// api/auth/register.php

require_once APP_PATH . '/config/database.php';
require_once APP_PATH . '/classes/Auth.php';
require_once APP_PATH . '/utils/Security.php';

try {
    $input = json_decode(file_get_contents('php://input'), true);

    // CSRF Token verification
    if (!isset($_SERVER['HTTP_X_CSRF_TOKEN']) || !Security::verifyCSRFToken($_SERVER['HTTP_X_CSRF_TOKEN'])) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'CSRF token mismatch.']);
        exit;
    }

    if (!$input || !isset($input['name']) || !isset($input['email']) || !isset($input['password'])) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Name, email and password required']);
        exit;
    }
    
    // Sanitize input
    $name = Security::sanitizeInput($input['name']);
    $email = Security::sanitizeInput($input['email']);
    $password = $input['password']; // Don't sanitize password
    $role = Security::sanitizeInput($input['role'] ?? 'visitor');
    
    // Validate inputs
    if (empty($name) || empty($email) || empty($password)) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'All fields are required']);
        exit;
    }
    
    if (!Security::validateEmail($email)) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Invalid email format']);
        exit;
    }
    
    // Validate username (requires two names, no numbers)
    $usernameValidation = Security::validateUsername($name);
    if (!$usernameValidation['valid']) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => $usernameValidation['message']]);
        exit;
    }
    
    if (!in_array($role, ['visitor', 'artist'])) {
        $role = 'visitor'; // Default to visitor for security
    }
    
    // Register user
    $database = new Database();
    $db = $database->getConnection();
    $auth = new Auth($db);
    
    $result = $auth->register($name, $email, $password, $role);
    
    if ($result['success']) {
        http_response_code(201);
        echo json_encode($result);
    } else {
        http_response_code(400);
        echo json_encode($result);
    }
    
} catch(Exception $e) {
    error_log("Register API error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Internal server error']);
}
exit;
