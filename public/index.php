<?php
// public/index.php - Central API Router

// Define the base path to your 'app' directory
define('APP_PATH', __DIR__ . '/../app');

// Configure and start session (important for Auth and Security classes)
if (session_status() == PHP_SESSION_NONE) {
    // Ensure the session cookie is valid for the whole app under the subdirectory
    $cookieParams = [
        'lifetime' => 0,
        'path' => '/usanii_mashariki',
        'domain' => '',
        'secure' => false,
        'httponly' => true,
        'samesite' => 'Lax'
    ];
    // Use new signature if available (PHP >= 7.3)
    if (function_exists('session_set_cookie_params')) {
        session_set_cookie_params($cookieParams);
    }
    session_start();
}

// Ensure PHP errors are not sent in responses (keeps JSON clean)
error_reporting(E_ALL);
ini_set('display_errors', '0');
ini_set('display_startup_errors', '0');

// Set headers for JSON response and CORS
header('Content-Type: application/json');
// Allow requests from the current origin (or localhost if missing)
$requestOrigin = isset($_SERVER['HTTP_ORIGIN']) ? $_SERVER['HTTP_ORIGIN'] : (isset($_SERVER['HTTP_HOST']) ? ('http://' . $_SERVER['HTTP_HOST']) : '*');
header('Access-Control-Allow-Origin: ' . $requestOrigin);
header('Access-Control-Allow-Credentials: true');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, X-CSRF-TOKEN, Authorization');

// Handle preflight OPTIONS request (important for complex CORS requests)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// Get the requested URI and clean it up
$request_uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

// Remove the project subdirectory from the URI if it exists
$project_base = '/usanii_mashariki'; // Adjust this if your project is in a different subdirectory
if (strpos($request_uri, $project_base) === 0) {
    $request_uri = substr($request_uri, strlen($project_base));
}

// Remove leading/trailing slashes for easier matching
$request_uri = trim($request_uri, '/');

// Define API routes and their corresponding handler files
$routes = [
    // Auth routes
    'api/auth/login' => APP_PATH . '/api/auth/login.php',
    'api/auth/register' => APP_PATH . '/api/auth/register.php',
    'api/auth/logout' => APP_PATH . '/api/auth/logout.php',
    'api/auth/csrf-token' => APP_PATH . '/api/auth/csrf-token.php',
    'api/auth/status' => APP_PATH . '/api/auth/status.php',

    // Artworks routes
    'api/artworks' => APP_PATH . '/api/artworks.php',

    // Exhibitions routes
    'api/exhibitions' => APP_PATH . '/api/exhibitions.php',

    // Stats routes
    'api/stats' => APP_PATH . '/api/stats.php',

    // Categories routes
    'api/categories' => APP_PATH . '/api/categories.php',

    // Artists routes (public listing)
    'api/artists' => APP_PATH . '/api/artists.php',
    'api/artist-profiles' => APP_PATH . '/api/artist-profiles.php',

    // Upload route
    'api/upload' => APP_PATH . '/api/upload.php',

    // Submissions route
    'api/submissions' => APP_PATH . '/api/submissions.php',

    // Users route
    'api/users' => APP_PATH . '/api/users.php',

    // Purchases route
    'api/purchases' => APP_PATH . '/api/purchases.php',

    // Exhibition artworks routes
    'api/exhibition-artworks' => APP_PATH . '/api/exhibition-artworks.php',

    // Reports routes
    'api/reports' => APP_PATH . '/api/reports.php',

    // Payments - M-Pesa
    'api/payments/mpesa/stk-push' => APP_PATH . '/api/payments/mpesa/stk-push.php',
    'api/payments/mpesa/callback' => APP_PATH . '/api/payments/mpesa/callback.php',
];

// Find the matching route and include the handler file
$matched = false;
foreach ($routes as $route_pattern => $handler_file) {
    // Use a simple starts-with match for API prefixes
    if (strpos($request_uri, $route_pattern) === 0) {
        if (file_exists($handler_file)) {
            require_once $handler_file;
            $matched = true;
            break; // Stop after the first match
        } else {
            error_log("API handler file not found: " . $handler_file);
            http_response_code(500);
            echo json_encode(['success' => false, 'message' => 'Server configuration error: Handler not found.']);
            $matched = true; // Mark as matched to avoid 404
            break;
        }
    }
}

// If no route matched, return 404
if (!$matched) {
    http_response_code(404);
    echo json_encode(['success' => false, 'message' => 'API endpoint not found.']);
}
