-- MySQL dump 10.13  Distrib 5.7.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: esms
-- ------------------------------------------------------
-- Server version	5.7.44-log

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
-- Table structure for table `jd_category`
--

DROP TABLE IF EXISTS `jd_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jd_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `turn` int(11) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jd_category`
--

LOCK TABLES `jd_category` WRITE;
/*!40000 ALTER TABLE `jd_category` DISABLE KEYS */;
INSERT INTO `jd_category` VALUES (1,'图书',0,'图书啊',NULL),(2,'小说',1,'小说啊',1),(3,'文学',2,'文学啊',1),(4,'青春文学',3,'青春文学啊',1),(5,'传记',4,'传记啊',1),(6,'中国当代小说',5,'中国当代小说啊',2),(7,'中国古代小说',6,'中国古代小说啊',2),(8,'中国武侠小说',7,'中国武侠小说啊',2),(9,'网络小说',8,'网络小说啊',2),(10,'中国当代文学',9,'中国当代文学啊',3),(11,'中国古代文学',10,'中国古代文学啊',3),(12,'中国武侠文学',11,'中国武侠文学啊',3),(13,'网络文学',12,'网络文学啊',3),(14,'当代青春文学',13,'当代青春文学啊',4),(15,'古代青春文学',14,'古代青春文学啊',4),(16,'校园青春文学',15,'校园文学啊',4);
/*!40000 ALTER TABLE `jd_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jd_category_product`
--

DROP TABLE IF EXISTS `jd_category_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jd_category_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `jd_category_product_category_id_fk` (`category_id`),
  KEY `jd_category_product_product_id_fk` (`product_id`),
  CONSTRAINT `jd_category_product_category_id_fk` FOREIGN KEY (`category_id`) REFERENCES `jd_category` (`category_id`),
  CONSTRAINT `jd_category_product_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `jd_product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jd_category_product`
--

LOCK TABLES `jd_category_product` WRITE;
/*!40000 ALTER TABLE `jd_category_product` DISABLE KEYS */;
INSERT INTO `jd_category_product` VALUES (1,6,1),(2,6,2),(3,6,3),(4,6,4),(5,6,5),(6,7,6),(7,7,7),(8,7,8),(9,7,9),(10,7,10),(11,7,11);
/*!40000 ALTER TABLE `jd_category_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jd_item`
--

DROP TABLE IF EXISTS `jd_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jd_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `product_num` int(11) DEFAULT NULL,
  `product_price` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jd_item`
--

LOCK TABLES `jd_item` WRITE;
/*!40000 ALTER TABLE `jd_item` DISABLE KEYS */;
INSERT INTO `jd_item` VALUES (6,5,2,2,150),(7,5,4,2,30),(8,5,5,2,20),(9,6,4,2,30),(10,6,5,2,20),(11,7,5,1,20),(12,8,1,1,20),(13,8,4,2,30),(14,9,1,1,20),(15,9,2,2,150),(16,10,1,1,20),(17,10,2,1,150),(18,11,1,1,20),(19,12,1,1,20),(20,13,1,1,20),(21,14,1,1,20);
/*!40000 ALTER TABLE `jd_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jd_order`
--

DROP TABLE IF EXISTS `jd_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jd_order` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `order_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `total_price` double DEFAULT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `invoice_id` int(11) DEFAULT NULL,
  `reveive_address_id` int(11) DEFAULT NULL,
  `bak` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jd_order`
--

LOCK TABLES `jd_order` WRITE;
/*!40000 ALTER TABLE `jd_order` DISABLE KEYS */;
INSERT INTO `jd_order` VALUES (5,22,'已取消','2024-05-21 06:41:19',400,1,1,1,'暂无备注'),(6,22,'已取消','2024-05-21 06:41:19',100,1,1,1,'暂无备注'),(7,22,'下单成功','2024-05-21 05:24:11',20,1,1,1,'暂无备注'),(8,22,'下单成功','2024-05-21 05:24:11',80,1,1,1,'暂无备注'),(9,22,'下单成功','2024-05-21 05:24:11',320,1,1,1,'暂无备注'),(10,22,'下单成功','2024-05-21 05:24:11',170,1,1,1,'暂无备注'),(11,22,'下单成功','2024-05-21 05:24:11',20,1,1,1,'暂无备注'),(12,22,'下单成功','2024-05-21 05:24:11',20,1,1,1,'暂无备注'),(13,22,'下单成功','2024-05-21 05:24:11',20,1,1,1,'暂无备注'),(14,22,'支付成功','2024-05-21 05:24:11',20,1,1,1,'暂无备注');
/*!40000 ALTER TABLE `jd_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jd_product`
--

DROP TABLE IF EXISTS `jd_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jd_product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `keywords` varchar(50) DEFAULT NULL,
  `add_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `picture` varchar(50) DEFAULT NULL,
  `big_picture` varchar(50) DEFAULT NULL,
  `fixed_price` int(11) DEFAULT NULL,
  `lower_price` int(11) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `author` varchar(100) DEFAULT NULL,
  `publishing` varchar(100) DEFAULT NULL,
  `publish_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `isbn` varchar(100) DEFAULT NULL,
  `language` varchar(100) DEFAULT NULL,
  `which_edtion` varchar(100) DEFAULT NULL,
  `total_page` varchar(100) DEFAULT NULL,
  `bind_layout` varchar(100) DEFAULT NULL,
  `book_size` varchar(100) DEFAULT NULL,
  `editor_description` varchar(1000) DEFAULT NULL,
  `catalog` varchar(1000) DEFAULT NULL,
  `book_summary` varchar(1000) DEFAULT NULL,
  `author_summary` varchar(1000) DEFAULT NULL,
  `extracts` varchar(1000) DEFAULT NULL,
  `print_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `print_int` int(11) DEFAULT NULL,
  `paper_type` varchar(100) DEFAULT NULL,
  `print_frequency` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jd_product`
--

LOCK TABLES `jd_product` WRITE;
/*!40000 ALTER TABLE `jd_product` DISABLE KEYS */;
INSERT INTO `jd_product` VALUES (1,'让子弹飞','子弹  飞   葛优 姜文 发哥','2024-05-14 02:18:30','img/book01.jpg','img/big/book01.jpg',100,20,'让子弹飞啊','姜文','兄弟连出版社','2024-05-14 02:18:30','ISBN_0001','简体中文','第三版','350页','简装','16K','编辑描述 你猜有没有','第一章之后就没有了','告诉你了就是让子弹飞','不知道是个演员 还是个导演','吃着火锅唱着歌','2024-05-14 02:18:30',5000,'泥皮','第五次加印'),(2,'藏地密码4','藏地 密码 哈哈','2024-05-14 02:18:30','img/book02.jpg','img/big/book02.jpg',120,150,'让藏地来了密码','河马','兄弟连出版社','2024-05-14 02:18:30','ISBN_0102','简体中文','第五版','250页','精装','16K','长篇小说很棒棒','第一章主人公卒','让藏地带一个密码','编剧和作家','遥远的藏地有一个密码叫高伟萎','2024-05-14 02:18:30',2000,'牛皮纸','修正液版'),(3,'藏地密码5','藏地 密码 哈哈','2024-05-14 02:18:30','img/book03.jpg','img/big/book03.jpg',120,50,'让藏地来了密码','河马','兄弟连出版社','2024-05-14 02:18:30','ISBN_0102','简体中文','第五版','250页','精装','16K','长篇小说很棒棒','第一章主人公卒','让藏地带一个密码','编剧和作家','遥远的藏地有一个密码叫高伟萎','2024-05-14 02:18:30',2000,'牛皮纸','修正液版'),(4,'藏地密码6','藏地 啊藏地','2024-05-14 02:18:30','img/book04.jpg','img/big/book04.jpg',88,30,'藏地密码密码','西藏人民','中国出版社','2024-05-14 02:18:30','ISBN_0004','繁体中文','第四版','180页','精装','20k','编辑描述 你猜有没有','第一章之后就没有了','告诉你了就是藏地密码','不知道是不是一个人','哈哈哈哈哈 ','2024-05-14 02:18:30',4800,'牛皮','第四次加印'),(5,'黑道飞云20年','古惑仔 山鸡 陈浩南','2024-05-14 02:18:30','img/book05.jpg','img/big/book05.jpg',100,20,'黑道飞云20年啊','山鸡','人民出版社','2024-05-14 02:18:30','ISBN_0005','简体中文','第三版','500页','精装','16k','编辑描述 你猜有没有','第一章之后就没有了','告诉你了就是黑道飞云20年','是个古惑仔','指导我大哥是谁吗','2024-05-14 02:18:30',5000,'金皮','第六次加印'),(6,'风雨哈佛路','风雨 哈佛 路','2024-05-14 02:18:30','img/book06.jpg','img/big/book06.jpg',100,99,'风雨哈佛路','外国人','总监出版社','2024-05-14 02:18:30','ISBN_0002','简体中文','第二版','350页','精装','16k','编辑描述','第一章','风雨哈佛路','外国妞','吃着火锅唱着歌','2024-05-14 02:18:30',5000,'牛皮纸','第二次加印'),(7,'奈良美智','奈良 美 智','2024-05-14 02:18:30','img/book07.jpg','img/big/book07.jpg',100,99,'奈良美智','日本人','总监出版社','2024-05-14 02:18:30','ISBN_0003','简体中文','第二版','350页','精装','16k','编辑描述','第一章','奈良美智','日本r','吃着火锅唱着歌','2024-05-14 02:18:30',5000,'牛皮纸','第二次加印'),(8,'说服力','ppt 说 说服力 会说话','2024-05-14 02:18:30','img/book08.jpg','img/big/book08.jpg',100,20,'说服力 让你的PPT会说话','张志 刘俊 包翔','人民邮电出版社','2024-05-14 02:18:30','ISBN_0008','简体中文','第一版','520页','精装','16K','编辑描述 让你的PPT会说话','第一章说服力了','说服力 ...省略一万字','不知道是一个人写到还是三个人写的..','让你的PPT会说话','2024-05-14 02:18:30',10000,'宣纸','第一次精印'),(9,'再见出租屋','再见 出租屋 屋','2024-05-14 02:18:30','img/book09.jpg','img/big/book09.jpg',100,20,'再见出租屋','李冰','生活?读书?新知三联书店','2024-05-14 02:18:30','ISBN_0009','简体中文','第五版','400页','精装','16K','编辑描述 这是一本好书','第一章我的北漂生活','北漂生活 ...省略一万字','不知道这是谁..','再见出租屋','2024-05-14 02:18:30',2500,'竹纸','第六次印'),(10,'将才','将 大将 人才','2024-05-14 02:18:30','img/book10.jpg','img/big/book10.jpg',100,20,'人才指南','将才作者本人','兄弟连出版社','2024-05-14 02:18:30','ISBN_0010','简体中文','第一版','350页','简装','16K','成为将才，必先掌握一技之长','总共36章','人才成长必备','著名作家','不想成为将军的士兵不是好士兵','2024-05-14 02:18:30',5000,'牛皮','第三次第一次印刷'),(11,'怪诞行为学','怪诞 行为 心理学 行为学','2024-05-14 02:18:30','img/book11.jpg','img/big/book11.jpg',100,20,'这是一本关于行为和心理方面的著作','高伟伟','兄弟连出版社','2024-05-14 02:18:30','ISBN_0011','简体中文','第三版','350页','简装','16K','行为理性息息相关','总共31章','要想学习心理学，必先读此书','马太效应 从众心理','停车做爱枫林晚，桑叶红于二月花','2024-05-14 02:18:30',5000,'特级纸','第五次加印');
/*!40000 ALTER TABLE `jd_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jd_receive_address`
--

DROP TABLE IF EXISTS `jd_receive_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jd_receive_address` (
  `reveive_address_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `receive_name` varchar(50) DEFAULT NULL,
  `province` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `zipcode` varchar(50) DEFAULT NULL,
  `mobile` varchar(50) DEFAULT NULL,
  `telephone` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `area` varchar(50) DEFAULT NULL,
  `is_default` int(11) DEFAULT NULL,
  PRIMARY KEY (`reveive_address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jd_receive_address`
--

LOCK TABLES `jd_receive_address` WRITE;
/*!40000 ALTER TABLE `jd_receive_address` DISABLE KEYS */;
INSERT INTO `jd_receive_address` VALUES (1,22,'王天辰','黑龙江','学府三道街28号','123456','18771275210','18771275210','1440057838@qq.com','东北',1);
/*!40000 ALTER TABLE `jd_receive_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jd_user`
--

DROP TABLE IF EXISTS `jd_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jd_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `login_name` varchar(64) DEFAULT NULL,
  `nick_name` varchar(64) DEFAULT NULL,
  `real_name` varchar(64) DEFAULT NULL,
  `grade_id` int(11) DEFAULT NULL,
  `Password` varchar(100) NOT NULL,
  `Email` varchar(200) DEFAULT NULL,
  `Province` varchar(100) DEFAULT NULL,
  `recommender` varchar(100) DEFAULT NULL,
  `Sex` varchar(64) DEFAULT NULL,
  `Birth` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Location` varchar(100) DEFAULT NULL,
  `School` varchar(200) DEFAULT NULL,
  `Company` varchar(200) DEFAULT NULL,
  `card_INT` varchar(64) DEFAULT NULL,
  `Mobile` varchar(64) DEFAULT NULL,
  `Phone` varchar(64) DEFAULT NULL,
  `msn` varchar(64) DEFAULT NULL,
  `Qq` varchar(64) DEFAULT NULL,
  `Website` varchar(64) DEFAULT NULL,
  `send_address` varchar(100) DEFAULT NULL,
  `Zipcode` varchar(32) DEFAULT NULL,
  `Hobby` varchar(64) DEFAULT NULL,
  `verify_flag` varchar(64) DEFAULT NULL,
  `verify_code` varchar(64) DEFAULT NULL,
  `last_login_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_login_ip` varchar(64) DEFAULT NULL,
  `Area` varchar(100) DEFAULT NULL,
  `head_pic` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `jd_user_login_name_uk` (`login_name`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jd_user`
--

LOCK TABLES `jd_user` WRITE;
/*!40000 ALTER TABLE `jd_user` DISABLE KEYS */;
INSERT INTO `jd_user` VALUES (21,'wtc3',NULL,NULL,NULL,'2a2bbd6eac5004509b4704102d204978','1440057838@qq.com',NULL,'wtc',NULL,'2024-05-14 01:39:09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-05-14 01:39:09',NULL,NULL,NULL),(22,'wtc',NULL,NULL,NULL,'272ab962a1560d51904e0c1f2225417a','1440057838@qq.com',NULL,'wtc3',NULL,'2024-05-15 19:03:51',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-05-15 19:03:51',NULL,NULL,NULL);
/*!40000 ALTER TABLE `jd_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-21 15:03:38
