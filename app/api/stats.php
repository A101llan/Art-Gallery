<?php
// api/stats.php - Gallery Statistics

require_once APP_PATH . '/config/database.php';

try {
    // No need for session_start() or CORS headers here, as they are handled by public/index.php
    $database = new Database();
    $db = $database->getConnection();

    // Get statistics
    $stats = [
        'artists' => getArtistCount($db),
        'artworks' => getArtworkCount($db),
        'exhibitions' => getExhibitionCount($db),
        'visitors' => getVisitorCount($db)
    ];

    echo json_encode([
        'success' => true,
        'data' => $stats
    ]);
} catch(Exception $e) {
    error_log("Stats API error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Internal server error']);
}
exit;

function getArtistCount($db) {
    $query = "SELECT COUNT(*) as count FROM users WHERE role = 'artist' AND status = 'active'";
    $stmt = $db->prepare($query);
    $stmt->execute();
    $result = $stmt->fetch();
    return intval($result['count']);
}

function getArtworkCount($db) {
    $query = "SELECT COUNT(*) as count FROM artworks WHERE status = 'approved'";
    $stmt = $db->prepare($query);
    $stmt->execute();
    $result = $stmt->fetch();
    return intval($result['count']);
}

function getExhibitionCount($db) {
    $query = "SELECT COUNT(*) as count FROM exhibitions WHERE status IN ('active', 'completed')";
    $stmt = $db->prepare($query);
    $stmt->execute();
    $result = $stmt->fetch();
    return intval($result['count']);
}

function getVisitorCount($db) {
    $query = "SELECT COUNT(*) as count FROM users WHERE status = 'active'";
    $stmt = $db->prepare($query);
    $stmt->execute();
    $result = $stmt->fetch();
    return intval($result['count']);
}
