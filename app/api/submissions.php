<?php
// api/submissions.php - Artwork Submissions API

require_once APP_PATH . '/config/database.php';
require_once APP_PATH . '/classes/Submission.php';
require_once APP_PATH . '/classes/Auth.php';
require_once APP_PATH . '/utils/Security.php';

try {
    // No need for session_start() or CORS headers here, as they are handled by public/index.php
    $database = new Database();
    $db = $database->getConnection();
    $submission = new Submission($db);
    $auth = new Auth($db);

    if (!$auth->isLoggedIn()) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'Authentication required']);
        exit;
    }

    // Get HTTP method and URI for routing
    $method = $_SERVER['REQUEST_METHOD'];
    $request_uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
    $project_base = '/usanii_mashariki'; // This should match what's in public/index.php
    if (strpos($request_uri, $project_base) === 0) {
        $request_uri = substr($request_uri, strlen($project_base));
    }
    $request_uri = trim($request_uri, '/');

    // Extract ID from URI for specific submission operations (e.g., /api/submissions/45 or /api/submissions/artwork/123)
    $path_parts = explode('/', $request_uri);
    $artwork_id_from_uri = null;
    $submission_id_from_uri = null;
    if (count($path_parts) >= 4 && $path_parts[1] === 'submissions' && $path_parts[2] === 'artwork' && is_numeric($path_parts[3])) {
        $artwork_id_from_uri = intval($path_parts[3]);
    }
    if (count($path_parts) >= 3 && $path_parts[1] === 'submissions' && is_numeric($path_parts[2])) {
        $submission_id_from_uri = intval($path_parts[2]);
    }

    switch($method) {
        case 'GET':
            if ($submission_id_from_uri) {
                handleGetSubmissionById($submission, $auth, $submission_id_from_uri);
            } else if ($artwork_id_from_uri) {
                handleGetSubmissionByArtworkId($submission, $artwork_id_from_uri);
            } else {
                handleGetSubmissions($submission, $auth);
            }
            break;
        case 'POST':
            // Create/Submit a submission (artist only)
            if (!isset($_SERVER['HTTP_X_CSRF_TOKEN']) || !Security::verifyCSRFToken($_SERVER['HTTP_X_CSRF_TOKEN'])) {
                http_response_code(403);
                echo json_encode(['success' => false, 'message' => 'CSRF token mismatch.']);
                exit;
            }
            handleCreateSubmission($submission, $auth);
            break;
        case 'PUT':
            // CSRF Token verification for PUT requests
            if (!isset($_SERVER['HTTP_X_CSRF_TOKEN']) || !Security::verifyCSRFToken($_SERVER['HTTP_X_CSRF_TOKEN'])) {
                http_response_code(403);
                echo json_encode(['success' => false, 'message' => 'CSRF token mismatch.']);
                exit;
            }
            handleReviewSubmission($submission, $auth);
            break;
        default:
            http_response_code(405);
            echo json_encode(['success' => false, 'message' => 'Method not allowed']);
    }
} catch(Exception $e) {
    error_log("Submissions API error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Internal server error']);
}
exit;

function handleGetSubmissionByArtworkId($submission, $artwork_id) {
    $result = $submission->getByArtworkId($artwork_id);
    if ($result['success']) {
        echo json_encode($result);
    } else {
        http_response_code(404);
        echo json_encode($result);
    }
}

function handleGetSubmissionById($submission, $auth, $submission_id) {
    // Artists can view only their own; staff can view any
    $result = $submission->getById($submission_id);
    if ($result['success']) {
        if ($_SESSION['user_role'] !== 'staff' && $result['data']['artist_id'] != $_SESSION['user_id']) {
            http_response_code(403);
            echo json_encode(['success' => false, 'message' => 'Access denied']);
            return;
        }
        echo json_encode($result);
    } else {
        http_response_code(404);
        echo json_encode($result);
    }
}

function handleGetSubmissions($submission, $auth) {
    $filters = [];
    
    if ($_SESSION['user_role'] === 'artist') {
        $filters['artist_id'] = $_SESSION['user_id'];
    } elseif ($_SESSION['user_role'] === 'staff') {
        if (isset($_GET['pending']) && $_GET['pending'] === 'true') {
            $filters['pending'] = true;
        }
        if (isset($_GET['status'])) {
            $filters['status'] = Security::sanitizeInput($_GET['status']);
        }
    } else {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'Access denied']);
        return;
    }

    $result = $submission->getAll($filters);
    echo json_encode($result);
}

function handleReviewSubmission($submission, $auth) {
    if (!$auth->hasRole('staff')) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'Staff access required']);
        return;
    }

    $input = json_decode(file_get_contents('php://input'), true);
    
    // CSRF Token verification for PUT requests
    if (!isset($_SERVER['HTTP_X_CSRF_TOKEN']) || !Security::verifyCSRFToken($_SERVER['HTTP_X_CSRF_TOKEN'])) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'CSRF token mismatch.']);
        exit;
    }

    $submission_id = intval($input['submission_id'] ?? 0);
    $action = Security::sanitizeInput($input['action'] ?? '');
    $review_notes = Security::sanitizeInput($input['review_notes'] ?? '');

    if (!$submission_id || !in_array($action, ['approve', 'reject'])) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Invalid input data']);
        return;
    }

    $result = $submission->review($submission_id, $action, $review_notes);
    echo json_encode($result);
}

function handleCreateSubmission($submission, $auth) {
    if (!$auth->hasRole('artist')) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'Artist access required']);
        return;
    }

    $input = json_decode(file_get_contents('php://input'), true);
    $artwork_id = intval($input['artwork_id'] ?? 0);
    $notes = Security::sanitizeInput($input['submission_notes'] ?? '');

    if (!$artwork_id) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'artwork_id is required']);
        return;
    }

    // Reuse Artwork::submit if desired, but here we call Submission::review path for creation
    // Implement creation upsert: pending status for the artwork
    try {
        // Upsert into submissions
        $stmt = $submissionDb = null;
        $submissionDb = (new Database())->getConnection();
        $query = "INSERT INTO submissions (artwork_id, artist_id, status, submission_notes) VALUES (?, ?, 'pending', ?)
                  ON DUPLICATE KEY UPDATE status = 'pending', submission_notes = VALUES(submission_notes), submitted_at = CURRENT_TIMESTAMP";
        $stmt = $submissionDb->prepare($query);
        $ok = $stmt->execute([$artwork_id, $_SESSION['user_id'], $notes]);
        if ($ok) {
            // Update artwork status to submitted
            $up = $submissionDb->prepare("UPDATE artworks SET status = 'submitted' WHERE id = ?");
            $up->execute([$artwork_id]);
            echo json_encode(['success' => true, 'message' => 'Artwork submitted for review']);
            return;
        }
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Failed to create submission']);
    } catch (Exception $e) {
        error_log('Create submission error: ' . $e->getMessage());
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'Failed to create submission']);
    }
}
