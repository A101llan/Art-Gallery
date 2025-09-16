<?php
// debug_exhibition_artworks.php - Debug exhibition artworks functionality

require_once 'app/config/database.php';
require_once 'app/classes/ExhibitionArtwork.php';

try {
    $database = new Database();
    $db = $database->getConnection();
    $exhibitionArtwork = new ExhibitionArtwork($db);
    
    echo "Debugging exhibition artworks functionality...\n";
    
    // Get first exhibition
    $stmt = $db->prepare("SELECT id, name FROM exhibitions LIMIT 1");
    $stmt->execute();
    $exhibition = $stmt->fetch();
    
    if (!$exhibition) {
        echo "❌ No exhibitions found.\n";
        exit;
    }
    
    echo "Using exhibition: {$exhibition['name']} (ID: {$exhibition['id']})\n";
    
    // Get first approved artwork
    $stmt = $db->prepare("SELECT id, title FROM artworks WHERE status = 'approved' LIMIT 1");
    $stmt->execute();
    $artwork = $stmt->fetch();
    
    if (!$artwork) {
        echo "❌ No approved artworks found.\n";
        exit;
    }
    
    echo "Using artwork: {$artwork['title']} (ID: {$artwork['id']})\n";
    
    // Try to add artwork directly with SQL to test
    echo "\n🔧 Testing direct SQL insert...\n";
    try {
        $sql = "INSERT INTO exhibition_artworks (exhibition_id, artwork_id, display_order) VALUES (?, ?, ?)";
        $stmt = $db->prepare($sql);
        $result = $stmt->execute([$exhibition['id'], $artwork['id'], 0]);
        
        if ($result) {
            echo "✅ Direct SQL insert successful!\n";
        } else {
            echo "❌ Direct SQL insert failed!\n";
            print_r($stmt->errorInfo());
        }
    } catch (Exception $e) {
        echo "❌ Direct SQL insert error: " . $e->getMessage() . "\n";
    }
    
    // Check if it was added
    $stmt = $db->prepare("SELECT COUNT(*) FROM exhibition_artworks WHERE exhibition_id = ? AND artwork_id = ?");
    $stmt->execute([$exhibition['id'], $artwork['id']]);
    $count = $stmt->fetchColumn();
    echo "📊 Records found: {$count}\n";
    
    // Test the class method
    echo "\n🔧 Testing class method...\n";
    try {
        $result = $exhibitionArtwork->addArtwork($exhibition['id'], $artwork['id']);
        echo "Class method result: " . ($result ? "true" : "false") . "\n";
    } catch (Exception $e) {
        echo "❌ Class method error: " . $e->getMessage() . "\n";
    }
    
    // Final check
    $stmt = $db->prepare("SELECT COUNT(*) FROM exhibition_artworks");
    $stmt->execute();
    $totalCount = $stmt->fetchColumn();
    echo "\n📊 Total records in table: {$totalCount}\n";
    
} catch(Exception $e) {
    echo "❌ Error: " . $e->getMessage() . "\n";
}















