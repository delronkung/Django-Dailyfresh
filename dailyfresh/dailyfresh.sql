-- MySQL dump 10.13  Distrib 5.7.19, for Linux (x86_64)
--
-- Host: localhost    Database: dailyfresh
-- ------------------------------------------------------
-- Server version	5.7.19-0ubuntu0.16.04.1-log

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permissi_content_type_id_2f476e4b_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add user',6,'add_user'),(17,'Can change user',6,'change_user'),(18,'Can delete user',6,'delete_user'),(19,'Can add address',7,'add_address'),(20,'Can change address',7,'change_address'),(21,'Can delete address',7,'delete_address'),(22,'Can add goods category',8,'add_goodscategory'),(23,'Can change goods category',8,'change_goodscategory'),(24,'Can delete goods category',8,'delete_goodscategory'),(25,'Can add goods',9,'add_goods'),(26,'Can change goods',9,'change_goods'),(27,'Can delete goods',9,'delete_goods'),(28,'Can add goods sku',10,'add_goodssku'),(29,'Can change goods sku',10,'change_goodssku'),(30,'Can delete goods sku',10,'delete_goodssku'),(31,'Can add goods image',11,'add_goodsimage'),(32,'Can change goods image',11,'change_goodsimage'),(33,'Can delete goods image',11,'delete_goodsimage'),(34,'Can add index goods banner',12,'add_indexgoodsbanner'),(35,'Can change index goods banner',12,'change_indexgoodsbanner'),(36,'Can delete index goods banner',12,'delete_indexgoodsbanner'),(37,'Can add index category goods banner',13,'add_indexcategorygoodsbanner'),(38,'Can change index category goods banner',13,'change_indexcategorygoodsbanner'),(39,'Can delete index category goods banner',13,'delete_indexcategorygoodsbanner'),(40,'Can add index promotion banner',14,'add_indexpromotionbanner'),(41,'Can change index promotion banner',14,'change_indexpromotionbanner'),(42,'Can delete index promotion banner',14,'delete_indexpromotionbanner'),(43,'Can add shopping cart',15,'add_shoppingcart'),(44,'Can change shopping cart',15,'change_shoppingcart'),(45,'Can delete shopping cart',15,'delete_shoppingcart'),(46,'Can add order info',16,'add_orderinfo'),(47,'Can change order info',16,'change_orderinfo'),(48,'Can delete order info',16,'delete_orderinfo'),(49,'Can add order goods',17,'add_ordergoods'),(50,'Can change order goods',17,'change_ordergoods'),(51,'Can delete order goods',17,'delete_ordergoods'),(52,'Can add Bookmark',18,'add_bookmark'),(53,'Can change Bookmark',18,'change_bookmark'),(54,'Can delete Bookmark',18,'delete_bookmark'),(55,'Can add User Setting',19,'add_usersettings'),(56,'Can change User Setting',19,'change_usersettings'),(57,'Can delete User Setting',19,'delete_usersettings'),(58,'Can add User Widget',20,'add_userwidget'),(59,'Can change User Widget',20,'change_userwidget'),(60,'Can delete User Widget',20,'delete_userwidget'),(61,'Can add log entry',21,'add_log'),(62,'Can change log entry',21,'change_log'),(63,'Can delete log entry',21,'delete_log'),(64,'Can add revision',22,'add_revision'),(65,'Can change revision',22,'change_revision'),(66,'Can delete revision',22,'delete_revision'),(67,'Can add version',23,'add_version'),(68,'Can change version',23,'change_version'),(69,'Can delete version',23,'delete_version'),(70,'Can view log entry',1,'view_logentry'),(71,'Can view group',3,'view_group'),(72,'Can view permission',2,'view_permission'),(73,'Can view shopping cart',15,'view_shoppingcart'),(74,'Can view content type',4,'view_contenttype'),(75,'Can view 商品',9,'view_goods'),(76,'Can view 商品类别',8,'view_goodscategory'),(77,'Can view 商品图片',11,'view_goodsimage'),(78,'Can view 商品SKU',10,'view_goodssku'),(79,'Can view 主页分类展示商品',13,'view_indexcategorygoodsbanner'),(80,'Can view 主页轮播商品',12,'view_indexgoodsbanner'),(81,'Can view 主页促销活动',14,'view_indexpromotionbanner'),(82,'Can view order goods',17,'view_ordergoods'),(83,'Can view order info',16,'view_orderinfo'),(84,'Can view address',7,'view_address'),(85,'Can view user',6,'view_user'),(86,'Can view revision',22,'view_revision'),(87,'Can view version',23,'view_version'),(88,'Can view session',5,'view_session'),(89,'Can view Bookmark',18,'view_bookmark'),(90,'Can view log entry',21,'view_log'),(91,'Can view User Setting',19,'view_usersettings'),(92,'Can view User Widget',20,'view_userwidget');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_address`
--

DROP TABLE IF EXISTS `df_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `receiver_name` varchar(20) NOT NULL,
  `receiver_mobile` varchar(11) NOT NULL,
  `detail_addr` varchar(256) NOT NULL,
  `zip_code` varchar(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_address_user_id_5e6a5c8a_fk_df_users_id` (`user_id`),
  CONSTRAINT `df_address_user_id_5e6a5c8a_fk_df_users_id` FOREIGN KEY (`user_id`) REFERENCES `df_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_address`
--

LOCK TABLES `df_address` WRITE;
/*!40000 ALTER TABLE `df_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_cart`
--

DROP TABLE IF EXISTS `df_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `count` int(11) NOT NULL,
  `sku_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_cart_sku_id_c9120efe_fk_df_goods_sku_id` (`sku_id`),
  KEY `df_cart_e8701ad4` (`user_id`),
  CONSTRAINT `df_cart_sku_id_c9120efe_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`),
  CONSTRAINT `df_cart_user_id_215a0aa0_fk_df_users_id` FOREIGN KEY (`user_id`) REFERENCES `df_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_cart`
--

LOCK TABLES `df_cart` WRITE;
/*!40000 ALTER TABLE `df_cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_goods`
--

DROP TABLE IF EXISTS `df_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `name` varchar(100) NOT NULL,
  `title` varchar(200) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_goods_b583a629` (`category_id`),
  CONSTRAINT `df_goods_category_id_59d58e6d_fk_df_goods_category_id` FOREIGN KEY (`category_id`) REFERENCES `df_goods_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_goods`
--

LOCK TABLES `df_goods` WRITE;
/*!40000 ALTER TABLE `df_goods` DISABLE KEYS */;
INSERT INTO `df_goods` VALUES (1,'2017-10-15 03:53:57.215906','2017-10-15 03:53:57.216003','草莓','草莓简介',1,2),(2,'2017-10-15 03:54:12.510948','2017-10-15 03:54:12.511131','葡萄','葡萄简介',1,2),(3,'2017-10-15 03:54:27.884249','2017-10-15 03:54:27.884340','柠檬','柠檬简介',1,2),(4,'2017-10-15 03:54:48.506372','2017-10-15 03:54:48.506465','奇异果','奇异果简介',1,2),(5,'2017-10-15 04:03:23.130002','2017-10-15 04:03:23.130096','大青虾','大青虾描述',1,3),(6,'2017-10-15 04:03:35.075158','2017-10-15 04:03:35.075331','扇贝','扇贝描述',1,3),(7,'2017-10-15 04:03:47.996538','2017-10-15 04:03:47.996643','冷冻秋刀鱼','冷冻秋刀鱼简介',1,3),(8,'2017-10-15 04:04:00.204602','2017-10-15 04:04:00.204782','基围虾','基围虾简介',1,3),(9,'2017-10-15 04:04:27.454215','2017-10-15 04:04:27.454307','牛排','牛排简介',1,4),(10,'2017-10-15 04:04:42.932859','2017-10-15 04:04:42.932950','羊肉','羊肉简介',1,4),(11,'2017-10-15 04:04:55.127578','2017-10-15 04:04:55.127671','猪肉','猪肉简介',1,4),(12,'2017-10-15 04:05:10.427498','2017-10-15 04:05:10.427591','猪排骨','猪排骨简介',1,4),(13,'2017-10-15 04:05:26.691566','2017-10-15 04:05:26.691664','鸡肉','鸡肉简介',1,5),(14,'2017-10-15 04:05:35.828392','2017-10-15 04:05:35.828483','鸡蛋','鸡蛋简介',1,5),(15,'2017-10-15 04:05:46.092810','2017-10-15 04:05:46.092977','鸭蛋','鸭蛋简介',1,5),(16,'2017-10-15 04:06:09.355594','2017-10-15 04:06:09.355698','鸡胸脯肉','鸡胸脯肉',1,5),(17,'2017-10-15 04:06:26.832938','2017-10-15 04:06:26.833099','白菜','白菜简介',1,6),(18,'2017-10-15 04:06:39.464105','2017-10-15 04:06:39.464223','芹菜','芹菜简介',1,6),(19,'2017-10-15 04:06:49.509735','2017-10-15 04:06:49.509828','香菜','香菜简介',1,6),(20,'2017-10-15 04:07:06.614781','2017-10-15 04:07:06.614865','冬瓜','冬瓜简介',1,6),(21,'2017-10-15 04:07:22.446523','2017-10-15 04:07:22.446614','鱼丸','鱼丸简介',1,7),(22,'2017-10-15 04:07:37.017331','2017-10-15 04:07:37.017418','虾丸','虾丸简介',1,7),(23,'2017-10-15 04:07:51.826950','2017-10-15 04:07:51.827056','速冻水饺','速冻水饺简介',1,7),(24,'2017-10-15 04:08:15.172403','2017-10-15 04:08:15.172498','汤圆','汤圆简介',1,7);
/*!40000 ALTER TABLE `df_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_goods_category`
--

DROP TABLE IF EXISTS `df_goods_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_goods_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `name` varchar(20) NOT NULL,
  `logo` varchar(100) NOT NULL,
  `image` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_goods_category`
--

LOCK TABLES `df_goods_category` WRITE;
/*!40000 ALTER TABLE `df_goods_category` DISABLE KEYS */;
INSERT INTO `df_goods_category` VALUES (2,'2017-10-15 03:22:36.953762','2017-10-15 03:22:36.953864','新鲜水果','fruit','group1/M00/00/00/CtM3BVni1H2ARPiXAAAmv27pX4k6813735'),(3,'2017-10-15 03:25:07.624594','2017-10-15 03:25:07.624688','海鲜水产','seafood','group1/M00/00/00/CtM3BVni1ROAfEx_AABHr3RQqFs9725322'),(4,'2017-10-15 03:25:25.828665','2017-10-15 03:25:25.828756','猪牛羊肉','meet','group1/M00/00/00/CtM3BVni1SWAIoj7AAAy1Tlm9So3453860'),(5,'2017-10-15 03:25:48.400021','2017-10-15 03:25:48.400120','禽类蛋品','egg','group1/M00/00/00/CtM3BVni1TyAYcUMAAAqR4DoSUg6268631'),(6,'2017-10-15 03:26:04.658369','2017-10-15 03:26:04.658457','新鲜蔬菜','vegetables','group1/M00/00/00/CtM3BVni1UyAa0zLAAA-0ZoYkpM0253895'),(7,'2017-10-15 03:26:18.642437','2017-10-15 03:26:18.642623','速冻食品','ice','group1/M00/00/00/CtM3BVni1VqAWa8fAAA3sZPrVzQ4050337');
/*!40000 ALTER TABLE `df_goods_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_goods_image`
--

DROP TABLE IF EXISTS `df_goods_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_goods_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `image` varchar(100) NOT NULL,
  `sku_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_goods_image_22ad5bca` (`sku_id`),
  CONSTRAINT `df_goods_image_sku_id_f8dc96ea_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_goods_image`
--

LOCK TABLES `df_goods_image` WRITE;
/*!40000 ALTER TABLE `df_goods_image` DISABLE KEYS */;
INSERT INTO `df_goods_image` VALUES (1,'2017-10-15 04:15:53.576153','2017-10-15 04:15:53.576261','group1/M00/00/00/CtM3BVni4PqACMLaAAAljHPuXJg1468332',1),(2,'2017-10-15 04:16:21.917321','2017-10-15 04:16:21.917461','group1/M00/00/00/CtM3BVni4RWAUSg1AAAljHPuXJg3689968',2),(3,'2017-10-15 04:16:32.041974','2017-10-15 04:16:32.042127','group1/M00/00/00/CtM3BVni4SCANYeOAAAiQjDS7wA6251295',3),(4,'2017-10-15 04:16:49.488183','2017-10-15 04:21:07.278131','group1/M00/00/00/CtM3BVni4TGAfX5nAAAiQjDS7wA3589312',4),(5,'2017-10-15 04:16:58.138581','2017-10-15 04:21:11.873227','group1/M00/00/00/CtM3BVni4TqAba-sAAAlcPqsn-E1949836',5),(6,'2017-10-15 04:17:06.825918','2017-10-15 04:21:16.550565','group1/M00/00/00/CtM3BVni4UKAHm0pAAAcye9XGMY2558687',6),(7,'2017-10-15 04:17:19.496824','2017-10-15 04:21:21.261591','group1/M00/00/00/CtM3BVni4U-AH41LAAA5OS4Kl4c6164095',7),(8,'2017-10-15 04:17:28.162534','2017-10-15 04:17:28.162623','group1/M00/00/00/CtM3BVni4ViARMz3AAA5OS4Kl4c1615509',8),(9,'2017-10-15 04:17:42.829934','2017-10-15 04:17:42.830228','group1/M00/00/00/CtM3BVni4WaAHD9RAAAkaP_7_185031909',9),(10,'2017-10-15 04:17:53.872693','2017-10-15 04:17:53.872782','group1/M00/00/00/CtM3BVni4XGACrEwAAAk8WCqqmI7993303',10),(11,'2017-10-15 04:18:08.366249','2017-10-15 04:18:08.366337','group1/M00/00/00/CtM3BVni4YCAJ_TWAAAk8WCqqmI1553113',11),(12,'2017-10-15 04:18:19.610030','2017-10-15 04:18:19.610134','group1/M00/00/00/CtM3BVni4YuAabKfAAAm3lfXL-Q8822022',12),(13,'2017-10-15 04:18:30.765023','2017-10-15 04:18:30.765159','group1/M00/00/00/CtM3BVni4ZaAez-MAAAh4Laa9PM7646087',13),(14,'2017-10-15 04:18:41.761811','2017-10-15 04:18:41.761913','group1/M00/00/00/CtM3BVni4aGAVKp-AAAcLRyfMSc3869171',14),(15,'2017-10-15 04:18:53.573563','2017-10-15 04:18:53.573657','group1/M00/00/00/CtM3BVni4a2ALjxZAAAgbU6nbaA7730942',15),(16,'2017-10-15 04:19:07.514422','2017-10-15 04:19:07.514770','group1/M00/00/00/CtM3BVni4buAbh7TAAAk0DN4-yE7181890',16),(17,'2017-10-15 04:19:17.697643','2017-10-15 04:19:17.697772','group1/M00/00/00/CtM3BVni4cWAS_vDAAAgbU6nbaA6752770',17),(18,'2017-10-15 04:19:28.690163','2017-10-15 04:19:28.690296','group1/M00/00/00/CtM3BVni4dCAVMHIAAAljHPuXJg4167162',18),(19,'2017-10-15 04:19:38.386374','2017-10-15 04:19:38.386483','group1/M00/00/00/CtM3BVni4dqAIsICAAAgnaeGwNQ6575764',19),(20,'2017-10-15 04:19:47.204775','2017-10-15 04:19:47.204879','group1/M00/00/00/CtM3BVni4eOAO5mhAAAeuLYy0pU4760038',20),(21,'2017-10-15 04:19:58.681113','2017-10-15 04:19:58.681210','group1/M00/00/00/CtM3BVni4e6Ab-3NAAAhst2hSFQ9636452',21),(22,'2017-10-15 04:20:08.086963','2017-10-15 04:20:08.087054','group1/M00/00/00/CtM3BVni4fiAXE0yAAAjjiYTEkw2650236',22),(23,'2017-10-15 04:20:18.017379','2017-10-15 04:20:18.017471','group1/M00/00/00/CtM3BVni4gKARJTGAAAgbU6nbaA5561664',23),(24,'2017-10-15 04:20:27.262496','2017-10-15 04:20:27.262588','group1/M00/00/00/CtM3BVni4guAc1euAAAaabPqzqc7740396',24),(25,'2017-10-15 04:20:37.514576','2017-10-15 04:20:37.514663','group1/M00/00/00/CtM3BVni4hWAcG7CAAAk0DN4-yE6832955',25),(26,'2017-10-15 04:20:50.880929','2017-10-15 04:20:50.881018','group1/M00/00/00/CtM3BVni4iKAVdn-AAAlcPqsn-E3729896',26),(27,'2017-10-15 04:21:00.700595','2017-10-15 04:21:00.700693','group1/M00/00/00/CtM3BVni4iyANvs2AAAjjiYTEkw0225364',27);
/*!40000 ALTER TABLE `df_goods_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_goods_sku`
--

DROP TABLE IF EXISTS `df_goods_sku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_goods_sku` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `unit` varchar(10) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `sales` int(11) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `default_image` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_goods_sku_goods_id_31622280_fk_df_goods_id` (`goods_id`),
  CONSTRAINT `df_goods_sku_goods_id_31622280_fk_df_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `df_goods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_goods_sku`
--

LOCK TABLES `df_goods_sku` WRITE;
/*!40000 ALTER TABLE `df_goods_sku` DISABLE KEYS */;
INSERT INTO `df_goods_sku` VALUES (1,'2017-10-15 03:55:35.414369','2017-10-15 05:07:27.154118','500g',10.00,100,0,'group1/M00/00/00/CtM3BVni7Q-AR4ORAAAgrKNKuOg9785395',1),(2,'2017-10-15 04:01:14.353213','2017-10-15 05:07:17.368098','100g',5.00,10,0,'group1/M00/00/00/CtM3BVni7QWACyE2AAAgrKNKuOg9615062',1),(3,'2017-10-15 04:01:37.048398','2017-10-15 05:07:09.290802','盒',30.00,20,0,'group1/M00/00/00/CtM3BVni7P2AbegjAAAgrKNKuOg7885706',1),(4,'2017-10-15 04:02:03.333853','2017-10-15 05:07:01.103102','500g',20.00,30,0,'group1/M00/00/00/CtM3BVni7PWAfaIgAAAiQjDS7wA2966092',2),(5,'2017-10-15 04:02:14.257707','2017-10-15 05:06:53.248899','500g',40.00,40,0,'group1/M00/00/00/CtM3BVni7O2AdXMUAAAlcPqsn-E8664565',3),(6,'2017-10-15 04:02:28.556683','2017-10-15 05:06:46.305279','500g',50.00,51,0,'group1/M00/00/00/CtM3BVni7OaAcPFJAAAcye9XGMY3489213',4),(7,'2017-10-15 04:08:36.313508','2017-10-15 05:06:37.541193','500g',60.00,100,0,'group1/M00/00/00/CtM3BVni7N2APghtAAA5OS4Kl4c3131364',5),(8,'2017-10-15 04:08:49.113650','2017-10-15 05:06:30.380881','盒',100.00,10,0,'group1/M00/00/00/CtM3BVni7NaAHLIfAAA5OS4Kl4c9768004',5),(9,'2017-10-15 04:09:34.768766','2017-10-15 05:06:20.260639','500g',70.00,10,0,'group1/M00/00/00/CtM3BVni7MyAQnniAAAkaP_7_183557335',6),(10,'2017-10-15 04:09:47.976971','2017-10-15 05:06:10.604753','500g',55.00,12,0,'group1/M00/00/00/CtM3BVni7MKAJAjbAAAkaP_7_182071330',7),(11,'2017-10-15 04:09:58.779205','2017-10-15 05:06:01.935959','500g',36.00,22,0,'group1/M00/00/00/CtM3BVni7LmACyEJAAA5OS4Kl4c2592459',8),(12,'2017-10-15 04:10:12.141977','2017-10-15 05:05:45.295835','500g',45.00,100,0,'group1/M00/00/00/CtM3BVni7KmAO-z1AAAhst2hSFQ8647873',9),(13,'2017-10-15 04:10:24.522752','2017-10-15 05:05:36.667329','500g',60.00,300,0,'group1/M00/00/00/CtM3BVni7KCAYhX5AAAjjiYTEkw2482580',10),(14,'2017-10-15 04:10:47.677291','2017-10-15 05:05:22.771330','500g',20.00,200,0,'group1/M00/00/00/CtM3BVni7JKAeVJhAAAaabPqzqc0609663',11),(15,'2017-10-15 04:10:57.551504','2017-10-15 05:05:12.636105','500g',23.00,20,0,'group1/M00/00/00/CtM3BVni7IiAEhuKAAAZxC0XRLc7582253',12),(16,'2017-10-15 04:11:13.921920','2017-10-15 05:05:00.655328','500g',10.00,23,0,'group1/M00/00/00/CtM3BVni7HyAeN4xAAAh4Laa9PM0401987',13),(17,'2017-10-15 04:11:41.617992','2017-10-15 05:04:50.887626','打',36.00,100,0,'group1/M00/00/00/CtM3BVni7HKAYCVyAAAWnwO6wpU6989636',14),(18,'2017-10-15 04:11:58.229264','2017-10-15 05:04:31.823396','打',38.00,26,0,'group1/M00/00/00/CtM3BVni7F-AAshaAAAeuLYy0pU7347714',15),(19,'2017-10-15 04:12:12.303432','2017-10-15 05:04:24.527693','500g',12.50,100,0,'group1/M00/00/00/CtM3BVni7FiAV466AAAljHPuXJg3105869',16),(20,'2017-10-15 04:12:27.670631','2017-10-15 05:04:16.463616','500g',3.99,100,0,'group1/M00/00/00/CtM3BVni7FCASUjFAAAcLRyfMSc1537560',17),(21,'2017-10-15 04:12:43.944372','2017-10-15 05:04:09.543859','500g',4.60,100,0,'group1/M00/00/00/CtM3BVni7EmAcGLwAAAeuLYy0pU6703666',18),(22,'2017-10-15 04:13:02.623743','2017-10-15 05:04:01.905911','100g',5.00,100,0,'group1/M00/00/00/CtM3BVni7EGAXg0mAAAZxC0XRLc9727640',19),(23,'2017-10-15 04:13:17.071755','2017-10-15 05:03:53.332900','500g',4.80,100,0,'group1/M00/00/00/CtM3BVni7DmAb7KhAAAh4Laa9PM5050331',20),(24,'2017-10-15 04:13:32.681491','2017-10-15 05:03:45.305578','500g',26.00,100,0,'group1/M00/00/00/CtM3BVni7DGALEA2AAAm3lfXL-Q0269639',21),(25,'2017-10-15 04:13:42.699105','2017-10-15 05:03:36.698847','500g',56.00,100,0,'group1/M00/00/00/CtM3BVni7CiAXNUOAAAh4Laa9PM5678134',22),(26,'2017-10-15 04:14:01.917150','2017-10-15 05:03:25.008063','500g',8.00,100,0,'group1/M00/00/00/CtM3BVni7B2AWoZHAAAcye9XGMY3943711',23),(27,'2017-10-15 04:14:21.977195','2017-10-15 05:03:13.364282','500g',9.00,100,0,'group1/M00/00/00/CtM3BVni7BGAdISWAAAk8WCqqmI4984605',24);
/*!40000 ALTER TABLE `df_goods_sku` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_index_category_goods`
--

DROP TABLE IF EXISTS `df_index_category_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_index_category_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `display_type` smallint(6) NOT NULL,
  `index` smallint(6) NOT NULL,
  `sku_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_index_category_goods_sku_id_8e0e6f22_fk_df_goods_sku_id` (`sku_id`),
  KEY `df_index_category_goods_b583a629` (`category_id`),
  CONSTRAINT `df_index_category_g_category_id_48a3069d_fk_df_goods_category_id` FOREIGN KEY (`category_id`) REFERENCES `df_goods_category` (`id`),
  CONSTRAINT `df_index_category_goods_sku_id_8e0e6f22_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_index_category_goods`
--

LOCK TABLES `df_index_category_goods` WRITE;
/*!40000 ALTER TABLE `df_index_category_goods` DISABLE KEYS */;
INSERT INTO `df_index_category_goods` VALUES (1,'2017-10-15 04:27:36.706884','2017-10-15 04:27:36.707384',1,0,1,2),(2,'2017-10-15 04:27:46.487838','2017-10-15 04:27:46.487979',1,1,4,2),(3,'2017-10-15 04:27:54.351575','2017-10-15 04:27:54.351668',1,2,5,2),(4,'2017-10-15 04:28:06.579646','2017-10-15 04:28:06.579738',1,3,5,2),(5,'2017-10-15 04:28:20.555252','2017-10-15 04:28:20.555348',0,0,2,2),(6,'2017-10-15 04:28:30.149046','2017-10-15 04:28:30.149139',0,1,4,2),(7,'2017-10-15 04:28:50.593515','2017-10-15 04:28:50.593605',1,0,7,3),(8,'2017-10-15 04:29:08.568977','2017-10-15 04:29:08.569083',1,1,9,3),(9,'2017-10-15 04:29:17.467555','2017-10-15 04:29:17.467647',1,2,10,3),(10,'2017-10-15 04:29:31.247564','2017-10-15 04:29:31.247653',1,3,11,3),(11,'2017-10-15 04:29:39.934251','2017-10-15 04:29:39.934338',0,0,10,3),(12,'2017-10-15 04:29:56.736660','2017-10-15 04:29:56.736756',0,1,8,3),(13,'2017-10-15 04:30:06.915175','2017-10-15 04:30:06.915335',0,2,9,3),(14,'2017-10-15 04:30:20.218979','2017-10-15 04:30:20.219078',1,0,12,4),(15,'2017-10-15 04:30:31.497660','2017-10-15 04:30:31.497845',1,1,13,4),(16,'2017-10-15 04:30:41.651361','2017-10-15 04:30:41.651462',1,2,15,4),(17,'2017-10-15 04:30:54.501773','2017-10-15 04:30:54.501871',1,3,14,4),(18,'2017-10-15 04:31:03.222158','2017-10-15 04:31:03.222253',0,0,13,4),(19,'2017-10-15 04:31:14.615258','2017-10-15 04:31:14.615354',1,0,18,5),(20,'2017-10-15 04:31:25.315668','2017-10-15 04:31:25.315763',1,1,16,5),(21,'2017-10-15 04:31:37.937786','2017-10-15 04:31:37.937873',1,2,18,5),(22,'2017-10-15 04:31:49.502494','2017-10-15 04:31:49.502586',1,3,19,5),(23,'2017-10-15 04:31:59.130767','2017-10-15 04:31:59.130852',0,0,16,5),(24,'2017-10-15 04:32:05.889602','2017-10-15 04:32:05.889717',1,0,20,6),(25,'2017-10-15 04:32:14.410364','2017-10-15 04:32:14.410458',1,1,21,6),(26,'2017-10-15 04:32:21.228492','2017-10-15 04:32:21.228583',1,2,22,6),(27,'2017-10-15 04:32:31.622621','2017-10-15 04:32:31.622716',1,3,23,6),(28,'2017-10-15 04:32:39.330332','2017-10-15 04:32:39.330422',0,0,23,6),(29,'2017-10-15 04:32:47.679808','2017-10-15 04:32:47.679937',0,2,22,6),(30,'2017-10-15 04:32:56.707397','2017-10-15 04:32:56.707520',1,0,24,7),(31,'2017-10-15 04:33:07.707277','2017-10-15 04:33:07.707373',1,1,25,7),(32,'2017-10-15 04:33:16.265391','2017-10-15 04:33:16.265480',1,2,26,7),(33,'2017-10-15 04:33:22.180610','2017-10-15 07:11:19.515317',1,1,27,7),(34,'2017-10-15 04:33:28.287144','2017-10-15 04:33:28.287239',0,0,26,7),(35,'2017-10-15 04:33:35.793501','2017-10-15 07:12:27.648477',0,6,27,7);
/*!40000 ALTER TABLE `df_index_category_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_index_goods`
--

DROP TABLE IF EXISTS `df_index_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_index_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `image` varchar(100) NOT NULL,
  `index` smallint(6) NOT NULL,
  `sku_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_index_goods_sku_id_b5ed7c7b_fk_df_goods_sku_id` (`sku_id`),
  CONSTRAINT `df_index_goods_sku_id_b5ed7c7b_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_index_goods`
--

LOCK TABLES `df_index_goods` WRITE;
/*!40000 ALTER TABLE `df_index_goods` DISABLE KEYS */;
INSERT INTO `df_index_goods` VALUES (1,'2017-10-15 04:22:52.666870','2017-10-15 04:22:52.667006','group1/M00/00/00/CtM3BVni4pyAGnYPAACpB-LsCdE6899184',0,4),(2,'2017-10-15 04:23:11.179292','2017-10-15 04:23:11.179382','group1/M00/00/00/CtM3BVni4q-AXPBgAAC3B-z8J2c3845825',1,6),(3,'2017-10-15 04:23:28.573671','2017-10-15 04:23:28.573761','group1/M00/00/00/CtM3BVni4sCAJlzHAAETwXb_pso9622268',2,12),(4,'2017-10-15 04:23:42.891858','2017-10-15 04:23:42.892017','group1/M00/00/00/CtM3BVni4s6AH_heAAD0akkXmFo7197106',3,7);
/*!40000 ALTER TABLE `df_index_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_index_promotion`
--

DROP TABLE IF EXISTS `df_index_promotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_index_promotion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `url` varchar(200) NOT NULL,
  `image` varchar(100) NOT NULL,
  `index` smallint(6) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_index_promotion`
--

LOCK TABLES `df_index_promotion` WRITE;
/*!40000 ALTER TABLE `df_index_promotion` DISABLE KEYS */;
INSERT INTO `df_index_promotion` VALUES (1,'2017-10-15 04:24:38.521151','2017-10-15 04:24:38.521249','http://www.itcast.cn','group1/M00/00/00/CtM3BVni4waAWINiAAA2pLUeB603197770',0,'吃货暑假趴'),(2,'2017-10-15 04:25:15.293574','2017-10-15 04:25:15.293698','http://www.itheima.com','group1/M00/00/00/CtM3BVni4yuAQDojAAA98yvCs1I2335551',1,'盛夏尝鲜季');
/*!40000 ALTER TABLE `df_index_promotion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_order_goods`
--

DROP TABLE IF EXISTS `df_order_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_order_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `count` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `comment` longtext NOT NULL,
  `order_id` varchar(64) NOT NULL,
  `sku_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_order_goods_69dfcb07` (`order_id`),
  KEY `df_order_goods_22ad5bca` (`sku_id`),
  CONSTRAINT `df_order_goods_order_id_6958ee23_fk_df_order_info_order_id` FOREIGN KEY (`order_id`) REFERENCES `df_order_info` (`order_id`),
  CONSTRAINT `df_order_goods_sku_id_b7d6e04e_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_order_goods`
--

LOCK TABLES `df_order_goods` WRITE;
/*!40000 ALTER TABLE `df_order_goods` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_order_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_order_info`
--

DROP TABLE IF EXISTS `df_order_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_order_info` (
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `order_id` varchar(64) NOT NULL,
  `total_count` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `trans_cost` decimal(10,2) NOT NULL,
  `pay_method` smallint(6) NOT NULL,
  `status` smallint(6) NOT NULL,
  `trade_id` varchar(100) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `trade_id` (`trade_id`),
  KEY `df_order_info_e8701ad4` (`user_id`),
  CONSTRAINT `df_order_info_user_id_ac1e5bf5_fk_df_users_id` FOREIGN KEY (`user_id`) REFERENCES `df_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_order_info`
--

LOCK TABLES `df_order_info` WRITE;
/*!40000 ALTER TABLE `df_order_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_order_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_users`
--

DROP TABLE IF EXISTS `df_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_users`
--

LOCK TABLES `df_users` WRITE;
/*!40000 ALTER TABLE `df_users` DISABLE KEYS */;
INSERT INTO `df_users` VALUES (1,'pbkdf2_sha256$24000$OZsFyLkHDtEC$maOzSIHz8c/rUfeKmAuoiG9j1fI5VxQPkSf88yEihwo=','2017-10-15 01:51:28.846563',0,'python','','','kongdehai@itcast.cn',0,1,'2017-10-14 20:13:58.710962','2017-10-14 20:13:58.736891','2017-10-14 20:14:46.037696'),(2,'pbkdf2_sha256$24000$EFtUByDIPPrU$IarGqASyoFzWoeFuZ1JvC4NEB+tfHjyhTmU/ItWnQQw=','2017-10-15 07:11:08.115108',1,'admin','','','admin@admin.com',1,1,'2017-10-14 20:16:49.414690','2017-10-14 20:16:49.439395','2017-10-14 20:16:49.439496');
/*!40000 ALTER TABLE `df_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_users_groups`
--

DROP TABLE IF EXISTS `df_users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_users_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `df_users_groups_user_id_7384a8ec_uniq` (`user_id`,`group_id`),
  KEY `df_users_groups_group_id_3b586d27_fk_auth_group_id` (`group_id`),
  CONSTRAINT `df_users_groups_group_id_3b586d27_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `df_users_groups_user_id_a8d299cd_fk_df_users_id` FOREIGN KEY (`user_id`) REFERENCES `df_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_users_groups`
--

LOCK TABLES `df_users_groups` WRITE;
/*!40000 ALTER TABLE `df_users_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_users_user_permissions`
--

DROP TABLE IF EXISTS `df_users_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_users_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `df_users_user_permissions_user_id_38ccfd00_uniq` (`user_id`,`permission_id`),
  KEY `df_users_user_permi_permission_id_a1834243_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `df_users_user_permi_permission_id_a1834243_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `df_users_user_permissions_user_id_5d96b254_fk_df_users_id` FOREIGN KEY (`user_id`) REFERENCES `df_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_users_user_permissions`
--

LOCK TABLES `df_users_user_permissions` WRITE;
/*!40000 ALTER TABLE `df_users_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_users_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_df_users_id` (`user_id`),
  CONSTRAINT `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_df_users_id` FOREIGN KEY (`user_id`) REFERENCES `df_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(15,'cart','shoppingcart'),(4,'contenttypes','contenttype'),(9,'goods','goods'),(8,'goods','goodscategory'),(11,'goods','goodsimage'),(10,'goods','goodssku'),(13,'goods','indexcategorygoodsbanner'),(12,'goods','indexgoodsbanner'),(14,'goods','indexpromotionbanner'),(17,'orders','ordergoods'),(16,'orders','orderinfo'),(7,'users','address'),(6,'users','user'),(22,'reversion','revision'),(23,'reversion','version'),(5,'sessions','session'),(18,'xadmin','bookmark'),(21,'xadmin','log'),(19,'xadmin','usersettings'),(20,'xadmin','userwidget');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2017-10-14 20:09:53.345366'),(2,'contenttypes','0002_remove_content_type_name','2017-10-14 20:09:53.415464'),(3,'auth','0001_initial','2017-10-14 20:09:53.588048'),(4,'auth','0002_alter_permission_name_max_length','2017-10-14 20:09:53.624844'),(5,'auth','0003_alter_user_email_max_length','2017-10-14 20:09:53.648842'),(6,'auth','0004_alter_user_username_opts','2017-10-14 20:09:53.660940'),(7,'auth','0005_alter_user_last_login_null','2017-10-14 20:09:53.678084'),(8,'auth','0006_require_contenttypes_0002','2017-10-14 20:09:53.693439'),(9,'auth','0007_alter_validators_add_error_messages','2017-10-14 20:09:53.715939'),(10,'users','0001_initial','2017-10-14 20:09:53.965089'),(11,'admin','0001_initial','2017-10-14 20:09:54.058395'),(12,'admin','0002_logentry_remove_auto_add','2017-10-14 20:09:54.087696'),(13,'goods','0001_initial','2017-10-14 20:09:54.426558'),(14,'cart','0001_initial','2017-10-14 20:09:54.500061'),(15,'cart','0002_shoppingcart_user','2017-10-14 20:09:54.608614'),(16,'orders','0001_initial','2017-10-14 20:09:54.655430'),(17,'orders','0002_auto_20171015_0409','2017-10-14 20:09:54.929750'),(18,'reversion','0001_initial','2017-10-14 20:09:55.147085'),(19,'reversion','0002_auto_20141216_1509','2017-10-14 20:09:55.153494'),(20,'reversion','0003_auto_20160601_1600','2017-10-14 20:09:55.160224'),(21,'reversion','0004_auto_20160611_1202','2017-10-14 20:09:55.166252'),(22,'sessions','0001_initial','2017-10-14 20:09:55.203702'),(23,'xadmin','0001_initial','2017-10-14 20:09:55.454683'),(24,'xadmin','0002_log','2017-10-14 20:09:55.582985'),(25,'xadmin','0003_auto_20160715_0100','2017-10-14 20:09:55.661475'),(26,'reversion','0001_squashed_0004_auto_20160611_1202','2017-10-14 20:09:55.671589'),(27,'goods','0002_auto_20171015_1150','2017-10-15 03:51:00.341575'),(28,'goods','0003_indexcategorygoodsbanner_category','2017-10-15 04:27:10.003959'),(29,'goods','0004_auto_20171015_1302','2017-10-15 05:02:19.912097'),(30,'goods','0005_auto_20171015_1308','2017-10-15 05:08:07.931448');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reversion_revision`
--

DROP TABLE IF EXISTS `reversion_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reversion_revision` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime(6) NOT NULL,
  `comment` longtext NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reversion_revision_user_id_17095f45_fk_df_users_id` (`user_id`),
  KEY `reversion_revision_c69e55a4` (`date_created`),
  CONSTRAINT `reversion_revision_user_id_17095f45_fk_df_users_id` FOREIGN KEY (`user_id`) REFERENCES `df_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reversion_revision`
--

LOCK TABLES `reversion_revision` WRITE;
/*!40000 ALTER TABLE `reversion_revision` DISABLE KEYS */;
/*!40000 ALTER TABLE `reversion_revision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reversion_version`
--

DROP TABLE IF EXISTS `reversion_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reversion_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` varchar(191) NOT NULL,
  `format` varchar(255) NOT NULL,
  `serialized_data` longtext NOT NULL,
  `object_repr` longtext NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `revision_id` int(11) NOT NULL,
  `db` varchar(191) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reversion_version_db_b2c54f65_uniq` (`db`,`content_type_id`,`object_id`,`revision_id`),
  KEY `reversion_ver_content_type_id_7d0ff25c_fk_django_content_type_id` (`content_type_id`),
  KEY `reversion_version_revision_id_af9f6a9d_fk_reversion_revision_id` (`revision_id`),
  CONSTRAINT `reversion_ver_content_type_id_7d0ff25c_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `reversion_version_revision_id_af9f6a9d_fk_reversion_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `reversion_revision` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reversion_version`
--

LOCK TABLES `reversion_version` WRITE;
/*!40000 ALTER TABLE `reversion_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `reversion_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_bookmark`
--

DROP TABLE IF EXISTS `xadmin_bookmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_bookmark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `url_name` varchar(64) NOT NULL,
  `query` varchar(1000) NOT NULL,
  `is_share` tinyint(1) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_bookma_content_type_id_60941679_fk_django_content_type_id` (`content_type_id`),
  KEY `xadmin_bookmark_user_id_42d307fc_fk_df_users_id` (`user_id`),
  CONSTRAINT `xadmin_bookma_content_type_id_60941679_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `xadmin_bookmark_user_id_42d307fc_fk_df_users_id` FOREIGN KEY (`user_id`) REFERENCES `df_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_bookmark`
--

LOCK TABLES `xadmin_bookmark` WRITE;
/*!40000 ALTER TABLE `xadmin_bookmark` DISABLE KEYS */;
/*!40000 ALTER TABLE `xadmin_bookmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_log`
--

DROP TABLE IF EXISTS `xadmin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `ip_addr` char(39) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` varchar(32) NOT NULL,
  `message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_log_content_type_id_2a6cb852_fk_django_content_type_id` (`content_type_id`),
  KEY `xadmin_log_user_id_bb16a176_fk_df_users_id` (`user_id`),
  CONSTRAINT `xadmin_log_content_type_id_2a6cb852_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `xadmin_log_user_id_bb16a176_fk_df_users_id` FOREIGN KEY (`user_id`) REFERENCES `df_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_log`
--

LOCK TABLES `xadmin_log` WRITE;
/*!40000 ALTER TABLE `xadmin_log` DISABLE KEYS */;
INSERT INTO `xadmin_log` VALUES (1,'2017-10-15 03:22:37.229672','127.0.0.1','2','GoodsCategory object','create','已添加',8,2),(2,'2017-10-15 03:25:07.628850','127.0.0.1','3','GoodsCategory object','create','已添加',8,2),(3,'2017-10-15 03:25:25.832601','127.0.0.1','4','GoodsCategory object','create','已添加',8,2),(4,'2017-10-15 03:25:48.403658','127.0.0.1','5','GoodsCategory object','create','已添加',8,2),(5,'2017-10-15 03:26:04.661854','127.0.0.1','6','GoodsCategory object','create','已添加',8,2),(6,'2017-10-15 03:26:18.646387','127.0.0.1','7','GoodsCategory object','create','已添加',8,2),(7,'2017-10-15 03:53:57.216961','127.0.0.1','1','草莓','create','已添加',9,2),(8,'2017-10-15 03:54:12.512428','127.0.0.1','2','葡萄','create','已添加',9,2),(9,'2017-10-15 03:54:27.885164','127.0.0.1','3','柠檬','create','已添加',9,2),(10,'2017-10-15 03:54:48.507891','127.0.0.1','4','奇异果','create','已添加',9,2),(11,'2017-10-15 03:55:35.416375','127.0.0.1','1','草莓 500g 10','create','已添加',10,2),(12,'2017-10-15 04:01:14.355410','127.0.0.1','2','草莓 ¥5.00/100g','create','已添加',10,2),(13,'2017-10-15 04:01:37.049351','127.0.0.1','3','草莓 ¥30.00/盒','create','已添加',10,2),(14,'2017-10-15 04:02:03.335155','127.0.0.1','4','葡萄 ¥20.00/500g','create','已添加',10,2),(15,'2017-10-15 04:02:14.259333','127.0.0.1','5','柠檬 ¥40.00/500g','create','已添加',10,2),(16,'2017-10-15 04:02:28.558263','127.0.0.1','6','奇异果 ¥50.00/500g','create','已添加',10,2),(17,'2017-10-15 04:03:23.130992','127.0.0.1','5','大青虾','create','已添加',9,2),(18,'2017-10-15 04:03:35.076474','127.0.0.1','6','扇贝','create','已添加',9,2),(19,'2017-10-15 04:03:47.997584','127.0.0.1','7','冷冻秋刀鱼','create','已添加',9,2),(20,'2017-10-15 04:04:00.206103','127.0.0.1','8','基围虾','create','已添加',9,2),(21,'2017-10-15 04:04:27.455120','127.0.0.1','9','牛排','create','已添加',9,2),(22,'2017-10-15 04:04:42.933983','127.0.0.1','10','羊肉','create','已添加',9,2),(23,'2017-10-15 04:04:55.128696','127.0.0.1','11','猪肉','create','已添加',9,2),(24,'2017-10-15 04:05:10.428439','127.0.0.1','12','猪排骨','create','已添加',9,2),(25,'2017-10-15 04:05:26.692606','127.0.0.1','13','鸡肉','create','已添加',9,2),(26,'2017-10-15 04:05:35.829667','127.0.0.1','14','鸡蛋','create','已添加',9,2),(27,'2017-10-15 04:05:46.093794','127.0.0.1','15','鸭蛋','create','已添加',9,2),(28,'2017-10-15 04:06:09.357279','127.0.0.1','16','鸡胸脯肉','create','已添加',9,2),(29,'2017-10-15 04:06:26.834684','127.0.0.1','17','白菜','create','已添加',9,2),(30,'2017-10-15 04:06:39.465149','127.0.0.1','18','芹菜','create','已添加',9,2),(31,'2017-10-15 04:06:49.510674','127.0.0.1','19','香菜','create','已添加',9,2),(32,'2017-10-15 04:07:06.615654','127.0.0.1','20','冬瓜','create','已添加',9,2),(33,'2017-10-15 04:07:22.447478','127.0.0.1','21','鱼丸','create','已添加',9,2),(34,'2017-10-15 04:07:37.018157','127.0.0.1','22','虾丸','create','已添加',9,2),(35,'2017-10-15 04:07:51.828100','127.0.0.1','23','速冻水饺','create','已添加',9,2),(36,'2017-10-15 04:08:15.173318','127.0.0.1','24','汤圆','create','已添加',9,2),(37,'2017-10-15 04:08:36.314620','127.0.0.1','7','大青虾 ¥60.00/500g','create','已添加',10,2),(38,'2017-10-15 04:08:49.115232','127.0.0.1','8','大青虾 ¥100.00/盒','create','已添加',10,2),(39,'2017-10-15 04:09:34.769611','127.0.0.1','9','扇贝 ¥70.00/500g','create','已添加',10,2),(40,'2017-10-15 04:09:47.978256','127.0.0.1','10','冷冻秋刀鱼 ¥55.00/500g','create','已添加',10,2),(41,'2017-10-15 04:09:58.780370','127.0.0.1','11','基围虾 ¥36.00/500g','create','已添加',10,2),(42,'2017-10-15 04:10:12.143089','127.0.0.1','12','牛排 ¥45.00/500g','create','已添加',10,2),(43,'2017-10-15 04:10:24.523728','127.0.0.1','13','羊肉 ¥60.00/500g','create','已添加',10,2),(44,'2017-10-15 04:10:47.678639','127.0.0.1','14','猪肉 ¥20.00/500g','create','已添加',10,2),(45,'2017-10-15 04:10:57.553052','127.0.0.1','15','猪排骨 ¥23.00/500g','create','已添加',10,2),(46,'2017-10-15 04:11:13.923486','127.0.0.1','16','鸡肉 ¥10.00/500g','create','已添加',10,2),(47,'2017-10-15 04:11:41.618966','127.0.0.1','17','鸡蛋 ¥36.00/打','create','已添加',10,2),(48,'2017-10-15 04:11:58.230102','127.0.0.1','18','鸭蛋 ¥38.00/打','create','已添加',10,2),(49,'2017-10-15 04:12:12.304474','127.0.0.1','19','鸡胸脯肉 ¥12.50/500g','create','已添加',10,2),(50,'2017-10-15 04:12:27.671758','127.0.0.1','20','白菜 ¥3.99/500g','create','已添加',10,2),(51,'2017-10-15 04:12:43.945593','127.0.0.1','21','芹菜 ¥4.60/500g','create','已添加',10,2),(52,'2017-10-15 04:13:02.624763','127.0.0.1','22','香菜 ¥5.00/100g','create','已添加',10,2),(53,'2017-10-15 04:13:17.072689','127.0.0.1','23','冬瓜 ¥4.80/500g','create','已添加',10,2),(54,'2017-10-15 04:13:32.684358','127.0.0.1','24','鱼丸 ¥26.00/500g','create','已添加',10,2),(55,'2017-10-15 04:13:42.700629','127.0.0.1','25','虾丸 ¥56.00/500g','create','已添加',10,2),(56,'2017-10-15 04:14:01.918027','127.0.0.1','26','速冻水饺 ¥8.00/500g','create','已添加',10,2),(57,'2017-10-15 04:14:21.978236','127.0.0.1','27','汤圆 ¥9.00/500g','create','已添加',10,2),(58,'2017-10-15 04:15:53.959903','127.0.0.1','1','草莓 ¥10.00/500g','create','已添加',11,2),(59,'2017-10-15 04:16:21.922401','127.0.0.1','2','草莓 ¥5.00/100g','create','已添加',11,2),(60,'2017-10-15 04:16:32.047129','127.0.0.1','3','草莓 ¥30.00/盒','create','已添加',11,2),(61,'2017-10-15 04:16:49.492743','127.0.0.1','4','葡萄 ¥20.00/500g','create','已添加',11,2),(62,'2017-10-15 04:16:58.142861','127.0.0.1','5','柠檬 ¥40.00/500g','create','已添加',11,2),(63,'2017-10-15 04:17:06.830754','127.0.0.1','6','奇异果 ¥50.00/500g','create','已添加',11,2),(64,'2017-10-15 04:17:19.500866','127.0.0.1','7','大青虾 ¥60.00/500g','create','已添加',11,2),(65,'2017-10-15 04:17:28.166391','127.0.0.1','8','大青虾 ¥100.00/盒','create','已添加',11,2),(66,'2017-10-15 04:17:42.834587','127.0.0.1','9','扇贝 ¥70.00/500g','create','已添加',11,2),(67,'2017-10-15 04:17:53.876133','127.0.0.1','10','冷冻秋刀鱼 ¥55.00/500g','create','已添加',11,2),(68,'2017-10-15 04:18:08.369762','127.0.0.1','11','基围虾 ¥36.00/500g','create','已添加',11,2),(69,'2017-10-15 04:18:19.613725','127.0.0.1','12','牛排 ¥45.00/500g','create','已添加',11,2),(70,'2017-10-15 04:18:30.768988','127.0.0.1','13','羊肉 ¥60.00/500g','create','已添加',11,2),(71,'2017-10-15 04:18:41.767848','127.0.0.1','14','猪肉 ¥20.00/500g','create','已添加',11,2),(72,'2017-10-15 04:18:53.577007','127.0.0.1','15','猪排骨 ¥23.00/500g','create','已添加',11,2),(73,'2017-10-15 04:19:07.518582','127.0.0.1','16','鸡肉 ¥10.00/500g','create','已添加',11,2),(74,'2017-10-15 04:19:17.701600','127.0.0.1','17','鸡蛋 ¥36.00/打','create','已添加',11,2),(75,'2017-10-15 04:19:28.693992','127.0.0.1','18','鸭蛋 ¥38.00/打','create','已添加',11,2),(76,'2017-10-15 04:19:38.390456','127.0.0.1','19','鸡胸脯肉 ¥12.50/500g','create','已添加',11,2),(77,'2017-10-15 04:19:47.208474','127.0.0.1','20','白菜 ¥3.99/500g','create','已添加',11,2),(78,'2017-10-15 04:19:58.685310','127.0.0.1','21','芹菜 ¥4.60/500g','create','已添加',11,2),(79,'2017-10-15 04:20:08.090775','127.0.0.1','22','香菜 ¥5.00/100g','create','已添加',11,2),(80,'2017-10-15 04:20:18.021323','127.0.0.1','23','冬瓜 ¥4.80/500g','create','已添加',11,2),(81,'2017-10-15 04:20:27.266625','127.0.0.1','24','鱼丸 ¥26.00/500g','create','已添加',11,2),(82,'2017-10-15 04:20:37.520628','127.0.0.1','25','虾丸 ¥56.00/500g','create','已添加',11,2),(83,'2017-10-15 04:20:50.885551','127.0.0.1','26','速冻水饺 ¥8.00/500g','create','已添加',11,2),(84,'2017-10-15 04:21:00.705386','127.0.0.1','27','汤圆 ¥9.00/500g','create','已添加',11,2),(85,'2017-10-15 04:21:07.279402','127.0.0.1','4','葡萄 ¥20.00/500g','change','已修改 is_default 。',11,2),(86,'2017-10-15 04:21:11.874849','127.0.0.1','5','柠檬 ¥40.00/500g','change','已修改 is_default 。',11,2),(87,'2017-10-15 04:21:16.551884','127.0.0.1','6','奇异果 ¥50.00/500g','change','已修改 is_default 。',11,2),(88,'2017-10-15 04:21:21.263046','127.0.0.1','7','大青虾 ¥60.00/500g','change','已修改 is_default 。',11,2),(89,'2017-10-15 04:22:52.671225','127.0.0.1','1','葡萄 ¥20.00/500g','create','已添加',12,2),(90,'2017-10-15 04:23:11.183593','127.0.0.1','2','奇异果 ¥50.00/500g','create','已添加',12,2),(91,'2017-10-15 04:23:28.578072','127.0.0.1','3','牛排 ¥45.00/500g','create','已添加',12,2),(92,'2017-10-15 04:23:42.898356','127.0.0.1','4','大青虾 ¥60.00/500g','create','已添加',12,2),(93,'2017-10-15 04:24:38.525434','127.0.0.1','1','吃货暑假趴','create','已添加',14,2),(94,'2017-10-15 04:25:15.299646','127.0.0.1','2','盛夏尝鲜季','create','已添加',14,2),(95,'2017-10-15 04:27:36.708496','127.0.0.1','1','草莓 ¥10.00/500g','create','已添加',13,2),(96,'2017-10-15 04:27:46.492615','127.0.0.1','2','葡萄 ¥20.00/500g','create','已添加',13,2),(97,'2017-10-15 04:27:54.352565','127.0.0.1','3','柠檬 ¥40.00/500g','create','已添加',13,2),(98,'2017-10-15 04:28:06.580739','127.0.0.1','4','柠檬 ¥40.00/500g','create','已添加',13,2),(99,'2017-10-15 04:28:20.556234','127.0.0.1','5','草莓 ¥5.00/100g','create','已添加',13,2),(100,'2017-10-15 04:28:30.150115','127.0.0.1','6','葡萄 ¥20.00/500g','create','已添加',13,2),(101,'2017-10-15 04:28:50.594400','127.0.0.1','7','大青虾 ¥60.00/500g','create','已添加',13,2),(102,'2017-10-15 04:29:08.570126','127.0.0.1','8','扇贝 ¥70.00/500g','create','已添加',13,2),(103,'2017-10-15 04:29:17.468575','127.0.0.1','9','冷冻秋刀鱼 ¥55.00/500g','create','已添加',13,2),(104,'2017-10-15 04:29:31.248518','127.0.0.1','10','基围虾 ¥36.00/500g','create','已添加',13,2),(105,'2017-10-15 04:29:39.935509','127.0.0.1','11','冷冻秋刀鱼 ¥55.00/500g','create','已添加',13,2),(106,'2017-10-15 04:29:56.738134','127.0.0.1','12','大青虾 ¥100.00/盒','create','已添加',13,2),(107,'2017-10-15 04:30:06.916798','127.0.0.1','13','扇贝 ¥70.00/500g','create','已添加',13,2),(108,'2017-10-15 04:30:20.220286','127.0.0.1','14','牛排 ¥45.00/500g','create','已添加',13,2),(109,'2017-10-15 04:30:31.499180','127.0.0.1','15','羊肉 ¥60.00/500g','create','已添加',13,2),(110,'2017-10-15 04:30:41.652341','127.0.0.1','16','猪排骨 ¥23.00/500g','create','已添加',13,2),(111,'2017-10-15 04:30:54.502901','127.0.0.1','17','猪肉 ¥20.00/500g','create','已添加',13,2),(112,'2017-10-15 04:31:03.223174','127.0.0.1','18','羊肉 ¥60.00/500g','create','已添加',13,2),(113,'2017-10-15 04:31:14.616194','127.0.0.1','19','鸭蛋 ¥38.00/打','create','已添加',13,2),(114,'2017-10-15 04:31:25.319135','127.0.0.1','20','鸡肉 ¥10.00/500g','create','已添加',13,2),(115,'2017-10-15 04:31:37.938886','127.0.0.1','21','鸭蛋 ¥38.00/打','create','已添加',13,2),(116,'2017-10-15 04:31:49.503558','127.0.0.1','22','鸡胸脯肉 ¥12.50/500g','create','已添加',13,2),(117,'2017-10-15 04:31:59.131589','127.0.0.1','23','鸡肉 ¥10.00/500g','create','已添加',13,2),(118,'2017-10-15 04:32:05.890688','127.0.0.1','24','白菜 ¥3.99/500g','create','已添加',13,2),(119,'2017-10-15 04:32:14.411402','127.0.0.1','25','芹菜 ¥4.60/500g','create','已添加',13,2),(120,'2017-10-15 04:32:21.229503','127.0.0.1','26','香菜 ¥5.00/100g','create','已添加',13,2),(121,'2017-10-15 04:32:31.623501','127.0.0.1','27','冬瓜 ¥4.80/500g','create','已添加',13,2),(122,'2017-10-15 04:32:39.331210','127.0.0.1','28','冬瓜 ¥4.80/500g','create','已添加',13,2),(123,'2017-10-15 04:32:47.681226','127.0.0.1','29','香菜 ¥5.00/100g','create','已添加',13,2),(124,'2017-10-15 04:32:56.708649','127.0.0.1','30','鱼丸 ¥26.00/500g','create','已添加',13,2),(125,'2017-10-15 04:33:07.708228','127.0.0.1','31','虾丸 ¥56.00/500g','create','已添加',13,2),(126,'2017-10-15 04:33:16.266294','127.0.0.1','32','速冻水饺 ¥8.00/500g','create','已添加',13,2),(127,'2017-10-15 04:33:22.181457','127.0.0.1','33','汤圆 ¥9.00/500g','create','已添加',13,2),(128,'2017-10-15 04:33:28.288219','127.0.0.1','34','速冻水饺 ¥8.00/500g','create','已添加',13,2),(129,'2017-10-15 04:33:35.794610','127.0.0.1','35','汤圆 ¥9.00/500g','create','已添加',13,2),(130,'2017-10-15 05:03:13.528499','127.0.0.1','27','汤圆 ¥9.00/500g','change','已修改 default_image 。',10,2),(131,'2017-10-15 05:03:25.011932','127.0.0.1','26','速冻水饺 ¥8.00/500g','change','已修改 default_image 。',10,2),(132,'2017-10-15 05:03:36.702739','127.0.0.1','25','虾丸 ¥56.00/500g','change','已修改 default_image 。',10,2),(133,'2017-10-15 05:03:45.310205','127.0.0.1','24','鱼丸 ¥26.00/500g','change','已修改 default_image 。',10,2),(134,'2017-10-15 05:03:53.336887','127.0.0.1','23','冬瓜 ¥4.80/500g','change','已修改 default_image 。',10,2),(135,'2017-10-15 05:04:01.909699','127.0.0.1','22','香菜 ¥5.00/100g','change','已修改 default_image 。',10,2),(136,'2017-10-15 05:04:09.547872','127.0.0.1','21','芹菜 ¥4.60/500g','change','已修改 default_image 。',10,2),(137,'2017-10-15 05:04:16.467512','127.0.0.1','20','白菜 ¥3.99/500g','change','已修改 default_image 。',10,2),(138,'2017-10-15 05:04:24.531641','127.0.0.1','19','鸡胸脯肉 ¥12.50/500g','change','已修改 default_image 。',10,2),(139,'2017-10-15 05:04:31.829203','127.0.0.1','18','鸭蛋 ¥38.00/打','change','已修改 default_image 。',10,2),(140,'2017-10-15 05:04:50.891836','127.0.0.1','17','鸡蛋 ¥36.00/打','change','已修改 default_image 。',10,2),(141,'2017-10-15 05:05:00.659425','127.0.0.1','16','鸡肉 ¥10.00/500g','change','已修改 default_image 。',10,2),(142,'2017-10-15 05:05:12.639874','127.0.0.1','15','猪排骨 ¥23.00/500g','change','已修改 default_image 。',10,2),(143,'2017-10-15 05:05:22.775273','127.0.0.1','14','猪肉 ¥20.00/500g','change','已修改 default_image 。',10,2),(144,'2017-10-15 05:05:36.671190','127.0.0.1','13','羊肉 ¥60.00/500g','change','已修改 default_image 。',10,2),(145,'2017-10-15 05:05:45.299676','127.0.0.1','12','牛排 ¥45.00/500g','change','已修改 default_image 。',10,2),(146,'2017-10-15 05:06:01.939916','127.0.0.1','11','基围虾 ¥36.00/500g','change','已修改 default_image 。',10,2),(147,'2017-10-15 05:06:10.608831','127.0.0.1','10','冷冻秋刀鱼 ¥55.00/500g','change','已修改 default_image 。',10,2),(148,'2017-10-15 05:06:20.264704','127.0.0.1','9','扇贝 ¥70.00/500g','change','已修改 default_image 。',10,2),(149,'2017-10-15 05:06:30.385821','127.0.0.1','8','大青虾 ¥100.00/盒','change','已修改 default_image 。',10,2),(150,'2017-10-15 05:06:37.544853','127.0.0.1','7','大青虾 ¥60.00/500g','change','已修改 default_image 。',10,2),(151,'2017-10-15 05:06:46.309239','127.0.0.1','6','奇异果 ¥50.00/500g','change','已修改 default_image 。',10,2),(152,'2017-10-15 05:06:53.252460','127.0.0.1','5','柠檬 ¥40.00/500g','change','已修改 default_image 。',10,2),(153,'2017-10-15 05:07:01.107416','127.0.0.1','4','葡萄 ¥20.00/500g','change','已修改 default_image 。',10,2),(154,'2017-10-15 05:07:09.294769','127.0.0.1','3','草莓 ¥30.00/盒','change','已修改 default_image 。',10,2),(155,'2017-10-15 05:07:17.372025','127.0.0.1','2','草莓 ¥5.00/100g','change','已修改 default_image 。',10,2),(156,'2017-10-15 05:07:27.157996','127.0.0.1','1','草莓 ¥10.00/500g','change','已修改 default_image 。',10,2),(157,'2017-10-15 07:11:19.517291','127.0.0.1','33','汤圆 ¥9.00/500g','change','已修改 index 。',13,2),(158,'2017-10-15 07:12:27.649772','127.0.0.1','35','汤圆 ¥9.00/500g','change','已修改 index 。',13,2);
/*!40000 ALTER TABLE `xadmin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_usersettings`
--

DROP TABLE IF EXISTS `xadmin_usersettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_usersettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(256) NOT NULL,
  `value` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_usersettings_user_id_edeabe4a_fk_df_users_id` (`user_id`),
  CONSTRAINT `xadmin_usersettings_user_id_edeabe4a_fk_df_users_id` FOREIGN KEY (`user_id`) REFERENCES `df_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_usersettings`
--

LOCK TABLES `xadmin_usersettings` WRITE;
/*!40000 ALTER TABLE `xadmin_usersettings` DISABLE KEYS */;
INSERT INTO `xadmin_usersettings` VALUES (1,'dashboard:home:pos','',2);
/*!40000 ALTER TABLE `xadmin_usersettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_userwidget`
--

DROP TABLE IF EXISTS `xadmin_userwidget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_userwidget` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_id` varchar(256) NOT NULL,
  `widget_type` varchar(50) NOT NULL,
  `value` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_userwidget_user_id_c159233a_fk_df_users_id` (`user_id`),
  CONSTRAINT `xadmin_userwidget_user_id_c159233a_fk_df_users_id` FOREIGN KEY (`user_id`) REFERENCES `df_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_userwidget`
--

LOCK TABLES `xadmin_userwidget` WRITE;
/*!40000 ALTER TABLE `xadmin_userwidget` DISABLE KEYS */;
/*!40000 ALTER TABLE `xadmin_userwidget` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-10-15 15:38:23
