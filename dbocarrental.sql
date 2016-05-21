-- MySQL dump 10.13  Distrib 5.6.30, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: dbocarrental
-- ------------------------------------------------------
-- Server version	5.6.30-0ubuntu0.15.10.1

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
-- Table structure for table `acl_class`
--

DROP TABLE IF EXISTS `acl_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_class` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_acl_class` (`class`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_class`
--

LOCK TABLES `acl_class` WRITE;
/*!40000 ALTER TABLE `acl_class` DISABLE KEYS */;
INSERT INTO `acl_class` VALUES (1,'com.crms.entity.Car');
/*!40000 ALTER TABLE `acl_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_entry`
--

DROP TABLE IF EXISTS `acl_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_entry` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `acl_object_identity` bigint(20) unsigned NOT NULL,
  `ace_order` int(11) NOT NULL,
  `sid` bigint(20) unsigned NOT NULL,
  `mask` int(10) unsigned NOT NULL,
  `granting` tinyint(1) NOT NULL,
  `audit_success` tinyint(1) NOT NULL,
  `audit_failure` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_acl_entry` (`acl_object_identity`,`ace_order`),
  KEY `fk_acl_entry_acl` (`sid`),
  CONSTRAINT `fk_acl_entry_acl` FOREIGN KEY (`sid`) REFERENCES `acl_sid` (`id`),
  CONSTRAINT `fk_acl_entry_object` FOREIGN KEY (`acl_object_identity`) REFERENCES `acl_object_identity` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_entry`
--

LOCK TABLES `acl_entry` WRITE;
/*!40000 ALTER TABLE `acl_entry` DISABLE KEYS */;
INSERT INTO `acl_entry` VALUES (1,1,1,1,1,1,1,1),(2,1,2,1,2,1,1,1);
/*!40000 ALTER TABLE `acl_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_object_identity`
--

DROP TABLE IF EXISTS `acl_object_identity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_object_identity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_id_class` bigint(20) unsigned NOT NULL,
  `object_id_identity` bigint(20) NOT NULL,
  `parent_object` bigint(20) unsigned DEFAULT NULL,
  `owner_sid` bigint(20) unsigned DEFAULT NULL,
  `entries_inheriting` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_acl_object_identity` (`object_id_class`,`object_id_identity`),
  KEY `fk_acl_object_identity_parent` (`parent_object`),
  KEY `fk_acl_object_identity_owner` (`owner_sid`),
  CONSTRAINT `fk_acl_object_identity_class` FOREIGN KEY (`object_id_class`) REFERENCES `acl_class` (`id`),
  CONSTRAINT `fk_acl_object_identity_owner` FOREIGN KEY (`owner_sid`) REFERENCES `acl_sid` (`id`),
  CONSTRAINT `fk_acl_object_identity_parent` FOREIGN KEY (`parent_object`) REFERENCES `acl_object_identity` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_object_identity`
--

LOCK TABLES `acl_object_identity` WRITE;
/*!40000 ALTER TABLE `acl_object_identity` DISABLE KEYS */;
INSERT INTO `acl_object_identity` VALUES (1,1,31,NULL,1,0);
/*!40000 ALTER TABLE `acl_object_identity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_sid`
--

DROP TABLE IF EXISTS `acl_sid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_sid` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `principal` tinyint(1) NOT NULL,
  `sid` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_acl_sid` (`sid`,`principal`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_sid`
--

LOCK TABLES `acl_sid` WRITE;
/*!40000 ALTER TABLE `acl_sid` DISABLE KEYS */;
INSERT INTO `acl_sid` VALUES (1,1,'admin');
/*!40000 ALTER TABLE `acl_sid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_authorities`
--

DROP TABLE IF EXISTS `group_authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_authorities` (
  `group_id` bigint(20) unsigned NOT NULL,
  `authority` varchar(50) NOT NULL,
  KEY `group_id` (`group_id`),
  CONSTRAINT `group_authorities_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_authorities`
--

LOCK TABLES `group_authorities` WRITE;
/*!40000 ALTER TABLE `group_authorities` DISABLE KEYS */;
INSERT INTO `group_authorities` VALUES (1,'ROLE_USER'),(1,'ROLE_ADMIN'),(7,'ROLE_EMPLOYEE'),(8,'ROLE_ADMIN'),(8,'ROLE_STUDENT');
/*!40000 ALTER TABLE `group_authorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_members`
--

DROP TABLE IF EXISTS `group_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_members` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `group_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `username_idx` (`username`),
  CONSTRAINT `group_members_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`),
  CONSTRAINT `username` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_members`
--

LOCK TABLES `group_members` WRITE;
/*!40000 ALTER TABLE `group_members` DISABLE KEYS */;
INSERT INTO `group_members` VALUES (1,'admin',1),(2,'kujta',7),(3,'kujta',7),(4,'kujta',7),(5,'kujta',7),(6,'kujta',7),(7,'kujta',7),(8,'kujta',7),(9,'kujta',7),(10,'kujta',7),(11,'kujta',7),(12,'kujta',7),(13,'kujta',7),(14,'kujta',7),(15,'kujta',7),(16,'kujta',7),(17,'kujta',7),(18,'kujta',7),(19,'kujta',7),(20,'kujta',7),(21,'kujta',7),(22,'kujta',7),(23,'kujta',7),(24,'kujta',7),(25,'kujta',7),(26,'kujta',7),(27,'kujta',7),(28,'kujta',7),(29,'kujta',7),(30,'kujta',7),(31,'kujta',7),(32,'kujta',7),(33,'kujta',7),(34,'kujta',7),(35,'kujta',7),(36,'kujta',7),(37,'kujta',7),(38,'kujta',7),(39,'kujta',7),(40,'kujta',7),(41,'kujta',7),(42,'kujta',7),(43,'kujta',7),(44,'kujta',7),(45,'kujta',7),(46,'kujta',7),(47,'kujta',7),(48,'kujta',7),(49,'kujta',7),(50,'kujta',7),(51,'kujta',7),(52,'kujta',7),(53,'kujta',7),(54,'kujta',7),(55,'kujta',7),(56,'kujta',7),(57,'kujta',7),(58,'kujta',7),(59,'kujta',7),(60,'kujta',7),(61,'kujta',7),(62,'kujta',7),(63,'qendrimi1',7),(64,'qendrimi1',1),(65,'kujta',7),(66,'kujta',7),(67,'kujta',7),(68,'kujta',7),(69,'kujta',7),(70,'kujta',7),(71,'kujta',7),(72,'kujta',7),(73,'kujta',7),(74,'kujta',7),(75,'kujta',7),(76,'kujta',7),(77,'kujta',7),(78,'kujta',7);
/*!40000 ALTER TABLE `group_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `group_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,'Admins'),(7,'Employee'),(8,'Students');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcar`
--

DROP TABLE IF EXISTS `tblcar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblcar` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Regjistration_Number` varchar(30) DEFAULT NULL,
  `Color` varchar(30) DEFAULT NULL,
  `Date_of_Manufacturing` date DEFAULT NULL,
  `Base_Price_Per_Day` float DEFAULT NULL,
  `Car_type_ID` int(11) NOT NULL,
  `image` blob,
  `image_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_tblcar_tblcar_type1_idx` (`Car_type_ID`),
  CONSTRAINT `fk_tblcar_tblcar_type1` FOREIGN KEY (`Car_type_ID`) REFERENCES `tblcar_type` (`Car_type_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcar`
--

LOCK TABLES `tblcar` WRITE;
/*!40000 ALTER TABLE `tblcar` DISABLE KEYS */;
INSERT INTO `tblcar` VALUES (32,'01-872-KM','Blue','2009-01-12',56,176,'ÿØÿà\0JFIF\0\0–\0–\0\0ÿÛ\0C\0	\Z!\Z\"$\"$ÿÛ\0CÿÂ\0\0´>\"\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0\0ÿÚ\0\0\0\0í?nä†wugrwqÜ$2\'\Z‚‰ÁDà9)E\Z€(#@£@9)EÉÌ·4È¹:‹“‚î@£t\'ÉÁru5\0äà#@£J((Ð(”\n$¢‰‰î•ÔdÚò.‹žû·æuµ#çðÎñ¹m™o¼òo5^ËÅgFr	]‰NÄ*FwC\'C\'J(”\n$ºVN\Zk´8v¹-b[%\\Òä´&/^à­YèRy§HuãC®+gMÎ3ë±q±îv›žgoYô’ãKyè®r79o«nxñ½æÌ˜¸Ð\nN±åÆ´—%|ÞYÎ_\\ôòí>Ek<^=8¦•¼¢”s´òu‹S×ÏÍ’k=w£†WI›ìójÑ­±4yÖ±±„\"ÎŸrŸYìóC¥düž’Çëè¥N3Ð¯c~I-ÎSÅëÔ§Z$ÒŸæµ\"­wÌ@]¸ÉvœœúÐºñô\'êOÅëâG´§ßž&wU‰®tÚ‹ý¯ÔUÂ—¿=X²Ö±¢t¨¨rëÐVm»·Ò©&ùØÒÇ›ÅëÞ³ËéfÕê0,çt<Úi1jXë·¼žŸ)Ê/§˜¡Îxz1³–ƒ¯mg‘ƒ°ƒNº~¹õÁ-ÔrÞoéžyèéum}¿B^š.S˜]T–pš,~_«^³ÜóûïtœgE×Ëtv×¿âáœ‡¼U··“Ã¹É•‘ô<Ú³°Òóúxß{C‰æü¾P‹ ŸÃîäcìA9ì\\ãŸ¬l.0=~^í¸b«|=ºßoâ/N0¼æV+ªG<ë<lÃÛÍ=q——¡tü¼œ{ô<„”|žª}U¹«\r+{|‘;´­ð¦lÌúƒ±Êîg¦ü|v‘°ôo†\\¥{dý9æÚ9íîño.pî:Œ}9ë>`Ë³\Z³WÃ1æõBµ¾Þv€©R>‡â}ŒÛsM×›‡F>¾ì÷ryïO#/6ßQÃöÞ?NÕ˜gíŒ½ÜúB9Z‘‡<oƒ@–d¢$çŸ1Éá÷Ü_-Õ’âéE:ŒÕÂæÐÕfýÜ\"7!ËY³Öñ]WÖ9Þ³Sº»¹¼uÎÎ]9 ê±u3:\ZÖ,¶yRS¥t®Vd³;¦¨¦Q\rÍˆ©5=Ã9Úý<ró1ô’æò±ö“GýìKÃ.ôŽ½£~öJàìu’%OJ¦VdQÔˆÏ±\n6dKHà•FTÖMœõ¡$’U/ØI%)[U ¬$’Ä@”¤éÙ!!ï$Ae$ª—–žGA”‘vtª¼É$Œ-dÿÄ\0*\0\0\0\0\0\0!\"1#B3@ 0pÿÚ\0\0ÿ\0ä×S’½LÔÔë:ÔÍå©©¯û(>èä³«æ^SÊâŸË/[,¶Ù]ùxíÈÒñ\Z›ŽxçH^¡<©Ë\r¬`±à°N»LÔ×ý=j)1Oãïba©šªòU×?#C ÙÕ–äÕZòÏ•(ÊÏC…•ÛåxþÃ–¡/;‹t7Ó%»¥Õ0\0ÒtgY©¯ý.ÔÏ%q~á%b°Ð°NÉeæßF_Ê 8üÞj³ê¸­nÓ/Én?¾EÞ¾mheáá·2œÎ>«’©¡ËX¹ÕDÈ©¡\"-½Ú¶³eH¯Èa-3‡äÅÏ[é¯ùÎq¸™\\Ÿ–,ä¸Úí~{ŠW¯˜ãlQÊñ…Wžáúÿ\0\'•cæ[QËË·\"›»UQ¹Œò~žëªv,Ý˜Ì.6Û\"lQnGbl|ìÏáxÍ0±õ>ñé¢Êýjt(J²\rÂòtä-øÙöU.ä¬±¬Ë¶5½œZš\\ÆSì³Eñoïr¶Ñ¬¦Ùû‰ƒÈ˜pÐÄp©lÉÆ·Äi°*c_b\0Kcb_u¸ôca­¹iò\r½Êe©Ú:×Ûq­T~31õ¯‹¨e_X_¬Ê\r•qî»ñë¾¾c¶‡T$ÿ\0_Íý$}Yè§ìzõPã_†»pd¸[mÈx­|ešhEmRÓƒÇ	ÛJÊñí<|tðq“×ã#QÆ<ÜqžŽ%–?‹©M4õ^<øÛ2–||v[¨ëúù€ls9˜õNŒŒ[*«Ê÷ñ–°øËDøÛš|uê&RAc§Ç8d–!lT0ãsÏzÈÙw˜ÏsÞr9×g•ÌòY;Ù°¯½“³ÊÅÖKVÜk\\ÇÎF•Ú`\'n7r¦E`öh¯vìý3hZò¬ã¹S\'øõ	-ã{K|õXXÎÉ§A:4ëdétd³^)]VOO\\ècLªÆ2äæùrQ÷‘eV«zYšôsÉõ36qò‚X\\Jh·\n-6ã®ø,Z|Í]&Ãl8·kÃn½[ÊÓƒ›\\õùX•r¢8äÂ¦C[E•ãªçaJlªÉ’ÿ\0½œ}àXgÇ<n2Ó>2éñ·Ï¾|vHŸ‘ùÜÜç+ž;µ§ä°©”YMBŸV»ßÞÓŽW#í´âfGÄÈŸh^C6E]«U©khÕr¤«\'eóU)<õúùÌÈ9œý|Ï!>o™…Ù¼©ÅZs0oÆ»Ï³;ÎÓ´Ü-	3¬:Ã©ÌÝ©æ±/9–ç;óÏ8žÀƒ$Aœ°f#FrÍ¸‡ªªjîJå÷7Ay·)»_ƒvšPk_‹GjÅeÙòrx+Ûâ+ÍÝžA¶ÈUžêv9M¿-†²\'•aÉÔ;“2¨¼ÞÞz•o²yÌÎ“Í\\ÓÐÐ¢ÃSã°chÛº±nð_U¡.ÍÈ.3ìñaÕ[]ÇàØpˆÖ¦„³êTì¼RÞN8À´*­Ú»‡ô½Ì5ýª\"ªÅ¯EÐ›a2\r­]ogJ.¶z=K\'©dõmž­³Ö¶#Š%™v‚rî1rNÜ÷ÏnÙ}ZÊ…Ý“ôO(†ß¥ò´\\lÇ‰Æò&dm&Ý.§k“‡S®![Ôæ°)U…é-7Äc:í;¼f:¶®¹]Í\0æä‚¹¹ûyfdO~ùòŽ§Ü®õ³²Ï!»ŒwÝ[†mB^û˜>=¯v£R‘›ÄSÇ®Yü–Ùoòæ–òyVË.±¥mÕ˜×=LTv)É¢Š×ÅþzÙ2Á±2rÚ¬fÓ°Ó£˜µ×/=Ø®2\'\'ETXZZyL[Ž÷£ÛSÜ·¯¹töœÊ2\nOigµTÈ½\Zš¥•ÜüŽO\Z÷£¾E¦Ï1qØÅÂc‡µ8˜”¹§\ZºÕDú*ÕñÓgJ7q\0YÉ;=Õ¨öRy^5­>©%ïMµ_ŠÕÂ:´¦Ïó¼6Ù6Ð™ØÍ™÷5ùá\'#d.!1p„\\Ti:é]ëEö—Ýâñä´ñÙ¯-<kåí´z(-2a*Fì¢~æk¬¶Ú¡}Æ\\††›§­<\n!¥§Š\nÚxxõÌðë<õ¬ž…æ+(Ê¸›ûcáW@cZÁfàöIñÝ/ª”4Ñúæ©ŽšÇÿ\0U£T	Ó£®Rˆ¿¼	X°4ínØZHÃ±™h­§pÕX;]•Ù1† Ãª5*£Á 3Õ]úè!­bx;w›‰ðX@¡gEX7³ršU‹•6e?l”:VcÙ­E± ¬lª·†‹+4åº\Z[MK?å©\0‚ÖyY§ôõÑ\\Pþžý!QÚ5¹ýFs,Ü5¬OªûLoÚ¥ký®?u¨kÑ?áO«\\õ®¦kHP¨Zëû²ZtïMn,N“\ZÆ\'ÿÄ\0.\0\0\0\0\0\0\0\0!1\"AQ02@B #¡qÁÑÿÚ\0?+ìë÷×*+•QEW-¯cm‹EQ¤ÒQ\\è¢Š(¢†¨¾]KO¹¥1¸®ìÝ‡ ó@Ý½ØR‰E>Tù×/7¡ª]™.ýä‰åPè<“¢$dÉ­è‰ZUDDg(‹&®Ã“5²*×(½<šŸ¹´ýÎ\"[õ÷\'â9gè,“‘¿3w/s\ZÏ?¥!ž+ÎšD:*7\"jD2ÅºL„áùkØ¯eý_âR^‡—ØÝ7ñÜaµu<J|;É|4z\n8G\'‡dðõƒùþ£õ„šRéþ?Åx|¸öøsA«©Q®¦¨/Q<k°¦Œ3”{>†¦Y©š™¼oÜ¥‘ÌîR4£DŸaà™Ž4ˆä¤`‚—™œDUZ+•Ñ‰T­šÙ­šß<ŠO§ú\r$®¡ao²•Ô¢KC_Göÿ\0èÕtåéŠGI\n(Ú¿CáþJ4GØQK±,q—tlcöŽ]h\\4¾TŸrÒ5_È²ÍF£Qf¢þbû/ÿÄ\0/\0\0\0\0\0\0\0\01!AQ2\"0@a¡ #BRÁáðÿÚ\0?¾Ö_äl¾öYe–Y}¬²Ë,²Ë7~E’,s¡dL²Ë,ÔYe–Ye–YeŠWÉK·ƒÊàÖÐ”åÂ6r{ø¦ÆAôù#„‘gƒÁk½ö¸üšcÊê(Å˜ð¹ùö#‹8C‘)ŽF,z#¹!ËSÕ#Á,q‘,zyPáø}¤¯¶¬>ç©‡µ>/S–¸1ý›Ší&Ä\rœ\\X!õö[û”ÉùìlÈÛ‘<3«’2cÈ’Òé.S7\"ù°¦½§û\Z›þ¤-_ó6±I—ëÇÁÑÇ&šÊÇ,Â–c¬‡Rò/ƒÑõOØéú,°ž¼†³K¢å~\r9>\nÈù9F,r«^M¸üq6Ñµƒ`ØýL\n0Æ¢p[53R÷H’vJÎ§#ÜGK7tûÕ™]Íš¡\Z¡wÇ(Õÿ\0‘u1~,Üh®XÞ¥i‰¿îý¿Ðù,œµÉÈémÊÇ6<õîz”/À’®\rrù›äŽYCég¨Éò.§,UYêæÕ¶¾“K|Š”%ütQ¤Ðh4\ZM”Wá¿È£ÿÄ\0B\0\0\0\0\0\0!1\"2AQq‘3a#Br’¡4Rbá ‚±Ñ$0@Cƒ“¢PpsÁðÿÚ\0\0?ÿ\0´F w–ÿ\0úEŒ½UqFç#Þhíô**0ò•ƒCÚÞâÅYö»eÉ¡®ÅKÌâQX`w–JiÕc¹Û­©ä¬ÒUÚV«ª»Zµ›\nGøkÛšŽÜ¹)Þ®UàóX…Š–W#ÕAwª’ì\\û1<€°hÝå/Í›V¦–ðÜ<Ó]¤>˜vR\rŠs~ÐÐZa\Zn.d{Ù·è£éZÐVþ‹Qƒš¾©óVp*ÄïãVpŽ+zÈwÂ•UœvwmÁ‡‚Õ7Êó[„ç%\0üÁOtèã’†éti³{N´¢êšu¿Z£èÍs¨þq2ƒkâàÚ–SÝT\'ÿ\0*h4\'ZåwÑõøâ*Ô]ó)ÂáÍËhu[Mê³UðxJÌtZÁ²±TÕV3¤3)‰º\rÖƒ|C%¤UÀ\"Œäí¥í4*ÌËzî*=åÃ<-˜C¹ÒYˆû®±]ÛôÊ!ÜÖ´raD\"#ˆNwÛ)ê·ä±}°rÂeúŽá’-ip\nYWWó‡3ˆ9¡{è]	2T6È“rw«fl…J±Iž{ÔRÄ]øŠ˜\'™[-[\rR]‘½bvÉ`¢ÙòB®dï}Ê½tF•FËsi›Çè¢i‚¥ÂÄq‡ÆÉáäw¬!Ç\n#rŽð‘æ±%™F#áaÄp®ð«vÏÓ·Úhå­;Ì\"ÜBV®\'ßð¨Âð9)ÈˆÉ9Žƒ‘„^a™P.»°È?Én©SŽà³RVôG`\'’¬Ûó]ãóÜ²B¡»Ÿw‡Ü­qñoì–‰{5›çä¢fÒ9#N«q5H¼ì»ñ~¿Íg\n0“û’»¼·¢\nŽ*êÃ·ÂkyJÂ)Ÿ@P–ºC	[/ùJ{E:“Õ(»M§\\5Kmu„÷¤’I$5_N2r¤â»ºzUV·ÊºûÞ‘þÊûÖ‘þÒûÎ“þÚûÎ‘ò+éu¾E÷ßøþ‹Ò‡âÄ‹UÞ¡IâVK	N ïDpxÖg0™U».“š2\ZíøN^Á¢\Z}ýJ®Áøgy;“±<;\rNéòÞ‡Ô&R}8¨û6öžCcÕlaCJ€ÑÏ41°Oª¸#øVVó\nrô^òÿ\0+ªÊŸUgáøT;I¬}TwÏO¡0\ZëÙm-¥¶˜{ÓÄê­¢¶”0$1Å’¹ˆJ½3;î²r–º{DîÞÝIøÊîié¤{¡ëÆ¨ƒQÄ€FCz4»òÙ ]9­¯T`;ïÿ\0µÞ»M§]¶!Àè¿µ\Zµ Û^ö5 ðz4êÒ‚<ÕÛP+Ôpæ«jíVªÞªÕ>«2µ+axEáÿ\0%²Ãj2qbÉ8Õ¥MÜ.A@HîÉŒä…\rpè›­G^ÃY@v$xz(/¡o4]Ž€N|1-ïÅ{V‚xý  )¹¢L@*d#V·‡Š!´ãÞ‰_|ô×ßò¯½WùGõ_vY`Mî?h3\0ãMZ½éú+ýõGû6ŽyTGí_³j½ÛEôêˆ+ý¥QTåCªšKW²®Çò|¬Y«2þìäâ·u^ïU»è½Þ{ŸE²Õê¶Z}{/ÚÖ\ZŽ§µÒÝ>mWÄøü©®s	1pŽr.ô×z¤ª±š—7:‡5Ëö`ûÉNÀÒ+Ymèß\'èš{Úr.¼j*¾”m|Ç!çÖPppƒ¿¶j8æ±ŠŒîÃeî•\Z->ó‰u•´z^²¼:*ÎþâÓùÛ¤ÓNmVè¢Ù÷@¨hñ:FÈ©Šl©éƒJuGffU:Íˆ{C—º½Õw7¢ýõ½{Ëñ,›Ù¶:¬ ¬a¸­aÁ™Ñm?¢ñÑx§¢ñ~‹ÄY¢{ï$8’…6™ÄrLÑ©8½±w>^H½âÜ×ˆX<”÷†¥#b¤e»÷ž1†Ùl‰V¹\">ª„;!k±Óáˆú¬©WpIòPÔÔtz¯Uâ¼ú¨Çê-¾%lÖ?Ã	ÎîêA<UÃ€^éæÕ±OåW¥K¢ð)¯½UèÉZ‹§šðR­L…,îÙwL¦ÔÃ0›V}Äƒ)˜21žvDÔ$ž$îLœÛ«û™¬û*1ÆD§Ñ¤Ì$˜?ÑS‡Zöõ]ÝW;‘Ñë¼‘îZ”‡5´žò«Å]’2ðåY”Ï¤«7£aY‡ªp`\0áÍ+T«ÜjÎaX¶<×»ÕfÞ«wU³õ[*-y›\0O%°TÔi~ànæÙk›‡LsL¤ÍíoÌS§ñ•f»¢ðÜ­AÅjèŽèTý™ÿ\0*ö›³²/ÎsNeFëS7åÄuÉRl`xßpÅd×a4\\8„×9âU–²µ¦WéÛs\n«1¹€:Ð,BÆÊÁÎÝl•ªçˆ(ÆAàVßÑf>UîôZÁ½\n‡²Åe‹’ðÞˆ,pæ„î·l¡ÅÅ\ZY´¼ºf\'š-«4œ]8#rŠ³‡˜æ½¿âl¯g¢G@½›)7©V­‡áhÚiO7¢ì¥wÌyuZÃ‡ÃÏ5´WŸ„ä¦HqÞÕb×Ž…at°ð+4áÞ-ZQÍK‹\Zµ´Ž‹7Íw[xîjîËižk!,~c‚Õ¥gÙÅk<‘6â¯SÜB\rË‰GRdÊÙ+DCršîUm\Z¬_g€à›B³ZêX{Ì/ƒ—Á]Ç·%tgd#‰¶SH7Ñm·ª1D69åNßU¬ñ>AKKÚy¡8]ð«ÔcV¬»ÑjÒêµª5’¬×ç›¬ÄêsÀ\'SÁ‰§Ñj¹¯Kd¬•„•³Ù™þàTuPÊ€aƒ“‡õUÙJ¯}_Hv»‡ºßÃÙu’ÙR7½¾IÆ	;°µjèØ¤Ì¸ÂœT©ò•í*>gøŠ\04[É\\ºê]ªµ[Íl™^àä«J‚/uªRO5¨Ç¸pc!Z–‰Êïhä³Ü}V«d«Ùd¬:,–K%’Ë²båªÁÆÒ®ù;åF.‹RCôV¦ÆsºöšQoÀ!\0àúŽà^»Ç´bu›d)»ÕÖ|”ä¬@þJÓ>K´7òÝO=Ç5 «ˆä‰c”UËá\nkO!ýT1­o¢¾ås«PJÿ\0â²1ÑkäÕžjz¨Â¯%ù\"\0Q2|‚Ôeüì†2Pš˜8ÂÖÖGú\"½{1ïž*3„\Z ÞÊKÍlÇ5­xWÍHßËz-¬ÙRÒ\'°EaB\'\\ÙJvMÃÁÁC¥ÜÊaä‹Q€ŒÊìÌö›­ùNh´eÍ9Ê|ã³õš×òS¿\n•èYÇ%ª!;(ÏÍæ®2„\\é@ÙÿÄ\0)\0\0\0\0\0\0!1QAaq‘¡±ÁÑáðñ0 @ÿÚ\0\0?!úÔ©R¥J•*T©R¾µ*T©R¿ú©_J•*T©_Z•õ©R¥J•õ¯¥}*T©R¥J•*T¯¥J•*T©R¥Jú’¥J•*T©R¾•*T©R¥J•*T©R¥}+éR¥åR¥}*T©R¥J•*T©R¥}*T©R¥J•ô©R¥ã¦:$íKñÄâb]%ø•*T©RÒÒÒ¥J•*T¯ÿ\0Œ¸\\R*‘„[x¸Šð–‡âf<=x²Ìâˆþõ0°³‰ý˜Mu^^|Ê\0ž¹i‰xÏÑ‹Ÿº±.ãxÌcå\\µ‘Ò÷™ .Dí^[‰R¥J•+ÿ\0Q^¨½A\"ºÛÍjæ\\WF\Z©µAšWÙ6Ê}à+ä«‚R\\üJ¤º¯¼Ïà™T­Hc¼>bèÎåó–­cÈh-7µ¸§y†ÎßôÎ©—f£ìöL™å\0Û†‹®jv‡:ƒêžÚ¯™™çµìÓ_Æm/-/-*WÒ¿ù ªêî(·øM€¯By´è™V§H¡ô—¥Ùçs*ºÇMikWS™Rè&„gŸª¦\r`ô>ì·ˆiË^ºÆagJƒµ±—zRk§Jƒ©á¢sJ«YªØæ\r9¦{ùú\n™ûYûFQ—Æ3EPZ^%ðUßR¼C|‹Mf®k½ˆî¤ÃXŽÞ3	ÕÌ2-ƒp/9ÔÁÅå¿\\f;Z©Pu5Ú:)ÙŸÜÄÍ¢öÃæÚZâ@­pžöÜ@¡mi¼•¡“\n›Ø0eBv%±eÖg\'³Äå!•EãYÔ ¨:A“-ÖõÞX6¨#&¬d»ëkþ§u©~%÷”Góî_ðbJ~á*iË¹‚†\\F¤í–Ký=¿ig¡Êdê>å™[2à£ÚuX}1*W4ßïdYÌE¯Ù~ð«£¼ïØV½EA¼—38ï¸ Â6)sÌ«jâæœ(ÆÓÞºÕÊ–Qëë÷>áò_¤e€¥\\^÷‰ÎãÜ^æ$N\n¥Þï/˜[îZêæàÅvƒmÉÁ[”Ý¢”‹˜í¾ÄC¼.åQ¹M¶b#«ˆæ½\"³G,MuµvýA&Û!éÞr¬…sÛõîbw™yÉí=™ôÌ˜÷GÝìcâ4yZ€U3ÜyŒ­øqâñþÙ†E­jkD^Þ±QoÓQÉ‡x‚ŽÎbÕYWRx%„‚òˆ²£u»™K+’,¹°^è¾zÝï}¢4ãZˆ©Ê)’—qû€8!îõ•DÐ¯e¶‹|úá™äÍÔX(™¨1Ùgò™Ÿ¨óXÆò[KÕTBÂŠñ€äe\0´m„bRÌß÷üJ—§æ{šá^&&î*57±ÃÕ¾a‚f:Åu`~¬w\nn¯ïÞn¥ÇWayæS7QRÆ¸ \nR:®á€še‹”FDîfÆÅ®*ã0áÂ–åÑÍ¿Èƒ’xÂNJö˜±èsòhBA6cÆÊéÁgQ¸#þßÁ;ˆàEÑ×·Ð»émZâfe`É XáBK+(’0|âëë0eÕÌ³ø	3ÕBh^³®¦#ðÿ\0%KU]T³ìAk*)G‡™y½Ò×{å,ÑÔ€sŽ­‰.Pz,:ÍðéY_\'òZnþ‚{};2­w¨ÿ\0aØŽñ/)î>‚w\"¡eY®5ªÁ„\\ÌIIàf£\rYt+ø•çÕaÞýDx‡O¼Fù’åKVëðüBäu#[{ jÝ#­T“mÿ\0 4ˆÝ(\'ûÏÀA´9e†ß–2D<Å÷åkÑ=Bu\r3ŠþæAóÌ×Œéø%=U›ðÀ´]á¶yÑøÖÌuó-äKíü\'-£ö‡1Ù\'ž 	GÅ`ñ;<;& ä²~‘\na?/ÔÅWïücÀýEÝŸ…SþDÛÝ‹Eá)ÁÚ^rŽ6õûŠwPVî{ÊMGŠÂzPu-Á{Cßgà£7žÄ33¬«ut·ê+iBŒÛÚ«ùa\0eŠ½=¥]`B$±èqö˜Äü(zá Çåy£œ>Hˆ:­†U¶bIåcQ–šºÊ³y‚ûSG¢h»Êþ¢úoì§\nÅi+Œuüè8Ã•CÇC,ëbÜ^½Ž²ð³o¾Î‘D×ä•îd©{@ÖÊéPöüIBc)kðÿ\0ˆ¬|”³òKsöˆ:ÞÄqÈÜ_yŒøŒVÍ=¿’Ü>ÿ\0ÉÚ>“Þd35ìFX)pš‹Øøÿ\0XÜÈø¸aj—‘ûÂêFÂ¸:ß	õ¾õØÞ˜€KyðúTâ\Z1\Z‹(ô´´[ñËŒˆ‹uŸ[O÷¤çïà©Ulð^:MhKØ‹ýMóyÔ©c«8þ ó¿Â!oá ê÷(Å¥x†“xý)~å\"‹’Ëâ_•¼¯„:Ÿ#ýJ\'Aâ¥p#¥?0iYÓýcÔIvG%ft\\*»1Tv˜ïBö¨îEã´É0®‘ó.Ÿ (Ætº=Þ}<Â>±ze<D‹LÄõ0¶‹0e	Kª¨<¡wa•kË+§*§EÊq/âu›B˜â”veƒØ¸G‚?J)¾þ¬ûÃÒ¾A\ZÊcŒ¹Ä\0-¯yL\0r5\Z½Lí™¥lÙ.nóW§Ù;Ó$ûOÖ¨Cþò › îÅt|éùúd\nß¶c@¾%LÄ8ˆãÙ‹lÞ-\\ô¨Ì—=UƒŽ**Ž…	\'Ä&êQ4ÜÍ!9ÿ\0B•œ6gÝÉ¦Q6Ó‘s+zî8PoêP¾ë8—÷j¦Æï2€WwðŒô[øÌc\Zf¦þ¾¬Ø¶»Àl‹ábú•”YN4ƒ0o¬S_òkÏ,L­êÕFfØ`¥èS#Ù~#–nèþCþ<[ÓûéþþcXgÁ/EÒ=<Çj1óåÇ\Zè™«9=NäR·‚Ø!Ž­Å•Œâç>‰qì“†=&£üÅmSt\\þÃP,^Oã!þèÿ\0	~4˜	.™}%Ý£bå&Gªª+™Ð“qšb(\0·Ì¨Ì™±/\0üTWÅè	âæ¨ŒY˜PPÁÜSœ£f©³oB½¢Ð^»OöSÕ#rúmå«ö†P˜(Ù·+êÊª¾ª	±—0ió)F±ÜZá¿Ä	ÐpG­1nohP_€©Éëg\"bÑ˜*§eºq\nCþ×žò·¦µ¬GÔ,zgqwŸpåNÍÂ€ãwQ«=—ˆ¯`{Ñˆ;a:!]ûˆÚR™z:è[^†Ó\'ÚÌIÕƒaõ¤5x}¡½Eîâ­§xQk\0/+þD™Ž¿Ê$êsuÁ)ÀâGc%.£å{C$ÚûQ\r£Ì\"å6Å:ý±XÁî“>g%Ð´È‡zñ/ V\Z[¾ƒf^%©Óõ~%F7	Q¤ÌÒUã2œ\rÐ³1²úèˆ_x»\0 ýÊ™+ÆFâÙ~¾ýìÇê=…x»Wž²…²0,$¡~e¸u,]\"Šóf¿\n~s3—Yºb\r\rtµ_ü»ØeöÏ‚…¿h=tèÀÔî}£O¾Qëó0ª½$\'@à‹åÏ]_ŽK¯—õ:jðNâ]«Atç^Ÿ‰ÍAóf¦=\n‘yÈ°¸³C‹¡iñguiOì\n®®¦ß§É2ŽÇ™}C¤ôñÆ?ÊD÷ÈxŒ1¯„P2ñW(^¬bÿ\0Â\']¶XXh[2Rß=%]?¡1á^c”¾k¸}Çþåù79ŒÏØq?ixÑ•|Ç¾Îì±nÎ\rM,B¿*Bé/wD“¨pûCG¹:½»}åSA(ÙèêJ\'AÒˆóRõ²xAÐ7J¾L!ÖZíå à;ý%Xä–(7ÅJH«ÞÆðÖ’ )Ì+8Þ³¯3”Ü‡ú¨wŸêb„}·÷”Ý‘‹7”¬®“™FìN»¥òË\'{¡–°’ˆ »Çá\Z[9ªæðËš÷\ZºÖ!,9G,Ø@éN¢ªEºÂËçGÜºV—,pQáóGqi„\0P )ë…yÜº•2ÐñÀßâòQ3˜`ZÆ÷ÚÑzËÝÌÇPÆñ-`n‡b6ãÌÉÙ|cû3sæXåÝ(M:×ÞU†Ò.ÈrqÓû4ÂÛoq&[U•+¼Å†5uŒ¹n\r×ˆmë&ä¿á:¶bYbó)4(èe€–«¾ñc¥÷æÿÚ\0\0\0\0\0\0BS\n<½ØQ†I›bÒð§Ý¨GÛHŠ½Ð3ÎßÛTœOec…¯\rþ³Ìÿ\09nÉ¹dï7øçËnˆ,-‹öoùÎFß\"v¢Pù.ÚÏ–ë¾¿SC	¶,}6LŠ”‚ê\Z›l–lòˆ²“xÞ^Fnl‡g§ó}ôGïŸy±^/6Ú£ØDd-òÃK÷´~Ê®Áe°!uOmknä86t¨¹˜‡Ð%ÐÌþpp\' t0¡	Çƒýà^õàÁÿÄ\0\'\0\0\0\0\0\0\0\0\0\0!1AQaÑq‘¡± 0áðñÿÚ\0?š!OãB„!	¢kMR@:Ü5æÕ¢õ!? Øbh9raž Yix$u\rí~îÀŸôÆ¹ýðu§¡ž„•hxÜ¨T©&XOQ@¯aÁ?©A²úy1ÄQÊ_q6!—ñËëÛÓôŠ}ŽÓÜk\"n!¡wàÍ‚ðz0ƒ{­Š¨Û)‡·¾GEé|‹›I`}¿±Î=Ëîóxü—/šOßo±–Ô5–²&	ã¦PókÙ¿êÕT½_ƒ\0)²ß\"r§V¾\náPÝm.]Ýnó×ØAn¾HÛÇÈˆ’#u´ö¸›ãÙUØD{\r4Òï¿,¥™úN÷ÈÒ¢(0¨×²6kýû7N;)–wñ=xçÔ‰rÿ\0E×ý)³û~·“ð(ë0MðHIÿ\0Ãc$N¶ˆr!Šs/ÎN=Wº`i6ïÐ¾Ò,˜zž…óþ`÷xvm¯Æ†šSê=›6%ÁØ“Üc‘u…<%’PÊÒ1*R±TcgaC‘„½”qYzˆ	p<dy*-€Å1¶´L„*O¢´YEÒé¾´\n-Æ ôBþV!m§:3ÿÄ\0(\0\0\0\0\0\0\0\0\0!1AQ‘aq±Ñáð0¡Áñ ÿÚ\0?‰JR”¥)JR”¥/—ð\0¿„Faâ<‚¸dŸÈÿ\0ó¢˜˜+cq&d7£f¸v¾Þ‚J9Ü\\ÅÜKS»KÖòiú1å\Z(œÅœL×F4õ5JFeÍy,*K,Œ¼QG7·Øe(×q©h1h6QRs²åãçè7\\oô:ØS¦EÒ-‡„ÓsÍOÃ\'æÄ…º¡šUk-:ñÈÍõØ~“<‹–ÌœÝ‰4¼×°Ô3>íð#Ö.Ý`iÈÐ+ l;-­Ê_¦YèŸ£°^oê-¡Õ†¤¿V†eª~H__à÷—ÞÂián™ç°šeÞ{~Æ±zNö+Z²[®·ABÝõ^ãn	¤%âú{\ZËéì\'²JüFÝƒZGv!—…çð)Ž·›lK³o½ÅËõ÷õúîW>ŽŠô÷‡Ò/r/ÙòGeHÊ5þ™b=ýŠÏ¸¨¥6·¶³¶\rþ‚x<¢+õGq—‘<ßo“a:î4“þ1W‡~¿…‘üÁÿ\0†P³v9	+]·L¨m#Ë(JÝÜÕTÔ„7ï&y\r»L™`Xm”Ü[qHj¢¢†Zp4à‘\'	*Ðƒ4àÈËÌ†ÜÜC7ÿ\0… †-F=Pµ6á¨ÿÄ\0(\0\0\0\0\0\0!1AQaq‘¡±ÁÑð áñ0ÿÚ\0\0? ¡\0„AAá	^%þ ©R¥Jÿ\0% #Ò ¡A„ €@þò=!þeOOð¤¤¤¤¤¤§øQ\0€ÿ\0<!@ B ‚?Ëõ‡ú€\'¤¯ô*T©R¥@€ÂI !ƒƒ„’I\'„$“Ãü¯þ þ¡D¢T©D«•*b9=¹\"R¸_(ÞQ&â)JÄC”¿P‚JBˆuO¹Ã=_õJe€•*T©R™R™R¥J•µ`\Zoâ‘æT¥“-ó¥|ÝË*\\§\0dDWÃ	·…ó²\nS\\=f<­(<Æ-(\n%Û#çDXImOž`ÂÓÊ`,³…újÑKOÒî„ø„‚ìU€‚¾›ñ‰Õ§¥%…Â¿âbžì¾„²¡ñd÷¥ôžpZ€â#Ã(å/Ô¿Rßè*T©R¥J•*T©R°#ÊûÇ(®ÝvA0Ùd…in)ææ=()\n[ÉÔ{TO-»Ô=)64éäuËRÒŒ]ä°âK)¥]—Ç›—£öX©OEË>šƒ_î¤=V¡(\r¬ááj(c;U†9Ç8Œ–‘&[=;·U¤ä¨0J· î6¡ÛWŽ\ne\r}e¬0Vår9u‰AiDTYÑ+JGVf¼Á¡í†_HOÌþ%½YÚq\r¯}%6\Z€Î©aâ”šz‰Äzc×áˆðÏÔ·R™é*T£¸#Ð•‹UÍ\0»\\m1(Cv5Ú‘ÑYU„^ ª«Ó£Y/¹b´»4«ÑÞø‹ÐpáÇ{IÒ9&†\"EÍ¸¥Î=CèÉž®Ÿré dZnÄm¿2èŠkà³Ã	X` cœ†>²£¸Û\r5 eÖš´Jï–)çÔŽ‚—qÎ-eVevÖÀ¯­bàÍ7l4gÜ¢‚Bó6à–òÀ¡€aõAk¿PQµÅ#ò1\ZuLx±qa´ò¿†93\r<)IzfÀ1G±éæ2‚\'D~’Û)…—¡‹Ì(3º&æŽvÁ¢«…M‡\"›”¨jh¸P\0)¾î£ Ã\0ß‡B²Û Ôûµæ[-¤q\\F|0SmkÆnê¡GqÃ2[ÅÜhœyÀº‡\n|`E§;Á¶šÔESÈ·…lYŒÊ’ËÙ?pˆidGŒÔv!i¥<?˜úš‚eÎZ,†‹YÒ…¬³\\î&)’ÅcÎ¾Ñúñ\\\ZhÆ¨÷·0‡µ»U<ÆÈ¸*½¯~åíM6”ÅyÇÌwÜÐÚõò’Ð¯@TÁóóÔ¯òCô$K)­«ó(f\ZÅ|™X€Þ+N9Û0Zã½òàuï¶aµIBŠ^ØÔ—€Š+Œêí°á\'\nÔ½šf~Äš¡uØó2¾é•\0O4¤ÕF´]¡œŒç—´tÕàÖ’ @d\0uyaîé±jÕÏr¾´ÌUtp@Âþ¿½MÔœµï!ÌM\nC	°\naÛŸ,({±wEºùÆå\ZŠÉ|EóFåz{\\\0¬ÖÁšóîao  =Cëx62óÌ5dU{í”¢‚»ª}F•´l®¡i0\0¹ƒw_R!:#â¨±}	ÅøÛFO_¸²\\*¸mÕÝyŠ\0##hîŽþhñÌº—epxÿ\0Ë8G•–eX|LÖˆì€7\nE.í»÷È{Ë ýÁ:¾U)Œ2^_±…œ_©7Yé·“>ßÄJúñ\"}Œ÷ï˜êÁ“Ì®…½-zïö·V°{5¯|>F7!¦k„l‡	ÿ\0! Ö¥dŒSÆ†Mˆÿ\0ƒHÔ]8ß3/|Šœ5¯¼f\r;æ†Å,¨iZ.þaWnàÛ>yÉC„pç8Bü\\¦‹ëÃçÔ\rPÔ}x‡øƒº?rÂÜ¯\"USÜ²š1ÜVŒKMx[˜¦I{«™©E»VÌ¦† íªÊòó0côŽ$D»š£Î o8\\¸•·Ì¸ÍA ­S‡P‹¬vMMà£Þ¡ÒúZQËö8	yyzD„Å\\ïˆÆ%”c¿‰kšN×ú\"¥ms_0]U~ìµiá0¼2©^µ0‘d‡Ò+Ê¹{/hdvK)±ØžF“É°øÃ6š/ÏGÐ¿\nf¢ÊØ^Ç’Q;Z|1j.,à×€Ç…?:\"T‚tØ4f%‹æÜ\"”¡rZ±È0¥´0J8RÊÈÃORÃÈù!fqG/’¡Ó\rèªâX’]“gŽå(ÍFªþÛÌ³IWIO\rØ.‹è¨ÀòÎK~j$Ì¬ú|ÅÝÓë7@ê”~¬-µ\ràýËþ Š„‚‘Øå®¬<×Ö~b	!¹m€3Ì ¤…°®q”#Ùeô_¨1_Øõüßâ \"ZU]™mÆ&Ðçú\'ñƒH¥µ\\Yõ–S¬è]VT\0A€˜ÆN\0mN“ã‰w8t?%7ö”D\rÓ“Ù²ZÛ)J^N7×î%Ÿ+~¯L¶A—P‡²Ý~%‚×ÚÚ«®¹™Oµ[÷ƒkRîaUcgŠÄ4Õó¶Æ‡uÍÄÚŠÝM‹4÷äÇ\'P¸8*rÕÇ‰dFmnŸ2áQdêû=ª6·P18F‹0£¡%øÎ¦+µ¦+œD‚0,žÑp˜²àZhþbz—¹òbRÍPuŽˆ¥{€)ùÖ¥ÝQ¢ÏÁ&JˆÏ9™.‡ÂU¤³ºÝ£n8$qŸ#Ž¾È8¡ Íõº…ËÆ”@AÃeZdWÇ‹Ñh/’\Z˜D-»ÑU—Äy\rK•˜%9S†4Gµ@²áWkD²»Ûª«Á•,Î3[¿Õ0¾M•àK²Ê<³’$—E.›ÎðT@½¸ÂûËA@Ržp!H¹#9<¢ì¦×Éd» Õ€à¤<<žctQÇ7ˆh­þ…\"jù ÝmÍœê¼`§ ªv¹_Ç ËåSìÜHAÅÓçÞ6Kªãq\Z$Êz\nOL §ê;x¶ü<û„;œ·ý!`\ZÈþ%Äƒ‚½å9‘4“0¥Ü}\"\Z²ÖHè\"œOÜ1´Å]?„‹~`Ü\0îŠúÃ |‰\0]oñ,Ò¤-á·Òt\r£5ã÷ŽÖÐêK¦Å¾ë¹}+@°¶ÞóQá%hÊ^\\yå†œ†l 2¶Ž\0™¬R@¶ª´ªPþCÙˆå¥T!{.Ê»¢¥òÐB?9åcšÑÃÎ\'Ébïæ48ös,hüÜs´àÅèXW%4‚£“TÄ\\[8\0Ò`¿Üt4‚ÁW[âtÚF~Zõ1=î¥##Â’áP`úÇ+8£ý:”€þ…ýË¨¨Îî¿DCa„CÍÉvÖ†)‚k2/ÒÚ¯|G\0ƒÅÂ6{ý157iOå‹³ŸýD²·MGælšªì ÐÝ8û ”ï4üÔ §@Ÿ©\0ÈÃ…#l6Ê?ß2Ç´ùÚýŸ¸gÑ“ñ)B0çÞ€§,óŸšº»§îU÷Q?#ÿ\0#6‹×A¢v£ZÚàüÁj	(èsñÍ8±Æßù„\Zh´W\ZŒd6‹/4åŒnÁMhÙQhæªùbûõì aeFiÝza0\0ƒ…?2ƒGÖeÓï\0Ôçó(Ðˆ¸ )Ò\0Ý^è‡ÝžéNN^Ø³F|$vÓ­	Ñéuà´L5zî	Õn€ý…¼4ø™9Žÿ\0’\"ŸðûKóµ´¨‹œ‚?•„Š¦ÇÒŸ[…!³à‘FÂùªûÊ\0$Àóð–þ 1+¯ÚQ£hÒü%äXSãL/l¡¸ûÜÀ—Iúé÷Nâh‡Ãüªú›o…D%ÊM-_¼ÖÈiÚ<Ô0Í}T*C•d¦¾e¶j`ërƒ+[ƒ©´B¤-Aø»ø‹IÂ8º&Û*¾³\"ª›hÝx<sV}á\r8bŒ*ß%z›åÐ/ ¯ûÃíRã„¬Êõ5¹gæ6…4w.ýA¬erRQj[‚Ë—“*y-tpb8ºòEP£EdpÐù„JS‘ð[¾¼8•\r^¤[ÖÖf/sÍÞ\r\\l\\l Ð”x»€ìYjz³§\Z‚ÿ\0ö%R¯ð9n\\\\‹îkûÇ\nÆê> Çú¨@FÌßÞbUuå¶÷(y‡+ƒ‘éîpW`ïŠ0·5÷ÿ\0™Ñ~?Ä^”Ÿ7×óAóþÞeŒ.¯&ø;†Çpy~PÊ|ø˜o\"«ÖC\\î>F4+ûîà}ÜJR_²È>fÅ:©ˆÓfÚÖµ¾Â\0¾¥O@(R€5ïW÷‹ÓÊY.4[¹s Än—ñQ\'ð®S× ¸ü)1¸hD»UJoÅµ‡¯‹¨Ök ÑŽØ÷U¬°îQ´—AÎ¡óü¾çÌe:uEvŽNÊø¸Mi¯;¿qPv]°eQ†G¯>b)ƒBåù¯¤=ÆÐë5›ï1Ú (2s]9¨j¬¼Û´ &@új;.Ö°„i\Zºø‹I™m¢Wî\0×UÀ¦Åh%›ìšc˜¹ûKö‡úõ7Þ×èg¶IâŽÜ”H’îêÀŸ%@D¨]èÌß«üÅ4>îºÞÕŸYœÖ2ôï@[oö`¥x3ôˆ\0Éä²h´d°•‰{õ‡´pp<KžÞ,(ÕãÔ4¥à°÷úÄÏ(ÒGÜ~ñ*òªý‘|\'Ê,-ÈÅ‡Ú4¶ð#U€r´K>ª0ÎA;¢8 ­©uÉŒÿ\0Xp%RxÃê{MóUŸâñ„§Ž!bx[ÄxjéÝÆ\rI¦¯¥ÃuÜHZ(ÃŠÔ©áÐ7aKF:™V™yc:?rÄ{\ZUñk~al¥ \\ø0}bˆ…s`}¼@\n•k7¾Ð4mÇÝ%½Þ¯é³­QÓƒv^ªµ9@ˆcÆµÔÆ¢Ø‰ªÃk\r|@™ø¾ÿ\0›¦7«Ø1÷ÖÝ­eæqsgesÄ¢XÙeÒþÒè‰­ÿ\0P?M¶Ggâc=êŒõ-¿›˜4ï~?3ˆÐä@(üBµ	=9føÝäè‹fØÁÛŒ¥¡¶WÜb®­-¯6Ì­——ê=´ÄÀ¹ñÁ·RÆK\0º;ÄÔU²RÕë×æV‹µ‚ó_ˆ_\0§‹vï†,tB}šÐˆù·,:ßVVxñ|@ó*\n¹µ Ë»á‚…K•MY‹.ÿ\0½eÐ†Ý}wQí—ç¨èâ+a€W.©¤œž(û¯ppé¦¡ò×1à¯-\Z»¯nXÍªñC<zn#e…››]oyš¢¹rWw\n÷‚U%Ù÷Ôì2ù±_Fo¾C?©…¯¢¸‡cÁ‚	—Œ\"“c‡þ‘wrÊŽ¤·½E³ïØÌ—Ïù)¡ŸÒ6Ä .€x…8”œ$sgE\ZUX`ÜR”¥äÙ_1Ñža(´\\çë¨2@¤´.ƒ˜®¢íùLè[jœWù\ZÙ×ô·o8Ží\'uYV6„ìPü:æåË§„¼=!Fõ7w´mam¿bfMš«qÏúÜž[¤ÒîV0;|Ì-Œ%d;;ó{Ôp³-kÏÌ](Ç£ëÛV–S°¯´ˆÓÿ\0¹²:Jµ‡Wž`UÂ±CÁ‘¬ïé7dµ©Ý?J0\nyZ_Ä\\ [	ÓVˆ#.²¯ê]b9ÃžJ*<a*í_<Ä\0ó°V/?f«bž2Å×—ïÔ`/u=&vÅh\nÿ\0°%zSw[¦ˆ«Î5-Ÿ†bFÛïQì\nâ²}ÖD^\0ã£qO&i´q]Jãas¡¡Ø¡	Ãk…WØõ-cö%`Õ‡S«KÎ±3918XÑèÎõ¸\"±_j;AÕŸXcMÚ²ÐVN½	–€Òå¥vÔÈØZn|ö~º€Í«VÝfù¤+lj•,ª­V&f‹°¯`g¦±½,±Šx<Þs©da¤ST{îpFçÕãu*ÂãM8ñƒÜÆÀlOÔx‚ðrÁº¾LPÛ¼Yz°.ûö„ZÚËÔaHE¯ˆ-ˆØvÛŸw¯rûÊ\0GºâaFp)´µî¡á1Á(x¦¼(ŽCNþ9ˆ7©¨ªÊ¾—qÚ\\|m*\\c©LŽæÓ´|‘›¡¼zß.\"Š—LEš¶‚2¾»ãÌTÔ­ìiywM\\Ð‰°R»ÇÅ{ƒ+fQW¾þâpJúUíÝÂ‰jRáCv9ÏŽ¼Fe´Þ¶Úï\\{ÌS\"7\0ªÕ¿G	k3ŒÝó|Ëù”]‡nÎH:dp›¢‹×ö¥Q­‹kIÇ›yóßgt7K†>¬Hx\\åzDÑ¹VðÙº«úªÔJá¢€ Áðõ1å–%J½WeÖ»€áQ–Ý8ã¯0AíQ-øï6°ÕŠ¼¬Ö¡VâÕ–p\Z·¨HcYÖ3]î6úÓ\\5J˜\\÷\"XúýîÒW7ûŠí\0Ç\'Ö2ÙÛH\0¯‚øîaÎ}­Åâ ¯ûP7\0´8qFn‡ •šQÛkoÒ§(§Bí_´(V©jÜwõƒP0€ãÄ8l89¿i…•žŸÜ2µ ¶£ºÄÄèzÜ\09ó‰l†l]z­JµKæˆh¹uUÁa3T•Ži<A¤ÿ\0&ÞÛXˆŠ„ ®‚4Ò¶ÌšÑ7ÝÏOäûDcdK[wý_¬Êyhäe‹ÉI°VŸˆî’Å*aY÷™R‚]…y)ùUfÔX6ó\0Z™G6Õ~ªÅÐ›	‚¿›Š`V”\\<¤*†Àß}î¦Ô—C±4µÆO¢Š²j+8¡‡È*,€Åú„é£JmyÌ s]\ZÔ+¤ÊmPe~YÿÙ','2015-m3-9_318.jpg'),(38,'sdfas','fasdfa','2001-01-01',12312,163,'‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0ôxÔú\0\0\0	pHYs\0\0\0\0\0šœ\0\0\nOiCCPPhotoshop ICC profile\0\0xÚSgTSé=÷ÞôBKˆ€”KoR RB‹€‘&*!	Jˆ!¡ÙQÁEEÈ ˆŽŽ€ŒQ,Š\nØä!¢Žƒ£ˆŠÊûá{£kÖ¼÷æÍþµ×>ç¬ó³ÏÀ–H3Q5€©BàƒÇÄÆáä.@\n$p\0³d!sý#\0ø~<<+\"À¾\0xÓ\0ÀM›À0‡ÿêB™\\€„Àt‘8K€\0@zŽB¦\0@F€˜&S\0 \0`Ëcbã\0P-\0`\'æÓ\0€ø™{\0[”! ‘\0 eˆD\0h;\0¬ÏVŠE\0X0\0fKÄ9\0Ø-\00IWfH\0°·\0ÀÎ²\0\00Qˆ…)\0{\0`È##x\0„™\0FòW<ñ+®ç*\0\0x™²<¹$9E[-qWW.(ÎI+6aaš@.Ây™24àóÌ\0\0 ‘àƒóýxÎ®ÎÎ6Ž¶_-ê¿ÿ\"bbãþåÏ«p@\0\0át~Ñþ,/³\Z€;€mþ¢%îh^ u÷‹f²@µ\0 éÚWópø~<<E¡¹ÙÙåääØJÄB[aÊW}þgÂ_ÀWýlù~<ü÷õà¾â$2]GøàÂÌôL¥Ï’	„bÜæGü·ÿüÓ\"ÄIb¹X*ãQqŽDšŒó2¥\"‰B’)Å%Òÿdâß,û>ß5\0°j>{‘-¨]cöK\'XtÀâ÷\0\0ò»oÁÔ(€hƒáÏwÿï?ýG %\0€fI’q\0\0^D$.TÊ³?Ç\0\0D *°AôÁ,ÀÁÜÁü`6„B$ÄÂBB\nd€r`)¬‚B(†Í°*`/Ô@4ÀQh†“p.ÂU¸=púažÁ(¼	AÈa!ÚˆbŠX#Ž™…ø!ÁH‹$ ÉˆQ\"K‘5H1RŠT UHò=r9‡\\Fº‘;È\02‚ü†¼G1”²Q=ÔµC¹¨7\Z„F¢Ðdt1š ›Ðr´\Z=Œ6¡çÐ«hÚ>CÇ0Àè3Äl0.ÆÃB±8,	“cË±\"¬«Æ\Z°V¬»‰õcÏ±wEÀ	6wB aAHXLXNØH¨ $4Ú	7	„QÂ\'\"“¨K´&ºùÄb21‡XH,#Ö/{ˆCÄ7$‰C2\'¹I±¤TÒÒFÒnR#é,©›4H\Z#“ÉÚdk²9”, +È…ääÃä3ää!ò[\nb@q¤øSâ(RÊjJåå4åe˜2AU£šRÝ¨¡T5ZB­¡¶R¯Q‡¨4uš9ÍƒIK¥­¢•Ó\Zhh÷i¯ètºÝ•N—ÐWÒËéGè—èôw\r†ƒÇˆg(›gw¯˜L¦Ó‹ÇT071ë˜ç™™oUX*¶*|‘Ê\n•J•&•*/T©ª¦ªÞªUóUËT©^S}®FU3Sã©	Ô–«UªPëSSg©;¨‡ªg¨oT?¤~Yý‰YÃLÃOC¤Q ±_ã¼Æ c³x,!k\r«†u5Ä&±ÍÙ|v*»˜ý»‹=ª©¡9C3J3W³Ró”f?ã˜qøœtN	ç(§—ó~ŠÞï)â)¦4L¹1e\\kª–—–X«H«Q«Gë½6®í§¦½E»YûAÇJ\'\\\'GgÎçSÙSÝ§\n§M=:õ®.ªk¥¡»Dw¿n§î˜ž¾^€žLo§Þy½çú}/ýTýmú§õGX³$ÛÎ<Å5qo</ÇÛñQC]Ã@C¥a•a—á„‘¹Ñ<£ÕFFŒiÆ\\ã$ãmÆmÆ£&&!&KMêMîšRM¹¦)¦;L;LÇÍÌÍ¢ÍÖ™5›=1×2ç›ç›×›ß·`ZxZ,¶¨¶¸eI²äZ¦Yî¶¼n…Z9Y¥XUZ]³F­­%Ö»­»§§¹N“N«žÖgÃ°ñ¶É¶©·°åØÛ®¶m¶}agbg·Å®Ãî“½“}º}ý=\r‡Ù«Z~s´r:V:ÞšÎœî?}Åô–é/gXÏÏØ3ã¶Ë)ÄiS›ÓGgg¹sƒóˆ‹‰K‚Ë.—>.›ÆÝÈ½äJtõq]ázÒõ›³›Âí¨Û¯î6îiî‡ÜŸÌ4Ÿ)žY3sÐÃÈCàQåÑ?Ÿ•0kß¬~OCOgµç#/c/‘W­×°·¥wª÷aï>ö>rŸã>ã<7Þ2ÞY_Ì7À·È·ËOÃož_…ßC#ÿdÿzÿÑ\0§€%g‰A[ûøz|!¿Ž?:Ûeö²ÙíAŒ ¹AA‚­‚åÁ­!hÈì­!÷ç˜Î‘Îi…P~èÖÐaæa‹Ã~\'…‡…W†?ŽpˆX\ZÑ1—5wÑÜCsßDúD–DÞ›g1O9¯-J5*>ª.j<Ú7º4º?Æ.fYÌÕXXIlK9.*®6nl¾ßüíó‡ââã{˜/È]py¡ÎÂô…§©.,:–@LˆN8”ðA*¨Œ%òw%Ž\nyÂÂg\"/Ñ6ÑˆØC\\*NòH*Mz’ì‘¼5y$Å3¥,å¹„\'©¼L\rLÝ›:žšv m2=:½1ƒ’‘qBª!M“¶gêgæfvË¬e…²þÅn‹·/•Ék³¬Y-\n¶B¦èTZ(×*²geWf¿Í‰Ê9–«ž+ÍíÌ³ÊÛ7œïŸÿíÂá’¶¥†KW-Xæ½¬j9²<qyÛ\nã+†V¬<¸Š¶*mÕO«íW—®~½&zMk^ÁÊ‚ÁµkëU\nå…}ëÜ×í]OX/Yßµaú†>‰Š®Û—Ø(Üxå‡oÊ¿™Ü”´©«Ä¹dÏfÒféæÞ-ž[–ª—æ—n\rÙÚ´\rßV´íõöEÛ/—Í(Û»ƒ¶C¹£¿<¸¼e§ÉÎÍ;?T¤TôTúT6îÒÝµa×ønÑî{¼ö4ìÕÛ[¼÷ý>É¾ÛUUMÕfÕeûIû³÷?®‰ªéø–ûm]­NmqíÇÒý#¶×¹ÔÕÒ=TRÖ+ëGÇ¾þïw-\r6\rUœÆâ#pDyäé÷	ß÷\r:ÚvŒ{¬áÓvg/jBšòšF›Sšû[b[ºOÌ>ÑÖêÞzüGÛœ4<YyJóTÉiÚé‚Ó“gòÏŒ•}~.ùÜ`Û¢¶{çcÎßjoïºtáÒEÿ‹ç;¼;Î\\ò¸tò²ÛåW¸Wš¯:_mêtê<þ“ÓOÇ»œ»š®¹\\k¹îz½µ{f÷éž7ÎÝô½yñÿÖÕž9=Ý½ózo÷Å÷õßÝ~r\'ýÎË»Ùw\'î­¼O¼_ô@íAÙCÝ‡Õ?[þÜØïÜjÀw óÑÜG÷…ƒÏþ‘õC™Ë†\r†ëž8>99â?rýéü§CÏdÏ&žþ¢þË®/~øÕë×ÎÑ˜Ñ¡—ò—“¿m|¥ýêÀë¯ÛÆÂÆ¾Éx31^ôVûíÁwÜwï£ßOä| (ÿhù±õSÐ§û“““ÿ˜óüc3-Û\0\0\0 cHRM\0\0z%\0\0€ƒ\0\0ùÿ\0\0€é\0\0u0\0\0ê`\0\0:˜\0\0o’_ÅF\0\0‚¦IDATxÚìýg”dÙyž¾{ïsN˜ô®lvw]\04ÉI€¶ ˆH‚¤x©¦“DiDÞYsïh–Æý˜µæçÜqkÝ™Å{e(éÒˆ¢$â%©¡¹¤Äh°@Ãµï.›™•.Üq{ïù{G<æDšª¬ª÷Yë¬ÈˆsâDÄyßïÛßþ¶°Ö‚B!’‡€B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „Bh\0x!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „Bh\0!„B@!„\Z\0B!„<Z<Ç‡‚TúªŒø›\0vÄßdØÁ²<D„€?`ò Ÿp.®^½*Z­–ˆãX$I\"ò<yž\00Æ­õàok­0Æ÷ù‹‡å»³»»{?^Ð.íë£þ>p›}H~X\ZÈýþQ€ì™ÇÿÔŠ:®^½*‡‰º1FdY&­µBk- Kkmqõz]:Æ	@$I\0ƒÛ›xØ¿7#ö àBãE]q@ä…6Žcí®·Ù!—•¶iŽj\0xþ 4\04\0dJ/‹{ÇÒ»ÖZ\ZcäQ—ÖZQ«Õ”û»x©Â0<p;\0rb/ýmîRH)„qû¬µ>Ò—ä8¾cÃžcšý\Z·ZkÿÙ…ÙH)À¸ÛM?b¼à!„Öýûë€.ümÒ4Õ%c0jkNÊ$Ð\0\Z\0\Z\0rŸ^k­\n¯¬µ2Š¢À£¼ [k•ñ  êÊZ«”Rµ6\0 „”2t·IkmànSRÊ\0 \0È<ÏWŒ1s%ñÇõ)Þ¿(\\UŸ§ÊýF½Æ!žÃŽÈ\0ÜÐ+dŒµV.µµ6w‚¯­µZ‘ÐÆ˜Ü\'êƒÛ\0h÷œ¹ûÛ]0åËqfG14\0„€€Aè777e§Ó‘išÊb¯µDäµZMcTAàkmP÷ÀZ(¥B\'à¡û[I)ÿ)e „Ýc­µk\0šÖÚóRÊÀs^)cÌ!„B@Ñ0Æ,Nû=÷Ý(þO1ô¾£?Íí\'y[Õý(\\¿íD\0nZk!„èXkwÜí¯;aÞBÜqÆ +˜ƒ\\¡1™µ6ó†Á_ÈQÈ1ÐîïÜ„á²AeS@@h\0h\0H5Á—W®\\‘wîÜQišÊ8Ž­µÒZÖZeŒ	\\?QÜ¥”‘ôÐZ\n!\"·…Zë\'1³ÖÚuÁŸBH\0+\0B\0\0šBH)áDJ)(¥ ¥„”J©Áw¢øÝ˜ô=9Š˜–/GýÒãÇ=ç8?ÌëW}þâÿ‹\0ôGî½Ÿâ†»Þ° `À¦¢àš¢í\r»ÌŒ1™\"³Ö¦ÎdÎ ¤Î0dÎdišf\02—UÈË¦`œ  4\04\0dL”ÿÌ3Ï{{{*Žã MÓPkcÂ0#­uäÄ¾fŒ	•R‘”2”RFÆ˜Ð¼RÊ|”eÙ:€%\0ç­µ«\0f\0œ0+„˜+\n{YÌýõ²ðA€ †á¿‹ÏUþ®øÏ^Jy¸¿ÃþW¾Í?ß°ÇŽÎQÏ[Õaõ¸Qï£ø\\“Så5¬µ0Æ¶QïmÜq+ýo»lÀMkmW±à:€-g\"Rgbg\nbgcLìB\"¥LÒ4¤Sà‡.,\r\0¡ àxò±”Ï<óL°³³t»Ý(Ë²ºRª¡µn(¥êÆ˜º”²!„¨…aØ0ÆÔ„5\0uk­ø‹ÖÚe)åŒµöœbF1_r/ðþÀ š/Š¹¿îïç¯+¥EÂ0\\–E©øY—£Õq‚8I8«Š¥®IQô0ñ¯\"ÔÃž{Ô~Œ32UGÑ<\r3ãÞç¤}µ/è?´¬µ{Bˆ7\0¼à%\0]\0=km@GÑ3Æt„=¥T7I’^ÉÈÐ\0\Z\0\Z\0r0ê——.]\n÷ööjiš6¤”³RÊ9­õ¬Rj>‚Y\03Zë3Bˆw\0xÒs^Jy^±XóòßÅëÃ\"öâý¢(BE¨Õj¡]‹–Ç]N#ð£Dq’	˜Fð«<ç4ÿ?ì{ª’MuûˆÈþÀo³hÆ³*[!spÀ›\0žB¼\"„hcv…-kmKJÙNÓ´ qFÀXk\r\r\0¡ à+Eý[[[a·ÛmH)gÑo_‚`Eký€Xkß#„X—RÎ£ð¢ˆ£qÿ·¿½(î^à‡	ò8A&F“>ãQ¢3L Çƒ*‘íQ¼Š¸Wÿi‡\rÆ½ça™dÆýVËæ Ì°¬Â¨ËÂ¶à\0$„øKkí!ÄŽµv/‚VÇ]grl^D@h\0h\0õ\'IÒ”R.\0XÃð,€§ò<ÿ;RÊ÷„a¨Š¢î·z½~Ïe½^Dï“Ò¾ã>ŸqŸë$á9¬O+ø‡úªF¢j4?)¨\"øU#ÿQ÷;îßZ9‹ µ>0ü0¤&á‹Bˆ_ð‚µvÃZ{G)µ—¦i®†\0…é„4\0„€àqµ¾¾îïï7„s\0–„kBˆó\0>àGÂ0œ«Õjh6›h4\Z˜™™A£Ñ@³ÙD³Ùˆ}1\"«z|‹ŸÛ°ûOšf7.­>*Z&^U£ìQ÷=Š™5æ?éÿÓš›a÷wÛ¸c]eVÂýø-\n!† Ïsh­‹æÀXk?-„økíBˆÛ\0¶³,ÛàëôaM\0Ïß„€à¡ÿ³gÏÖ:NS±\0`%‚óRÊ§µÖ;Ã÷ÕëuÌÍÍaaaóóóXZZÂÂÂÂÐB»QÂ}˜©wãœ(•‹ÔÆEªã¢Z­5²,C–eD¥ª°–‡3|Ç½*õ	åãX,¶UMÈ´&bšÈÒ{¸¿Ao²,CžçC`­½à_ø4ú=¶‚ Øã¸]0†çB@ðXˆÿ3Ï<nllDÝnwF±¤”:£”º`Œù«Bˆm4\Zs333XZZÂÚÚ\ZÖÖÖTØ;öÓ¤ì§ýüÉ½øzÅ×JÓY–!I’ÁÉ¿˜*&ÊE±ö÷É²ìžˆrœèŽ2(Å¿ÇÍ<ð†eÔ1ôÓË}ÊÇyTµþ°Š¿½øœ£f L2R£n»ß3›iš\"MSoà´µöw¤”ÿÎsÀ†Rj7I?$0µ	àù›Ð\0Ð\0<Ìâ?`Y)u.ÃukíI)¿¯Ùlbqqkkk8þ<\ZÆáu¬«F„“>»²Ài­Ñëõ\'táùèÜµ?Ùçy~O‘X•,@¹ðlÜtÂQïoÜ1õwYüËÇ¹x<†™ŸÃ~ŸËf¢ø÷(ó0Jl‡™•õ[+îŸÿ^øïŠ1æsRÊŸµÖ¾aŒ¹Á¶3¾8ÐðüAh\0h\0Yñ¿}ûv­ÛíÎFQ´à|—ò<ÿ‡Q½nn+++8wîÎŸ??Ó*‚3LÔÊ×ËÑ­õâIÚ§ß‹\'ïaéøa…`.å;.Í¹F3\0\0)å-ÿ·1ÆºK!¥¼iŒÑî1ÆÿÏÝ?qóÉG}¬¿¿Â\n!n\n!z…wü¾k­°ÖFÖÚõÂ*…ÒZ{@€BkmÀŠ{>¿¿gÑ_çÀ¿ÇY\0óÓþfÓ)qØýÊF¢lF™˜a¦¡Š¹ª’mòÏÇñà;d­}Iñß[k_6ÆÜPJÝIÓtZÀó7¡ xhÄÿÊ•+Áo¼Qët:sQ­ApQñV­õEÑ;pæÌ\\¼x³³³÷¤ÜËÇ­|’õ›tŸŽ/¦Ñ‹…Z^Ð‹â^óâmþºÐ…[ÖÚÀúó»·Ñ/î2n\nØ¾µVK)[Al\ZcŒëG`Á\Z¿âm¿ø`µÖn\\÷wy©Ü‘_/”–ÑµÖúç|,Å­°p‘°ÖJ)¥*)¥”ÖZ)„P…ÇÉÂã;Ócž*Ý×w_”îkQ·Ö®`P\0Xs‹-yf¬µÃ²ã2ãD’i6ìQ®˜dÊ†´8Dä†þ?\0¾hŒ¹^0•‡xþ&4\04\0…øPkkkuù+¥Ö…Ok­ÿÛz½þŽÅÅEœ?O<ñÄ éNñÄ\\Ž¨ý	YkV«…N§ƒ8Ž‘$É=Ñ¼/ªóÇ¼(èåqz·eÖÚ-iï ßK~Ç³%„ØUJÝB¿3\\jŒñÆäÆ˜Ü3XeNkíWŸó—FQ\\ÊöÀÊrQ·B“ç¹)ºÂ¤ij\n·3\0þ9¼FÉ\0  þE¡^¤@õ«\0Eù¾åÇ)¥K—.ïùÛ…É(m¢d(TñvcÌ¥Òã–\\öÁß\08ç~—@`µðžÏ3£þö& Ø4ª<´3jf‰ˆãØÑM\0ÿOo‚ ØJ’¤˜	°<\Z\0\Z€‡^üÏž=[k·Û³\0V¢(ºÁÛ´ÖÿÛz½þŽååe\\¸poyË[eÙ=Ç´,üA`{{;;;hµZèõzƒÈªÉŠÒn9ñ·RÊ[îvà¦;á^ÐÃðºvkmîúÀçnmŒñ‹Åh­u&„~žç¹Û,Ë¢ï…ßZ[ã¢ØRó…¨~èí._¾ï¨cowvvŠ™€a¦¡˜¸\'+0n«×ëÒ}>åL‚eŠÃîõdá1R)5Ì\\Èa×Ë¦¢h&ÜBNL†\"(f+Üue­½ 	`ýæS«\0êîzÀ÷÷dŠM¨†	þ°ßºµv0$ µ¾%„ø¿[k¿bŒ¹æjŠ™\0K@h\0h\0Vñ—.\\¨íïïÏ\0X‘R^ˆ¢è-ZëÜh4Þ½¼¼Œ‹/âÉ\'ŸDžç÷D^EñWJaww›››ØÝÝE·ÛEÇHÓÆ˜8Ïó!Ä†µvW±\rà\r¥ÔM)eKJé#ô\\¡­µºx]‘k­skm.„È˜ûÿé<Ï5\0ín×.ª÷\"o]doœ@ûK+¥4RJÿ·•RZ¥”uïÇ@ƒ/B­Vü]¯×ÏÍÍY\0øøÇ?>M9[ø®Ù	ŸS1#€’!¨r‰&¢²©(ŠiŒEÉd ˜ýÁý{²î9TÁ\0””2p9“ð$€‹è/õ„b©˜\rðMª†\r\r«W)˜€kBˆÿÎZû5kíõ ¶ã8ÞÇ„><\Z\0\Z€Ó|Läúúzmoo¯	`YJy!‚KÆ˜X«Õ¾uyyëëëxê©§ÆŠ¿¿íúõë¸}û6ö÷÷Ñëõ’<Ï¿fŒùšâ«RÊZëž1&6Æ¤RÊÔ-íšD^»Ôº{×Bã¢õâf¤”:I’Á}ÜmFJi”R~³RJ\r‚ÀÖj5[¯×íÜÜœ}î¹çDÝö1ü±‰ƒ?Š£\Z\nLc*\ZF1³ †˜ŠÁ0GÑ¸ëJJºÛkmˆþRÐ5)eÍÓR6<e­ý&!ÄÛ„oõ& ^¯W6½^ÏOý|Uñßc^p3Ãí^¯×r&`hÇ@ž¿	\r\0\rÀ©ÿË—/‡›››Mkí’1æ\\½^‹Öúï„aøÝ‹‹‹xâ‰\'ðôÓOÒþ£Ä?Žc\\»v\r›››ØßßG’$o(¥~Uñb–eÛ\0ÚÖÚ^š¦±”2Bd>‚—RæE÷zÇ®Å]JiÃ04#„}â:ïäT‹²‰¸gX¡Ñh(74 Ý¥rÙÐZH)ëÖÚº¢	`NJ¹l­}7€’R>é×˜UpXn]È|^ñÿ¶Ö¾àfžçwÐ_qÐ›\0\Z\0rl<ä¤NÐÏ<óLpóæÍšbÎ³ÁÅ<Ï?ÁwÏÏÏãìÙ³cÓþÆH)Ñn·ñæ›obkkûûûFkýGJ©_ÓZ_7Æìh­wµÖ=)e†až¦i&„ÐJ)]õ0M1Zúév/ìkkköcû˜ñá:?ÅÓKéó±Gý®–3\n½^O1\n€j4\Z¡1&0Æ„ÎÌ¸‚Ñm!ÄKÆ˜ŸHÓôÖZÔëõ‰­¦¥”ˆ¢ÈÞ÷Zkÿ–â_ÈÂ0Ì³,óu$Sõ „€<¨èLmllDqÏ„a¸Á\0ïB<;;;‹ÕÕU<ñÄC»ÐùMJ‰½½=¼ùæ›ØÜÜD»ÝŽ1¿àZë[Y–mXk÷µÖ Ò(Š²0ÍÂÂ‚™™™1kkk†¢N¦0“j$¼9˜\0a½^¯çy¾ç–ÿíH)ÿµ1ÆfYöAg2ïiJTŽâ‹VeYöa\07\0ü&€,Š¢<MS_pä	¡ \'êÖ××ÃÝÝÝ†+’:+¥|›1æÎÌÌÔVVV°¾¾Žz½>ˆò‹\'C/þÛÛÛƒ´§ÓÙBüK\0ŸÓZßÌó|ÓZ»W«ÕºËËËé¥K—òçž{NSäÉ	šÿÝÒBˆÜ‚$Žã@/Š¢XkH…?çÖ8`Æ5´Š¢ÈÏZ‘yžÿ€\r7%­Õj:I_pèÅƒ¡ \'ýËË—/‡\r!Ä‚RjM)uQký3Ífsqqq.\\Àüü¼o¤sOä¯”Âööö òïv»¯*¥þ‡4M_Êóü†âŽbo~~¾wþüùìùçŸÏ_}õUžÉƒ0¾™“NÓ4¯×ë:Ïsí¦gþœÖZ\0ø\0€ÁpÀ°µüwßZk#­õ?pÓU“$IR\\>XóS 4\0ä4‰¿¸råŠzõÕWkRÊY­õ²Rê¼1æÙ(ŠžöãþgÏžE–eÅcc½^ïËJ©–eÙ e*€ýÅÅÅøµ×^ËnÜ¸aõ“m\\FÀÆqlëõºí×Ÿ\n!¥üWZëE\0_\0Fc¨	\00˜Îê¦´À\"€\0àÿ†»Kç…\0ë\r\095Èk×®EI’4ƒ X\n‚à<€o’R~÷ÜÜÖÖÖðÄO¨ø/\Z€²øÇqüù þi–e¯Ä¿µ¼¼œ¼ôÒK™kâCÈi1\Z@\ZÇq»^¯‹<Ï…1F	!þ­õÿÀE!\Z¬µƒn•þr_ào\0ø%ô›Ue¸Û!õ\0„€œŠè_^ºt)¼sçNC±(¥\\SJ=©µþ©™™åÇýË¹+øsâÿE¥Ô?ÍóüU­õu¥Ô¶¢uöìÙä…^È)þä›€$ŽcÔj5™ç¹BRÊŸÕZÿŸ²,[ôë—hžÀ÷øªËxà×\nàP\0¡ TüÅ3Ï<\\¿~½.„˜³Ö.¸çùO5›ÍÕååeœ;wFZë{zû!ÐjµSýâ8þ²”òŸåyþjžç×•Rw¤”­3gÎ¤/¼ðBÆ”?y2I’´¢(®‰P µþY–ýïÐo(4\r\nÀOÃµª.˜€Á\"Rññæ—îHrTñ 766¢4M›\0–jµÚ\0\nÃðý>õ¿¶¶6\0ƒý\0$	®]»†\rt»Ý×”Rÿ<ÏóWò<¿¡”Ú–R¶ž|òÉ„âOà\"ó$MÓV–e›išÞ4Æ|\nÀ8äÓ.øû\0ÎX0 æÌàQ\'4\0äx€õõõ¨×ëùÔÿ!ÄÛ…?:33ƒ••\\¼xqÐì§¼j\Z\0¼ñÆ~ªßŽ”òçÒ4}9ÏóRÊm)åþ“O>™<ÿüó9ÅŸ<D&À7îI\0´\0l¡¿èÔoøãC>í»Ñ8ãAýu\n$M\0¡ ÷=úæ™g‚v»]“RÎ…a¸¢”:Ÿçùß«×ëÍ¥¥%œ?~è\Zé¾èÏ‹«ÕŠ…?§µþ’ÿ;RÊý3gÎ¤ò›€ýUýöl¢ßàçç¼|È§ýa\0ï\0°†þª…\rô‡h\0\r\0¹¿ßŸ­­­Ð¥þ•Rg­µ=Ã§°¶¶†………é~)¥ÄÍ›7½ý1¿¦µþL’$7„w\0ø‚?¦ýÉCíœ	èØ°àM\0?`ûÏ×\0ðwÀ¡\0B@`ô//]ºv»Ý†bAJ¹&„¸à{fff°´´„õõõ}þE«ÕÂíÛ·±»»‹<Ïÿ\\ñûZk/þû+++±«ö§ø“‡9à‹ôR\0\0;\0nx	À¿pÙiy\'€âîPÀîB@NTü\0¹¿¿I)g}»ß<Ïÿf½^¯/..âüùóÐZÿ¢–ß¼yÛÛÛˆãøºâßXkoøö¾sss1çù“GÌè‚	¸à€¿Àá‹?êŒÀ*€yÜ\nà9Ð\0“õ\0.\\ˆ’$i\0XÃð€†aøîÙÙY¬­­a~~þ€àSÿ7nÜÀ;wÐét2!Ä/i­ßÌóü¶µv·Ùlö®]»–RüÉ#jb\0mgnø_p¸¢À€¿à,€e\0³.À¡\0B@N.úæ™g‚N§S“RÎYkW„ë\0~¤^¯cqqgÏž…ÖúÀ¸¿ïû¿··ç‹þ`Œù/ZëÏ£ŸÝm4\Zõõõ¡ëžò˜\0?3Àn¡_øËèÏñŸ–·ø^ôÑ\n`€Ð\0“ûÎlllDY–5„‹a®Yk8Š¢µ……œ={J©{–øB@)5÷O’äM¥Ô¯¸eÙ¶µ¶µ¸¸ÈŠòÈû\0,\nÜð€…ÃÕ|?€§q· °Ž~ƒ7f\r\09ÞèÿòåËAÇ5Wø·jŒy‡â;fff°¼¼ŒµµµA‹Óâ\"?>õ¿³³ƒn·«…ÿ>Ïó›Æ˜McÌ~aÜŸâOå,À¨¢À/\0øõC<å<€Ã½\n 4\0äXQ»»»¾ðoQqÆZûl½^}ôŸeÙÐ±ÿ4M±µµ…V«­õ§\0|^J¹`¯ÑhtÏž=ë8!äq0Å¢Àmg~Àñ”ïGÉáUÜí\rÀ,\0¡ ÇýËK—.q7ò<Ÿ‹¢h\rÀ7AðîÙÙY¬®®¢ÙlÒýÅiJ)Üºu{{{H’¤%¥ü\06â8Þ6Æ´™ú\'©	ðõ\0¾Sà-\0¿ˆþðÀ´çñE¿7€Ï°7\0¡ Ç\"þ€ÜÛÛ«I)g‚ XB¬øF£ÅÅEœ9sæÀ´¿âB?Ýn;;;èt:0Æü‰1æMcÌvE­F£‘¼ôÒKòXú\0Ü[ð7pÀ0@h\0È±{€õõõ0MÓFžçóRÊUkí‡ƒ xÒýA0áÆþoß¾ýý}$IÒBüž1f+Ë²]cLguu5«þÉã›ðõ\0]ôë6\0ü€/â)?Œ~Aà\"³\0„€Kô_è÷?[¯×W\0œ·Ö~ÄOû;wîÜ ú÷âïÍ@§ÓÁþþ>z½Œ1j­½¡µÞÑZ·›ÍfÊn„Y€þÊè÷ðõ\0ÿÖƒiˆ\0üú3æÁ„€Õìììiš6„óÆ˜kí÷‡a¸477‡åååâ_Lÿ+¥…I’ÄRÊß5ÆÜ±Ö¶¢(ê?>ÿñ‹ù¡€-\0_ðñC<×û\\@ ¸Z !4\0dúè¿ÓéÔ”R³J©%!Ä“BˆÕj5ÌÏÏãÌ™3\"þâßqcoo½^ÖÚO¸®µÞõÑÿóÏ?¯ýrÀtì¢_ð1ý‚Au\0A¿}\r\09ZôŸeY]1ïæý4ÃúÜÜVWWþ£)%¶··Ñn·‘¦i\"¥üm­õ¶1¦†a¼´´ÄiÇlÖ„ÒmJ¸-t[TØj…­î¶âmþ~þ±þ¹”Û¤{=ŠÊñág‡n\0øC<×·áà\Z¾/\0!xÈ¸èÿÚµkƒèßsQJùz½Žùùy¬­­!Ë²¡Ñ¿1;;;~ìÿ3\0Þ”RîFQÔ©×ë	Çþ«}.r¶¡ð·,þ=77\'1€°ÖŠÂ%Ê\"À\n!î¹ìt:ÆE«€ñÿ«°Ÿw%P\nxÎ	úÛ§xž\0®Å6ú½ôk\rø\Z\0R=ú‚`^J¹’çùGkµZÝÏû//õë{þK)qçÎ?öŸI)ÿ€í8Ž÷”RÝ¥¥¥üÆõ‰¨=‹QBî·ùùyeŒ‘ÖZ/ìÒZ+¬µ^ä%\0å.e¯×S\0dÅÿ÷0Þr!„ÕýÏà¶ ¼ÐBãL€ÿÛ\n!ŒÂôz=íîW4ƒ¿‡™\Z„Á±Iœhï:ðë\0þ˜.c{ýÙwœ™è¹ƒæ©Ð\0‰Ñÿõë×£BôAJùA_ù¿¶¶†4MDÿ~Þ¸sçºÝ.Œ1ŸB¼nŒÙ‰¢¨†ácSù?$‚—eqw»râ®¬µ² èÊZ«â8VÖÚ@)¥¬µÊ?ÎýíoS\0””rpkmàvC¹KQ2Å£½ˆ°Æ#¥4Nœ‚nŒÉ…ÆZ›!´µV[kµ1&÷æÀí6oüæMB^0	Þ Œ4	‰A(/tÀçÑoü¾)žç€¢_K°ƒ~mAZ8®„Ð\0ÑÑš¦ æ¬µËÖÚï¢¨>;;‹åååAË_)åè_)…\r´Z-Äq¬…¿c­½“¦éž”²wþüùìöíÛÌ	È‹êw}×wÉV«%ööödžçâõ×_÷«\\¯œÀ{‘WN UÇ*è7RPÖÚ@JXk!„¿Ý})e „½À;qWÆ˜\0gÜmÝo;²Öž„—õó¬3enºûY!„pÂ«8g]q]¡¼\"„È­µ9€\\J™È…Ú“[k3\'ìƒûXksgò ¼AÈó~:i`†\\Ž2A{„B±7Àž3¿	à=Sfþ*úK\rßA¿Û`\\8Æ„Ð\0¡Èn·)¥f”RK\0.!>Øh40??ÕÕÕÁØQü~Û__ügŒùœâ%kíN†(ŠÊ±ÿ²ÈÇq,:ŽLÓT®®®J­µüìg?{@äëõºû ÏóÐ‰tè¢ôÈZXkC\0JðÂÝ}\"\0—¬µè/ùºb­m:a_qÇ~Í=f)Öæ¯ªÙ+.ÛŒþ²·ùmˆ‰ð×7Øï\0ˆ­µ{\0ö…-ôÛt¤”×­µ™µ6“Rf\0²,ËRífnË›ò·.må,Ã£bŠ½Zè~Àç\0|ãÏóV\0_þ0Â³\0„€L»õõõpgg§f­QJ-Yk?EQ³8öï£ý¢(¥°¹¹‰½½=Äql¤”¿gŒÙvÑwuuõTGÿÃ¢ù8Žå™3gd–eêsŸûœÔZ+km1š¬µAa!‚­µ¡µÖyh­\r•R‘¢æ¢ôš1æ€%kíBˆkíYkí€ycÌª3R„Üg\\†‰yQè‡mÅûô²èc€aFÀ]®yó0Ê,¸ÛÛBˆV–eèqßvâ´àU\'xÙˆ-/™„Q†áQ1ÅÞ\0û…,Àû0]Eÿ÷\0øŒ3Ì\Z\021ú•R3A,X5Æ|ÐWþ¯¬¬ MÓ4,ú×ZYñU!ÄN† Ò^xáTÌû/\nýææ¦Íc©ù |ä¸1ùÈ‰|h­„‘µ6BÔ¤”€Èó\0kBˆ5kíkí2€kíÒ(¡.oRÊ	(šr¤_¾%ÜãÄ¿xŸâóOÊŒ2þÿZk$I2`ÀùMÏ™m­Þp×·\0¼Qˆ`ý–.G…|Hö`˜9(Öœs0¬CàW|ýf?Uy—ÛŠÅ€³\0„€Ü#Œ—.]\n·¶¶êÆ˜¥Ô€«aÎû±?ïßG¢^¤”Åè>úãxo~~¾733“mnnšûý~ž}öY¹¹¹)666}žçê3ŸùÌ ’7Æ.¢Ã0½À»ñøÈ¥ë#¥TÍJ)kRÊšµ62Æ<)„8ëÒñ­µ‹.m¿Rí²x—¾,ôJ©·MŠÈ‹×½)&üU2\0ÃS4å„ÏoÏ²ívûÀpÑ\Zn»0âÿúEm>kpÇen¹ëÉ1˜ƒµc\nï‡9(6òY€ÿÀ7L‘\0~À—Ü1jãî”@fh\0ésõêUõÅ/~1TJ5‚ XR.c¾­^¯cnnî@å¿Ç‚Rôÿ’âRÊ0ÛyžÇ\'¹âŸúW^yEöz½ÁøüÚÚšüýßÿ}¥µDóÅ´}†‘zWhºq÷H)Us}-‚:€­õºµö\"ú©îe­õ€ÕrŠ~”°{Aõ?Ÿv/Šw9?JÌ«ÚbúßgÊCåûM¶Z‹,ËÐét¦þª„Î\\c6ÑŸ>W4ÛÇ”9(\Z„‘æà¿çå,Àú«~\ný\nÿi²\0ïvÇaýa\0f\rÀãá¯N2xöÙgåµk×T’$µ f…KÖÚ+A¬ÏÌÌ˜÷_¬ü÷\"²½½íWü€ß·ÖncvkµZonnîÈÑqÞü•+WTÇ¢ÝnË,Ëäêêªúƒ?øYzcLQäC)ehŒ	­µ‘wcò‘Rªîþ¾hŒYpÎÑŸ5Æ¬¨#r/äÅÛüßJ©Á&¥DRÄ½©[k‘çùHa/ëÉ°Ôü0±/\n}ñ¶*â^|L•û@žçèt:÷˜ÄûÄ8sº¬As0Ì «;Us`Ü	o\nLg<„9(¯àk® ßá¯jà\\`wù}¶¸·)”-]\Z\0ò\n¾¼råŠ¼sçŽºpá‚Ì²Lj­ù{¥”‘RÚO|âˆã8BÌI)—]Ûß»þù{Y˜”RØÙÙA§ÓAžçoJ)Ÿ·Öîh­ÛZëx}}]¿øâ‹vÊýW¯^ŒÑû}Ïó\\½øâ‹ÊñÜø|A†adŒñãó‘¢îÒöõ j\0jZëK\0Ö1Ðo›ºb­=+„A÷¢ÈA€  ”\Z\\*¥†á@Ð‹¼¿î3%“ªêÇEäea.ßg\\AŸß·a‚^5ƒ0Êhxáwæï4U4;îò\r\0×Xë°Â¤^³\0¯¸,À·OqžðÜ\r;cLB1(0C¶qûIh\0ÈiýgžyF]¸p!ˆã8øÚ×¾\ZcBQù®q6Ïs-¥Ô\0†aM±b­=#¥ü:)å;ü‚?išÆúËü’¿nìÿ9!ÄVžç»µZ­×l6³«W¯šªBïS÷Å1úRê>‚ \n‚ tsâk~Œ^)Us\'ûº£¯çyþVkíºµö€UW„w¶<ÞîÅÝQèÃ0DƒKµ£yŸ™Tl7Jä‹\">LŒ«fÊû0,0iø ªÐZ£Óé Žã‡ù\'3Îø¢DŸ)ØtÆàõB=­9Ð3¬0Dhærs ß\0ðÍSd\0à¿ð‚Ûo¸çÊq°9UÑtä#²åý$4\0ä‹¾¸råŠZ__ºÝnøÆoDZë(‚†1¦îÆ´kJ©šµV	!$úÍ^r\0¹R\n.%¾†áº1æÃÍfS.--aqqyž(\\óQ®”r þÆ˜0ÿXk½EQ\'ÏóxeeEÀþèªÍÍMQœ^·¶¶¦|Õ½Ö:(ãÅªû üô¹ÈÏBDRÊº”².„¨eYvÀ:€sÖÚ5×¼èL1ïß§äýÿ¼Ø·(ŠîzcÌ`\\»,ðå¼,¼£ÌÁ¤~˜ W©ìŸ”\r8Šøk­ÑívÑëõõŸÖ¸¢Dßv‚¼áŒÂ+N¨Ç\r+L3SÁL€Øý‰?ð]S¼Ÿs\0¾ýBÂýi™{î\0wMaSgâÂûJ\nû¯ih\0Èþgžy&ØÙÙ	^~ùå(Ë²ºRªáªø›J©¹ f\041\r\0g¬c­µsRÊ—Ã0|Õ‰d$¥\\‚àë„_¿´´„.Ü³â_Q,„H’Y–A)õçRÊØu{C­V‹^}õUüìÏþ¬ÕZKcŒ4Æ¨(ŠBÙûÌD†¡1&Š¢(ÒZ…¾f­­)¥ê.¢÷BQk½â\Zâ¬…Þ‹ºêÃ0ÜæÿÃaBJ	k-´Ö\"ú²Ð‹¦G¥ê‡‚*cî£„~˜ˆ·øW~k-:Ž_Þùqÿùù)OùßîN_¼]0¯¢z½A¹’7‚ø€oAÉßª|€×\0¼ìLŒFñ g\0Ì¸}íánAeìG×e=:îïžûŸ744\0ä~ÿÖÖVøæ›oÖò<¯»¹û³J©7…o^±®µþFô+/	!š>\Zö\'ucÌ¶Rê‹Q½Á²â¯,,,¨‹/RÞÃæý¯K)÷šÍæ—Ò4•Zë\Z€97fo\0?^†a˜eY¨”òÕöQ†5cLÍÏ×jµzžçOYkŸ@ZÝš1æŒ1fÕe*éy/øÅ4}†ˆ¢a¢^¯C)uOž—×ZÑ²Ð—MÏ°¿«tÍ›$Î“šîL#þå©€‡k-z½ž_Û?ÀÉ,¸íÒÿm;s°àšÙ[\0Þ,™‚b¦ÀÿmÜ9{Æ‰~àOÑ_ù¯*!€ŸðÿsfâôW\ZÖb8ufáE\0Ï£?aÏm-·µHJf…<ZB\'¬Â<õc¦=þBé#þN§SSJ5Ó4¢hÞZ»àøò<ÿcÌ•RO•Ç´}$_Žlƒ €/ú;sæêõú@ü‹¦¡XÔ^ýu´Ûí?ŒãøSÝn÷fžç·’$Ù“R¦N`…ë7h”ƒ~U}#Ïó‹ÖÚ\'…1kRÊUkíùru}±ðÎ‹|¨Õjƒëõzý@áÝ°nvÃ\"äI‚=ª nœOô*÷7æ?Î TÉTýþÅqŒN§3ø¼É‰²‰þ¸¼7-ôë\röÐOùç.ÂÌh¢ŸÊÿ\'NÌOš}\0à÷añû¹ïŒ@·``îËCê\rÀca\0\\Ô¯Ö××Ãv»]SJ5“$™¢hÁ³$¥\\ðcÌG”RßÁLEˆ¢õzµZ\rþº7EB V«¡Ùlbvvv/Ïo÷âç\'¥Äîîn,¥ü…ÍÍÍöööv–$É¾Öº«µÎÝwLi­—Ýôº‹ÖÚsBˆ3nŒ^•§Ë\r+Àóû_«ÕP«Õ4Æ©Ò²v”ŽÙIâ?¸O+ø§AüÓ4E»Ý7’SŸÂwýôû¦Þ¯Ãtk•ýu	~ý¢Â-—ÙØuû×s÷9ñl\0õ‹à‘6\0¾ªÿòåËÁîîn$„h&I2#„XR®!V¥”oÏóü¤”ßP«ÕT½^ÇÌÌÌ`›››ÃÜÜÜ×ó\"6lŠY1Í[,ž+Þ¯8Ý-¼ùæ›ƒF@I’S/w½+Fó~óQ|†ÌŠ/Æ+¦êýóŽËqWßâ{<Mâ?JàSüµÖhµZj.?yøø$€ë2›Îø©†1î]œˆÐP¿h\0Y „W®\\Q7oÞÛív]J9›eÙ|­V[B¬¸dŒù¯¤”ßT¯×½ÏÏÏcqqóóó¡žvìÖ§ûËâ_Š¢ÀAp pš¦„º8_ÞÏ£ú(Š\"_Ì0ŒEÿ÷°‚¼q­r«DýÇùWyÍaïs˜©\"ú‡ø‘#ÐFZâïºì„ï©ÐÂÝµôI˜\0~Wi\09PŒú···kBˆ™$Iæ¢(ZpFJyÖó\0¾§^¯×gff¢¿ººŠ bê÷kÚ}%üå¹ØÀGøišÈøÔ~Eƒ}ó&Â]YØÆ5¶¶O“\nåÆãWõªâ?î~UÅ¿êßÇ%þqûå›ù#&Gáe\0?à¸;=ÒgüúÇú%£~Ñ\0<RÀõ_¸p!òQ?€E!Äšâ,€o°ÖþXEO4›M,,,`yyçÎ; *å%`\'­	˜}ÖÚvÒýËÑí¸ãQ6UÒàÓ\nþq‰ÿa³\rRüó<G«Õ:‰žýäñ%ðï\0ü€›…l@w‡Žmº õ‹à‘1\0¾Âcc#0Çñ|+\0Î*¥žÊóüÇ‚ ø–F£¡üÒ¼gÎœ¤ÏËb?*ŠŸ´?£3n\nÛ¨UèŠ‚?n‘™ò´£µl¦çãÿ*‡r:Òë;®\'!þÆ˜AºŸâ\0üú³|6ÀO<¶º\0ê\rÀCo\0ü¼þË—/‡wîÜ©!f“$Y¬ÕjgÐïl÷\0~¼^¯/ÎÎÎbii	gÎœÁÂÂÂTÿ¤qûãþqM2UÆéË7ISPwñ?ÌðÂa^³ªøO*lö¹¯÷z=t:¦ûÉýàu\0ÿ#ú3n¡?[`wëŽl¨_4\0µ€kñyéÒ¥pgg§!„˜³Ö.!Î)¥.j­R)uuffF.,,`mm\r.\\¬wœÂØïÂ¸9ö£²Gmˆ3ª@î8ÄÚH¿J„’â?©m0\0dY†v»Ít?¹ßìøg\0þw‡|]@zT@ý¢x˜\r€\0 ×××£ýýýúÝÃV”R¼ÝZû£(º<77‡••œ;w333¦ð•çèß¯Ï¸(sš\nõi¶ª@¥Jÿ0iþ£ìÓ8£tâoŒA»Ý~Øì!7)€_D¿.à:úí†}Oƒ#Í ~\r¶~€~Á‹¿ÖzÀ‚µv-Š¢ucÌ·øéf³9¿°°€3gÎ`}}}PU_Œö}ôÒ~ÕÀ8Ñ/ß§˜†.ãa¿Šøµ ï8:ü\rñ*ÓüªŠ¿ÿ»Ûí¢Óéð$I4€¿çœ_ÃÁ¥‡;8¸42¡x<@1òWJ•R®k­¿Wñ7gggÃÅÅE\\¸p«««ƒŽlå¨¿jÑÞq	þ¸åg\'‰Õf7G©Ž?l•þ4éÿãÈFŒË,Œ3MãŽŸ\'Ë2´Z-vñ#§		àY§9ÿ¡xú(d	hh\0ÃåË—ÃÍÍÍºüøÿ°”òÙÙÙYµ¶¶†‹/bfffp\"/õ—Åÿ~	~Uñ/GøU\"ÞãÿiªôGÍ&8ª9)×œ´ø[kÑjµ˜î\'§™PðK%`qw8€Ð\0<º‘?\0å\ZüÌYkW¢(ZÏóü£J©ŸŸ—kkkX__Lï+FüÃV§»Ÿ‚?Nü\'-¸3i,û8£ýiÄü°ÃÓšqB_eU¿QÇè÷îßßßgu?yø>íÿ’»4…èß\Z€G3ú?{öl”çùlš¦‹õzý‚1æRÊŸœ•«««xê©§ ”\ZDøÅ\"¿a]ò&‰÷¨ÛG=OUñ¯27½j!Ûqö\r»>ªJ¿Êª~U\"üÃ˜…inw|õ“‡¢ß*ø×\\Ô¯& §	 x$ÅÿÒ¥Ka¯×k&I2ÁYkíÓÖÚŸžU«««xâ‰\'ë×—â×šwœH{ìaÄ¿ª(§øOkFEâ‡­à¯º\\ï´u‡ÍoK’­V‹Q?yXùQôWü=\'úº”	`=\0\rÀ#ƒ\0 ÷ööjÆ˜™ V„ç1ÿ¨Ñh,...âüùóƒÕï&‰•ô{Y¤Fµ®2…pÚt÷SüÇ‰ïqw<®Z…*¦iÔñõ+ö%IÂ_y˜Q\0þWè7JÝV4¬ xtÀ…¢$IšI’,Ôjµ3Æ˜ÃðsssX[[ÃÜÜ´ÖÅXOýò´º*\"^\\¦·lÊ«ÚjvZñŸÔÓÿ°Â^530éö*&ã$ŒÀ¨ãÛëõÐjµ8µ<*ÔüúM‚â‚	ð™\0¦·h\0~ñæ™g‚ë×¯GZký?)„øp³ÙÄÒÒ.\\¸€4M‡Šò¸Â:¿€GJ9BHÓt0ƒ DQ)å ŸÀ¨†BÅÛÇ	ý´â_5%~œMxŽ£ùÏ´•ÿÃŒÓQÅ_kýý}¤iÊ_yÔXð\0ü?œ	H\n™\0Ð\0<ü`gg\'PJ51óa®j­°V«ÍÍÍÍáìÙ³÷Ìó¶ðMQ<ŠhBA€v»½½=ôz=Äq| qR\nJ)Ôj54\Z\r,,, Ùl¸O±è°,B‡ÿiÇ¾§ÉL+þU†\n+þUÏaÅŸQ?yx€@%ÁžËøõ8@ððråÊõòË/GZë!Ä€KBˆïh4\ZX\\\\ÌõÖÒwX÷¼b„vvv°½½=¨÷‘¿7	Bˆ€Ÿˆ¢Íf333XZZÂÒÒÒàþÞt;ŽËB‡ø«ÐŸvÿqLõ;ñŸæ½OÊ¬äyÎ¨Ÿ<húÕú÷áµ~ÀgÑïØu™€ba ¡xø¢ÿÛ·oJ©†µv6‚e­õGkµZèÇþ‡-å;Iü¥”ˆão¼ñvwwÑív‘$I×ZûcÌ×\0lI)_SJeý‡[eŒYÍóü­I’¼·Ûí¾½Õj…{{{ØÝÝÅÙ³gQ¯×«³Ec0*ÂFü«ô&Z¯Òç$‹§ÿq¦ªÛí¢Ýn3ê\'÷“6€/\0ø\ZúË÷¾ê\"q‹~\'¿À[\0¼Ýmoq·\r\0?…þÂ­B&@£?$@h\0:d·Û\ró<o!¬µg¥”W|ô_«ÕÍ~Æµô-ŠØÚÚÂíÛ·±··‡8Ž;Zëÿ¢”ú„ûá¶¬µq–e‰1F€RJ\n!jBˆÏI)ÀZ·Ûýö$I®Æq<×ëõpæÌ,//V\Z,Ö!ŒêêWEüSÐ7Í}SìwXñwŸIÆ¨JÍ€1{{{\\µÜOöüg\0`Û¸ ¾Þ\0(\0/øc\0³\0–\0|‡ÛÎÓ¾<à»Ð_,¨åöãH\Z€ý_¾|9Øßß¯\'IÒŒ¢hÑZû]Q5}úÝGÿ£Vôó¢àMB¸~ý:666°¿¿oò<ÿ¥Ô¯cÞÐZocö1<ÏS)e&„0\0ç¹´ÖJ©š”rFJyÓZ{\rÀ÷z½¿ž¦é·$I\"ã8ÆÅ‹ËC•¦!VÙaErUÄÿ(SýÆíW•ÊÿQ÷Ÿ¶RQð‡ý/Žã1Öÿ\núkµ¿À<²Ÿð«\0Þpâ¿ï\"o_ˆçÓïÂ€\0ýV¾\r\0s\0n8óðQ\0ßþÂ?Gå\0ü)ú=¼ñE„àá1\0­V+È²¬EÑ<€Ekíkµ\ZæææÐh4FFÿÅÂ5Ÿ‚‚\0o¾ù&666ÐjµZÆ˜_–R~:Ë²[ÖÚ­4M÷Â0ìFQ”H•RZJið­µªÕja–e5gH¶µÖ»Bˆ-­õWvwwTk=“ç9ž|òÉ¯=jÕÁÃ¬êWUüCØ\'‰÷¸5\0&íÓ¸Tþ°çw,P7¿¿\0ð›îï?ð“\0Öù³},èø\0ŸppË‰«ðý[¸-p[ éLÃ.€à«\0~\ZG¯¸\0àÃ.›¹çö‰‹Ñ\0<\\\\¹rE½ôÒK‘ÖºÁœâ]J©‹µZ\r‹‹‹c§ÛÔZ;ÿ[·n¡ÝnoH)ÿ¥µöyžß´Ön\n!ö”RÝ(ŠÒÕÕÕlmmÍ<÷ÜsóÕ«WÕææ¦ÜÚÚ\n1mkmÇZÛ6Æ´•RÝ 6ö÷÷ÿ¾ÖzÅZ‹\'Ÿ|Y–\röÁ·\'.ÎP˜vU¿Q\"=M´=Mf ŠxW“/ÞgT[áòû,2l?…È²»»»÷Lçœ2}»	à\"úsª«’ø}÷Øwhù—Ú­Bì\"ÇU\0ËüÅ?4t\0üSg\0o8ñ/\n­¯¾÷?J[0\0ÅL@ÇEèm÷wìÌÀÏ8?\nßàœ	ðY	fh\0žèÿÎ;*Ã\Z€¦Rj^kýÁ0133ƒ……äy>2ú÷Ñ·ÞÛ·oûÈÿŽ”òÌ²ì‹ZëëZëÍF£± {þüùì…^ÈoÝº5ªyFî„\'æ™g²­­­´ÛíÆBˆÄZ›¦išEQ·Ûíÿ\ZÀ!Ö××‘¦é@¸ŠS§]Õo’¸Wÿ£d¼×\0¶Ã²1Eñ/wX,ÖL”2•÷Á×T¸B¿ŽµöîdûíSFOŸðî„­\0|‹KÃªŠ}À5wâo¸ïÇoø;«üŽ®;<é¢¶·M™~¾ài\0ïå)ã¾ø9\0ŸrŸýFAü³RÔàk\\ˆ¾}Q^ê²IÁ8h\0ÿ_\0ÿÇ#šÂ5\0ßìöoÇŒ”€à¡1\0½^Oåy	!f\0Ì!ÞU«Õ033sOþaÑ¿ÜV«…\rìííåBˆ“eÙ—¬µo\Zc6„{F£wéÒ¥ü¹çžÓ¶Â\0²µÖ!2\0úÒ¥KzggGc´RÊdYfƒ ø—ívû+¥šA`mmmP0J \'‰ÿaŠÿªDñe!/¿aÙ”r?ì¸—ß[Ù4øÏ.Ih­\0ZÑÃpbÑ¤1»»»HÓô€_t\'8à\0ÿãIlø\0®»,pÏsÀOTxŽ]ä·áNþuô+º¿âN´Ñ˜ÌÁ¯ ?]ë¶;1‡î¹n\0øë\0¾±Âþÿ{÷~{\0>í2	ß‡~±Ù4l3û0¿ãÄÿºûüvâ?MŠ½¼zŸ_ÐÇþ¼û.e–ÀU\0`¦”à0\0\rÀé7\0I’„yž×…3Bˆw!–ýøÿ(òQpâcÌoøcÌu­õ¦”rwuuµ÷ÒK/e¯¾úêT-3QÐB{ùòe»µµe{½ži4\Z\"Ë2Á/µZ­Ÿ‚ ¨Õjh6›ƒŽtåÕ	Ç‰ö0ñW7IüË\"^Žè«FðþØ\n!}¤”Ãð@öeØsxÜ4½?	‚à¿XkE–eßžeÙÕZ­6˜>Y6I’øe{_ð.\no»å\Z€øH…ðh^C¿Z:t\'ÈÀEæß1áñéNªûNÄ3·-Œo¿ú\0_rr£`\0b÷ÚûöýËNôo¿ëûlEÑ¸àß¸}>àoEŒ“ø¢ËÝpÆo·ðÙ¦å®Å½Ýú¤û|Ú½Öß8Âþ¾ý¡„[èQîù™ 8Ý¸êÿ(MÓzE³Æ˜oª×ë¨×ëƒžÿãŠÿ€~÷¾\rìîî\"Ë²‚ ø½4Moäy¾)„Ø[\\\\Œ_zé¥ÌZ{è~Ù>pùòelmm¡Ûíªz½Zkÿ4Ïó§ö÷÷?Ež~úi¤iz A¹à(}ô\'eŠâ]èbú}ØšÃú!ÐëõÐëõe™BlXk—ú~§6X”iX/„@»ÝFš¦/)¥þsÇ{\0¬âZë3ÖÚw5\Z{Þg«ÕB¯×ƒ­_Bžõ5w=r\'âOøž	‘pàÏ\\wÛ‰väSeaý±ÕîN÷\n\n)ÝIì¸Ço•^{Î=ç$|êÿzáñ‰»}ÀNx¼ðÜ{OÝ{ø\r\0{Ê¯Ç½þ¹Çà””º¬‹/øÛ+DÔGí·oÜóÄî»ºÔï¡?´óöC>¯DXëkîùB\Z\0\Z€‡\"úïv»*Ë²H)ÕBÌcÞê;ð[‰Ï˜yžc{{ÝnWK)3I’[ÖÚÍz½¾_«Õz¯½öZzñ/›€K—.‰;wîìçyh(¥~;ŽãoØßß?{ûöm¬¬¬Ü3=pXt|˜…s&eŠ¢_nœ”¦)²,ƒb°ÞA1;P~?¬ÒívaŒù#¥Ô\'1)e-MÓoÎ²ìj³Ù”Þ”3¾Û¢1æÏ¬µo:1€ekíŸ¤iú.)%jµÚ`÷ööížÝ	loˆˆè7AyÀ¥1ÙèìâîT©ºÏN…üvAø³‚èŠbÐÅÁ°š»ÞA?%?Ž¶‹·Ü{ØwWÎ¼Ti{øô§/údšî=|ÕŠÏ4úŸvïýa“³ð9éOÝ1»SÿÃFþ£L@æžwß}6\0ü€r„çýF\0¿î€7š 8Í MS¥µŽ¤”M!Ä¢Rê|Eh4\ZcWí+F™[[[~½÷ÏXk¿f­Ý²Öî[k»—/_Î®]»vl?o.\\¸ÐÛÛÛÛ³Öni­oAðŸz½ÞOïííaiii ðÅ…ƒ³\nÞ´=ý‹Ñ¿Ï@Äqì#ñ)‚\0õz³³³÷ŒÙ{ÓÒétÐívSkíð|–e›\0b­uC±`³×ë=«”’>ÓQü\\Üëµ„Ÿ±ÖÞ°%„°ZëDJùEcÌ~žçóaŽëãß)ˆ¨7\0³îäùæà‡\rü|mÁçî$\\%‚Op°èkšïR^2\rþu3Lx\rw‡Zî}ä…ãQe?¾ìÄå–;3.:üË\n`wëvÝ{ØDÌú¿Eµú‹‡\r\rà¿8Q.Vûwsë>Ëž{mwœ_ÄtÅ¡Ežp™%_£¢(/4\0§š«W¯ÊÏ~ö³1&RJ5Œ1ï	Ã0¬Õj˜½§\0p`¡Q®”r°°€Oh­·…»µZ­;77—V-ø›ÖÅŸ?>ëõÙ¢èŽâÓZë«NçéÝÝ],,,†/Š™€ª+åû»<ÅpÔã…èv»>ªþKÉÝ²ÖÖÓ4ý¦4M¿#MS9??±Êó½^Æ˜?5Æ|ÖZû†1æ–”26Æ4¥”©”²¦µ~’$OûT¾ÿ¼’$ñS#ßBìXk·¥”wÜ~JcÌŽµö•<Ï¿Þuiu¬³BôíE;v\'Ï×1~ßGðE·¨¾rZ»ð¸²ØŠ\'úâf\nÛ¤Ä›¸;eÌïà.«VyÞ‰÷î¶‹s™ïðØ_w¢ô†‹†\rúÓ‹’?\\!Òý¤37ÜmëèÛ\\:¥§¤¯¸ïÔž;ö~žÿqŸ?|M@ê>—–ûœ>wÐ\0ðVô‡Ë|–Œ\0\Z€ÓËææ¦¬Õja»ÝŽjµZSkýN¿ÏÌÌÌÐÅ]Ê)ê/T¯	!^ÔZïèh­ãõõuýâ‹/ûÀZk…ù¥K—’4M»Bˆ=­õ6€ç“$yºÓé`aaa ÆÅ•§]˜§œÖ5\ro”ah·ÛÆóÛ\0>iŒÙ0Æ´1¡”ò€7ºÝîççç®ÂbIZ±m­Ý°ÖÞBÄRÊ¹<ÏÃ –­µ6Ë²A\ZßïKaä\Z€Žµ¶«µî¹R×ZÛµÖÞr³&	‰)DÑ¢ ‚×\'|T×qwÝôÃDq»¥(þ(ß¥¢Ð˜\\p£µÈKˆ*¦~ê¿ë¶ž;v\0/aü¿¿~öÃ–{ýÄE—Ÿ®`\0~ý*ú›…lÇmwýo¡?¥ñ´ñ%Ü-öô­uOJ@} qŸOÀŸøL?ÃÃóvgÎ¼8¾¡‹Ç\ZÉCpüìíí©<ÏC¥TÍS·Ö^ÃðÀb;ãÚëú\"³8ŽaŒyÕZ»A7‚dvv6+7ø9npéÒ¥<ÃDkÝ5Æì+¥>“çyž$ÉÐi‹Ó4Üñ¢¯µ,E<jÑ£QF¡Ûí\"MÓW1ŸIÓô\r­õ+Zë—¼’eÙ«Æ˜Ï\Zcþ Žct»ÝÁ±Îó|ÐØÈmí<Ï[QuŒ1m!D@ÛÓÖZ[­õ WC±%³†Ø°Ö&.íŸJ)370Îóü)ûxñôs«7&yL»Ÿöd¾?Dxj\0¼™™d\0náàœq;EæîØçžûÍÎ¤\Z„w‡]ö]T¼ë._­ðø]÷®¹¨úu—Õ¸~]Áiä‹îØÜ¯¾ú¦`zî˜Ý8Âó=‰~H„þ\0u‹àÔ\"²,“Zë@)UB4¤”ç•R¨×ë#ÓÿE!•R\"I/>_Íó¼Çq/Š¢leeå$Rÿxî¹çt†yžç±1¦`×s3Ë²AJ»(Òeñ/Fì£@±Å°Rj`Œ”R·l|Ÿe™ÕZß±Önh­o¸‘çù\r!Ä-­õ†µök~}€¿tÏi1‰\"KÓ4\r‚ OÓÔG¤™ßß¢a+\Zkí\rkm\"„È¥”¹R*BäI’$Æ˜ÛGQí„)­ à‡]*µUxìq´W-îwÂ}·†DþÓf/Š­j‹5©ûÿ8Šõ\nÞ8Ä…ŒB¡ò³ 6Ü¶é®ŸÆëöa‰Y—“Žž½¡Í\n&àÖžï¬3\0a!@ŽœŒPÆ˜Ð­¾wQQ÷€*SÔ´Ö¾Á„oZk{Bˆ,Žãì­o}ë‰§¾¬µö‰\'žÐN\'SJ%ÖÚÀVžçO¤iŠz½>Ø÷*…€Ã€ÿÝÝ]ôz½Ì³ R®5\Z\r4›ÍÁª„þøøçÌóZk+¥l[k÷…{Bˆ}\0ažç5)åžÖºëï›eÙ™n_¬Â¢?}Ïº5¬é¿-f#üß¥¥’w\0äÖZ£”ÒB›e™—Û‡8ìÅf*Ú°‡¥²{¸wÜZz%ñ?àŸk\\\r€vÑ÷Q²»%ñ×…c—9q®º¯¶ôØ¸Âã}¥»/àîÎ‚˜f1‡¶{-¿ªÞ‰%$qp¶ÇýZUÏ”²Z{Gx®3à3\0¬ 8}¸@eŒ	ƒ ¨YkŸ\n‚\0~À¤àÝZ[ì¿ŸYk[Bí¢Ló±}ì¾Œ}ÕëuÀ!üÉ±ãSâ^‡5»gŠ´R\n[[[èt:[aþŠ1¦åzã?Çñ³yžG³³³Å”{?|ë‹?Œ1@ªµÎ1ùââbææô§ÆŸ†ßç Ê³„{>«”\Zj‚&¬ØÒZk)¥VJ™âx¾*ëSv[µQóñS¬8ŒˆöŽQü‡	ë¨÷ÞÃÁé†‡yín)ƒ`Jb“Lù|ÅÇæQ¯jÔlá±UÇ}¾ˆ~1¢/þüVTkþtzGÌ¸õûàSïÏÕ@ªfÄ\0\rÀ©fssSÖëõ ÕjRÊšµö’ï0†áuÞÇutB•	!ŒJ…ÖÞÇµb}„ì^3&ìÃ²ã\"ÿb‘ãþþ¾‘R~¬×ë½â¦7J)åžµvqÿûý\\úb¶¡h\"Œ1ƒÂ1)¥uQ¸•Rj)¥6ì0Íá+¯Pxl@&„Ðišš4Mõ1I¦4\0åªúxŒ\0U¼ó’`õDoK\'ýQÄ¸wèaÚ×ï–Ä¬l:‡Øÿâç¶_áþã>·Iì\0ø5ô‡\Zº.ªýC\'pß|?ãÓÍ9)3pÔá‘s¸»!3\04\0§“$I„ÖZA\n!\"cÌj¨Õj\Zµ´®ÇÏ±B„>Rõ—Â¹€ûò«µ¶¸Xm˜Øš²7®g¿Ö\ZívY–}Uñ5cÌë\0v­µÒZÛRJýY–eßÑétæ½ðÏéÓð#Ž›OëÃZk&õpb¤ÿej\0¤B“eYy½(H1¦_µ\\P7*PÝi)Ï·?ŽïSQdÒæGÃ¾w‡ˆâ1ëqßO:Ãöè;@Æè/Ë{ Žƒ+ù=Ä1hÍYÜ;@h\0NqKcŒ²ÖBˆÀ¼Rj‚Vý_V¥”7	¡¢.„Œ1Rk-ïçûp‚¬Ü®!¥D±1Î°)€£2\0ÅÇt:Äq­õW¥”›ÖÚ[nþ¼Bè<Ïç¬µ/Æq|¥Ûíhž4®‰R1S0n¢C¡—Æ¸‚Asˆ~RdéŸ#©xß£ŠõqTyÎ£f/†õ<(OE<ìþW™ÅpT^@¿hpÛ(¿Œþl‚\'Žùõ\Zî<¿…S¸×óçæŸoù½G\ZŽ¥3ÆaŒQJ©ÈZI)—”RÃpìêsÅÿ)¥&@k}AJcB­µºzõê‰wÂBˆ,Ë¤µ6ðÅŒ\0VŠ‹åe©Þ^¯çÛâ~5Ïó]­õž”rÏïíi­wŒ1¯çyŽ8ŽG®ê7J¨G‰xUñµ’ŸŸç¹!ÂÇ!ª÷sŒö¸Ÿk’ù‰áµº#ÌÆa»=!C4Œ€¯âîôÃòöæ	¼æ‚3aA@ï‡xzñÜëÏÃû  8Õˆ,Ë\0ç¾g| ²Hûéç×k­Q¯×¬µoB4‚ ˆjµZ¸¹¹yâŸÙÕ«WU’$A†5!DC1\'„8ã‹§iå;L|]!_àMcL×k­{µZ-QJÅN(^÷…úEq¶\0 µ®²üñ°e~í„hßoët:ØÞÞö¯ŸŽˆÚ\"DÇÙ?H“q?Ç™G½Î¤ÌÉƒæ¶3¾…³ß|È[\'ðšóè§Ï‹­tOúâ£/þu}…Y\Z\0\Z€SÖZZk•‹žÏ!¤Ö`XjÚZ‹F£0!¥|\nÀŒ”²™eYmgg\'BœØç&„×®]SY–ERÊ†RjÎó® êµZížªüI•ÿå¼Â8þ¾µ6BäB†aÇq¦µöUüÆäy>0\0ÃÆð«Ìª8´Ê¸×ÚÝÝE«ÕšF¬OZˆŠu!§éDh+Dúâ^ó8†\0îÅ)yÅ™¾\'ÁzÝ÷ Ÿ‚÷êœt@:³Qs¯¹ˆj‹4£Q\Z\0\Z€Ó™0ÆHk­’RBˆ5ßèÆGÎ£D©h\nŒ1˜››C£Ñ€âA¬(¥æ³,kt»ÝèÊ•+JŒ+$8bô¿··j­.zX´Ö^	‚\0ÍfóÀJ|eÓ2¬à¯l\n|@kmÇZ›k­3)¥ÃÐA ûoßäBˆ}k­öÝ÷†eªø°Ä4øŽŒÇçoöAu6{Q>å=ˆc2bÈvRtpp\r†â†G›+?ŽwºßòL!pRïS¸Ï9r¦cýýŽ:tÙ`ôOpª¹zõª´Ö\n_<g­ó ˜}Œ@†˜EEõ<Ï¿ÍZ»EÑ‚”rææÍ›\'òBÈW_}5èv»Z­6/¥\\ðV)å{šÍ&æææL‰+vì&öÃŒ€¼\"u=L’$FJi¥”6MS#„ÐÖÚýF;C—ž…±ã\"úQY—2~áŸ\n¢‡\nâw\\4\n\"z\ZwšÇÅ‰1âTC!œ8ž=Ü;…±8ƒ!;¡×}úÅ…ÎÔpwQ“ÿ9ô›}Ã1<w}ˆy$4\0§‡V«%šÍ¦ ¤”€Yo\0ªF«Þ\0c°´´„f³	)å·‡axNJ¹œ¦él«Õj\\ºt):Î¡\0!„x×»ÞìííÕ”RsÖÚe)åšÖú‡jµZ0;;{ 3_Y‡Íù&¾S 1ƒŠî ¬RjÐ€±ÖæU:	Ë²Söó?®è¤¨¶Y8yŸ–aÕÚ…Ew\"?J$\ryßÅëòÇÝoÍ<NÃ¦/·“šø«\0VÜgàMÀqøqÿ¦Ë8,¡¿\nà;É\0(\Z\0\Z€S1F„a(•Rb¦X9ï~”3\0ZkÌÌÌ`qqõzýŒÖú#Bˆ³A¬\n!æwwwë—/_Ã!Ä•+W‚Û·o×â8žµÖ.+¥Îø`†ïž,\\Üïbþª3\0\nÓ3ô;\rm¬â÷óaÑ{Õ~˜Q©B’$÷³ßÒ(0î7[Ÿ	ŸæóÍG<‘/bø‚/<«Aü¥Ç“\"ÃƒkÊó­è¯ª·æ„yÇ[Pÿôÿ>zL:S£ø?ìpŒÄqìk\0¤µVhú)}Å©kÃŠ\0‡e´Ö8sæºÝ.²,ûµökJ©®”2íõzù;wìåË—!„È¬µ‡j`\"„ïz×»‚×^{­Öívç¢(ZUJWJ]²Öþ`³ÙÄâââ`\\ßÄhÜÜÿa‚]^\\Ç™€A/þ ly™äQ3\rFeO&ý¯Š¨§iú ”¿\\Ø§*ŠÖi;N7\"?l \"üÅëáŽÿIg\02ÜÛ¡xNrŠo„þrÅ7qw=	ƒ~3¢‡_#À§ýá©g2Îø+\0Þ{Lû¯\n¯EÀÀé#IQèž\'…M!Ä`\n`1ú—ð\rwŒ1‚\0kkk˜››«YkÿvEï”R^l4\Zçâ8^ØÜÜl®¯¯×>ô¡Ó\n!Ä‡>ô¡à©§žŠnÜ¸Ñèt:óa®Ap1‚KZë¿_¯××–––à«ÿG-_\\eàµÃ¢¡{n5Ó`*Uªð˜8ŽOKkQ~ñÔ$±:Âï;Ž;çå$>jÄQü~eRFEÿ~ßçOøõß\nàÇ\0¬£ßZwýqú:¶Ø6ê¯¹ŒÂú÷\\t‡gqßCŠ?3\0§k­‚@	!ú«ÛÈ\0ŒÓèbe}1°°°€4MaŒYjµZ/‚–ç¹¬×ë*Ïó­ÝÝÝýÏþóñ¥K—Ò÷¿ÿýú­o}«ùØÇ>6tŽœB\\½zU]¾|Y}á_ˆâ8®+¥æÂ0\\RJ]PJ=aŒùÉz½þöÅÅEÌÏÏ¦á‡(ª¤ù‡uôun5¾aC\0##÷qK)WüGÓ þÅh¶þ0~ý+D‘ÃR÷‡ëQ>óŸQÇiñ>ìÃUôWTü‚€ïàîj†Åí˜Ï¯ØäÇ§ýWÑŸî÷^\0?…ã/¨¬Süi\0\nà}4_ùaV&ßrWk,Ë°¶¶æçà_j·ÛÿX)õ\0> iŒ¹Óív÷’$éíìì¤¯¿þz~áÂ}éÒ%\0aÚ,ËDš¦rmmM~ö³Ÿ\r²,«i­ëõz}ÎZ»Á¥Ô[´Ö?U«ÕÞ½¼¼ŒÕÕUdYvÀ¸i¨36Be\0ìh­µÖH)m­V³Ýnw¬ ©#˜*ê%þN‡‹ŠŸ°[Ç Š˜sÈýN~-€ý	&à~51úë.úÿE\'ªug\n¼	ðK÷³X\'¡pwžÿîŽùŸð\0~bBë°¨Sœ£xÜÉó|ðÅ”R\ncŒBŒœPeìÚg²,ÃÙ³gýÁ¹v»ý¿B|,Š¢Oæy~ÛZ»þµ]kmÒét2!Dñd,­µÒ„aX‚ †áœ”rIJ¹&¥|¯Öú\'Æêâââ@üË‹Uÿaÿó«ù¹Ûz…Õ\rí$!?l/ÿIƒÅ.ƒ§LH;˜~1¡Ó²ïÝ\n€£¼0zØ¨uÈýö¿•ý<F­ÂïoÛ¼Ÿ×w ß_ÿ—\0¼†~¢²	Ð…óGYüë8XíÀø0Nvh™âOpê}íÂGüÃÒá“Œ€¯ðÉ²«««‚\0›››3­Vëï¦iúmRÊß«Õj_ÔZïh­[ÖÚ^­VK…yád#\\wÂHJY—RÎ	!¬µo³Ö~À»çææäÒÒæææ¦é`éÞ¢9Œø ï_Qðò°Ã‘?!e™}¥þ„Íbüºôri×*€ýûðZÀð©t;GÜÿûtœ†e²ûü¹=àÿ\nà?ø]göóÃ¦(Fþ~žÿ²ýïDàÄÏ«”\Z€Ó¹\"@×(š™V+_hŒA–e˜››C½^ÇÆÆö÷÷ßÖëõÞ¦µ~ÀËa~À5kmÑÅÃZ+¥”‘Rªf­=à½Æ˜wH)ßQ¯×¥ŸrEÑ *>ªø—§–\"ò`˜àûcXNï[ gÂç`Ge’$9õ_£CÉiÙïª\rm{\"oOˆ¢Íöý~,|Úh ?Uï\0¾à/|Ù\0?;À^~ÌýöÂoð>—¸ßzåÍ\0‡ïh\0Nmà¦…mñïb&Á§å/^¼ˆùùyììì Ûí¾-MÓ·¥iúkíúéD¿6zê¸®ÁÏjÃF³³³˜››ó‹ô^o\Zñ¯b¼©pÏ­0|*Û)nåLÉaƒvŸAi·Ûƒø{“\ZWÄ;Y€I‚s”ªûÖ˜Hú0Çä~š©‘ßsœ|ÂI¬¢_ xÕen8³eÜwÎ§ý—ÑŸæ÷ ö5¢¬Ð\0<ÊÙƒ±ç³~=Ïs4›MÌÎÎ¢Ûí¢Óé ×ë!Ë²%­õRyÙ\\!‚ €R\nµZ\rFõz}PhX®²\'þ£TÛÞ! rí’¥µV$I\"´Ö~\Z¥BÅü¨ç«J·ÛE¯×;õ_\n÷éáÞnr£9>l@yïÇ±óIÏr„r¢Ú)ù|æqòSËH\Z€‡öd~@ÌFUÏûë^˜}]€_(Çƒ(ŠE–——Óí\nSîà‹‹Â)”³ÃöaÜ2¿U:\0úÛý¬!Äœ”2BÆÕívUžç€TýªÉ@”k(cªºÝîýJûßSŒé*íOrH$|b¿­SöùÍàà’¶~Ü¶ÈÓæýüi\0È±¢G	ý°ùôãÌÀ°åaòãŠÿú=Šýü‡	ñµ¦MóÊboó!Ä¢¢!„ˆ‚ {½^ µVJ©Ð*®!}¦o€~•¹Ãà	ÆI*•#àÓv2œÔÅ°†ãébh‡sqˆsZy_N2Í¼ìÞXýwëÖxÊK—&€àTã§¶¹7º,þ“¢þq·•Ÿ£8K`Ô}ÇÍ/§ø‹·EüÇÍ\0à\rÀY)å¬1fNkÝ‚ •R*cÌ¬bÀ¥âBJUçþ—9AñŸ$*Ñ!W%µ§ô$X¥oxL@ãqÇÄ4œqY€ÜíXØp×gÑŸGOª?š\0\Z€Sû%µcQlQÈ&‰ÿ°Ê÷IF`ÔtÃQ¯=ª³ß´â_Î@ŒZ¸ÇW(¥\ZZë÷H)7\0´ó<­µJ±\"„XðV_¨X®eyÐf?Ä	¦ýå±Õ›þ°Bô°sV5/5­`„ácèG9nÅqø“œÃþ´Ë,£ßô§»…uË\0.óÔùP\Z_\Z\0A0HÉ\Zcü’¶÷,ë…p’øVÿrÚX4?ªû`Å®}•ÅÒs\0@­VCEˆãøë…_v™’y)¥´Ö®H)/Zkß†áØ…”Æ‘$ÉIŽ‘GCÄâÞ¢®Ã\nh•Hö4GõçFy]÷i–A(.bß‹â’­„ÐŸ6×q¯ÕsÇã,úís90žq „àœ	û©#„0Æ˜Ôê\r‹ò«Žÿë*\">NÜG™i¦ú\rkò3ê5üíZk4\Z\räyþõ\0¾¤”ªcZèþ-XkÿZ‹Íf³¼z`ùX‹!·[ùŸt=jú¢ï–V?äsÊÂsTÝÓdªT³uQ—féñÅ¿¦_¨|Ì›\'|œ~\0À-g4w¬V|?Ïž‰)ü4\0§Þ\0dYf‚ Ð\0b/xÅb=_t7¬?ÀaÄ’\0W­æ÷JçW‰ö\'])…™™Ùëõ~ÌZû¼Rê5kí*€§•Ro)‹¿lñØ€RJZk…1FcDš¦jÅ°²4N¹äû\'dOŽ²\"à¬;>å>êˆÇÝäÍâñÓd}–ü×è7ÜyÍEýßìn\'£ñËš\0\Z€SI­VóÅýôbŒ´Õ-ŠØa#ÿr]Àqˆÿ°¹û£¿ªøº^|Í 0??&Iò<Ï?à§*ÓþÃŽ›F(„5cLAÔétj­VK¹ˆª†“o\Z2lì¹8¥ë°B4IÈ†Õœ–èß¿‡qï½~DÐÄð©tòÇÝsßwbRW;U¸X05ÑçÓyô{ñÏš•)¶%æ\0\rÀé£^¯[!Ä`³Öö´Ö#‡\0Fu¬\ZI+5þ~˜é|‡uŸb6ÄZ‹ Áàzñx\r;F…g…Æ˜Ž[I0@œu¾‚uIZ1\"ŠÐ¯öVS>_Yüc\"è£ìûýÈ~Œþh¢÷ÃÜ-9áU¥ÍòÒ”Ÿ»ïo¹ýž4º,Äî¶<žw×ë<žq)@@púRÚ,ËŒ\"Bt1Èó|õû£\"ÿI¢>ÊŒæòs–\'š6ƒp”ž\0Þ\0!û5b± ¡M‰¼aÈóÜXI’d/Ë²¼®8®ÒŸ¼‰JTppü¹(þ5÷ú‡þ#ô×T¯\ZqŸ–è¿I7*€Ãf\0–pï\\z/þ5Ln¦#Jë×@,¾Ê\nŒËèðE…ë,à;YŠ?\rÀ©fnnÎv»]\r@!´1f`\0FQµ˜¯ªø{Á/‹jùõFªm~“5(¿î°>þöaûë¯»þ\0—vww¯c2yuq·›Ú\0~°JÒ¦°	wÙ¨ÉE8˜‚.\nPÀS‡ÿ ‰ž­pÿÓdŠËÄ†D´‰{Çð§a­ð™Õœ(øãîW§›ôÙyÁoº×Ÿsûü\r²ÊåÌˆp=à{x<Ñ€¦	 8µ<÷ÜsfqqÑº\09€=? Ø°Ç/æ3It\'ý¯A—/G¥ãËB[¥Àp\\-@Õ¬Á¸¬@qŸF5M\Z„I‚ÐZûý\0¾À+è/ãZ°àÝ¨V0ïCâ¶Yw}Rt?Î]+ˆ_%m¶¢(°…azjB]žFw˜!ŒãÌ\0\rÌÒå35£zâObÀ[\0\\ÇÝ‚@Üß^!{£Üg¼_Ø÷5\'êïªðú?†þjy/ãî\"[Ð_Z·Á³à‰Ñ)\0Ò\0œJ¬”Ò¸è_A°íÇ´ËÑ³Ÿ\r0©ÿAö¹p®8Ó ˜r/¿Î(#pÔa‚aÿõ^G	ù¶,Ë°³³S¼ýi·MË.j‹Ýï uâtÎ	Â¤®l«áSÿËîö·Tüí…¥ÌAÓ	Ù“cçWe+f +ÜþÒòñbHdÒ{Ÿ)DáQáSú“x€/¹Ï®çŽÛrEÒ}îyÁ@¬xGÅÇK\'öÏðtwß\r@^0„àô¡”2yžû\Z€-o\0Š=ø} Šø›ŠW~›ï\n˜e’$,ö#¥D¨×ë(›’¢	–8ŠàO3aÜkÿ£ðu\0¾ÀÇç.‚;ë¢¼IY€.\nÍÑ~¨8àQm%5µÎ»ßaÓEÏç\0\\šðØå‚`ª‚PÓåñ÷iç)FðÅºf Ü{¼áÞ»qÏ7ë¶*¯ÿ\rîsƒ3M÷y¼¯Âc¯ºÏ­æ>7Ÿøqœl@r4ÚNü‹Í€\rÀ©Ë\0X!„ÖZgAt\0$ÖÚš/5`šU÷†‰¿þv»v»=_Qïÿ†!êõ:fgg¬X6“Œ@•jÿãÿíííãÏ‡ÑïÀö:€=ùª\r|À›NHbw¹à¯U|íyyê‚ˆð-˜¼Öú9wÿ&îÕ50~ö@‘¹’y0QE…×·îrÎ½§K¿æ¶´ÍXEõ¹ðÐŸ;ÿyÜMÃª~†\0þ.€ÑoÈ¡?d4ÃÓ×©f·”  8}„ahÒ4ÕÆ˜ÜZ›ZkÛZëZ–eˆ¢èñ/÷¹¯Ú}¯,þÖZlll Óé MÓM­õW¬µ.a¬µ+ÖÚ3iš^èõz—{½žœE±áN10måÿ$ór\nÅ¿,FÓòV\0À§ÜvòŸkÀ·º“YÝ‰XÃ€ï¬ðø\'vûî9R\'ÀK¨VÅ>‡ƒ)x»é÷*ægwûÙ{²ê„¹ÊpÌî˜)\0-Ü-¨»àÛ+ÿrƒ×Ðû¿:åç÷6·‘á¼àk\0n¢Ÿ~ŸsÙ±w`º\"×ãbýi—Å,\0¡8e4l’$:‚@jŒÙ5Æ¬dY†Z­6è\n8lû*Â:Lüó<ÇÖÖÚívÇZû\0>!„ØÐ6Æ$Æ+¥\04…sÖÚ·u»Ý¿–eÙ»´Ö˜	ŒêNxÒâ?êyžc{{{èz\n§€u·†¸é¸æ¢ç¿Q1\n~€çÑoæÈ9g\"&¥áý¼õ9Ü­®ö×g+¼ç‹¸›>qwèäƒ²@†Æ7¸÷þ·ïow™ùŠÇ/tÇ/›\0~ÀgÁì¹ï‡ïN¹\0àŠûWïã~Ýt€œ\0\Z€SËÌÌŒ‘Rúi€©bÇ¯I?,ª>ŒàÇü­µØÚÚB«ÕÚðÆ˜Ïåy~Àn–e!Dæ„TYk#cÌ|ÛBˆ7ó<ÿÁýýý«RJÔjµÁsW™¡pâ?é6­5îÜ¹sZÅÿ8x§ÛRL×¹ðÝ\0¾	w«î}„Ë\0~“Sáßà¸»(q\'öUôìÆUñûV¶¿\nà‹8ØÏþ¯Lñžpû:í{\'\'Ç—ü<úCb[Î\0øù÷Ò}/æÑŸqóºË€=qöË¸Œ‘Ï\0Ð\0Ð\0œN\\7@“çyEQf­ÝÔZÖ¥/Î§ŸFü‹Süüã•RØØØ@»ÝÎ­µ¿lŒù4€7µÖZë–”2•Ræî¹¤1&D¬»£µN•R¿•eÙÙv»ýNo\0¼ðŽ+R<ŒøOýk­OsäÜF\0ÿú‡/»(ímÎ\0T‰Àßç„q¿qÑÿ:€ï«ò5ð·Ð¯øš»í›p¸ipÿÓÁ+\0þ¥»¼áD¾ƒ»=ø¥û¬vÝí)€àŸ ZíÅQh¹Œ\r\0\rÀéfnnÎJ)µµ67Æ¤\0nzP^žwÔrÀãÄÒ\0)%::´ÖŸ@?%|-Ïóë\0vççç»sssùÂÂ‚€8ŽÅÞÞžj·Û]—™Æ˜ºâ“$yg»ÝF£Ñ¸gšâ$SRÜ¿Qïaš”¿;;;ƒF2’·ºí0ü ‹âŠCßƒé¥yâ>E€ädÑ\0þ½û>\\wÑ¶þýx»ïWÑuâoÜõ_ð38Ù;î59\ràtóÜsÏ™ååeÇq&„HÃ0¼î»VY‚w’³®Ú¿%„ø_²,»­µÞ\0°»¸¸Øþà?˜þê¯þª±…\'}EÏççç…Ö:0+¥ü€7“$y¢ÙlôAnÌ¢AUfTÿííí±ÝÉ±°\0àÿÂÃ@\0|\nÀKèÿßA?KØ\"¶²`üÌ“Ï¢?ôÞÜ¿mg\02°\0ðXá¼×ãÇ†a¨…¹µ6BÜ2Ædyž#I’á”;öE~XÞb:\\k8ŽaŒù‚µvÀ®ÖºÕh4z—/_Î>ö±i[rîz¾¿¿çyÞµÖ¶…mcÌµ<Ï,¿;lŸF™–QFeZñ·Öbgg‡âOÈýåeï¡?ß>i…Çî~»Nœÿü„÷ï†ËFd¸[Hh\0N­0RÊL‘j­;ÖÚ\r_8L8«cYXý<!ÄÖÚ€Ž”2YXXÈ>þñÌ; ¥”¹\"5ÆÄÖÚß¬hTöa\\ÆbÒ{©’!°ÖbwwY–ñDÈýå«.âïánª}”È\Z\'Ä‰»Ç=>=Áý{¥`\0˜ 8ÝÔëu#„ÐRÊÔýHneY†^¯74Bž$þåÿ~êŸ»ß€,ÏóLJ©Œ<aÞ\n!¬î²kkm2Ê”TùiÚþŽ\ZòØÛÛC’$üòré¸ˆÞ¯WXëî—¹-F¿fà$0¸»î\r\0\rÀégaaÁH)ó<Ï}„ý†1ÆGìCp’Ð80| ¥ôÏaJk­ˆã¸J+Ua­ª¿.±_ˆfäÚGéðWEü÷÷÷Ç1¿8„<¦]	¸·•txBû¶þP3\04\0Ï?ÿ¼‚ Ïó<‘RÆJ©¯•k\0¦_/ÿ/?_@]Q7Æ„{{{êÙgŸ¹\"š+TÆ˜ÀZ	!êRÊ¥”Rc#ÿiÅ\\VÃÓn·Ñívù¥!äÁ0ƒþ4¾\Zî®/!ÇâP~\rˆ*\r¤Ë\rÜ;4A@pª±Ah)ešçyÀkÆ˜8MÓA¤[^Ä§lF\r@EB¼SJ¹çù¬RªÙn·k_úÒ—”(7ö/ˆÿÂÂB-‚¦”rN1\'„¸ÁØ¬ÄIˆ·ÛE»Ýæ·…Ë{œ€Ï8AGhƒ/ü3NüßƒÉË0–kè1$` \rÀÃB­VÓBˆLhYkßÈó½^o¨ÀŽ«	(øàv­5\Z¤”ïðÞ Ö‚ X0óæÍ:€@!½BH\0ÁÊÊJ#I’Ykí¢bIñ)åÅZ­v`]‚“Žüã8Æþþ>¿(„<x>€~&qýNMg¦ù•ËÌ ¿Ä\nú ¿í÷í«¨VœHû\0œP`aaAïííeÆ˜žÖºàkY–½=ŽcÌÌÌÆñÇ5Ü™$¼333èõz²Õjý Rêµ<Ïc)¥ÖZËÙÙÙV½^OÂ04.\\ÀêêªL’$êt:3a®\n!Î)¥.c¾·^¯Ë(Š†N¿«Ú\rpšŒA–eØÛÛã·„ÓÁ:€¿Š»S\0}“Ÿž]o\0BgÑ_ûá¼{ÜI-”¡ßž¸˜`úŸàôóÂ/è………<MÓDJÙQJ½ µþ¨¯ð+–ûîOWÖeÙù8ŽÿfÿS–eR)¥v“$éåyž¹ûJ©†1f^qV)õ¤µöG¢(zÚ/T\\›`TAà4â?ªÅïîîîI­ìG9ß~kg¿ðOÝ‚b×¿\Zú)ÿUô„º\nàNpŸ^E¿\rp,\0¤xÈ0õz=K’$‘Rö\0¼¤µÞKÓt¡ÜxX¤]¼,×	øŒÏ,..bggçÝI’ü£0ÑZ;«µÞ¶Ö¶Œ1™ÖÚJ)CkílËRÊÖÚ‚àƒ333\n\ZùWiñû˜ô÷\'äa\"ðÓN>ã„~¿Ðïü·\0à€¿æÄ_à>}ýiŠœ@ððQ¯×u«ÕJ­µ])eÀ+Y–}C¯×C³Ùœzõ½¢pzáîYZZÂÞÞÞÛ{½ÞÿÀï‡aø)¥T@\Z5Æ„RÊ9cÌkí‡¢(:7333†ðÏYÜa&eRëâqÆ`ww—ýý	9½Ì\0ø\0þÀ¢¿&@¯`\0š\0¾Àw»Ë“æ‹è7(ŠqwQ\"BðP`WWWõöövªµî	!ZBˆ¿ô ˜v/ŠoÕ…Šbí3ËËËhµZ‹½^ïÙ<Ï¿ÀËÖÚØH)kÖÚ·AÐŒ¢hP‡0,\Z\'þã\ZýŒËbìïï³Ë!§ŸýÔþw¢ß€gw‡Öœ»Oû±]È\0xÀèŸàááùçŸ×+++Y»Ýî)¥ÚA|Zkýãq×Ë‘}Õåw‹×}-Aqê`£ÑðÅ3yž¿×ö	!Â°ß¯£h>ÊÄ×\'3$ã\"üQâßjµØè‡‡‰þÓŠÐ‚ð3\0˜þ§xø²\0F#ïv»‰µ¶cŒÙµÖ¾”¦é»[­\ZÆñ¯’v/ßVÎøË0b?®©P9í_|žIËþVÿn·ËF?„iù$úEˆ]\Z€“uyä\rÀüü¼‚ 1Æt1{BˆOùuŠQwQ¼Çu,¦ìËEåç3Æ@k\r­õæBþ¾ÃÄ\\—Â*â_¼-I´Z-~!Ó°…þø¿Ÿ–Èñ\Z€‡“/}éKyEYžç\0-!Ä§ò<ßïõzƒ‚¸QËÿVYhÇã½¸ÿ7LôËæ£êÂ>£î[¼_žçœëO9ŸE¿ö ¸P£\Z€‡30;;›)¥|GÀ;\0>—¦)Úíö=cøUºïÝab?Iüýÿ¦YØgRq çúB‰A‚7\0LÿÓ\0<Ü`eeE‡a˜c:Æ˜]!ÄfYfz½Þ`\n`yÉßiWÙ7^_üI·¥½¯¿¾¿¿Ïé~„Ãð%l\0ä\Z€‡“Ï|æ3ºV«eyžw¬µû\0^2Æ¼Òëõ°¿¿ Pµÿ¤ezG‰y9ú?Nñú«û¥iÊrþ3úËÿúñ¦ÿi\0þ,ÀÜÜ\\Al­mi­·„ÿ)MSt:{²\0£ÄvÔ‚AÓd†™ˆQF`Zñïõz;\"„)x\rÀóÎ\0ø€\\þ—àá7\0/¿ür^¯×­uÀŽâ3Zë/÷z=ìíí0£–.›„ª+ö\r3\nU²\0U²\n~KÓ”ÿ„£ð‡è7\0òé®þGðÈ`² zÖÚý<Ï7„¿–¦©ît:¦ŽùªÍy¦)Ü;ŠøûKc—ö%„…-\0`ýô?Wÿ£xd³\0ûÆ˜-kí¬µÏÅqŒ½½½¡3ªÎ¨’Ò%ê£Ä¿j¦aŸüBŽÂï\0Ø@¿ûŸoþÃ“\n\rÀ£•8sæL\ZEQWk½`KJùëyžïôz=W	,öé¯š²?ñ¯2þ_¼ìt:ìñO9\n·\0üî¦ÿcpê\rÀ£˜øÒ—¾”ÏÌÌ$A´µÖ[Æ˜k\0~%Žc´Z­A-À°´•Tþ´…€ãj&‰Ç,ú#„•ç¢ÿ]ÜûÏèŸàÑ47oÞLkµZ×Z»k­Ý\0ðgZëÏõz=t:KýŽ›8íÀQe0Æ‰žç,ú#„•ÏøSôk\0öÑ?\rÀ}€‹=\0\0ÀÌÏÏ§Y–u¬µÛÖÚY¥Ô/fYv©Óé,6\ZUÿãzöWÿªæ x9îÆ¶ù=^n¸íqd	ý%fgø5xì¸àŸ£?°ƒƒÿÈ}@°]ë1ÌR«Ý	¨3gÎÔ[­Ö¼µö\\†oB|ŸRêïÍÏÏ£^¯Ck=²…o•ÖÀ‡mò3é>{{{÷?^ð?£?ÿ¹ÇgìS Ÿ}4\0,øV\0ß â×â±à5\0ÿ=€/xÓe\0ÚÓ\Z\0ê3\0+fcc#]\\\\ôw¤”ŸÔZ¿7Žã÷7\Z\r!ËW5\0U2Ó\\–ocÑß±ñ\0?_:ù=.O„Û‚‚Øs‘à?\0 øõxä#ÿáL€ûï‚«þÑ\0<FX\0zww7n6›kí.€;J©gYöõišÅ‚Àa®wRôTñ/_¦iÊ¢¿ã¡\rà×\0¼îN†[è§?óÇÌ\0H\05ôÇ~wÛïø~~EiþÐ™½m,ücå?\rÀã•\0‡a˜äyÞÓZ·•R×µÖÝ4Mçëõú@ÀýPÀ´ÝûŽÚÛ¿8îßn·ù‰Z~¿ùÎgË	°8¹¿g|\nÀ·Xà×ä‘%E?ãã;þ%\Z€ÇÖìííeµZ-‘RÆÆ˜ØZ‹<Ï~9p\\â_uü¿Õj±ÙÏñqÃc·¥x<‹Ÿ„;é\'îý\'N6h\0i÷½O\nß{ž\\h\0?¬µVaÜ¦­µYy=€a`”ø&âŸ$þÝn—ãþÇKýb·&úÕï	úãÞÛÂ\'Âe\0fÜ1©£?$0Ï¯È#F?Ûå…ŸâO@/\0ÀXkí3Ê0TûIâ>êÿåëY–qÜÿøù\0_@?š9|»Ÿù!€Y\0kn»à,¿\"ü¹Î‚)\Z\0ràG1 ØÐf¡žiCñþ÷?1.ø	\0ÿÁE¼Kxüj\0¼ˆ\0ÌXðM\0~Œ_Bh\0èJÍ€|?€£4ô™æþ÷?Qžð¿ðŸpwüûqÍ\0„Î}Ø”\Z\0\nÿè¿ªb~”9ÿ½^yžóÃ8YÎøiB\r\0¹GàËµ\0åá€ªÓø¦ÿ<ÏÑívù!B\r\0¹_cì(C0Lü\'óU1Å¿9îO!4\0äg\0Š—åž\0ÇÕÛ¿|[·Û…Ö\\‹ƒBuXpsº³•#üãÿ4M‘$	<!„0@NS6`’ WÛ?ìyŒ1èt:<Ø„B@¤à—‹\0‡\rÆŒz|§ÓáÒš„òÁ!€Séúßq‹ÇlõK!4\0äA¡µ¶ÃÒ÷Ã–ý=.ñ×Z³Õ/!„<†pàÈ\nVü¦þ	!„\0rê„”O+þ£ú°Û!„0@Nqôï›\0Uÿab_¾žç9Sÿ„B@N‹Ø»}Rt_Uü­µ\'=å¯`oÈíøIB\r\09‚)¨Òðg”øÇq|ÒÝþ^@•;íŒ@@ ¿ôíÛ<\rà	\0ë\0–ùI2’\02\0›è/-\0|;¡x„…”˜úªâ«þS\0×\0Üqë¾o/9#PÐ@øw8S°î²³üGœ¢¨ï\0Ø°à6€€7Ýÿrô—Kž0à)\Z\0Bðe\0Æ™€*â_®ú¿OÜ°Q8¡i\0ÊÌ\"·Õ\0¼î2õ‚)¸à2úkÄ_pÆ ÁoyHðC`û\0Ú|\r@À«NØ3·å…ËòfÜïdÀ9g\0¡xÜL€/œ$þ£Á}Hý;	úè&GÖ‰* d¼)x\rÀó%S°îLÁ[ÜßÝc	¹Ÿì¹ïöúY®[èq½áÄþZIÐ‹Â^y]¸Ô#®Ã}ÿ÷}7ü\r\0Å¿òü ßð\'Žãû¹û©ÛôS™úã—Â¢P30ÎüEÁÔð¦ `Íýo‰ßrŠ¢ž¸é\"ö›ÎÈÞ®(îºÁ—E½¸YwiFlýôèŒWë\"4\0ºè»>mÃŸâõn·û@þ¸‡~4\0ˆ¾«)šU¸\n[8ÆüIá6ŸÀ™eôÓ¦³\0Î»ç]u÷Yv&‚<xQ¿í\"öMôÇÜï¸ÛvQ-%ŸWˆÚ‡	zù6[¸·I÷}NÝ>1@h\0#pÔ\Z\0[š¦§²áÏSLt—jH¦ h\nÂBæÀo\nýbC?5ä>~;‡~qÕ*€—=˜uQ×‚3«üFžZ|1]`ý4ü¶»mýÔ|o\nq%êù!¹wSøê[g‚ù	\Z\02ÞVü1UÃŸ‚)ð\'Ë²)6| JÙY2åûo{iHÆA•þ.no)<ÿ9—EÎDÌ»}.›†s`×ÍÃP¬o»¿[\0®»ÿ½Œá)ùìQû(A×…ï¤\"êÅë°ì­Mh\0ÈQ„ÜõªâôÛý>ìç£!¦\0C2Å¿%î­5(š1Æ0Œ2þòkCn—#žKy].É»°Åº¼\rs%ðÃ¢õq)ùQ©yŠ;¡ 60Nü‹×³,{d—ùf\nJæ\0c0leÊ‚-GÜgÔcF=NÐ\0T6\0(ˆpQÄRL7iÌâNh\0ÈéÍ”gLš÷ÿ¸öú/œÈÇžÐ+\Z…ò}ä#1é6ŠÿtÀ‰Ê‡Eï‹é(ì„Ð\0<´&À‹ÿ4ËüÆqcX0|Fa„aÀauÅÿhF€âN\rÀã	¨\"þÆ$	§?hÃ@!4\0äÐâ?.À5Àe~	!„L‚S“Ni´?)³9Jü³,;•sþ	!„Ð\0Š&`’9VxŸÛýB¡ \'eŠ—ãÄ?IþB¡xT3ÃÄŸ…„B¦E€Aä?ÊogêŸB3\0·øÛ²	˜$þyž³ðB\rÀÃ¨û…K3,âwý§þ9_žãù=J=(ì÷Eh\0k\0c­Õå¨¿üwñzš¦ÐZŸæ“ä„ÏïÉ<BàQy/4\0äè?!„1Æd\0RgTô\nð•ÿ§”œ?rBŽM,‹«\">ìä…óÏ4\0Œþ¥”¹\"ÐµÖÞ2Æ ÏsÜm?×ø-I’ÓºÔoq¹VÍ8!G;?¸ßR`çx?;î½x@h\0o—ßív3!DÏZÛð»ÖZh­¡µ>°\n ßŒ1HÓô´¾Ÿ7\0ô\\6ƒ€£€Ìý¦¾`ÿ!~/\0/ˆÝ{¢ à@&¥ìØ•Rþ¡µöÏŒ1È²l`ŠÛ)žö·à·\0´Ý<§ äðÁ3Ñ©Ïm\0¿ü¿Ÿ`Ó4\0¤ÿÈ“$é\n!ö1·…ÿ/cÌïj­u–eHÓÆ!™Sjdþ\'\0·´ø\'äØ~WEð[\0þ…‹ R\0ÿ\ZÀoº÷Ðq·1ð\0\\Nû¦˜~¹wü…\n@ †á¢1fEqÀ;<à}BˆPJ‰<ÏO£0\0~Åm×l ŸªŒ­µlR@ÈáÏÂ\Z\0æ\0¬ðç†p€:¥o1ðI\'ü/¸óÂ–;7ôœ‰9´Q¿Ž;ž.ÍôÂ0Y–icL\"„Ø—R¾`Íó~­õû´ÖçÝ	 |ÀûÜq?æë\0~À§Üü>!Ç†ˆ€Î€WÜ¹à›|½ûûÂÜ×¶ûý¿\nàK\0>í®ï¸m×í7³ƒÌ\00P<þ¢ÿÒ	{­V«5µÖMkíŒ”rÎÓTJÍ¤iÚ\0Pð€Y÷ƒo¸Ç?æ·µ~:ß¶7\\C?•×uÿßw?î}ÜÿÏ¬µšßBŽ|Îðç†\0@ 	`ÆýþýÖt[À[ÜmO¸ìÀ\Z€Ú1îzÀžñÛî7ÿ¦»=vÑ}×ÝÞ)\\úâàc™&Lý¢xd@Á÷£\r\0Dõz½®µ®[kkyž×Ü9r‚ºû)·I·‰Â‰cÚhÃ_vxñ÷ó‘}Ï‚Äýà»îÇ£0ÅÇòFÈqž3dñÜàÄ¾æ.ëî¶Ú˜sƒ(lG=/hÜÍ\\ús‚?/¤…sß¼ðkSƒ0ž^h\0)0ÄÈÂØÿ ‹?ì ðãV…ÇFüË?x[úÁM€.ýðÓÂuÝkürrÜçŒ‚€ûsCP:/·ò¹AÓyaØù@~ÿÅ^ yÁ,kgPžbh\0öó´?xQŠôe)ê?Žù0Ç?Î˜Ò›_*BîÓi§pn(nålàQ²‚£ÎfÈù ¼è9úEð¸š\rQ:”ÜÇe\0Ê?ú¢)\0£|BNå¹aÒùá¸Î*âù€€B!§6\"„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„Ð\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „B\r\0!„Bh\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „B\r\0!„B@!„\Z\0B!„Ð\0B!„€B!4\0„B¡ „BÈéçÿ?\0„#£‹þä†\0\0\0\0IEND®B`‚','car.png'),(49,'1231`','12312','2016-03-10',0,163,NULL,''),(50,'','','2017-02-03',0,176,NULL,''),(51,'sdfas','','2016-03-11',0,170,NULL,''),(52,'dsfasdfa','','2016-03-12',0,175,NULL,'');
/*!40000 ALTER TABLE `tblcar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcar_type`
--

DROP TABLE IF EXISTS `tblcar_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblcar_type` (
  `Car_type_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  `Producer` varchar(45) DEFAULT NULL,
  `Type` varchar(45) DEFAULT NULL,
  `Automatic` bit(1) DEFAULT NULL,
  PRIMARY KEY (`Car_type_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcar_type`
--

LOCK TABLES `tblcar_type` WRITE;
/*!40000 ALTER TABLE `tblcar_type` DISABLE KEYS */;
INSERT INTO `tblcar_type` VALUES (163,'Audi','Auto prishtina','quatro',''),(170,'Fesal','sdlfa','adslakf','\0'),(171,'sdjfakj','kdfsjkaf','djaskdfjk',''),(175,'Audi','Volswagen','r8',''),(176,'BMW','BMW','320 GT',''),(177,'dfasd','sdfa','sdfa','\0'),(178,'opel','sdfasdf','sdf','\0'),(179,'sdfasdfsdfasd','asdfasdf','sdfasdf',''),(180,'Volvo','Volvo','s60','\0'),(181,'Audi','Volswagen','a4','\0'),(182,'Porsche','Posrche','Panamera','\0'),(183,'Porsche','Posrche','Panamera',''),(184,'BMW','BMW','320','\0');
/*!40000 ALTER TABLE `tblcar_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_roles` (
  `user_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `role` varchar(45) NOT NULL,
  PRIMARY KEY (`user_role_id`),
  UNIQUE KEY `uni_username_role` (`role`,`username`),
  KEY `fk_username_idx` (`username`),
  CONSTRAINT `fk_username` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `fname` varchar(45) DEFAULT NULL,
  `lname` varchar(45) DEFAULT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(100) DEFAULT NULL,
  `email` varchar(85) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `telephone` varchar(45) DEFAULT NULL,
  `bday` date NOT NULL,
  `enabled` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('Kujtim','Mjeku','admin','$2a$10$F3jTGzG.TvJRj9GlErLJ3eukneWjE5uUMOL8m4lBaBKpvqltebBhG','kujtim.mjeku@gmail.com','Kosovo','1231321231sadfasdfa','2001-01-01',1),('Alex','Dikushu','alex','123456','mitjuki@hotmail.com','','2312312','2010-01-05',1),(NULL,NULL,'kujta','$2a$10$tZY8rtx9zhCw7d1RBrtGK.b/bv.YKEp2TVz3IDc1N8foNdHLXgqha','kujta@gmail.com',NULL,NULL,'1992-01-04',1),(NULL,NULL,'mkyong','$2a$10$Fgkk1Im2TiNruAZROUDCTeyN.Co6wCPBvkdk2W.KtsKds/WYalR86',NULL,NULL,NULL,'1992-01-04',1),('qendrim','mjeku','qendrimi1','$2a$10$b97CQp944n.yE0FCFtiPk.JStzVFK9LvhfkVXIe8QrelBzEu23ify','qendrim.mjeku@gmail.com','Obiliq','+37744760846','2016-04-01',0),(NULL,NULL,'test','1231','testtt',NULL,NULL,'1992-01-04',1),(NULL,NULL,'TeT','$2a$10$StBjTF9rHF8A.oNV1KM8l.pofXbifWCIbyG3s5cjRtFNpS7jIppSa','kuj1ta@gmail.com',NULL,NULL,'1992-01-04',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-05-21  9:08:44
