<?php
// utils/FileUpload.php - File Upload Handler

require_once APP_PATH . '/utils/Security.php';

class FileUpload {
    private $upload_dir_fs; // filesystem path
    private $thumbnail_dir_fs; // filesystem path
    private $upload_dir_web; // web path relative to project root
    private $thumbnail_dir_web; // web path relative to project root

    public function __construct() {
        // Build absolute filesystem paths under public/uploads
        $project_root = dirname(APP_PATH);
        $this->upload_dir_fs = $project_root . DIRECTORY_SEPARATOR . 'public' . DIRECTORY_SEPARATOR . 'uploads' . DIRECTORY_SEPARATOR;
        $this->thumbnail_dir_fs = $project_root . DIRECTORY_SEPARATOR . 'public' . DIRECTORY_SEPARATOR . 'uploads' . DIRECTORY_SEPARATOR . 'thumbnails' . DIRECTORY_SEPARATOR;

        // Build web paths that pages can use directly
        $this->upload_dir_web = 'public/uploads/';
        $this->thumbnail_dir_web = 'public/uploads/thumbnails/';

        // Create directories if they don't exist
        if (!is_dir($this->upload_dir_fs)) {
            mkdir($this->upload_dir_fs, 0755, true);
        }
        if (!is_dir($this->thumbnail_dir_fs)) {
            mkdir($this->thumbnail_dir_fs, 0755, true);
        }
    }
    
    // Upload artwork image
    public function uploadArtworkImage($file) {
        try {
            // Validate file
            $validation = Security::validateFileUpload($file);
            if (!$validation['success']) {
                return $validation;
            }
            
            // Generate secure filename
            $filename = Security::generateSecureFilename($file['name']);
            $file_path_fs = $this->upload_dir_fs . $filename;

            // Move uploaded file
            if (!move_uploaded_file($file['tmp_name'], $file_path_fs)) {
                return ['success' => false, 'message' => 'Failed to save file'];
            }
            
            // Generate thumbnail
            $thumbnail_result = $this->generateThumbnail($file_path_fs, $filename);
            
            return [
                'success' => true,
                'filename' => $filename,
                'file_path' => $this->upload_dir_web . $filename,
                'thumbnail_path' => $thumbnail_result['success'] ? $this->thumbnail_dir_web . 'thumb_' . $filename : null
            ];
            
        } catch(Exception $e) {
            error_log("File upload error: " . $e->getMessage());
            return ['success' => false, 'message' => 'File upload failed'];
        }
    }
    
    // Generate thumbnail
    private function generateThumbnail($source_path, $filename, $width = 300, $height = 300) {
        try {
            $image_info = getimagesize($source_path);
            $mime_type = $image_info['mime'];
            
            // Create image resource based on type
            switch($mime_type) {
                case 'image/jpeg':
                    $source = imagecreatefromjpeg($source_path);
                    break;
                case 'image/png':
                    $source = imagecreatefrompng($source_path);
                    break;
                case 'image/gif':
                    $source = imagecreatefromgif($source_path);
                    break;
                default:
                    return ['success' => false, 'message' => 'Unsupported image type'];
            }
            
            if (!$source) {
                return ['success' => false, 'message' => 'Failed to create image resource'];
            }
            
            // Get original dimensions
            $orig_width = imagesx($source);
            $orig_height = imagesy($source);
            
            // Calculate new dimensions maintaining aspect ratio
            $aspect_ratio = $orig_width / $orig_height;
            if ($width / $height > $aspect_ratio) {
                $width = $height * $aspect_ratio;
            } else {
                $height = $width / $aspect_ratio;
            }
            
            // Create thumbnail
            $thumbnail = imagecreatetruecolor($width, $height);
            
            // Preserve transparency for PNG and GIF
            if ($mime_type == 'image/png' || $mime_type == 'image/gif') {
                imagecolortransparent($thumbnail, imagecolorallocatealpha($thumbnail, 0, 0, 0, 127));
                imagealphablending($thumbnail, false);
                imagesavealpha($thumbnail, true);
            }
            
            // Resize image
            imagecopyresampled($thumbnail, $source, 0, 0, 0, 0, $width, $height, $orig_width, $orig_height);
            
            // Save thumbnail (filesystem path)
            $thumbnail_path = $this->thumbnail_dir_fs . 'thumb_' . $filename;
            $success = false;
            
            switch($mime_type) {
                case 'image/jpeg':
                    $success = imagejpeg($thumbnail, $thumbnail_path, 85);
                    break;
                case 'image/png':
                    $success = imagepng($thumbnail, $thumbnail_path, 8);
                    break;
                case 'image/gif':
                    $success = imagegif($thumbnail, $thumbnail_path);
                    break;
            }
            
            // Clean up
            imagedestroy($source);
            imagedestroy($thumbnail);
            
            if ($success) {
                return ['success' => true, 'thumbnail_path' => $thumbnail_path];
            } else {
                return ['success' => false, 'message' => 'Failed to save thumbnail'];
            }
            
        } catch(Exception $e) {
            error_log("Thumbnail generation error: " . $e->getMessage());
            return ['success' => false, 'message' => 'Thumbnail generation failed'];
        }
    }
    
    // Delete file
    public function deleteFile($file_path) {
        try {
            if (file_exists($file_path)) {
                unlink($file_path);
            }
            
            // Also delete thumbnail if exists (filesystem path)
            $filename = basename($file_path);
            $thumbnail_path = $this->thumbnail_dir_fs . 'thumb_' . $filename;
            if (file_exists($thumbnail_path)) {
                unlink($thumbnail_path);
            }
            
            return ['success' => true];
            
        } catch(Exception $e) {
            error_log("File deletion error: " . $e->getMessage());
            return ['success' => false, 'message' => 'File deletion failed'];
        }
    }
}
