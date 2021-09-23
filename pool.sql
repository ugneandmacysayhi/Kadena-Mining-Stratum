-- MySQL dump 10.13  Distrib 8.0.26, for Linux (x86_64)
--
-- Host: localhost    Database: kdapool
-- ------------------------------------------------------
-- Server version	8.0.26-0ubuntu0.20.04.2

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
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `coinid` int DEFAULT NULL,
  `last_earning` int DEFAULT NULL,
  `is_locked` tinyint(1) DEFAULT '0',
  `no_fees` tinyint(1) DEFAULT NULL,
  `donation` tinyint unsigned NOT NULL DEFAULT '0',
  `logtraffic` tinyint(1) DEFAULT NULL,
  `balance` double NOT NULL DEFAULT '0',
  `username` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `coinsymbol` varchar(16) DEFAULT NULL,
  `swap_time` int unsigned DEFAULT NULL,
  `login` varchar(45) DEFAULT NULL,
  `hostaddr` varchar(48) DEFAULT NULL,
  `payout_min` double DEFAULT '0.1',
  `hashrate` double(18,3) DEFAULT NULL,
  `password` varchar(256) NOT NULL DEFAULT '',
  `hashrate2` double(18,3) DEFAULT NULL,
  `last_share` int DEFAULT NULL,
  `whitelist` tinyint DEFAULT NULL,
  `last_share_time` int DEFAULT NULL,
  `account_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `coin` (`coinid`),
  KEY `balance` (`balance`),
  KEY `earning` (`last_earning`)
) ENGINE=InnoDB AUTO_INCREMENT=63652 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `algos`
--

DROP TABLE IF EXISTS `algos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `algos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(16) DEFAULT NULL,
  `profit` double DEFAULT NULL,
  `rent` double DEFAULT NULL,
  `factor` double DEFAULT NULL,
  `overflow` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `algos`
--

LOCK TABLES `algos` WRITE;
/*!40000 ALTER TABLE `algos` DISABLE KEYS */;
INSERT INTO `algos` VALUES (1,'scrypt',16.481350199722,16.151723195728,1,1),(2,'scryptn',0,0,1,NULL),(3,'neoscrypt',0.053322780035898,0.05225632443518,1,NULL),(4,'quark',0,0,1,NULL),(5,'lyra2',0,0,1,NULL),(6,'x11',0,0,1,1),(7,'x13',0,0,1,1),(8,'x14',0,0,1,NULL),(9,'x15',0,0,1,NULL),(10,'fresh',0.0026231955438411,0.0027018914101563,5,NULL),(11,'sha256',0,0,1,1),(12,'qubit',0.00012952279651798,0.00013211325244834,1,NULL),(13,'skein',16.481350199722,16.151723195728,1,1),(14,'groestl',0,0,1,NULL),(15,'blake',0,0,1,NULL),(16,'keccak',0,0,1,NULL),(17,'nist5',0,0,1,NULL),(18,'zr5',0,0,1,NULL),(19,'c11',0.000092773221651005,0.000094628686084025,1,NULL),(20,'drop',2.5713261892185e-21,32.540632674103,1.5,NULL),(21,'skein2',0,0,1,NULL),(22,'bmw',0.00000000000009119158510914,0.000072523406145041,100,NULL),(23,'argon2',0,0,1,NULL),(24,'blake2s',0,0,1,NULL),(25,'decred',0,0,1,NULL),(26,'luffa',0,0,1,NULL),(27,'lyra2v2',0.00038302229015942,0.00037536184435623,1,NULL),(28,'penta',0,0,1,NULL),(29,'dmd-gr',0,0,1,NULL),(30,'myr-gr',0,0,1,NULL),(31,'m7m',0.04932252545475,0.050308975963845,1,1),(32,'sib',0,0,1,NULL),(33,'vanilla',0,0,1,NULL),(34,'velvet',0,0,1,NULL),(35,'yescrypt',0,0,1,NULL),(36,'whirlpool',0,0,1,NULL),(37,'sha256t',0,0,1,NULL),(38,'bastion',0,0,1,NULL),(39,'bitcore',0,0,1,NULL),(40,'blakecoin',0,0,1,NULL),(41,'deep',0,0,1,NULL),(42,'hmq1725',0,0,1,1),(43,'keccakc',0,0,1,NULL),(44,'jha',0,0,1,NULL),(45,'hsr',0,0,1,NULL),(46,'lbry',0,0,1,NULL),(47,'lyra2z',0.0050353766597426,0.0051360841929375,1,1),(48,'polytimos',0,0,1,NULL),(49,'x11evo',0,0,1,NULL),(50,'x12',0,0,1,NULL),(51,'x16r',0,0,1,1),(52,'x16s',0,3.533174917882e-26,1,1),(53,'x17',0.0007806060438099,0.0007962181646861,1,NULL),(54,'xevan',0,0,1,NULL),(55,'phi',0,0,1,NULL),(56,'skunk',0,0,1,NULL),(57,'timetravel',0,0,1,NULL),(58,'tribus',0,0,1,NULL),(59,'a5a',0,0,1,NULL),(60,'veltor',0,0,1,NULL),(61,'yescryptR16',0,0,1,NULL),(62,'yescryptR32',0,0,1,0),(63,'vitality',0,0,1,NULL),(64,'vitalium',2.6385446554853,4.3393090170246,1,NULL),(65,'balloon',0,0,1,NULL),(66,'deft',0,0,1,NULL),(67,'phi2',0,0,1,0),(68,'bcd',0.0010589378950642,0.0010377591371629,1,1),(69,'hex',0,0,1,NULL),(70,'allium',0,0.000041609205381217,1,1),(71,'lbk3.c',0,0,1,NULL),(72,'lbk3',0,0,1,NULL),(73,'merit',0,0,1,1),(74,'sonoa',0,0,1,NULL),(75,'argon2ad',0,0,1,1),(76,'argon2d-dyn',0,0,1,NULL),(77,'renesis',0,0,1,0),(78,'cuckoo',0,0,1,1),(79,'cuckoo27',0,0,1,NULL),(80,'x22i',0,0,1,1),(81,'bcsh3',0,0,1,NULL),(82,'bsha3',0,0,1,0),(83,'x18',0,0,1,NULL),(84,'x21s',0,5e-324,1,1),(85,'argon2m',0,0,1,0),(86,'argon2d250',0,0,1,1),(87,'x16rt',0,0,1,1),(88,'equihash144,5',0,272018.84015224,1,NULL),(89,'equihash144',0,51971.564464661,1,NULL),(90,'cuckoo29',0,0,1,NULL),(91,'argon2d',0,0,1,NULL),(92,'x25x',0,0.00765491681726,1,1),(93,'yespowerurx',0,0,1,NULL),(94,'equihash125',0,0,1,NULL),(95,'equihash192',0,0,1,NULL),(96,'progpow',0,0,1,NULL),(97,'randomx',0,0,1,NULL),(98,'cuckaroo',0,0,1,NULL),(99,'cuckatoo',0,0,1,NULL),(100,'epic',0,0,1,NULL),(101,'x16rv2',0,0,1,1),(102,'beamHashII',0,0,1,NULL),(103,'eaglesong',0,0,1,NULL),(104,'mwc',0,0,1,NULL);
/*!40000 ALTER TABLE `algos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blocks`
--

DROP TABLE IF EXISTS `blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blocks` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `coin_id` int DEFAULT NULL,
  `height` int unsigned DEFAULT NULL,
  `confirmations` int DEFAULT NULL,
  `time` int DEFAULT NULL,
  `userid` int DEFAULT NULL,
  `workerid` int DEFAULT NULL,
  `difficulty_user` double NOT NULL DEFAULT '0',
  `price` double DEFAULT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `difficulty` double NOT NULL DEFAULT '0',
  `category` varchar(16) DEFAULT 'new',
  `algo` varchar(16) DEFAULT 'unknown',
  `blockhash` varchar(128) DEFAULT NULL,
  `txhash` varchar(128) DEFAULT NULL,
  `segwit` tinyint unsigned NOT NULL DEFAULT '0',
  `effort` float DEFAULT NULL,
  `jobid` mediumint DEFAULT NULL,
  `chainid` int NOT NULL DEFAULT '-1',
  `stratum_id` varchar(11) NOT NULL DEFAULT '-1',
  `node_id` varchar(11) DEFAULT NULL,
  `mode` varchar(11) NOT NULL DEFAULT 'normal',
  `party_pass` varchar(9) DEFAULT NULL,
  `duration` int NOT NULL DEFAULT '0',
  `shares` double DEFAULT '0',
  `state` int NOT NULL DEFAULT '0',
  `rigname` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`time`),
  KEY `algo1` (`algo`),
  KEY `coin` (`coin_id`),
  KEY `category` (`category`),
  KEY `user1` (`userid`),
  KEY `height1` (`height`)
) ENGINE=InnoDB AUTO_INCREMENT=3483766 DEFAULT CHARSET=utf8mb3 COMMENT='Discovered blocks persisted from Litecoin Service';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blocks`
--

LOCK TABLES `blocks` WRITE;
/*!40000 ALTER TABLE `blocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `blocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coins`
--

DROP TABLE IF EXISTS `coins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `fullname` varchar(24) DEFAULT NULL,
  `symbol` varchar(16) DEFAULT NULL,
  `symbol2` varchar(16) DEFAULT NULL,
  `algo` varchar(16) DEFAULT NULL,
  `version` varchar(32) DEFAULT NULL,
  `image` varchar(1024) DEFAULT NULL,
  `market` varchar(64) DEFAULT NULL,
  `marketid` int DEFAULT NULL,
  `master_wallet` varchar(1024) DEFAULT NULL,
  `charity_address` varchar(1024) DEFAULT NULL,
  `charity_amount` double DEFAULT NULL,
  `charity_percent` double DEFAULT NULL,
  `deposit_address` varchar(1024) DEFAULT NULL,
  `deposit_minimum` double DEFAULT '1',
  `sellonbid` tinyint(1) DEFAULT NULL,
  `dontsell` tinyint(1) DEFAULT '1',
  `block_explorer` varchar(1024) DEFAULT NULL,
  `index_avg` double DEFAULT NULL,
  `connections` int DEFAULT NULL,
  `errors` varchar(1024) DEFAULT NULL,
  `balance` double DEFAULT NULL,
  `immature` double DEFAULT NULL,
  `cleared` double DEFAULT NULL,
  `available` double DEFAULT NULL,
  `stake` double DEFAULT NULL,
  `mint` double DEFAULT NULL,
  `txfee` double DEFAULT NULL,
  `payout_min` double DEFAULT NULL,
  `payout_max` double DEFAULT NULL,
  `block_time` int DEFAULT NULL,
  `difficulty` double DEFAULT '1',
  `difficulty_pos` double DEFAULT NULL,
  `block_height` int DEFAULT NULL,
  `target_height` int DEFAULT NULL,
  `powend_height` int DEFAULT NULL,
  `network_hash` double DEFAULT NULL,
  `price` double DEFAULT NULL,
  `price2` double DEFAULT NULL,
  `reward` double DEFAULT '1',
  `reward_model` varchar(30) DEFAULT 'PROP',
  `reward_mul` double DEFAULT '1',
  `mature_blocks` int DEFAULT NULL,
  `enable` tinyint(1) DEFAULT '0',
  `auto_ready` tinyint(1) DEFAULT '0',
  `visible` tinyint(1) DEFAULT NULL,
  `no_explorer` tinyint unsigned NOT NULL DEFAULT '0',
  `max_miners` int DEFAULT NULL,
  `max_shares` int DEFAULT NULL,
  `created` int DEFAULT NULL,
  `action` int DEFAULT NULL,
  `conf_folder` varchar(128) DEFAULT NULL,
  `program` varchar(128) DEFAULT NULL,
  `rpcuser` varchar(128) DEFAULT NULL,
  `rpcpasswd` varchar(128) DEFAULT NULL,
  `serveruser` varchar(45) DEFAULT NULL,
  `rpchost` varchar(128) DEFAULT NULL,
  `rpcport` int DEFAULT NULL,
  `rpccurl` tinyint(1) NOT NULL DEFAULT '0',
  `rpcssl` tinyint(1) NOT NULL DEFAULT '0',
  `rpccert` varchar(255) DEFAULT NULL,
  `rpcencoding` varchar(16) DEFAULT NULL,
  `account` varchar(64) NOT NULL DEFAULT '',
  `hasgetinfo` tinyint unsigned NOT NULL DEFAULT '1',
  `hassubmitblock` tinyint unsigned NOT NULL DEFAULT '1',
  `hasmasternodes` tinyint(1) NOT NULL DEFAULT '0',
  `usememorypool` tinyint(1) DEFAULT NULL,
  `usesegwit` tinyint unsigned NOT NULL DEFAULT '0',
  `txmessage` tinyint(1) DEFAULT NULL,
  `auxpow` tinyint(1) DEFAULT NULL,
  `multialgos` tinyint(1) NOT NULL DEFAULT '0',
  `lastblock` varchar(128) DEFAULT NULL,
  `network_ttf` int DEFAULT NULL,
  `actual_ttf` int DEFAULT NULL,
  `pool_ttf` int DEFAULT NULL,
  `last_network_found` int DEFAULT NULL,
  `installed` tinyint(1) DEFAULT NULL,
  `watch` tinyint(1) NOT NULL DEFAULT '0',
  `link_site` varchar(1024) DEFAULT NULL,
  `link_exchange` varchar(1024) DEFAULT NULL,
  `link_bitcointalk` varchar(1024) DEFAULT NULL,
  `link_github` varchar(1024) DEFAULT NULL,
  `link_explorer` varchar(1024) DEFAULT NULL,
  `specifications` blob,
  `apivisible` tinyint DEFAULT '1',
  `pplns_x` int DEFAULT NULL,
  `pplns_factor` int DEFAULT NULL,
  `hashrate` double(21,3) DEFAULT NULL,
  `link_discord` varchar(64) DEFAULT NULL,
  `link_twitter` varchar(64) DEFAULT NULL,
  `exchange_vol_btc` double DEFAULT NULL,
  `last_btc` double DEFAULT NULL,
  `link_telegram` varchar(64) DEFAULT NULL,
  `last_btc_avg15m` double DEFAULT NULL,
  `hashrate2` double DEFAULT NULL,
  `hashrate3` double DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `auto_ready` (`auto_ready`),
  KEY `enable` (`enable`),
  KEY `algo` (`algo`),
  KEY `symbol` (`symbol`),
  KEY `index_avg` (`index_avg`),
  KEY `created` (`created`),
  KEY `coinsIdxSym` (`symbol`,`symbol2`)
) ENGINE=InnoDB AUTO_INCREMENT=2431 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coins`
--

LOCK TABLES `coins` WRITE;
/*!40000 ALTER TABLE `coins` DISABLE KEYS */;
INSERT INTO `coins` VALUES (2423,'KDA',NULL,'KDA','','blake2s',NULL,'/images/coin-KDA.png','unknown',NULL,'','',NULL,NULL,NULL,1,0,1,NULL,0,NULL,'Could not resolve host: ',0,23.222658,100.93232895921,-100.93232895921,NULL,23.222658000000006,NULL,5,NULL,NULL,1,NULL,1906955,NULL,NULL,NULL,0,0,1,'DPPLNS',1,NULL,0,0,0,0,NULL,NULL,1574978571,NULL,'','','yiimprpc','l9BEwFlKvzpcIDDZ5Na5MA','','',24230,0,0,'','POW','',0,0,0,NULL,0,0,0,0,NULL,NULL,0,NULL,1615481651,0,0,'https://kadena.io','https://www.hotbit.io/exchange?symbol=KDA_BTC','','https://github.com/kadena-io/','https://explorer.chainweb.com','',1,NULL,NULL,0.000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `coins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kdablocks`
--

DROP TABLE IF EXISTS `kdablocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kdablocks` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `coin_id` int DEFAULT NULL,
  `height` int unsigned DEFAULT NULL,
  `confirmations` int DEFAULT NULL,
  `time` int DEFAULT NULL,
  `userid` int DEFAULT NULL,
  `workerid` int DEFAULT NULL,
  `difficulty_user` double DEFAULT NULL,
  `price` double DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `difficulty` double DEFAULT NULL,
  `category` varchar(16) DEFAULT 'new',
  `algo` varchar(16) DEFAULT 'scrypt',
  `blockhash` varchar(128) DEFAULT NULL,
  `txhash` varchar(128) DEFAULT NULL,
  `segwit` tinyint unsigned NOT NULL DEFAULT '0',
  `effort` float DEFAULT NULL,
  `jobid` mediumint DEFAULT NULL,
  `chainid` int DEFAULT NULL,
  `stratum_id` varchar(11) DEFAULT NULL,
  `node_id` varchar(11) DEFAULT NULL,
  `party_pass` varchar(11) DEFAULT NULL,
  `mode` varchar(11) DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `shares` double DEFAULT NULL,
  `rigname` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`time`),
  KEY `algo1` (`algo`),
  KEY `coin` (`coin_id`),
  KEY `category` (`category`),
  KEY `user1` (`userid`),
  KEY `height1` (`height`)
) ENGINE=InnoDB AUTO_INCREMENT=2309945 DEFAULT CHARSET=utf8mb3 COMMENT='Discovered blocks persisted from Litecoin Service';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kdablocks`
--

LOCK TABLES `kdablocks` WRITE;
/*!40000 ALTER TABLE `kdablocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `kdablocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stratums`
--

DROP TABLE IF EXISTS `stratums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stratums` (
  `pid` int NOT NULL,
  `time` int DEFAULT NULL,
  `started` int unsigned DEFAULT NULL,
  `algo` varchar(64) DEFAULT NULL,
  `workers` int unsigned NOT NULL DEFAULT '0',
  `port` int unsigned DEFAULT NULL,
  `symbol` varchar(16) DEFAULT NULL,
  `url` varchar(128) DEFAULT NULL,
  `fds` int unsigned NOT NULL DEFAULT '0',
  `stratum_id` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`pid`),
  KEY `stratumsIdx1` (`algo`,`symbol`),
  KEY `stratumWorkersSym` (`algo`,`symbol`,`workers`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stratums`
--

LOCK TABLES `stratums` WRITE;
/*!40000 ALTER TABLE `stratums` DISABLE KEYS */;
/*!40000 ALTER TABLE `stratums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workers`
--

DROP TABLE IF EXISTS `workers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userid` int DEFAULT NULL,
  `time` int DEFAULT NULL,
  `pid` int DEFAULT NULL,
  `subscribe` tinyint(1) DEFAULT NULL,
  `difficulty` double DEFAULT NULL,
  `ip` varchar(48) DEFAULT NULL,
  `dns` varchar(1024) DEFAULT NULL,
  `name` varchar(128) DEFAULT NULL,
  `nonce1` varchar(64) DEFAULT NULL,
  `version` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `worker` varchar(64) DEFAULT NULL,
  `algo` varchar(16) DEFAULT '',
  `coinid` int DEFAULT NULL,
  `extra` varchar(11) DEFAULT NULL,
  `hashrate` double(18,3) DEFAULT NULL,
  `last_share_time` int DEFAULT NULL,
  `shares_per_min` varchar(7) DEFAULT NULL,
  `uuid` bigint unsigned DEFAULT NULL,
  `mode` varchar(11) DEFAULT NULL,
  `party_pass` varchar(8) DEFAULT NULL,
  `owner_id` int DEFAULT NULL,
  `owner_type` varchar(16) DEFAULT NULL,
  `stratum_id` varchar(64) NOT NULL DEFAULT '',
  `state` varchar(64) NOT NULL DEFAULT '',
  `share_count` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `algo1` (`algo`),
  KEY `name1` (`name`),
  KEY `userid` (`userid`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=156685375 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workers`
--

LOCK TABLES `workers` WRITE;
/*!40000 ALTER TABLE `workers` DISABLE KEYS */;
/*!40000 ALTER TABLE `workers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-09-22 19:42:59
