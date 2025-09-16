<?php
// database/run_migrate_email_outbox.php - Run email_outbox migration

require_once __DIR__ . '/../app/config/database.php';

try {
	$database = new Database();
	$db = $database->getConnection();
	$sql = file_get_contents(__DIR__ . '/migrate_email_outbox.sql');
	if ($sql === false) {
		throw new Exception('Failed to read migrate_email_outbox.sql');
	}
	$db->exec($sql);
	echo "Email outbox migration executed successfully.\n";
} catch (Exception $e) {
	echo "Migration failed: " . $e->getMessage() . "\n";
}





