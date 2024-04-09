-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 09, 2024 at 07:43 AM
-- Server version: 10.5.20-MariaDB
-- PHP Version: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `id21953977_tratour`
--
CREATE DATABASE IF NOT EXISTS `id21953977_tratour` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `id21953977_tratour`;

-- --------------------------------------------------------

--
-- Table structure for table `articles`
--

CREATE TABLE `articles` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `file_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `source` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE `files` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `url` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jenis_sampah`
--

CREATE TABLE `jenis_sampah` (
  `id_jenis` int(11) NOT NULL,
  `nama_jenis` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `id_jenis` int(11) NOT NULL,
  `pickup_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pickup`
--

CREATE TABLE `pickup` (
  `shipment_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `id_jenis` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` int(15) DEFAULT NULL,
  `password` varchar(50) NOT NULL,
  `user_type` tinyint(1) DEFAULT NULL,
  `user_point` int(11) DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `referral_code` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `phone`, `password`, `user_type`, `user_point`, `profile_image`, `referral_code`, `created_at`, `updated_at`) VALUES
(7, 'Candra Ganteng', 'felizia060110@gmail.com', 2147483647, 'qwerqwer', 1, 0, NULL, '5fw2rn', '2024-03-03 23:08:31', '2024-03-03 23:08:31'),
(11, 'Dodi Deno', 'namadepannamabelakang@gmail.com', 86849947, 'qwerqwer', 1, 0, NULL, 'uhy3s7', '2024-03-05 21:31:40', '2024-03-05 21:31:40'),
(51, 'user123', 'user123@example.com', 123456789, 'password123', 1, 0, 'path/to/image.jpg', 'ABC123', '2024-03-07 06:44:50', '2024-03-07 06:44:50'),
(64, 'Imam Mahdi', 'aarevaananda@gmail.com', 8864664, 'qwerqwer', 1, 0, NULL, 'zlz68o', NULL, NULL),
(76, 'hhxkkx', 'tes@gmail.com', 6466474, 'qwerqwer', 1, 0, NULL, '6te0em', '2024-03-09 05:23:10', '2024-03-09 05:23:10'),
(77, 'ushejsij', 'tes2@gmail.com', 99445, 'qwerqwer', 1, 0, NULL, 'lq1eyo', '2024-03-09 05:24:20', '2024-03-09 05:24:20');

-- --------------------------------------------------------

--
-- Table structure for table `waste_types`
--

CREATE TABLE `waste_types` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cretaed_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `files_user_id_id` (`user_id`);

--
-- Indexes for table `jenis_sampah`
--
ALTER TABLE `jenis_sampah`
  ADD PRIMARY KEY (`id_jenis`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `pickup_id` (`pickup_id`),
  ADD KEY `id_jenis` (`id_jenis`);

--
-- Indexes for table `pickup`
--
ALTER TABLE `pickup`
  ADD PRIMARY KEY (`shipment_id`),
  ADD KEY `shipment_id` (`shipment_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `id_jenis` (`id_jenis`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_email` (`email`);

--
-- Indexes for table `waste_types`
--
ALTER TABLE `waste_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `waste_types_user_id_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `articles`
--
ALTER TABLE `articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `files`
--
ALTER TABLE `files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `waste_types`
--
ALTER TABLE `waste_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `files_user_id_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `Orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `Orders_ibfk_2` FOREIGN KEY (`pickup_id`) REFERENCES `pickup` (`shipment_id`),
  ADD CONSTRAINT `Orders_ibfk_3` FOREIGN KEY (`id_jenis`) REFERENCES `jenis_sampah` (`id_jenis`);

--
-- Constraints for table `pickup`
--
ALTER TABLE `pickup`
  ADD CONSTRAINT `Pickup_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `Pickup_ibfk_2` FOREIGN KEY (`id_jenis`) REFERENCES `jenis_sampah` (`id_jenis`);

--
-- Constraints for table `waste_types`
--
ALTER TABLE `waste_types`
  ADD CONSTRAINT `waste_types_user_id_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
