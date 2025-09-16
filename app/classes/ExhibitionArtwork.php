<?php
// classes/ExhibitionArtwork.php - Manage exhibition-artwork relationships

class ExhibitionArtwork {
    private $conn;
    private $table_name = "exhibition_artworks";

    public function __construct($db) {
        $this->conn = $db;
    }

    // Add artwork to exhibition
    public function addArtwork($exhibition_id, $artwork_id, $display_order = 0) {
        try {
            $sql = "INSERT INTO {$this->table_name} (exhibition_id, artwork_id, display_order) VALUES (?, ?, ?)";
            $stmt = $this->conn->prepare($sql);
            return $stmt->execute([$exhibition_id, $artwork_id, $display_order]);
        } catch (PDOException $e) {
            // If duplicate entry, update display order
            if ($e->getCode() == 23000) {
                return $this->updateDisplayOrder($exhibition_id, $artwork_id, $display_order);
            }
            throw $e;
        }
    }

    // Remove artwork from exhibition
    public function removeArtwork($exhibition_id, $artwork_id) {
        $sql = "DELETE FROM {$this->table_name} WHERE exhibition_id = ? AND artwork_id = ?";
        $stmt = $this->conn->prepare($sql);
        return $stmt->execute([$exhibition_id, $artwork_id]);
    }

    // Get all artworks in an exhibition
    public function getExhibitionArtworks($exhibition_id) {
        $sql = "SELECT ea.*, a.*, COALESCE(a.thumbnail_url, a.image_url) AS thumbnail_url, u.name as artist_name, c.name as category_name 
                FROM {$this->table_name} ea
                JOIN artworks a ON ea.artwork_id = a.id
                LEFT JOIN users u ON a.artist_id = u.id
                LEFT JOIN categories c ON a.category_id = c.id
                WHERE ea.exhibition_id = ?
                ORDER BY ea.display_order ASC, ea.added_at ASC";
        
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$exhibition_id]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Get exhibitions for an artwork
    public function getArtworkExhibitions($artwork_id) {
        $sql = "SELECT ea.*, e.* 
                FROM {$this->table_name} ea
                JOIN exhibitions e ON ea.exhibition_id = e.id
                WHERE ea.artwork_id = ?
                ORDER BY e.start_date DESC";
        
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$artwork_id]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Update display order
    public function updateDisplayOrder($exhibition_id, $artwork_id, $display_order) {
        $sql = "UPDATE {$this->table_name} SET display_order = ? WHERE exhibition_id = ? AND artwork_id = ?";
        $stmt = $this->conn->prepare($sql);
        return $stmt->execute([$display_order, $exhibition_id, $artwork_id]);
    }

    // Check if artwork is in exhibition
    public function isArtworkInExhibition($exhibition_id, $artwork_id) {
        $sql = "SELECT COUNT(*) FROM {$this->table_name} WHERE exhibition_id = ? AND artwork_id = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$exhibition_id, $artwork_id]);
        return $stmt->fetchColumn() > 0;
    }

    // Get available artworks (not in this exhibition)
    public function getAvailableArtworks($exhibition_id) {
        $sql = "SELECT a.*, COALESCE(a.thumbnail_url, a.image_url) AS thumbnail_url, u.name as artist_name, c.name as category_name 
                FROM artworks a
                LEFT JOIN users u ON a.artist_id = u.id
                LEFT JOIN categories c ON a.category_id = c.id
                WHERE a.status IN ('approved','submitted')
                AND a.id NOT IN (
                    SELECT artwork_id FROM {$this->table_name} WHERE exhibition_id = ?
                )
                ORDER BY a.title ASC";
        
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$exhibition_id]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Get exhibition artwork count
    public function getExhibitionArtworkCount($exhibition_id) {
        $sql = "SELECT COUNT(*) FROM {$this->table_name} WHERE exhibition_id = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$exhibition_id]);
        return $stmt->fetchColumn();
    }
}





