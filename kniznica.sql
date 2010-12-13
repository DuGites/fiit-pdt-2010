-- MySQL dump 10.13  Distrib 5.1.51, for unknown-linux-gnu (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	5.1.51

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
-- Table structure for table `autori`
--

DROP TABLE IF EXISTS `autori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autori` (
  `idautori` int(11) NOT NULL,
  `meno` varchar(45) DEFAULT NULL,
  `priezvisko` varchar(45) DEFAULT NULL,
  `pracoviska_idpracoviska` int(11) NOT NULL,
  PRIMARY KEY (`idautori`),
  KEY `fk_autori_pracoviska` (`pracoviska_idpracoviska`),
  CONSTRAINT `fk_autori_pracoviska` FOREIGN KEY (`pracoviska_idpracoviska`) REFERENCES `pracoviska` (`idpracoviska`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autori`
--

LOCK TABLES `autori` WRITE;
/*!40000 ALTER TABLE `autori` DISABLE KEYS */;
INSERT INTO `autori` VALUES (1,'Ludo','Ondrejov',1),(2,'Samuel','Chalupka',1),(3,'Mark','Twain',1),(4,'Stephen','King',1),(5,'Joshua','Bloch',1);
/*!40000 ALTER TABLE `autori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autorstvo`
--

DROP TABLE IF EXISTS `autorstvo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autorstvo` (
  `idautorstvo` int(11) NOT NULL,
  `percent` int(11) DEFAULT NULL,
  `autori_idautori` int(11) NOT NULL,
  `dielo_iddielo` int(11) NOT NULL,
  PRIMARY KEY (`idautorstvo`),
  KEY `fk_autorstvo_autori1` (`autori_idautori`),
  KEY `fk_autorstvo_dielo1` (`dielo_iddielo`),
  CONSTRAINT `fk_autorstvo_autori1` FOREIGN KEY (`autori_idautori`) REFERENCES `autori` (`idautori`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_autorstvo_dielo1` FOREIGN KEY (`dielo_iddielo`) REFERENCES `dielo` (`iddielo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autorstvo`
--

LOCK TABLES `autorstvo` WRITE;
/*!40000 ALTER TABLE `autorstvo` DISABLE KEYS */;
INSERT INTO `autorstvo` VALUES (1,100,1,1),(2,100,2,2),(3,100,3,3);
/*!40000 ALTER TABLE `autorstvo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citatelia`
--

DROP TABLE IF EXISTS `citatelia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `citatelia` (
  `idcitatelia` int(11) NOT NULL,
  `meno` varchar(45) DEFAULT NULL,
  `priezvisko` varchar(45) DEFAULT NULL,
  `registracia` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idcitatelia`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citatelia`
--

LOCK TABLES `citatelia` WRITE;
/*!40000 ALTER TABLE `citatelia` DISABLE KEYS */;
INSERT INTO `citatelia` VALUES (1,'Tomas','Haber','1.1.2010'),(2,'Michal','Immer','12.2.2009'),(3,'Marcel','Balaz','12.2.2009'),(4,'Lukas','Nemcik','12.2.2005');
/*!40000 ALTER TABLE `citatelia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dielo`
--

DROP TABLE IF EXISTS `dielo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dielo` (
  `iddielo` int(11) NOT NULL,
  `nazov` varchar(100) DEFAULT NULL,
  `isbn` varchar(45) DEFAULT NULL,
  `jazyk` varchar(45) DEFAULT NULL,
  `vydane` year(4) DEFAULT NULL,
  `vydavatelstva_idvydavatelstva` int(11) NOT NULL,
  `typy_idtypy` int(11) NOT NULL,
  PRIMARY KEY (`iddielo`),
  KEY `fk_dielo_vydavatelstva1` (`vydavatelstva_idvydavatelstva`),
  KEY `fk_dielo_typy1` (`typy_idtypy`),
  CONSTRAINT `fk_dielo_vydavatelstva1` FOREIGN KEY (`vydavatelstva_idvydavatelstva`) REFERENCES `vydavatelstva` (`idvydavatelstva`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_dielo_typy1` FOREIGN KEY (`typy_idtypy`) REFERENCES `typy` (`idtypy`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dielo`
--

LOCK TABLES `dielo` WRITE;
/*!40000 ALTER TABLE `dielo` DISABLE KEYS */;
INSERT INTO `dielo` VALUES (1,'Zbojnicka Mladost','123456780','SK',1963,1,1),(2,'The Jaunt','123456780423','EN',1985,1,1),(3,'Mor ho!','123456780423','SK',1943,1,1),(4,'Effective Java','5456456456','EN',2007,2,1),(5,'Zbornik Esejj 2010','3423432422','SK',2010,1,1);
/*!40000 ALTER TABLE `dielo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `editori`
--

DROP TABLE IF EXISTS `editori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `editori` (
  `ideditori` int(11) NOT NULL,
  `percent` int(11) DEFAULT NULL,
  `dielo_iddielo` int(11) NOT NULL,
  `autori_idautori` int(11) NOT NULL,
  PRIMARY KEY (`ideditori`),
  KEY `fk_editori_dielo1` (`dielo_iddielo`),
  KEY `fk_editori_autori1` (`autori_idautori`),
  CONSTRAINT `fk_editori_dielo1` FOREIGN KEY (`dielo_iddielo`) REFERENCES `dielo` (`iddielo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_editori_autori1` FOREIGN KEY (`autori_idautori`) REFERENCES `autori` (`idautori`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `editori`
--

LOCK TABLES `editori` WRITE;
/*!40000 ALTER TABLE `editori` DISABLE KEYS */;
INSERT INTO `editori` VALUES (1,100,1,1),(2,100,2,2),(3,100,3,3),(4,100,4,4);
/*!40000 ALTER TABLE `editori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exemplare`
--

DROP TABLE IF EXISTS `exemplare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exemplare` (
  `idexemplare` int(11) NOT NULL,
  `stav` varchar(45) DEFAULT NULL,
  `dielo_iddielo` int(11) NOT NULL,
  PRIMARY KEY (`idexemplare`),
  KEY `fk_exemplare_dielo1` (`dielo_iddielo`),
  CONSTRAINT `fk_exemplare_dielo1` FOREIGN KEY (`dielo_iddielo`) REFERENCES `dielo` (`iddielo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exemplare`
--

LOCK TABLES `exemplare` WRITE;
/*!40000 ALTER TABLE `exemplare` DISABLE KEYS */;
INSERT INTO `exemplare` VALUES (1,'vypozicane',1),(2,'vypozicane',2),(3,'nevypozicane',3),(4,'nevypozicane',4);
/*!40000 ALTER TABLE `exemplare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pracoviska`
--

DROP TABLE IF EXISTS `pracoviska`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pracoviska` (
  `idpracoviska` int(11) NOT NULL,
  `pracovisko` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idpracoviska`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pracoviska`
--

LOCK TABLES `pracoviska` WRITE;
/*!40000 ALTER TABLE `pracoviska` DISABLE KEYS */;
INSERT INTO `pracoviska` VALUES (1,'Neurcene'),(2,'SAV Ustav literarneho vyskumu'),(3,'Fakulta elektrotechniky a Informatiky STU Bra');
/*!40000 ALTER TABLE `pracoviska` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prispevky`
--

DROP TABLE IF EXISTS `prispevky`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prispevky` (
  `idprispevky` int(11) NOT NULL,
  `nazov` varchar(45) DEFAULT NULL,
  `tags` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idprispevky`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prispevky`
--

LOCK TABLES `prispevky` WRITE;
/*!40000 ALTER TABLE `prispevky` DISABLE KEYS */;
INSERT INTO `prispevky` VALUES (1,'Sledovanie uloh softverovom projekte','dizajn'),(2,'Koordinacia vo virtualnych timoch',NULL);
/*!40000 ALTER TABLE `prispevky` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prispievatelia`
--

DROP TABLE IF EXISTS `prispievatelia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prispievatelia` (
  `idprispievatelia` int(11) NOT NULL,
  `percent` int(11) DEFAULT NULL,
  `autori_idautori` int(11) NOT NULL,
  `prispevky_idprispevky` int(11) NOT NULL,
  PRIMARY KEY (`idprispievatelia`),
  KEY `fk_prispievatelia_autori1` (`autori_idautori`),
  KEY `fk_prispievatelia_prispevky1` (`prispevky_idprispevky`),
  CONSTRAINT `fk_prispievatelia_autori1` FOREIGN KEY (`autori_idautori`) REFERENCES `autori` (`idautori`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_prispievatelia_prispevky1` FOREIGN KEY (`prispevky_idprispevky`) REFERENCES `prispevky` (`idprispevky`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prispievatelia`
--

LOCK TABLES `prispievatelia` WRITE;
/*!40000 ALTER TABLE `prispievatelia` DISABLE KEYS */;
INSERT INTO `prispievatelia` VALUES (1,10,4,1),(2,10,5,1);
/*!40000 ALTER TABLE `prispievatelia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `typy`
--

DROP TABLE IF EXISTS `typy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `typy` (
  `idtypy` int(11) NOT NULL,
  PRIMARY KEY (`idtypy`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `typy`
--

LOCK TABLES `typy` WRITE;
/*!40000 ALTER TABLE `typy` DISABLE KEYS */;
INSERT INTO `typy` VALUES (1);
/*!40000 ALTER TABLE `typy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vydavatelstva`
--

DROP TABLE IF EXISTS `vydavatelstva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vydavatelstva` (
  `idvydavatelstva` int(11) NOT NULL,
  `meno` varchar(45) DEFAULT NULL,
  `adresa` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idvydavatelstva`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vydavatelstva`
--

LOCK TABLES `vydavatelstva` WRITE;
/*!40000 ALTER TABLE `vydavatelstva` DISABLE KEYS */;
INSERT INTO `vydavatelstva` VALUES (1,'Ikar','Bratislava'),(2,'Grada','Praha');
/*!40000 ALTER TABLE `vydavatelstva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vypozicky`
--

DROP TABLE IF EXISTS `vypozicky`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vypozicky` (
  `idvypozicky` int(11) NOT NULL,
  `vypozicane` datetime DEFAULT NULL,
  `vratene` varchar(45) DEFAULT NULL,
  `poznamka` varchar(45) DEFAULT NULL,
  `citatelia_idcitatelia` int(11) NOT NULL,
  `exemplare_idexemplare` int(11) NOT NULL,
  PRIMARY KEY (`idvypozicky`),
  KEY `fk_vypozicky_citatelia1` (`citatelia_idcitatelia`),
  KEY `fk_vypozicky_exemplare1` (`exemplare_idexemplare`),
  CONSTRAINT `fk_vypozicky_citatelia1` FOREIGN KEY (`citatelia_idcitatelia`) REFERENCES `citatelia` (`idcitatelia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_vypozicky_exemplare1` FOREIGN KEY (`exemplare_idexemplare`) REFERENCES `exemplare` (`idexemplare`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vypozicky`
--

LOCK TABLES `vypozicky` WRITE;
/*!40000 ALTER TABLE `vypozicky` DISABLE KEYS */;
INSERT INTO `vypozicky` VALUES (1,'2001-10-20 10:00:00',NULL,'',1,1),(2,'2003-10-20 10:00:00',NULL,NULL,2,2),(3,'2023-01-20 10:00:00',NULL,NULL,3,3),(4,'2004-04-20 09:00:00',NULL,NULL,4,4);
/*!40000 ALTER TABLE `vypozicky` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zbornik`
--

DROP TABLE IF EXISTS `zbornik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zbornik` (
  `idzbornik` int(11) NOT NULL,
  `dielo_iddielo` int(11) NOT NULL,
  `prispevky_idprispevky` int(11) NOT NULL,
  PRIMARY KEY (`idzbornik`),
  KEY `fk_zbornik_dielo1` (`dielo_iddielo`),
  KEY `fk_zbornik_prispevky1` (`prispevky_idprispevky`),
  CONSTRAINT `fk_zbornik_dielo1` FOREIGN KEY (`dielo_iddielo`) REFERENCES `dielo` (`iddielo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_zbornik_prispevky1` FOREIGN KEY (`prispevky_idprispevky`) REFERENCES `prispevky` (`idprispevky`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zbornik`
--

LOCK TABLES `zbornik` WRITE;
/*!40000 ALTER TABLE `zbornik` DISABLE KEYS */;
INSERT INTO `zbornik` VALUES (1,5,1);
/*!40000 ALTER TABLE `zbornik` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-12-11 18:04:03
