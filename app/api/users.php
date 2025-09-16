<?php
// api/users.php - Users API

require_once APP_PATH . '/config/database.php';
require_once APP_PATH . '/classes/User.php';
require_once APP_PATH . '/classes/Auth.php';
require_once APP_PATH . '/utils/Security.php';

try {
    // Database and classes
    $db = (new Database())->getConnection();
    $userModel = new User($db);
    $auth = new Auth($db);

    // Parse request path
    $requestUri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
    $projectBase = '/usanii_mashariki';
    if (strpos($requestUri, $projectBase) === 0) {
        $requestUri = substr($requestUri, strlen($projectBase));
    }
    $requestUri = trim($requestUri, '/');
    $segments = explode('/', $requestUri); // e.g., ['api','users','change-role','123'] or ['api','users','45']

    $method = $_SERVER['REQUEST_METHOD'];

    // Helper: read JSON body
    $readJson = function() {
        $raw = file_get_contents('php://input');
        $data = json_decode($raw, true);
        return is_array($data) ? $data : [];
    };

    // Helper: CSRF check for state-changing methods
    $requireCsrf = function() {
        $token = $_SERVER['HTTP_X_CSRF_TOKEN'] ?? '';
        if (!$token || !Security::verifyCSRFToken($token)) {
            http_response_code(400);
            echo json_encode(['success' => false, 'message' => 'Invalid or missing CSRF token']);
            exit;
        }
    };

    // Routing
    if ($method === 'GET') {
        // GET /api/users or GET /api/users/{id}
        if (isset($segments[2]) && is_numeric($segments[2])) {
            $requestedId = intval($segments[2]);
            $currentUser = $auth->getCurrentUser();

            if (!$currentUser) {
                http_response_code(401);
                echo json_encode(['success' => false, 'message' => 'Not authenticated']);
                exit;
            }

            // Staff can view any user, others only themselves
            if ($currentUser['role'] !== 'staff' && $currentUser['id'] !== $requestedId) {
                http_response_code(403);
                echo json_encode(['success' => false, 'message' => 'Forbidden']);
                exit;
            }

            $result = $userModel->getById($requestedId);
            echo json_encode($result);
            exit;
        } else {
            // List users (staff only)
            $currentUser = $auth->getCurrentUser();
            if (!$currentUser || $currentUser['role'] !== 'staff') {
                http_response_code(403);
                echo json_encode(['success' => false, 'message' => 'Forbidden']);
                exit;
            }

            $filters = [];
            if (!empty($_GET['role'])) { $filters['role'] = Security::sanitizeInput($_GET['role']); }
            if (!empty($_GET['status'])) { $filters['status'] = Security::sanitizeInput($_GET['status']); }
            $result = $userModel->getAll($filters);
            echo json_encode($result);
            exit;
        }
    }

    if ($method === 'PUT') {
        // Change role: PUT /api/users/change-role/{id}
        if (isset($segments[2]) && $segments[2] === 'change-role' && isset($segments[3]) && is_numeric($segments[3])) {
            $requireCsrf();

            $currentUser = $auth->getCurrentUser();
            if (!$currentUser || $currentUser['role'] !== 'staff') {
                http_response_code(403);
                echo json_encode(['success' => false, 'message' => 'Forbidden']);
                exit;
            }

            $targetUserId = intval($segments[3]);
            $payload = $readJson();
            $newRole = isset($payload['new_role']) ? Security::sanitizeInput($payload['new_role']) : '';
            if (!$newRole) {
                http_response_code(400);
                echo json_encode(['success' => false, 'message' => 'New role is required']);
                exit;
            }

            $result = $userModel->changeRole($targetUserId, $newRole);
            echo json_encode($result);
            exit;
        }

        // Update profile: PUT /api/users/{id}
        if (isset($segments[2]) && is_numeric($segments[2])) {
            $requireCsrf();

            $requestedId = intval($segments[2]);
            $currentUser = $auth->getCurrentUser();
            if (!$currentUser) {
                http_response_code(401);
                echo json_encode(['success' => false, 'message' => 'Not authenticated']);
                exit;
            }

            // Only self-update unless staff
            if ($currentUser['role'] !== 'staff' && $currentUser['id'] !== $requestedId) {
                http_response_code(403);
                echo json_encode(['success' => false, 'message' => 'Forbidden']);
                exit;
            }

            $payload = $readJson();
            $data = [];
            foreach (['name', 'phone', 'bio', 'profile_image'] as $field) {
                if (array_key_exists($field, $payload)) {
                    $data[$field] = Security::sanitizeInput($payload[$field]);
                }
            }
            $result = $userModel->updateProfile($requestedId, $data);
            echo json_encode($result);
            exit;
        }

        http_response_code(404);
        echo json_encode(['success' => false, 'message' => 'Endpoint not found']);
        exit;
    }

    // Method not allowed
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed']);
    exit;
} catch (Exception $e) {
    error_log('Users API error: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Server error']);
    exit;
}


