-- phpMyAdmin SQL Dump
-- version 4.6.0
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 30, 2017 at 01:44 AM
-- Server version: 5.6.30
-- PHP Version: 5.6.20-pl0-gentoo

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `zpijlb`
--

-- --------------------------------------------------------

--
-- Table structure for table `icu_device`
--

CREATE TABLE `icu_device` (
  `id` varchar(4) NOT NULL,
  `first_ip` varchar(15) NOT NULL,
  `human_name` varchar(16) DEFAULT NULL,
  `datetime_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_request` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `icu_device`
--

INSERT INTO `icu_device` (`id`, `first_ip`, `human_name`, `datetime_added`, `last_request`) VALUES
('1001', '82.72.141.49', NULL, '2017-11-29 22:27:46', NULL),
('2C4F', '192.168.1.3', NULL, '2017-11-24 13:06:00', '2017-11-23 15:44:09'),
('541F', '82.72.141.49', 'blaas', '2017-11-24 13:49:10', '2017-11-29 19:48:11'),
('6499', '185.56.227.7', NULL, '2017-11-29 10:29:26', '2017-11-29 10:29:50'),
('8340', '185.56.227.7', '', '2017-11-29 10:17:50', '2017-11-29 10:17:51'),
('8D1E', '185.56.227.7', 'Mijn naam', '2017-11-29 10:25:10', '2017-11-29 10:25:15'),
('8E62', '185.56.227.7', 'droopec', '2017-11-29 10:11:48', '2017-11-29 10:11:53'),
('9DAF', '185.56.227.7', NULL, '2017-11-29 10:14:15', '2017-11-29 10:14:38'),
('A45F', '192.168.0.1', 'Greet', '2017-11-29 22:05:18', '2017-11-29 22:05:18'),
('B313', '185.56.227.7', NULL, '2017-11-29 10:32:16', '2017-11-29 10:32:27'),
('B362', '185.56.227.7', NULL, '2017-11-29 10:22:14', '2017-11-29 10:22:16'),
('B5F6', '185.56.227.7', NULL, '2017-11-29 10:21:36', '2017-11-29 10:21:36'),
('BA93', '185.56.227.7', NULL, '2017-11-29 10:19:10', '2017-11-29 10:19:12'),
('CBC8', '185.56.227.7', NULL, '2017-11-29 10:27:08', '2017-11-29 10:27:10'),
('D37E', '185.56.227.7', 'Breez', '2017-11-29 09:55:22', '2017-11-29 09:56:17');

-- --------------------------------------------------------

--
-- Table structure for table `icu_device_configuration`
--

CREATE TABLE `icu_device_configuration` (
  `device_id` varchar(4) NOT NULL,
  `target_device_id` varchar(4) NOT NULL,
  `color` varchar(11) NOT NULL,
  `spring` tinyint(3) UNSIGNED DEFAULT NULL,
  `damp` tinyint(3) UNSIGNED DEFAULT NULL,
  `message` longtext,
  `blacklist` tinyint(1) NOT NULL DEFAULT '0',
  `temp` tinyint(1) DEFAULT '0',
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `icu_device_configuration`
--

INSERT INTO `icu_device_configuration` (`device_id`, `target_device_id`, `color`, `spring`, `damp`, `message`, `blacklist`, `temp`, `date_added`) VALUES
('2C4F', '2C4F', '#91FF00', 186, 36, 'Blub', 0, 0, '2017-11-22 09:33:01'),
('8D1E', '2C4F', '#00FFFF', 128, 128, '', 0, 0, '2017-11-29 21:44:05'),
('541F', '541F', '#F700FF', 128, 41, '', 0, 0, '2017-11-29 12:16:24'),
('8D1E', '541F', '#26FF00', 128, 128, '', 0, 0, '2017-11-29 21:43:35'),
('8E62', '541F', '#A6FF00', 99, 199, '', 0, 0, '2017-11-30 00:01:34'),
('D37E', '541F', '#00FFFF', 128, 128, '', 0, 0, '2017-11-30 00:04:38'),
('8D1E', 'A45F', '#FF0000', 1, 3, 'hoihoi', 0, 0, '2017-11-29 22:06:40'),
('8D1E', 'BA93', '#00FFFF', 128, 128, '', 0, 0, '2017-11-29 21:43:54'),
('8E62', 'CBC8', '#FB00FF', 128, 128, '', 0, 0, '2017-11-30 00:02:10'),
('D37E', 'CBC8', '#00FFFF', 128, 128, '', 0, 0, '2017-11-30 00:05:34'),
('BA93', 'D37E', '#FF0000', 1, 1, 'cdsv', 0, 0, '2017-11-29 22:07:33');

-- --------------------------------------------------------

--
-- Table structure for table `icu_queue`
--

CREATE TABLE `icu_queue` (
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `target_device_id` varchar(4) NOT NULL,
  `device_id` varchar(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `icu_device`
--
ALTER TABLE `icu_device`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `icu_device_configuration`
--
ALTER TABLE `icu_device_configuration`
  ADD PRIMARY KEY (`target_device_id`,`device_id`),
  ADD KEY `fk_queue_device_idx` (`device_id`),
  ADD KEY `fk_queue_device1_idx` (`target_device_id`);

--
-- Indexes for table `icu_queue`
--
ALTER TABLE `icu_queue`
  ADD PRIMARY KEY (`timestamp`,`target_device_id`,`device_id`),
  ADD KEY `fk_queue_device_configuration1_idx` (`target_device_id`,`device_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `icu_device_configuration`
--
ALTER TABLE `icu_device_configuration`
  ADD CONSTRAINT `fk_queue_device` FOREIGN KEY (`device_id`) REFERENCES `icu_device` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_queue_device1` FOREIGN KEY (`target_device_id`) REFERENCES `icu_device` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `icu_queue`
--
ALTER TABLE `icu_queue`
  ADD CONSTRAINT `fk_queue_device_configuration1` FOREIGN KEY (`target_device_id`,`device_id`) REFERENCES `icu_device_configuration` (`target_device_id`, `device_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
