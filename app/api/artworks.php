<?php
// api/artworks.php - Artworks API Endpoint

require_once APP_PATH . '/config/database.php';
require_once APP_PATH . '/classes/Artwork.php';
require_once APP_PATH . '/classes/Auth.php';
require_once APP_PATH . '/utils/Security.php';

try {
    // No need for session_start() or CORS headers here, as they are handled by public/index.php
    $database = new Database();
    $db = $database->getConnection();
    $artwork = new Artwork($db);
    $auth = new Auth($db);

    // Get HTTP method and URI for routing
    $method = $_SERVER['REQUEST_METHOD'];
    $request_uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
    $project_base = '/usanii_mashariki'; // This should match what's in public/index.php
    if (strpos($request_uri, $project_base) === 0) {
        $request_uri = substr($request_uri, strlen($project_base));
    }
    $request_uri = trim($request_uri, '/');

    // Extract ID from URI for specific artwork operations
    $path_parts = explode('/', $request_uri);
    $artwork_id = null;
    if (count($path_parts) >= 3 && $path_parts[1] === 'artworks' && is_numeric($path_parts[2])) {
        $artwork_id = intval($path_parts[2]);
    }

    switch($method) {
        case 'GET':
            if ($artwork_id) {
                handleGetArtworkById($artwork, $artwork_id);
            } else {
                handleGetArtworks($artwork);
            }
            break;
        case 'POST':
            // CSRF protection for POST requests
            if (!isset($_SERVER['HTTP_X_CSRF_TOKEN']) || !Security::verifyCSRFToken($_SERVER['HTTP_X_CSRF_TOKEN'])) {
                http_response_code(403);
                echo json_encode(['success' => false, 'message' => 'CSRF token mismatch.']);
                exit;
            }
            handleCreateArtwork($artwork, $auth);
            break;
        case 'PUT':
            // CSRF protection for PUT requests
            if (!isset($_SERVER['HTTP_X_CSRF_TOKEN']) || !Security::verifyCSRFToken($_SERVER['HTTP_X_CSRF_TOKEN'])) {
                http_response_code(403);
                echo json_encode(['success' => false, 'message' => 'CSRF token mismatch.']);
                exit;
            }
            handleUpdateArtwork($artwork, $auth, $artwork_id);
            break;
        case 'DELETE':
            // CSRF protection for DELETE requests
            if (!isset($_SERVER['HTTP_X_CSRF_TOKEN']) || !Security::verifyCSRFToken($_SERVER['HTTP_X_CSRF_TOKEN'])) {
                http_response_code(403);
                echo json_encode(['success' => false, 'message' => 'CSRF token mismatch.']);
                exit;
            }
            handleDeleteArtwork($artwork, $auth, $artwork_id);
            break;
        default:
            http_response_code(405);
            echo json_encode(['success' => false, 'message' => 'Method not allowed']);
    }
} catch(Exception $e) {
    error_log("Artworks API error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Internal server error']);
}
exit;

// Handles getting a single artwork by ID
function handleGetArtworkById($artwork, $artwork_id) {
    $result = $artwork->getById($artwork_id);
    if ($result['success'] && isset($result['data'])) {
        $result['data'] = normalizeArtworkPaths($result['data']);
    }
    if ($result['success']) {
        $artwork->incrementViews($artwork_id); // Increment views on successful fetch
        echo json_encode($result);
    } else {
        http_response_code(404);
        echo json_encode($result);
    }
}

// Handles getting all artworks with filters
function handleGetArtworks($artwork) {
    $filters = [];
    
    // Parse query parameters
    if (isset($_GET['featured']) && $_GET['featured'] === 'true') {
        $filters['featured'] = true;
    }
    
    if (isset($_GET['status'])) {
        $filters['status'] = Security::sanitizeInput($_GET['status']);
    }
    
    if (isset($_GET['category_id'])) {
        $filters['category_id'] = intval($_GET['category_id']);
    }
    
    if (isset($_GET['artist_id'])) {
        $filters['artist_id'] = intval($_GET['artist_id']);
    }
    
    if (isset($_GET['search'])) {
        $filters['search'] = Security::sanitizeInput($_GET['search']);
    }
    
    if (isset($_GET['limit'])) {
        $filters['limit'] = min(50, intval($_GET['limit'])); // Max 50 items
    }
    
    if (isset($_GET['offset'])) {
        $filters['offset'] = intval($_GET['offset']);
    }

    // Default to approved artworks only for public access
    if (!isset($_SESSION['user_role']) || $_SESSION['user_role'] === 'visitor') {
        $filters['status'] = 'approved';
    }

    $result = $artwork->getAll($filters);
    
    if ($result['success']) {
        // Normalize paths and fallback thumbnail
        if (isset($result['data']) && is_array($result['data'])) {
            $normalized = [];
            foreach ($result['data'] as $row) {
                $normalized[] = normalizeArtworkPaths($row);
            }
            $result['data'] = $normalized;
        }
        echo json_encode($result);
    } else {
        http_response_code(500);
        echo json_encode($result);
    }
}

function handleCreateArtwork($artwork, $auth) {
    if (!$auth->isLoggedIn() || !$auth->hasRole('artist')) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'Access denied']);
        return;
    }

    $input = json_decode(file_get_contents('php://input'), true);
    
    if (!$input) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Invalid input data']);
        return;
    }

    // Sanitize input
    $data = [
        'title' => Security::sanitizeInput($input['title'] ?? ''),
        'description' => Security::sanitizeInput($input['description'] ?? ''),
        'category_id' => intval($input['category_id'] ?? 0),
        'artist_id' => $_SESSION['user_id'],
        'image_url' => Security::sanitizeInput($input['image_url'] ?? ''),
        'thumbnail_url' => Security::sanitizeInput($input['thumbnail_url'] ?? ''),
        'dimensions' => Security::sanitizeInput($input['dimensions'] ?? ''),
        'medium' => Security::sanitizeInput($input['medium'] ?? ''),
        'year_created' => intval($input['year_created'] ?? date('Y')),
        'price' => floatval($input['price'] ?? 0),
        'status' => 'draft'
    ];

    // Validate required fields
    if (empty($data['title']) || empty($data['image_url']) || $data['category_id'] <= 0) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Title, image, and category are required']);
        return;
    }

    $result = $artwork->create($data);
    
    if ($result['success']) {
        http_response_code(201);
        echo json_encode($result);
    } else {
        http_response_code(400);
        echo json_encode($result);
    }
}

function handleUpdateArtwork($artwork, $auth, $artwork_id) {
    if (!$auth->isLoggedIn()) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'Access denied']);
        return;
    }

    $input = json_decode(file_get_contents('php://input'), true);

    if (!$artwork_id) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Artwork ID required']);
        return;
    }

    // Check ownership or staff permission
    $current_artwork = $artwork->getById($artwork_id);
    if (!$current_artwork['success']) {
        http_response_code(404);
        echo json_encode(['success' => false, 'message' => 'Artwork not found']);
        return;
    }

    $can_edit = $_SESSION['user_role'] === 'staff' || 
                ($current_artwork['data']['artist_id'] == $_SESSION['user_id']);

    // Allow visitors to mark artwork as sold (for purchase completion)
    $is_purchase_update = isset($input['status']) && $input['status'] === 'sold' && 
                         $_SESSION['user_role'] === 'visitor';

    if (!$can_edit && !$is_purchase_update) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'Permission denied']);
        return;
    }

    // Sanitize update data
    $data = array_filter([
        'title' => Security::sanitizeInput($input['title'] ?? ''),
        'description' => Security::sanitizeInput($input['description'] ?? ''),
        'category_id' => intval($input['category_id'] ?? 0) ?: null,
        'dimensions' => Security::sanitizeInput($input['dimensions'] ?? ''),
        'medium' => Security::sanitizeInput($input['medium'] ?? ''),
        'year_created' => intval($input['year_created'] ?? 0) ?: null,
        'price' => floatval($input['price'] ?? 0) ?: null,
    ], function($value) { return $value !== '' && $value !== null; });

    // Handle status updates
    if (isset($input['status'])) {
        $new_status = Security::sanitizeInput($input['status']);
        
        // Staff can update any status
        if ($_SESSION['user_role'] === 'staff') {
            $data['status'] = $new_status;
        }
        // Artists can update their own artwork status (except to sold)
        elseif ($_SESSION['user_role'] === 'artist' && $can_edit && $new_status !== 'sold') {
            $data['status'] = $new_status;
        }
        // Visitors can only mark as sold (purchase completion)
        elseif ($_SESSION['user_role'] === 'visitor' && $new_status === 'sold') {
            $data['status'] = $new_status;
        }
    }

    // Only staff can update featured
    if ($_SESSION['user_role'] === 'staff' && isset($input['featured'])) {
        $data['featured'] = (bool)$input['featured'];
    }

    $result = $artwork->update($artwork_id, $data);
    echo json_encode($result);
}

// Utilities
function normalizeArtworkPaths($row) {
    // Ensure thumbnail falls back to image when file missing
    $thumb = isset($row['thumbnail_url']) ? $row['thumbnail_url'] : '';
    $image = isset($row['image_url']) ? $row['image_url'] : '';
    if ($thumb) {
        if (!fileExistsForWebPath($thumb)) {
            // Try alternate mapping
            $alt = str_replace('/public/uploads/', '/uploads/', $thumb);
            if (!fileExistsForWebPath($alt)) {
                $alt2 = str_replace('/uploads/', '/public/uploads/', $thumb);
                if (!fileExistsForWebPath($alt2)) {
                    // last resort: use image_url
                    $row['thumbnail_url'] = $image;
                } else {
                    $row['thumbnail_url'] = $alt2;
                }
            } else {
                $row['thumbnail_url'] = $alt;
            }
        }
    }
    return $row;
}

function fileExistsForWebPath($webPath) {
    if (!$webPath) return false;
    // Strip project base if present
    $path = $webPath;
    $path = preg_replace('#^/usanii_mashariki/#', '', $path);
    // If already starts with public/, keep; else try to prepend public/
    $projectRoot = dirname(APP_PATH);
    $full = $projectRoot . DIRECTORY_SEPARATOR . $path;
    if (file_exists($full)) return true;
    if (strpos($path, 'public/') !== 0) {
        $fullAlt = $projectRoot . DIRECTORY_SEPARATOR . 'public' . DIRECTORY_SEPARATOR . $path;
        if (file_exists($fullAlt)) return true;
    }
    return false;
}

function handleDeleteArtwork($artwork, $auth, $artwork_id) {
    if (!$auth->isLoggedIn()) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'Access denied']);
        return;
    }

    if (!$artwork_id) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Artwork ID required']);
        return;
    }

    // Check ownership or staff permission
    $current_artwork = $artwork->getById($artwork_id);
    if (!$current_artwork['success']) {
        http_response_code(404);
        echo json_encode(['success' => false, 'message' => 'Artwork not found']);
        return;
    }

    $can_delete = $_SESSION['user_role'] === 'staff' || 
                  ($current_artwork['data']['artist_id'] == $_SESSION['user_id']);

    if (!$can_delete) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'Permission denied']);
        return;
    }

    $result = $artwork->delete($artwork_id);
    echo json_encode($result);
}
