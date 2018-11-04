-- MySQL dump 10.13  Distrib 5.6.36, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: postcodify
-- ------------------------------------------------------
-- Server version	5.6.36-1~dotdeb+7.1-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `postcodify_addresses`
--

DROP TABLE IF EXISTS `postcodify_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `postcodify_addresses` (
  `id` int(11) NOT NULL,
  `postcode5` char(5) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `postcode6` char(6) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `road_id` decimal(14,0) DEFAULT NULL,
  `num_major` smallint(5) unsigned DEFAULT NULL,
  `num_minor` smallint(5) unsigned DEFAULT NULL,
  `is_basement` tinyint(1) DEFAULT '0',
  `dongri_ko` varchar(80) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `dongri_en` varchar(80) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `jibeon_major` smallint(5) unsigned DEFAULT NULL,
  `jibeon_minor` smallint(5) unsigned DEFAULT NULL,
  `is_mountain` tinyint(1) DEFAULT '0',
  `building_id` decimal(25,0) DEFAULT NULL,
  `building_name` varchar(80) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `building_nums` varchar(120) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `other_addresses` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `updated` decimal(8,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `postcodify_addresses_road_id` (`road_id`),
  KEY `postcodify_addresses_num_major` (`num_major`),
  KEY `postcodify_addresses_num_minor` (`num_minor`),
  KEY `postcodify_addresses_postcode5` (`postcode5`),
  KEY `postcodify_addresses_postcode6` (`postcode6`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `postcodify_buildings`
--

DROP TABLE IF EXISTS `postcodify_buildings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `postcodify_buildings` (
  `seq` int(11) NOT NULL,
  `address_id` int(11) NOT NULL,
  `keyword` varchar(5000) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`seq`),
  KEY `postcodify_buildings_address_id` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `postcodify_english`
--

DROP TABLE IF EXISTS `postcodify_english`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `postcodify_english` (
  `seq` int(11) NOT NULL,
  `ko` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ko_crc32` int(10) unsigned DEFAULT NULL,
  `en` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `en_crc32` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`seq`),
  KEY `postcodify_english_ko` (`ko`),
  KEY `postcodify_english_ko_crc32` (`ko_crc32`),
  KEY `postcodify_english_en` (`en`),
  KEY `postcodify_english_en_crc32` (`en_crc32`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `postcodify_keywords`
--

DROP TABLE IF EXISTS `postcodify_keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `postcodify_keywords` (
  `seq` int(11) NOT NULL,
  `address_id` int(11) NOT NULL,
  `keyword_crc32` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`seq`),
  KEY `postcodify_keywords_address_id` (`address_id`),
  KEY `postcodify_keywords_keyword_crc32` (`keyword_crc32`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `postcodify_numbers`
--

DROP TABLE IF EXISTS `postcodify_numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `postcodify_numbers` (
  `seq` int(11) NOT NULL,
  `address_id` int(11) NOT NULL,
  `num_major` smallint(5) unsigned DEFAULT NULL,
  `num_minor` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`seq`),
  KEY `postcodify_numbers_address_id` (`address_id`),
  KEY `postcodify_numbers_num_major` (`num_major`),
  KEY `postcodify_numbers_num_minor` (`num_minor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `postcodify_pobox`
--

DROP TABLE IF EXISTS `postcodify_pobox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `postcodify_pobox` (
  `seq` int(11) NOT NULL,
  `address_id` int(11) NOT NULL,
  `keyword` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `range_start_major` smallint(5) unsigned DEFAULT NULL,
  `range_start_minor` smallint(5) unsigned DEFAULT NULL,
  `range_end_major` smallint(5) unsigned DEFAULT NULL,
  `range_end_minor` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`seq`),
  KEY `postcodify_pobox_address_id` (`address_id`),
  KEY `postcodify_pobox_range_start_major` (`range_start_major`),
  KEY `postcodify_pobox_range_start_minor` (`range_start_minor`),
  KEY `postcodify_pobox_range_end_major` (`range_end_major`),
  KEY `postcodify_pobox_range_end_minor` (`range_end_minor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `postcodify_ranges_jibeon`
--

DROP TABLE IF EXISTS `postcodify_ranges_jibeon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `postcodify_ranges_jibeon` (
  `seq` int(11) NOT NULL,
  `sido_ko` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `sido_en` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `sigungu_ko` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `sigungu_en` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ilbangu_ko` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ilbangu_en` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `eupmyeon_ko` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `eupmyeon_en` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `dongri_ko` varchar(80) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `dongri_en` varchar(80) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `range_start_major` smallint(5) unsigned DEFAULT NULL,
  `range_start_minor` smallint(5) unsigned DEFAULT NULL,
  `range_end_major` smallint(5) unsigned DEFAULT NULL,
  `range_end_minor` smallint(5) unsigned DEFAULT NULL,
  `is_mountain` tinyint(1) DEFAULT '0',
  `admin_dongri` varchar(80) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `postcode5` char(5) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`seq`),
  KEY `postcodify_ranges_jibeon_sido_ko` (`sido_ko`),
  KEY `postcodify_ranges_jibeon_sigungu_ko` (`sigungu_ko`),
  KEY `postcodify_ranges_jibeon_ilbangu_ko` (`ilbangu_ko`),
  KEY `postcodify_ranges_jibeon_eupmyeon_ko` (`eupmyeon_ko`),
  KEY `postcodify_ranges_jibeon_dongri_ko` (`dongri_ko`),
  KEY `postcodify_ranges_jibeon_range_start_major` (`range_start_major`),
  KEY `postcodify_ranges_jibeon_range_start_minor` (`range_start_minor`),
  KEY `postcodify_ranges_jibeon_range_end_major` (`range_end_major`),
  KEY `postcodify_ranges_jibeon_range_end_minor` (`range_end_minor`),
  KEY `postcodify_ranges_jibeon_admin_dongri` (`admin_dongri`),
  KEY `postcodify_ranges_jibeon_postcode5` (`postcode5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `postcodify_ranges_oldcode`
--

DROP TABLE IF EXISTS `postcodify_ranges_oldcode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `postcodify_ranges_oldcode` (
  `seq` int(11) NOT NULL,
  `sido_ko` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `sido_en` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `sigungu_ko` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `sigungu_en` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ilbangu_ko` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ilbangu_en` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `eupmyeon_ko` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `eupmyeon_en` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `dongri_ko` varchar(80) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `dongri_en` varchar(80) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `range_start_major` smallint(5) unsigned DEFAULT NULL,
  `range_start_minor` smallint(5) unsigned DEFAULT NULL,
  `range_end_major` smallint(5) unsigned DEFAULT NULL,
  `range_end_minor` smallint(5) unsigned DEFAULT NULL,
  `is_mountain` tinyint(1) DEFAULT '0',
  `island_name` varchar(80) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `building_name` varchar(80) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `building_num_start` smallint(5) unsigned DEFAULT NULL,
  `building_num_end` smallint(5) unsigned DEFAULT NULL,
  `postcode6` char(6) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`seq`),
  KEY `postcodify_ranges_oldcode_sido_ko` (`sido_ko`),
  KEY `postcodify_ranges_oldcode_sigungu_ko` (`sigungu_ko`),
  KEY `postcodify_ranges_oldcode_ilbangu_ko` (`ilbangu_ko`),
  KEY `postcodify_ranges_oldcode_eupmyeon_ko` (`eupmyeon_ko`),
  KEY `postcodify_ranges_oldcode_dongri_ko` (`dongri_ko`),
  KEY `postcodify_ranges_oldcode_range_start_major` (`range_start_major`),
  KEY `postcodify_ranges_oldcode_range_start_minor` (`range_start_minor`),
  KEY `postcodify_ranges_oldcode_range_end_major` (`range_end_major`),
  KEY `postcodify_ranges_oldcode_range_end_minor` (`range_end_minor`),
  KEY `postcodify_ranges_oldcode_postcode6` (`postcode6`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `postcodify_ranges_roads`
--

DROP TABLE IF EXISTS `postcodify_ranges_roads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `postcodify_ranges_roads` (
  `seq` int(11) NOT NULL,
  `sido_ko` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `sido_en` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `sigungu_ko` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `sigungu_en` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ilbangu_ko` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ilbangu_en` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `eupmyeon_ko` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `eupmyeon_en` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `road_name_ko` varchar(80) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `road_name_en` varchar(80) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `range_start_major` smallint(5) unsigned DEFAULT NULL,
  `range_start_minor` smallint(5) unsigned DEFAULT NULL,
  `range_end_major` smallint(5) unsigned DEFAULT NULL,
  `range_end_minor` smallint(5) unsigned DEFAULT NULL,
  `range_type` tinyint(1) DEFAULT '0',
  `is_basement` tinyint(1) DEFAULT '0',
  `postcode5` char(5) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`seq`),
  KEY `postcodify_ranges_roads_sido_ko` (`sido_ko`),
  KEY `postcodify_ranges_roads_sigungu_ko` (`sigungu_ko`),
  KEY `postcodify_ranges_roads_ilbangu_ko` (`ilbangu_ko`),
  KEY `postcodify_ranges_roads_eupmyeon_ko` (`eupmyeon_ko`),
  KEY `postcodify_ranges_roads_road_name_ko` (`road_name_ko`),
  KEY `postcodify_ranges_roads_range_start_major` (`range_start_major`),
  KEY `postcodify_ranges_roads_range_start_minor` (`range_start_minor`),
  KEY `postcodify_ranges_roads_range_end_major` (`range_end_major`),
  KEY `postcodify_ranges_roads_range_end_minor` (`range_end_minor`),
  KEY `postcodify_ranges_roads_range_type` (`range_type`),
  KEY `postcodify_ranges_roads_postcode5` (`postcode5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `postcodify_roads`
--

DROP TABLE IF EXISTS `postcodify_roads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `postcodify_roads` (
  `road_id` decimal(14,0) NOT NULL,
  `road_name_ko` varchar(80) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `road_name_en` varchar(120) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `sido_ko` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `sido_en` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `sigungu_ko` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `sigungu_en` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ilbangu_ko` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ilbangu_en` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `eupmyeon_ko` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `eupmyeon_en` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `updated` decimal(8,0) DEFAULT NULL,
  PRIMARY KEY (`road_id`),
  KEY `postcodify_roads_sido_ko` (`sido_ko`),
  KEY `postcodify_roads_sigungu_ko` (`sigungu_ko`),
  KEY `postcodify_roads_ilbangu_ko` (`ilbangu_ko`),
  KEY `postcodify_roads_eupmyeon_ko` (`eupmyeon_ko`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `postcodify_settings`
--

DROP TABLE IF EXISTS `postcodify_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `postcodify_settings` (
  `k` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `v` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`k`),
  KEY `postcodify_settings_k` (`k`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-04 14:47:09
