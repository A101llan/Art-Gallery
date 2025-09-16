<?php
// database/run_cleanup_and_core.php - Apply cleanup_and_core.sql using PDO

require_once __DIR__ . '/../app/config/database.php';

try {
    $db = (new Database())->getConnection();
    $sql = file_get_contents(__DIR__ . '/cleanup_and_core.sql');
    if ($sql === false) {
        throw new Exception('Failed to read cleanup_and_core.sql');
    }
    $db->exec($sql);
    echo "Database cleanup and core tables applied successfully.\n";
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}




