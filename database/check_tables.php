<?php
// database/check_tables.php - Check and create payment tables if needed

require_once __DIR__ . '/../app/config/database.php';

try {
    $database = new Database();
    $db = $database->getConnection();
    
    echo "Checking payment tables...\n";
    
    // Check if payments table exists
    $stmt = $db->prepare("SHOW TABLES LIKE 'payments'");
    $stmt->execute();
    if ($stmt->rowCount() == 0) {
        echo "Creating payments table...\n";
        $sql = "CREATE TABLE payments (
            id INT AUTO_INCREMENT PRIMARY KEY,
            artwork_id INT NOT NULL,
            buyer_id INT NOT NULL,
            amount DECIMAL(10,2) NOT NULL,
            phone_number VARCHAR(15) NOT NULL,
            checkout_request_id VARCHAR(100),
            merchant_request_id VARCHAR(100),
            mpesa_receipt_number VARCHAR(50),
            status ENUM('pending', 'processing', 'completed', 'failed', 'cancelled') DEFAULT 'pending',
            payment_method ENUM('mpesa') DEFAULT 'mpesa',
            transaction_description TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            completed_at TIMESTAMP NULL,
            
            FOREIGN KEY (artwork_id) REFERENCES artworks(id) ON DELETE CASCADE,
            FOREIGN KEY (buyer_id) REFERENCES users(id) ON DELETE CASCADE,
            
            INDEX idx_artwork_id (artwork_id),
            INDEX idx_buyer_id (buyer_id),
            INDEX idx_status (status),
            INDEX idx_checkout_request_id (checkout_request_id),
            INDEX idx_created_at (created_at)
        )";
        $db->exec($sql);
        echo "Payments table created successfully!\n";
    } else {
        echo "Payments table already exists.\n";
    }
    
    // Check if purchase_history table exists
    $stmt = $db->prepare("SHOW TABLES LIKE 'purchase_history'");
    $stmt->execute();
    if ($stmt->rowCount() == 0) {
        echo "Creating purchase_history table...\n";
        $sql = "CREATE TABLE purchase_history (
            id INT AUTO_INCREMENT PRIMARY KEY,
            payment_id INT NOT NULL,
            artwork_id INT NOT NULL,
            buyer_id INT NOT NULL,
            seller_id INT NOT NULL,
            amount DECIMAL(10,2) NOT NULL,
            purchase_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            
            FOREIGN KEY (payment_id) REFERENCES payments(id) ON DELETE CASCADE,
            FOREIGN KEY (artwork_id) REFERENCES artworks(id) ON DELETE CASCADE,
            FOREIGN KEY (buyer_id) REFERENCES users(id) ON DELETE CASCADE,
            FOREIGN KEY (seller_id) REFERENCES users(id) ON DELETE CASCADE,
            
            INDEX idx_artwork_id (artwork_id),
            INDEX idx_buyer_id (buyer_id),
            INDEX idx_seller_id (seller_id),
            INDEX idx_purchase_date (purchase_date)
        )";
        $db->exec($sql);
        echo "Purchase_history table created successfully!\n";
    } else {
        echo "Purchase_history table already exists.\n";
    }
    
    // Check if artworks table has 'sold' status
    $stmt = $db->prepare("SHOW COLUMNS FROM artworks LIKE 'status'");
    $stmt->execute();
    if ($stmt->rowCount() > 0) {
        $column = $stmt->fetch();
        if (strpos($column['Type'], 'sold') === false) {
            echo "Adding 'sold' status to artworks table...\n";
            $sql = "ALTER TABLE artworks MODIFY COLUMN status ENUM('draft', 'submitted', 'approved', 'rejected', 'sold') DEFAULT 'draft'";
            $db->exec($sql);
            echo "Added 'sold' status to artworks table!\n";
        } else {
            echo "Artworks table already has 'sold' status.\n";
        }
    }
    
    echo "All payment tables are ready!\n";
    
} catch(Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}





