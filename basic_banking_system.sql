-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: basic_banking_system
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bank_transaction`
--

DROP TABLE IF EXISTS `bank_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_transaction` (
  `BankTransactionID` int NOT NULL AUTO_INCREMENT,
  `BTCreationDate` date NOT NULL,
  `BTAmount` double NOT NULL,
  `BTFromAccount` varchar(45) NOT NULL,
  `BTToAccount` varchar(45) NOT NULL,
  PRIMARY KEY (`BankTransactionID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_transaction`
--

LOCK TABLES `bank_transaction` WRITE;
/*!40000 ALTER TABLE `bank_transaction` DISABLE KEYS */;
INSERT INTO `bank_transaction` VALUES (1,'2022-03-20',200,'aya@gmail.com','mona@gmail.com'),(2,'2022-03-20',200,'naglaa@gmail.com','mona@gmail.com'),(3,'2022-03-20',200,'mona@gmail.com','naglaa@gmail.com'),(4,'2022-03-20',500,'rana@gmail.com','noha@gmail.com'),(5,'2022-03-20',500,'noha@gmail.com','rana@gmail.com'),(6,'2022-03-21',500,'naglaa@gmail.com','rana@gmail.com'),(7,'2022-03-21',500,'naglaa@gmail.com','aya@gmail.com'),(8,'2022-03-21',500,'aya@gmail.com','mai@gmail.com');
/*!40000 ALTER TABLE `bank_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `CustomerID` int NOT NULL AUTO_INCREMENT,
  `CustomerName` varchar(45) NOT NULL,
  `CustomerEmail` varchar(45) NOT NULL,
  `BACurrentAmount` double NOT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE KEY `CustomerEmail_UNIQUE` (`CustomerEmail`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Naglaa','naglaa@gmail.com',4000),(2,'Mona','mona@gmail.com',2000),(3,'Rana','rana@gmail.com',3000),(4,'Sara','sara@gmail.com',9000),(5,'Noha','noha@gmail.com',1000),(6,'Aya','aya@gmail.com',8000),(7,'Nour','nour@gmail.com',7000),(8,'Fatma','fatma@gmail.com',6000),(9,'Mayada','mayada@gmail.com',4000),(10,'Mai','mai@gmail.com',3500);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-21 23:19:51
