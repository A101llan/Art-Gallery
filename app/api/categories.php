<?php
// api/categories.php - Categories API

require_once APP_PATH . '/config/database.php';
require_once APP_PATH . '/classes/Category.php';
require_once APP_PATH . '/utils/Security.php'; // Add this line

try {
    // No need for session_start() or CORS headers here, as they are handled by public/index.php
    $database = new Database();
    $db = $database->getConnection();
    $category = new Category($db);

    // Get HTTP method and URI for routing
    $method = $_SERVER['REQUEST_METHOD'];
    $request_uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
    $project_base = '/usanii_mashariki'; // This should match what's in public/index.php
    if (strpos($request_uri, $project_base) === 0) {
        $request_uri = substr($request_uri, strlen($project_base));
    }
    $request_uri = trim($request_uri, '/');

    // Extract ID from URI for specific category operations
    $path_parts = explode('/', $request_uri);
    $category_id = null;
    // Example: /api/categories/123
    if (count($path_parts) >= 3 && $path_parts[1] === 'categories' && is_numeric($path_parts[2])) {
        $category_id = intval($path_parts[2]);
    }

    switch ($method) {
        case 'GET':
            if ($category_id) {
                // Handle get by ID if needed, otherwise this will fall through to getAll with ID as filter
                $result = $category->getById($category_id); // Assuming a getById method exists or will be added
            } else {
                $result = $category->getAll();
            }
            echo json_encode($result);
            break;
        case 'POST':
            // CSRF Token verification for POST requests
            if (!isset($_SERVER['HTTP_X_CSRF_TOKEN']) || !Security::verifyCSRFToken($_SERVER['HTTP_X_CSRF_TOKEN'])) {
                http_response_code(403);
                echo json_encode(['success' => false, 'message' => 'CSRF token mismatch.']);
                exit;
            }
            
            // You might need Auth for creating categories, depending on permissions
            // For now, assume it's handled elsewhere or allowed without specific auth check here
            $input = json_decode(file_get_contents('php://input'), true);
            if (isset($input['name'])) {
                $name = Security::sanitizeInput($input['name']);
                $description = Security::sanitizeInput($input['description'] ?? '');
                $result = $category->create($name, $description);
                if ($result['success']) {
                    http_response_code(201);
                } else {
                    http_response_code(400);
                }
                echo json_encode($result);
            } else {
                http_response_code(400);
                echo json_encode(['success' => false, 'message' => 'Category name required']);
            }
            break;
        // Add PUT/DELETE handlers if needed for categories
        default:
            http_response_code(405);
            echo json_encode(['success' => false, 'message' => 'Method not allowed']);
            break;
    }
} catch(Exception $e) {
    error_log("Categories API error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Internal server error']);
}
exit;
?>
