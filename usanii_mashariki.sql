-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 16, 2025 at 03:09 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `usanii_mashariki`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `table_name` varchar(50) NOT NULL,
  `record_id` int(11) DEFAULT NULL,
  `old_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_values`)),
  `new_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_values`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `table_name`, `record_id`, `old_values`, `new_values`, `ip_address`, `user_agent`, `created_at`) VALUES
(1, 2, 'user_registered', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-19 17:30:38'),
(2, NULL, 'user_registered', 'users', 3, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-19 17:40:39'),
(3, NULL, 'user_registered', 'users', 4, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-19 17:41:44'),
(4, NULL, 'user_registered', 'users', 5, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-19 17:42:08'),
(5, 6, 'user_registered', 'users', 6, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-19 17:46:01'),
(6, 6, 'user_login', 'users', 6, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-19 17:46:58'),
(7, 6, 'user_logout', 'users', 6, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-19 17:48:03'),
(8, 6, 'user_login', 'users', 6, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-19 17:48:19'),
(9, 6, 'user_logout', 'users', 6, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-19 17:49:54'),
(10, 6, 'user_login', 'users', 6, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-19 17:50:25'),
(11, 6, 'user_login', 'users', 6, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-19 17:50:43'),
(12, 6, 'user_logout', 'users', 6, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-19 18:01:38'),
(13, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-19 19:44:54'),
(14, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-19 19:45:02'),
(15, 7, 'user_registered', 'users', 7, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-19 19:53:08'),
(16, 7, 'user_login', 'users', 7, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-19 19:53:32'),
(17, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-19 19:59:04'),
(18, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-19 20:52:19'),
(19, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-20 02:06:29'),
(20, 2, 'exhibition_created', 'exhibitions', 1, 'null', '{\"name\":\"Grand Opening\",\"description\":\"Official launch of the management system\",\"start_date\":\"2025-08-24\",\"end_date\":\"2025-08-31\",\"featured_image\":\"\",\"created_by\":2,\"status\":\"upcoming\",\"max_artworks\":50}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-20 02:07:42'),
(21, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-20 02:23:19'),
(22, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-20 02:23:40'),
(23, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-20 02:23:56'),
(24, 7, 'user_login', 'users', 7, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-20 02:25:54'),
(25, 7, 'user_logout', 'users', 7, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-20 02:26:53'),
(26, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-20 02:27:06'),
(27, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-20 02:59:39'),
(28, 8, 'user_registered', 'users', 8, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-20 08:37:12'),
(29, 8, 'user_login', 'users', 8, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-20 08:37:28'),
(30, 8, 'profile_updated', 'users', 8, 'null', '{\"name\":\"Trevor Wanyoike\",\"phone\":\"\",\"bio\":\"\",\"profile_image\":\"http:\\/\\/localhost\\/usanii_mashariki\\/artist-dashboard.html#\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-20 09:23:14'),
(31, 8, 'user_logout', 'users', 8, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-20 09:26:13'),
(32, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-20 16:39:41'),
(33, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-20 16:41:12'),
(34, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-20 16:46:36'),
(35, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 14:45:44'),
(36, 8, 'user_login', 'users', 8, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 14:46:09'),
(37, 8, 'artwork_created', 'artworks', 1, 'null', '{\"title\":\"durban potrait\",\"description\":\"From the port of durban\",\"category_id\":4,\"artist_id\":8,\"image_url\":\"uploads\\/f70c39f23726b62b9989cc4f1a292674.png\",\"thumbnail_url\":\"uploads\\/thumbnails\\/thumb_f70c39f23726b62b9989cc4f1a292674.png\",\"dimensions\":\"12\\u00d78\",\"medium\":\"oil painting\",\"year_created\":2025,\"price\":25998.99,\"status\":\"draft\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 14:48:11'),
(38, 8, 'user_logout', 'users', 8, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 14:48:55'),
(39, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 14:49:14'),
(40, 2, 'submission_reviewed', 'submissions', 1, '{\"id\":1,\"artwork_id\":1,\"artist_id\":8,\"status\":\"pending\",\"submission_notes\":\"Made with love.\",\"review_notes\":null,\"reviewed_by\":null,\"reviewed_at\":null,\"submitted_at\":\"2025-08-21 17:48:35\",\"updated_at\":\"2025-08-21 17:48:35\"}', '{\"status\":\"approved\",\"action\":\"approve\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 14:49:36'),
(41, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 14:50:20'),
(42, 7, 'user_login', 'users', 7, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 14:51:24'),
(43, 7, 'user_logout', 'users', 7, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:03:12'),
(44, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:03:24'),
(45, 2, 'artwork_updated', 'artworks', 1, '{\"id\":1,\"title\":\"durban potrait\",\"description\":\"From the port of durban\",\"category_id\":4,\"artist_id\":8,\"image_url\":\"uploads\\/f70c39f23726b62b9989cc4f1a292674.png\",\"thumbnail_url\":\"uploads\\/thumbnails\\/thumb_f70c39f23726b62b9989cc4f1a292674.png\",\"dimensions\":\"12\\u00d78\",\"medium\":\"oil painting\",\"year_created\":\"2025\",\"price\":\"25998.99\",\"status\":\"approved\",\"featured\":0,\"views_count\":3,\"created_at\":\"2025-08-21 17:48:11\",\"updated_at\":\"2025-08-21 18:03:39\",\"category_name\":\"Digital Art\",\"artist_name\":\"Trevor Wanyoike\",\"artist_email\":\"trevor@gmail.com\"}', '{\"title\":\"durban potrait\",\"description\":\"From the port of durban\",\"category_id\":4,\"dimensions\":\"12\\u00d78\",\"medium\":\"oil painting\",\"year_created\":2025,\"price\":25998.99,\"status\":\"submitted\",\"featured\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:03:47'),
(46, 2, 'artwork_updated', 'artworks', 1, '{\"id\":1,\"title\":\"durban potrait\",\"description\":\"From the port of durban\",\"category_id\":4,\"artist_id\":8,\"image_url\":\"uploads\\/f70c39f23726b62b9989cc4f1a292674.png\",\"thumbnail_url\":\"uploads\\/thumbnails\\/thumb_f70c39f23726b62b9989cc4f1a292674.png\",\"dimensions\":\"12\\u00d78\",\"medium\":\"oil painting\",\"year_created\":\"2025\",\"price\":\"25998.99\",\"status\":\"submitted\",\"featured\":0,\"views_count\":4,\"created_at\":\"2025-08-21 17:48:11\",\"updated_at\":\"2025-08-21 18:03:56\",\"category_name\":\"Digital Art\",\"artist_name\":\"Trevor Wanyoike\",\"artist_email\":\"trevor@gmail.com\"}', '{\"title\":\"durban potrait\",\"description\":\"From the port of durban\",\"category_id\":4,\"dimensions\":\"12\\u00d78\",\"medium\":\"oil painting\",\"year_created\":2025,\"price\":25998.99,\"status\":\"approved\",\"featured\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:04:06'),
(47, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:06:49'),
(48, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:07:04'),
(49, 2, 'artwork_updated', 'artworks', 1, '{\"id\":1,\"title\":\"durban potrait\",\"description\":\"From the port of durban\",\"category_id\":4,\"artist_id\":8,\"image_url\":\"uploads\\/f70c39f23726b62b9989cc4f1a292674.png\",\"thumbnail_url\":\"uploads\\/thumbnails\\/thumb_f70c39f23726b62b9989cc4f1a292674.png\",\"dimensions\":\"12\\u00d78\",\"medium\":\"oil painting\",\"year_created\":\"2025\",\"price\":\"25998.99\",\"status\":\"approved\",\"featured\":0,\"views_count\":5,\"created_at\":\"2025-08-21 17:48:11\",\"updated_at\":\"2025-08-21 18:07:08\",\"category_name\":\"Digital Art\",\"artist_name\":\"Trevor Wanyoike\",\"artist_email\":\"trevor@gmail.com\"}', '{\"title\":\"durban potrait\",\"description\":\"From the port of durban\",\"category_id\":4,\"dimensions\":\"12\\u00d78\",\"medium\":\"oil painting\",\"year_created\":2025,\"price\":25998.99,\"status\":\"approved\",\"featured\":true}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:07:11'),
(50, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:07:19'),
(51, 9, 'user_registered', 'users', 9, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:15:59'),
(52, 9, 'user_login', 'users', 9, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:16:09'),
(53, 9, 'user_logout', 'users', 9, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:17:29'),
(54, 10, 'user_registered', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:18:07'),
(55, 10, 'user_login', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:18:16'),
(56, 10, 'artwork_created', 'artworks', 2, 'null', '{\"title\":\"Big 5\",\"description\":\"The big 5 animals\",\"category_id\":1,\"artist_id\":10,\"image_url\":\"uploads\\/5c3c30ccdac1c16e7e453c99904a54c3.jpg\",\"thumbnail_url\":\"uploads\\/thumbnails\\/thumb_5c3c30ccdac1c16e7e453c99904a54c3.jpg\",\"dimensions\":\"5\\u00d75\",\"medium\":\"Hand painting\",\"year_created\":2025,\"price\":5000,\"status\":\"draft\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:22:30'),
(57, 10, 'user_logout', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:23:25'),
(58, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:24:04'),
(59, 2, 'submission_reviewed', 'submissions', 2, '{\"id\":2,\"artwork_id\":2,\"artist_id\":10,\"status\":\"pending\",\"submission_notes\":\"\",\"review_notes\":null,\"reviewed_by\":null,\"reviewed_at\":null,\"submitted_at\":\"2025-08-21 18:23:00\",\"updated_at\":\"2025-08-21 18:23:00\"}', '{\"status\":\"approved\",\"action\":\"approve\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:24:35'),
(60, 2, 'artwork_updated', 'artworks', 2, '{\"id\":2,\"title\":\"Big 5\",\"description\":\"The big 5 animals\",\"category_id\":1,\"artist_id\":10,\"image_url\":\"uploads\\/5c3c30ccdac1c16e7e453c99904a54c3.jpg\",\"thumbnail_url\":\"uploads\\/thumbnails\\/thumb_5c3c30ccdac1c16e7e453c99904a54c3.jpg\",\"dimensions\":\"5\\u00d75\",\"medium\":\"Hand painting\",\"year_created\":\"2025\",\"price\":\"5000.00\",\"status\":\"approved\",\"featured\":0,\"views_count\":1,\"created_at\":\"2025-08-21 18:22:30\",\"updated_at\":\"2025-08-21 18:24:46\",\"category_name\":\"Painting\",\"artist_name\":\"musee\",\"artist_email\":\"musee@gmail.com\"}', '{\"title\":\"Big 5\",\"description\":\"The big 5 animals\",\"category_id\":1,\"dimensions\":\"5\\u00d75\",\"medium\":\"Hand painting\",\"year_created\":2025,\"price\":5000,\"status\":\"approved\",\"featured\":true}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:24:53'),
(61, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:25:35'),
(62, 11, 'user_registered', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:26:10'),
(63, 11, 'user_login', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:26:21'),
(64, 11, 'user_logout', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:34:30'),
(65, 12, 'user_registered', 'users', 12, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:34:59'),
(66, 12, 'user_login', 'users', 12, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:35:09'),
(67, 12, 'profile_updated', 'users', 12, 'null', '{\"name\":\"Mugambi\",\"phone\":\"0783673864\",\"bio\":\"Christ believer\",\"profile_image\":\"http:\\/\\/localhost\\/usanii_mashariki\\/artist-dashboard.html#\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:35:56'),
(68, 12, 'artwork_created', 'artworks', 3, 'null', '{\"title\":\"Nature Landscape\",\"description\":\"Beauty put in art\",\"category_id\":1,\"artist_id\":12,\"image_url\":\"public\\/uploads\\/9359100a130f184a3ab8e429c87c7768.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_9359100a130f184a3ab8e429c87c7768.png\",\"dimensions\":\"7\\u00d77\",\"medium\":\"Acrylic\",\"year_created\":2025,\"price\":6799,\"status\":\"draft\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:39:44'),
(69, 12, 'artwork_updated', 'artworks', 3, '{\"id\":3,\"title\":\"Nature Landscape\",\"description\":\"Beauty put in art\",\"category_id\":1,\"artist_id\":12,\"image_url\":\"public\\/uploads\\/9359100a130f184a3ab8e429c87c7768.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_9359100a130f184a3ab8e429c87c7768.png\",\"dimensions\":\"7\\u00d77\",\"medium\":\"Acrylic\",\"year_created\":\"2025\",\"price\":\"6799.00\",\"status\":\"draft\",\"featured\":0,\"views_count\":1,\"created_at\":\"2025-08-21 18:39:44\",\"updated_at\":\"2025-08-21 18:51:45\",\"category_name\":\"Painting\",\"artist_name\":\"Mugambi\",\"artist_email\":\"Mugambi@gmail.com\"}', '{\"title\":\"Nature Landscape\",\"description\":\"Beauty put in art\",\"category_id\":1,\"dimensions\":\"7\\u00d77\",\"medium\":\"Acrylic\",\"year_created\":2025,\"price\":6799}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:51:55'),
(70, 12, 'artwork_updated', 'artworks', 3, '{\"id\":3,\"title\":\"Nature Landscape\",\"description\":\"Beauty put in art\",\"category_id\":1,\"artist_id\":12,\"image_url\":\"public\\/uploads\\/9359100a130f184a3ab8e429c87c7768.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_9359100a130f184a3ab8e429c87c7768.png\",\"dimensions\":\"7\\u00d77\",\"medium\":\"Acrylic\",\"year_created\":\"2025\",\"price\":\"6799.00\",\"status\":\"submitted\",\"featured\":0,\"views_count\":3,\"created_at\":\"2025-08-21 18:39:44\",\"updated_at\":\"2025-08-21 18:55:08\",\"category_name\":\"Painting\",\"artist_name\":\"Mugambi\",\"artist_email\":\"Mugambi@gmail.com\"}', '{\"title\":\"Nature Landscape\",\"description\":\"Beauty put in art\",\"category_id\":1,\"dimensions\":\"7\\u00d77\",\"medium\":\"Acrylic\",\"year_created\":2025,\"price\":6799}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:55:13'),
(71, 12, 'artwork_updated', 'artworks', 3, '{\"id\":3,\"title\":\"Nature Landscape\",\"description\":\"Beauty put in art\",\"category_id\":1,\"artist_id\":12,\"image_url\":\"public\\/uploads\\/9359100a130f184a3ab8e429c87c7768.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_9359100a130f184a3ab8e429c87c7768.png\",\"dimensions\":\"7\\u00d77\",\"medium\":\"Acrylic\",\"year_created\":\"2025\",\"price\":\"6799.00\",\"status\":\"submitted\",\"featured\":0,\"views_count\":4,\"created_at\":\"2025-08-21 18:39:44\",\"updated_at\":\"2025-08-21 18:55:20\",\"category_name\":\"Painting\",\"artist_name\":\"Mugambi\",\"artist_email\":\"Mugambi@gmail.com\"}', '{\"title\":\"Nature Landscape\",\"description\":\"Beauty put in art\",\"category_id\":1,\"dimensions\":\"7\\u00d77\",\"medium\":\"Acrylic\",\"year_created\":2025,\"price\":6799}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:55:22'),
(72, 12, 'user_logout', 'users', 12, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:55:50'),
(73, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:56:02'),
(74, 2, 'submission_reviewed', 'submissions', 3, '{\"id\":3,\"artwork_id\":3,\"artist_id\":12,\"status\":\"pending\",\"submission_notes\":\"\",\"review_notes\":null,\"reviewed_by\":null,\"reviewed_at\":null,\"submitted_at\":\"2025-08-21 18:52:01\",\"updated_at\":\"2025-08-21 18:52:01\"}', '{\"status\":\"approved\",\"action\":\"approve\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:57:06'),
(75, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:57:16'),
(76, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 15:57:42'),
(77, NULL, 'user_registered', 'users', 13, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 16:21:05'),
(78, 12, 'user_login', 'users', 12, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 16:22:15'),
(79, 12, 'user_logout', 'users', 12, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 16:22:38'),
(80, 11, 'user_login', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 16:22:45'),
(81, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 16:33:35'),
(82, 11, 'user_logout', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 17:11:47'),
(83, 8, 'user_login', 'users', 8, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 17:11:58'),
(84, 8, 'artwork_deleted', 'artworks', 1, '{\"id\":1,\"title\":\"durban potrait\",\"description\":\"From the port of durban\",\"category_id\":4,\"artist_id\":8,\"image_url\":\"uploads\\/f70c39f23726b62b9989cc4f1a292674.png\",\"thumbnail_url\":\"uploads\\/thumbnails\\/thumb_f70c39f23726b62b9989cc4f1a292674.png\",\"dimensions\":\"12\\u00d78\",\"medium\":\"oil painting\",\"year_created\":\"2025\",\"price\":\"25998.99\",\"status\":\"approved\",\"featured\":1,\"views_count\":11,\"created_at\":\"2025-08-21 17:48:11\",\"updated_at\":\"2025-08-21 20:12:08\",\"category_name\":\"Digital Art\",\"artist_name\":\"Trevor Wanyoike\",\"artist_email\":\"trevor@gmail.com\"}', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 17:12:12'),
(85, 8, 'artwork_created', 'artworks', 4, 'null', '{\"title\":\"Mona Litha\",\"description\":\"The one and only Mona Litha by Da Princi\",\"category_id\":4,\"artist_id\":8,\"image_url\":\"public\\/uploads\\/c2b087932e4b4416f1b9cf891aef9d84.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_c2b087932e4b4416f1b9cf891aef9d84.png\",\"dimensions\":\"12\\u00d715\",\"medium\":\"Digital contemporary art\",\"year_created\":1900,\"price\":99999,\"status\":\"draft\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 17:21:32'),
(86, 8, 'user_logout', 'users', 8, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 17:22:32'),
(87, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 17:22:42'),
(88, 2, 'submission_reviewed', 'submissions', 4, '{\"id\":4,\"artwork_id\":4,\"artist_id\":8,\"status\":\"pending\",\"submission_notes\":\"Kindly consider for Exhibitions and featured artworks\",\"review_notes\":null,\"reviewed_by\":null,\"reviewed_at\":null,\"submitted_at\":\"2025-08-21 20:22:26\",\"updated_at\":\"2025-08-21 20:22:26\"}', '{\"status\":\"approved\",\"action\":\"approve\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 17:23:12'),
(89, 2, 'user_role_changed', 'users', 1, 'null', '{\"new_role\":\"artist\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 18:01:23'),
(90, 2, 'user_role_changed', 'users', 1, 'null', '{\"new_role\":\"staff\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 18:01:31'),
(91, 2, 'artwork_updated', 'artworks', 3, '{\"id\":3,\"title\":\"Nature Landscape\",\"description\":\"Beauty put in art\",\"category_id\":1,\"artist_id\":12,\"image_url\":\"public\\/uploads\\/9359100a130f184a3ab8e429c87c7768.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_9359100a130f184a3ab8e429c87c7768.png\",\"dimensions\":\"7\\u00d77\",\"medium\":\"Acrylic\",\"year_created\":\"2025\",\"price\":\"6799.00\",\"status\":\"approved\",\"featured\":0,\"views_count\":7,\"created_at\":\"2025-08-21 18:39:44\",\"updated_at\":\"2025-08-21 21:02:22\",\"category_name\":\"Painting\",\"artist_name\":\"Mugambi\",\"artist_email\":\"Mugambi@gmail.com\"}', '{\"title\":\"Nature Landscape\",\"description\":\"Beauty put in art\",\"category_id\":1,\"dimensions\":\"7\\u00d77\",\"medium\":\"Acrylic\",\"year_created\":2025,\"price\":6799,\"status\":\"approved\",\"featured\":true}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 18:02:35'),
(92, 2, 'exhibition_created', 'exhibitions', 2, 'null', '{\"name\":\"Matatu culture\",\"description\":\"Our annual matatu art showcasing day.\",\"start_date\":\"2025-08-09\",\"end_date\":\"2025-08-15\",\"featured_image\":\"\",\"created_by\":2,\"status\":\"upcoming\",\"max_artworks\":50}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 18:05:58'),
(93, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 18:29:18'),
(94, 11, 'user_login', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 18:36:16'),
(95, 14, 'user_registered', 'users', 14, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 20:12:19'),
(96, 14, 'user_login', 'users', 14, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 20:12:29'),
(97, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 20:12:55'),
(98, 2, 'exhibition_created', 'exhibitions', 3, 'null', '{\"name\":\"Consultation\",\"description\":\"Final consultation\",\"start_date\":\"2025-08-19\",\"end_date\":\"2025-08-25\",\"featured_image\":\"\",\"created_by\":2,\"status\":\"upcoming\",\"max_artworks\":50}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 20:13:44'),
(99, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 20:13:55'),
(100, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 20:14:26'),
(101, 12, 'user_login', 'users', 12, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 20:35:15'),
(102, 12, 'user_logout', 'users', 12, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 20:35:53'),
(103, 10, 'user_login', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 20:36:01'),
(104, 10, 'user_logout', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 20:36:05'),
(105, 11, 'user_login', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 20:36:19'),
(106, 15, 'user_registered', 'users', 15, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 21:33:38'),
(107, 15, 'user_login', 'users', 15, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-21 21:34:07'),
(108, 15, 'user_logout', 'users', 15, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 03:02:55'),
(109, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 03:03:05'),
(110, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 03:55:21'),
(111, 11, 'user_login', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 04:29:14'),
(112, 11, 'user_logout', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 04:39:19'),
(113, 8, 'user_login', 'users', 8, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 04:39:31'),
(114, 8, 'user_logout', 'users', 8, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 04:55:00'),
(115, 11, 'user_login', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 04:55:08'),
(116, 11, 'user_logout', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 06:33:32'),
(117, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 06:33:42'),
(118, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 06:46:09'),
(119, 16, 'user_registered', 'users', 16, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 06:51:44'),
(120, 16, 'user_login', 'users', 16, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 06:52:40'),
(121, 16, 'artwork_created', 'artworks', 5, 'null', '{\"title\":\"The Scary Night\",\"description\":\"The Scary Night\",\"category_id\":3,\"artist_id\":16,\"image_url\":\"public\\/uploads\\/d025b804c11fd7c4ce8fe57a3da0d844.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_d025b804c11fd7c4ce8fe57a3da0d844.png\",\"dimensions\":\"12\\u00d710\",\"medium\":\"film photography\",\"year_created\":2000,\"price\":5599.99,\"status\":\"draft\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 07:08:12'),
(122, 16, 'artwork_updated', 'artworks', 5, '{\"id\":5,\"title\":\"The Scary Night\",\"description\":\"The Scary Night\",\"category_id\":3,\"artist_id\":16,\"image_url\":\"public\\/uploads\\/d025b804c11fd7c4ce8fe57a3da0d844.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_d025b804c11fd7c4ce8fe57a3da0d844.png\",\"dimensions\":\"12\\u00d710\",\"medium\":\"film photography\",\"year_created\":\"2000\",\"price\":\"5599.99\",\"status\":\"draft\",\"featured\":0,\"views_count\":2,\"created_at\":\"2025-08-22 10:08:12\",\"updated_at\":\"2025-08-22 10:08:27\",\"category_name\":\"Photography\",\"artist_name\":\"Charles\",\"artist_email\":\"nyachae@gmail.com\"}', '{\"title\":\"The Scary Night\",\"description\":\"The Scary Night\",\"category_id\":3,\"dimensions\":\"12\\u00d710\",\"medium\":\"film photography\",\"year_created\":2000,\"price\":5599.99}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 07:08:29'),
(123, 16, 'user_logout', 'users', 16, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 07:09:14'),
(124, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 07:09:27'),
(125, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 07:13:25'),
(126, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 07:18:22'),
(127, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 07:27:56'),
(128, 17, 'user_registered', 'users', 17, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 07:33:32'),
(129, 17, 'user_login', 'users', 17, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 07:33:50'),
(130, 17, 'user_logout', 'users', 17, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 07:37:48'),
(131, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 07:38:28'),
(132, 2, 'artwork_updated', 'artworks', 4, '{\"id\":4,\"title\":\"Mona Litha\",\"description\":\"The one and only Mona Litha by Da Princi\",\"category_id\":4,\"artist_id\":8,\"image_url\":\"public\\/uploads\\/c2b087932e4b4416f1b9cf891aef9d84.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_c2b087932e4b4416f1b9cf891aef9d84.png\",\"dimensions\":\"12\\u00d715\",\"medium\":\"Digital contemporary art\",\"year_created\":\"0000\",\"price\":\"99999.00\",\"status\":\"approved\",\"featured\":0,\"views_count\":14,\"created_at\":\"2025-08-21 20:21:32\",\"updated_at\":\"2025-08-22 10:45:38\",\"category_name\":\"Digital Art\",\"artist_name\":\"Trevor Wanyoike\",\"artist_email\":\"trevor@gmail.com\"}', '{\"title\":\"Mona Litha\",\"description\":\"The one and only Mona Litha by Da Princi\",\"category_id\":4,\"dimensions\":\"12\\u00d715\",\"medium\":\"Digital contemporary art\",\"year_created\":1675,\"price\":99999,\"status\":\"approved\",\"featured\":true}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 07:46:14'),
(133, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 07:48:09'),
(134, 17, 'user_login', 'users', 17, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 07:48:45'),
(135, 17, 'user_logout', 'users', 17, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 07:52:44'),
(136, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 07:52:57'),
(137, 2, 'submission_reviewed', 'submissions', 5, '{\"id\":5,\"artwork_id\":5,\"artist_id\":16,\"status\":\"pending\",\"submission_notes\":\"Consider for upcoming exhibitions.\",\"review_notes\":null,\"reviewed_by\":null,\"reviewed_at\":null,\"submitted_at\":\"2025-08-22 10:08:57\",\"updated_at\":\"2025-08-22 10:08:57\"}', '{\"status\":\"approved\",\"action\":\"approve\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 07:54:46'),
(138, 2, 'user_role_changed', 'users', 1, 'null', '{\"new_role\":\"artist\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 08:04:33'),
(139, 2, 'user_role_changed', 'users', 1, 'null', '{\"new_role\":\"artist\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 08:04:51'),
(140, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 08:05:03'),
(141, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 08:06:52'),
(142, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 08:08:03'),
(143, 17, 'user_login', 'users', 17, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 08:08:17'),
(144, 17, 'user_logout', 'users', 17, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 08:51:03'),
(145, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 08:51:19'),
(146, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 08:51:53'),
(147, 11, 'user_login', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 08:52:11'),
(148, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 10:42:38'),
(149, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 10:47:46'),
(150, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 10:50:09'),
(151, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 10:50:50'),
(152, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 10:53:45'),
(153, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:02:23'),
(154, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:02:28'),
(155, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:02:42'),
(156, 11, 'user_login', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:10:12'),
(157, 11, 'user_logout', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:18:21'),
(158, 8, 'user_login', 'users', 8, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:18:34'),
(159, 8, 'profile_updated', 'users', 8, 'null', '{\"name\":\"Trevor Wanyoike\",\"phone\":\"\",\"bio\":\"\",\"profile_image\":\"public\\/uploads\\/ab43a0820cd637620cb5637c80d0eef3.png\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:19:13'),
(160, 8, 'user_logout', 'users', 8, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:19:26'),
(161, 14, 'user_login', 'users', 14, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:21:24'),
(162, 14, 'user_logout', 'users', 14, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:21:43'),
(163, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:21:50'),
(164, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:22:17'),
(165, 16, 'user_login', 'users', 16, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:22:28'),
(166, 16, 'profile_updated', 'users', 16, 'null', '{\"name\":\"Charles\",\"phone\":\"\",\"bio\":\"\",\"profile_image\":\"public\\/uploads\\/68cd514ac59d256528160feb45aa262d.png\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:23:27'),
(167, 16, 'user_logout', 'users', 16, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:23:30'),
(168, 12, 'user_login', 'users', 12, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:23:38'),
(169, 12, 'profile_updated', 'users', 12, 'null', '{\"name\":\"Mugambi\",\"phone\":\"0783673864\",\"bio\":\"Christ believer\",\"profile_image\":\"public\\/uploads\\/e050c82136a6ca1bae7f5edb48f2e365.png\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:23:53'),
(170, 12, 'user_logout', 'users', 12, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:23:56'),
(171, 9, 'user_login', 'users', 9, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:25:22'),
(172, 9, 'user_logout', 'users', 9, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:25:29'),
(173, 10, 'user_login', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:25:54'),
(174, 10, 'profile_updated', 'users', 10, 'null', '{\"name\":\"musee\",\"phone\":\"\",\"bio\":\"\",\"profile_image\":\"public\\/uploads\\/390bf0c77ef3cd3e115f404394cf427e.png\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:26:14'),
(175, 10, 'user_logout', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:26:17'),
(176, 10, 'user_login', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:31:23'),
(177, 10, 'artwork_created', 'artworks', 6, 'null', '{\"title\":\"Kipchoge Sculpture\",\"description\":\"World champion and multiple time record holder. You&#039;ve got to love it!\",\"category_id\":2,\"artist_id\":10,\"image_url\":\"public\\/uploads\\/ba6240fb87c22b0152753a3b713f6cae.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_ba6240fb87c22b0152753a3b713f6cae.png\",\"dimensions\":\"8\\u00d78\",\"medium\":\"Brass sculpture\",\"year_created\":2025,\"price\":2998.84,\"status\":\"draft\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:34:56'),
(178, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:41:45');
INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `table_name`, `record_id`, `old_values`, `new_values`, `ip_address`, `user_agent`, `created_at`) VALUES
(179, 2, 'submission_reviewed', 'submissions', 6, '{\"id\":6,\"artwork_id\":6,\"artist_id\":10,\"status\":\"pending\",\"submission_notes\":\"Kindly see this.\",\"review_notes\":null,\"reviewed_by\":null,\"reviewed_at\":null,\"submitted_at\":\"2025-08-22 14:43:42\",\"updated_at\":\"2025-08-22 14:43:42\"}', '{\"status\":\"approved\",\"action\":\"approve\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:44:16'),
(180, 10, 'user_logout', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:44:58'),
(181, 10, 'user_login', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:50:31'),
(182, 10, 'artwork_created', 'artworks', 7, 'null', '{\"title\":\"Maasai Women\",\"description\":\"Beautiful women from the Maasai Community.\",\"category_id\":1,\"artist_id\":10,\"image_url\":\"public\\/uploads\\/561e909abb162224c7a043ed48a9ea1d.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_561e909abb162224c7a043ed48a9ea1d.png\",\"dimensions\":\"12\\u00d710\",\"medium\":\"oil painting\",\"year_created\":2022,\"price\":7999,\"status\":\"draft\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:52:10'),
(183, 10, 'profile_updated', 'users', 10, 'null', '{\"name\":\"Musee\",\"phone\":\"\",\"bio\":\"\",\"profile_image\":\"http:\\/\\/localhost\\/usanii_mashariki\\/public\\/uploads\\/390bf0c77ef3cd3e115f404394cf427e.png\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:52:48'),
(184, 10, 'profile_updated', 'users', 10, 'null', '{\"name\":\"Musee\",\"phone\":\"\",\"bio\":\"\",\"profile_image\":\"http:\\/\\/localhost\\/usanii_mashariki\\/public\\/uploads\\/390bf0c77ef3cd3e115f404394cf427e.png\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:52:50'),
(185, 10, 'user_logout', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:53:05'),
(186, 8, 'user_login', 'users', 8, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:54:38'),
(187, 8, 'user_logout', 'users', 8, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:55:03'),
(188, 11, 'user_login', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:55:10'),
(189, 11, 'user_logout', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:59:21'),
(190, 10, 'user_login', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:59:30'),
(191, 10, 'artwork_updated', 'artworks', 7, '{\"id\":7,\"title\":\"Maasai Women\",\"description\":\"Beautiful women from the Maasai Community.\",\"category_id\":1,\"artist_id\":10,\"image_url\":\"public\\/uploads\\/561e909abb162224c7a043ed48a9ea1d.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_561e909abb162224c7a043ed48a9ea1d.png\",\"dimensions\":\"12\\u00d710\",\"medium\":\"oil painting\",\"year_created\":\"2022\",\"price\":\"7999.00\",\"status\":\"submitted\",\"featured\":0,\"views_count\":1,\"created_at\":\"2025-08-22 14:52:10\",\"updated_at\":\"2025-08-22 14:59:39\",\"category_name\":\"Painting\",\"artist_name\":\"Musee\",\"artist_email\":\"musee@gmail.com\"}', '{\"title\":\"Maasai Women\",\"description\":\"Beautiful women from the Maasai Community.\",\"category_id\":1,\"dimensions\":\"12\\u00d710\",\"medium\":\"oil painting\",\"year_created\":2022,\"price\":7999}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 11:59:43'),
(192, 10, 'user_logout', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 12:00:23'),
(193, 2, 'submission_reviewed', 'submissions', 7, '{\"id\":7,\"artwork_id\":7,\"artist_id\":10,\"status\":\"pending\",\"submission_notes\":\"\",\"review_notes\":null,\"reviewed_by\":null,\"reviewed_at\":null,\"submitted_at\":\"2025-08-22 14:52:25\",\"updated_at\":\"2025-08-22 14:52:25\"}', '{\"status\":\"approved\",\"action\":\"approve\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 12:01:59'),
(194, 2, 'artwork_updated', 'artworks', 3, '{\"id\":3,\"title\":\"Nature Landscape\",\"description\":\"Beauty put in art\",\"category_id\":1,\"artist_id\":12,\"image_url\":\"public\\/uploads\\/9359100a130f184a3ab8e429c87c7768.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_9359100a130f184a3ab8e429c87c7768.png\",\"dimensions\":\"7\\u00d77\",\"medium\":\"Acrylic\",\"year_created\":\"2025\",\"price\":\"6799.00\",\"status\":\"approved\",\"featured\":1,\"views_count\":26,\"created_at\":\"2025-08-21 18:39:44\",\"updated_at\":\"2025-08-22 15:02:14\",\"category_name\":\"Painting\",\"artist_name\":\"Mugambi\",\"artist_email\":\"Mugambi@gmail.com\"}', '{\"title\":\"Nature Landscape\",\"description\":\"Beauty put in art\",\"category_id\":1,\"dimensions\":\"7\\u00d77\",\"medium\":\"Acrylic\",\"year_created\":2025,\"price\":6799,\"status\":\"approved\",\"featured\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 12:02:18'),
(195, 2, 'artwork_updated', 'artworks', 6, '{\"id\":6,\"title\":\"Kipchoge Sculpture\",\"description\":\"World champion and multiple time record holder. You&#039;ve got to love it!\",\"category_id\":2,\"artist_id\":10,\"image_url\":\"public\\/uploads\\/ba6240fb87c22b0152753a3b713f6cae.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_ba6240fb87c22b0152753a3b713f6cae.png\",\"dimensions\":\"8\\u00d78\",\"medium\":\"Brass sculpture\",\"year_created\":\"2025\",\"price\":\"2998.84\",\"status\":\"approved\",\"featured\":0,\"views_count\":1,\"created_at\":\"2025-08-22 14:34:56\",\"updated_at\":\"2025-08-22 15:02:24\",\"category_name\":\"Sculpture\",\"artist_name\":\"Musee\",\"artist_email\":\"musee@gmail.com\"}', '{\"title\":\"Kipchoge Sculpture\",\"description\":\"World champion and multiple time record holder. You&amp;#039;ve got to love it!\",\"category_id\":2,\"dimensions\":\"8\\u00d78\",\"medium\":\"Brass sculpture\",\"year_created\":2025,\"price\":2998.84,\"status\":\"approved\",\"featured\":true}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 12:02:27'),
(196, 2, 'artwork_updated', 'artworks', 7, '{\"id\":7,\"title\":\"Maasai Women\",\"description\":\"Beautiful women from the Maasai Community.\",\"category_id\":1,\"artist_id\":10,\"image_url\":\"public\\/uploads\\/561e909abb162224c7a043ed48a9ea1d.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_561e909abb162224c7a043ed48a9ea1d.png\",\"dimensions\":\"12\\u00d710\",\"medium\":\"oil painting\",\"year_created\":\"2022\",\"price\":\"7999.00\",\"status\":\"approved\",\"featured\":0,\"views_count\":3,\"created_at\":\"2025-08-22 14:52:10\",\"updated_at\":\"2025-08-22 15:02:31\",\"category_name\":\"Painting\",\"artist_name\":\"Musee\",\"artist_email\":\"musee@gmail.com\"}', '{\"title\":\"Maasai Women\",\"description\":\"Beautiful women from the Maasai Community.\",\"category_id\":1,\"dimensions\":\"12\\u00d710\",\"medium\":\"oil painting\",\"year_created\":2022,\"price\":7999,\"status\":\"approved\",\"featured\":true}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 12:02:35'),
(197, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 12:02:43'),
(198, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 19:17:17'),
(199, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 19:53:43'),
(200, 10, 'user_login', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 19:57:29'),
(201, 10, 'user_logout', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 19:59:00'),
(202, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 19:59:27'),
(203, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 20:04:39'),
(204, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 20:06:38'),
(205, 11, 'user_login', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-22 21:42:49'),
(206, 11, 'user_logout', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-23 05:07:35'),
(207, 12, 'user_login', 'users', 12, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-23 05:08:09'),
(208, 12, 'artwork_created', 'artworks', 8, 'null', '{\"title\":\"Albert Einstein\",\"description\":\"Albert Einstein digital art\",\"category_id\":4,\"artist_id\":12,\"image_url\":\"public\\/uploads\\/1abc90d07eac97925b91be26f16fc9d8.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_1abc90d07eac97925b91be26f16fc9d8.png\",\"dimensions\":\"12\\u00d710\",\"medium\":\"Computer-generated art\",\"year_created\":2025,\"price\":8499.87,\"status\":\"draft\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-23 05:10:38'),
(209, 12, 'artwork_created', 'artworks', 9, 'null', '{\"title\":\"Woven Mat\",\"description\":\"Indigenous Kenyan Mat\",\"category_id\":5,\"artist_id\":12,\"image_url\":\"public\\/uploads\\/356886265e103f068011541520e06b99.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_356886265e103f068011541520e06b99.png\",\"dimensions\":\"10\\u00d710\",\"medium\":\"Indeginous art\",\"year_created\":2025,\"price\":2500,\"status\":\"draft\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-23 05:12:44'),
(210, 12, 'artwork_created', 'artworks', 10, 'null', '{\"title\":\"Test reject\",\"description\":\"Testing reject art\",\"category_id\":1,\"artist_id\":12,\"image_url\":\"public\\/uploads\\/472eb61f48a7a78d4c248ba29b85a3d7.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_472eb61f48a7a78d4c248ba29b85a3d7.png\",\"dimensions\":\"12\\u00d78\",\"medium\":\"Oil painting\",\"year_created\":2024,\"price\":6784.9,\"status\":\"draft\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-23 05:13:47'),
(211, 12, 'user_logout', 'users', 12, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-23 05:13:58'),
(212, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-23 05:14:07'),
(213, 2, 'submission_reviewed', 'submissions', 10, '{\"id\":10,\"artwork_id\":10,\"artist_id\":12,\"status\":\"pending\",\"submission_notes\":\"\",\"review_notes\":null,\"reviewed_by\":null,\"reviewed_at\":null,\"submitted_at\":\"2025-08-23 08:13:51\",\"updated_at\":\"2025-08-23 08:13:51\"}', '{\"status\":\"rejected\",\"action\":\"reject\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-23 05:14:18'),
(214, 2, 'submission_reviewed', 'submissions', 9, '{\"id\":9,\"artwork_id\":9,\"artist_id\":12,\"status\":\"pending\",\"submission_notes\":\"\",\"review_notes\":null,\"reviewed_by\":null,\"reviewed_at\":null,\"submitted_at\":\"2025-08-23 08:12:53\",\"updated_at\":\"2025-08-23 08:12:53\"}', '{\"status\":\"approved\",\"action\":\"approve\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-23 05:14:24'),
(215, 2, 'submission_reviewed', 'submissions', 8, '{\"id\":8,\"artwork_id\":8,\"artist_id\":12,\"status\":\"pending\",\"submission_notes\":\"\",\"review_notes\":null,\"reviewed_by\":null,\"reviewed_at\":null,\"submitted_at\":\"2025-08-23 08:10:46\",\"updated_at\":\"2025-08-23 08:10:46\"}', '{\"status\":\"approved\",\"action\":\"approve\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-23 05:14:30'),
(216, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-23 05:15:01'),
(217, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-23 05:16:07'),
(218, 10, 'user_login', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-23 05:17:01'),
(219, 10, 'user_logout', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-23 05:19:08'),
(220, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-23 05:19:16'),
(221, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-23 05:26:32'),
(222, 18, 'user_registered', 'users', 18, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-24 12:41:11'),
(223, 18, 'user_login', 'users', 18, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-24 12:41:28'),
(224, 18, 'user_logout', 'users', 18, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-24 12:43:12'),
(225, 10, 'user_login', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-24 12:43:22'),
(226, 10, 'artwork_updated', 'artworks', 6, '{\"id\":6,\"title\":\"Kipchoge Sculpture\",\"description\":\"World champion and multiple time record holder. You&amp;#039;ve got to love it!\",\"category_id\":2,\"artist_id\":10,\"image_url\":\"public\\/uploads\\/ba6240fb87c22b0152753a3b713f6cae.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_ba6240fb87c22b0152753a3b713f6cae.png\",\"dimensions\":\"8\\u00d78\",\"medium\":\"Brass sculpture\",\"year_created\":\"2025\",\"price\":\"2998.84\",\"status\":\"approved\",\"featured\":1,\"views_count\":2,\"created_at\":\"2025-08-22 14:34:56\",\"updated_at\":\"2025-08-24 15:43:27\",\"category_name\":\"Sculpture\",\"artist_name\":\"Musee\",\"artist_email\":\"musee@gmail.com\"}', '{\"title\":\"Kipchoge Sculpture\",\"description\":\"World champion and multiple time record holder. You&#039;ve got to love it!\",\"category_id\":2,\"dimensions\":\"8\\u00d78\",\"medium\":\"Brass sculpture\",\"year_created\":2025,\"price\":2998.84}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-24 12:43:41'),
(227, 10, 'user_logout', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-24 14:26:32'),
(228, 19, 'user_registered', 'users', 19, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-24 14:27:55'),
(229, 19, 'user_login', 'users', 19, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-24 14:28:16'),
(230, 19, 'user_logout', 'users', 19, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-24 14:29:57'),
(231, 10, 'user_login', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-24 14:30:08'),
(232, 10, 'artwork_created', 'artworks', 11, 'null', '{\"title\":\"Screenshot\",\"description\":\"Test Screenshot\",\"category_id\":4,\"artist_id\":10,\"image_url\":\"public\\/uploads\\/463136239d65d2740e3fa9f4c94470d4.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_463136239d65d2740e3fa9f4c94470d4.png\",\"dimensions\":\"5\\u00d75\",\"medium\":\"Photo\",\"year_created\":2025,\"price\":6775.83,\"status\":\"draft\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-24 14:32:08'),
(233, 10, 'user_logout', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-24 14:32:20'),
(234, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-24 14:32:30'),
(235, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-24 14:33:08'),
(236, 10, 'user_login', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-24 14:33:16'),
(237, 10, 'user_logout', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-24 14:33:48'),
(238, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-24 14:34:00'),
(239, 2, 'submission_reviewed', 'submissions', 11, '{\"id\":11,\"artwork_id\":11,\"artist_id\":10,\"status\":\"pending\",\"submission_notes\":\"Please consider for featured artwork\",\"review_notes\":null,\"reviewed_by\":null,\"reviewed_at\":null,\"submitted_at\":\"2025-08-24 17:33:43\",\"updated_at\":\"2025-08-24 17:33:43\"}', '{\"status\":\"approved\",\"action\":\"approve\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-24 14:34:47'),
(240, 2, 'user_role_changed', 'users', 19, 'null', '{\"new_role\":\"staff\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-24 14:35:26'),
(241, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-24 14:35:47'),
(242, 19, 'user_login', 'users', 19, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-24 14:37:24'),
(243, 19, 'user_logout', 'users', 19, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-25 18:19:46'),
(244, 20, 'user_registered', 'users', 20, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-25 18:21:23'),
(245, 20, 'user_login', 'users', 20, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-25 18:26:22'),
(246, 20, 'user_logout', 'users', 20, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-25 18:29:03'),
(247, 10, 'user_login', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-25 18:29:19'),
(248, 10, 'user_logout', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-25 18:31:07'),
(249, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-25 18:31:18'),
(250, 2, 'artwork_updated', 'artworks', 8, '{\"id\":8,\"title\":\"Albert Einstein\",\"description\":\"Albert Einstein digital art\",\"category_id\":4,\"artist_id\":12,\"image_url\":\"public\\/uploads\\/1abc90d07eac97925b91be26f16fc9d8.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_1abc90d07eac97925b91be26f16fc9d8.png\",\"dimensions\":\"12\\u00d710\",\"medium\":\"Computer-generated art\",\"year_created\":\"2025\",\"price\":\"8499.87\",\"status\":\"approved\",\"featured\":0,\"views_count\":1,\"created_at\":\"2025-08-23 08:10:38\",\"updated_at\":\"2025-08-25 21:32:04\",\"category_name\":\"Digital Art\",\"artist_name\":\"Mugambi\",\"artist_email\":\"Mugambi@gmail.com\"}', '{\"title\":\"Albert Einstein\",\"description\":\"Albert Einstein digital art\",\"category_id\":4,\"dimensions\":\"12\\u00d710\",\"medium\":\"Computer-generated art\",\"year_created\":2025,\"price\":8499.87,\"status\":\"approved\",\"featured\":true}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-25 18:32:09'),
(251, 2, 'user_role_changed', 'users', 20, 'null', '{\"new_role\":\"staff\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-25 18:32:52'),
(252, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-25 18:33:02'),
(253, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-26 07:40:16'),
(254, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-26 07:40:24'),
(255, 21, 'user_registered', 'users', 21, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-26 07:58:30'),
(256, 21, 'user_login', 'users', 21, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-26 07:58:45'),
(257, 21, 'user_logout', 'users', 21, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-26 07:59:03'),
(258, 22, 'user_registered', 'users', 22, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-26 07:59:44'),
(259, 22, 'user_login', 'users', 22, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-26 07:59:57'),
(260, 22, 'artwork_created', 'artworks', 12, 'null', '{\"title\":\"MonaLisa\",\"description\":\"Original Leonardo Da Vince\",\"category_id\":4,\"artist_id\":22,\"image_url\":\"public\\/uploads\\/19d044495703d67cd205baa8c7649b2a.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_19d044495703d67cd205baa8c7649b2a.png\",\"dimensions\":\"8\\u00d78\",\"medium\":\"film photography\",\"year_created\":2025,\"price\":700,\"status\":\"draft\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-26 08:03:01'),
(261, 22, 'user_logout', 'users', 22, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-26 08:04:07'),
(262, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-26 08:04:23'),
(263, 2, 'submission_reviewed', 'submissions', 12, '{\"id\":12,\"artwork_id\":12,\"artist_id\":22,\"status\":\"pending\",\"submission_notes\":\"Test2\",\"review_notes\":null,\"reviewed_by\":null,\"reviewed_at\":null,\"submitted_at\":\"2025-08-26 11:03:44\",\"updated_at\":\"2025-08-26 11:03:44\"}', '{\"status\":\"approved\",\"action\":\"approve\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-26 08:04:59'),
(264, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-26 08:06:26'),
(265, 22, 'user_login', 'users', 22, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-26 08:06:44'),
(266, 22, 'user_logout', 'users', 22, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-26 08:06:49'),
(267, 21, 'user_login', 'users', 21, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-26 08:07:01'),
(268, 21, 'user_logout', 'users', 21, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-26 08:10:49'),
(269, 23, 'user_registered', 'users', 23, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-26 09:42:43'),
(270, 23, 'user_login', 'users', 23, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-26 09:42:57'),
(271, 23, 'user_logout', 'users', 23, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-26 09:44:48'),
(272, 10, 'user_login', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-26 09:45:13'),
(273, 10, 'user_logout', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-27 17:30:22'),
(274, 24, 'user_registered', 'users', 24, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-27 17:34:13'),
(275, 24, 'user_login', 'users', 24, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-27 17:34:28'),
(276, 24, 'user_logout', 'users', 24, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-27 17:45:28'),
(277, 10, 'user_login', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-27 17:45:47'),
(278, 10, 'user_logout', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-27 17:47:21'),
(279, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-27 17:47:38'),
(280, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-27 17:49:37'),
(281, 24, 'user_login', 'users', 24, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 21:56:57'),
(282, 24, 'user_logout', 'users', 24, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 21:57:26'),
(283, 11, 'user_login', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 21:57:33'),
(284, 11, 'user_logout', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 22:39:51'),
(285, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 22:40:05'),
(286, 2, 'artwork_updated', 'artworks', 11, '{\"id\":11,\"title\":\"Screenshot\",\"description\":\"Test Screenshot\",\"category_id\":4,\"artist_id\":10,\"image_url\":\"public\\/uploads\\/463136239d65d2740e3fa9f4c94470d4.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_463136239d65d2740e3fa9f4c94470d4.png\",\"dimensions\":\"5\\u00d75\",\"medium\":\"Photo\",\"year_created\":\"2025\",\"price\":\"6775.83\",\"status\":\"approved\",\"featured\":0,\"views_count\":3,\"created_at\":\"2025-08-24 17:32:08\",\"updated_at\":\"2025-08-29 01:40:21\",\"category_name\":\"Digital Art\",\"artist_name\":\"Musee\",\"artist_email\":\"musee@gmail.com\"}', '{\"title\":\"Screenshot\",\"description\":\"Test Screenshot\",\"category_id\":4,\"dimensions\":\"5\\u00d75\",\"medium\":\"Photo\",\"year_created\":2025,\"price\":6775.83,\"status\":\"rejected\",\"featured\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 22:40:28'),
(287, 2, 'artwork_updated', 'artworks', 12, '{\"id\":12,\"title\":\"MonaLisa\",\"description\":\"Original Leonardo Da Vince\",\"category_id\":4,\"artist_id\":22,\"image_url\":\"public\\/uploads\\/19d044495703d67cd205baa8c7649b2a.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_19d044495703d67cd205baa8c7649b2a.png\",\"dimensions\":\"8\\u00d78\",\"medium\":\"film photography\",\"year_created\":\"2025\",\"price\":\"700.00\",\"status\":\"approved\",\"featured\":0,\"views_count\":3,\"created_at\":\"2025-08-26 11:03:01\",\"updated_at\":\"2025-08-29 01:40:33\",\"category_name\":\"Digital Art\",\"artist_name\":\"James Wambaya\",\"artist_email\":\"WambayaJ@gmail.com\"}', '{\"title\":\"MonaLisa\",\"description\":\"Original Leonardo Da Vince\",\"category_id\":4,\"dimensions\":\"8\\u00d78\",\"medium\":\"film photography\",\"year_created\":2025,\"price\":700,\"status\":\"rejected\",\"featured\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 22:40:39'),
(288, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 22:55:29'),
(289, 11, 'user_login', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 22:55:42'),
(290, 11, 'user_logout', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 23:04:35'),
(291, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 23:04:48'),
(292, 2, 'artwork_updated', 'artworks', 8, '{\"id\":8,\"title\":\"Albert Einstein\",\"description\":\"Albert Einstein digital art\",\"category_id\":4,\"artist_id\":12,\"image_url\":\"public\\/uploads\\/1abc90d07eac97925b91be26f16fc9d8.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_1abc90d07eac97925b91be26f16fc9d8.png\",\"dimensions\":\"12\\u00d710\",\"medium\":\"Computer-generated art\",\"year_created\":\"2025\",\"price\":\"8499.87\",\"status\":\"approved\",\"featured\":1,\"views_count\":3,\"created_at\":\"2025-08-23 08:10:38\",\"updated_at\":\"2025-08-29 02:04:55\",\"category_name\":\"Digital Art\",\"artist_name\":\"Mugambi\",\"artist_email\":\"Mugambi@gmail.com\"}', '{\"title\":\"Albert Einstein\",\"description\":\"Albert Einstein digital art\",\"category_id\":4,\"dimensions\":\"12\\u00d710\",\"medium\":\"Computer-generated art\",\"year_created\":2025,\"price\":1,\"status\":\"approved\",\"featured\":true}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 23:05:01'),
(293, 2, 'artwork_updated', 'artworks', 4, '{\"id\":4,\"title\":\"Mona Litha\",\"description\":\"The one and only Mona Litha by Da Princi\",\"category_id\":4,\"artist_id\":8,\"image_url\":\"public\\/uploads\\/c2b087932e4b4416f1b9cf891aef9d84.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_c2b087932e4b4416f1b9cf891aef9d84.png\",\"dimensions\":\"12\\u00d715\",\"medium\":\"Digital contemporary art\",\"year_created\":\"0000\",\"price\":\"99999.00\",\"status\":\"approved\",\"featured\":1,\"views_count\":20,\"created_at\":\"2025-08-21 20:21:32\",\"updated_at\":\"2025-08-29 02:05:16\",\"category_name\":\"Digital Art\",\"artist_name\":\"Trevor Wanyoike\",\"artist_email\":\"trevor@gmail.com\"}', '{\"title\":\"Mona Litha\",\"description\":\"The one and only Mona Litha by Da Princi\",\"category_id\":4,\"dimensions\":\"12\\u00d715\",\"medium\":\"Digital contemporary art\",\"year_created\":2025,\"status\":\"approved\",\"featured\":true}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 23:05:35'),
(294, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 23:05:42'),
(295, 11, 'user_login', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 23:05:54'),
(296, NULL, 'artwork_updated', 'artworks', 8, '{\"id\":8,\"title\":\"Albert Einstein\",\"description\":\"Albert Einstein digital art\",\"category_id\":4,\"artist_id\":12,\"image_url\":\"public\\/uploads\\/1abc90d07eac97925b91be26f16fc9d8.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_1abc90d07eac97925b91be26f16fc9d8.png\",\"dimensions\":\"12\\u00d710\",\"medium\":\"Computer-generated art\",\"year_created\":\"2025\",\"price\":\"1.00\",\"status\":\"approved\",\"featured\":1,\"views_count\":11,\"created_at\":\"2025-08-23 08:10:38\",\"updated_at\":\"2025-08-29 02:06:43\",\"category_name\":\"Digital Art\",\"artist_name\":\"Mugambi\",\"artist_email\":\"Mugambi@gmail.com\"}', '{\"status\":\"sold\"}', '', '', '2025-08-28 23:39:30'),
(297, 11, 'user_logout', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 23:45:20'),
(298, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 23:45:31'),
(299, 18, 'user_login', 'users', 18, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 23:46:09'),
(300, 18, 'user_logout', 'users', 18, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 23:46:49'),
(301, 10, 'user_login', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 23:47:38'),
(302, 10, 'artwork_created', 'artworks', 13, 'null', '{\"title\":\"Jomo Kenyatta\",\"description\":\"First president of the republic of Kenya and father of the nation.\",\"category_id\":3,\"artist_id\":10,\"image_url\":\"public\\/uploads\\/5cb43416f4e0ceb4f66c51969a4e9106.jpg\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_5cb43416f4e0ceb4f66c51969a4e9106.jpg\",\"dimensions\":\"10\\u00d78\",\"medium\":\"Black and white\",\"year_created\":2022,\"price\":0,\"status\":\"draft\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 23:51:18'),
(303, 10, 'user_logout', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 23:52:34'),
(304, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 23:52:48'),
(305, 2, 'submission_reviewed', 'submissions', 14, '{\"id\":14,\"artwork_id\":13,\"artist_id\":10,\"status\":\"pending\",\"submission_notes\":\"\",\"review_notes\":null,\"reviewed_by\":null,\"reviewed_at\":null,\"submitted_at\":\"2025-08-29 02:51:28\",\"updated_at\":\"2025-08-29 02:51:28\"}', '{\"status\":\"approved\",\"action\":\"approve\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 23:52:59'),
(306, 2, 'artwork_updated', 'artworks', 6, '{\"id\":6,\"title\":\"Kipchoge Sculpture\",\"description\":\"World champion and multiple time record holder. You&#039;ve got to love it!\",\"category_id\":2,\"artist_id\":10,\"image_url\":\"public\\/uploads\\/ba6240fb87c22b0152753a3b713f6cae.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_ba6240fb87c22b0152753a3b713f6cae.png\",\"dimensions\":\"8\\u00d78\",\"medium\":\"Brass sculpture\",\"year_created\":\"2025\",\"price\":\"2998.84\",\"status\":\"approved\",\"featured\":1,\"views_count\":5,\"created_at\":\"2025-08-22 14:34:56\",\"updated_at\":\"2025-08-29 02:53:16\",\"category_name\":\"Sculpture\",\"artist_name\":\"Musee\",\"artist_email\":\"musee@gmail.com\"}', '{\"title\":\"Kipchoge Sculpture\",\"description\":\"World champion and multiple time record holder. You&amp;#039;ve got to love it!\",\"category_id\":2,\"dimensions\":\"8\\u00d78\",\"medium\":\"Brass sculpture\",\"year_created\":2025,\"status\":\"approved\",\"featured\":true}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 23:53:22'),
(307, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 23:53:31'),
(308, 14, 'user_login', 'users', 14, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-28 23:53:43'),
(309, 14, 'user_logout', 'users', 14, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 00:09:59'),
(310, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 00:10:08'),
(311, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 06:47:30'),
(312, 11, 'user_login', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 06:48:34'),
(313, 11, 'user_logout', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 06:48:47'),
(314, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 07:28:12'),
(315, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 07:28:37'),
(316, 22, 'user_login', 'users', 22, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 07:29:29'),
(317, 22, 'user_logout', 'users', 22, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 07:29:49'),
(318, 10, 'user_login', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 07:31:03'),
(319, 10, 'profile_updated', 'users', 10, 'null', '{\"name\":\"Musee Musee\",\"phone\":\"\",\"bio\":\"\",\"profile_image\":\"http:\\/\\/localhost\\/usanii_mashariki\\/public\\/uploads\\/390bf0c77ef3cd3e115f404394cf427e.png\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 07:31:47'),
(320, 10, 'user_logout', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 07:36:27'),
(321, 25, 'user_registered', 'users', 25, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 07:42:16'),
(322, 25, 'user_login', 'users', 25, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 07:42:28'),
(323, 25, 'user_logout', 'users', 25, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 07:46:27'),
(324, 25, 'user_login', 'users', 25, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 07:51:58'),
(325, 25, 'user_logout', 'users', 25, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 07:52:20'),
(326, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 07:54:12'),
(327, 2, 'artwork_updated', 'artworks', 13, '{\"id\":13,\"title\":\"Jomo Kenyatta\",\"description\":\"First president of the republic of Kenya and father of the nation.\",\"category_id\":3,\"artist_id\":10,\"image_url\":\"public\\/uploads\\/5cb43416f4e0ceb4f66c51969a4e9106.jpg\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_5cb43416f4e0ceb4f66c51969a4e9106.jpg\",\"dimensions\":\"10\\u00d78\",\"medium\":\"Black and white\",\"year_created\":\"2022\",\"price\":\"5000.00\",\"status\":\"approved\",\"featured\":0,\"views_count\":6,\"created_at\":\"2025-08-29 02:51:18\",\"updated_at\":\"2025-08-29 10:55:02\",\"category_name\":\"Photography\",\"artist_name\":\"Musee Musee\",\"artist_email\":\"musee@gmail.com\"}', '{\"title\":\"Jomo Kenyatta\",\"description\":\"First president of the republic of Kenya and father of the nation.\",\"category_id\":3,\"dimensions\":\"10\\u00d78\",\"medium\":\"Black and white\",\"year_created\":2022,\"price\":3,\"status\":\"approved\",\"featured\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 07:55:08'),
(328, 2, 'artwork_updated', 'artworks', 13, '{\"id\":13,\"title\":\"Jomo Kenyatta\",\"description\":\"First president of the republic of Kenya and father of the nation.\",\"category_id\":3,\"artist_id\":10,\"image_url\":\"public\\/uploads\\/5cb43416f4e0ceb4f66c51969a4e9106.jpg\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_5cb43416f4e0ceb4f66c51969a4e9106.jpg\",\"dimensions\":\"10\\u00d78\",\"medium\":\"Black and white\",\"year_created\":\"2022\",\"price\":\"3.00\",\"status\":\"approved\",\"featured\":0,\"views_count\":7,\"created_at\":\"2025-08-29 02:51:18\",\"updated_at\":\"2025-08-29 10:55:12\",\"category_name\":\"Photography\",\"artist_name\":\"Musee Musee\",\"artist_email\":\"musee@gmail.com\"}', '{\"title\":\"Jomo Kenyatta\",\"description\":\"First president of the republic of Kenya and father of the nation.\",\"category_id\":3,\"dimensions\":\"10\\u00d78\",\"medium\":\"Black and white\",\"year_created\":2022,\"price\":3,\"status\":\"approved\",\"featured\":true}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 07:55:18'),
(329, 2, 'artwork_updated', 'artworks', 13, '{\"id\":13,\"title\":\"Jomo Kenyatta\",\"description\":\"First president of the republic of Kenya and father of the nation.\",\"category_id\":3,\"artist_id\":10,\"image_url\":\"public\\/uploads\\/5cb43416f4e0ceb4f66c51969a4e9106.jpg\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_5cb43416f4e0ceb4f66c51969a4e9106.jpg\",\"dimensions\":\"10\\u00d78\",\"medium\":\"Black and white\",\"year_created\":\"2022\",\"price\":\"3.00\",\"status\":\"approved\",\"featured\":1,\"views_count\":7,\"created_at\":\"2025-08-29 02:51:18\",\"updated_at\":\"2025-08-29 10:55:18\",\"category_name\":\"Photography\",\"artist_name\":\"Musee Musee\",\"artist_email\":\"musee@gmail.com\"}', '{\"title\":\"Jomo Kenyatta\",\"description\":\"First president of the republic of Kenya and father of the nation.\",\"category_id\":3,\"dimensions\":\"10\\u00d78\",\"medium\":\"Black and white\",\"year_created\":2022,\"price\":3,\"status\":\"approved\",\"featured\":true}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 07:55:18'),
(330, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 07:55:36'),
(331, 22, 'user_login', 'users', 22, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 07:55:59'),
(332, 22, 'user_logout', 'users', 22, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 07:56:12'),
(333, 18, 'user_login', 'users', 18, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 07:56:43'),
(334, 18, 'user_logout', 'users', 18, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 08:10:44');
INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `table_name`, `record_id`, `old_values`, `new_values`, `ip_address`, `user_agent`, `created_at`) VALUES
(335, 26, 'user_registered', 'users', 26, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 08:21:45'),
(336, 26, 'user_login', 'users', 26, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 08:21:53'),
(337, 26, 'artwork_created', 'artworks', 14, 'null', '{\"title\":\"Cool Dogo\",\"description\":\"Coolest dog in the world\",\"category_id\":4,\"artist_id\":26,\"image_url\":\"public\\/uploads\\/ce01364e21765f6b780c18de8b619cc3.png\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_ce01364e21765f6b780c18de8b619cc3.png\",\"dimensions\":\"12\\u00d78\",\"medium\":\"oil painting\",\"year_created\":2025,\"price\":2,\"status\":\"draft\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 08:24:01'),
(338, 26, 'user_logout', 'users', 26, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 08:24:17'),
(339, 27, 'user_registered', 'users', 27, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 08:25:08'),
(340, 27, 'user_login', 'users', 27, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 08:25:17'),
(341, 27, 'user_logout', 'users', 27, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 08:25:34'),
(342, 27, 'user_login', 'users', 27, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 08:27:40'),
(343, 27, 'user_logout', 'users', 27, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 08:27:44'),
(344, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 08:27:56'),
(345, 2, 'submission_reviewed', 'submissions', 15, '{\"id\":15,\"artwork_id\":14,\"artist_id\":26,\"status\":\"pending\",\"submission_notes\":\"For the test\",\"review_notes\":null,\"reviewed_by\":null,\"reviewed_at\":null,\"submitted_at\":\"2025-08-29 11:24:13\",\"updated_at\":\"2025-08-29 11:24:13\"}', '{\"status\":\"approved\",\"action\":\"approve\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 08:28:16'),
(346, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 08:28:29'),
(347, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 08:30:06'),
(348, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 08:30:12'),
(349, 26, 'user_login', 'users', 26, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 08:30:36'),
(350, 26, 'user_logout', 'users', 26, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 08:30:39'),
(351, 26, 'user_login', 'users', 26, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 08:50:02'),
(352, 26, 'user_logout', 'users', 26, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 08:50:06'),
(353, 11, 'user_login', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 08:50:16'),
(354, 11, 'user_logout', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 13:25:35'),
(355, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 13:26:10'),
(356, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 13:29:48'),
(357, 28, 'user_registered', 'users', 28, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 13:33:00'),
(358, 28, 'user_login', 'users', 28, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 13:33:14'),
(359, 11, 'user_login', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-12 14:07:10'),
(360, 11, 'user_logout', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-12 14:28:53'),
(361, 10, 'user_login', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-12 14:29:11'),
(362, 10, 'artwork_created', 'artworks', 15, 'null', '{\"title\":\"Sunset soccer\",\"description\":\"Sunset soccer photo\",\"category_id\":3,\"artist_id\":10,\"image_url\":\"public\\/uploads\\/94c04ec1c39e5a99259a529ada9789b3.jpeg\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_94c04ec1c39e5a99259a529ada9789b3.jpeg\",\"dimensions\":\"5\\u00d75\",\"medium\":\"Photo\",\"year_created\":2025,\"price\":20,\"status\":\"draft\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-12 14:32:27'),
(363, 10, 'user_logout', 'users', 10, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-12 14:34:04'),
(364, 11, 'user_login', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-12 14:34:17'),
(365, 11, 'user_logout', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-12 14:34:28'),
(366, 2, 'user_login', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-12 14:34:37'),
(367, 2, 'submission_reviewed', 'submissions', 16, '{\"id\":16,\"artwork_id\":15,\"artist_id\":10,\"status\":\"pending\",\"submission_notes\":\"Consider for featured artwork please.\",\"review_notes\":null,\"reviewed_by\":null,\"reviewed_at\":null,\"submitted_at\":\"2025-09-12 17:33:52\",\"updated_at\":\"2025-09-12 17:33:52\"}', '{\"status\":\"approved\",\"action\":\"approve\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-12 14:35:12'),
(368, 2, 'artwork_updated', 'artworks', 15, '{\"id\":15,\"title\":\"Sunset soccer\",\"description\":\"Sunset soccer photo\",\"category_id\":3,\"artist_id\":10,\"image_url\":\"public\\/uploads\\/94c04ec1c39e5a99259a529ada9789b3.jpeg\",\"thumbnail_url\":\"public\\/uploads\\/thumbnails\\/thumb_94c04ec1c39e5a99259a529ada9789b3.jpeg\",\"dimensions\":\"5\\u00d75\",\"medium\":\"Photo\",\"year_created\":\"2025\",\"price\":\"20.00\",\"status\":\"approved\",\"featured\":0,\"views_count\":1,\"created_at\":\"2025-09-12 17:32:27\",\"updated_at\":\"2025-09-12 17:35:23\",\"category_name\":\"Photography\",\"artist_name\":\"Musee Musee\",\"artist_email\":\"musee@gmail.com\"}', '{\"title\":\"Sunset soccer\",\"description\":\"Sunset soccer photo\",\"category_id\":3,\"dimensions\":\"5\\u00d75\",\"medium\":\"Photo\",\"year_created\":2025,\"price\":20,\"status\":\"approved\",\"featured\":true}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-12 14:35:28'),
(369, 2, 'user_logout', 'users', 2, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-12 14:38:29'),
(370, 11, 'user_login', 'users', 11, 'null', 'null', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-12 14:38:44');

-- --------------------------------------------------------

--
-- Table structure for table `artist_profiles`
--

CREATE TABLE `artist_profiles` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `bio` text DEFAULT NULL,
  `portfolio_url` varchar(255) DEFAULT NULL,
  `socials_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`socials_json`)),
  `location` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `artist_profiles`
--

INSERT INTO `artist_profiles` (`id`, `user_id`, `bio`, `portfolio_url`, `socials_json`, `location`, `created_at`, `updated_at`) VALUES
(2, 6, 'Artist profile for msanii', NULL, NULL, NULL, '2025-08-29 00:03:50', '2025-08-29 00:03:50'),
(3, 8, 'Artist profile for Trevor Wanyoike', NULL, NULL, NULL, '2025-08-29 00:03:50', '2025-08-29 00:03:50'),
(4, 10, 'Artist profile for Musee', NULL, NULL, NULL, '2025-08-29 00:03:50', '2025-08-29 00:03:50'),
(5, 12, 'Artist profile for Mugambi', NULL, NULL, NULL, '2025-08-29 00:03:50', '2025-08-29 00:03:50'),
(6, 16, 'Artist profile for Charles', NULL, NULL, NULL, '2025-08-29 00:03:50', '2025-08-29 00:03:50'),
(7, 22, 'Artist profile for James Wambaya', NULL, NULL, NULL, '2025-08-29 00:03:50', '2025-08-29 00:03:50');

-- --------------------------------------------------------

--
-- Table structure for table `artworks`
--

CREATE TABLE `artworks` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `artist_id` int(11) NOT NULL,
  `image_url` varchar(500) NOT NULL,
  `thumbnail_url` varchar(500) DEFAULT NULL,
  `dimensions` varchar(50) DEFAULT NULL,
  `medium` varchar(100) DEFAULT NULL,
  `year_created` year(4) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `status` enum('draft','submitted','approved','rejected','sold') DEFAULT 'draft',
  `featured` tinyint(1) DEFAULT 0,
  `views_count` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `artworks`
--

INSERT INTO `artworks` (`id`, `title`, `description`, `category_id`, `artist_id`, `image_url`, `thumbnail_url`, `dimensions`, `medium`, `year_created`, `price`, `status`, `featured`, `views_count`, `created_at`, `updated_at`) VALUES
(2, 'Big 5', 'The big 5 animals', 1, 10, 'uploads/5c3c30ccdac1c16e7e453c99904a54c3.jpg', 'uploads/thumbnails/thumb_5c3c30ccdac1c16e7e453c99904a54c3.jpg', '5×5', 'Hand painting', '2025', 5000.00, 'approved', 1, 66, '2025-08-21 15:22:30', '2025-08-28 22:55:47'),
(3, 'Nature Landscape', 'Beauty put in art', 1, 12, 'public/uploads/9359100a130f184a3ab8e429c87c7768.png', 'public/uploads/thumbnails/thumb_9359100a130f184a3ab8e429c87c7768.png', '7×7', 'Acrylic', '2025', 6799.00, 'approved', 0, 26, '2025-08-21 15:39:44', '2025-08-22 12:02:18'),
(4, 'Mona Litha', 'The one and only Mona Litha by Da Princi', 4, 8, 'public/uploads/c2b087932e4b4416f1b9cf891aef9d84.png', 'public/uploads/thumbnails/thumb_c2b087932e4b4416f1b9cf891aef9d84.png', '12×15', 'Digital contemporary art', '2025', 99999.00, 'approved', 1, 20, '2025-08-21 17:21:32', '2025-08-28 23:05:35'),
(5, 'The Scary Night', 'The Scary Night', 3, 16, 'public/uploads/d025b804c11fd7c4ce8fe57a3da0d844.png', 'public/uploads/thumbnails/thumb_d025b804c11fd7c4ce8fe57a3da0d844.png', '12×10', 'film photography', '2000', 5599.99, 'approved', 0, 7, '2025-08-22 07:08:12', '2025-08-22 10:52:14'),
(6, 'Kipchoge Sculpture', 'World champion and multiple time record holder. You&amp;#039;ve got to love it!', 2, 10, 'public/uploads/ba6240fb87c22b0152753a3b713f6cae.png', 'public/uploads/thumbnails/thumb_ba6240fb87c22b0152753a3b713f6cae.png', '8×8', 'Brass sculpture', '2025', 2998.84, 'approved', 1, 17, '2025-08-22 11:34:56', '2025-08-29 13:38:18'),
(7, 'Maasai Women', 'Beautiful women from the Maasai Community.', 1, 10, 'public/uploads/561e909abb162224c7a043ed48a9ea1d.png', 'public/uploads/thumbnails/thumb_561e909abb162224c7a043ed48a9ea1d.png', '12×10', 'oil painting', '2022', 7999.00, 'approved', 1, 9, '2025-08-22 11:52:10', '2025-08-29 13:36:07'),
(8, 'Albert Einstein', 'Albert Einstein digital art', 4, 12, 'public/uploads/1abc90d07eac97925b91be26f16fc9d8.png', 'public/uploads/thumbnails/thumb_1abc90d07eac97925b91be26f16fc9d8.png', '12×10', 'Computer-generated art', '2025', 1.00, 'sold', 1, 13, '2025-08-23 05:10:38', '2025-08-28 23:53:09'),
(9, 'Woven Mat', 'Indigenous Kenyan Mat', 5, 12, 'public/uploads/356886265e103f068011541520e06b99.png', 'public/uploads/thumbnails/thumb_356886265e103f068011541520e06b99.png', '10×10', 'Indeginous art', '2025', 2500.00, 'approved', 0, 19, '2025-08-23 05:12:44', '2025-09-12 14:09:07'),
(10, 'Test reject', 'Testing reject art', 1, 12, 'public/uploads/472eb61f48a7a78d4c248ba29b85a3d7.png', 'public/uploads/thumbnails/thumb_472eb61f48a7a78d4c248ba29b85a3d7.png', '12×8', 'Oil painting', '2024', 6784.90, 'rejected', 0, 0, '2025-08-23 05:13:47', '2025-08-23 05:14:18'),
(11, 'Screenshot', 'Test Screenshot', 4, 10, 'public/uploads/463136239d65d2740e3fa9f4c94470d4.png', 'public/uploads/thumbnails/thumb_463136239d65d2740e3fa9f4c94470d4.png', '5×5', 'Photo', '2025', 6775.83, 'submitted', 0, 3, '2025-08-24 14:32:08', '2025-08-28 23:47:52'),
(12, 'MonaLisa', 'Original Leonardo Da Vince', 4, 22, 'public/uploads/19d044495703d67cd205baa8c7649b2a.png', 'public/uploads/thumbnails/thumb_19d044495703d67cd205baa8c7649b2a.png', '8×8', 'film photography', '2025', 700.00, 'rejected', 0, 3, '2025-08-26 08:03:01', '2025-08-28 22:40:39'),
(13, 'Jomo Kenyatta', 'First president of the republic of Kenya and father of the nation.', 3, 10, 'public/uploads/5cb43416f4e0ceb4f66c51969a4e9106.jpg', 'public/uploads/thumbnails/thumb_5cb43416f4e0ceb4f66c51969a4e9106.jpg', '10×8', 'Black and white', '2022', 3.00, 'approved', 1, 71, '2025-08-28 23:51:18', '2025-09-12 14:42:23'),
(14, 'Cool Dogo', 'Coolest dog in the world', 4, 26, 'public/uploads/ce01364e21765f6b780c18de8b619cc3.png', 'public/uploads/thumbnails/thumb_ce01364e21765f6b780c18de8b619cc3.png', '12×8', 'oil painting', '2025', 2.00, 'approved', 0, 57, '2025-08-29 08:24:01', '2025-09-12 14:12:25'),
(15, 'Sunset soccer', 'Sunset soccer photo', 3, 10, 'public/uploads/94c04ec1c39e5a99259a529ada9789b3.jpeg', 'public/uploads/thumbnails/thumb_94c04ec1c39e5a99259a529ada9789b3.jpeg', '5×5', 'Photo', '2025', 20.00, 'approved', 1, 6, '2025-09-12 14:32:27', '2025-09-12 14:39:27');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Painting', 'Oil paintings, watercolors, acrylics, and mixed media paintings', '2025-08-17 19:51:55', '2025-08-17 19:51:55'),
(2, 'Sculpture', '3D artworks in various materials including stone, metal, wood, and clay', '2025-08-17 19:51:55', '2025-08-17 19:51:55'),
(3, 'Photography', 'Digital and film photography, black and white and color', '2025-08-17 19:51:55', '2025-08-17 19:51:55'),
(4, 'Digital Art', 'Computer-generated art, digital illustrations, and multimedia', '2025-08-17 19:51:55', '2025-08-17 19:51:55'),
(5, 'Traditional Art', 'Indigenous and traditional art forms', '2025-08-17 19:51:55', '2025-08-17 19:51:55'),
(6, 'Contemporary', 'Modern contemporary artworks and installations', '2025-08-17 19:51:55', '2025-08-17 19:51:55');

-- --------------------------------------------------------

--
-- Table structure for table `email_outbox`
--

CREATE TABLE `email_outbox` (
  `id` int(11) NOT NULL,
  `to_email` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `status` enum('queued','sent','failed') DEFAULT 'queued',
  `error_message` text DEFAULT NULL,
  `retry_count` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `sent_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `email_outbox`
--

INSERT INTO `email_outbox` (`id`, `to_email`, `subject`, `body`, `status`, `error_message`, `retry_count`, `created_at`, `sent_at`) VALUES
(1, 'allanwambua9912@gmail.com', 'Your enquiry has been received - Usanii Mashariki', 'Hello allan,<br />\n<br />\nThank you for your interest in the artwork. We have received your enquiry and will contact you shortly.<br />\n<br />\nRegards,<br />\nUsanii Mashariki', 'queued', NULL, 0, '2025-08-22 06:28:30', NULL),
(2, 'viewer@gmail.com', 'Your enquiry has been received - Usanii Mashariki', 'Hello Test,<br />\n<br />\nThank you for your interest in the artwork. We have received your enquiry and will contact you shortly.<br />\n<br />\nRegards,<br />\nUsanii Mashariki', 'queued', NULL, 0, '2025-08-22 06:33:08', NULL),
(3, 'bigO@gmail.com', 'Your enquiry has been received - Usanii Mashariki', 'Hello Obi,<br />\n<br />\nThank you for your interest in the artwork. We have received your enquiry and will contact you shortly.<br />\n<br />\nRegards,<br />\nUsanii Mashariki', 'queued', NULL, 0, '2025-08-22 07:36:25', NULL),
(4, 'allanwambua9912@gmail.com', 'Your enquiry has been received - Usanii Mashariki', 'Hello Allan Wambua,<br />\n<br />\nThank you for your interest in the artwork. We have received your enquiry and will contact you shortly.<br />\n<br />\nRegards,<br />\nUsanii Mashariki', 'queued', NULL, 0, '2025-08-22 11:56:25', NULL),
(5, 'testuser@gmail.com', 'Your enquiry has been received - Usanii Mashariki', 'Hello TestUser,<br />\n<br />\nThank you for your interest in the artwork. We have received your enquiry and will contact you shortly.<br />\n<br />\nRegards,<br />\nUsanii Mashariki', 'queued', NULL, 0, '2025-08-26 08:09:12', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `enquiries`
--

CREATE TABLE `enquiries` (
  `id` int(11) NOT NULL,
  `artwork_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `enquiries`
--

INSERT INTO `enquiries` (`id`, `artwork_id`, `name`, `email`, `phone`, `message`, `created_at`) VALUES
(1, 2, 'allan', 'allanwambua9912@gmail.com', '0790855665', 'Can I get this', '2025-08-22 06:28:30'),
(2, 2, 'Test', 'viewer@gmail.com', '0790855665', 'I love Kenya and this reminds me of it.', '2025-08-22 06:33:08'),
(3, 4, 'Obi', 'bigO@gmail.com', '0790855665', 'Not for that price though', '2025-08-22 07:36:25'),
(4, 4, 'Allan Wambua', 'allanwambua9912@gmail.com', '0790855665', 'I love this', '2025-08-22 11:56:25'),
(5, 12, 'TestUser', 'testuser@gmail.com', '0790855746', 'I love this one!', '2025-08-26 08:09:12');

-- --------------------------------------------------------

--
-- Table structure for table `exhibitions`
--

CREATE TABLE `exhibitions` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `featured_image` varchar(500) DEFAULT NULL,
  `status` enum('upcoming','active','completed','cancelled') DEFAULT 'upcoming',
  `created_by` int(11) NOT NULL,
  `max_artworks` int(11) DEFAULT 50,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

--
-- Dumping data for table `exhibitions`
--

INSERT INTO `exhibitions` (`id`, `name`, `description`, `start_date`, `end_date`, `featured_image`, `status`, `created_by`, `max_artworks`, `created_at`, `updated_at`) VALUES
(1, 'Grand Opening', 'Official launch of the management system', '2025-08-24', '2025-08-31', '', 'completed', 2, 50, '2025-08-20 02:07:42', '2025-09-12 14:07:12'),
(2, 'Matatu culture', 'Our annual matatu art showcasing day.', '2025-08-09', '2025-08-15', '', 'completed', 2, 50, '2025-08-21 18:05:58', '2025-08-21 18:05:58'),
(3, 'Consultation', 'Final consultation', '2025-08-19', '2025-08-25', '', 'completed', 2, 50, '2025-08-21 20:13:44', '2025-08-26 07:40:19');

-- --------------------------------------------------------

--
-- Table structure for table `exhibition_artworks`
--

CREATE TABLE `exhibition_artworks` (
  `id` int(11) NOT NULL,
  `exhibition_id` int(11) NOT NULL,
  `artwork_id` int(11) NOT NULL,
  `display_order` int(11) DEFAULT 0,
  `added_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `exhibition_artworks`
--

INSERT INTO `exhibition_artworks` (`id`, `exhibition_id`, `artwork_id`, `display_order`, `added_at`) VALUES
(1, 1, 2, 0, '2025-08-21 20:33:51'),
(3, 1, 3, 0, '2025-08-21 20:33:58'),
(4, 1, 4, 0, '2025-08-21 20:33:58'),
(5, 1, 5, 0, '2025-08-22 07:43:33'),
(6, 3, 2, 0, '2025-08-22 07:44:02'),
(7, 3, 5, 0, '2025-08-22 07:44:17'),
(8, 3, 4, 0, '2025-08-22 07:44:26'),
(9, 2, 5, 0, '2025-08-22 07:54:27'),
(10, 1, 12, 0, '2025-08-26 08:06:14'),
(11, 1, 15, 0, '2025-09-12 14:37:19');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `artwork_id` int(11) NOT NULL,
  `buyer_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `checkout_request_id` varchar(100) DEFAULT NULL,
  `merchant_request_id` varchar(100) DEFAULT NULL,
  `mpesa_receipt_number` varchar(50) DEFAULT NULL,
  `status` enum('pending','processing','completed','failed','cancelled') DEFAULT 'pending',
  `payment_method` enum('mpesa') DEFAULT 'mpesa',
  `transaction_description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `completed_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `artwork_id`, `buyer_id`, `amount`, `phone_number`, `checkout_request_id`, `merchant_request_id`, `mpesa_receipt_number`, `status`, `payment_method`, `transaction_description`, `created_at`, `updated_at`, `completed_at`) VALUES
(8, 8, 11, 1.00, '0790855665', 'ws_CO_290820250206179790855665', 'e220-4004-8311-59daec3452ca63098', NULL, 'processing', 'mpesa', NULL, '2025-08-28 23:06:17', '2025-08-28 23:06:19', NULL),
(11, 13, 18, 3.00, '0790855665', NULL, NULL, NULL, 'failed', 'mpesa', 'STK push failed', '2025-08-29 07:57:16', '2025-08-29 07:57:16', NULL),
(12, 13, 18, 3.00, '0790855665', NULL, NULL, NULL, 'failed', 'mpesa', 'STK push failed', '2025-08-29 07:57:35', '2025-08-29 07:57:35', NULL),
(13, 13, 18, 3.00, '0790855665', 'ws_CO_290820251109575790855665', '1b55-42d9-8b63-384f5c34309b12281', NULL, 'failed', 'mpesa', 'Request Cancelled by user.', '2025-08-29 08:09:57', '2025-08-29 08:10:08', NULL),
(14, 13, 11, 3.00, '0721374616', 'ws_CO_290820251153078721374616', '1b55-42d9-8b63-384f5c34309b12779', NULL, 'failed', 'mpesa', 'Request Cancelled by user.', '2025-08-29 08:53:05', '2025-08-29 08:53:19', NULL),
(15, 6, 11, 2998.84, '0792352751', 'ws_CO_290820251623455792352751', '3440-42c2-9f92-6d73a1ed9db22851', NULL, 'processing', 'mpesa', NULL, '2025-08-29 13:23:42', '2025-08-29 13:23:45', NULL),
(16, 13, 28, 3.00, '079556001', NULL, NULL, NULL, 'failed', 'mpesa', 'STK push failed', '2025-08-29 13:34:39', '2025-08-29 13:34:40', NULL),
(17, 13, 28, 3.00, '079556001', NULL, NULL, NULL, 'failed', 'mpesa', 'STK push failed', '2025-08-29 13:34:51', '2025-08-29 13:34:53', NULL),
(18, 13, 28, 3.00, '0792352751', 'ws_CO_290820251635084792352751', 'f54a-4486-81ba-4bab593898a445048', NULL, 'processing', 'mpesa', NULL, '2025-08-29 13:35:06', '2025-08-29 13:35:08', NULL),
(19, 14, 11, 2.00, '0707757397', 'ws_CO_120920251708325707757397', 'b8ae-4f7c-b56b-875ff450c56c39080', NULL, 'processing', 'mpesa', NULL, '2025-09-12 14:08:28', '2025-09-12 14:08:31', NULL),
(20, 14, 11, 2.00, '0707757397', 'ws_CO_120920251709302707757397', '5dce-4124-8b76-032ef06f4c0b6914', NULL, 'processing', 'mpesa', NULL, '2025-09-12 14:09:26', '2025-09-12 14:09:29', NULL),
(21, 15, 11, 20.00, '0790855665', 'ws_CO_120920251739124790855665', 'afa9-427a-82b0-d44e80b7ee4451443', NULL, 'processing', 'mpesa', NULL, '2025-09-12 14:39:09', '2025-09-12 14:39:11', NULL),
(22, 13, 11, 3.00, '0790855665', 'ws_CO_120920251740018790855665', 'b8ae-4f7c-b56b-875ff450c56c39269', NULL, 'processing', 'mpesa', NULL, '2025-09-12 14:39:58', '2025-09-12 14:40:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_history`
--

CREATE TABLE `purchase_history` (
  `id` int(11) NOT NULL,
  `payment_id` int(11) NOT NULL,
  `artwork_id` int(11) NOT NULL,
  `buyer_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `purchase_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `submissions`
--

CREATE TABLE `submissions` (
  `id` int(11) NOT NULL,
  `artwork_id` int(11) NOT NULL,
  `artist_id` int(11) NOT NULL,
  `status` enum('pending','under_review','approved','rejected','needs_revision') DEFAULT 'pending',
  `submission_notes` text DEFAULT NULL,
  `review_notes` text DEFAULT NULL,
  `reviewed_by` int(11) DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `submissions`
--

INSERT INTO `submissions` (`id`, `artwork_id`, `artist_id`, `status`, `submission_notes`, `review_notes`, `reviewed_by`, `reviewed_at`, `submitted_at`, `updated_at`) VALUES
(2, 2, 10, 'approved', '', '', 2, '2025-08-21 15:24:35', '2025-08-21 15:23:00', '2025-08-21 15:24:35'),
(3, 3, 12, 'approved', '', '', 2, '2025-08-21 15:57:06', '2025-08-21 15:52:01', '2025-08-21 15:57:06'),
(4, 4, 8, 'approved', 'Kindly consider for Exhibitions and featured artworks', 'Ok, noted.', 2, '2025-08-21 17:23:12', '2025-08-21 17:22:26', '2025-08-21 17:23:12'),
(5, 5, 16, 'approved', 'Consider for upcoming exhibitions.', '', 2, '2025-08-22 07:54:46', '2025-08-22 07:08:57', '2025-08-22 07:54:46'),
(6, 6, 10, 'approved', 'Kindly see this.', 'Nice piece!', 2, '2025-08-22 11:44:16', '2025-08-22 11:43:42', '2025-08-22 11:44:16'),
(7, 7, 10, 'approved', '', 'Beautiful art.', 2, '2025-08-22 12:01:59', '2025-08-22 11:52:25', '2025-08-22 12:01:59'),
(8, 8, 12, 'approved', '', '', 2, '2025-08-23 05:14:30', '2025-08-23 05:10:46', '2025-08-23 05:14:30'),
(9, 9, 12, 'approved', '', '', 2, '2025-08-23 05:14:24', '2025-08-23 05:12:53', '2025-08-23 05:14:24'),
(10, 10, 12, 'rejected', '', '', 2, '2025-08-23 05:14:18', '2025-08-23 05:13:51', '2025-08-23 05:14:18'),
(11, 11, 10, 'pending', '', 'Ok, noted', 2, '2025-08-24 14:34:47', '2025-08-28 23:47:52', '2025-08-28 23:47:52'),
(12, 12, 22, 'approved', 'Test2', 'Good one!', 2, '2025-08-26 08:04:59', '2025-08-26 08:03:44', '2025-08-26 08:04:59'),
(14, 13, 10, 'approved', '', '', 2, '2025-08-28 23:52:59', '2025-08-28 23:51:28', '2025-08-28 23:52:59'),
(15, 14, 26, 'approved', 'For the test', '', 2, '2025-08-29 08:28:16', '2025-08-29 08:24:13', '2025-08-29 08:28:16'),
(16, 15, 10, 'approved', 'Consider for featured artwork please.', 'Noted!', 2, '2025-09-12 14:35:12', '2025-09-12 14:33:52', '2025-09-12 14:35:12');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('staff','artist','visitor') NOT NULL DEFAULT 'visitor',
  `phone` varchar(20) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `email_verified` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `phone`, `bio`, `profile_image`, `status`, `email_verified`, `created_at`, `updated_at`) VALUES
(1, 'Gallery Admin', 'admin@usaniimashariki.gallery', '$2y$12$LQv3c1ydiCr7taTGAzEefuSIfL2xNjY6dTCHPTU1qMyfcJO5OwFp6', 'artist', NULL, NULL, NULL, 'active', 1, '2025-08-17 19:52:28', '2025-08-22 08:04:33'),
(2, 'Allan Wambua', 'allanwambua@gmail.com', '$2y$12$0X/zB/DITRt.DHyYq1nL.eddajTrreg5j/xyWkjvsz9Dc9jh3o5EC', 'staff', NULL, NULL, NULL, 'active', 0, '2025-08-19 17:30:38', '2025-08-19 20:51:51'),
(6, 'msanii', 'msanii@gmail.com', '$2y$12$NOFpba3YAc/26TUlWew7J.Hltdh77Www5iYeAUwq4wl3nTwHeNtuK', 'artist', NULL, NULL, NULL, 'active', 0, '2025-08-19 17:46:01', '2025-08-19 17:46:01'),
(7, 'Ken', 'Walibora@gmail.com', '$2y$12$FUJ91smA862DtvtmbUiPp.rVxvVOPyAHcRaUZ6HtnJXLNOS2mk.3m', 'visitor', NULL, NULL, NULL, 'active', 0, '2025-08-19 19:53:08', '2025-08-19 19:53:08'),
(8, 'Trevor Wanyoike', 'trevor@gmail.com', '$2y$12$n64RGK2RngufaFMWQxh2q.42SPMzvfwKMLQslXOHeI5Ns4UBi8aMK', 'artist', '', '', 'public/uploads/ab43a0820cd637620cb5637c80d0eef3.png', 'active', 0, '2025-08-20 08:37:12', '2025-08-22 11:19:13'),
(9, 'kariuki', 'mwangi@gmail.com', '$2y$12$QpPSEjDGpswj8HTNjuixIO3mDKwbEfWM1YTQQhkaAVgMG3gX.VbJm', 'visitor', NULL, NULL, NULL, 'active', 0, '2025-08-21 15:15:59', '2025-08-21 15:15:59'),
(10, 'Musee Musee', 'musee@gmail.com', '$2y$12$gaF3ZiBHTQZeW0pSlCZlyejKTMvNC4TNu6w6f7WpyZb4kpXBI7.NS', 'artist', '', '', 'http://localhost/usanii_mashariki/public/uploads/390bf0c77ef3cd3e115f404394cf427e.png', 'active', 0, '2025-08-21 15:18:07', '2025-08-29 07:31:47'),
(11, 'Viewer', 'Viewer@gmail.com', '$2y$12$qwuX82m/U9HqOJ6ovGM6feru3gSN4NFCnx8tfvlGEwsheyxcmfWW.', 'visitor', NULL, NULL, NULL, 'active', 0, '2025-08-21 15:26:10', '2025-08-21 15:26:10'),
(12, 'Mugambi', 'Mugambi@gmail.com', '$2y$12$8bXRDkiHgYjC3D2XNdhwCOw6W2HoDzgN268UWNubMncdlFmXaWPgK', 'artist', '0783673864', 'Christ believer', 'public/uploads/e050c82136a6ca1bae7f5edb48f2e365.png', 'active', 0, '2025-08-21 15:34:59', '2025-08-22 11:23:53'),
(14, 'Meeks', 'big@gmail.com', '$2y$12$JmhkDq89TELRyXXihPDbKeYxnRNObNsw8aHfnJtsYmdrzZfXEqCzO', 'visitor', NULL, NULL, NULL, 'active', 0, '2025-08-21 20:12:19', '2025-08-21 20:12:19'),
(15, 'austin', 'odhiambo@gmail.com', '$2y$12$FIbBucS6OxApIywOEBXY2uq0UqQdcwlIrAR7dfWgtL6flss/ZIfGS', 'visitor', NULL, NULL, NULL, 'active', 0, '2025-08-21 21:33:38', '2025-08-21 21:33:38'),
(16, 'Charles', 'nyachae@gmail.com', '$2y$12$Jrwj32GUi2E6GscuZCqQtewouu0XYiRJ69yHDlalkuH20H8Rl9DF2', 'artist', '', '', 'public/uploads/68cd514ac59d256528160feb45aa262d.png', 'active', 0, '2025-08-22 06:51:44', '2025-08-22 11:23:27'),
(17, 'Dobi', 'bigO@gmail.com', '$2y$12$0TqkuHWlFcVqt2tf36xXVOJn4JCPXm398DS6k2Oi28tNXszV.ExOy', 'visitor', NULL, NULL, NULL, 'active', 0, '2025-08-22 07:33:32', '2025-08-22 07:33:32'),
(18, 'Sunday', 'funday@gmail.com', '$2y$12$2FzwqorvGPMMScGnmamnkuDiMmreFIY/JRd5FFhAbfZckaDC/TfDa', 'visitor', NULL, NULL, NULL, 'active', 0, '2025-08-24 12:41:11', '2025-08-24 12:41:11'),
(19, 'Florence', 'wambua12@gmail.com', '$2y$12$7AOHT4ucvenpzJMeTxo1K.r/M8/jdTNsxkuvf/cZQ7WlWYOB3vbIS', 'staff', NULL, NULL, NULL, 'active', 0, '2025-08-24 14:27:55', '2025-08-24 14:35:26'),
(20, 'Lewis', 'lewi@gmail.com', '$2y$12$D2LDN8ecDV7gfGjvWdHqVu.69wy2Q9PSfMG9vraOG91Hx3kTG46su', 'staff', NULL, NULL, NULL, 'active', 0, '2025-08-25 18:21:23', '2025-08-25 18:32:52'),
(21, '12354', 'wambaya@gmail.com', '$2y$12$Yq7fh6yBkD77B1ANH61Vj.1dseO2FnxYBkZipe9tjsiTGP8YajME2', 'visitor', NULL, NULL, NULL, 'active', 0, '2025-08-26 07:58:30', '2025-08-26 07:58:30'),
(22, 'James Wambaya', 'WambayaJ@gmail.com', '$2y$12$AZWedWSrbkLIZnd6JfaatO37UUVXPbPQFHfC2d9uQIM.bNRRItCOu', 'artist', NULL, NULL, NULL, 'active', 0, '2025-08-26 07:59:44', '2025-08-26 07:59:44'),
(23, 'Allan Kairu Nguwa', 'kairunguwa@gmail.com', '$2y$12$VUKiGsy.gGoqMq1Ov4H8X.ID8fSkkWFENvRWX/qKKKgrK/CcETMzO', 'visitor', NULL, NULL, NULL, 'active', 0, '2025-08-26 09:42:43', '2025-08-26 09:42:43'),
(24, 'Annie', 'annie@gmail.com', '$2y$12$GULXmfaWtN8r8m5VvwxMHugULtxFEHWOB9Ix4smOHkxeYW5CKW0du', 'visitor', NULL, NULL, NULL, 'active', 0, '2025-08-27 17:34:13', '2025-08-27 17:34:13'),
(25, 'Pres Nate', 'pressday@gmail.com', '$2y$12$pPNP8jdIJDKhmorU6ySUwecJq/cMwx8AkP6uajqibpEmjmf6OYcPS', 'visitor', NULL, NULL, NULL, 'active', 0, '2025-08-29 07:42:16', '2025-08-29 07:42:16'),
(26, 'Kara Nan', 'Knan@gmail.com', '$2y$12$DsCzLZcU9o6gzP5bG0OHIuFvfoDmZbM0LfJA095s68bYbX2zfjYDu', 'artist', NULL, NULL, NULL, 'active', 0, '2025-08-29 08:21:45', '2025-08-29 08:21:45'),
(27, 'Big Spend', 'Bspend@gmail.com', '$2y$12$8eT7OwxBOaPPW/sHVxdPX.54CXuyaohtTUtZkxqrxBykaGAeY8ZiO', 'visitor', NULL, NULL, NULL, 'active', 0, '2025-08-29 08:25:08', '2025-08-29 08:25:08'),
(28, 'mithell makena', 'allanwambuare@gmail.com', '$2y$12$uqrpezKbXj9QYNUTXwrvn.yfnzXvg.QKdBiOCIdUKdiUKuaBHVFTC', 'visitor', NULL, NULL, NULL, 'active', 0, '2025-08-29 13:33:00', '2025-08-29 13:33:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_action` (`action`),
  ADD KEY `idx_table` (`table_name`),
  ADD KEY `idx_created` (`created_at`);

--
-- Indexes for table `artist_profiles`
--
ALTER TABLE `artist_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `artworks`
--
ALTER TABLE `artworks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_artist` (`artist_id`),
  ADD KEY `idx_category` (`category_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_featured` (`featured`),
  ADD KEY `idx_title` (`title`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `idx_name` (`name`);

--
-- Indexes for table `email_outbox`
--
ALTER TABLE `email_outbox`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `enquiries`
--
ALTER TABLE `enquiries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_artwork_id` (`artwork_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `exhibitions`
--
ALTER TABLE `exhibitions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_dates` (`start_date`,`end_date`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_created_by` (`created_by`);

--
-- Indexes for table `exhibition_artworks`
--
ALTER TABLE `exhibition_artworks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_exhibition_artwork` (`exhibition_id`,`artwork_id`),
  ADD KEY `idx_exhibition_id` (`exhibition_id`),
  ADD KEY `idx_artwork_id` (`artwork_id`),
  ADD KEY `idx_display_order` (`display_order`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_artwork_id` (`artwork_id`),
  ADD KEY `idx_buyer_id` (`buyer_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_checkout_request_id` (`checkout_request_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `purchase_history`
--
ALTER TABLE `purchase_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payment_id` (`payment_id`),
  ADD KEY `idx_artwork_id` (`artwork_id`),
  ADD KEY `idx_buyer_id` (`buyer_id`),
  ADD KEY `idx_seller_id` (`seller_id`),
  ADD KEY `idx_purchase_date` (`purchase_date`);

--
-- Indexes for table `submissions`
--
ALTER TABLE `submissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_artwork_submission` (`artwork_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_artist` (`artist_id`),
  ADD KEY `idx_reviewer` (`reviewed_by`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_role` (`role`),
  ADD KEY `idx_status` (`status`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=371;

--
-- AUTO_INCREMENT for table `artist_profiles`
--
ALTER TABLE `artist_profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `artworks`
--
ALTER TABLE `artworks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `email_outbox`
--
ALTER TABLE `email_outbox`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `enquiries`
--
ALTER TABLE `enquiries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `exhibitions`
--
ALTER TABLE `exhibitions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exhibition_artworks`
--
ALTER TABLE `exhibition_artworks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `purchase_history`
--
ALTER TABLE `purchase_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `submissions`
--
ALTER TABLE `submissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `artist_profiles`
--
ALTER TABLE `artist_profiles`
  ADD CONSTRAINT `artist_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `artworks`
--
ALTER TABLE `artworks`
  ADD CONSTRAINT `artworks_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `artworks_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `enquiries`
--
ALTER TABLE `enquiries`
  ADD CONSTRAINT `enquiries_ibfk_1` FOREIGN KEY (`artwork_id`) REFERENCES `artworks` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `exhibitions`
--
ALTER TABLE `exhibitions`
  ADD CONSTRAINT `exhibitions_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `exhibition_artworks`
--
ALTER TABLE `exhibition_artworks`
  ADD CONSTRAINT `exhibition_artworks_ibfk_1` FOREIGN KEY (`exhibition_id`) REFERENCES `exhibitions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `exhibition_artworks_ibfk_2` FOREIGN KEY (`artwork_id`) REFERENCES `artworks` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`artwork_id`) REFERENCES `artworks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `purchase_history`
--
ALTER TABLE `purchase_history`
  ADD CONSTRAINT `purchase_history_ibfk_1` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_history_ibfk_2` FOREIGN KEY (`artwork_id`) REFERENCES `artworks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_history_ibfk_3` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_history_ibfk_4` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `submissions`
--
ALTER TABLE `submissions`
  ADD CONSTRAINT `submissions_ibfk_1` FOREIGN KEY (`artwork_id`) REFERENCES `artworks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `submissions_ibfk_2` FOREIGN KEY (`artist_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `submissions_ibfk_3` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
