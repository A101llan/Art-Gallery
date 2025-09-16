<?php
// debug_payments.php - Comprehensive payment system debugging

require_once 'app/config/database.php';
require_once 'app/utils/MpesaDaraja.php';

echo "=== PAYMENT SYSTEM DEBUG REPORT ===\n\n";

try {
    $db = (new Database())->getConnection();
    
    // 1. Check database tables
    echo "1. DATABASE TABLES CHECK:\n";
    $tables = ['payments', 'purchase_history', 'artworks', 'users'];
    foreach ($tables as $table) {
        $stmt = $db->query("SHOW TABLES LIKE '$table'");
        if ($stmt->rowCount() > 0) {
            $stmt = $db->query("SELECT COUNT(*) as count FROM $table");
            $count = $stmt->fetch(PDO::FETCH_ASSOC);
            echo "   ✓ $table table exists with {$count['count']} records\n";
        } else {
            echo "   ✗ $table table MISSING!\n";
        }
    }
    
    // 2. Check recent payments
    echo "\n2. RECENT PAYMENTS:\n";
    $stmt = $db->query("SELECT * FROM payments ORDER BY created_at DESC LIMIT 5");
    $payments = $stmt->fetchAll(PDO::FETCH_ASSOC);
    if (empty($payments)) {
        echo "   No payments found in database.\n";
    } else {
        foreach ($payments as $payment) {
            echo "   Payment ID: {$payment['id']} | Status: {$payment['status']} | Amount: {$payment['amount']} | Created: {$payment['created_at']}\n";
            if ($payment['mpesa_receipt_number']) {
                echo "     Receipt: {$payment['mpesa_receipt_number']}\n";
            }
            if ($payment['transaction_description']) {
                echo "     Description: {$payment['transaction_description']}\n";
            }
        }
    }
    
    // 3. Check M-Pesa configuration
    echo "\n3. M-PESA CONFIGURATION:\n";
    $daraja = new MpesaDaraja();
    echo "   Environment: " . getenv('MPESA_ENV') . "\n";
    echo "   Shortcode: " . getenv('MPESA_SHORTCODE') . "\n";
    echo "   Callback URL: " . getenv('MPESA_CALLBACK_BASE_URL') . "\n";
    
    // Test OAuth
    $token = $daraja->getAccessToken();
    if ($token['success']) {
        echo "   ✓ OAuth working - Access token obtained\n";
    } else {
        echo "   ✗ OAuth failed: " . ($token['message'] ?? 'Unknown error') . "\n";
    }
    
    // 4. Check callback URL accessibility
    echo "\n4. CALLBACK URL CHECK:\n";
    $callbackUrl = getenv('MPESA_CALLBACK_BASE_URL') . '/usanii_mashariki/api/payments/mpesa/callback';
    echo "   Full callback URL: $callbackUrl\n";
    
    // Test if callback endpoint is accessible
    $ch = curl_init($callbackUrl);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 10);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode(['test' => 'data']));
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $error = curl_error($ch);
    curl_close($ch);
    
    if ($error) {
        echo "   ✗ Callback URL not accessible: $error\n";
    } else {
        echo "   ✓ Callback URL accessible (HTTP $httpCode)\n";
    }
    
    // 5. Check error logs
    echo "\n5. ERROR LOG CHECK:\n";
    $logFile = ini_get('error_log');
    if ($logFile && file_exists($logFile)) {
        $recentLogs = shell_exec("tail -n 20 \"$logFile\" 2>/dev/null");
        if ($recentLogs) {
            $mpesaLogs = array_filter(explode("\n", $recentLogs), function($line) {
                return stripos($line, 'mpesa') !== false || stripos($line, 'payment') !== false;
            });
            if (!empty($mpesaLogs)) {
                echo "   Recent M-Pesa related logs:\n";
                foreach (array_slice($mpesaLogs, -5) as $log) {
                    echo "     " . trim($log) . "\n";
                }
            } else {
                echo "   No recent M-Pesa related logs found.\n";
            }
        }
    } else {
        echo "   Error log file not found or not configured.\n";
    }
    
    // 6. Recommendations
    echo "\n6. RECOMMENDATIONS:\n";
    if (empty($payments)) {
        echo "   - No payments found. Try making a test payment.\n";
    }
    
    if (getenv('MPESA_CALLBACK_BASE_URL') === 'http://localhost/usanii_mashariki') {
        echo "   - Callback URL is set to localhost. For testing, use ngrok:\n";
        echo "     ngrok http 80\n";
        echo "     Then update MPESA_CALLBACK_BASE_URL to your ngrok URL.\n";
    }
    
    if (!$token['success']) {
        echo "   - M-Pesa OAuth is failing. Check your credentials.\n";
    }
    
    echo "\n=== END DEBUG REPORT ===\n";
    
} catch (Exception $e) {
    echo "ERROR: " . $e->getMessage() . "\n";
}
?>






