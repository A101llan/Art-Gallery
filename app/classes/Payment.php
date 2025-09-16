<?php
// classes/Payment.php - Payment persistence and helpers

require_once APP_PATH . '/config/database.php';

class Payment {
    private $conn;
    private $table = 'payments';

    public function __construct($db) {
        $this->conn = $db;
    }

    public function create(int $artworkId, int $buyerId, float $amount, string $phoneNumber): array {
        $sql = "INSERT INTO {$this->table} (artwork_id, buyer_id, amount, phone_number, status, payment_method) VALUES (?, ?, ?, ?, 'pending', 'mpesa')";
        $stmt = $this->conn->prepare($sql);
        $ok = $stmt->execute([$artworkId, $buyerId, $amount, $phoneNumber]);
        if (!$ok) return ['success' => false, 'message' => 'Failed to create payment'];
        return ['success' => true, 'payment_id' => (int)$this->conn->lastInsertId()];
    }

    public function updateStkRefs(int $paymentId, ?string $merchantRequestId, ?string $checkoutRequestId): void {
        $sql = "UPDATE {$this->table} SET merchant_request_id = ?, checkout_request_id = ?, status = 'processing' WHERE id = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$merchantRequestId, $checkoutRequestId, $paymentId]);
    }

    public function markCompleted(int $paymentId, string $receiptNumber, ?string $description = null): void {
        $sql = "UPDATE {$this->table} SET status = 'completed', mpesa_receipt_number = ?, transaction_description = ?, completed_at = CURRENT_TIMESTAMP WHERE id = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$receiptNumber, $description, $paymentId]);
    }

    public function markFailed(int $paymentId, ?string $description = null): void {
        $sql = "UPDATE {$this->table} SET status = 'failed', transaction_description = ? WHERE id = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$description, $paymentId]);
    }

    public function findByCheckoutRequestId(string $checkoutRequestId): ?array {
        $stmt = $this->conn->prepare("SELECT * FROM {$this->table} WHERE checkout_request_id = ? LIMIT 1");
        $stmt->execute([$checkoutRequestId]);
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        return $row ?: null;
    }
}
?>


