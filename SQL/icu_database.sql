-- phpMyAdmin SQL Dump
-- version 4.2.12deb2+deb8u2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 07, 2018 at 12:38 AM
-- Server version: 5.5.59-0+deb8u1
-- PHP Version: 5.6.33-0+deb8u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `connectiklaas`
--

-- --------------------------------------------------------

--
-- Table structure for table `icu_device`
--

CREATE TABLE IF NOT EXISTS `icu_device` (
  `id` varchar(4) NOT NULL,
  `first_ip` varchar(15) NOT NULL,
  `human_name` varchar(16) DEFAULT NULL,
  `datetime_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_request` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- --------------------------------------------------------

--
-- Table structure for table `icu_device_configuration`
--

CREATE TABLE IF NOT EXISTS `icu_device_configuration` (
  `device_id` varchar(4) NOT NULL,
  `target_device_id` varchar(4) NOT NULL,
  `color` varchar(11) NOT NULL,
  `spring` tinyint(3) unsigned DEFAULT NULL,
  `damp` tinyint(3) unsigned DEFAULT NULL,
  `message` longtext,
  `blacklist` tinyint(1) NOT NULL DEFAULT '0',
  `temp` tinyint(1) DEFAULT '0',
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Table structure for table `icu_queue`
--

CREATE TABLE IF NOT EXISTS `icu_queue` (
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
 ADD PRIMARY KEY (`target_device_id`,`device_id`), ADD KEY `fk_queue_device_idx` (`device_id`), ADD KEY `fk_queue_device1_idx` (`target_device_id`);

--
-- Indexes for table `icu_queue`
--
ALTER TABLE `icu_queue`
 ADD PRIMARY KEY (`timestamp`,`target_device_id`,`device_id`), ADD KEY `fk_queue_device_configuration1_idx` (`target_device_id`,`device_id`);

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
ADD CONSTRAINT `fk_queue_device_configuration1` FOREIGN KEY (`target_device_id`, `device_id`) REFERENCES `icu_device_configuration` (`target_device_id`, `device_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

