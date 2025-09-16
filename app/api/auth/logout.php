<?php
// api/auth/logout.php

require_once APP_PATH . '/config/database.php';
require_once APP_PATH . '/classes/Auth.php';

try {
    $database = new Database();
    $db = $database->getConnection();
    $auth = new Auth($db);
    
    $result = $auth->logout();
    echo json_encode($result);
    
} catch(Exception $e) {
    error_log("Logout API error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Internal server error']);
}
exit;
