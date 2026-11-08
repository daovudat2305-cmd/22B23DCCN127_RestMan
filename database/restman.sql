-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: restman
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `restman`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `restman` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `restman`;

--
-- Table structure for table `tblcombo7`
--

DROP TABLE IF EXISTS `tblcombo7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcombo7` (
  `tblMenuItem7id` int NOT NULL,
  PRIMARY KEY (`tblMenuItem7id`),
  CONSTRAINT `tblcombo7_ibfk_1` FOREIGN KEY (`tblMenuItem7id`) REFERENCES `tblmenuitem7` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcombo7`
--

LOCK TABLES `tblcombo7` WRITE;
/*!40000 ALTER TABLE `tblcombo7` DISABLE KEYS */;
INSERT INTO `tblcombo7` VALUES (6),(7),(8),(9);
/*!40000 ALTER TABLE `tblcombo7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcomboitem7`
--

DROP TABLE IF EXISTS `tblcomboitem7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcomboitem7` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `tblCombo7id` int NOT NULL,
  `tblFood7id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tblCombo7id` (`tblCombo7id`),
  KEY `tblFood7id` (`tblFood7id`),
  CONSTRAINT `tblcomboitem7_ibfk_1` FOREIGN KEY (`tblCombo7id`) REFERENCES `tblcombo7` (`tblMenuItem7id`) ON DELETE CASCADE,
  CONSTRAINT `tblcomboitem7_ibfk_2` FOREIGN KEY (`tblFood7id`) REFERENCES `tblfood7` (`tblMenuItem7id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcomboitem7`
--

LOCK TABLES `tblcomboitem7` WRITE;
/*!40000 ALTER TABLE `tblcomboitem7` DISABLE KEYS */;
INSERT INTO `tblcomboitem7` VALUES (1,2,6,1),(2,1,6,4),(3,2,6,5),(4,2,7,1),(5,1,7,3),(6,1,7,4),(7,2,7,5),(8,1,8,5),(9,2,8,2),(10,1,9,1),(11,1,9,3),(12,2,9,5);
/*!40000 ALTER TABLE `tblcomboitem7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcustomer7`
--

DROP TABLE IF EXISTS `tblcustomer7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcustomer7` (
  `customerCode` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `registrationDate` date NOT NULL,
  `tblMember7id` int NOT NULL,
  PRIMARY KEY (`tblMember7id`),
  UNIQUE KEY `customerCode` (`customerCode`),
  CONSTRAINT `tblcustomer7_ibfk_1` FOREIGN KEY (`tblMember7id`) REFERENCES `tblmember7` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcustomer7`
--

LOCK TABLES `tblcustomer7` WRITE;
/*!40000 ALTER TABLE `tblcustomer7` DISABLE KEYS */;
INSERT INTO `tblcustomer7` VALUES ('KH001','2026-01-10',1);
/*!40000 ALTER TABLE `tblcustomer7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblfood7`
--

DROP TABLE IF EXISTS `tblfood7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblfood7` (
  `unit` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tblMenuItem7id` int NOT NULL,
  PRIMARY KEY (`tblMenuItem7id`),
  CONSTRAINT `tblfood7_ibfk_1` FOREIGN KEY (`tblMenuItem7id`) REFERENCES `tblmenuitem7` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblfood7`
--

LOCK TABLES `tblfood7` WRITE;
/*!40000 ALTER TABLE `tblfood7` DISABLE KEYS */;
INSERT INTO `tblfood7` VALUES ('Đĩa',1),('Đĩa',2),('Đĩa',3),('Đĩa',4),('Ly',5);
/*!40000 ALTER TABLE `tblfood7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblimportdetail7`
--

DROP TABLE IF EXISTS `tblimportdetail7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblimportdetail7` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quantity` float NOT NULL,
  `importPrice` float NOT NULL,
  `amount` float NOT NULL,
  `tblImportReceipt7id` int NOT NULL,
  `tblIngredient7id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tblImportReceipt7id` (`tblImportReceipt7id`),
  KEY `tblIngredient7id` (`tblIngredient7id`),
  CONSTRAINT `tblimportdetail7_ibfk_1` FOREIGN KEY (`tblImportReceipt7id`) REFERENCES `tblimportreceipt7` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tblimportdetail7_ibfk_2` FOREIGN KEY (`tblIngredient7id`) REFERENCES `tblingredient7` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblimportdetail7`
--

LOCK TABLES `tblimportdetail7` WRITE;
/*!40000 ALTER TABLE `tblimportdetail7` DISABLE KEYS */;
INSERT INTO `tblimportdetail7` VALUES (1,10,420000,4200000,1,1),(2,10,45000,450000,1,2);
/*!40000 ALTER TABLE `tblimportdetail7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblimportreceipt7`
--

DROP TABLE IF EXISTS `tblimportreceipt7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblimportreceipt7` (
  `id` int NOT NULL AUTO_INCREMENT,
  `receiptCode` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `importDate` datetime NOT NULL,
  `totalAmount` float NOT NULL DEFAULT '0',
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tblSupplier7id` int NOT NULL,
  `tblWarehouseStaff7id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `receiptCode` (`receiptCode`),
  KEY `tblSupplier7id` (`tblSupplier7id`),
  KEY `tblWarehouseStaff7id` (`tblWarehouseStaff7id`),
  CONSTRAINT `tblimportreceipt7_ibfk_1` FOREIGN KEY (`tblSupplier7id`) REFERENCES `tblsupplier7` (`id`),
  CONSTRAINT `tblimportreceipt7_ibfk_2` FOREIGN KEY (`tblWarehouseStaff7id`) REFERENCES `tblwarehousestaff7` (`tblStaff7id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblimportreceipt7`
--

LOCK TABLES `tblimportreceipt7` WRITE;
/*!40000 ALTER TABLE `tblimportreceipt7` DISABLE KEYS */;
INSERT INTO `tblimportreceipt7` VALUES (1,'PN001','2026-11-01 08:30:00',4650000,'Nhập hàng định kỳ đầu tháng',1,4);
/*!40000 ALTER TABLE `tblimportreceipt7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblingredient7`
--

DROP TABLE IF EXISTS `tblingredient7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblingredient7` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ingredientCode` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stockQuantity` float NOT NULL DEFAULT '0',
  `avgImportPrice` float NOT NULL DEFAULT '0',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ingredientCode` (`ingredientCode`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblingredient7`
--

LOCK TABLES `tblingredient7` WRITE;
/*!40000 ALTER TABLE `tblingredient7` DISABLE KEYS */;
INSERT INTO `tblingredient7` VALUES (1,'NL01','Thăn nội bò Úc','Kg',45.5,420000,'Thịt bò tươi bảo quản lạnh'),(2,'NL02','Xà lách Romaine Đà Lạt','Kg',20,45000,'Rau sạch chuẩn VietGAP'),(3,'NL03','Cam sành tươi','Kg',50,25000,'Cam tươi dùng để ép nước');
/*!40000 ALTER TABLE `tblingredient7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblinvoice7`
--

DROP TABLE IF EXISTS `tblinvoice7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblinvoice7` (
  `id` int NOT NULL AUTO_INCREMENT,
  `invoiceCode` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdDate` datetime NOT NULL,
  `subTotal` float NOT NULL DEFAULT '0',
  `discountAmount` float NOT NULL DEFAULT '0',
  `depositDeducted` float NOT NULL DEFAULT '0',
  `totalAmount` float NOT NULL DEFAULT '0',
  `paymentMethod` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tblTable7id` int NOT NULL,
  `tblSalesStaff7id` int NOT NULL,
  `tblOnlineReservation7id` int DEFAULT NULL,
  `tblMembershipCard7id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `invoiceCode` (`invoiceCode`),
  UNIQUE KEY `tblOnlineReservation7id` (`tblOnlineReservation7id`),
  KEY `tblTable7id` (`tblTable7id`),
  KEY `tblSalesStaff7id` (`tblSalesStaff7id`),
  KEY `tblMembershipCard7id` (`tblMembershipCard7id`),
  CONSTRAINT `tblinvoice7_ibfk_1` FOREIGN KEY (`tblTable7id`) REFERENCES `tbltable7` (`id`),
  CONSTRAINT `tblinvoice7_ibfk_2` FOREIGN KEY (`tblSalesStaff7id`) REFERENCES `tblsalesstaff7` (`tblStaff7id`),
  CONSTRAINT `tblinvoice7_ibfk_3` FOREIGN KEY (`tblOnlineReservation7id`) REFERENCES `tblonlinereservation7` (`id`),
  CONSTRAINT `tblinvoice7_ibfk_4` FOREIGN KEY (`tblMembershipCard7id`) REFERENCES `tblmembershipcard7` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblinvoice7`
--

LOCK TABLES `tblinvoice7` WRITE;
/*!40000 ALTER TABLE `tblinvoice7` DISABLE KEYS */;
INSERT INTO `tblinvoice7` VALUES (1,'INV001','2026-11-05 20:45:00',500000,50000,100000,350000,'CHUYEN_KHOAN',1,3,1,1);
/*!40000 ALTER TABLE `tblinvoice7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmanager7`
--

DROP TABLE IF EXISTS `tblmanager7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblmanager7` (
  `tblStaff7id` int NOT NULL,
  PRIMARY KEY (`tblStaff7id`),
  CONSTRAINT `tblmanager7_ibfk_1` FOREIGN KEY (`tblStaff7id`) REFERENCES `tblstaff7` (`tblMember7id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmanager7`
--

LOCK TABLES `tblmanager7` WRITE;
/*!40000 ALTER TABLE `tblmanager7` DISABLE KEYS */;
INSERT INTO `tblmanager7` VALUES (2);
/*!40000 ALTER TABLE `tblmanager7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmember7`
--

DROP TABLE IF EXISTS `tblmember7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblmember7` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fullName` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dob` date DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmember7`
--

LOCK TABLES `tblmember7` WRITE;
/*!40000 ALTER TABLE `tblmember7` DISABLE KEYS */;
INSERT INTO `tblmember7` VALUES (1,'khachhang','123456','Đào Vũ Đạt','2005-05-23','Hà Đông, Hà Nội','dat.customer@restman.vn','0912345678','CUSTOMER','Khách hàng trực tuyến'),(2,'quanly','123456','Nguyễn Quản Lý','1990-01-15','Cầu Giấy, Hà Nội','manager@restman.vn','0987654321','MANAGER','Quản lý nhà hàng'),(3,'banhang','123456','Trần Thị Thu Ngân','1998-08-20','Đống Đa, Hà Nội','sales@restman.vn','0933445566','SALES','Nhân viên bán hàng ca sáng'),(4,'thukho','123456','Lê Văn Kho','1995-03-12','Thanh Xuân, Hà Nội','warehouse@restman.vn','0977889900','WAREHOUSE','Nhân viên quản lý kho');
/*!40000 ALTER TABLE `tblmember7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmembershipcard7`
--

DROP TABLE IF EXISTS `tblmembershipcard7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblmembershipcard7` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cardNumber` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `issueDate` date NOT NULL,
  `rewardPoints` int NOT NULL DEFAULT '0',
  `rank` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Đồng',
  `discountRate` float NOT NULL DEFAULT '0',
  `tblCustomer7id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cardNumber` (`cardNumber`),
  UNIQUE KEY `tblCustomer7id` (`tblCustomer7id`),
  CONSTRAINT `tblmembershipcard7_ibfk_1` FOREIGN KEY (`tblCustomer7id`) REFERENCES `tblcustomer7` (`tblMember7id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmembershipcard7`
--

LOCK TABLES `tblmembershipcard7` WRITE;
/*!40000 ALTER TABLE `tblmembershipcard7` DISABLE KEYS */;
INSERT INTO `tblmembershipcard7` VALUES (1,'CARD-KH001','2026-01-15',1500,'Vàng',0.1,1);
/*!40000 ALTER TABLE `tblmembershipcard7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmenuitem7`
--

DROP TABLE IF EXISTS `tblmenuitem7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblmenuitem7` (
  `id` int NOT NULL AUTO_INCREMENT,
  `itemCode` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` float NOT NULL,
  `imageUrl` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `tblMenuItemCategory7id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `itemCode` (`itemCode`),
  KEY `tblMenuItemCategory7id` (`tblMenuItemCategory7id`),
  CONSTRAINT `tblmenuitem7_ibfk_1` FOREIGN KEY (`tblMenuItemCategory7id`) REFERENCES `tblmenuitemcategory7` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmenuitem7`
--

LOCK TABLES `tblmenuitem7` WRITE;
/*!40000 ALTER TABLE `tblmenuitem7` DISABLE KEYS */;
INSERT INTO `tblmenuitem7` VALUES (1,'MA01','Bò bít tết sốt tiêu đen',150000,'https://images.unsplash.com/photo-1600891964092-4316c288032e?w=600','Thăn bò mềm mọng nước hòa quyện sốt tiêu đen cay nồng đậm vị kiểu Âu',1),(2,'MA02','Sườn cừu nướng thảo mộc',220000,'https://images.unsplash.com/photo-1544025162-d76694265947?w=600','Sườn cừu Úc nướng hương thảo và tỏi thơm lừng',1),(3,'MA05','Bò lúc lắc khoai tây',135000,'https://images.unsplash.com/photo-1558030006-450675393462?w=600','Thịt bò thái vuông xào lửa lớn kèm khoai tây chiên giòn',1),(4,'MA18','Salad bò xào dầu giấm',75000,'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=600','Rau củ tươi sạch trộn sốt dầu giấm kèm thịt bò áp chảo',2),(5,'MA36','Nước cam ép',30000,'https://images.unsplash.com/photo-1613478223719-2ab802602423?w=600','Nước cam tươi nguyên chất 100% giàu vitamin C',3),(6,'CB01','Combo Cặp đôi lãng mạn',350000,'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=600','Gói combo hoàn hảo dành cho 2 người gồm bít tết, salad và nước cam',5),(7,'CB02','Combo Bò nướng thịnh soạn',450000,'https://images.unsplash.com/photo-1544025162-d76694265947?w=600','Đại tiệc thịt bò nướng kèm khai vị và đồ uống mát lạnh cho gia đình',5),(8,'CB1817','Combo cừu',349000,'https://images.unsplash.com/photo-1544025162-d76694265947?w=600','Combo siêu tiết kiệm',5),(9,'CB4452','Combo bò siêu ưu đãi',300000,'/RestMan/uploads/combo_1794014624438_image16_3f0680101d444eefb18aabd96d79c78c_1024x1024.webp','combooooooooooooooooooooo bò',5);
/*!40000 ALTER TABLE `tblmenuitem7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmenuitemcategory7`
--

DROP TABLE IF EXISTS `tblmenuitemcategory7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblmenuitemcategory7` (
  `id` int NOT NULL AUTO_INCREMENT,
  `categoryCode` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categoryCode` (`categoryCode`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmenuitemcategory7`
--

LOCK TABLES `tblmenuitemcategory7` WRITE;
/*!40000 ALTER TABLE `tblmenuitemcategory7` DISABLE KEYS */;
INSERT INTO `tblmenuitemcategory7` VALUES (1,'CAT01','Món chính','Các món chính chế biến từ thịt bò, cừu, hải sản'),(2,'CAT02','Khai vị','Các món salad, súp nhẹ đầu bữa'),(3,'CAT03','Đồ uống','Nước ép trái cây, đồ uống giải khát'),(4,'CAT04','Tráng miệng','Bánh ngọt, kem và trái cây tươi'),(5,'CAT05','Combo','Các gói thực đơn kết hợp ưu đãi trọn gói');
/*!40000 ALTER TABLE `tblmenuitemcategory7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblonlinereservation7`
--

DROP TABLE IF EXISTS `tblonlinereservation7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblonlinereservation7` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reservationCode` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bookingTime` datetime NOT NULL,
  `arrivalTime` datetime NOT NULL,
  `guestCount` int NOT NULL,
  `depositAmount` float NOT NULL DEFAULT '0',
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tblCustomer7id` int NOT NULL,
  `tblTable7id` int NOT NULL,
  `tblSalesStaff7id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reservationCode` (`reservationCode`),
  KEY `tblCustomer7id` (`tblCustomer7id`),
  KEY `tblTable7id` (`tblTable7id`),
  KEY `tblSalesStaff7id` (`tblSalesStaff7id`),
  CONSTRAINT `tblonlinereservation7_ibfk_1` FOREIGN KEY (`tblCustomer7id`) REFERENCES `tblcustomer7` (`tblMember7id`),
  CONSTRAINT `tblonlinereservation7_ibfk_2` FOREIGN KEY (`tblTable7id`) REFERENCES `tbltable7` (`id`),
  CONSTRAINT `tblonlinereservation7_ibfk_3` FOREIGN KEY (`tblSalesStaff7id`) REFERENCES `tblsalesstaff7` (`tblStaff7id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblonlinereservation7`
--

LOCK TABLES `tblonlinereservation7` WRITE;
/*!40000 ALTER TABLE `tblonlinereservation7` DISABLE KEYS */;
INSERT INTO `tblonlinereservation7` VALUES (1,'RES001','2026-11-05 14:00:00','2026-11-05 19:00:00',2,100000,'Chuẩn bị bàn gần cửa sổ','CONFIRMED',1,1,3);
/*!40000 ALTER TABLE `tblonlinereservation7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblorderdetail7`
--

DROP TABLE IF EXISTS `tblorderdetail7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblorderdetail7` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `priceAtOrder` float NOT NULL,
  `amount` float NOT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tblTableOrder7id` int NOT NULL,
  `tblMenuItem7id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tblTableOrder7id` (`tblTableOrder7id`),
  KEY `tblMenuItem7id` (`tblMenuItem7id`),
  CONSTRAINT `tblorderdetail7_ibfk_1` FOREIGN KEY (`tblTableOrder7id`) REFERENCES `tbltableorder7` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tblorderdetail7_ibfk_2` FOREIGN KEY (`tblMenuItem7id`) REFERENCES `tblmenuitem7` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblorderdetail7`
--

LOCK TABLES `tblorderdetail7` WRITE;
/*!40000 ALTER TABLE `tblorderdetail7` DISABLE KEYS */;
INSERT INTO `tblorderdetail7` VALUES (1,1,350000,350000,'Combo đã đặt trước',1,6),(2,1,150000,150000,'Gọi thêm tại bàn',1,1);
/*!40000 ALTER TABLE `tblorderdetail7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblreservationdetail7`
--

DROP TABLE IF EXISTS `tblreservationdetail7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblreservationdetail7` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `priceAtBooking` float NOT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tblOnlineReservation7id` int NOT NULL,
  `tblMenuItem7id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tblOnlineReservation7id` (`tblOnlineReservation7id`),
  KEY `tblMenuItem7id` (`tblMenuItem7id`),
  CONSTRAINT `tblreservationdetail7_ibfk_1` FOREIGN KEY (`tblOnlineReservation7id`) REFERENCES `tblonlinereservation7` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tblreservationdetail7_ibfk_2` FOREIGN KEY (`tblMenuItem7id`) REFERENCES `tblmenuitem7` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblreservationdetail7`
--

LOCK TABLES `tblreservationdetail7` WRITE;
/*!40000 ALTER TABLE `tblreservationdetail7` DISABLE KEYS */;
INSERT INTO `tblreservationdetail7` VALUES (1,1,350000,'Làm nóng khi khách đến',1,6);
/*!40000 ALTER TABLE `tblreservationdetail7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblsalesstaff7`
--

DROP TABLE IF EXISTS `tblsalesstaff7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblsalesstaff7` (
  `tblStaff7id` int NOT NULL,
  PRIMARY KEY (`tblStaff7id`),
  CONSTRAINT `tblsalesstaff7_ibfk_1` FOREIGN KEY (`tblStaff7id`) REFERENCES `tblstaff7` (`tblMember7id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblsalesstaff7`
--

LOCK TABLES `tblsalesstaff7` WRITE;
/*!40000 ALTER TABLE `tblsalesstaff7` DISABLE KEYS */;
INSERT INTO `tblsalesstaff7` VALUES (3);
/*!40000 ALTER TABLE `tblsalesstaff7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblstaff7`
--

DROP TABLE IF EXISTS `tblstaff7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblstaff7` (
  `staffCode` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hireDate` date DEFAULT NULL,
  `salary` float NOT NULL DEFAULT '0',
  `tblMember7id` int NOT NULL,
  PRIMARY KEY (`tblMember7id`),
  UNIQUE KEY `staffCode` (`staffCode`),
  CONSTRAINT `tblstaff7_ibfk_1` FOREIGN KEY (`tblMember7id`) REFERENCES `tblmember7` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblstaff7`
--

LOCK TABLES `tblstaff7` WRITE;
/*!40000 ALTER TABLE `tblstaff7` DISABLE KEYS */;
INSERT INTO `tblstaff7` VALUES ('NV001','Quản lý trưởng','2023-05-01',25000000,2),('NV002','Nhân viên bán hàng','2024-02-15',12000000,3),('NV003','Nhân viên kho','2024-03-01',11000000,4);
/*!40000 ALTER TABLE `tblstaff7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblsupplier7`
--

DROP TABLE IF EXISTS `tblsupplier7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblsupplier7` (
  `id` int NOT NULL AUTO_INCREMENT,
  `supplierCode` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `supplierCode` (`supplierCode`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblsupplier7`
--

LOCK TABLES `tblsupplier7` WRITE;
/*!40000 ALTER TABLE `tblsupplier7` DISABLE KEYS */;
INSERT INTO `tblsupplier7` VALUES (1,'NCC01','Công ty Thực phẩm Sạch Á Âu','KCN Bắc Thăng Long, Hà Nội','02438889999','contact@thucphamaau.vn','Chuyên cung cấp thịt bò Úc, cừu nhập khẩu');
/*!40000 ALTER TABLE `tblsupplier7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltable7`
--

DROP TABLE IF EXISTS `tbltable7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbltable7` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tableCode` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `capacity` int NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tableCode` (`tableCode`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltable7`
--

LOCK TABLES `tbltable7` WRITE;
/*!40000 ALTER TABLE `tbltable7` DISABLE KEYS */;
INSERT INTO `tbltable7` VALUES (1,'TB01','Bàn 01 - Tầng 1',4,'Bàn cạnh cửa sổ thoáng mát','Đang hoạt động'),(2,'TB02','Bàn 02 - Tầng 1',6,'Bàn gia đình khu trung tâm','Đang hoạt động'),(3,'TB03','Bàn VIP 01 - Tầng 2',10,'Phòng riêng máy lạnh','Phù hợp tiếp khách');
/*!40000 ALTER TABLE `tbltable7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltableorder7`
--

DROP TABLE IF EXISTS `tbltableorder7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbltableorder7` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orderCode` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `orderTime` datetime NOT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tblTable7id` int NOT NULL,
  `tblSalesStaff7id` int NOT NULL,
  `tblInvoice7id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orderCode` (`orderCode`),
  KEY `tblTable7id` (`tblTable7id`),
  KEY `tblSalesStaff7id` (`tblSalesStaff7id`),
  KEY `tblInvoice7id` (`tblInvoice7id`),
  CONSTRAINT `tbltableorder7_ibfk_1` FOREIGN KEY (`tblTable7id`) REFERENCES `tbltable7` (`id`),
  CONSTRAINT `tbltableorder7_ibfk_2` FOREIGN KEY (`tblSalesStaff7id`) REFERENCES `tblsalesstaff7` (`tblStaff7id`),
  CONSTRAINT `tbltableorder7_ibfk_3` FOREIGN KEY (`tblInvoice7id`) REFERENCES `tblinvoice7` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltableorder7`
--

LOCK TABLES `tbltableorder7` WRITE;
/*!40000 ALTER TABLE `tbltableorder7` DISABLE KEYS */;
INSERT INTO `tbltableorder7` VALUES (1,'ORD001','2026-11-05 19:05:00','PAID',1,3,1);
/*!40000 ALTER TABLE `tbltableorder7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblwarehousestaff7`
--

DROP TABLE IF EXISTS `tblwarehousestaff7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblwarehousestaff7` (
  `tblStaff7id` int NOT NULL,
  PRIMARY KEY (`tblStaff7id`),
  CONSTRAINT `tblwarehousestaff7_ibfk_1` FOREIGN KEY (`tblStaff7id`) REFERENCES `tblstaff7` (`tblMember7id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblwarehousestaff7`
--

LOCK TABLES `tblwarehousestaff7` WRITE;
/*!40000 ALTER TABLE `tblwarehousestaff7` DISABLE KEYS */;
INSERT INTO `tblwarehousestaff7` VALUES (4);
/*!40000 ALTER TABLE `tblwarehousestaff7` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-08  8:55:46
