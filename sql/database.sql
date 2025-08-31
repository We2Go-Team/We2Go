-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th8 31, 2025 lúc 04:54 PM
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

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
('3bbecfe3-867a-11f0-9d09-380025bd8fc0', 'Concert', 'Hòa nhạc', '2025-08-31 21:53:19', '2025-08-31 21:53:19'),
('3bc21260-867a-11f0-9d09-380025bd8fc0', 'Sport', 'Thể thao', '2025-08-31 21:53:19', '2025-08-31 21:53:19'),
('3bc2132b-867a-11f0-9d09-380025bd8fc0', 'Theater', 'Kịch / sân khấu', '2025-08-31 21:53:19', '2025-08-31 21:53:19'),
('3bc2135b-867a-11f0-9d09-380025bd8fc0', 'Expo', 'Triển lãm', '2025-08-31 21:53:19', '2025-08-31 21:53:19'),
('3bc21380-867a-11f0-9d09-380025bd8fc0', 'Workshop', 'Workshop, đào tạo', '2025-08-31 21:53:19', '2025-08-31 21:53:19'),
('3bc213a8-867a-11f0-9d09-380025bd8fc0', 'Festival', 'Lễ hội, sự kiện lớn', '2025-08-31 21:53:19', '2025-08-31 21:53:19'),
('3bc213ce-867a-11f0-9d09-380025bd8fc0', 'Conference', 'Hội thảo, hội nghị', '2025-08-31 21:53:19', '2025-08-31 21:53:19'),
('3bc213eb-867a-11f0-9d09-380025bd8fc0', 'Meetup', 'Gặp mặt cộng đồng', '2025-08-31 21:53:19', '2025-08-31 21:53:19'),
('3bc2140f-867a-11f0-9d09-380025bd8fc0', 'Webinar', 'Hội thảo trực tuyến', '2025-08-31 21:53:19', '2025-08-31 21:53:19'),
('3bc21436-867a-11f0-9d09-380025bd8fc0', 'Networking', 'Kết nối chuyên môn', '2025-08-31 21:53:19', '2025-08-31 21:53:19'),
('3bc21458-867a-11f0-9d09-380025bd8fc0', 'Party', 'Bữa tiệc, giải trí', '2025-08-31 21:53:19', '2025-08-31 21:53:19'),
('3bc2147a-867a-11f0-9d09-380025bd8fc0', 'Charity', 'Từ thiện', '2025-08-31 21:53:19', '2025-08-31 21:53:19'),
('3bc214a0-867a-11f0-9d09-380025bd8fc0', 'Exhibition', 'Triển lãm nghệ thuật và công nghệ', '2025-08-31 21:53:19', '2025-08-31 21:53:19'),
('3bc214c6-867a-11f0-9d09-380025bd8fc0', 'Product Launch', 'Ra mắt sản phẩm mới', '2025-08-31 21:53:19', '2025-08-31 21:53:19'),
('3bc214ec-867a-11f0-9d09-380025bd8fc0', 'Gaming', 'Sự kiện game, eSports', '2025-08-31 21:53:19', '2025-08-31 21:53:19'),
('3bc2150b-867a-11f0-9d09-380025bd8fc0', 'Anime & Cosplay', 'Sự kiện anime, cosplay', '2025-08-31 21:53:19', '2025-08-31 21:53:19'),
('3bc21532-867a-11f0-9d09-380025bd8fc0', 'Youth Meetup', 'Gặp gỡ giới trẻ', '2025-08-31 21:53:19', '2025-08-31 21:53:19'),
('3bc2155b-867a-11f0-9d09-380025bd8fc0', 'Other', 'Khác', '2025-08-31 21:53:19', '2025-08-31 21:53:19');

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
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `category_id` char(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `events`
--

INSERT INTO `events` (`id`, `title`, `description`, `images`, `min_price`, `organizer_id`, `time_start`, `time_end`, `location`, `venue`, `status`, `alias`, `created_at`, `updated_at`, `category_id`) VALUES
('14146a98-5781-4db2-a08b-0b9020a9a547', '[CAT&MOUSE] MTV BAND - ĐÊM TÌM VỀ HỒI ỨC', '<p>Với kh&ocirc;ng gian được đầu tư&nbsp;<strong>hệ thống &aacute;nh s&aacute;ng - &acirc;m thanh đẳng cấp quốc tế</strong>&nbsp;với sức chứa l&ecirc;n đến&nbsp;<strong>350 người,</strong>&nbsp;c&ugrave;ng quầy bar phục vụ cocktail pha chế độc đ&aacute;o bởi bartender chuy&ecirc;n nghiệp.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>MTV BAND - Đ&Ecirc;M T&Igrave;M VỀ HỒI ỨC.</strong></p>\r\n\r\n<p>Đổi gi&oacute; cho đ&ecirc;m, cảm nhận t&acirc;m hồn bạn đắm m&igrave;nh trong những giai điệu quen thuộc, trở về với thời khắc đ&aacute;ng nhớ c&ugrave;ng những giọng h&aacute;t da diết từ&nbsp;<strong>MTV BAND</strong>&nbsp;kết hợp c&ugrave;ng những tay guitar - trống v&agrave; keyboard đầy đi&ecirc;u luyện từ&nbsp;<strong>WereCats Band.</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Địa chỉ sau s&aacute;p nhập: 37B Phạm Ngọc Thạch, Phường Xu&acirc;n H&ograve;a, Th&agrave;nh phố Hồ Ch&iacute; Minh</p>\r\n\r\n<p>Gi&aacute; v&eacute; đ&atilde; bao gồm VAT</p>\r\n\r\n<p>Gi&aacute; v&eacute; kh&ocirc;ng bao gồm nước v&agrave; đồ ăn</p>\r\n\r\n<p><strong><em>Sơ đồ sự kiện<br />\r\n<img alt=\"\" src=\"https://salt.tkbcdn.com/ts/ds/58/67/53/ae98e0aaf637468529d0168945663c09.png\" /><img alt=\"\" src=\"https://salt.tkbcdn.com/ts/ds/0e/04/e6/eaa01315a21c092406f0c5e2aabbea61.png\" /></em></strong></p>\r\n', 'https://res.cloudinary.com/dtzbyruu1/image/upload/v1756650256/We2Go%20Upload/or6j6wq0q67ayhxqvpvn.png', 0, NULL, '2025-04-09 21:21:00', '2025-04-09 12:00:00', '37B Phạm Ngọc Thạch, Phường Võ Thị Sáu, Quận 3, Thành Phố Hồ Chí Minh', 'Cat&Mouse Live Music', 'UPCOMING', 'catmouse-mtv-band-dem-tim-ve-hoi-uc', '2025-08-31 14:22:37', '2025-08-31 14:53:31', ''),
('1b9f9a44-65c9-4198-81e3-a2bba82192e5', '[CONCERT ENCORE] ANH TRAI VƯỢT NGÀN CHÔNG GAI DAY7, DAY8', '<p><img alt=\"\" src=\"https://salt.tkbcdn.com/ts/ds/b3/55/d8/0f0d1ee1d8e269f3460bacb1ca2d061e.jpg\" /></p>\r\n', 'https://res.cloudinary.com/dtzbyruu1/image/upload/v1756645504/We2Go%20Upload/mlypmy9l9v9iz8vjmyhj.png', 0, NULL, '2025-08-15 11:05:00', '2025-08-21 02:07:00', 'Đỗ Xuân Hợp, Tp Thủ Đức, Phường An Phú, Quận 2, Thành Phố Hồ Chí Minh', 'The Global City', 'UPCOMING', 'concert-encore-anh-trai-vuot-ngan-chong-gai-day7-day8', '2025-08-31 13:03:26', '2025-08-31 14:12:36', ''),
('276243b0-26d8-4549-8047-a96ca7dd45c1', 'GIẢI CHẠY \"30 STEPS OF MEMORIES - 30 CHẶNG KÝ ỨC SUỐI TIÊN\"', '<p><strong>Giới thiệu sự kiện:</strong></p>\r\n\r\n<p>Giải chạy&nbsp;<strong>&ldquo;30 STEPS OF MEMORIES - 30 CHẶNG K&Yacute; ỨC SUỐI TI&Ecirc;N&rdquo;</strong>&nbsp;- Giải chạy đặc biệt mừng 30 năm KDL Suối Ti&ecirc;n &ndash; nơi mỗi bước ch&acirc;n l&agrave; một k&yacute; ức đ&aacute;ng nhớ! Cự ly 3km &amp; 5km, đường chạy xanh m&aacute;t len lỏi qua c&aacute;c biểu tượng văn h&oacute;a &ndash; ph&ugrave; hợp cho mọi độ tuổi. Tham gia để vừa chạy, vừa chơi, vừa kh&aacute;m ph&aacute; Suối Ti&ecirc;n theo c&aacute;ch ri&ecirc;ng của bạn!</p>\r\n\r\n<p><strong>Th&ocirc;ng tin về giải chạy:</strong></p>\r\n\r\n<ul>\r\n	<li>Thời gian: 5h00 - 9h00, ng&agrave;y 10/08/2025</li>\r\n	<li>Địa điểm: Khu Du Lịch Văn H&oacute;a Suối Ti&ecirc;n</li>\r\n	<li>Cự ly: 3km &amp; 5km</li>\r\n	<li>Đối tượng: Gia đ&igrave;nh, học sinh, sinh vi&ecirc;n, c&ocirc;ng ty, runner tự do, cộng đồng y&ecirc;u du lịch &amp; thể thao</li>\r\n	<li>Quy m&ocirc; dự kiến: Hơn 1.000 người tham gia</li>\r\n</ul>\r\n\r\n<p><strong>Mỗi du kh&aacute;ch tham gia giải chạy sẽ nhận được trọn bộ Race Kit gồm:<br />\r\n<img alt=\"\" src=\"https://salt.tkbcdn.com/ts/ds/1c/2d/90/75e38efb3f9531f89aafc6ad59b4f4e4.jpg\" style=\"height:1000px; width:1000px\" /></strong></p>\r\n\r\n<p><strong>2 Loại v&eacute; gồm</strong></p>\r\n\r\n<ul>\r\n	<li>V&eacute; Standard gi&aacute; 300.000đ/người bao gồm: &Aacute;o, Bib, Nước, V&eacute; v&agrave;o cổng Suối Ti&ecirc;n</li>\r\n	<li>V&eacute; Premium gi&aacute; 400.000đ/người bao gồm: : &Aacute;o, Bib, Nước, V&eacute; v&agrave;o cổng Suối Ti&ecirc;n + V&eacute; Biển Ti&ecirc;n Đồng</li>\r\n</ul>\r\n\r\n<p><strong>Lịch tr&igrave;nh dự kiến:<br />\r\n<img alt=\"\" src=\"https://salt.tkbcdn.com/ts/ds/0a/60/5b/80c38beaa6975e81c06d4bbaf03956ba.jpg\" style=\"height:1000px; width:1000px\" />Giải thưởng hấp dẫn k&egrave;m huy chương chiến thắng:<br />\r\n<img alt=\"\" src=\"https://salt.tkbcdn.com/ts/ds/c6/ae/e5/98f06e8024993d31c6bfe9b32ab6854a.jpg\" style=\"height:1000px; width:1000px\" /></strong>Tổ chức trong khu&ocirc;n vi&ecirc;n hơn 150ha tại Khu Du lịch Văn h&oacute;a Suối Ti&ecirc;n, đường chạy được thiết kế bao quanh hồ nước, c&acirc;y xanh v&agrave; c&aacute;c c&ocirc;ng tr&igrave;nh văn h&oacute;a - lịch sử mang đậm bản sắc d&acirc;n tộc, tạo n&ecirc;n một h&agrave;nh tr&igrave;nh vừa vận động thể chất, vừa nu&ocirc;i dưỡng tinh thần<br />\r\n<img alt=\"\" src=\"https://salt.tkbcdn.com/ts/ds/cd/9e/76/24dbfbc4acfc2c28cd33b8bc6f27b066.jpg\" style=\"height:1000px; width:1000px\" /></p>\r\n\r\n<p><strong>Trải nghiệm vui chơi trọn g&oacute;i chỉ trong 1 tấm v&eacute;</strong></p>\r\n\r\n<p>B&ecirc;n cạnh yếu tố thể thao, giải chạy c&ograve;n t&iacute;ch hợp trải nghiệm du lịch trọn g&oacute;i d&agrave;nh cho người tham gia. Trong c&ugrave;ng một v&eacute;, người tham gia kh&ocirc;ng chỉ nhận được c&aacute;c quyền lợi cơ bản (&aacute;o thun, Bib, nước uống, v&eacute; v&agrave;o cổng), m&agrave; c&ograve;n được trải nghiệm nhiều dịch vụ tại Suối Ti&ecirc;n như:</p>\r\n\r\n<ul>\r\n	<li>\r\n	<p>Suối Ti&ecirc;n Farm, kh&ocirc;ng gian n&ocirc;ng trại với m&ocirc; h&igrave;nh tr&aacute;i c&acirc;y sạch, nơi trẻ nhỏ được tiếp cận thi&ecirc;n nhi&ecirc;n một c&aacute;ch gần gũi</p>\r\n	</li>\r\n	<li>\r\n	<p>Tắm biển nước Biển Ti&ecirc;n Đồng sau khi chạy - một trong những khu vui chơi dưới nước quy m&ocirc; lớn tại TP.HCM</p>\r\n	</li>\r\n</ul>\r\n\r\n<p>Ngo&agrave;i ra c&ograve;n c&oacute; hệ thống 150 c&ocirc;ng tr&igrave;nh vui chơi giải tr&iacute;, khu ẩm thực v&agrave; s&acirc;n khấu biểu diễn mang lại trải nghiệm giải tr&iacute; đa dạng.<br />\r\n<img alt=\"\" src=\"https://salt.tkbcdn.com/ts/ds/4b/4d/c5/f81a3e45e5e4595de0bde53ad8265018.jpg\" style=\"height:667px; width:1000px\" /></p>\r\n\r\n<p><strong>Điều khoản v&agrave; điều kiện:</strong></p>\r\n\r\n<ul>\r\n	<li>Th&iacute; sinh tham gia check-in đ&uacute;ng giờ trong khoảng thời gian đ&atilde; n&ecirc;u tr&ecirc;n.</li>\r\n	<li>Mỗi v&eacute; chỉ &aacute;p dụng với 1 người</li>\r\n	<li>Giấy tờ t&ugrave;y th&acirc;n c&oacute; thể được y&ecirc;u cầu xuất tr&igrave;nh để kiểm tra độ tuổi.</li>\r\n	<li>Những kh&aacute;ch c&oacute; dấu hiệu say xỉn, l&agrave;m ồn, ph&aacute; hoại hoặc đe dọa đến kh&aacute;n giả kh&aacute;c sẽ bị y&ecirc;u cầu rời khỏi khu&ocirc;n vi&ecirc;n của sự kiện</li>\r\n	<li>Ban Tổ Chức c&oacute; to&agrave;n quyền quay phim, chụp ảnh tại sự kiện.</li>\r\n</ul>\r\n', 'https://res.cloudinary.com/dtzbyruu1/image/upload/v1756649047/We2Go%20Upload/vis18yfnol2f4pkgmvne.jpg', 0, NULL, '2025-08-10 05:00:00', '2025-08-10 09:00:00', '120 Xa lộ Hà Nội, Phường Tân Phú, Quận 9, Thành Phố Hồ Chí Minh', 'KHU DU LỊCH VĂN HÓA SUỐI TIÊN', 'UPCOMING', 'giai-chay-30-steps-of-memories-30-chang-ky-uc-suoi-tien', '2025-08-31 14:02:29', '2025-08-31 14:06:09', ''),
('753df965-79c5-47db-b9e6-54e0708cebba', 'PiperFlow Platform', '<h1>&nbsp;</h1>\r\n\r\n<h2><strong><a href=\"https://specials-images.forbesimg.com/imageserve/682ac3c2d2a741da509390ac/960x0.jpg\"><img alt=\"\" src=\"https://specials-images.forbesimg.com/imageserve/682ac3c2d2a741da509390ac/960x0.jpg\" /></a><br />\r\n<br />\r\nThe Future is AI</strong></h2>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i ti&ecirc;n phong trong thế hệ tiếp theo của tự động h&oacute;a dựa tr&ecirc;n AI. Nền tảng của ch&uacute;ng t&ocirc;i gi&uacute;p doanh nghiệp x&acirc;y dựng quy tr&igrave;nh th&ocirc;ng minh m&agrave; kh&ocirc;ng cần lập tr&igrave;nh phức tạp, đưa AI ti&ecirc;n tiến đến gần hơn với mọi người.</p>\r\n\r\n<p>Từ chatbot đơn giản cho đến c&aacute;c quy tr&igrave;nh ph&acirc;n t&iacute;ch dữ liệu phức tạp, giao diện k&eacute;o-thả trực quan gi&uacute;p bạn dễ d&agrave;ng x&acirc;y dựng, triển khai v&agrave; mở rộng c&aacute;c giải ph&aacute;p AI mang lại gi&aacute; trị thực sự cho doanh nghiệp.</p>\r\n\r\n<h3>&nbsp;</h3>\r\n', 'https://res.cloudinary.com/dtzbyruu1/image/upload/v1756567550/We2Go%20Upload/ukwv4qlmkooccqbrhciy.png', 0, NULL, '2025-08-23 10:03:00', '2025-08-26 10:04:00', 'Đường A, phường B, Thành Phố Hồ Chí Minh', 'Trung tâm sự kiện ABC', 'UPCOMING', 'piperflow-platform', '2025-08-30 02:46:58', '2025-08-31 11:49:44', ''),
('80c90730-bba9-4d23-8d39-001c3796f007', 'VBA STAR X 2025 | PlayOff2 - Home Game of Nha Trang Dolphins', '<p><strong>Giới thiệu sự kiện:</strong></p>\r\n\r\n<p>VBA StarX - Nơi quy tụ những ng&ocirc;i sao đ&atilde; ch&iacute;nh thức khởi động. Với th&ocirc;ng điệp &ldquo;VƯƠN TẦM KH&Ocirc;NG GIỚI HẠN&rdquo;, VBA StarX hứa hẹn mang đến một m&ugrave;a giải đẳng cấp, b&ugrave;ng nổ v&agrave; ngập tr&agrave;n trải nghiệm độc quyền cho cộng đồng người h&acirc;m mộ b&oacute;ng rổ Việt Nam.</p>\r\n\r\n<p>Welcome to VBA StarX!</p>\r\n\r\n<p><strong>Chi tiết sự kiện: VBA STAR X | PlayOff2 - Home game of Nha Trang Dolphins</strong></p>\r\n\r\n<p><strong><img alt=\"\" src=\"https://salt.tkbcdn.com/ts/ds/fd/a2/98/efd1759ecd90f1a68ea9c05331d38893.jpg\" style=\"height:1000px; width:1000px\" /></strong></p>\r\n\r\n<p><strong>Điều khoản v&agrave; điều kiện:</strong></p>\r\n\r\n<p>1. V&eacute; được d&ugrave;ng cho sự kiện n&ecirc;u tr&ecirc;n v&agrave; phải được xuất tr&igrave;nh trong thời gian đ&oacute;n kh&aacute;ch.</p>\r\n\r\n<p>2. Mỗi v&eacute; chỉ được &aacute;p dụng cho một ghế v&agrave; kh&ocirc;ng c&oacute; gi&aacute; trị chuyển nhượng cho người kh&aacute;c.</p>\r\n\r\n<p>3. Nghi&ecirc;m cấm h&agrave;nh vi sao ch&eacute;p, giả mạo v&eacute; v&agrave;o cổng.</p>\r\n\r\n<p>4. Kh&ocirc;ng đổi trả, kh&ocirc;ng ho&agrave;n tiền.</p>\r\n\r\n<p>5. Ban Tổ Chức c&oacute; quyền từ chối v&eacute; v&agrave;o cổng.</p>\r\n\r\n<p>6. Gi&aacute; v&eacute; đ&atilde; bao gồm VAT, c&aacute;c khoản thanh to&aacute;n v&eacute; c&oacute; thể được xuất h&oacute;a đơn khi y&ecirc;u cầu.</p>\r\n\r\n<p>7. V&eacute; được ph&aacute;t h&agrave;nh v&agrave; quản l&yacute; th&ocirc;ng qua ứng dụng VBA dưới c&aacute;c điều lệ v&agrave; điều khoản của ứng dụng VBA .</p>\r\n\r\n<p>8. Giấy tờ t&ugrave;y th&acirc;n c&oacute; thể được y&ecirc;u cầu xuất tr&igrave;nh để kiểm tra độ tuổi.</p>\r\n\r\n<p>10. Kh&aacute;ch đến muộn sẽ phải chờ được sắp xếp chỗ ngồi v&agrave; kh&ocirc;ng được ho&agrave;n trả tiền v&eacute;. Ban Tổ Chức sẽ bắt đầu so&aacute;t v&eacute; trước khi sự kiện</p>\r\n\r\n<p>bắt đầu 1h30 ph&uacute;t.</p>\r\n\r\n<p>11. Nghi&ecirc;m cấm sang nhượng v&eacute; với gi&aacute; cao hơn gi&aacute; ban đầu. V&eacute; được mua b&aacute;n lại sẽ bị từ chối quyền v&agrave;o cổng.</p>\r\n\r\n<p>12. Những kh&aacute;ch c&oacute; dấu hiệu say xỉn, l&agrave;m ồn, ph&aacute; hoại hoặc đe dọa đến kh&aacute;n giả kh&aacute;c sẽ bị y&ecirc;u cầu rời khỏi khu&ocirc;n vi&ecirc;n của sự kiện</p>\r\n\r\n<p>13. Ban Tổ Chức c&oacute; to&agrave;n quyền quay phim, chụp ảnh tại sự kiện.</p>\r\n\r\n<p>14. V&eacute; c&oacute; thể được quy đổi từ coupon với nh&acirc;n vi&ecirc;n tại quầy v&eacute; trước sự kiện.</p>\r\n\r\n<p>15. C&aacute;c dữ liệu thu thập từ sự kiện để phục vụ mục đ&iacute;ch quảng b&aacute; phải tu&acirc;n thủ nghi&ecirc;m ngặt Theo Quy Tắc Bảo Mật Th&ocirc;ng Tin.</p>\r\n\r\n<p>16. Mỗi trẻ em kh&ocirc;ng qu&aacute; 3 tuổi c&oacute; thể ngồi c&ugrave;ng mỗi ghế của bố mẹ nếu phụ huynh c&oacute; nhu cầu.</p>\r\n\r\n<p>17. Trẻ em dưới 10 tuổi phải c&oacute; người lớn tr&ecirc;n 18 tuổi đi c&ugrave;ng.</p>\r\n', 'https://res.cloudinary.com/dtzbyruu1/image/upload/v1756648658/We2Go%20Upload/thzpfjmiuwelnrzssmic.jpg', 0, NULL, '2025-05-09 19:00:00', '2025-05-09 21:30:00', '33 Phan Chu Trinh, Phường Vạn Thạnh, Thành Phố Nha Trang, Tỉnh Khánh Hòa', 'Nhà thi đấu tỉnh Khánh Hoà', 'UPCOMING', 'vba-star-x-2025-playoff2-home-game-of-nha-trang-dolphins', '2025-08-31 13:55:59', '2025-08-31 13:59:28', ''),
('892b2646-2a54-4d18-9df1-8b80811e895d', 'SÂN KHẤU THIÊN ĐĂNG - VỞ KỊCH : CÔ GIÁO DUYÊN', '<p><strong><em>S&acirc;n khấu Nghệ Thuật Thi&ecirc;n Đăng&nbsp;</em></strong>&nbsp;tr&acirc;n trọng giới thiệu đến qu&yacute; kh&aacute;n giả vở h&agrave;i kịch&nbsp;<strong>&quot;C&Ocirc;</strong><strong>&nbsp;GI&Aacute;O DUY&Ecirc;N&quot;</strong>&nbsp;&nbsp;</p>\r\n\r\n<p>Cảm t&aacute;c từ t&aacute;c phẩm :&nbsp;&quot;Ng&ocirc;i nh&agrave; kh&ocirc;ng c&oacute; đ&agrave;n &ocirc;ng&quot; của cố t&aacute;c giả - nh&agrave; văn NGỌC LINH</p>\r\n\r\n<p><strong><em>T&aacute;c giả : Nguyễn Ngọc Thạch - L&ecirc; Ho&agrave;ng Giang</em></strong></p>\r\n\r\n<p><em><strong>Đạo diễn : L&ecirc; Ho&agrave;ng Giang</strong></em></p>\r\n\r\n<p><em><strong>Đạo diễn &acirc;m nhạc : Trương Anh Khoa</strong></em></p>\r\n\r\n<p>Với sự tham gia của c&aacute;c Nghệ sỹ:<strong>&nbsp;&nbsp;NSND KIM XU&Acirc;N, NSƯT TH&Agrave;NH LỘC - V&Acirc;N TRANG - L&Ecirc; PHƯƠNG - NGỌC XUY&Ecirc;N - L&Ecirc; HO&Agrave;NG GIANG - PHI PHỤNG - DON NGUYỄN - MAI THANH T&Uacute; - HO&Agrave;NG PHONG - THU HƯỜNG - HO&Agrave;NG MINH THƯ.</strong></p>\r\n\r\n<p><strong>Tr&acirc;n trọng k&iacute;nh mời qu&yacute; kh&aacute;n giả.</strong></p>\r\n\r\n<p><em><strong>Lưu &yacute; :&nbsp;</strong></em></p>\r\n\r\n<ul>\r\n	<li><strong>Sự kiện c&oacute; xuất VAT. Kh&aacute;ch h&agrave;ng lưu &yacute; gửi th&ocirc;ng tin cần thiết trong v&ograve;ng 24h kể từ khi mua v&eacute; để được hỗ trợ. Sau thời gian tr&ecirc;n, BTC xin ph&eacute;p được từ chối xuất ho&aacute; đơn.&nbsp;</strong></li>\r\n	<li><strong>Trẻ em từ 8 tuổi trở l&ecirc;n sẽ c&oacute; thể mua v&eacute; tham dự vờ diễn.</strong></li>\r\n</ul>\r\n', 'https://res.cloudinary.com/dtzbyruu1/image/upload/v1756649364/We2Go%20Upload/j8x7dhexipyjust11hxg.jpg', 0, NULL, '2025-04-09 19:30:00', '2025-04-09 21:30:00', '62 TRẦN QUANG KHẢI, Phường TÂN ĐỊNH, Quận 1, Thành Phố Hồ Chí Minh', 'TẦNG 12B TÒA NHÀ IMC', 'UPCOMING', 'san-khau-thien-dang-vo-kich-co-giao-duyen', '2025-08-31 14:07:45', '2025-08-31 14:09:57', ''),
('897adc82-cd65-4ad3-a6a0-9cc7d75d5e35', 'DAY6 10th Anniversary Tour <The DECADE> in HO CHI MINH CITY', '<p><img alt=\"\" src=\"https://salt.tkbcdn.com/ts/ds/4d/92/65/4756312238e1ae1b8129074a53454f7b.jpg\" style=\"height:1333px; width:1000px\" /><img alt=\"\" src=\"https://salt.tkbcdn.com/ts/ds/d8/c4/b0/951c7564e3f6037d0a15e701e0cfcdca.jpg\" style=\"height:1333px; width:1000px\" /><img alt=\"\" src=\"https://salt.tkbcdn.com/ts/ds/68/01/85/cca31e239273c9dbec58ab9f58eb94e2.jpg\" style=\"height:1333px; width:1000px\" /><img alt=\"\" src=\"https://salt.tkbcdn.com/ts/ds/2d/b4/f1/5e12dd3f24b1f56f5e89bf99d6545682.jpg\" style=\"height:1333px; width:1000px\" /></p>\r\n\r\n<p>English below:</p>\r\n\r\n<p><strong>1. Lưu &yacute; quan trọng trước khi mua v&eacute;</strong></p>\r\n\r\n<ul>\r\n	<li>V&eacute; sự kiện DAY6 10th Anniversary Tour &lt;The DECADE&gt; in HO CHI MINH CITY chỉ c&oacute; thể được mua th&ocirc;ng qua nền tảng Ticketbox (bao gồm trang web v&agrave; ứng dụng Ticketbox). Vui l&ograve;ng kiểm tra kỹ th&ocirc;ng tin v&agrave; địa chỉ email trước khi tiến h&agrave;nh mua v&eacute;</li>\r\n	<li>NGƯỜI MUA V&Eacute; l&agrave; bất kỳ c&aacute; nh&acirc;n n&agrave;o mua v&eacute; theo c&aacute;c Điều khoản &amp; Quy định n&agrave;y.</li>\r\n	<li>NGƯỜI C&Oacute; V&Eacute; l&agrave; người sở hữu/kiểm so&aacute;t v&eacute; để v&agrave;o b&ecirc;n trong sự kiện v&agrave;o ng&agrave;y diễn ra sự kiện. Mỗi v&eacute; chỉ c&oacute; gi&aacute; trị cho một (01) người sở hữu v&eacute; cho một (01) lần v&agrave;o địa điểm tổ chức sự kiện.</li>\r\n	<li>Vui l&ograve;ng kh&ocirc;ng mua v&eacute; từ c&aacute;c nguồn kh&aacute;c ngo&agrave;i nền tảng ch&iacute;nh thức được Ban Tổ Chức c&ocirc;ng bố để tr&aacute;nh v&eacute; giả hoặc gian lận. Ban Tổ Chức kh&ocirc;ng chịu tr&aacute;ch nhiệm giải quyết c&aacute;c trường hợp li&ecirc;n quan đến những v&eacute; n&agrave;y.</li>\r\n	<li>Bằng c&aacute;ch mua v&eacute;, bạn x&aacute;c nhận rằng m&igrave;nh đ&atilde; chấp nhận tất cả c&aacute;c Điều Khoản v&agrave; Điều Kiện của Ban Tổ Chức. Trước khi mua v&eacute; v&agrave; tham gia sự kiện, vui l&ograve;ng đảm bảo rằng bạn tu&acirc;n thủ tất cả c&aacute;c hướng dẫn để tr&aacute;nh bất kỳ sự bất tiện n&agrave;o tại sự kiện.</li>\r\n</ul>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>2. Th&ocirc;ng tin b&aacute;n v&eacute;</strong></p>\r\n\r\n<ul>\r\n	<li>Thời gian b&aacute;n v&eacute;: 22/08/2025 (Thứ S&aacute;u) &ndash; 12:00 PM ICT&nbsp;</li>\r\n	<li>Giới hạn mua v&eacute;: Mỗi t&agrave;i khoản Ticketbox chỉ được mua tối đa 4 v&eacute;</li>\r\n</ul>\r\n\r\n<p>&nbsp; &nbsp;Lưu &yacute; quan trọng:</p>\r\n\r\n<ul>\r\n	<li>Sự kiện kh&ocirc;ng ph&ugrave; hợp cho trẻ em dưới 07 tuổi. Trẻ em dưới độ tuổi n&agrave;y sẽ kh&ocirc;ng được v&agrave;o cửa, ngay cả khi c&oacute; v&eacute; hoặc đi c&ugrave;ng người lớn.</li>\r\n	<li>Trẻ em dưới 16 tuổi phải c&oacute; người lớn (tr&ecirc;n 18 tuổi) đi c&ugrave;ng suốt thời gian diễn ra sự kiện.</li>\r\n	<li>V&eacute; KH&Ocirc;NG ĐƯỢC HO&Agrave;N TRẢ, KH&Ocirc;NG CHUYỂN NHƯỢNG v&agrave; KH&Ocirc;NG CHỈNH SỬA trong bất kỳ trường hợp n&agrave;o.<br />\r\n	Sơ đồ chỗ ngồi theo hạng v&eacute; chỉ mang t&iacute;nh tham khảo v&agrave; c&oacute; thể thay đổi m&agrave; kh&ocirc;ng cần th&ocirc;ng b&aacute;o trước.</li>\r\n	<li>Tất cả v&eacute; trong sự kiện n&agrave;y đều l&agrave; v&eacute; ngồi cố định.</li>\r\n</ul>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>3. Th&ocirc;ng tin chung</strong></p>\r\n\r\n<ul>\r\n	<li>&nbsp;Kh&aacute;ch h&agrave;ng chịu tr&aacute;ch nhiệm bảo quản m&atilde; v&eacute; điện tử của m&igrave;nh. Ban Tổ Chức sẽ kh&ocirc;ng giải quyết c&aacute;c trường hợp c&oacute; hơn một (01) người cố gắng check-in bằng c&ugrave;ng một m&atilde; v&eacute;.</li>\r\n	<li>Chỉ người đầu ti&ecirc;n check-in với m&atilde; v&eacute; tr&ugrave;ng lặp mới được ph&eacute;p v&agrave;o sự kiện.</li>\r\n	<li>Tất cả người c&oacute; v&eacute; phải xuất tr&igrave;nh v&eacute; điện tử hợp lệ để kiểm tra trước khi v&agrave;o địa điểm tổ chức sự kiện.</li>\r\n	<li>Ban quản l&yacute; v&agrave; nh&acirc;n vi&ecirc;n c&oacute; quyền từ chối hoặc buộc rời khỏi sự kiện đối với bất kỳ c&aacute; nh&acirc;n n&agrave;o vi phạm c&aacute;c Điều Khoản v&agrave; Quy Định.</li>\r\n	<li>Nghi&ecirc;m cấm sử dụng hoặc ph&acirc;n phối v&eacute; cho mục đ&iacute;ch quảng c&aacute;o m&agrave; kh&ocirc;ng c&oacute; sự cho ph&eacute;p của Ban Tổ Chức.</li>\r\n	<li>Trong mọi trường hợp, quyết định của Ban Tổ Chức l&agrave; quyết định cuối c&ugrave;ng.</li>\r\n	<li>C&aacute;c Điều khoản v&agrave; Quy định kh&aacute;c vẫn được &aacute;p dụng. Vui l&ograve;ng theo d&otilde;i c&aacute;c nền tảng mạng x&atilde; hội ch&iacute;nh thức của iME Vietnam để biết th&ecirc;m chi tiết về DAY6 10th Anniversary Tour &lt;The DECADE&gt; in HO CHI MINH CITY.<br />\r\n	&nbsp;</li>\r\n</ul>\r\n\r\n<p><strong><em>1. Important Notice Before Purchase</em></strong></p>\r\n\r\n<ul>\r\n	<li><em>Tickets for the DAY6 10th Anniversary Tour &lt;The DECADE&gt; in HO CHI MINH CITY can only be purchased through the Ticketbox platform (including the Ticketbox website and app). Please double-check your information and email address before proceeding with the purchase.</em></li>\r\n	<li><em>The term &quot;TICKET BUYER&quot; refers to any individual who purchases a ticket under these Terms &amp; Conditions.&nbsp;</em></li>\r\n	<li><em>The &quot;TICKET HOLDER&quot; is the individual who possesses or controls the ticket for entry to the event on the event date. Each ticket is valid for one (01) Ticket Holder for a single entry to the event venue.</em></li>\r\n	<li><em>Please avoid purchasing tickets from sources other than the official platforms announced by the Organizer to prevent counterfeit or fraudulent tickets. The Organizer is not responsible for resolving issues related to such cases.</em></li>\r\n	<li><em>By purchasing tickets, you acknowledge and accept all of the Organizer&rsquo;s Terms and Conditions. Please ensure that you follow all guidance before purchase and attendance to avoid any inconvenience during the performance.</em></li>\r\n</ul>\r\n\r\n<h3><strong><em>2. Ticket Sales Notice</em></strong></h3>\r\n\r\n<ul>\r\n	<li><em>Sales Period: August 22, 2025 (Friday) &ndash; from 12:00 PM (ICT)</em></li>\r\n	<li><em>Ticket Limits: Each Ticketbox account is limited to purchasing up to 4 tickets.</em></li>\r\n</ul>\r\n\r\n<p><em>&nbsp;&nbsp;&nbsp;&nbsp;Important Notice:</em></p>\r\n\r\n<ul>\r\n	<li><em>The event is not suitable for children under 7 years old. Attendees below this age will not be admitted, even if they hold a ticket or are accompanied by an adult.</em></li>\r\n	<li><em>Children under 16 must be accompanied by an adult (18 years or older) throughout the entire event.</em></li>\r\n	<li><em>Tickets are NON-REFUNDABLE, NON-TRANSFERABLE, and NON-EDITABLE under any circumstances.</em></li>\r\n	<li><em>The seating layout is subject to change without prior notice.</em></li>\r\n	<li><em>All tickets are for designated seating.</em></li>\r\n</ul>\r\n\r\n<p><em><strong>&nbsp;</strong></em><strong><em>3. General Notice</em></strong></p>\r\n\r\n<ul>\r\n	<li><em>Ticket holders are responsible for maintaining their electronic ticket codes. The Organizer will not resolve cases where more than one (01) person attempts to check in using the same ticket code. Only the first individual to check in with the duplicated ticket code will be permitted entry.</em></li>\r\n	<li><em>All ticket holders must present a valid electronic ticket for verification before entering the event venue.</em></li>\r\n	<li><em>The management and staff reserve the right to deny or eject any attendee from the event at any time if they violate any of the Terms and Conditions or Regulations.</em></li>\r\n	<li><em>Using or distributing tickets for advertising and/or publicity without the explicit permission of the Organizer is strictly prohibited.</em></li>\r\n	<li><em>The Organizer&#39;s decision is final in all cases.</em></li>\r\n	<li><em>Other Terms and Conditions still apply. Please follow iME Vietnam&#39;s official social media channels for further details about DAY6 10th Anniversary Tour &lt;The DECADE&gt; in HO CHI MINH CITY.&nbsp;</em></li>\r\n</ul>\r\n', 'https://res.cloudinary.com/dtzbyruu1/image/upload/v1756647285/We2Go%20Upload/qgucjrxeqwizbeostdlw.jpg', 0, NULL, '2025-09-13 12:00:00', '2025-09-13 23:00:00', '799 Nguyễn Văn Linh, Phường Tân Phú, Quận 7, Thành Phố Hồ Chí Minh', 'SECC Hall B2, 799 Nguyen Van Linh, Tan Phu Ward, Ho Chi Minh City', 'UPCOMING', 'day6-10th-anniversary-tour-the-decade-in-ho-chi-minh-city', '2025-08-31 13:16:30', '2025-08-31 13:33:07', ''),
('a7e72d22-2ad8-422c-86d1-32b098d21037', 'DOMBRESKY @APLUS', '<p><strong>Giới thiệu sự kiện:</strong></p>\r\n\r\n<p>TBA</p>\r\n\r\n<p><strong>Điều khoản v&agrave; điều kiện:</strong></p>\r\n\r\n<p>- V&eacute; tham dự đ&ecirc;m diễn chỉ c&oacute; thể được mua th&ocirc;ng qua c&aacute;c nền tảng của Ticketbox (trang web v&agrave; ứng dụng Ticketbox)</p>\r\n\r\n<p>- 01 v&eacute; chỉ c&oacute; hiệu lực cho 01 người tham gia v&agrave; 01 lần v&agrave;o b&ecirc;n trong sự kiện</p>\r\n\r\n<p>- Kh&aacute;ch h&agrave;ng vui l&ograve;ng kiểm tra lại th&ocirc;ng tin v&eacute; (tổng số v&eacute;, loại v&eacute;, số v&eacute; từng loại) v&agrave; số tiền trước khi x&aacute;c nhận đặt mua v&eacute;.</p>\r\n\r\n<p>- Kh&aacute;ch h&agrave;ng c&oacute; tr&aacute;ch nhiệm bảo mật tuyệt đối m&atilde; v&eacute; điện tử của m&igrave;nh. Ban tổ chức KH&Ocirc;NG chịu tr&aacute;ch nhiệm về sơ suất của kh&aacute;ch h&agrave;ng dẫn đến v&eacute; rơi v&agrave;o tay người kh&aacute;c v&agrave; được sử dụng để v&agrave;o cổng. Vui l&ograve;ng KH&Ocirc;NG TIẾT LỘ th&ocirc;ng tin v&eacute; cho bất kỳ ai trước sự kiện</p>\r\n\r\n<p>- Để đảm bảo nhận được v&eacute; sự kiện, trước khi thực hiện việc đặt mua v&eacute; theo quy tr&igrave;nh giao dịch tại điều khoản n&agrave;y, kh&aacute;ch h&agrave;ng n&ecirc;n chủ động kiểm tra v&agrave; điền đầy đủ, ch&iacute;nh x&aacute;c th&ocirc;ng tin email &amp; số điện thoại.</p>\r\n\r\n<p>- V&eacute; đ&atilde; mua kh&ocirc;ng được đổi hoặc trả dưới bất kỳ trường hợp n&agrave;o.</p>\r\n\r\n<p>- Ban tổ chức sẽ KH&Ocirc;NG chịu tr&aacute;ch nhiệm cho bất kỳ v&eacute; n&agrave;o được mua th&ocirc;ng qua c&aacute;c k&ecirc;nh kh&ocirc;ng ch&iacute;nh thống. Xin lưu &yacute; kỹ như sau:</p>\r\n\r\n<p>- Vui l&ograve;ng cẩn thận với lừa đảo, v&iacute; dụ dịch vụ đặt chỗ, m&atilde; b&aacute;n trước v&agrave; b&aacute;n lại từ c&aacute;c b&ecirc;n thứ ba. Ticketbox l&agrave; nền tảng b&aacute;n v&eacute; được ủy quyền duy nhất.</p>\r\n\r\n<p>- Tất cả v&eacute; l&agrave; t&agrave;i sản của Ban tổ chức. Kh&aacute;ch h&agrave;ng KH&Ocirc;NG được sử dụng v&eacute; cho mục đ&iacute;ch khuyến m&atilde;i m&agrave; kh&ocirc;ng c&oacute; sự cho ph&eacute;p của Ban tổ chức.</p>\r\n\r\n<p>- Trẻ em dưới 16 tuổi phải c&oacute; người gi&aacute;m hộ đi c&ugrave;ng trong sự kiện v&agrave; chịu mọi tr&aacute;ch nhiệm đối với người được gi&aacute;m hộ.&nbsp;</p>\r\n\r\n<p>- Phụ nữ mang thai hay người c&oacute; vấn đề sức khỏe khi tham gia phải th&ocirc;ng b&aacute;o cho Ban tổ chức v&agrave; k&iacute; giấy cam kết tại cửa so&aacute;t v&eacute;.</p>\r\n\r\n<p>- Ban tổ chức c&oacute; quyền thay đổi bố cục sự kiện m&agrave; kh&ocirc;ng cần th&ocirc;ng b&aacute;o trước.</p>\r\n\r\n<p>- Trong mọi trường hợp, quyết định của Ban tổ chức l&agrave; quyết định cuối c&ugrave;ng.</p>\r\n\r\n<p>-<em>&nbsp;Tickets for the concert can only be purchased through Ticketbox platforms (website and Ticketbox app).</em></p>\r\n\r\n<p><em>- 01 ticket is valid for 01 person for 01 entry to the event.</em></p>\r\n\r\n<p><em>- Customers are advised to double-check ticket information (total number of tickets, ticket types, and the cost) before confirming your ticket purchase.</em></p>\r\n\r\n<p><em>- Customers are responsible for safeguarding their e-ticket code securely. The organizer will not be responsible for customer negligence leading to tickets falling into the hands of others and being used for entry. Please DO NOT DISCLOSE ticket information to anyone before the event.</em></p>\r\n\r\n<p><em>- To ensure the receipt of event tickets, customers should actively verify and provide accurate email and phone number information before proceeding with the ticket purchase process as outlined in these terms.</em></p>\r\n\r\n<p><em>- Tickets that have been purchased cannot be exchanged or refunded under any circumstances.</em></p>\r\n\r\n<p><em>- The organizer is NOT responsible for any tickets purchased through unauthorized channels. Please take note of the following:</em></p>\r\n\r\n<p><em>- Exercise caution regarding scams, such as reservation services, pre-sale codes, and reselling from third parties. Ticketbox is the sole authorized ticketing platform.</em></p>\r\n\r\n<p><em>- All tickets are the property of the organizer. Customers are NOT allowed to use tickets for promotional purposes without the organizer&#39;s permission.</em></p>\r\n\r\n<p><em>- No admision for infant in arms and children age below 6 years old. Children over 6 years old will need to purchase ticket.</em><br />\r\n<em>- Children under the age of 16 must be accompanied by a guardian at the event, and the guardian is responsible for them. Pregnant women or individuals with health issues must inform the organizer and sign a commitment form at the ticket checkpoint.</em></p>\r\n\r\n<p><em>- The organizer reserves the right to change the event layout without prior notice.</em></p>\r\n\r\n<p><em>- In all cases, the organizer&#39;s decision is final</em></p>\r\n', 'https://res.cloudinary.com/dtzbyruu1/image/upload/v1756647581/We2Go%20Upload/pcs6ofwwwzlbkmja9nsh.png', 0, NULL, '2025-08-31 21:00:00', '2025-01-09 05:00:00', '78 Yên Phụ, Phường Nguyễn Trung Trực, Quận Ba Đình, Thành Phố Hà Nội', 'APLUS Hanoi | GA Area Only', 'UPCOMING', 'dombresky-aplus', '2025-08-31 13:17:10', '2025-08-31 14:14:51', ''),
('ce46b6e4-8bf5-4f5a-8045-4bf2aa71d050', 'SÂN KHẤU THIÊN ĐĂNG: HẠC VỸ LAN', '<p><strong><em>S&acirc;n khấu Nghệ Thuật Thi&ecirc;n Đăng&nbsp;</em></strong>&nbsp;tr&acirc;n trọng giới thiệu đến qu&yacute; kh&aacute;n giả VỞ KỊCH MỚI NHẤT</p>\r\n\r\n<p>&nbsp;<strong>&quot;HẠC VỸ LAN</strong><strong>&quot;</strong>&nbsp;&nbsp;</p>\r\n\r\n<p><strong><em>T&aacute;c giả</em></strong><strong><em>&nbsp;:&nbsp;</em></strong><strong><em>Vũ Thị Thanh Hương</em></strong></p>\r\n\r\n<p><em><strong>Đạo diễn&nbsp;: Ho&agrave;ng Th&aacute;i Quốc</strong></em><br />\r\n&nbsp;</p>\r\n\r\n<p>Với sự tham gia của c&aacute;c Nghệ sỹ:<strong>&nbsp;&nbsp;NSƯT TH&Agrave;NH LỘC -&nbsp;&nbsp;NSƯT&nbsp; HỮU CH&Acirc;U - TUẤN KH&Ocirc;I - HO&Agrave;NG TH&Aacute;I QUỐC - TRƯƠNG HẠ - TRANG TUYỀN&nbsp;</strong></p>\r\n\r\n<p><strong>TH&Agrave;NH KH&Ocirc;N - NGHI&Ecirc;M NHI - NGỌC THỦY - HUY TỨ - CAO ĐỨC XU&Acirc;N HỒNG - QUỐC TRUNG - MẠNH H&Ugrave;NG - MAI CHI - NHẬT MINH - T&Acirc;M NH&Acirc;N -&nbsp;</strong><strong>HO&Agrave;NG MINH THƯ - SƠN GIANG - TRUNG HIẾU - MẠNH Đ&Igrave;NH - B&Aacute; T&Yacute; - GIA H&Acirc;N - PHA L&Ecirc; - BI TỒ.</strong><br />\r\n&nbsp;</p>\r\n\r\n<p><strong>Tr&acirc;n trọng k&iacute;nh mời qu&yacute; kh&aacute;n giả.</strong></p>\r\n\r\n<p><em><strong>Lưu &yacute; :&nbsp;</strong></em></p>\r\n\r\n<ul>\r\n	<li><strong>Sự kiện c&oacute; xuất VAT. Kh&aacute;ch h&agrave;ng lưu &yacute; gửi th&ocirc;ng tin cần thiết trong v&ograve;ng 24h kể từ khi mua v&eacute; để được hỗ trợ. Sau thời gian tr&ecirc;n, BTC xin ph&eacute;p được từ chối xuất ho&aacute; đơn.&nbsp;</strong></li>\r\n	<li><strong>Trẻ em từ 8 tuổi trở l&ecirc;n sẽ c&oacute; thể mua v&eacute; tham dự vờ diễn.</strong></li>\r\n</ul>\r\n', 'https://res.cloudinary.com/dtzbyruu1/image/upload/v1756648124/We2Go%20Upload/dvcwp7uuy8roixiiauvm.jpg', 0, NULL, '2025-01-09 18:00:00', '2025-01-09 21:00:00', '62 Trần Quang Khải, Phường Tân Định, Quận 1, Thành Phố Hồ Chí Minh', 'Tầng 12 TOÀ NHÀ IMC', 'UPCOMING', 'san-khau-thien-dang-hac-vy-lan', '2025-08-31 13:47:06', '2025-08-31 13:49:50', ''),
('cffe08c5-db36-465b-9f12-3f307c1fc813', 'SUPERFEST 2025 - Concert Mùa Hè Rực Sáng', '<p><strong>*Cổng b&aacute;n v&eacute; ch&iacute;nh thức mở l&uacute;c 13:15 ng&agrave;y 21.08.2025</strong></p>\r\n\r\n<p><strong>SUPERFEST 2025 &ndash; CONCERT M&Ugrave;A H&Egrave; RỰC S&Aacute;NG</strong><br />\r\n20 nghệ sĩ, 1 concert, 1 m&ugrave;a h&egrave; bất tận v&agrave; đầy cảm x&uacute;c!</p>\r\n\r\n<p>Đại tiệc &acirc;m nhạc b&ugrave;ng nổ nhất ch&iacute;nh thức trở lại tại H&agrave; Nội với phi&ecirc;n bản n&acirc;ng cấp chưa từng c&oacute; &ndash; nơi &aacute;nh s&aacute;ng, &acirc;m nhạc v&agrave; cảm x&uacute;c c&ugrave;ng chạm đỉnh!<br />\r\nSUPERFEST 2025 quy tụ 20 nghệ sĩ t&agrave;i sắc vẹn to&agrave;n, mang đến những m&agrave;n tr&igrave;nh diễn độc nhất, lần đầu hội tụ tr&ecirc;n một s&acirc;n khấu đặc biệt nhất trong năm.</p>\r\n\r\n<p>Đ&acirc;y kh&ocirc;ng chỉ l&agrave; một concert &ndash; m&agrave; l&agrave; h&agrave;nh tr&igrave;nh đ&aacute;nh thức thanh xu&acirc;n, nơi bạn sẽ ch&aacute;y hết m&igrave;nh, sống trọn cảm x&uacute;c v&agrave; tạo n&ecirc;n những kỷ niệm rực s&aacute;ng nhất năm nay!</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>- Thời gian 17.10.2025&nbsp;</p>\r\n\r\n<p>- Địa điểm: Trung T&acirc;m Triển L&atilde;m Việt Nam (VEC)</p>\r\n\r\n<p>- Đơn vị tổ chức: Vi21 Media<br />\r\n<img alt=\"\" src=\"https://salt.tkbcdn.com/ts/ds/34/ff/82/92737b672b1748c88095f1d80eda168b.jpg\" style=\"height:1250px; width:1000px\" /></p>\r\n\r\n<p><strong>Lưu &yacute; về độ tuổi tham gia:</strong></p>\r\n\r\n<p><strong>- Trẻ em dưới 13 tuổi phải mua v&eacute; v&agrave; c&oacute; người bảo hộ đi c&ugrave;ng. Người bảo hộ cần c&oacute; v&eacute; ri&ecirc;ng.&nbsp;<br />\r\n- BTC kh&ocirc;ng khuyến kh&iacute;ch trẻ em dưới 5 tuổi v&agrave; phụ nữ mang thai tham gia sự kiện. BTC xin ph&eacute;p sẽ kh&ocirc;ng chịu tr&aacute;ch nhiệm cho bất kỳ sự cố đ&aacute;ng tiếc n&agrave;o xảy ra. Kh&aacute;n giả vui l&ograve;ng c&acirc;n nhắc kỹ lưỡng v&agrave; chịu tr&aacute;ch nhiệm về sức khoẻ khi tham gia sự kiện.</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>TH&Ocirc;NG TIN V&Eacute;</strong></p>\r\n\r\n<p>- Thời gian&nbsp;<strong>b&aacute;n v&eacute; bắt đầu từ 13:15, ng&agrave;y 21/08/2025 (giờ Việt Nam)</strong></p>\r\n\r\n<p>- Mỗi t&agrave;i khoản Ticketbox chỉ được mua tối đa 10 v&eacute;/lượt mua</p>\r\n\r\n<p>- V&eacute; KH&Ocirc;NG ĐƯỢC HO&Agrave;N TRẢ, KH&Ocirc;NG CHUYỂN NHƯỢNG v&agrave; KH&Ocirc;NG CHỈNH SỬA trong bất kỳ trường hợp n&agrave;o.</p>\r\n\r\n<p>- Sơ đồ chỗ ngồi được cung cấp để hỗ trợ việc mua v&eacute;. Ban Tổ Chức c&oacute; thể thay đổi sơ đồ chỗ ngồi t&ugrave;y thuộc v&agrave;o y&ecirc;u cầu của chương tr&igrave;nh m&agrave; kh&ocirc;ng cần th&ocirc;ng b&aacute;o trước<br />\r\n<img alt=\"\" src=\"https://salt.tkbcdn.com/ts/ds/1b/bf/f1/a2490addae97b9b73f3eb90d20ea3bc2.jpg\" style=\"height:1250px; width:1000px\" /><img alt=\"\" src=\"https://salt.tkbcdn.com/ts/ds/40/ce/cb/4969c2fe2e301cda2b383a595835e75a.jpg\" style=\"height:1250px; width:1000px\" /></p>\r\n\r\n<p><strong>LƯU &Yacute; QUAN TRỌNG TRƯỚC KHI MUA V&Eacute;</strong></p>\r\n\r\n<p>- V&eacute; sự kiện&nbsp;<strong>SUPERFEST 2025 - Concert M&ugrave;a H&egrave; Rực S&aacute;ng (ng&agrave;y 17.10.2025)</strong>&nbsp;chỉ c&oacute; thể được mua th&ocirc;ng qua nền tảng của Ticketbox (bao gồm trang web v&agrave; ứng dụng Ticketbox). Vui l&ograve;ng kiểm tra kỹ th&ocirc;ng tin v&agrave; địa chỉ email trước khi tiến h&agrave;nh mua v&eacute;.</p>\r\n\r\n<p>- NGƯỜI MUA V&Eacute; l&agrave; bất kỳ c&aacute; nh&acirc;n n&agrave;o mua v&eacute; theo c&aacute;c Điều khoản &amp; Quy định n&agrave;y. NGƯỜI C&Oacute; V&Eacute; l&agrave; người sở hữu/ kiểm so&aacute;t v&eacute; để v&agrave;o b&ecirc;n trong sự kiện v&agrave;o ng&agrave;y diễn ra sự kiện. Mỗi v&eacute; chỉ c&oacute; gi&aacute; trị cho một (01) người sở hữu v&eacute; cho một (01) lần v&agrave;o địa điểm tổ chức sự kiện.</p>\r\n\r\n<p>- Vui l&ograve;ng mua v&eacute; tr&ecirc;n nền tảng ph&acirc;n phối ch&iacute;nh thức được Ban Tổ Chức c&ocirc;ng bố l&agrave; Ticketbox để tr&aacute;nh v&eacute; giả. Ban Tổ Chức kh&ocirc;ng chịu tr&aacute;ch nhiệm giải quyết c&aacute;c trường hợp v&eacute; mua từ c&aacute;c nguồn ph&acirc;n phối kh&ocirc;ng ch&iacute;nh thống kh&aacute;c.</p>\r\n\r\n<p>- Bằng c&aacute;ch mua v&eacute;, bạn x&aacute;c nhận rằng m&igrave;nh đ&atilde; chấp nhận tất cả c&aacute;c Điều Khoản v&agrave; Điều Kiện của Ban Tổ Chức. Trước khi mua v&eacute; v&agrave; tham gia sự kiện, vui l&ograve;ng đảm bảo rằng bạn tu&acirc;n thủ tất cả c&aacute;c hướng dẫn để ph&ograve;ng tr&aacute;nh bất kỳ sự bất tiện n&agrave;o tại sự kiện.</p>\r\n\r\n<p>- Mỗi m&atilde; v&eacute; điện tử chỉ c&oacute; gi&aacute; trị cho 01 (một) người v&agrave; 01 (một) lần sử dụng. Người tham dự c&oacute; tr&aacute;ch nhiệm bảo mật m&atilde; v&eacute; điện tử của m&igrave;nh. Chỉ người đầu ti&ecirc;n qu&eacute;t m&atilde; v&eacute; được ph&eacute;p tham gia sự kiện. Trường hợp c&oacute; nhiều hơn 01 (một) người check-in c&ugrave;ng 01 (một) m&atilde; v&eacute;, BTC sẽ kh&ocirc;ng chịu tr&aacute;ch nhiệm v&agrave; từ chối giải quyết. V&eacute; KH&Ocirc;NG được ho&agrave;n trả, đổi ng&agrave;y hoặc chỉnh sửa trong bất k&igrave; trường hợp n&agrave;o, trừ trường hợp sự kiện bị hủy do nguy&ecirc;n nh&acirc;n từ ph&iacute;a BTC.</p>\r\n\r\n<p>- TẤT CẢ người tham dự phải xuất tr&igrave;nh v&eacute; hợp lệ để x&aacute;c nhận v&agrave;o khu vực đ&atilde; được hiển thị tr&ecirc;n v&eacute;.</p>\r\n\r\n<p>- Sự kiện sẽ diễn ra ngo&agrave;i trời với mỗi v&eacute; đều được sắp xếp vị tr&iacute; đứng hoặc ghế ngồi cố định theo hạng v&eacute;. TẤT CẢ người tham dự phải đứng/ ngồi đ&uacute;ng vị tr&iacute; do BTC chỉ định theo hạng v&eacute; đ&atilde; mua.</p>\r\n\r\n<p><em><strong>Lưu &yacute;: Trong trường hợp trời mưa, sự kiện vẫn sẽ tiếp tục diễn ra theo kế hoạch. Với trường hợp trời mưa v&agrave; bất k&igrave; sự cố bất khả kh&aacute;ng n&agrave;o cũng sẽ kh&ocirc;ng &aacute;p dụng ch&iacute;nh s&aacute;ch hủy hay ho&agrave;n tiền.</strong></em></p>\r\n', 'https://res.cloudinary.com/dtzbyruu1/image/upload/v1756649932/We2Go%20Upload/hlsfookjcjs4klheebl5.png', 0, NULL, '2025-10-17 19:30:00', '2025-10-17 21:30:00', '3VQ8+24C, Xã Đông Hội, Huyện Đông Anh, Thành Phố Hà Nội', 'Trung tâm Triển lãm Việt Nam (VEC)', 'UPCOMING', 'superfest-2025-concert-mua-he-ruc-sang', '2025-08-31 14:17:13', '2025-08-31 14:21:00', ''),
('ffc9d025-8fdb-4913-a581-acffba4a73fe', '[CAT&MOUSE] Đêm nhạc Phương Thanh - Khi Giấc Mơ Về', '<p>Với kh&ocirc;ng gian được đầu tư&nbsp;<strong>hệ thống &aacute;nh s&aacute;ng - &acirc;m thanh đẳng cấp quốc tế</strong>&nbsp;với sức chứa l&ecirc;n đến&nbsp;<strong>350 người,</strong>&nbsp;c&ugrave;ng quầy bar phục vụ cocktail pha chế độc đ&aacute;o bởi bartender chuy&ecirc;n nghiệp.</p>\r\n\r\n<p>&nbsp;<strong>&quot;PHƯƠNG THANH - Đ&Ecirc;M CỦA GIẤC MƠ TRỞ VỀ&quot;</strong>&nbsp;tại Cat&amp;Mouse Live Music l&agrave; một sự kết hợp đầy mong đợi tr&ecirc;n c&ugrave;ng một s&acirc;n khấu khi một giọng h&aacute;t nội lực, truyền cảm phối c&ugrave;ng giai điệu được tạo n&ecirc;n từ những tay guitar - trống v&agrave; keyboard chuy&ecirc;n nghiệp từ&nbsp;<strong>WereCats band.&nbsp;</strong>Một đ&ecirc;m diễn s&acirc;u lắng v&agrave; cổ điển d&agrave;nh ri&ecirc;ng cho c&aacute;c t&igrave;nh y&ecirc;u của&nbsp;<strong>Cat&amp;Mouse.</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Địa chỉ sau s&aacute;p nhập: 37B Phạm Ngọc Thạch, Phường Xu&acirc;n H&ograve;a, Th&agrave;nh phố Hồ Ch&iacute; Minh</p>\r\n\r\n<p>Gi&aacute; v&eacute; đ&atilde; bao gồm VAT</p>\r\n\r\n<p>Gi&aacute; v&eacute; kh&ocirc;ng bao gồm nước v&agrave; đồ ăn</p>\r\n\r\n<p><strong><em>Sơ đồ sự kiện<br />\r\n<img alt=\"\" src=\"https://salt.tkbcdn.com/ts/ds/89/dc/6b/972df37162d1f803f1c0d6f3afe954bb.png\" style=\"height:564px; width:1000px\" /><img alt=\"\" src=\"https://salt.tkbcdn.com/ts/ds/0e/85/a4/100a8e206a240d57e8481b44c771e8d7.png\" style=\"height:548px; width:1000px\" /></em></strong></p>\r\n', 'https://res.cloudinary.com/dtzbyruu1/image/upload/v1756647893/We2Go%20Upload/eysnnblgmbheqzm3gen6.png', 0, NULL, '2025-06-09 20:00:00', '2025-06-09 12:00:00', '37B Phạm Ngọc Thạch, Phường Võ Thị Sáu, Quận 3, Thành Phố Hồ Chí Minh', 'Cat&Mouse Live Music', 'UPCOMING', 'catmouse-dem-nhac-phuong-thanh-khi-giac-mo-ve', '2025-08-31 13:43:15', '2025-08-31 13:43:15', '');

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
('0a1277d5-c6f8-4cec-8974-de1505d71bc3', 'Vé thường', 'aa7de78f-2c88-439a-9867-bdcf43f69e5e', 300000.00, 200, 0, '2025-08-31 14:06:09', '2025-08-31 14:06:09'),
('168e15a2-2f42-4d9a-bd2e-802b03100d4f', 'STANDAR', 'c7ff0588-0467-42dc-be24-ddf58ba2fabc', 200000.00, 1000, 0, '2025-08-31 11:12:25', '2025-08-31 11:48:18'),
('21e80b19-8dd1-4330-8641-1b67f5544efc', 'Standard', '9fc0dfe1-2f84-4a76-8ca7-4215eececded', 330000.00, 300, 0, '2025-08-31 14:09:51', '2025-08-31 14:09:51'),
('25e65235-c832-40f4-af07-755a670ddef4', 'Vé thường ', 'ae990e65-1f30-4339-891c-2312f03bbd38', 300000.00, 150, 0, '2025-08-31 14:06:09', '2025-08-31 14:06:09'),
('372c59a3-a7cb-43dc-8e4e-fd2ce7dd4d23', 'Vé 1', '19d0e285-8fea-469a-8f0e-fdbc47c445ee', 100000.00, 0, 0, '2025-08-31 11:15:34', '2025-08-31 11:47:17'),
('77608a9d-5acb-4a82-a153-48e758807ac6', 'Vé thường ', 'a5bafc6b-280d-4c0f-917f-ff534a6c48cd', 300000.00, 150, 0, '2025-08-31 14:06:09', '2025-08-31 14:06:09'),
('7bfc0d81-f491-43f5-97c5-f23fea0e40ad', 'VIP', 'c7ff0588-0467-42dc-be24-ddf58ba2fabc', 600000.00, 100, 0, '2025-08-31 11:15:33', '2025-08-31 11:48:18'),
('83424cc2-5a2e-4a7f-be8a-127a928efa17', 'Nham thạch (standing)', '4ff55bbb-46ff-4057-8bc1-7ba3ae78f8df', 3000000.00, 30, 0, '2025-08-31 13:05:20', '2025-08-31 13:05:20'),
('a7bd2369-946d-4c09-94ae-f240c0e82379', 'Standard', 'ac6385f3-0bdd-40aa-928c-30a292113464', 1200000.00, 400, 0, '2025-08-31 14:14:51', '2025-08-31 14:14:51'),
('ddd4ad35-360a-4780-8511-116b4424012a', 'Standard ', 'c3904654-e9f2-4987-a0c0-a624132e7e09', 1200000.00, 400, 0, '2025-08-31 14:14:51', '2025-08-31 14:14:51'),
('dfd0f85d-8cfc-4d02-9c5e-5aacdfb012a0', 'Vé thường ', '955de4d6-c992-4ce1-99c8-7a5c7670c643', 300000.00, 150, 0, '2025-08-31 14:06:09', '2025-08-31 14:06:09'),
('dfdf962a-7e69-4b04-8aff-5691321909fb', 'Vé thường ', '72d6a1db-37d0-45f4-9730-c89e2aeaf91f', 300000.00, 150, 0, '2025-08-31 14:06:09', '2025-08-31 14:06:09'),
('e7801e10-73f5-414c-950f-b38cbdb8b3e4', 'Vé thường ', '34fe9b4e-0a44-4e64-8b31-e82f15a8c199', 300000.00, 200, 0, '2025-08-31 14:06:09', '2025-08-31 14:06:09');

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
('02302672-9901-43a8-a210-464019643216', '80c90730-bba9-4d23-8d39-001c3796f007', 'Student - C', 'STAND', '', 100, '2025-08-31 13:59:28', '2025-08-31 13:59:28'),
('0d6385c5-e004-41ae-b83a-9434b443d451', 'cffe08c5-db36-465b-9f12-3f307c1fc813', 'Toả Sáng 1 (seated)', 'SEAT', '', 100, '2025-08-31 14:21:00', '2025-08-31 14:21:00'),
('18947635-f1ff-4e8c-9d19-f006ca9f7503', '80c90730-bba9-4d23-8d39-001c3796f007', 'Student - L', 'STAND', '', 100, '2025-08-31 13:59:28', '2025-08-31 13:59:28'),
('19d0e285-8fea-469a-8f0e-fdbc47c445ee', '753df965-79c5-47db-b9e6-54e0708cebba', 'Safe Zone', 'STAND', 'Hahahahahahaha', 100, '2025-08-30 15:25:49', '2025-08-31 11:17:35'),
('1b4cb045-04cb-410e-a658-ac127e65b6b2', '14146a98-5781-4db2-a08b-0b9020a9a547', 'Standard - L', 'STAND', '', 100, '2025-08-31 14:25:14', '2025-08-31 14:25:14'),
('2229849f-8b36-461d-8376-820237d6d79d', '1b9f9a44-65c9-4198-81e3-a2bba82192e5', 'Zone F', 'STAND', '', 100, '2025-08-31 14:12:36', '2025-08-31 14:12:36'),
('2c317334-cedb-41eb-8eba-a47d7bd86fee', '1b9f9a44-65c9-4198-81e3-a2bba82192e5', 'Zone D', 'STAND', '', 100, '2025-08-31 14:12:36', '2025-08-31 14:12:36'),
('2f909e8e-09a3-4a01-99b8-0f3880605b6a', '1b9f9a44-65c9-4198-81e3-a2bba82192e5', 'Zone C', 'STAND', '', 100, '2025-08-31 14:12:36', '2025-08-31 14:12:36'),
('3476ed07-b0d1-4411-82ea-d126b157b521', 'cffe08c5-db36-465b-9f12-3f307c1fc813', 'Siêu Anh (Seated)', 'SEAT', '', 100, '2025-08-31 14:20:59', '2025-08-31 14:20:59'),
('34fe9b4e-0a44-4e64-8b31-e82f15a8c199', '276243b0-26d8-4549-8047-a96ca7dd45c1', 'KHU VỰC ĐỨNG E', 'STAND', '', 100, '2025-08-31 14:05:01', '2025-08-31 14:05:01'),
('3fbb56b4-0f7a-4b9e-ada9-be4511e7e3bc', '14146a98-5781-4db2-a08b-0b9020a9a547', 'SUPER VIP - C', 'STAND', '', 100, '2025-08-31 14:25:14', '2025-08-31 14:25:14'),
('407dd07a-ca2a-4d64-b487-2505b71e93bd', '80c90730-bba9-4d23-8d39-001c3796f007', 'VIP - R', 'STAND', '', 100, '2025-08-31 13:59:28', '2025-08-31 13:59:28'),
('41d43a7e-3e10-45d5-b2f8-16c4badc0919', '14146a98-5781-4db2-a08b-0b9020a9a547', 'SUPER VIP - R', 'STAND', '', 100, '2025-08-31 14:25:14', '2025-08-31 14:25:14'),
('431a1bf3-965c-4466-acf1-784d8cadbd8a', '14146a98-5781-4db2-a08b-0b9020a9a547', 'Standard - R', 'STAND', '', 100, '2025-08-31 14:25:14', '2025-08-31 14:25:14'),
('4349cdff-65d6-41b1-947e-3cec1ba06b2a', '80c90730-bba9-4d23-8d39-001c3796f007', 'PREMIUM - C', 'STAND', '', 100, '2025-08-31 13:59:28', '2025-08-31 13:59:28'),
('43fe558f-37fd-46f2-8feb-d431bf6eac07', '14146a98-5781-4db2-a08b-0b9020a9a547', 'SUPER VIP - L', 'STAND', '', 100, '2025-08-31 14:25:14', '2025-08-31 14:25:14'),
('465a1845-ac04-4eb0-a0d1-54148ed7aec7', '80c90730-bba9-4d23-8d39-001c3796f007', 'VIP - L', 'STAND', '', 100, '2025-08-31 13:59:28', '2025-08-31 13:59:28'),
('47362dca-06f0-4377-b1c7-a675a5e95625', '892b2646-2a54-4d18-9df1-8b80811e895d', 'VIP - C', 'STAND', '', 100, '2025-08-31 14:09:51', '2025-08-31 14:09:51'),
('4ff55bbb-46ff-4057-8bc1-7ba3ae78f8df', '1b9f9a44-65c9-4198-81e3-a2bba82192e5', 'Zone A', 'STAND', '', 100, '2025-08-31 13:04:31', '2025-08-31 13:04:31'),
('59e0954a-496b-4e78-a435-7522bad75e55', '80c90730-bba9-4d23-8d39-001c3796f007', 'PREMIUM - L ', 'SEAT', '', 100, '2025-08-31 13:59:28', '2025-08-31 13:59:28'),
('5bbdcc17-10f7-4456-a39c-73d8c5395419', '892b2646-2a54-4d18-9df1-8b80811e895d', 'Standard - R', 'STAND', '', 100, '2025-08-31 14:09:51', '2025-08-31 14:09:51'),
('605401e0-6854-47e0-b8ee-458fb8c0aac8', 'cffe08c5-db36-465b-9f12-3f307c1fc813', 'Toả Sáng 2 (seated)', 'SEAT', '', 100, '2025-08-31 14:21:00', '2025-08-31 14:21:00'),
('68bd308a-0fe2-413f-8bf9-be79b9c90b5b', '14146a98-5781-4db2-a08b-0b9020a9a547', 'VIP - L', 'STAND', '', 100, '2025-08-31 14:25:14', '2025-08-31 14:25:14'),
('72d6a1db-37d0-45f4-9730-c89e2aeaf91f', '276243b0-26d8-4549-8047-a96ca7dd45c1', 'KHU VỰC ĐỨNG C', 'STAND', '', 100, '2025-08-31 14:05:01', '2025-08-31 14:05:01'),
('7526defd-4e02-4876-8f74-ca92dd1dd102', '14146a98-5781-4db2-a08b-0b9020a9a547', 'VIP - R', 'STAND', '', 100, '2025-08-31 14:25:14', '2025-08-31 14:25:14'),
('78ad1cdd-b617-4119-9fff-6ccfbad80ae3', 'a7e72d22-2ad8-422c-86d1-32b098d21037', 'VIP - L', 'STAND', '', 100, '2025-08-31 14:14:51', '2025-08-31 14:14:51'),
('852a5c79-541d-4748-be79-9072fe26d8b7', '892b2646-2a54-4d18-9df1-8b80811e895d', 'VIP - L', 'STAND', '', 100, '2025-08-31 14:09:51', '2025-08-31 14:09:51'),
('8be4e46b-69a3-4c11-8a93-3667a1ab3a86', '14146a98-5781-4db2-a08b-0b9020a9a547', 'Standard - C', 'STAND', '', 100, '2025-08-31 14:25:14', '2025-08-31 14:25:14'),
('8d70a786-af0f-43ba-b0db-ab2f8cd1dee5', '892b2646-2a54-4d18-9df1-8b80811e895d', 'VIP - R', 'STAND', '', 100, '2025-08-31 14:09:51', '2025-08-31 14:09:51'),
('955de4d6-c992-4ce1-99c8-7a5c7670c643', '276243b0-26d8-4549-8047-a96ca7dd45c1', 'KHU VỰC ĐỨNG F', 'STAND', '', 100, '2025-08-31 14:05:01', '2025-08-31 14:05:01'),
('9a76589c-6071-4cf9-aadd-ec1ca700c5cf', '1b9f9a44-65c9-4198-81e3-a2bba82192e5', 'Zone E', 'STAND', '', 100, '2025-08-31 14:12:36', '2025-08-31 14:12:36'),
('9dc4a3bb-299d-4349-889f-ca8da67f4f97', '897adc82-cd65-4ad3-a6a0-9cc7d75d5e35', 'CAT 3', 'STAND', '', 100, '2025-08-31 13:33:04', '2025-08-31 13:33:04'),
('9fc0dfe1-2f84-4a76-8ca7-4215eececded', '892b2646-2a54-4d18-9df1-8b80811e895d', 'Standard - L', 'STAND', '', 100, '2025-08-31 14:07:49', '2025-08-31 14:08:14'),
('a30a04c9-88a2-4c29-885a-4897f2879bea', 'cffe08c5-db36-465b-9f12-3f307c1fc813', 'Ngôi Sao 1 (seated)', 'SEAT', '', 100, '2025-08-31 14:19:05', '2025-08-31 14:19:05'),
('a4afcc51-3b18-43ee-ab40-02000ee4b3e2', '80c90730-bba9-4d23-8d39-001c3796f007', 'PREMIUM - R', 'STAND', '', 100, '2025-08-31 13:59:28', '2025-08-31 13:59:28'),
('a4bb7bb4-dbe7-430e-beb4-ef45518d6c8c', '14146a98-5781-4db2-a08b-0b9020a9a547', 'VIP - C', 'STAND', '', 100, '2025-08-31 14:25:14', '2025-08-31 14:25:14'),
('a5bafc6b-280d-4c0f-917f-ff534a6c48cd', '276243b0-26d8-4549-8047-a96ca7dd45c1', 'KHU VỰC ĐỨNG A', 'STAND', '', 100, '2025-08-31 14:05:01', '2025-08-31 14:05:01'),
('a9867107-92cf-41c1-9711-426ab05b15f6', 'ce46b6e4-8bf5-4f5a-8045-4bf2aa71d050', 'VIP', 'STAND', '', 100, '2025-08-31 13:49:50', '2025-08-31 13:49:50'),
('aa7de78f-2c88-439a-9867-bdcf43f69e5e', '276243b0-26d8-4549-8047-a96ca7dd45c1', 'KHU VỰC ĐỨNG D', 'STAND', '', 100, '2025-08-31 14:05:01', '2025-08-31 14:05:01'),
('ac6385f3-0bdd-40aa-928c-30a292113464', 'a7e72d22-2ad8-422c-86d1-32b098d21037', 'Standard - C', 'SEAT', '', 120, '2025-08-31 13:37:58', '2025-08-31 14:14:51'),
('ad575437-825c-4993-9dc4-458fda1f5fc4', '897adc82-cd65-4ad3-a6a0-9cc7d75d5e35', 'VIP ', 'SEAT', '', 120, '2025-08-31 13:33:04', '2025-08-31 13:33:04'),
('ae990e65-1f30-4339-891c-2312f03bbd38', '276243b0-26d8-4549-8047-a96ca7dd45c1', 'KHU VỰC ĐỨNG B', 'STAND', '', 100, '2025-08-31 14:05:01', '2025-08-31 14:05:01'),
('b29c5081-a47d-4087-8202-e633347c93fd', 'cffe08c5-db36-465b-9f12-3f307c1fc813', 'Kỳ Quan 1 (Seated)', 'SEAT', '', 100, '2025-08-31 14:18:17', '2025-08-31 14:18:17'),
('ba0df91b-21b9-429a-bc1f-d86830c3f447', '897adc82-cd65-4ad3-a6a0-9cc7d75d5e35', 'CAT 1', 'SEAT', '', 100, '2025-08-31 13:33:04', '2025-08-31 13:33:04'),
('bea1bad8-f2d6-4224-af3e-ce360460c2a0', 'ce46b6e4-8bf5-4f5a-8045-4bf2aa71d050', 'Khán đài', 'STAND', 'Khu vực khán đài trước sân khấu', 200, '2025-08-31 13:49:50', '2025-08-31 13:49:50'),
('bff5567a-6280-4634-bc07-2ca1fb40f64a', 'cffe08c5-db36-465b-9f12-3f307c1fc813', 'Kỳ Quan 2 (Seated)', 'SEAT', '', 100, '2025-08-31 14:18:17', '2025-08-31 14:18:17'),
('c3904654-e9f2-4987-a0c0-a624132e7e09', 'a7e72d22-2ad8-422c-86d1-32b098d21037', 'Standard - L', 'STAND', '', 100, '2025-08-31 13:37:58', '2025-08-31 14:14:51'),
('c7889b1e-4b5f-4fca-8d33-668a5091adc4', 'a7e72d22-2ad8-422c-86d1-32b098d21037', 'VIP - R', 'STAND', '', 100, '2025-08-31 14:14:51', '2025-08-31 14:14:51'),
('c7ff0588-0467-42dc-be24-ddf58ba2fabc', '753df965-79c5-47db-b9e6-54e0708cebba', 'Danger Zone ', 'STAND', 'Hehehehehehehehe', 200, '2025-08-30 04:55:15', '2025-08-31 11:11:51'),
('d83e1d1a-228e-4294-bf7d-1a5a349b931d', '892b2646-2a54-4d18-9df1-8b80811e895d', 'Standard - C', 'STAND', '', 100, '2025-08-31 14:09:51', '2025-08-31 14:09:51'),
('ea58fec0-2eca-47be-b2c0-1491d05b2af3', 'ce46b6e4-8bf5-4f5a-8045-4bf2aa71d050', 'Standard ', 'STAND', '', 120, '2025-08-31 13:49:50', '2025-08-31 13:49:50'),
('ec9002c6-23a8-4a8c-95bf-76e1bb7357ee', '80c90730-bba9-4d23-8d39-001c3796f007', 'VIP - C', 'STAND', '', 100, '2025-08-31 13:59:28', '2025-08-31 13:59:28'),
('ecc9be94-5d73-4af5-9b0f-af7edd401355', '80c90730-bba9-4d23-8d39-001c3796f007', 'Student - R', 'STAND', '', 100, '2025-08-31 13:59:28', '2025-08-31 13:59:28'),
('ee054b28-0de0-4d43-b8e4-3e8c6173300f', 'a7e72d22-2ad8-422c-86d1-32b098d21037', 'Standard - R', 'STAND', '', 100, '2025-08-31 14:14:51', '2025-08-31 14:14:51'),
('f22cbc31-21ab-4c10-b4d8-24b97445cf70', 'cffe08c5-db36-465b-9f12-3f307c1fc813', 'Ngôi Sao 2 (seated)', 'SEAT', '', 100, '2025-08-31 14:19:05', '2025-08-31 14:19:05'),
('f42db506-65e8-428c-a9e8-2c6084c84914', 'cffe08c5-db36-465b-9f12-3f307c1fc813', 'Siêu Chị (Seated)', 'SEAT', '', 100, '2025-08-31 14:21:00', '2025-08-31 14:21:00'),
('f62e18c6-0eb6-464f-a316-2e0e530cb1d5', '1b9f9a44-65c9-4198-81e3-a2bba82192e5', 'Zone B', 'STAND', '', 100, '2025-08-31 14:12:36', '2025-08-31 14:12:36'),
('f6f7f353-3e8d-4756-b1ce-6df97ff64b30', '897adc82-cd65-4ad3-a6a0-9cc7d75d5e35', 'CAT 2', 'SEAT', '', 100, '2025-08-31 13:33:04', '2025-08-31 13:33:04');

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
