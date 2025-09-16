<?php
// database/run_migrate_artist_profiles.php - Run artist_profiles migration

require_once __DIR__ . '/../app/config/database.php';

try {
	$database = new Database();
	$db = $database->getConnection();
	$sql = file_get_contents(__DIR__ . '/migrate_artist_profiles.sql');
	if ($sql === false) {
		throw new Exception('Failed to read migrate_artist_profiles.sql');
	}
	$db->exec($sql);
	echo "Artist profiles migration executed successfully.\n";
} catch (Exception $e) {
	echo "Migration failed: " . $e->getMessage() . "\n";
}



