-- Create exhibition_artworks junction table
CREATE TABLE IF NOT EXISTS exhibition_artworks (
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
);















