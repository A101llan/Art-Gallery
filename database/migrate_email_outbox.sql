-- Create email_outbox table for queued emails
CREATE TABLE IF NOT EXISTS email_outbox (
	id INT AUTO_INCREMENT PRIMARY KEY,
	to_email VARCHAR(255) NOT NULL,
	subject VARCHAR(255) NOT NULL,
	body TEXT NOT NULL,
	status ENUM('queued','sent','failed') DEFAULT 'queued',
	error_message TEXT NULL,
	retry_count INT DEFAULT 0,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	sent_at TIMESTAMP NULL
);





