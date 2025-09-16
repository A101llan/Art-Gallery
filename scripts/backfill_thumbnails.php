<?php
// scripts/backfill_thumbnails.php - Generate missing thumbnails for existing images

define('APP_PATH', __DIR__ . '/../app');
require_once APP_PATH . '/config/database.php';
require_once APP_PATH . '/utils/FileUpload.php';

try {
    $db = (new Database())->getConnection();
    $fu = new FileUpload();

    // Find artworks missing thumbnail but having image_url under public/uploads
    $stmt = $db->prepare("SELECT id, image_url FROM artworks WHERE (thumbnail_url IS NULL OR thumbnail_url = '') AND image_url LIKE 'public/%'");
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if (empty($rows)) {
        echo "No artworks require backfill.\n";
        exit;
    }

    $project_root = dirname(APP_PATH);
    $count = 0; $ok = 0; $fail = 0;
    foreach ($rows as $row) {
        $count++;
        $web_path = $row['image_url']; // e.g., public/uploads/filename.jpg
        $fs_path = $project_root . DIRECTORY_SEPARATOR . str_replace('/', DIRECTORY_SEPARATOR, $web_path);
        if (!file_exists($fs_path)) {
            echo "Missing source file: {$fs_path}\n";
            $fail++;
            continue;
        }
        $filename = basename($fs_path);
        $thumb = (new ReflectionClass($fu))->getMethod('generateThumbnail');
        $thumb->setAccessible(true);
        $result = $thumb->invoke($fu, $fs_path, $filename);
        if ($result['success'] ?? false) {
            $thumb_web = 'public/uploads/thumbnails/' . 'thumb_' . $filename;
            $up = $db->prepare("UPDATE artworks SET thumbnail_url = ? WHERE id = ?");
            $up->execute([$thumb_web, $row['id']]);
            echo "Generated thumbnail for artwork {$row['id']} -> {$thumb_web}\n";
            $ok++;
        } else {
            echo "Failed to generate thumbnail for artwork {$row['id']}: " . ($result['message'] ?? 'unknown') . "\n";
            $fail++;
        }
    }
    echo "Done. Total: {$count}, OK: {$ok}, Failed: {$fail}\n";
} catch (Exception $e) {
    echo 'Error: ' . $e->getMessage() . "\n";
}




