<?php
// fix_exhibition_artworks_table.php - Fix exhibition_artworks table structure

require_once 'app/config/database.php';

try {
    $database = new Database();
    $db = $database->getConnection();
    
    echo "Fixing exhibition_artworks table...\n";
    
    // Drop the existing table
    echo "Dropping existing table...\n";
    $db->exec("DROP TABLE IF EXISTS exhibition_artworks");
    
    // Create the table with correct structure
    echo "Creating new table...\n";
    $sql = "CREATE TABLE exhibition_artworks (
        id INT AUTO_INCREMENT PRIMARY KEY,
        exhibition_id INT NOT NULL,
        artwork_id INT NOT NULL,
        display_order INT DEFAULT 0,
        added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        
        FOREIGN KEY (exhibition_id) REFERENCES exhibitions(id) ON DELETE CASCADE,
        FOREIGN KEY (artwork_id) REFERENCES artworks(id) ON DELETE CASCADE,
        
        UNIQUE KEY unique_exhibition_artwork (exhibition_id, artwork_id),
        INDEX idx_exhibition_id (exhibition_id),
        INDEX idx_artwork_id (artwork_id),
        INDEX idx_display_order (display_order)
    )";
    
    $db->exec($sql);
    echo "✅ Table created successfully!\n";
    
    // Test insert
    echo "Testing insert...\n";
    $stmt = $db->prepare("SELECT id FROM exhibitions LIMIT 1");
    $stmt->execute();
    $exhibition = $stmt->fetch();
    
    $stmt = $db->prepare("SELECT id FROM artworks WHERE status = 'approved' LIMIT 1");
    $stmt->execute();
    $artwork = $stmt->fetch();
    
    if ($exhibition && $artwork) {
        $insertStmt = $db->prepare("INSERT INTO exhibition_artworks (exhibition_id, artwork_id, display_order) VALUES (?, ?, ?)");
        $result = $insertStmt->execute([$exhibition['id'], $artwork['id'], 0]);
        
        if ($result) {
            echo "✅ Test insert successful!\n";
            
            // Check count
            $stmt = $db->prepare("SELECT COUNT(*) FROM exhibition_artworks");
            $stmt->execute();
            $count = $stmt->fetchColumn();
            echo "📊 Total records: {$count}\n";
        } else {
            echo "❌ Test insert failed!\n";
        }
    }
    
    echo "\n🎉 Table fixed! You can now use the exhibition artworks functionality.\n";
    
} catch(Exception $e) {
    echo "❌ Error: " . $e->getMessage() . "\n";
}















