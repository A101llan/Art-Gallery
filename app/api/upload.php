<?php
// api/upload.php - File Upload Handler

require_once APP_PATH . '/config/database.php';
require_once APP_PATH . '/classes/Auth.php';
require_once APP_PATH . '/utils/Security.php';
require_once APP_PATH . '/utils/FileUpload.php';

try {
    // No need for session_start() or CORS headers here, as they are handled by public/index.php
    $database = new Database();
    $db = $database->getConnection();
    $auth = new Auth($db);

    // Check authentication and method
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        http_response_code(405);
        echo json_encode(['success' => false, 'message' => 'Method not allowed']);
        exit;
    }

    if (!$auth->isLoggedIn() || !$auth->hasRole('artist')) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'Artist access required']);
        exit;
    }

    // CSRF Token verification for POST requests
    if (!isset($_SERVER['HTTP_X_CSRF_TOKEN']) || !Security::verifyCSRFToken($_SERVER['HTTP_X_CSRF_TOKEN'])) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'CSRF token mismatch.']);
        exit;
    }

    if (!isset($_FILES['artwork_image'])) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'No file uploaded']);
        exit;
    }

    $fileUpload = new FileUpload();
    $result = $fileUpload->uploadArtworkImage($_FILES['artwork_image']);

    if ($result['success']) {
        echo json_encode([
            'success' => true,
            'message' => 'File uploaded successfully',
            'data' => [
                'image_url' => $result['file_path'],
                'thumbnail_url' => $result['thumbnail_path'],
                'filename' => $result['filename']
            ]
        ]);
    } else {
        http_response_code(400);
        echo json_encode($result);
    }
} catch(Exception $e) {
    error_log("Upload API error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Upload failed']);
}
exit;
?>
