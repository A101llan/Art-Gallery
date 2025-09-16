<?php
// test_exhibition_artworks.php - Test adding artworks to exhibitions

require_once 'app/config/database.php';
require_once 'app/classes/ExhibitionArtwork.php';

try {
    $database = new Database();
    $db = $database->getConnection();
    $exhibitionArtwork = new ExhibitionArtwork($db);
    
    echo "Testing exhibition artworks functionality...\n";
    
    // Get first exhibition
    $stmt = $db->prepare("SELECT id, name FROM exhibitions LIMIT 1");
    $stmt->execute();
    $exhibition = $stmt->fetch();
    
    if (!$exhibition) {
        echo "❌ No exhibitions found. Please create an exhibition first.\n";
        exit;
    }
    
    echo "Using exhibition: {$exhibition['name']} (ID: {$exhibition['id']})\n";
    
    // Get approved artworks
    $stmt = $db->prepare("SELECT id, title FROM artworks WHERE status = 'approved' LIMIT 3");
    $stmt->execute();
    $artworks = $stmt->fetchAll();
    
    if (count($artworks) == 0) {
        echo "❌ No approved artworks found. Please approve some artworks first.\n";
        exit;
    }
    
    echo "Found " . count($artworks) . " approved artworks:\n";
    foreach ($artworks as $artwork) {
        echo "- {$artwork['title']} (ID: {$artwork['id']})\n";
    }
    
    // Add artworks to exhibition
    foreach ($artworks as $artwork) {
        if ($exhibitionArtwork->addArtwork($exhibition['id'], $artwork['id'])) {
            echo "✅ Added '{$artwork['title']}' to exhibition\n";
        } else {
            echo "❌ Failed to add '{$artwork['title']}' to exhibition\n";
        }
    }
    
    // Check current count
    $count = $exhibitionArtwork->getExhibitionArtworkCount($exhibition['id']);
    echo "\n📊 Exhibition now has {$count} artworks\n";
    
    // List artworks in exhibition
    $exhibitionArtworks = $exhibitionArtwork->getExhibitionArtworks($exhibition['id']);
    echo "\n🎨 Artworks in exhibition:\n";
    foreach ($exhibitionArtworks as $artwork) {
        echo "- {$artwork['title']} by {$artwork['artist_name']}\n";
    }
    
    echo "\n🎉 Test completed! You can now test the staff dashboard.\n";
    
} catch(Exception $e) {
    echo "❌ Error: " . $e->getMessage() . "\n";
}















