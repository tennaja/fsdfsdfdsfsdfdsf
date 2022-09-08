-- phpMyAdmin SQL Dump
-- version 4.9.10
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 03, 2022 at 04:39 PM
-- Server version: 10.2.25-MariaDB-log
-- PHP Version: 7.4.25


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `web5_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `basket`
--

CREATE TABLE `basket` (
  `basket_id` int(11) NOT NULL,
  `basket_product_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `basket_product_quantity` int(11) NOT NULL,
  `basket_product_pricetotal` float NOT NULL,
  `basket_product_source` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `import_order`
--

CREATE TABLE `import_order` (
  `Import_order_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Import_product_pricetotal` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Import_date` date NOT NULL,
  `Import_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Import_source_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `import_order`
--

INSERT INTO `import_order` (`Import_order_id`, `Import_product_pricetotal`, `Import_date`, `Import_status`, `Import_source_id`) VALUES
('329ac180-17d1-11ed-a9e7-7520656f2450', '90', '2022-08-09', 'ส่งแล้ว', '2'),
('916268a0-17f7-11ed-87c2-1db6f49e10bb', '630', '2022-08-09', 'ส่งแล้ว', '1'),
('d305b8d0-1819-11ed-a3b9-712a28551b30', '390', '2022-08-10', 'ส่งแล้ว', '1'),
('1fe9d680-1a14-11ed-b973-69575302a577', '660', '2022-08-12', 'ส่งแล้ว', '2'),
('0750f0a0-1bbc-11ed-ae9d-d30a0cb85bbc', '800', '2022-08-14', 'ส่งแล้ว', '1'),
('d0d6f790-1c6f-11ed-950f-7563a9412445', '300', '2022-08-15', 'ส่งแล้ว', '1'),
('a4ca58c0-1c71-11ed-b605-633bf19d36d0', '300', '2022-08-15', 'สินค้ายังไม่ครบ', '1');

-- --------------------------------------------------------

--
-- Table structure for table `import_order_detail`
--

CREATE TABLE `import_order_detail` (
  `order_detail_id` int(11) NOT NULL,
  `basket_product_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `basket_product_quantity` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `basket_product_pricetotal` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `DateTime` date NOT NULL,
  `Import_order_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `import_order_detail`
--

INSERT INTO `import_order_detail` (`order_detail_id`, `basket_product_id`, `basket_product_quantity`, `basket_product_pricetotal`, `DateTime`, `Import_order_id`) VALUES
(4, '1', '4', '800', '2022-08-02', '3a135720-11cc-11ed-90a6-6550599aff2d'),
(5, '4', '4', '120', '2022-08-02', '3a135720-11cc-11ed-90a6-6550599aff2d'),
(6, '2', '4', '240', '2022-08-02', '9575cf80-11cc-11ed-9b61-8523dfdcf9b4'),
(7, '3', '3', '90', '2022-08-02', '9575cf80-11cc-11ed-9b61-8523dfdcf9b4'),
(29, '4', '1', '30', '2022-08-09', '329ac180-17d1-11ed-a9e7-7520656f2450'),
(30, '3', '2', '60', '2022-08-09', '329ac180-17d1-11ed-a9e7-7520656f2450'),
(31, '6', '1', '30', '2022-08-09', '916268a0-17f7-11ed-87c2-1db6f49e10bb'),
(32, '1', '3', '600', '2022-08-09', '916268a0-17f7-11ed-87c2-1db6f49e10bb'),
(35, '4', '3', '90', '2022-08-10', 'd305b8d0-1819-11ed-a3b9-712a28551b30'),
(36, '2', '3', '180', '2022-08-10', 'd305b8d0-1819-11ed-a3b9-712a28551b30'),
(37, '2', '2', '120', '2022-08-10', 'd305b8d0-1819-11ed-a3b9-712a28551b30'),
(38, '2', '1', '60', '2022-08-12', '1fe9d680-1a14-11ed-b973-69575302a577'),
(39, '1', '3', '600', '2022-08-12', '1fe9d680-1a14-11ed-b973-69575302a577'),
(41, '1', '4', '800', '2022-08-14', '0750f0a0-1bbc-11ed-ae9d-d30a0cb85bbc'),
(48, '2', '5', '300', '2022-08-15', 'd0d6f790-1c6f-11ed-950f-7563a9412445'),
(49, '2', '5', '300', '2022-08-15', 'a4ca58c0-1c71-11ed-b605-633bf19d36d0');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_detail` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_price` int(11) NOT NULL,
  `product_quantity` int(11) NOT NULL,
  `export_product` int(11) NOT NULL,
  `import_product` int(11) NOT NULL,
  `product_type_id` int(11) NOT NULL,
  `product_promotion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `product_name`, `product_detail`, `product_image`, `product_price`, `product_quantity`, `export_product`, `import_product`, `product_type_id`, `product_promotion`) VALUES
(2, 'sunsilk', 'ad', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F096a1ed0-2b44-437a-afab-22362adc0ad8_large.jpg?alt=media&token=79663d93-98d2-4389-8cda-1d04ef15f594', 60, 995, 20, 17, 3, 'โปรโมชั่น 10%'),
(3, 'สบู่แคร์', '***คำอธิบาย**', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F186870-01-bath-hair-care.jpg?alt=media&token=b5316469-3f02-47f9-aef1-8d09a212f5fc', 30, 975, 23, 0, 3, 'โปรโมชั่น 20%'),
(4, 'ฝอยขัดหม้อ', '***คำอธิบาย**', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F19_09_18_floor_01.jpg?alt=media&token=71a90e82-7bbc-4eca-b4d6-6f851db1832e', 30, 991, 13, 6, 3, 'โปรโมชั่น 30%'),
(5, 'สบู่Lux', '***คำอธิบาย**', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F1d238b301ee81f2b99cab88744a98456.jpg?alt=media&token=a8c79607-9f1f-41cf-99f7-ccea4b79849d', 30, 997, 1, 0, 3, 'โปรโมชั่น 30%'),
(6, 'น้ำปลาตราหอยหลอด', '***คำอธิบาย**', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F22_4.jpg?alt=media&token=ab13c2ef-c822-4844-8a44-67b4ddba344c', 30, 996, 2, 0, 2, 'ไม่มีโปรโมชั่น'),
(7, 'สบู่ตราprotect', '***คำอธิบาย**', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F298be91c6f134217b4a77ce6622fee57.jpg?alt=media&token=d1f5e148-496f-4fbf-9ae1-cf914d99ce58', 30, 998, 0, 0, 3, 'โปรโมชั่น 10%'),
(8, 'น้ำปลาตราปลาหมึก', '***คำอธิบาย**', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F384333_010_Supermarket.jpg?alt=media&token=218bc789-112e-431f-a107-6cb55ead9cbd', 30, 998, 0, 0, 2, 'โปรโมชั่น 20%'),
(9, 'ยาสีฟันตราSPARKEL', '***คำอธิบาย**', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F387478_00_Sparkle.jpg?alt=media&token=ad23e774-ab8e-441f-b54d-000f2db4dabc', 30, 998, 0, 0, 3, 'ไม่มีโปรโมชั่น'),
(10, 'น้ำปลาตราทิพรส', '***คำอธิบาย**', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F393899_010_Supermarket.jpg?alt=media&token=6eabaf1b-3dba-436b-b43b-a20769ab2401', 30, 998, 0, 0, 2, 'ไม่มีโปรโมชั่น'),
(11, 'Sunslik', '***คำอธิบาย**', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F3bdde077247c08cdfbd06e8c79faf1d2_tn.jpg?alt=media&token=158e1b8a-f631-4e20-a2d3-6f4614cc7a9e', 30, 992, 6, 0, 3, 'ไม่มีโปรโมชั่น'),
(12, 'สก๊อตไบร์ท', '***คำอธิบาย**', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F580700000133.jpg?alt=media&token=1f0ef7ca-0280-4b1c-a594-8ab91dc7723f', 30, 994, 4, 0, 3, 'ไม่มีโปรโมชั่น'),
(13, 'ข้าวไอยรา', 'คำอธิบาย', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/rice%2Frice1.png?alt=media&token=8ef03bc6-c0ba-4021-9190-24d6362fe7ae', 250, 947, 41, 0, 1, 'ไม่มีโปรโมชั่น'),
(14, 'ข้าวสุพรรณ์หงษ์', 'คำอธิบาย', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/rice%2Frice2.png?alt=media&token=f4f86c6e-3b7b-419d-9bf6-41e6e8d397ca', 250, 982, 16, 0, 1, 'ไม่มีโปรโมชั่น'),
(16, 'ข้าวตราฉัตร', 'คำอธิบาย', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/rice%2Frice3.png?alt=media&token=0d2129f3-1591-4bde-a7e0-5175116ecc98', 250, 992, 6, 0, 1, 'ไม่มีโปรโมชั่น'),
(17, 'ข้าวตราหอมมะลิ', 'คำอธิบาย', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/rice%2Frice3.png?alt=media&token=0d2129f3-1591-4bde-a7e0-5175116ecc98', 250, 998, 0, 0, 1, 'ไม่มีโปรโมชั่น'),
(19, 'ข้าวตราแสนดี1', 'คำอธิบาย', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/rice%2Frice4.png?alt=media&token=735d13a2-b3d3-48ef-9c50-4681780c9dfa', 250, 994, 4, 0, 1, 'โปรโมชั่น 30%'),
(20, 'ข้าวตราฉัตรทอง', 'คำอธิบาย', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/rice%2Frice-1.png?alt=media&token=7ddc70e8-8b43-444d-af47-ca7aafe4a0c9', 250, 992, 6, 0, 1, 'โปรโมชั่น 30%'),
(21, 'ข้าวตราไดรโนเสา', 'คำอธิบาย', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/rice%2F9cfeb5b2ba608cba80c9c895275b50c0.png?alt=media&token=5fdc143d-07ef-452a-a387-dc84678f98de', 250, 990, 8, 0, 1, 'โปรโมชั่น 20%'),
(22, 'ข้าวตราทอง', 'คำอธิบาย', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/rice%2Ff530cd68edb2c035b74bec75de01bd53.png?alt=media&token=ceac8a93-2178-4e94-9754-40633c2e9dbe', 250, 980, 31, 0, 1, 'โปรโมชั่น 10%'),
(28, 'nong', '111', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F0f71e54e-d772-4b06-b6f7-1a5c353288d08956141358626799334.jpg?alt=media&token=b52e09c3-5da6-4cfe-80fd-935b13aebf2c', 11, 11, 0, 0, 1, 'ไม่มีโปรโมชั่น'),
(29, 'asdasda', 'adasdad', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F957e27e5-06b9-4d50-8d0c-29c20104b4487466414898412810929.jpg?alt=media&token=8632482c-773d-4528-86e1-2e9d87b6902a', 111, 111, 0, 0, 1, 'ไม่มีโปรโมชั่น');

-- --------------------------------------------------------

--
-- Table structure for table `product_promotion`
--

CREATE TABLE `product_promotion` (
  `product_id` int(11) NOT NULL,
  `promotion_id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_promotion`
--

INSERT INTO `product_promotion` (`product_id`, `promotion_id`, `start_date`, `end_date`) VALUES
(2, 2, '2022-09-14', '2022-10-14'),
(3, 5, '2022-09-07', '2022-12-07');

-- --------------------------------------------------------

--
-- Table structure for table `product_type`
--

CREATE TABLE `product_type` (
  `product_type_id` int(11) NOT NULL,
  `product_type_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_type`
--

INSERT INTO `product_type` (`product_type_id`, `product_type_name`) VALUES
(1, 'ประเภทข้าวสาร'),
(2, 'ประเภทเครื่องปรุง'),
(3, 'ประเภทของใช้'),
(5, 'เครื่องเทศ');

-- --------------------------------------------------------

--
-- Table structure for table `promotion`
--

CREATE TABLE `promotion` (
  `promotion_id` int(11) NOT NULL,
  `promotion_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `promotion_value` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `promotion`
--

INSERT INTO `promotion` (`promotion_id`, `promotion_name`, `promotion_value`) VALUES
(2, 'โปรโมชั่น 10%', 10),
(5, 'ไม่มีโปรโมชั่น', 1),
(7, 'โปรโมชั่น 20%', 20),
(8, 'โปรโมชั่น 40%', 40),
(9, 'โปรโมชั่น 30%', 30);

-- --------------------------------------------------------

--
-- Table structure for table `rider`
--

CREATE TABLE `rider` (
  `rider_id` int(11) NOT NULL,
  `rider_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rider_surname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rider_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rider_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rider_password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rider_latitude` double NOT NULL,
  `rider_longtitude` double NOT NULL,
  `rider_role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rider`
--

INSERT INTO `rider` (`rider_id`, `rider_name`, `rider_surname`, `rider_phone`, `rider_email`, `rider_password`, `rider_latitude`, `rider_longtitude`, `rider_role`) VALUES
(1, 'rider', 'art', '0977855478', 'rider@gmail.com', '123456', 0, 0, 'rider'),
(2, 'admin', 'test', '0977855478', 'admin@gmail.com', '123456', 0, 0, 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `source`
--

CREATE TABLE `source` (
  `source_id` int(11) NOT NULL,
  `source_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `source`
--

INSERT INTO `source` (`source_id`, `source_name`, `source_number`, `source_address`) VALUES
(1, 'ร้านA', '0815489785', '100หมู่2'),
(2, 'ร้านB', '0874567894', 'หมู่7'),
(3, 'ร้านC', '0874597854', 'หมู่4');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(255) NOT NULL COMMENT 'รหัสผู้ใช้',
  `user_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ชื่อผู้ใช้',
  `user_surname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'นามสกุลผู้ใช้',
  `user_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'เบอร์ผู้ใช้',
  `user_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'อีเมลผู้ใช้',
  `user_password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รหัสผู้ใช้',
  `user_latitude` double NOT NULL,
  `user_longitude` double NOT NULL,
  `user_role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ตำแหน่งผู้ใช้'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `user_name`, `user_surname`, `user_phone`, `user_email`, `user_password`, `user_latitude`, `user_longitude`, `user_role`) VALUES
(2, 'supako', 'panjaiyen', '0917301938', 'art@gmail.com', '123456', 13.8015234, 100.7388424, 'rider'),
(3, 'supakon', 'panjaiyne', '082222235', 'test2@gmail.com', '', 13.7681633, 100.6820733, 'customer'),
(5, 'sqluser', 'Admin', '0123456789', 'sql1@gmail.com', '123456', 0, 0, 'admin'),
(9, 'art', 'art', '0124537896', 'artart@gmail.com', '123456', 13.6468477, 100.6110764, 'customer'),
(10, 'supakon', 'panjaiyen', '0917301938', 'sql@gmai.com', '123456', 0, 0, 'customer'),
(11, 'supakon', 'panjaiyen', '0917301938', 'art2@gmail.com', '123456', 13.7681633, 100.6820733, 'customer'),
(12, 'art', 'supakon3', '0981381938', 'art3@gmail.com', '1234567', 0, 0, 'customer');

-- --------------------------------------------------------

--
-- Table structure for table `user_basket`
--

CREATE TABLE `user_basket` (
  `user_basket_id` int(11) NOT NULL,
  `user_basket_product_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_basket_quantity` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_basket_pricetotal` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_basket_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_order`
--

CREATE TABLE `user_order` (
  `order_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รหัสออเดอร์',
  `order_by` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รหัสผู้สั่ง',
  `user_latitude` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ืที่อยู่1',
  `user_longitude` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ที่อยู่2',
  `order_responsible_person` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'คนรับงาน',
  `total_price` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ราคารวม',
  `order_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'สถานะ',
  `order_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_order`
--

INSERT INTO `user_order` (`order_id`, `order_by`, `user_latitude`, `user_longitude`, `order_responsible_person`, `total_price`, `order_status`, `order_date`) VALUES
('694e7900-1b1f-11ed-8b2f-afc77c74e327', 'test2@gmail.com', '13.7388183', '100.6271417', 'ยังไม่มีคนรับผิดชอบ', '1120', 'รายการที่ยกเลิก', '2022-08-13'),
('f6c89e10-1ba5-11ed-a1ca-1308e8e3cd11', 'test2@gmail.com', '13.7388183', '100.6271417', 'ยังไม่มีคนรับผิดชอบ', '1350', 'รายการที่ยกเลิก', '2022-08-14'),
('8fe0d3c0-1bff-11ed-a5a7-975622ff73f9', 'test2@gmail.com', '13.6761117', '100.6559817', 'rider@gmail.com', '1005', 'ของกำลังส่ง', '2022-08-15'),
('62a4d220-1c00-11ed-9665-11aced57ad8e', 'test2@gmail.com', '13.6761117', '100.6559817', 'rider@gmail.com', '5500', 'ส่งเรียบร้อย', '2022-08-15'),
('3ac4dfe0-1c6c-11ed-a444-a16369339134', 'test2@gmail.com', '13.9480017', '100.5898733', 'rider@gmail.com', '525', 'ส่งเรียบร้อย', '2022-08-15'),
('28d79890-1c76-11ed-b8a2-81de96a53d35', 'test2@gmail.com', '13.9480017', '100.5898733', 'ยังไม่มีคนรับผิดชอบ', '1250', 'ยังไม่มีใครรับ', '2022-08-15'),
('f9685150-1c78-11ed-951d-3396caa659d0', 'test2@gmail.com', '13.7681633', '100.6820733', 'ยังไม่มีคนรับผิดชอบ', '1250', 'ยังไม่มีใครรับ', '2022-08-15'),
('530ac920-1d48-11ed-80b6-f7afb8996f21', 'test2@gmail.com', '13.7681633', '100.6820733', 'ยังไม่มีคนรับผิดชอบ', '180', 'ยังไม่มีใครรับ', '2022-08-16'),
('081ee5c0-28f3-11ed-8443-a5bac6a1f75b', 'test2@gmail.com', '13.7681633', '100.6820733', 'ยังไม่มีคนรับผิดชอบ', '1000', 'ยังไม่มีใครรับ', '2022-08-31'),
('0b1d58b0-28f3-11ed-82af-43b831501a73', 'test2@gmail.com', '13.7681633', '100.6820733', 'ยังไม่มีคนรับผิดชอบ', '1000', 'ยังไม่มีใครรับ', '2022-08-31'),
('5d45e8a0-28f3-11ed-9c88-773f80b59a7e', 'test2@gmail.com', '13.7681633', '100.6820733', 'ยังไม่มีคนรับผิดชอบ', '1000', 'ยังไม่มีใครรับ', '2022-08-31'),
('32991f80-29c7-11ed-9369-87f019fb919d', 'test2@gmail.com', '13.7681633', '100.6820733', 'ยังไม่มีคนรับผิดชอบ', '560', 'ยังไม่มีใครรับ', '2022-09-01'),
('51878a00-2a79-11ed-b327-adf8ab87eea3', 'art@gmail.com', '13.8015234', '100.7388424', 'rider@gmail.com', '662', 'ส่งเรียบร้อย', '2022-09-02');

-- --------------------------------------------------------

--
-- Table structure for table `user_order_detail`
--

CREATE TABLE `user_order_detail` (
  `order_detail_id` int(11) NOT NULL,
  `order_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_amount` int(11) NOT NULL,
  `product_per_price` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_order_detail`
--

INSERT INTO `user_order_detail` (`order_detail_id`, `order_id`, `product_id`, `product_amount`, `product_per_price`, `total`) VALUES
(71, '694e7900-1b1f-11ed-8b2f-afc77c74e327', 12, 4, '30', 120),
(72, '694e7900-1b1f-11ed-8b2f-afc77c74e327', 19, 4, '250', 1000),
(73, 'f6c89e10-1ba5-11ed-a1ca-1308e8e3cd11', 16, 3, '250', 750),
(74, 'f6c89e10-1ba5-11ed-a1ca-1308e8e3cd11', 1, 3, '200', 600),
(75, '8fe0d3c0-1bff-11ed-a5a7-975622ff73f9', 2, 10, '60', 540),
(76, '8fe0d3c0-1bff-11ed-a5a7-975622ff73f9', 3, 10, '30', 240),
(77, '8fe0d3c0-1bff-11ed-a5a7-975622ff73f9', 4, 10, '30', 210),
(78, '8fe0d3c0-1bff-11ed-a5a7-975622ff73f9', 5, 1, '30', 15),
(79, '62a4d220-1c00-11ed-9665-11aced57ad8e', 22, 20, '250', 4500),
(80, '62a4d220-1c00-11ed-9665-11aced57ad8e', 21, 5, '250', 1000),
(81, '3ac4dfe0-1c6c-11ed-a444-a16369339134', 20, 3, '250', 525),
(82, '28d79890-1c76-11ed-b8a2-81de96a53d35', 13, 5, '250', 1250),
(83, 'f9685150-1c78-11ed-951d-3396caa659d0', 13, 5, '250', 1250),
(84, '530ac920-1d48-11ed-80b6-f7afb8996f21', 3, 3, '30', 72),
(85, '530ac920-1d48-11ed-80b6-f7afb8996f21', 2, 2, '60', 108),
(86, '081ee5c0-28f3-11ed-8443-a5bac6a1f75b', 13, 2, '250', 500),
(87, '081ee5c0-28f3-11ed-8443-a5bac6a1f75b', 14, 2, '250', 500),
(88, '0b1d58b0-28f3-11ed-82af-43b831501a73', 13, 2, '250', 500),
(89, '0b1d58b0-28f3-11ed-82af-43b831501a73', 14, 2, '250', 500),
(90, '5d45e8a0-28f3-11ed-9c88-773f80b59a7e', 14, 2, '250', 500),
(91, '5d45e8a0-28f3-11ed-9c88-773f80b59a7e', 13, 2, '250', 500),
(92, '32991f80-29c7-11ed-9369-87f019fb919d', 13, 2, '250', 500),
(93, '32991f80-29c7-11ed-9369-87f019fb919d', 6, 2, '30', 60),
(94, '51878a00-2a79-11ed-b327-adf8ab87eea3', 13, 2, '250', 500),
(95, '51878a00-2a79-11ed-b327-adf8ab87eea3', 2, 3, '60', 162);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `basket`
--
ALTER TABLE `basket`
  ADD PRIMARY KEY (`basket_id`);

--
-- Indexes for table `import_order_detail`
--
ALTER TABLE `import_order_detail`
  ADD PRIMARY KEY (`order_detail_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `product_type`
--
ALTER TABLE `product_type`
  ADD PRIMARY KEY (`product_type_id`);

--
-- Indexes for table `promotion`
--
ALTER TABLE `promotion`
  ADD PRIMARY KEY (`promotion_id`);

--
-- Indexes for table `rider`
--
ALTER TABLE `rider`
  ADD PRIMARY KEY (`rider_id`);

--
-- Indexes for table `source`
--
ALTER TABLE `source`
  ADD PRIMARY KEY (`source_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `user_basket`
--
ALTER TABLE `user_basket`
  ADD PRIMARY KEY (`user_basket_id`);

--
-- Indexes for table `user_order_detail`
--
ALTER TABLE `user_order_detail`
  ADD PRIMARY KEY (`order_detail_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `basket`
--
ALTER TABLE `basket`
  MODIFY `basket_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `import_order_detail`
--
ALTER TABLE `import_order_detail`
  MODIFY `order_detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `product_type`
--
ALTER TABLE `product_type`
  MODIFY `product_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `promotion`
--
ALTER TABLE `promotion`
  MODIFY `promotion_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `rider`
--
ALTER TABLE `rider`
  MODIFY `rider_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `source`
--
ALTER TABLE `source`
  MODIFY `source_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(255) NOT NULL AUTO_INCREMENT COMMENT 'รหัสผู้ใช้', AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `user_basket`
--
ALTER TABLE `user_basket`
  MODIFY `user_basket_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;

--
-- AUTO_INCREMENT for table `user_order_detail`
--
ALTER TABLE `user_order_detail`
  MODIFY `order_detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
