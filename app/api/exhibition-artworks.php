<?php
// api/exhibition-artworks.php - Manage exhibition artworks

require_once APP_PATH . '/config/database.php';
require_once APP_PATH . '/classes/ExhibitionArtwork.php';
require_once APP_PATH . '/utils/Security.php';

// Check authentication and staff role (session-based)
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Check CSRF token for POST/PUT/DELETE requests
if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    $token = $_SERVER['HTTP_X_CSRF_TOKEN'] ?? '';
    if (!$token || !Security::verifyCSRFToken($token)) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'Invalid CSRF token.']);
        exit;
    }
}

$database = new Database();
$db = $database->getConnection();
$exhibitionArtwork = new ExhibitionArtwork($db);

$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
// Normalize path to remove project base and leading slash
$project_base = '/usanii_mashariki';
if (strpos($path, $project_base) === 0) {
    $path = substr($path, strlen($project_base));
}
$path = ltrim($path, '/');

// Route: /api/exhibition-artworks/{exhibition_id}/artworks
if (preg_match('/^api\/exhibition-artworks\/(\d+)\/artworks$/', $path, $matches)) {
    $exhibition_id = intval($matches[1]);
    
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'GET':
            // Get artworks in exhibition
            try {
                $artworks = $exhibitionArtwork->getExhibitionArtworks($exhibition_id);
                echo json_encode(['success' => true, 'data' => $artworks]);
            } catch (Exception $e) {
                http_response_code(500);
                echo json_encode(['success' => false, 'message' => 'Failed to load exhibition artworks']);
            }
            break;
            
        case 'POST':
            // Add artwork to exhibition
            if (!isset($_SESSION['user_id']) || (($_SESSION['user_role'] ?? '') !== 'staff')) {
                http_response_code(403);
                echo json_encode(['success' => false, 'message' => 'Access denied. Staff only.']);
                exit;
            }
            try {
                $input = json_decode(file_get_contents('php://input'), true);
                $artwork_id = intval($input['artwork_id'] ?? 0);
                $display_order = intval($input['display_order'] ?? 0);
                
                if (!$artwork_id) {
                    http_response_code(400);
                    echo json_encode(['success' => false, 'message' => 'Artwork ID is required']);
                    exit;
                }
                
                if ($exhibitionArtwork->addArtwork($exhibition_id, $artwork_id, $display_order)) {
                    echo json_encode(['success' => true, 'message' => 'Artwork added to exhibition']);
                } else {
                    http_response_code(500);
                    echo json_encode(['success' => false, 'message' => 'Failed to add artwork to exhibition']);
                }
            } catch (Exception $e) {
                http_response_code(500);
                echo json_encode(['success' => false, 'message' => 'Failed to add artwork to exhibition']);
            }
            break;
    }
}

// Route: /api/exhibition-artworks/{exhibition_id}/artworks/{artwork_id}
elseif (preg_match('/^api\/exhibition-artworks\/(\d+)\/artworks\/(\d+)$/', $path, $matches)) {
    $exhibition_id = intval($matches[1]);
    $artwork_id = intval($matches[2]);
    
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'DELETE':
            // Remove artwork from exhibition
            if (!isset($_SESSION['user_id']) || (($_SESSION['user_role'] ?? '') !== 'staff')) {
                http_response_code(403);
                echo json_encode(['success' => false, 'message' => 'Access denied. Staff only.']);
                exit;
            }
            try {
                if ($exhibitionArtwork->removeArtwork($exhibition_id, $artwork_id)) {
                    echo json_encode(['success' => true, 'message' => 'Artwork removed from exhibition']);
                } else {
                    http_response_code(500);
                    echo json_encode(['success' => false, 'message' => 'Failed to remove artwork from exhibition']);
                }
            } catch (Exception $e) {
                http_response_code(500);
                echo json_encode(['success' => false, 'message' => 'Failed to remove artwork from exhibition']);
            }
            break;
            
        case 'PUT':
            // Update display order
            if (!isset($_SESSION['user_id']) || (($_SESSION['user_role'] ?? '') !== 'staff')) {
                http_response_code(403);
                echo json_encode(['success' => false, 'message' => 'Access denied. Staff only.']);
                exit;
            }
            try {
                $input = json_decode(file_get_contents('php://input'), true);
                $display_order = intval($input['display_order'] ?? 0);
                
                if ($exhibitionArtwork->updateDisplayOrder($exhibition_id, $artwork_id, $display_order)) {
                    echo json_encode(['success' => true, 'message' => 'Display order updated']);
                } else {
                    http_response_code(500);
                    echo json_encode(['success' => false, 'message' => 'Failed to update display order']);
                }
            } catch (Exception $e) {
                http_response_code(500);
                echo json_encode(['success' => false, 'message' => 'Failed to update display order']);
            }
            break;
    }
}

// Route: /api/exhibition-artworks/{exhibition_id}/available
elseif (preg_match('/^api\/exhibition-artworks\/(\d+)\/available$/', $path, $matches)) {
    $exhibition_id = intval($matches[1]);
    
    if ($_SERVER['REQUEST_METHOD'] === 'GET') {
        // Staff only for available list used in dashboard
        if (!isset($_SESSION['user_id']) || (($_SESSION['user_role'] ?? '') !== 'staff')) {
            http_response_code(403);
            echo json_encode(['success' => false, 'message' => 'Access denied. Staff only.']);
            exit;
        }
        // Get available artworks (not in this exhibition)
        try {
            $artworks = $exhibitionArtwork->getAvailableArtworks($exhibition_id);
            echo json_encode(['success' => true, 'data' => $artworks]);
        } catch (Throwable $e) {
            error_log('Available artworks error: ' . $e->getMessage());
            http_response_code(500);
            echo json_encode(['success' => false, 'message' => 'Failed to load available artworks']);
        }
    }
}

// Route: /api/exhibition-artworks/{exhibition_id}/count
elseif (preg_match('/^api\/exhibition-artworks\/(\d+)\/count$/', $path, $matches)) {
    $exhibition_id = intval($matches[1]);
    
    if ($_SERVER['REQUEST_METHOD'] === 'GET') {
        // Get artwork count for exhibition
        try {
            $count = $exhibitionArtwork->getExhibitionArtworkCount($exhibition_id);
            echo json_encode(['success' => true, 'data' => ['count' => $count]]);
        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode(['success' => false, 'message' => 'Failed to get artwork count']);
        }
    }
}

// Route: /api/exhibition-artworks/artwork/{artwork_id}/exhibitions
elseif (preg_match('/^api\/exhibition-artworks\/artwork\/(\d+)\/exhibitions$/', $path, $matches)) {
    $artwork_id = intval($matches[1]);
    
    if ($_SERVER['REQUEST_METHOD'] === 'GET') {
        // Get exhibitions for an artwork
        try {
            $exhibitions = $exhibitionArtwork->getArtworkExhibitions($artwork_id);
            echo json_encode(['success' => true, 'data' => $exhibitions]);
        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode(['success' => false, 'message' => 'Failed to load artwork exhibitions']);
        }
    }
}

else {
    http_response_code(404);
    echo json_encode(['success' => false, 'message' => 'API endpoint not found.']);
}





