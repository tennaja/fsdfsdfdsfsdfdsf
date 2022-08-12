-- phpMyAdmin SQL Dump
-- version 4.9.10
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 12, 2022 at 05:31 PM
-- Server version: 10.2.25-MariaDB-log
-- PHP Version: 7.4.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


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
('3a135720-11cc-11ed-90a6-6550599aff2d', '920', '2022-08-02', 'ส่งแล้ว', ''),
('9575cf80-11cc-11ed-9b61-8523dfdcf9b4', '330', '2022-08-02', 'สินค้ายังไม่ครบ', ''),
('329ac180-17d1-11ed-a9e7-7520656f2450', '90', '2022-08-09', 'ส่งแล้ว', '2'),
('916268a0-17f7-11ed-87c2-1db6f49e10bb', '630', '2022-08-09', 'ส่งแล้ว', '1'),
('d305b8d0-1819-11ed-a3b9-712a28551b30', '390', '2022-08-10', 'สินค้ายังไม่ครบ', '1'),
('1fe9d680-1a14-11ed-b973-69575302a577', '660', '2022-08-12', 'ส่งแล้ว', '2');

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
(39, '1', '3', '600', '2022-08-12', '1fe9d680-1a14-11ed-b973-69575302a577');

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
  `product_type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `product_name`, `product_detail`, `product_image`, `product_price`, `product_quantity`, `export_product`, `import_product`, `product_type_id`) VALUES
(1, 'น้ำตาลตรามิตรผล', 'มันคือแป้ง', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F0070100.jpg?alt=media&token=6f74df1d-ee1d-4ac3-814f-0c9758edf099', 200, 1000, 0, 0, 2),
(2, 'sunsilk', 'ad', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F096a1ed0-2b44-437a-afab-22362adc0ad8_large.jpg?alt=media&token=79663d93-98d2-4389-8cda-1d04ef15f594', 60, 1000, 0, 0, 3),
(3, 'สบู่แคร์', '***คำอธิบาย**', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F186870-01-bath-hair-care.jpg?alt=media&token=b5316469-3f02-47f9-aef1-8d09a212f5fc', 30, 1000, 0, 0, 3),
(4, 'ฝอยขัดหม้อ', '***คำอธิบาย**', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F19_09_18_floor_01.jpg?alt=media&token=71a90e82-7bbc-4eca-b4d6-6f851db1832e', 30, 1000, 0, 0, 3),
(5, 'สบู่Lux', '***คำอธิบาย**', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F1d238b301ee81f2b99cab88744a98456.jpg?alt=media&token=a8c79607-9f1f-41cf-99f7-ccea4b79849d', 30, 1000, 0, 0, 3),
(6, 'น้ำปลาตราหอยหลอด', '***คำอธิบาย**', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F22_4.jpg?alt=media&token=ab13c2ef-c822-4844-8a44-67b4ddba344c', 30, 1000, 0, 0, 2),
(7, 'สบู่ตราprotect', '***คำอธิบาย**', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F298be91c6f134217b4a77ce6622fee57.jpg?alt=media&token=d1f5e148-496f-4fbf-9ae1-cf914d99ce58', 30, 1000, 0, 0, 3),
(8, 'น้ำปลาตราปลาหมึก', '***คำอธิบาย**', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F384333_010_Supermarket.jpg?alt=media&token=218bc789-112e-431f-a107-6cb55ead9cbd', 30, 1000, 0, 0, 2),
(9, 'ยาสีฟันตราSPARKEL', '***คำอธิบาย**', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F387478_00_Sparkle.jpg?alt=media&token=ad23e774-ab8e-441f-b54d-000f2db4dabc', 30, 1000, 0, 0, 3),
(10, 'น้ำปลาตราทิพรส', '***คำอธิบาย**', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F393899_010_Supermarket.jpg?alt=media&token=6eabaf1b-3dba-436b-b43b-a20769ab2401', 30, 1000, 0, 0, 2),
(11, 'Sunslik', '***คำอธิบาย**', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F3bdde077247c08cdfbd06e8c79faf1d2_tn.jpg?alt=media&token=158e1b8a-f631-4e20-a2d3-6f4614cc7a9e', 30, 1000, 0, 0, 3),
(12, 'สก๊อตไบร์ท', '***คำอธิบาย**', 'https://firebasestorage.googleapis.com/v0/b/bakery203.appspot.com/o/product_image%2F580700000133.jpg?alt=media&token=1f0ef7ca-0280-4b1c-a594-8ab91dc7723f', 30, 1000, 0, 0, 3);

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
(1, 'ข้าวสาร'),
(2, 'เครื่องปรุง'),
(3, 'ของใช้');

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
(2, 'supako', 'panjaiyen', '0917301938', 'art@gmail.com', '123456', 0, 0, 'rider'),
(3, 'supakon', 'panjaiyne', '082222235', 'test2@gmail.com', '123456', 37.4219983, -122.084, 'customer'),
(4, 'rider', '133', '015486244', 'rider@gmail.com', '123456', 0, 0, 'rider'),
(5, 'sqluser', 'Admin', '0123456789', 'sql@gmail.com', '123456', 0, 0, 'admin');

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
('12e707a0-1942-11ed-80b3-bddc945b5459', 'test2@gmail.com', 'null', 'null', 'art@gmail.com', '810', 'มีคนรับแล้ว', '0000-00-00'),
('0ab3fc40-1a10-11ed-98a5-c1692052a52c', 'test2@gmail.com', 'null', 'null', 'ยังไม่มีคนรับผิดชอบ', '2070', 'ยังไม่มีใครรับ', '2022-08-12'),
('2fa56200-1a10-11ed-944f-4f5f8eb1277f', 'test2@gmail.com', 'null', 'null', 'art@gmail.com', '120', 'มีคนรับแล้ว', '2022-08-12'),
('03482d00-1a24-11ed-98e1-a3480aa9e6a2', 'test2@gmail.com', 'null', 'null', 'ยังไม่มีคนรับผิดชอบ', '2070', 'ยังไม่มีใครรับ', '2022-08-12'),
('46b2c820-1a24-11ed-86b2-abe585a3899d', 'test2@gmail.com', 'null', 'null', 'ยังไม่มีคนรับผิดชอบ', '30', 'ยังไม่มีใครรับ', '2022-08-12'),
('5590a100-1a24-11ed-b759-919e586bf97d', 'test2@gmail.com', 'null', 'null', 'ยังไม่มีคนรับผิดชอบ', '270', 'ยังไม่มีใครรับ', '2022-08-12'),
('65101ba0-1a25-11ed-98d2-a5563f567153', 'test2@gmail.com', 'null', 'null', 'ยังไม่มีคนรับผิดชอบ', '120', 'ยังไม่มีใครรับ', '2022-08-12'),
('d4a7d910-1a27-11ed-8108-1d943daf83e5', 'test2@gmail.com', '37.4219983', '37.4219983', 'ยังไม่มีคนรับผิดชอบ', '270', 'ยังไม่มีใครรับ', '2022-08-12'),
('2f891380-1a28-11ed-90b1-69d32ec4a9c6', 'test2@gmail.com', '37.4219983', '37.4219983', 'ยังไม่มีคนรับผิดชอบ', '270', 'ยังไม่มีใครรับ', '2022-08-12'),
('4fa2d980-1a28-11ed-a2ee-8912f413ef49', 'test2@gmail.com', '37.4219983', '-122.084', 'art@gmail.com', '270', 'มีคนรับแล้ว', '2022-08-12');

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
(22, '12e707a0-1942-11ed-80b3-bddc945b5459', 4, 3, '30', 270),
(23, '12e707a0-1942-11ed-80b3-bddc945b5459', 11, 3, '30', 270),
(24, '12e707a0-1942-11ed-80b3-bddc945b5459', 8, 3, '30', 270),
(27, '0ab3fc40-1a10-11ed-98a5-c1692052a52c', 5, 3, '30', 270),
(28, '0ab3fc40-1a10-11ed-98a5-c1692052a52c', 1, 3, '200', 1800),
(29, '2fa56200-1a10-11ed-944f-4f5f8eb1277f', 6, 2, '30', 120),
(30, '03482d00-1a24-11ed-98e1-a3480aa9e6a2', 1, 3, '200', 1800),
(31, '03482d00-1a24-11ed-98e1-a3480aa9e6a2', 4, 3, '30', 270),
(32, '46b2c820-1a24-11ed-86b2-abe585a3899d', 6, 1, '30', 30),
(33, '5590a100-1a24-11ed-b759-919e586bf97d', 6, 3, '30', 270),
(34, 'b4ed5170-1a24-11ed-af49-3da3424546c7', 6, 3, '30', 270),
(35, 'e95a56b0-1a24-11ed-85c7-2d12c4bb7d46', 6, 3, '30', 270),
(36, 'e95a56b0-1a24-11ed-85c7-2d12c4bb7d46', 9, 3, '30', 270),
(37, '65101ba0-1a25-11ed-98d2-a5563f567153', 6, 2, '30', 120),
(38, 'd4a7d910-1a27-11ed-8108-1d943daf83e5', 8, 3, '30', 270),
(39, '2f891380-1a28-11ed-90b1-69d32ec4a9c6', 10, 3, '30', 270),
(40, '4fa2d980-1a28-11ed-a2ee-8912f413ef49', 8, 3, '30', 270);

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
  MODIFY `basket_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `import_order_detail`
--
ALTER TABLE `import_order_detail`
  MODIFY `order_detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `product_type`
--
ALTER TABLE `product_type`
  MODIFY `product_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `source`
--
ALTER TABLE `source`
  MODIFY `source_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(255) NOT NULL AUTO_INCREMENT COMMENT 'รหัสผู้ใช้', AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user_basket`
--
ALTER TABLE `user_basket`
  MODIFY `user_basket_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `user_order_detail`
--
ALTER TABLE `user_order_detail`
  MODIFY `order_detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
