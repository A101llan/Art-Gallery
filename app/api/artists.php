<?php
// api/artists.php - Public artists listing

require_once APP_PATH . '/config/database.php';
require_once APP_PATH . '/classes/Auth.php';

try {
    $db = (new Database())->getConnection();
    $auth = new Auth($db);

    // Simple listing of active artists with artwork counts (approved only)
    $query = "SELECT u.id, u.name, u.email, u.profile_image, u.bio,
                     COUNT(a.id) AS artwork_count
              FROM users u
              LEFT JOIN artworks a ON a.artist_id = u.id AND a.status = 'approved'
              WHERE u.role = 'artist' AND u.status = 'active'
              GROUP BY u.id
              ORDER BY u.name";
    $stmt = $db->prepare($query);
    $stmt->execute();
    $rows = $stmt->fetchAll();

    echo json_encode(['success' => true, 'data' => $rows]);
} catch (Exception $e) {
    error_log('Artists API error: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Server error']);
}
exit;


