<?php
// api/payments/mpesa/stk-push.php - Initiate M-Pesa STK Push

require_once APP_PATH . '/config/database.php';
require_once APP_PATH . '/classes/Auth.php';
require_once APP_PATH . '/classes/Payment.php';
require_once APP_PATH . '/utils/Security.php';
require_once APP_PATH . '/utils/MpesaDaraja.php';

try {
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        http_response_code(405);
        echo json_encode(['success' => false, 'message' => 'Method not allowed']);
        exit;
    }

    // CSRF Token verification
    if (!isset($_SERVER['HTTP_X_CSRF_TOKEN']) || !Security::verifyCSRFToken($_SERVER['HTTP_X_CSRF_TOKEN'])) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'CSRF token mismatch.']);
        exit;
    }

    $database = new Database();
    $db = $database->getConnection();
    $auth = new Auth($db);
    if (!$auth->isLoggedIn()) {
        http_response_code(401);
        echo json_encode(['success' => false, 'message' => 'Login required']);
        exit;
    }

    $input = json_decode(file_get_contents('php://input'), true) ?: [];
    $artworkId = isset($input['artwork_id']) ? (int)$input['artwork_id'] : 0;
    $amount = isset($input['amount']) ? (float)$input['amount'] : 0.0;
    $phone = isset($input['phone']) ? Security::sanitizeInput($input['phone']) : '';

    if ($artworkId <= 0 || $amount <= 0 || !$phone) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'artwork_id, amount and phone are required']);
        exit;
    }

    $payment = new Payment($db);
    $create = $payment->create($artworkId, $_SESSION['user_id'], $amount, $phone);
    if (!$create['success']) {
        http_response_code(500);
        echo json_encode($create);
        exit;
    }
    $paymentId = (int)$create['payment_id'];

    $daraja = new MpesaDaraja();
    $accountRef = 'ART' . $artworkId;
    $desc = 'Purchase Artwork #' . $artworkId;
    $stk = $daraja->stkPush((int)round($amount), $phone, $accountRef, $desc);

    if (!$stk['success']) {
        $payment->markFailed($paymentId, 'STK push failed');
        http_response_code(502);
        echo json_encode(['success' => false, 'message' => 'STK push failed', 'details' => $stk]);
        exit;
    }

    $data = $stk['data'];
    $payment->updateStkRefs($paymentId, $data['MerchantRequestID'] ?? null, $data['CheckoutRequestID'] ?? null);

    echo json_encode([
        'success' => true,
        'message' => 'STK push initiated',
        'payment_id' => $paymentId,
        'stk' => $data
    ]);
} catch (Exception $e) {
    error_log('MPESA STK Push API error: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Internal server error']);
}
exit;
?>


