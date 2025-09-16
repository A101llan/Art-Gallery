<?php
// api/auth/csrf-token.php

require_once APP_PATH . '/utils/Security.php';

try {
    echo json_encode(['success' => true, 'csrf_token' => Security::generateCSRFToken()]);
} catch(Exception $e) {
    error_log("CSRF token generation API error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Failed to generate CSRF token']);
}
exit;
