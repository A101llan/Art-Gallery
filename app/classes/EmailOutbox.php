<?php
// classes/EmailOutbox.php - Queue emails for sending

class EmailOutbox {
	private $conn;
	private $table_name = "email_outbox";

	public function __construct($db) {
		$this->conn = $db;
	}

	public function queue(string $to, string $subject, string $body): bool {
		try {
			$query = "INSERT INTO " . $this->table_name . " (to_email, subject, body) VALUES (?,?,?)";
			$stmt = $this->conn->prepare($query);
			return $stmt->execute([$to, $subject, $body]);
		} catch (Exception $e) {
			error_log('EmailOutbox queue error: ' . $e->getMessage());
			return false;
		}
	}
}



