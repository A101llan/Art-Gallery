<?php
// classes/ArtistProfile.php - Manage artist profiles

class ArtistProfile {
	private $conn;
	private $table_name = "artist_profiles";

	public function __construct($db) {
		$this->conn = $db;
	}

	public function getByUserId($user_id) {
		$query = "SELECT * FROM " . $this->table_name . " WHERE user_id = ?";
		$stmt = $this->conn->prepare($query);
		$stmt->execute([$user_id]);
		return $stmt->fetch();
	}

	public function upsert($data) {
		$existing = $this->getByUserId($data['user_id']);
		if ($existing) {
			$query = "UPDATE " . $this->table_name . " SET bio = ?, portfolio_url = ?, socials_json = ?, location = ?, updated_at = CURRENT_TIMESTAMP WHERE user_id = ?";
			$stmt = $this->conn->prepare($query);
			return $stmt->execute([
				$data['bio'] ?? null,
				$data['portfolio_url'] ?? null,
				isset($data['socials_json']) ? $data['socials_json'] : null,
				$data['location'] ?? null,
				$data['user_id']
			]);
		} else {
			$query = "INSERT INTO " . $this->table_name . " (user_id, bio, portfolio_url, socials_json, location) VALUES (?,?,?,?,?)";
			$stmt = $this->conn->prepare($query);
			return $stmt->execute([
				$data['user_id'],
				$data['bio'] ?? null,
				$data['portfolio_url'] ?? null,
				isset($data['socials_json']) ? $data['socials_json'] : null,
				$data['location'] ?? null
			]);
		}
	}
}





