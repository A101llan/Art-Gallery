<?php
// api/reports.php - Generate and download reports

require_once APP_PATH . '/config/database.php';
require_once APP_PATH . '/classes/Auth.php';
require_once APP_PATH . '/utils/Security.php';

try {
    $database = new Database();
    $db = $database->getConnection();
    $auth = new Auth($db);

    // Check if user is logged in and has admin/staff role
    if (!$auth->isLoggedIn()) {
        http_response_code(401);
        echo json_encode(['success' => false, 'message' => 'Authentication required']);
        exit;
    }

    $user = $auth->getCurrentUser();
    if (!in_array($user['role'], ['admin', 'staff'])) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'Admin access required']);
        exit;
    }

    if ($_SERVER['REQUEST_METHOD'] === 'GET') {
        $report_type = $_GET['type'] ?? '';
        $format = $_GET['format'] ?? 'csv';
        
        if (!in_array($format, ['csv', 'pdf'])) {
            $format = 'csv';
        }

        switch ($report_type) {
            case 'artworks':
                generateArtworksReport($db, $format);
                break;
            case 'artists':
                generateArtistsReport($db, $format);
                break;
            case 'sales':
                generateSalesReport($db, $format);
                break;
            case 'users':
                generateUsersReport($db, $format);
                break;
            case 'exhibitions':
                generateExhibitionsReport($db, $format);
                break;
            default:
                http_response_code(400);
                echo json_encode(['success' => false, 'message' => 'Invalid report type']);
                exit;
        }
    } else {
        http_response_code(405);
        echo json_encode(['success' => false, 'message' => 'Method not allowed']);
    }

} catch (Exception $e) {
    error_log('Reports API error: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Server error']);
}

function generateArtworksReport($db, $format) {
    $query = "SELECT 
                a.id,
                a.title,
                a.description,
                a.price,
                a.status,
                a.created_at,
                c.name as category_name,
                u.name as artist_name,
                u.email as artist_email
              FROM artworks a
              LEFT JOIN categories c ON a.category_id = c.id
              LEFT JOIN users u ON a.artist_id = u.id
              ORDER BY a.created_at DESC";
    
    $stmt = $db->prepare($query);
    $stmt->execute();
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    $filename = 'artworks_report_' . date('Y-m-d_H-i-s');
    outputReport($data, $filename, $format, 'USANII MASHARIKI ART GALLERY - Artworks Report');
}

function generateArtistsReport($db, $format) {
    $query = "SELECT 
                u.id,
                u.name,
                u.email,
                u.phone,
                u.status,
                u.created_at,
                COUNT(a.id) as artwork_count,
                COUNT(CASE WHEN a.status = 'approved' THEN 1 END) as approved_artworks,
                COUNT(CASE WHEN a.status = 'sold' THEN 1 END) as sold_artworks
              FROM users u
              LEFT JOIN artworks a ON u.id = a.artist_id
              WHERE u.role = 'artist'
              GROUP BY u.id
              ORDER BY u.name";
    
    $stmt = $db->prepare($query);
    $stmt->execute();
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    $filename = 'artists_report_' . date('Y-m-d_H-i-s');
    outputReport($data, $filename, $format, 'USANII MASHARIKI ART GALLERY - Artists Report');
}

function generateSalesReport($db, $format) {
    $query = "SELECT 
                p.id as payment_id,
                p.amount,
                p.status,
                p.mpesa_receipt_number,
                p.created_at,
                p.completed_at,
                a.title as artwork_title,
                a.price as artwork_price,
                buyer.name as buyer_name,
                buyer.email as buyer_email,
                seller.name as seller_name,
                seller.email as seller_email
              FROM payments p
              LEFT JOIN artworks a ON p.artwork_id = a.id
              LEFT JOIN users buyer ON p.buyer_id = buyer.id
              LEFT JOIN users seller ON a.artist_id = seller.id
              ORDER BY p.created_at DESC";
    
    $stmt = $db->prepare($query);
    $stmt->execute();
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    $filename = 'sales_report_' . date('Y-m-d_H-i-s');
    outputReport($data, $filename, $format, 'USANII MASHARIKI ART GALLERY - Sales Report');
}

function generateUsersReport($db, $format) {
    $query = "SELECT 
                id,
                name,
                email,
                role,
                status,
                email_verified,
                created_at
              FROM users
              ORDER BY created_at DESC";
    
    $stmt = $db->prepare($query);
    $stmt->execute();
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    $filename = 'users_report_' . date('Y-m-d_H-i-s');
    outputReport($data, $filename, $format, 'USANII MASHARIKI ART GALLERY - Users Report');
}

function generateExhibitionsReport($db, $format) {
    $query = "SELECT 
                e.id,
                e.title,
                e.description,
                e.start_date,
                e.end_date,
                e.status,
                e.created_at,
                COUNT(ea.artwork_id) as artwork_count
              FROM exhibitions e
              LEFT JOIN exhibition_artworks ea ON e.id = ea.exhibition_id
              GROUP BY e.id
              ORDER BY e.created_at DESC";
    
    $stmt = $db->prepare($query);
    $stmt->execute();
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    $filename = 'exhibitions_report_' . date('Y-m-d_H-i-s');
    outputReport($data, $filename, $format, 'USANII MASHARIKI ART GALLERY - Exhibitions Report');
}

function outputReport($data, $filename, $format, $title) {
    if ($format === 'csv') {
        // Set headers for CSV download
        header('Content-Type: text/csv');
        header('Content-Disposition: attachment; filename="' . $filename . '.csv"');
        header('Cache-Control: no-cache, must-revalidate');
        header('Expires: Sat, 26 Jul 1997 05:00:00 GMT');
        
        // Create CSV output
        $output = fopen('php://output', 'w');
        
        // Add title row
        fputcsv($output, [$title . ' - Generated on ' . date('Y-m-d H:i:s')]);
        fputcsv($output, ['USANII MASHARIKI ART GALLERY']);
        fputcsv($output, []); // Empty row
        
        // Add headers
        if (!empty($data)) {
            fputcsv($output, array_keys($data[0]));
        }
        
        // Add data rows
        foreach ($data as $row) {
            fputcsv($output, $row);
        }
        
        fclose($output);
        
    } else { // PDF format
        generatePDFReport($data, $filename, $title);
    }
    
    exit;
}

function generatePDFReport($data, $filename, $title) {
    // Set headers for HTML download (browser will convert to PDF)
    header('Content-Type: text/html');
    header('Content-Disposition: attachment; filename="' . $filename . '.html"');
    header('Cache-Control: no-cache, must-revalidate');
    header('Expires: Sat, 26 Jul 1997 05:00:00 GMT');
    
    // Create HTML content optimized for PDF printing
    $html = '<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>' . htmlspecialchars($title) . '</title>
    <style>
        @media print {
            body { margin: 0; padding: 20px; }
            .no-print { display: none; }
        }
        body { 
            font-family: Arial, sans-serif; 
            margin: 20px; 
            line-height: 1.4;
            color: #333;
        }
        h1 { 
            color: #0056b3; 
            border-bottom: 2px solid #0056b3; 
            padding-bottom: 10px; 
            text-align: center;
            margin-bottom: 30px;
            font-size: 24px;
            font-weight: bold;
        }
        .gallery-name {
            color: #0056b3;
            font-size: 18px;
            font-weight: bold;
            text-align: center;
            margin: 10px 0;
        }
        .header { 
            text-align: center; 
            margin-bottom: 30px; 
            border-bottom: 1px solid #ddd;
            padding-bottom: 20px;
        }
        .header p {
            margin: 5px 0;
            color: #666;
        }
        table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 20px; 
            font-size: 12px;
        }
        th, td { 
            border: 1px solid #ddd; 
            padding: 8px; 
            text-align: left; 
            vertical-align: top;
        }
        th { 
            background-color: #f8f9fa; 
            font-weight: bold; 
            color: #333;
        }
        tr:nth-child(even) { 
            background-color: #f9f9f9; 
        }
        .generated { 
            font-size: 11px; 
            color: #666; 
            margin-top: 30px; 
            text-align: center;
            border-top: 1px solid #ddd;
            padding-top: 20px;
        }
        .print-instructions {
            background: #e7f3ff;
            border: 1px solid #0056b3;
            padding: 15px;
            margin: 20px 0;
            border-radius: 5px;
            text-align: center;
        }
        .print-instructions h3 {
            margin: 0 0 10px 0;
            color: #0056b3;
        }
        .print-instructions p {
            margin: 5px 0;
        }
    </style>
</head>
<body>
    <div class="print-instructions no-print">
        <h3>📄 PDF Generation Instructions</h3>
        <p><strong>To save as PDF:</strong></p>
        <p>1. Press <strong>Ctrl+P</strong> (Windows) or <strong>Cmd+P</strong> (Mac)</p>
        <p>2. Select "Save as PDF" as destination</p>
        <p>3. Click "Save" to download the PDF file</p>
    </div>
    
    <div class="header">
        <div class="gallery-name">USANII MASHARIKI ART GALLERY</div>
        <h1>' . htmlspecialchars($title) . '</h1>
        <p><strong>Generated on:</strong> ' . date('Y-m-d H:i:s') . '</p>
        <p><strong>Total Records:</strong> ' . count($data) . '</p>
    </div>';
    
    if (!empty($data)) {
        $html .= '<table>
            <thead>
                <tr>';
        
        // Add headers
        foreach (array_keys($data[0]) as $header) {
            $html .= '<th>' . htmlspecialchars(ucwords(str_replace('_', ' ', $header))) . '</th>';
        }
        
        $html .= '</tr>
            </thead>
            <tbody>';
        
        // Add data rows
        foreach ($data as $row) {
            $html .= '<tr>';
            foreach ($row as $value) {
                // Format the value for better display
                $formattedValue = $value;
                if (is_numeric($value) && strpos($value, '.') !== false) {
                    $formattedValue = number_format((float)$value, 2);
                } elseif (strpos($value, '-') === 4 && strpos($value, '-', 5) === 7) {
                    // Format dates
                    $formattedValue = date('M d, Y', strtotime($value));
                }
                $html .= '<td>' . htmlspecialchars($formattedValue) . '</td>';
            }
            $html .= '</tr>';
        }
        
        $html .= '</tbody>
        </table>';
    } else {
        $html .= '<p style="text-align: center; font-style: italic; color: #666;">No data available for this report.</p>';
    }
    
    $html .= '<div class="generated">
        <p><strong>Report generated by USANII MASHARIKI ART GALLERY</strong></p>
        <p>© ' . date('Y') . ' USANII MASHARIKI ART GALLERY. All rights reserved.</p>
    </div>
    
    <script>
        // Auto-print when page loads (optional)
        // window.onload = function() {
        //     window.print();
        // };
    </script>
</body>
</html>';
    
    echo $html;
}
?>
