<?php
// check_exhibition_artworks.php - Check exhibition_artworks table

require_once 'app/config/database.php';

try {
    $database = new Database();
    $db = $database->getConnection();
    
    echo "Checking exhibition_artworks table...\n";
    
    // Check if table exists
    $stmt = $db->prepare("SHOW TABLES LIKE 'exhibition_artworks'");
    $stmt->execute();
    if ($stmt->rowCount() == 0) {
        echo "❌ exhibition_artworks table does not exist!\n";
        exit;
    }
    echo "✅ exhibition_artworks table exists\n";
    
    // Check all records
    $stmt = $db->prepare("SELECT * FROM exhibition_artworks");
    $stmt->execute();
    $records = $stmt->fetchAll();
    
    echo "📊 Total records in exhibition_artworks: " . count($records) . "\n";
    
    if (count($records) > 0) {
        echo "\n📋 Records:\n";
        foreach ($records as $record) {
            echo "- Exhibition ID: {$record['exhibition_id']}, Artwork ID: {$record['artwork_id']}, Added: {$record['added_at']}\n";
        }
    }
    
    // Check with JOIN to get more details
    $stmt = $db->prepare("
        SELECT ea.*, e.name as exhibition_name, a.title as artwork_title, u.name as artist_name
        FROM exhibition_artworks ea
        JOIN exhibitions e ON ea.exhibition_id = e.id
        JOIN artworks a ON ea.artwork_id = a.id
        LEFT JOIN users u ON a.artist_id = u.id
        ORDER BY ea.exhibition_id, ea.added_at
    ");
    $stmt->execute();
    $details = $stmt->fetchAll();
    
    if (count($details) > 0) {
        echo "\n🎨 Detailed view:\n";
        foreach ($details as $detail) {
            echo "- Exhibition: '{$detail['exhibition_name']}' | Artwork: '{$detail['artwork_title']}' by {$detail['artist_name']} | Added: {$detail['added_at']}\n";
        }
    }
    
} catch(Exception $e) {
    echo "❌ Error: " . $e->getMessage() . "\n";
}















