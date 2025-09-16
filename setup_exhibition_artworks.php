<?php
// setup_exhibition_artworks.php - Set up exhibition_artworks table

require_once 'app/config/database.php';

try {
    $database = new Database();
    $db = $database->getConnection();
    
    echo "Setting up exhibition_artworks table...\n";
    
    // Create exhibition_artworks table
    $sql = "CREATE TABLE IF NOT EXISTS exhibition_artworks (
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
    echo "✅ exhibition_artworks table created successfully!\n";
    
    // Test the table by checking if it exists
    $stmt = $db->prepare("SHOW TABLES LIKE 'exhibition_artworks'");
    $stmt->execute();
    if ($stmt->rowCount() > 0) {
        echo "✅ Table verification successful!\n";
    } else {
        echo "❌ Table verification failed!\n";
    }
    
    echo "\n🎉 Exhibition artworks functionality is now ready!\n";
    echo "You can now:\n";
    echo "- Add artworks to exhibitions\n";
    echo "- Remove artworks from exhibitions\n";
    echo "- View artworks in exhibitions\n";
    echo "- Manage display order\n";
    
} catch(Exception $e) {
    echo "❌ Error: " . $e->getMessage() . "\n";
}















