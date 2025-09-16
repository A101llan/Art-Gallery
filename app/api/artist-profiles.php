<?php
// api/artist-profiles.php - Get and update artist profiles

require_once APP_PATH . '/config/database.php';
require_once APP_PATH . '/classes/ArtistProfile.php';
require_once APP_PATH . '/classes/Auth.php';
require_once APP_PATH . '/utils/Security.php';

try {
	$database = new Database();
	$db = $database->getConnection();
	$profiles = new ArtistProfile($db);

	session_start();

	if ($_SERVER['REQUEST_METHOD'] === 'GET') {
		$user_id = isset($_GET['user_id']) ? (int)$_GET['user_id'] : 0;
		if (!$user_id && isset($_SESSION['user_id'])) {
			$user_id = (int)$_SESSION['user_id'];
		}
		if (!$user_id) {
			http_response_code(400);
			echo json_encode(['success' => false, 'message' => 'user_id required']);
			exit;
		}
		$data = $profiles->getByUserId($user_id);
		echo json_encode(['success' => true, 'data' => $data]);
		exit;
	}

	if ($_SERVER['REQUEST_METHOD'] === 'POST') {
		if (!isset($_SERVER['HTTP_X_CSRF_TOKEN']) || !Security::verifyCSRFToken($_SERVER['HTTP_X_CSRF_TOKEN'])) {
			http_response_code(403);
			echo json_encode(['success' => false, 'message' => 'CSRF token mismatch.']);
			exit;
		}
		if (!isset($_SESSION['user_id'])) {
			http_response_code(403);
			echo json_encode(['success' => false, 'message' => 'Authentication required']);
			exit;
		}
		$input = json_decode(file_get_contents('php://input'), true);
		$data = [
			'user_id' => (int)$_SESSION['user_id'],
			'bio' => $input['bio'] ?? null,
			'portfolio_url' => $input['portfolio_url'] ?? null,
			'socials_json' => isset($input['socials']) ? json_encode($input['socials']) : null,
			'location' => $input['location'] ?? null,
		];
		$ok = $profiles->upsert($data);
		echo json_encode(['success' => (bool)$ok]);
		exit;
	}

	http_response_code(405);
	echo json_encode(['success' => false, 'message' => 'Method not allowed']);

} catch (Exception $e) {
	error_log('Artist profiles error: ' . $e->getMessage());
	http_response_code(500);
	echo json_encode(['success' => false, 'message' => 'Server error']);
}





