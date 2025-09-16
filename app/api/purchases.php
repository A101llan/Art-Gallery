<?php
// api/purchases.php - List purchases for the logged-in user

require_once APP_PATH . '/config/database.php';
require_once APP_PATH . '/classes/Auth.php';

try {
    if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
        http_response_code(405);
        echo json_encode(['success' => false, 'message' => 'Method not allowed']);
        exit;
    }

    $db = (new Database())->getConnection();
    $auth = new Auth($db);
    if (!$auth->isLoggedIn()) {
        http_response_code(401);
        echo json_encode(['success' => false, 'message' => 'Login required']);
        exit;
    }

    $user = $auth->getCurrentUser();
    $stmt = $db->prepare(
        "SELECT p.id AS payment_id, p.amount, p.status, p.mpesa_receipt_number, p.created_at,
                a.id AS artwork_id, a.title, COALESCE(a.thumbnail_url, a.image_url) AS image_url, a.price
         FROM payments p
         JOIN artworks a ON a.id = p.artwork_id
         WHERE p.buyer_id = ?
         ORDER BY p.created_at DESC"
    );
    $stmt->execute([$user['id']]);
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode(['success' => true, 'data' => $rows]);
} catch (Exception $e) {
    error_log('Purchases API error: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Failed to load purchases']);
}
exit;
?>


