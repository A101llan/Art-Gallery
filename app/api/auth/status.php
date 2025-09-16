<?php
// api/auth/status.php - Check Authentication Status

require_once APP_PATH . '/config/database.php';
require_once APP_PATH . '/classes/Auth.php';

try {
    // No need for session_start() or CORS headers here, as they are handled by public/index.php
    if (isset($_SESSION['logged_in']) && $_SESSION['logged_in'] === true) {
        echo json_encode([
            'success' => true,
            'user' => [
                'id' => $_SESSION['user_id'],
                'name' => $_SESSION['user_name'],
                'email' => $_SESSION['user_email'],
                'role' => $_SESSION['user_role']
            ]
        ]);
    } else {
        http_response_code(401);
        echo json_encode(['success' => false, 'message' => 'Not authenticated']);
    }
} catch(Exception $e) {
    error_log("Status API error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Server error']);
}
exit;
