-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th8 31, 2025 lúc 02:36 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `we2go_database`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `events`
--

CREATE TABLE `events` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `title` varchar(255) DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `images` text DEFAULT NULL,
  `min_price` double DEFAULT NULL,
  `organizer_id` char(36) DEFAULT NULL,
  `time_start` datetime DEFAULT NULL,
  `time_end` datetime DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `venue` varchar(255) DEFAULT NULL,
  `status` enum('UPCOMING','ONGOING','COMPLETED','CANCELLED') DEFAULT NULL,
  `alias` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `events`
--

INSERT INTO `events` (`id`, `title`, `description`, `images`, `min_price`, `organizer_id`, `time_start`, `time_end`, `location`, `venue`, `status`, `alias`, `created_at`, `updated_at`) VALUES
('753df965-79c5-47db-b9e6-54e0708cebba', 'PiperFlow Platform', '<h1>&nbsp;</h1>\r\n\r\n<h2><strong><a href=\"https://specials-images.forbesimg.com/imageserve/682ac3c2d2a741da509390ac/960x0.jpg\"><img alt=\"\" src=\"https://specials-images.forbesimg.com/imageserve/682ac3c2d2a741da509390ac/960x0.jpg\" /></a><br />\r\n<br />\r\nThe Future is AI</strong></h2>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i ti&ecirc;n phong trong thế hệ tiếp theo của tự động h&oacute;a dựa tr&ecirc;n AI. Nền tảng của ch&uacute;ng t&ocirc;i gi&uacute;p doanh nghiệp x&acirc;y dựng quy tr&igrave;nh th&ocirc;ng minh m&agrave; kh&ocirc;ng cần lập tr&igrave;nh phức tạp, đưa AI ti&ecirc;n tiến đến gần hơn với mọi người.</p>\r\n\r\n<p>Từ chatbot đơn giản cho đến c&aacute;c quy tr&igrave;nh ph&acirc;n t&iacute;ch dữ liệu phức tạp, giao diện k&eacute;o-thả trực quan gi&uacute;p bạn dễ d&agrave;ng x&acirc;y dựng, triển khai v&agrave; mở rộng c&aacute;c giải ph&aacute;p AI mang lại gi&aacute; trị thực sự cho doanh nghiệp.</p>\r\n\r\n<h3>&nbsp;</h3>\r\n', 'https://res.cloudinary.com/dtzbyruu1/image/upload/v1756567550/We2Go%20Upload/ukwv4qlmkooccqbrhciy.png', 0, NULL, '2025-08-23 10:03:00', '2025-08-26 10:04:00', 'Đường A, phường B, Thành Phố Hồ Chí Minh', 'Trung tâm sự kiện ABC', 'UPCOMING', 'piperflow-platform', '2025-08-30 02:46:58', '2025-08-31 11:49:44');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `event_categories`
--

CREATE TABLE `event_categories` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `event_id` char(36) DEFAULT NULL,
  `category_id` char(36) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tickets`
--

CREATE TABLE `tickets` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `name` varchar(255) NOT NULL,
  `zone_id` char(36) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `sold` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tickets`
--

INSERT INTO `tickets` (`id`, `name`, `zone_id`, `price`, `quantity`, `sold`, `created_at`, `updated_at`) VALUES
('168e15a2-2f42-4d9a-bd2e-802b03100d4f', 'STANDAR', 'c7ff0588-0467-42dc-be24-ddf58ba2fabc', 200000.00, 1000, 0, '2025-08-31 11:12:25', '2025-08-31 11:48:18'),
('372c59a3-a7cb-43dc-8e4e-fd2ce7dd4d23', 'Vé 1', '19d0e285-8fea-469a-8f0e-fdbc47c445ee', 100000.00, 0, 0, '2025-08-31 11:15:34', '2025-08-31 11:47:17'),
('7bfc0d81-f491-43f5-97c5-f23fea0e40ad', 'VIP', 'c7ff0588-0467-42dc-be24-ddf58ba2fabc', 600000.00, 100, 0, '2025-08-31 11:15:33', '2025-08-31 11:48:18');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role` enum('USER','ADMIN') DEFAULT 'USER',
  `sessions_key` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `avatar`, `email`, `phone`, `role`, `sessions_key`, `created_at`, `updated_at`, `password`) VALUES
('db334de5-5ed9-42a0-b3af-ab7cb183dac5', 'Nguyễn', 'Hải', '', 'hainguyen0112358@gmail.com', '0879299627', 'USER', NULL, '2025-08-31 19:10:10', '2025-08-31 19:10:10', 'scrypt:32768:8:1$lwvlSHVnm7mogD6j$1f0735229eee93f778253c1265fdeb028317fd4cc18dcc38f2c6ab03e96ce0e6b792ffc1ca11f5a5cdfab2fea3eb76926c6aa9f7985ef1f5dda41c24b853376d');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `zones`
--

CREATE TABLE `zones` (
  `id` char(36) NOT NULL,
  `event_id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` enum('STAND','SEAT') NOT NULL,
  `description` text DEFAULT NULL,
  `capacity` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `zones`
--

INSERT INTO `zones` (`id`, `event_id`, `name`, `type`, `description`, `capacity`, `created_at`, `updated_at`) VALUES
('19d0e285-8fea-469a-8f0e-fdbc47c445ee', '753df965-79c5-47db-b9e6-54e0708cebba', 'Safe Zone', 'STAND', 'Hahahahahahaha', 100, '2025-08-30 15:25:49', '2025-08-31 11:17:35'),
('c7ff0588-0467-42dc-be24-ddf58ba2fabc', '753df965-79c5-47db-b9e6-54e0708cebba', 'Danger Zone ', 'STAND', 'Hehehehehehehehe', 200, '2025-08-30 04:55:15', '2025-08-31 11:11:51');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tickets_zone` (`zone_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Chỉ mục cho bảng `zones`
--
ALTER TABLE `zones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_zones_event_id` (`event_id`);

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `fk_tickets_zone` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `zones`
--
ALTER TABLE `zones`
  ADD CONSTRAINT `fk_zones_event` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_zones_event_id` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
