<?php
// api/payments/mpesa/callback.php - Daraja STK callback receiver

require_once APP_PATH . '/config/database.php';
require_once APP_PATH . '/classes/Payment.php';
require_once APP_PATH . '/classes/Artwork.php';

// Daraja will POST JSON to this endpoint; do not enforce CSRF or auth.
try {
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        http_response_code(405);
        echo json_encode(['success' => false, 'message' => 'Method not allowed']);
        exit;
    }

    $raw = file_get_contents('php://input');
    $payload = json_decode($raw, true) ?: [];

    // Expected structure contains Body.stkCallback
    $callback = $payload['Body']['stkCallback'] ?? null;
    if (!$callback) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Invalid callback payload']);
        exit;
    }

    $checkoutId = $callback['CheckoutRequestID'] ?? '';
    $resultCode = (string)($callback['ResultCode'] ?? '');
    $resultDesc = $callback['ResultDesc'] ?? '';

    $database = new Database();
    $db = $database->getConnection();
    $payment = new Payment($db);
    $row = $payment->findByCheckoutRequestId($checkoutId);
    if (!$row) {
        // Unknown checkout ID; ack 200 to stop retries
        echo json_encode(['success' => true]);
        exit;
    }

    if ($resultCode === '0') {
        // Extract receipt from CallbackMetadata
        $receipt = '';
        $meta = $callback['CallbackMetadata']['Item'] ?? [];
        foreach ($meta as $item) {
            if (($item['Name'] ?? '') === 'MpesaReceiptNumber') {
                $receipt = $item['Value'] ?? '';
            }
        }
        $payment->markCompleted((int)$row['id'], $receipt, $resultDesc);
        // Mark the artwork as sold and record purchase history
        try {
            $artwork = new Artwork($db);
            // Only update status to sold to avoid altering other fields
            $artwork->update((int)$row['artwork_id'], ['status' => 'sold']);
            // Insert purchase_history row if table exists
            try {
                $hist = $db->prepare("INSERT INTO purchase_history (payment_id, artwork_id, buyer_id, seller_id, amount) VALUES (?, ?, ?, ?, ?)");
                $sellerId = null;
                // Try to get seller (artist_id) from artworks
                $s = $db->prepare('SELECT artist_id FROM artworks WHERE id = ?');
                $s->execute([(int)$row['artwork_id']]);
                $r = $s->fetch(PDO::FETCH_ASSOC);
                if ($r && isset($r['artist_id'])) { $sellerId = (int)$r['artist_id']; }
                $hist->execute([(int)$row['id'], (int)$row['artwork_id'], (int)$row['buyer_id'], $sellerId, (float)$row['amount']]);
            } catch (Exception $e) {
                // ignore if table missing
            }
        } catch (Exception $e) {
            error_log('Failed to mark artwork sold after payment: ' . $e->getMessage());
        }
    } else {
        $payment->markFailed((int)$row['id'], $resultDesc);
    }

    echo json_encode(['success' => true]);
} catch (Exception $e) {
    error_log('MPESA callback error: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false]);
}
exit;
?>


