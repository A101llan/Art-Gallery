<?php
// api/exhibitions.php - Exhibitions API Endpoint

require_once APP_PATH . '/config/database.php';
require_once APP_PATH . '/classes/Exhibition.php';
require_once APP_PATH . '/classes/Auth.php';
require_once APP_PATH . '/utils/Security.php';

try {
    // No need for session_start() or CORS headers here, as they are handled by public/index.php
    $database = new Database();
    $db = $database->getConnection();
    $exhibition = new Exhibition($db);
    $auth = new Auth($db);

    // Get HTTP method and URI for routing
    $method = $_SERVER['REQUEST_METHOD'];
    $request_uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
    $project_base = '/usanii_mashariki'; // This should match what's in public/index.php
    if (strpos($request_uri, $project_base) === 0) {
        $request_uri = substr($request_uri, strlen($project_base));
    }
    $request_uri = trim($request_uri, '/');

    // Extract ID from URI for specific exhibition operations
    $path_parts = explode('/', $request_uri);
    $exhibition_id = null;
    // Example: /api/exhibitions/123
    if (count($path_parts) >= 3 && $path_parts[1] === 'exhibitions' && is_numeric($path_parts[2])) {
        $exhibition_id = intval($path_parts[2]);
    }

    // Auto-sync statuses on every exhibitions API request
    $exhibition->syncStatuses();

    switch($method) {
        case 'GET':
            if ($exhibition_id) {
                handleGetExhibitionById($exhibition, $exhibition_id);
            } else {
                handleGetExhibitions($exhibition);
            }
            break;
        case 'POST':
            // CSRF protection for POST requests
            if (!isset($_SERVER['HTTP_X_CSRF_TOKEN']) || !Security::verifyCSRFToken($_SERVER['HTTP_X_CSRF_TOKEN'])) {
                http_response_code(403);
                echo json_encode(['success' => false, 'message' => 'CSRF token mismatch.']);
                exit;
            }
            handleCreateExhibition($exhibition, $auth);
            break;
        case 'PUT':
            if (!isset($_SERVER['HTTP_X_CSRF_TOKEN']) || !Security::verifyCSRFToken($_SERVER['HTTP_X_CSRF_TOKEN'])) {
                http_response_code(403);
                echo json_encode(['success' => false, 'message' => 'CSRF token mismatch.']);
                exit;
            }
            handleUpdateExhibition($exhibition, $auth, $exhibition_id);
            break;
        case 'DELETE':
            if (!isset($_SERVER['HTTP_X_CSRF_TOKEN']) || !Security::verifyCSRFToken($_SERVER['HTTP_X_CSRF_TOKEN'])) {
                http_response_code(403);
                echo json_encode(['success' => false, 'message' => 'CSRF token mismatch.']);
                exit;
            }
            handleDeleteExhibition($exhibition, $auth, $exhibition_id);
            break;
        default:
            http_response_code(405);
            echo json_encode(['success' => false, 'message' => 'Method not allowed']);
    }
} catch(Exception $e) {
    error_log("Exhibitions API error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Internal server error']);
}
exit;

// Handles getting a single exhibition by ID
function handleGetExhibitionById($exhibition, $exhibition_id) {
    $result = $exhibition->getById($exhibition_id);
    if ($result['success']) {
        echo json_encode($result);
    } else {
        http_response_code(404);
        echo json_encode($result);
    }
}

function handleGetExhibitions($exhibition) {
    $filters = [];
    
    if (isset($_GET['active']) && $_GET['active'] === 'true') {
        $filters['active'] = true;
    }
    
    if (isset($_GET['status'])) {
        $filters['status'] = Security::sanitizeInput($_GET['status']);
    }
    
    if (isset($_GET['limit'])) {
        $filters['limit'] = min(20, intval($_GET['limit']));
    }

    $result = $exhibition->getAll($filters);
    echo json_encode($result);
}

function handleCreateExhibition($exhibition, $auth) {
    if (!$auth->isLoggedIn() || !$auth->hasRole('staff')) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'Staff access required']);
        return;
    }

    $input = json_decode(file_get_contents('php://input'), true);
    
    if (!$input) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Invalid input data']);
        return;
    }

    // Sanitize and validate input
    $data = [
        'name' => Security::sanitizeInput($input['name'] ?? ''),
        'description' => Security::sanitizeInput($input['description'] ?? ''),
        'start_date' => $input['start_date'] ?? '',
        'end_date' => $input['end_date'] ?? '',
        'featured_image' => Security::sanitizeInput($input['featured_image'] ?? ''),
        'created_by' => $_SESSION['user_id'],
        'status' => 'upcoming',
        'max_artworks' => intval($input['max_artworks'] ?? 50)
    ];

    if (empty($data['name']) || empty($data['start_date']) || empty($data['end_date'])) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Name, start date, and end date are required']);
        return;
    }

    $result = $exhibition->create($data);
    
    if ($result['success']) {
        http_response_code(201);
        echo json_encode($result);
    } else {
        http_response_code(400);
        echo json_encode($result);
    }
}

function handleUpdateExhibition($exhibition, $auth, $exhibition_id) {
    if (!$auth->isLoggedIn() || !$auth->hasRole('staff')) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'Staff access required']);
        return;
    }
    if (!$exhibition_id) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Exhibition ID required']);
        return;
    }
    $input = json_decode(file_get_contents('php://input'), true) ?: [];
    $data = [
        'name' => Security::sanitizeInput($input['name'] ?? null),
        'description' => Security::sanitizeInput($input['description'] ?? null),
        'start_date' => $input['start_date'] ?? null,
        'end_date' => $input['end_date'] ?? null,
        'featured_image' => Security::sanitizeInput($input['featured_image'] ?? null),
        'status' => Security::sanitizeInput($input['status'] ?? null),
        'max_artworks' => isset($input['max_artworks']) ? intval($input['max_artworks']) : null,
    ];
    // Remove nulls
    $data = array_filter($data, fn($v) => $v !== null);
    $result = $exhibition->update($exhibition_id, $data);
    echo json_encode($result);
}

function handleDeleteExhibition($exhibition, $auth, $exhibition_id) {
    if (!$auth->isLoggedIn() || !$auth->hasRole('staff')) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'Staff access required']);
        return;
    }
    if (!$exhibition_id) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Exhibition ID required']);
        return;
    }
    $result = $exhibition->delete($exhibition_id);
    echo json_encode($result);
}
