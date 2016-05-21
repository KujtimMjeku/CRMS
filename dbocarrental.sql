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
INSERT INTO `tblcar` VALUES (32,'01-872-KM','Blue','2009-01-12',56,176,'����\0JFIF\0\0�\0�\0\0��\0C\0	\Z!\Z\"$\"$��\0C��\0\0�>\"\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0�?n�wugr�wq��$2\'\Z���D�9)E\Z��(#@�@9)E�̷4ȹ:����@�t\'��ru5\0��#@�J(�(�(�\n$����d��.�����u��#����m�o��o5^��g�Fr	]�N�*F�wC\'C\'J(�\n$�VN�\Zk�8v�-b[%\\��&/^�Y�Ry�Hu�C�+gM�3�q��v��goY���Ky�r79o�nx��̘��\nN��ƴ�%|�Y�_\\���>Ek<^=8�����s��u�S��͒k=w��WI����jѭ�4yֱ��\"Οr�Y��C�d������N3Яc~I-�S��ԧZ$ҟ�\"�w�@]��v�������\'�O���G��ߞ&wU��tڋ����U�=X�ֱ�t��r��Vm��ҩ&���Ǜ��޳��f��0,�t<�i1jX뷼��)�/����xz1����mg����N�~����-�r�o�y��um}��B^�.S�]T�p�,~_�^�����t�gE��tv׿�ᜇ�U���ùɕ��<ڳ����x�{C�����P������c�A9�\\㟬l.0=~^�b�|=��o�/N0��V+�G<�<l���=q���t���{�<��|��}U��\r+{|�;���l������g��|v���o�\\�{d�9��9���o.p�:�}9�>`˳\Z�W�1��B���v��R>��}��sMכ�F>���ry�O#/6�Q���?N՘g팽��B9Z��<o�@�d�$�1����_-Ւ��E:������f��\"7!ˏY���]W�9޳S����u��]9 �u3:\Z�,�yRS�t�Vd�;���Q\r͈�5=�9��<r�1������G��K�.����~�J��u�%OJ�VdQԈϱ\n6dKH��FT�M���$�U/�I%)[U �$�Đ@����!�!�$Ae$����GA��vt���$�-d���\0*\0\0\0\0\0\0!\"1#B3@ 0p��\0\0�\0��S��L���:��婩��(>����^S����/[,��]�x����\Z��x�H^�<��\r�`��N�L���=j)1O��ba����U�?#C �Ֆ��Z�ϕ(��C����x�Ö�/;�t7�%���0\0�t�gY���.��%q~�%b�аN�e��F_� 8���j�긭n�/�n?�E޾mhe�᷍2��>�����X��Dȩ�\"-�ڶ�eH��a-3����[����q��\\��,���~{�W���lQ��W����\0\'�c�[Q�˷\"��UQ���~��v,ݘ�.6�\"lQnGbl�|���x�0��>����jt(J�\r��t�-���U.䬱�˶5��Z�\\�S�E�o�r�Ѭ������Șp��p��l�Ʒ�i�*c_b\0Kcb_u��ca��i�\r��e���:��q�T~31����e_X_��\r�q���뾾c���T$�\0_���$}Y��z�P�_��pd�[m�x�|e�hEmRӏ��	ۏJ���<|t�q���#Q�<�q��%�?���M4��^<��2�||v[�����ls9��N��[*������D�ۚ|u�&RA�c��8��d�!lT0�s�z��w��s��r9�g���Y;���������KV�k\\��F��`\'n7r�E`�h�v��3hZ��S\'��	-�{K|�XX����A:4�d�td�^)]VOO\\�cL��2���rQ��eV�zY��s��36q�X\\J�h�\n-6��,Z|�]&Íl8�k�n�[�Ӄ�\\��X�r�8�¦C[E���aJl�ɒ�\0��}��Xg�<n2�>2��ύ�|vH������+�;��䰩�YMB�V���ӎW#��fG���h�^C6E]�U�kh�r��\'e�U)<�����9��|�!>o��������Zs0oƻϏ�;�Ӵ�-	3�:é�ݩ�/9��;��8���$A��f#Fr͸���j�J��7Ay�)�_�v��Pk_�Gj��e��rx+��+�ݞA��U��v9M�-��\'�a��;�2����z�o�y�Γ�\\��Т�S�chۺ�n�_U�.��.3��a�[]���p�֦���T�R�N8��*�ڻ����5��\"�ůEЛa2\r�]ogJ.�z�=K\'�d�m���ֶ#�%�v�r�1rN���n�}Zʅݓ�O(�ߥ�\\lǉ��&dm&�.�k��S�![��)U��-7�c:�;�f:���]�\0�䂹��yfdO~��ܮ����!���w�[�mB^��>=�v�R���S�ǮY���o���yV�.��mՍ��=LTv)ɢ����z�2��2rڬ�f��ӣ���/=خ2\'\'ETXZZyL[����Sܷ��t���2\nOig�TȽ\Z������O\Z���E���1q���c���8����\Z��D�*���gJ7q��\0Y�;=ը�Ry^5�>��%�M�_��:����6�6Й�͙�5��\'#�d.!1p�\\Ti:�]�E�������ٯ-<k���z(-2�a*F�~�k��ڡ}�\\�����<\n!���\n�xx����<�����+(ʸ��c�W@cZ�f��I��/��4��������\0U�T	ӣ�R���	X�4�n�ZHñ�h��p�X;]��1� ê5*�� 3�]��!�bx;w���X@�gEX7�r�U��6e?l�:Vc٭E���l����+4�\Z�[MK?�\0��yY����\\P���!Q�5��Fs,�5�O��Lo��k��?u�k�?�O�\\���kHP�Z���Zt�Mn,N�\Z�\'��\0.\0\0\0\0\0\0\0\0!1\"AQ02@B #�q����\0?+����*+�QEW-�cm��EQ��Q\\袊(����]KO��1���݇��@݁��R�E>T��/7��]�.���P�<����$dɭ�ZUDDg(�&�Ó5�*�(�<������\"[��\'�9g�,���3w/s\Z�?�!�+ΚD:*7\"jD2źL���kدe��_�R^����7��a��u<J|;�|4z\n8G\'�d���������R��?�x|���sA��Q���/Q<k���3�{>��Y����oܥ���R4�D�a���4��`����DUZ+�щT��٭��<�O��\r$���ao��ԢKC_G��\0��t��GI\n(ڿC��J4G�QK�,q�tlc��]h\\4�T�r�5_Ȳ�F�Qf��b�/��\0/\0\0\0\0\0\0\0\01!AQ2\"0@a� #BR�����\0?��_�l��Ye�Y}���,��7~E�,s�dL��,�Ye�Ye�Ye�W�K�����Д��6r{���A��#��g��k�����c��(Ř���#�8C�)�F,z#�!�S�#�,q�,zyP��}����>穇�>/S��1����&�\r�\\X!��[�����l�ۑ<3��2cȒҍ�.S7\"������\Z���-_�6�I������&���,c��R�/���O���,�����K��~\r9>\n��9F,r�^M��q6ѵ�`��L\n0Ƣp[53R�H�vJΧ#��GK7t�ՙ]͚�\Z�w�(��\0�u1~,�h�Xޥi�����Н�,�����m��6<��z�/���\rr���YC�g���.�,UY������K|��%�tQ��h4\ZM�W�ȣ��\0B\0\0\0\0\0\0!1\"2AQq�3a�#Br��4Rb� ���$0@C���Pps����\0\0?�\0�F�w��\0�E��UqF�#�h��**0�C����Y��eɡ��K��QX`w�Ji�c�ۭ���U�V���Z��\nG�kۚ�ܹ)ޮU��X���W#�Aw���\\�1<��h��/��V����<�]�>�vR\r�s~��Za\Zn.d{ٷ��Z�V��Q�����Vp*���Vp�+zȐw�U�vwm���Ր7��[��%\0��Ot�㒆�ti�{N���u�Z����s��q2�k��ږS�T\'�\0*h4\'Z�w�����*�]�)����hu[M�U�xJ�tZ���T�V3�3)��\rփ|C%�U�\"����4*��z�*=��<-�C��Y����]���!���raD�\"#�Nw�)��}�r�e���-ip\nYWW��3�9�{�]	2T6ȓrw�fl�J�I�{�R�]���\'�[-[\rR]��bv�`���B�d�}ʽtF�F�si��袍i����q�����w�!�\n#r���%�F#�a�p��v�ӷ�h�;�\"�BV�\'����9)���9����^a�P.���?�n�S��RV�G`\'����]��ܲB���w�ܭq�o얉{5���f�9#N�q5H���~��g\n0�������\n�*�÷�kyJ�)�@P��C	[/�J{E:��(�M�\\5Kmu����I$5_N2r�⻺zUV�ʁ��ޑ���֑���Γ���Α�+�u�E����������UޡI�VK	N��Dpx��g0�U�.��2\Z��N^��\Z}�J���gy;��<;\rN��އ�&R}8��6��Cc�laCJ���41�O��#�VV�\nr�^��\0+�ʟUg��T;I�}Tw�O�0\Z��m-���{Ӎ�ꭢ��0$1Œ��J�3;�r��{D���I���i��{��ƨ��QĀFCz4��� ]9��T`;��\0�޻M�]�!�迵\Z���^�5 �z4�҂<��P+�p��j�V�ު�>�2��+axE��\0%��j2qb�8եM�.A@H�Ɍ�\rp蛭G^�Y@v�$xz(/�o4]���N|1-��{V�x�� )��L@*d#V���!��މ_|���ߝ�W�G�_vY`M�?h3\0�MZ���+���G�6�yTG�_�j��E��+���QT�C��KW����|�Y��2����u^�U��ށ{�E�Ր�Z}{/��\Z�����>mW�����s	1p�r.��z�����7:�5��`���N��+Ym��\'�{�r.�j*��m|��!��Ppp���j8汊���e\Z->�u��z^��:*ΐ����ۤ�NmV���@�h�:Fȩ�l��JuGffU:͈{C����w7����{ˏ�,�ٶ:� �a��a���m?���x���~��Y�{�$8��6��rLѩ8��w>^H���׈X<����#b�e���1��l�V�\">��;!k�������WpI�P��tz�U�����-��%l�?�	���A<UÀ^��ձO�W�K��)��U��Z����R�L�,��wL���0�V}ă)�21�vD�$�$�L�۫����*1�D�Ѥ�$�?�S�Z��]�W;��뼑�Z��5����]�2��Y�Ϥ�7�aY��p`\0��+T��j�aX�<׻�fޫwU��[*-�y�\0O%�T�i~�n��k��LsL�͐�o�S��f���ܭA�j��T���\0*����/�sNeF�S7��u�Rl`x��p�d�a4\\8��9�U����W��s\n�1��:�,B�����l���(�A�V��f>U��Z��\n���e���ވ,p��l���\ZY���f\'�-�4�]8#r����潝��l�g�G@��)7�V���h�iO7��w�yuZ�Ç��5�W���Hq��b׎�at��+4��-ZQ�K�\Z����7�w[x�j��i�k!,~c���g��k<�6�S�B\rˉGRd��+DCr��Um\Z�_g���B�Z�X{�/���]Ƿ%tgd#��SH7�m��1�D69�N�U��>AKK�y�8]��cV���j�굪5���盬��s�\'S����j��Kd�����ٙ��TuPʀa����U�J�}_Hv������u��R7��I�	;��j�ؤ̸T���*>g��\04[�\\��]��[�l�^���J�/u�RO5�Ǹpc!Z����h���}V�d��d�:,�K%�˲b����Ү�;�F.�R�C�V��s���Qo�!\0����^�Ǵbu�d)���|��@�J�>K�7��O=�5 ���c��Uˏ�\nkO!�T1�o���s�PJ�\0�1�k�՞jz�¯%�\"\0Q2|��e��2P��8���G�\"�{1�*3�\Z ��K�l�5�xW�H��z-��R�\'�EaB\'\\�JvM���C��ʁa�Q���������Nh�e�9�|�����S�\n��Y�%�!;�(���2�\\�@���\0)\0\0\0\0\0\0!1QAaq���������0 @��\0\0?!�ԩR�J�*T�R��*T�R���_J�*T�_Z���R�J����}*T�R�J�*T��J�*T�R�J���J�*T�R��*T�R�J�*T�R�}+�R��R�}*T�R�J�*T�R�}*T�R�J���R��:$�K���b]%��*T�R��ҥJ�*T��\0��\\R*��[x����f<�=x�����0�����Mu^^|�\0��i�x�ы���.�x�c�\\����� .D�^[�R�J�+�\0Q^��A\"���j�\\�WF\Z��A�W�6�}�+䫂R\\�J��������T�Hc�>b����c�h-7���y����Ω�f���L��\0ۆ��jv�:��گ�����_�m/-/-*Wҿ�����(��M��By��V��H������s*��MikWS�R�&�g���\r`�>췈i�^��agJ����zRk�J���sJ�Y���\r9�{��\n��Y�FQ��3E�PZ^%�U�R�C|�Mf�k����X��3	��2-�p/9����\\f;Z�Pu5�:)ٟ��͢�����Z�@�p���@�mi����\n��0�eBv%�e�g\'���!�E�YԠ�:A�-���X6�#&�d��k��u��~%��G��_�bJ~�*i˹��\\F��K�=�ig��d�>�[2��uX}1*W4��dY�E��~�����V�EA��38� �6)s̫j��(��޺�ʖQ���>��_�e���\\^�����^�$N\n���/�[�Z����v�m��[�ݢ�����C�.��Q�M�b#����\"�G,Mu�v�A&�!��r��s���bw�y��=�����G��c�4yZ�U3�y���q���نE�jkD^ޱQo�Qɇx���b�YWRx%��򈲣u��K+�,��^�z���}�4�Z���)��q��8!���DЯe��|�����X(��1�g򙟨�X��[K�TB���e\0�m�bR����J��揝{��^&&�*57��վa�f:�u`~�w\nn���n��Way�S7QRƸ \nR:�ယe��FD�f�Ů*�0���Ϳȃ�x�NJ����s�hBA6c����gQ�#����;���E�׷л�m�Z�fe`� X�BK+(�0|���0e�̳�	3�Bh^���#��\0%KU]T��Ak*)G��y���{�,�Ԁs���.Pz,:���Y_\'�Zn��{};2�w��\0a؎�/)�>�w\"�eY�5����\\�II�f�\rYt+����a��Dx�O�F���KV���B�u#[{ j�#�T��m�\0 4��(\'���A�9e�ߖ2D<���k�=Bu\r3���A��׌��%=U����]�y����̍u�-�K��\'-���1�\'� 	G�`�;<;&��~�\na?/��W��c��Eݟ�S�D�݋E�)��^r�6���wPV�{�MG��zPu-�{C�g��7��3�3��ut��+iB��ګ�a\0e���=�]`B$��q����(z���y��>H�:��U�bI�cQ���ʳy��SG�h�����o�\n�i+�u��8ÕC�C,�b�^�����o�ΑD���d��{@���P��IBc)k��\0��|���Ks��:��q��_y���V�=���>�\0��>���d35�FX)p�����\0X����aj������F¸:�	����ޘ�Ky��T�\Z1\Z�(���[�����u�[O�����Ul�^:M�hK؋�M�yԩc�8� ��!o���(ťx��x��)�~�\"����_�����:�#�J\'A��p#�?0iY��c�IvG%ft\\*�1Tv��B���E��0���.� (�t�=�}<�>�ze<D�L��0��0e	K��<�wa�k�+�*�E�q/�u�B���ve�ظG�?J)�����ҾA\Z�c���\0-�yL\0r5\Z�L홥l�.n�W��;�$�O��C�� � ��t|���d\n߶c@�%L�8��ًl�-\\��̗=U��**��	�\'�&��Q4��!9�\0B��6g�ɦQ6ӑs+z�8Po�P��8��j���2�Ww���[��c\Zf����ض��l��b���YN4�0o�S_�k�,L���Ff�`��S#�~#�n��C�<[�����cXg�/E�=<�j1���\Z虫9=N�R���!��ŕ���>�q��=&���mSt\\��P,^O�!���\0	~4�	.�}%ݣ�b�&G��+�Гq�b(\0�̨̙�/\0��TW��	�樌Y�PP��S���f��oB���^�O�S�#r�m���P�(��+�ʪ��	��0i�)F��Z��	�pG�1nohP_����g\"bј*�e�q\nC�מ򷦵�G�,zgqw�p�N���wQ�=���`{��;a:!]����R�z:�[^��\'��IՃa��5x}��E�⭧xQk\0/+�D����$�su�)��Gc%.��{C$��Q\r��\"�6�:��X���>g%дȇz�/ V\Z[��f^%���~%F7	Q����U�2�\rг1���_x�\0 �ʙ+�F��~������=�x�W����0,$�~e�u,]\"��f�\n~s3�Y�b\r\rt�_���e�ς��h=t����}�O�Q��0��$\'@����]_�K���:j�N�]�At�^���A�f�=\n�yȰ��C��i�guiO�\n���ߏ��2�Ǚ}C����?�D��x�1��P2�W(^�b�\0�\']�XXh[2R�=%]?�1�^c��k�}����79���q?ixѕ|Ǿ��n�\rM,B�*B�/wD��p�CG��:��}�SA(���J\'A���R��xA�7�J�L!�Z�� �;�%X�(7�JH����֒�)�+8޳�3�܇��w��b�}���ݑ�7������F�N����\'{����� ���\Z[9���˚�\Z��!,9G,�@�N��E����GܺV�,pQ��Gqi�\0P�)��yܺ�2������Q3��`Z����z����P��-`n�b6����|c�3s�X��(M:��U��.�rq��4��oq&[U�+�ņ5u��n\r׈m�&��:�b�Yb�)4(�e�����c�����\0\0\0\0\0\0BS\n<��Q�I�b���ݨG�H���3���T�O�ec��\r����\09nɹd�7���n�,-��o��F�\"v�P�.�ϖ뾿SC	�,}6L����\Z�l�l���x�^Fnl�g��}�G�y�^/6ڣ�Dd-��K��~ʮ�e�!uOmkn�86t�����%���pp\' t0�	ǃ��^�����\0\'\0\0\0\0\0\0\0\0\0\0!1AQa�q���� 0�����\0?�!O�B�!	�kMR@:�5����!?��bh9ra� Yix$u\r�~�����ƹ��u�����hxܨT��&XOQ@�a�?�A��y1��Q�_q6!���������}���k\"n!�w�͂�z0�{����)���GE�|��I`}���=���x��/�O�o���5��&	�P�kٿ��T�_�\0)��\"r�V�\n�P�m.]�n���An�H��Ȉ�#u������U�D{�\r4��,���N��ҍ�(0�ײ6k��7N�;)�w�=x�ԉr�\0E��)��~���(�0M�HI�\0�c�$N��r!�s/�N=W�`i6�о�,�z����`�xvm�Ɔ�S�=�6%�ؓ�c�u�<%�P��1*R��TcgaC����qYz�	p<dy*-��1��L�*O��YE��龴�\n-� �B�V!m�:3��\0(\0\0\0\0\0\0\0\0\0!1AQ��aq����0��� ��\0?�JR��)JR��/��\0��Fa�<��d���\0���+cq&d7�f�v�ނJ9�\\��KS�K��i�1�\Z(�ŜL�F4�5JFe�y,*K,��QG7��e(�q�h1h6QRs�����7\\o�:�S�E�-���s��O�\'�ą���Uk-:�����~�<��̜��4�װ�3>��#�.�`i��+�l;-��_�Y蟣�^o�-�Ն��V�e�~H__�����i�n�簚e�{~���zN�+Z�[��AB��^�n	�%��{\Z���\'�J�F݃ZGv!����)���lK�o��������W>������/r/��GeH�5��b=��ϸ��6����\r��x<�+�Gq��<�o�a:�4��1W�~��������\0�P�v9	+]�L�m#�(J���TԄ7�&y\r�L�`Xm��[qHj����Zp4��\'	*Ѓ4���̆��C7�\0���-F=P�6���\0(\0\0\0\0\0\0!1AQaq������� ��0��\0\0? �\0�AA�	^%����R�J�\0%�#���A� ��@���=!�eOO𤤤�����Q\0��\0<!@�B �?�����\'���*T�R�@��I !����I\'�$����� ��D�T�D��*b�9=�\"R�_(�Q&�)J�C��P�JB�uO��=_�Je��*T�R�R�R�J��`\Zo��T��-�|��*\\�\0dDW�	���\nS�\\=f<�(<�-(\n%�#�DXImO�`���`,���j�KO�������U�����է�%��¿�b�쾄���d����pZ��#�(�/ԿR��*T�R�J�*T�R�#���(��vA0�d�in)��=()\n[��{TO-��=)64��u�RҌ]��K)�]�Ǜ���X�OE�>��_�=V�(\r���j(c;U�9�8���&[=;�U��0J� �6���W�\ne\r}e�0V�r9u�AiDTY�+JGVf����_HO��%�Y�q\r�}%6\Z�Ωa���z��zc����ԷR��*T��#Е�U�\0�\\m1(�Cv5ڑ�YU�^ ����Y/�b��4������p��{I�9&�\"E͸��=C�ɞ��r�dZn�m�2芍k��	X` c��>����\r5�e���J�)�Ԏ��q�-eVev����b��7l�4gܢ�B�6������a�Ak�PQ��#�1\ZuLx�qa��93\r<)Izf�1G���2�\'D~��)�����(3�&�v����M�\"���jh�P\0)��\0߇B�� ����[-�q\\F|0Smk�n�Gq�2[��h�y���\n|`E�;����ESȷ�lY�����?p�idG��v!i�<?����e�Z,��Y҅��\\�&)���cξ���\\\Zhƨ��0���U<�ȸ*��~��M6��y��w�������@T���ԯ�C�$K)���(f\Z�|�X��+N9�0Z����u�a�IB�^�ԗ��+����\'\nԽ�f~Ě�u��2��\0O4��F�]����痴t��֒ @d\0uya��j��r���Utp@����MԜ��!�M\nC	�\na۟,({�wE����\Z��|E�F�z{\\\0������ao �=C�x62��5dU{�픢���}F��l��i0\0��w_R!:#⨱}	���FO_��\\*�m��y�\0##h��h�̺�epx�\0��8G��e�X�|L���7\nE.���{ˠ��:�U�)�2^_����_�7Y鷓>��J��\"}������̮��-z���V�{5�|>F7!�k�l�	�\0!�֥d�SƆM��\0�H�]8�3/|��5��f\r;���,�iZ.�aWn��>y��C�p�8B�\\������\rP�}x�����?r�ܯ\"USܲ�1�V�KMx[��I{���E�V��������0c�$D���Πo8\\���̸�A��S�P��vMM�ޡ��ZQ��8	yyzD���\\��%�c��k�N��\"��ms_0]U~�i�0�2�^�0�d��+ʹ{/hdvK)�؞F������6�/�Gп\nf���^��Q;Z|1j�.,�׀���?:\"T�t�4f%���\"��rZ��0��0J8R���OR���!fqG/���\r��X�]�g��(�F���̳IWIO\r�.�����K~j$̬�|����7@�~�-�\r�������������<��~b	!�m�3̠����q�#�e�_�1_����� \"ZU]�m�&���\'��H��\\Y��S��]VT\0�A���N\0mN��w8t?%7��D\rӓٲZ�)J^N7��%�+~�L�A��P���~%���ګ����O�[��kR�aUcg��4��Ƈu��ڊ�M�4���\'P�8*r����dFmn�2�Qd��=�6�P18F��0��%�Φ+��+��D�0,��p���Zh�bz���bR�Pu����{�)��֥�Q���&J��9�.���U���ݣn8$q�#���8�������Ɣ@A�e�ZdWǋ�h/�\Z�D-��U��y\rK��%9S�4G�@��WkD��۪���,�3[��0�M��K��<��$�E.���T@�����A@R�p!H�#9<����d��Հ�<<�ctQ�7�h���\"j� �m͜��`� �v�_� ��S��HA����6K��q\Z$�z\nOL ��;x��<��;����!`\Z��%ă����9�4�0��}\"\Z��H�\"�O�1��]?��~�`�\0��� |�\0]o�,��-��t\r�5������K�ž�}+@����Q�%h��^\\y农�l�2��\0��R@����P�Cو�T!{.ʻ����B?9�c����\'�b��48�s,h��s����XW%4���T�\\[8\0�`��t4��W[�tڏF~Z�1=##�P`��+8��:����������DCa�C��vֆ�)�k2/����|G\0���6{�157iO勳��D��MG�l��� ���8����4�� �@��\0�����#l6�?�2Ǵ�����gѓ�)B0�ހ�,�������U��Q?#�\0#6��A�v�Z����j	(�s��8�����\Zh�W\Z�d6�/4�n�Mh�Qh��b���aeFi�za0\0��?2�G�e��\0���(����)�\0�^�ݞ�NN^سF|$vӭ	��u�L5z�	�n����4��9��\0�\"���K�������?�����ҟ[�!���F�����\0$���� 1+��Q�h��%�XS�L/l������I���N�h������o�D�%�M-_���i��<�0�}T*C�d��e�j`�r�+[���B�-A����I�8�&�*��\"��h�x<sV}�\r8b�*��%z���/ �����R����5�g�6�4w.�A�erRQj[�˗�*y�-tpb8��EP�Edp���JS��[��8�\r^�[��f/s��\r\\l\\l Дx���Yjz��\Z��\0�%R��9n\\\\��k��\n��>����@F���bUu��(y�+����pW`�0��5��\0��~?�^��7��A���e��.�&�;��py~P�|��o\"��C\\�>F4+���}�JR_��>f�:����f�����\0��O@(R�5�W����Y.4[�s �n��Q\'�S� ��)1��hD�UJoŵ������k ю��U���Q��AΡ������e:uEv�N���Mi�;�qPv]�eQ�G�>b)�B����=���5��1�ڠ(2�s]9�j��۴ &�@�j;.ְ�i\Z���I�m�W�\0�U���h%��c���K����7���g�I�ܔH�����%@D�]��߫��4�>������Y��2��@[o�`�x3�\0���h�d���{���pp<K��,(���4������(�G�~�*���|\'�,-ȏŇ�4��#U�r��K>�0�A;�8���uɌ�\0Xp%Rx��{M�U��񄧎!bx[�xj���\rI����u�HZ(Êԩ��7aKF:�V�yc:?r�{\ZU�k~al� \\�0}b��s`}�@\n�k7��4m��%�ޯ���QӍ�v^��9@�cƵ�Ƣ�؉��k\r|@����\0��7��1����e�qsges�ĢX�e���艭�\0P?M�Gg�c=���-���4�~?3���@(�B�	=9f����f��ې����W�b��-�6̭���=�������R�K\0�;��U�R����V����_�_\0��v�,tB}������,:�VVx�|@�*\n���˻ႅK�MY�.�\0�eІ�}wQ폗���+a�W.����(��pp馡��1�-\Z��nXͪ�C<zn#e���]oy���rWw\n��U%����2��_Fo��C?������c��	��\"�c���wrʎ���E�������)���6� .�x�8���$sgE\ZUX`�R����_1ўa(�\\��2@��.�������L�[j�W�\Z�׏��o8��\'uYV6��P��:��ː���=!F�7w�mam��bfM��q����[���V0;|�-�%d;;�{�p�-k��](ǣ��V�S������\0��:J��W�`U±C�����7d���?J0\nyZ_�\\ [	�V�#.���]b9ÞJ*<a*�_<�\0�V/?f�b�2�ח��`/u�=&v�h\n�\0�%zSw[�����5-��bF��Q�\n�}�D^\0�qO&i�q]J�as���ء	�k�W��-c�%`�ՇS�Kα3918X�����\"�_j;A��XcMڲ�VN�	����v���Zn|�~��ͫV�f��+lj�,��V&f���`g���,��x<�s�da�ST{�pF���u*��M8����lO�x��r���LPۼYz�.����Z���aHE��-���v۟w�r��\0G��aFp)����1�(x���(�CN�9�7���ʾ�qځ\\|m*\\c�L����|����z�.\"��LE�����2����Tԭ�iywM\\Љ�R���{�+fQW���pJ�U��jR�Cv9ώ�Fe�޶��\\{�S\"7\0�տG	k3�ݝ�|���]�n�H:dp������Q��kIǛy��gt7K�>�Hx\\�zDѹV�ٺ�����J�������1�%J�Weֻ���Q��8�0A�Q-��6�Պ��֡V�Ֆp\Z��HcY�3]�6��\\5J�\\�\"X�����W7���\0�\'�2��H\0�����a�}��� ��P7\0�8q�Fn� ���Q�koҧ(��B�_�(V�j�w��P0���8l89�i�����2��������z�\09�l�l]z�J�K�h�uU��a3T��i<A��\0�&��X������4Ҷ̚�7��O��DcdK[w�_��yh�e��I�V����*aY��R�]�y)��Uf�X6�\0Z�G6�~��Л	����`V�\\<�*���}����C�4��O���j�+8���*,����飐Jmy̠s]\Z�+��mPe~Y��','2015-m3-9_318.jpg'),(38,'sdfas','fasdfa','2001-01-01',12312,163,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0�x��\0\0\0	pHYs\0\0\0\0\0��\0\0\nOiCCPPhotoshop ICC profile\0\0xڝSgTS�=���BK���KoR RB���&*!	J�!��Q�EEȠ�����Q,�\n��!���������{�kּ������>�����H3Q5��B�������.@�\n$p\0�d!s�#\0�~<<+\"��\0x�\0�M��0���B�\\���t�8K�\0@z�B�\0@F���&S\0�\0`�cb�\0P-\0`\'��\0����{\0[�!��\0 e�D\0h;\0��V�E\0X0\0fK�9\0�-\00IWfH\0��\0���\0\00Q��)\0{\0`�##x\0��\0F�W<�+��*\0\0x��<�$9E�[-qWW.(�I+6aa�@.�y�2�4���\0\0������x����6��_-��\"bb���ϫp@\0\0�t~��,/�\Z�;�m��%�h^�u��f�@�\0���W�p�~<<E���������J�B[a�W}�g�_�W�l�~<�����$�2]�G�����L�ϒ	�b��G�����\"�Ib�X*�Qq�D���2�\"�B�)�%��d��,�>�5\0�j>{�-�]c�K\'Xt���\0\0�o��(�h���w��?�G�%\0�fI�q\0\0^D$.Tʳ?�\0\0D��*�A��,�����`6�B$��BB\nd�r`)��B(�Ͱ*`/�@4�Qh��p.�U�=p�a��(��	A�a!ڈb�X#����!�H�$ ɈQ\"K�5H1R�T UH�=r9�\\F��;�\02����G1���Q=��C��7\Z�F��dt1�����r�\Z=�6��Ыhڏ>C�0��3�l0.��B�8,	�c˱\"���\Z�V����cϱw�E�	6wB aAHXLXN�H� $4�	7	�Q�\'\"��K�&���b21�XH,#��/{�C�7$�C2\'��I��T��F�nR#�,��4H\Z#���dk�9�, +ȅ����3��!�[\n�b@q��S�(R�jJ��4�e�2AU��Rݨ�T5�ZB���R�Q��4u�9̓IK�����\Zhh�i��t�ݕN��W���G���w\r��ǈg(�gw��L�Ӌ�T071���oUX*�*|��\n�J�&�*/T����ުU�U�T��^S}�FU3S�	Ԗ�U��P�SSg�;���g�oT?�~Y��Y�L�OC�Q��_�� c�x,!k\r��u�5�&���|v*�����=���9C3J3W�R�f?�q��tN	�(���~���)�)�4L�1e\\k����X�H�Q�G�6����E�Y��A�J\'\\\'Gg����S�Sݧ\n�M=:��.�k���Dw�n��^��Lo��y���}/�T�m���GX�$��<�5qo</���QC]�@C�a�a�ᄑ��<��F�F�i�\\�$�m�mƣ&&!&KM�M�RM��)�;L;L���͢�֙5�=1�2��כ߷`ZxZ,����eI��Z�Yn�Z9Y�XUZ]�F���%ֻ�����N�N���gð�ɶ�����ۮ�m�}agbg�Ů��}�}��=\r���Z~s�r:V:ޚΜ�?}����/gX���3��)�i�S��Ggg�s�󈋉K��.�>.���Ƚ�Jt�q]�z��������ۯ�6�i�ܟ�4�)�Y3s���C�Q��?��0k߬~OCO�g��#/c/�W�װ��w��a�>�>r��>�<7�2�Y_�7��ȷ�O�o�_��C#�d�z��\0��%g��A�[��z|!��?:�e����A���AA�������!h�쐭!��Α�i�P~���a�a��~\'���W�?�p�X\Z�1�5w��Cs�D�D�Dޛg1O9�-J5*>�.j<�7�4�?�.fY��X�XIlK9.*�6nl��������{�/�]py�����.,:�@L�N8��A*��%�w%�\ny��g\"/�6ш�C\\*N�H*Mz�쑼5y$�3�,幄\'���L\rLݛ:��v m2=:�1����qB�!M��g�g�fvˬe����n��/��k���Y-\n�B��TZ(�*�geWf�͉�9���+��̳�ې7�����ᒶ��KW-X潬j9�<qy�\n�+�V�<���*m�O��W��~�&zMk�^�ʂ��k�U\n�}����]OX/Yߵa���>������(�x��oʿ�ܔ���Ĺd�f�f���-�[����n\r�ڴ\r�V����E�/��(ۻ��C���<��e����;?T�T�T�T6��ݵa��n��{��4���[���>ɾ�UUM�f�e�I���?�������m]�Nmq����#�׹���=TR��+�G�����w-\r6\rU����#pDy���	��\r:�v�{���vg/jB��F�S��[b[�O�>����z�G��4<YyJ�T�i��ӓg�ό���}~.��`ۢ�{�c��jo�t��E���;�;�\\�t���W�W��:_m�t�<���Oǻ�����\\k��z��{f���7����y���՞9=ݽ�zo������~r\'��˻�w\'O�_�@�A�C݇�?[�����j�w����G��������C���ˆ\r��8>99�?r����C�d�&����ˮ/~�����јѡ�򗓿m|������������x31^�V���w�w��O�| (�h���SЧ��������c3-�\0\0\0 cHRM\0\0z%\0\0��\0\0��\0\0��\0\0u0\0\0�`\0\0:�\0\0o�_�F\0\0��IDATx���g�d�y��{�sN���lvw]\04�I�� �H��x���DiD�Ys�h��������qkݙ�{e(�҈�$��%�����h�@õ�.���.�q{��{G�<�D�����Y�Ȉs�D�y�������ւB!����B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �B\r\0!�Bh\0!�\Z\0B!��\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �Bh\0x!�\Z\0B!��\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �Bh\0!�B@!�\Z\0B!�<Z<Ǉ��T�����\0v��d���<D��?`� �p.�^�*Z����X$I\"�<y�\00����ok�0�����廳��{?^�.���>p�}H~X\Z���Q�쏙��Ԋ:�^�*���1FdY&��Bk-��Kkmq�z]:��	@$I\0���xؿ7#� �B�E]q@�6�c���!���i�j\0x� 4\04\0dJ�/�{����Z\Zc�Q��ZQ�Ք��x��0<p;\0�rb/�m�RH)�q���>җ�8�cÞc��\Z�Zk����H)���M?�b��!������.�m�4�%c0jkN�$�\0\Z\0\Z\0r�^k�\n���2������[k�� ��Z��R��6\0����2t�Ikm�nSRʁ\0�\0�<�W�1s%���)޿(\\U����F��!�Î�\0��+d��V.��6w����Z��Ƙ�\'��\0h�����]0��qfG14\0���A�777e�ӑi��b��D�ZMcTA�kmP��Z(�B\'��[I)�)e ��c��k\0����R��s^)c�!�B@�0�,N�=��(�O1���?��\'y[��(\\��D\0nZk!��Xkw��;a�B�q� +��\\��1��6��_ȝQȝ1���������AeS@@h\0h\0H5��W�\\�w��Qi��8����Z�Ze�	\\?Qܥ����Z\n!\"��Z�\'�1���u��BH\0+\0B\0\0�BH)�DJ)(� ���J��w��ݘ�=9���/G����=�8?��W}����\0�G↻���`�������\r��̌1�\"�֦�d� ��0d�di�f\02�U�˦`�� 4\04\0dL���3�{{{*�� M�Pkc�0#�u�ľf�	�R��2�RFƘ��R�|�e�:�%\0筵�\0f\0�0+��+\n{Y�����A� �ၿ��U����^Jy�����W��?߰ǎ�Q�[�a���Q��\\�S�5��0��Q�m�q+�o�l�MkmW��:�-g\"Rgbg\nbgcL�B\"�L�4��S��.,\r\0���x��<�L���t��(˲�R���n(��Ƙ���!���a�0�Ԅ5\0uk�����e)匵��bF1_r/��� �/������+�E�0\\�E��Y���q�8I8����IQ�0�\"�Þ{�~�32UG�<\r3���}�/�?���{B�7\0��%\0]\0=km@G�3�t�=�T7I�^���\0\Z\0\Z\0r0ꗗ.]\n���ji�6���R�9���Rj>�Y\03Z�3B�w\0x�s^Jy^�X������\"����(BE��j�]���]N#�Dq�	�F�<�4�?�{��Mu�����o�h��*[!sp��\0�B�\"�hcv�-kmKJ�NӴ qF�Xk\r\r\0����+E�[[[a��mH)g�o_�`Ek��Xk�#�X�R����q����(�^��	�8A&F�>�Q�3L ��*��Q���W�i�\rƽ�a��d��V��̰�¨�¶�\0$��Kk�!Ď�v/�V�]grl^D@h\0h\0�\'IҔR.\0X��,���<�;R���a����z�~�e�^D�Ҿ�>�q��$�9��O+����F�j4?�)�\"�U#�Q�;��Z9���>0�0�&�B�_���v�Z{G)���i��\0��4\0���q������7�s\0��kB��\0>�G�0���jh6�h4\Z���A��@��D���}1\"�z|��۰�O�f7.�>*Z&^U��Q�=��5�?��Ӛ�a�w۸c]eV���-\n!� �sh����Xk?-��k�B��\0��,����aM\0�߄����g��:�NS�\0`%��Rʧ��;����u���aaa���XZZ�����B�Q�}��w��(����E��Z�5�,C�eD�����3|ǽ*�	��X,��UMȴ&b���{��Ao�,C��C`���_�4�=�� ؍�]0��B@�X��3�<nllD�nwF���:���`���B�m4\Zs333XZZ���\Z���T�;�Ӥ���ɽ�z��J�Y�!I��ɿ�*&�E���ɲ있r��2(ſ��<��e�1���}��yT���������f L2R�n��3�i�\"MSoവ�w����s��Rj7I?$0�	����\0�\0<��?`Y)u.�uk�I)���lbqqkkk8�<\Z���u��F��>���i����\'t�����?��y~O�X�,@��l�t�Q�o�1�wY��ǹx<����~��f���(�0Jl����[+��^��1�sRʟ�־a����3�8���Ah\0h\0Y�}�v����FQ��|��<��Q�nn+++8w�Ο??�*�3L����ѭ��Iڧߋ\'�a��a�`.�;.͝�F3\0\0)�-��1ƺK!��i���1����?q��G}�����\n!n\n!z�w��k���F����*��Z{@�Bkm��{>��g�_����Y\0���f�)q���F�lF��a������m�����;d�}I��[k_6��PJ�I�tZ��7��xh��ʕ+�o�Q�t:sQ�ApQ�V��E�;p��\\�x�������ǭ|���t��/�ы�Z^Ћ�^��m���Ѕ[������/�2n\nؾ�VK)[Al\Zc��G`�\Z��m���`��n\\�wy�ܑ_/��ѵ���|,ŭ�p���J)�*)���Z)�P�����;�c�*��w_��kQ�֮`P\0Xs�-yf��ò�2�D�i6�Q��dʆ�8D��?\0�h��^0��x�&4\04\0��Pkkku�+�օOk���z�����E�?O<�Ġ�N��\\���	Yk�V��N��8��$�=Ѽ/��Ǽ(��qz�e��-i��K~��%��UJ�B�3\\j����Ƙ�3XeNk�W��FQ\\����rQ�B��)�¤ij\n��3\0�9�F�\0� �E�^�@��\0E����)�K�.������(m�d(T�vc̥��\\���\08�~�@`��Ϗ3���&��4�<�3jf�����M\0�Oo� �J���	�<\Z\0\Z��^�Ϟ=[k�۳\0V�(��۴���z�����e\\�poy�[�e�=Ǵ,�A`{{;;;h�Z��z�Ȫ���n9�R�[�v�;�^���vkm����n�m���h�u&�~���,����Z[��R�~��._��cowvv���a����\'+0n����}>�L�e����d�1R)5�\\�a�˦�h&�BNL�\"(f+�ue���	`��S�\0��z���d�M��	��ߺ�v0$���%���[k�b���j��\0K@h\0h\0V�.\\�����\0X�R^���-Z��h4޽����/��\'�D���D^E�WJaww������E��E�H�Ƙ8��!Ć�vW�\r�\r��M)eKJ�#�\\����x]�k�skm.�ȝ����<�5\0�n�.��\"o]do�@�K+�4RJ���RZ��u��@�/B�V�]�����Y\0���?>M9[���	�S1#��!�r�&���(�i�E�d������{��9T�\0��2p9��$���/��b��\r�M��\r\r�W)��kB���Z�5k�� ��8�Ǆ><\Z\0\Z��|L���zmoo�	`YJy!�KƘX�վuyy���xꩧƊ������}�6�������<Ͽf����R�Z�1&6ƤR��-�D^�Ժ{�B���f��:I��}�mFJi�R~�RJ�\r���j5[����ܜ}��D��1����?��\Z\nLc*\Z�F1� ����0G���JJ��km��R�5)e�ӐR6<e��&!�ۄo�&�^�W6�^�O�|U��c^p3��^��r&`h�@��	\r\0\r���˗/����Mk�1�\\�^����a�݋��x�\'���O����?�c\\�v\r������G�$o(�~U�b�e�\0���^����2Bd>��R�E�z���]Ji�04#�}�:��T����gX��h(74 ݥrف�ZH)��ں�	`NJ�l�}7��R>�טUpXn]�|^���־�f��w�_qЛ\0\Z\0rl<�N��<�Lp��͚b����<�?�w�����ٳc���H)�n���obkk���Fk�GJ�_�Z_7��h�w��=)e�a��i&��J)]�0M1Z��v/�kkk�c����:?��K��G���3\n�^O1\n�j4\Z�1&0Ƅ�̸��m!�KƘ�H���Z�������������Zk���_��0̳,�u$S� ��<��LmllDqτa��\0�B<;;;���U<��C���MJ���=������D�ݎ�1��Z�[Y�mXk��֝ �(��0�����1kkk��N�0�j$�9�\0a�^��y����H)��1�fY�Ag2�iJT��VeY�a\07\0�&�,��<MS_p�	� \'�������݆+�:+�|�1�����VVV����z�>��\'C/���ۃ����B�K\0��Z���|�Z�W�պ����K���{NS��	����B���$��@/��XkH�?��8`�5�����Z�y���\r7%��j:I_p�Ń� \'��˗/�\r!ĂRjM)uQk�3�fsqqq.\\����o�sO䯔���� ��v��*���4M_�����bo~~�w�������_}�U�Ƀ0���N�4���:�s�g���Z\0�\0��p����w�Zk#��?p�U�$IR\\>X�S 4\0�4���r�z��WkR�Y���R�1��(�����gϞE�e�cc�^��J��e٠e*��������^�nܸa��m\\F��ql����ן\n!��WZ�E\0_\0�Fc�	\00��ꦴ�\"�\0����K�\0�\r\095�k׮EI�4� X\n��<�o�R~��������O��/\Z����q�� �i�e�Ŀ�������K�k�C�i1\Z@\Z�q�^��<υ1F	!�����E!\Z����n��r_�o\0�%��Ue��!��\0�����_^�t)�s�NC�(�\\SJ=�����������+�s��E��?���U��u�Զ�u����^�)����$�c�j5��BRʟ�Z���,[���h������x��\n�P\0� T��3�<\\�~�.����.����O5�����e�;w�FZ�{z�!�j�S��8�����y�j��וRw���3gΤ/��BƔ?y2I���(��P���Y����o(4\r\n�Oõ�.���\"R�����HrT� 766�4M�\0�j��\0\n���>����6\0��\0�$	�]����\rt��הR�<��W�<���ږR��|�Ʉ�O�\"�$M�V�e�i��4�|\n�8��.��\0�X0��́�Q\'4\0�x����������!�ۅ?:33���\\�xq�짼j\Z\0���~�ߎ����4}9��R�m)���O>�<���9ş<D&�7�I\0�\0l����o��C>��8�A�u\n$M\0� �=��g�v�]�R΅a���:���߫��ͥ�%�?~�\Z��ϋ�Պ�?�����;R��3gΤ����U��l������|ȧ�a\0�\0�����\r�h\0\r\0��ߟ���Х��Rg��=ç��������~)��͛7���1����L�$7�w\0��?���C��	����M\0?`���\0�w��\0B@`�//]�v�݆bAJ�&���{fff�������}��E����۷����<��\\��Zk/��+++�������9���R\0\0;\0nx	��pفiy\'����P��B@NT�\0���I)g}��<��f�^�/..�����Z���߼y��ۈ�����Xko���sss1���G��	������?��*�y�\n�9��\0���\0.\\��$i\0X����a����Y���a~~���S�7n���;w��t2!�/i�������v��l��]��R��#jb\0mgn�_p������,�e\0�.��\0B@N.��g�N�S�R�YkW��\0~�^�cqqgϞ�������������`��/Z�ϣ��m4\Z��������\0?3�n�_����񟖷�^��\n`��\0����lllDY�5��a�Yk8������={J�{��B@)5�O��M�ԯ��eٶ�����Ȋ���\0,\n������|?��q� ��~�7f\r\09������A�5W��j�y��;fff�������A���\"?>�����n����>��ƘMc�~aܟ�O�,����/\0��C<�<�ý�\n 4\0�XQ�����oQq�Z�l�^}��e�б�4M����V����\0|^J�`��htϞ=�8!�q0Ţ�mg~���G��U��\r�,\0� ���K�.q7�<���h\r�7A����Y�����l���iJ)ܺu{{{H��%���\06�8�6ƴ��\'��	��\0�S�-\0��������E�7���7\0� �\"����۫I)g� XB���F����E�9s�����B?�n;;;�t:0���1�Mc�vE�F�����K�X�\0�[�7p��0@h\0ȱ{����0M�F���R�Uk퇃 xҏ�A0���o߾���}$I�B��1f+˲]cLguu5������\0]��6\0��/�)?�~A�\"�\0��K�_��?[��W\0���~�O�;w�� �����@�����>z��1j������Z���f�n�Y��ʁ����\0���i�\0��3��������i�6��Ƙk���a�477�����_L�+��I��R��5�ֶܱ�(�?>�����-\0_��C<��\\@��Z !4\0d����ԔR�J�%!ēB��j5����̙3\"���qcoo�^��O���������?��r�t�_�1��Au\0A��}\r\09Z��eY]1���4����VWW��)%����n���i\"��m���1��a����i�lք�mJ�-t[T�j����m�~�����ۤ{=����g�n\0��C<׷��\Z�/\0!xȸ��ڵk���sQJ��z����y���!˲�ѿ1;;;~��3\0ޔR�FQԩ��	���}.r���,�=77\'�1��֊�%��\"�\n!��t:�E��������w%P\nx�	�ۧx�\0��6���k\r�\Z\0R=��`^J����Gk�Z���//��{�K)q��?��I)���8���Rݥ���ƍ����=�QB���ye���Z/��Z+��^�%\0�.e��S\0d���0�r!����� ��B�L���\n!���z=��W4����\Z���I�h�:��\0��.c{��w����橍�\0������ףB�AJ�A_�����4MD�~��s���.�1�B�n�ى����cS�?$��eqw�r⮬�� ��Z��8V��@)����?���oS\0��rpkm�vC�KQ2������#�4N��n�Ʌ�Z�!��V[k�1&����6o��MB^0	� �4	��A(/t���o��)����_K��~mAZ8���\0������ 欵����>;;����A�_)��_)���\r�Z-�q���c����鞔�w������ۏ�	ȋ�w}�w�V�%���d�����_��\\���{�WN�U�*�7RP��@JXk!���})e ���;qWƘ\0g�m�o;�֞����3en��Y!�p��8g]q]��\"�ȭ�9�\\J�ȅ��[k3\'��Xksg� �A��~:i`�\\�2A{�B�7��3�	�=Sf�*�K\r�A��`\\8Ƅ�\0���n�)�f�RK\0.!>�h40??������Q��~�__�g����%k�N��(�ʱ����q,:��L�T���J����g?{@����� ��Љt���ZXkC\0J���}\"\0����/��b�m:a_q�~�=f��)������+.ی����m����7���\0���{\0��-��t��׭���6�Rf\0�,�R�fn���.m�,ãb��Z�~��\0|���V\0_��0��\0��L����pgg�f��QJ-Yk?EQ�8����(�������=�ql���g��v�wuu�TG�â�8��3gd�e�s����Z+km1���Aa!������yh�\r�R�����1��%k�B�k�Yk��yc̪3�R��g\\��yQ�m�����c�aF�]�y�0�,���B�V�e�q�v��U\'xو-/��Q��Q1��\0��,��0]E��\0��3�\Z\021��R3A,X5�|�W���� M�4,��ZY�U!�N�� �^x�T��/\n����c�� |��1�ȉ|h�����6BԤ����\0kB�5k�k�2�k��(�.oRʁ	(��r�_�%��Ŀx���O��2��Zk$I2`��Mϙ�m��p׷\0�Q�`��.G�|H�`�9(��s0�C�W|�f?Uy�ۊŀ�\0���#��.]\n����Ƙ����a���?��G�^����>���xo~~�733�mnn���~�}�Y���)666}���3��� �7�.��0�����ȥ�#�T�J)kRʚ�62�<)�8������.m�R�x��,�J��M�ȋ׽)&�U2\0�S4���oϲ�v��p�\Zn�0���Em>kp�en���1���c\n�9(6�Y���7L��\0~���1j��@fh\0�s��U��/~1TJ5� X�R.c��^�cnn�@���R����Rʝ0�y��\'���W^yE�z�����ښ����}��D�Ŵ}��zWh�q�H)Us}-�:������\"���e����r�~��{A�?�v/�w9?J̫�b��g�C��M�Z�,���t�����\\c6џ>W4�ǔ9(\Z�������,���~\n�\n�i�\0�v�a�a\0f\r����N2x��g�k�T�$� f�K��+A������_���\"����W��߷�ncvk�Zonn���q���+WTǢ�n�,������?�YzcLQ�C)eh�	����wc�R����h�Yp΍џ5Ƭ�#r/�����J��&�D�RĽ�[k���Ha/�ɰ��0�/\n}�*�^|L��@���t:�����8s���As0� �;Us`�	o\nLg<�9(��k����j�\\`w�}���)�-]\Z\0�\n��r劼s玺p�̲Lj��{���R�O|���8B�I)�]�����{Y��R���A��A��oJ)����h��Z�x}}]���v��W�^���}��\\�������|A�ad��������� j\0jZ�K\0֍1�o��b�=+��A���A� ��\Z\\*���@Ћ���3%����E�ea.�g\\A�߷a�^5�0�hx�w��4U4;��\r\0םX�¤^�\0��,��Oq��ܝ\r�;c�LB1(0C�q�Ih\0�i�g�yF]�p!��8��׾\ZcBQ��q6�s-��\0�aM�b�=#��:)�;��?i���ˍ���n��9!�V�绵Z��l6��W���B�S��1�R�>� \n� ts�k~�^)Us\'�����y�Vk���UW�w�<����Q��0D�K��y��Tl7J�\">L��f��0,0i����Z��� ���\'3���D�)�t���B=�9�3�0Dh��rs��\0��Sd\0����o���q�9U�t�#���$4\0����r�Z__��n��oDZ�(��1��ƴkJ���V	!$��^r\0�R\n.%���1���fS.--aqqy�(\\�Q��r �Ƙ�0�Xk�EQ\'��xeeE���菪��MQ�^����|ս�:(�Ū� ����ϏBDRʺ��.��eYv�:�s��5׼�L1�ߧ������(��zc�`\\�,���,�����~� W�쟔\r8��k���v�����ָ�D��v����+N��\r+L3S�L�����?�]S��s\0��B��i��{�\0wMaSg���J\n��ih\0��g�y&���	^~��(˲�R����J�� f\04�1\r\0g�c��sRʗ�0|Չd$�\\���_����.ܳ�_Q,�H�Y�A)��R��u{C�V�^}�U������ZKc�4ƨ(�B���D��1&��(�Z��f��)��.��BQk��\Z��ދ����0����aBJ	k-��\"�����G���*c~����W~k-:��_��q���)�O���N_�]0��z�A��7����oA�ߪ|��\0��L�F�g\0̸}��nAe�G�e=:����744\0�~���V��o��<�����J�7�o^����F�+�/	!�>\Z�\'uc̶R�Q����,,,��/R�����K)�����4�Z�\Z�97fo\0?^�a�eY�����Q�5cL͏��j�z��OYk�@Zݚ1�1f�e*�y/��4}���a�^�C)uO���ZѲЗMϰ��t͛$Γ��L#�婀�k-z��_ہ?��,��Ґ�m;s����[\0�,��b���m�9{Ɖ~�O�_��*!����sf��W\Z�b8uf�E\0ϣ?a�m-���HJf�<ZB\'��<�c�=�B�#�N�SSJ5�4���h�Z����<�c��RO�Ǵ}$_�l� �/�;s����@����X�^�u���?���S�n�f�緒$ٓR�N`��7h��~U}#����\'��1kR�Uk��ru}��΋|��j���z�@�ݰnv�\"�I�=��n�O�*�7�?� T�T���q�N�3��ɉ�����7-��\r��O��.��h����\'N�O�}\0���a����@�``��C�\r�ca\0\\ԯ����v�]SJ5�$���h��$�\\�c�G�R��LE���z�Z\r��7E�B�V���lbvvv�/�o���\'����n,���������v�$ɾֺ����wLi��������sB�3n�^���\r+���_��P��4ƩҲv���I�?��O+��A��4E��7�S���w����ޯ�tk��u	~���-���u��s�9�l\0����6\0���������n$�h&I2#�X�R�!V��o������P��T�^����`������܁��\"6l�Y1�[,�+ޯ8�-��曃F@I�S/w�+F�~�Q|�̊/�+�����qW��{<M�?J��S���h�Zj.?y��$��2�����1�]���P�h\0Y ��W�\\Q7o���v]J9�e�|�V[B��d������T������cqq�����v�֧���_���Ap�p����8_ޏ���(�\"_�0�E�����q�r�D���Wy�a�s��\"����#�FZ������ݵ�I�\0~Wi\09P�����kB��$I�(ZpFJy��\0��^��gff����� b��k�}%�����G�i����~E�}�&�]Y��5��O�\n�ƍ�W���?�~Uſ���%�q���#&G�e\0?��;=�g����%�~�\0<R���_�p!�Q?�E!Ě�,�o���XEO4�M,,,`yy�Ν; *�%`\'�	�}��v������Q6U���\n�q��a�\rR��<G��:�����%��\0����l@w��m� ����1\0��cc#0��|+\0�*�����ǂ ��F���ҼgΜ���b?*���?�3n\nۨU节?n������l����*�r:��;�\'!�ƘA����\0���|6�O<��\0�\r�Co\0���˗/�w�ܩ!f�$Y��jg��l��\0~�^�/���bii	gΜ���T��q���qM2U���7ISPw�?���a^���O*l����z=t:�����u\0�#�3n�?[`w��l�_4\0��k�y�ҥpgg�!����.!�)�.j�R)uuffF.,,`mm\r.\\�w����¸9���Gm�3�@�8��H�J���?�m0\0dY�v��t?����g\0�w�|]@zT@��x�\r�\0 ��ף������V�R��Z��(�<77����;w333����߯ϸ(s�\n�i��@�J�0i����8�t�o�A��~��!7)�_D�.�:��}O�#��~\r�~�~����z���v-��uc̷��f�9����3g�`}}}PU_��}��~��8�/ߧ��.�a������8:�\r�*������������$I4����_����;8�42�x<@1�WJ��R�k��W�7ggg���E\\�p�����l娿j��q	���g\'��f7G��?l��4����F��,�3M㎟\'�2�Z-v�#�		�Y�9��x�(d	hh\0���˗���ͺ�����������Y�����/bfffp\"/�����~	~U�/G�U\"���i��G�&8�9)����[k�j���\'��P�K%`qw8��\0<��?\0�\Z��YkW�(Z����J�����kkkX__L�+F��V����?N�\'-�3i,�8��i����Ӛ�qB_eU�Q�������gu?y�>����4���\Z�G3�?{�l���l����z��1�Rʟ�������xꩧ��\ZD��\"�a]�&����G=OU�27�j!�q�\r�>�J�ʪ~U\"�Ø�inw|�������*��\\ԯ& �	�x$��ҥKa��k&I2�Yk���ڟ���U���x�\'�ח�ךw�H{�aĿ�(��OkFE⇭௺\\�u��oK��V�Q?yX�Q�W�=\'���	`=\0\r�#�\0 ���jƘ� V��1���h,...������&���{Y�F��2�p�t�S�ǉ�qw<�Z�*�i���+�%I�_y�Q\0�W�7J�V4��xt���$I�I�,�j�3Ƙ��sssX[[������XO��*\"^\\��lʏ��jvZ������^530��*&�$��������j�8��<*���M��	�\0��h\0~��g��ׯGZk�?)��p�����.\\��4M����:��GJ9BH�t0� DQ)堟���B���	���_5%~�Mx���ϴ��Ì�Q�_k���}�i�_y�X��\0�?�	H\n�\0�\0<�`gg\'PJ5�1�a�j��V�������ٳ�����MQ<�hBA�v����=�z=�q|�q�R\nJ)�j54\Z\r,,,��l�O��,B��iǾ��L+�U�\n+�U�aşQ?yx�@%�����8@��r�����/GZ�!��KB��h4\ZX\\\\����wX��b�vvv���=����7	B������f333XZZ�������t;��B���Пv�qL�;��Oʬ�yΨ�<h�����~�g���u��ba �x���۷oJ���v6�e��Gk�Z����-�;I�����o��vww��v�$I�Z�c��\0lI)_SJe��[e�Y����I������j�{{{����ٳgQ����Ec0*F���&Z�Ґ�$���q�����n3�\'��6�/\0�\Z�����\"q�~\'��[\0��moq�\r\0?��­B&@�?$@h\0:d��\r�<o!��g��W|�_���~Ƶ�-������۷����8�;Z�������ᶬ�q�e�1F�RJ\n!jB��I)�Z����$I��q<���p��,//V\Z,�!���WE�S�7�}S�wX�w�IƨJ̀1{{{\\���O��g\0`��� ��\0(\0/�c\0�\0�\0|���Ӿ<��_,����H\Z��_�|9��߯\'IҌ�h�Z�]Q5}��G��V���MB�~�:666���o�<��ԯc��Zoc��1�<�S)e&�0\0�繴�J���rFJy�Z{\r��z�����$I\"�8�ŋ�C��!V�aErU��(S���W���Q���RQ���/��1��\n�k���<����\0�p��\"o_������\0�V�\r\0s\0n8��Q\0ߍ��?G�\0�)�=��E����1\0�V+Ȳ�E�<�Ek�k�\Z����h4FF���5���\0o��&666�j�ZƘ_�R~:˲[�ڭ4M��0�FQ�H�RZJi������ja�e5gH��ֻB�-��WvwwTk=��9�|���=j��ì�WU��C�\'���5\0&�ӸT���w,P7��\0���?�\0���},��\0�ppˉ����[�-p[��L�.��\0~\ZG��\0��.�������\0<\\\\�rE���K�ֺ���]J���Z\r���c���Z;�[�n��noH)����y�ߴ�n\n!��R�(�����lmm�<��s�իW������\n�1mkm�Z�6ƴ�R� 6������z�Z�\'�|Y�\r���\'.�P�vU�Q\"=M�=Mf��xW�/�gT[���,2l?�Ȳ����L�2}�	�\"�s����}��wh��ڭB�\"�U\0���?4t\0�Sg\0o8�/\n����?J[0\0�L@�E�m�w����8?\n���	�Y	fh\0���Ν;*�\Z��Rj^k��0133����y>2��ѷ�۷o������̲�Z��Z��F���{����^�oݺ5�yF�\'�g��������B��Z��i�EQ����\Z�!��ב��@��S�]�o��W��d��\0�ò1E�/wX,�L�2����T�B�����d��SFO��\0|�Kê��}�5w�o���o�;�����;�<颶�M�~��i\0��)㾐�9\0�r��FA��R��k\\��}Q^�I�8h\0�_\0��#��5\0���o�����1\0�^O�y	!f\0�!�U��033sO��aѿ�V����\r����B��eٗ��o\Zc6�{�F�w�ҥ���Ӷ�\0���!2\0�ҥKzggGc�R�dYf� ���v�+��A`mmmP0J \'��a���D�e!/�aٔr?츗�[�4��.Ih�\0Z��pbѤ1���H���_t\'8�\0���Il��\0��,p�s�OTx�]��N�u�+���N�ј����?]�;1��n\0��\0�����{�~{\0>�2	߇~��4l3�0�������v�?M���z�_�����.e��U\0`���0\0\r��7\0I��y�ׅ3B�w!����(�Qp�c�o�c�u����rwuu���K/e����T-3�Q�B{��e���e{��i4\Z\"�2�/�Z��� ��jh6���t��	ǉ�0�W7I��\"^��F���\n!}����@�e�sx�4�?	��XkE�eߞe��Z�6�>Y6I��e{_�.\no��\Z���H�����h^C�Z:t\'��E��1���N��N�3�-�o��\0_rr�`\0b������N�o���lEѸ�߸}>�o�E������p�o�����Ž����|ڽ��8������[�Q����8ݸ��(M�zE�Ƙo����냞����~����\r���\"˲� ��4Mo�y�)��[\\\\�_z��Z{�~�>p��elmm���z�Zk�4�����?E�~�i�iz�A��(}�\'e��]�b�}ؚ��!�������e�BlXk��~�6X�iX/�@��F��/)��s�{\0��Z�3��w5\Z�{�g��B�׃�_B��5w=r\'�O��	�p��\\wۉv�Sea����N�\n\n)�I��o�^{�=�$|��z��}�Nx���{O�{�\r\0{ʯǽ���������/��+D�G�o�������?���C>�DX�k��B\Z\0\Z��\"��v�*˲H)�B�c��;��[���y�c{{�nWK)3I�[���z��_��z���Zz�/��K�.�;w���yh(�~;��o���?{��m����3=pXt|��s&e��_n���)�,�b��A1;P~?���va��#��\'�1)e-M�oβ�j�ٔ��3�ۢ1�Ϭ�o:1�ekퟤi�.)%j��`�����	lo���7Ay��1�����T���N���vA����b�������A?%?�����{�w�WμTi{���/�d��=|Պ�4���v��a����9�O�1�S��F��L@�w�}6\0��r���F\0���7��8� MS�����M!ĢR�|Eh4\ZcW�+F�[[[~���Xk�f�ݲ��[k��/_ή]�vl?o.\\�����۳�ni�oA�z��O���aiii �Ņ��\n޴=��ѿ�@�q�#�)�\0�z������{���t��vSk��|�e�\0b�uC�`���=���>�Q�\\�뵄�����%��Z�DJ�Ec�~���a����)��7\0�������\r�|m���$\\%�Op��k��R^2\r�u3Lx\rw�Z�}��Qe?����;3.:��\n`w�v�{�D���E����\r\r�8Q.V�ws�>˞{�mw�_�tšE�p�%_��(/4\0���W���~���1&RJ5�1�	�0��j�����\0p`�Q��r���Oh�����Z�;77�V-���ş?>��ٍ����Z뫝N����],,,�/����+���<�p���v�>��K�ݲ���4��4M�#MS9??�����^Ƙ?5�|�Z��1斔26�4�������~�$O�T����$�S#�B�Xk���w�~Jc̎���<Ͽ�uiu��B��E;v\'��1~�G�E���rZ��؊\'��f\nۤě�;e���.�Vyމ��s�����_w�􆋆\r�����?\\!���37�m���\\:������Ԟ;�~��q�?|M@�>����>w�\0�V��|��\0\Z����榬�ja�ݎj�ZSk�N�������]�)ꝝ/T�	!^�Z��h����u��/��Zk���K��4M�B�=��6��$y���`aaa �ŕ�]����5\ro�ah�����\0>i��0ƴ�1����7��������bIZ�m�ݰ��B�Rʹ<�� ���6˲A\Z��Ka�\Z�������R�Z۵��r�&	�)DѢ ��\'|T�qw���Dq��(�(ߥ�И\\p����K�*��~�붞;v\0/a���~�Ö{��E���`\0~�*���l�mw�o�?���%�-���uOJ@} q�O���L?���vgμ�8����\Z�Cp����<�C�T�S��^���b;����\"�8�a�y�Z�A7�dvv6+7�9np�ҥ<�Dk�5��+�>��y�$��i��4�񢯵,E<jѣQF���\"M�W�1�I��\r��+Z���e٫Ƙ�\Zc� �ct������|���m�<�[Qu�1m!D@���Z[���WC�%��ذ�&.�J)370����)�x��s�7&yL���d�?Dx�j\0���d\0n���q;E������Τ\Z�w�]�]T��._���]�����u�ո�~]�i���ܯ���`z��8��=�~�H��\0u���\"�,�Z�@)UB4���R���#��E!�R\"I/>_���q/��lee�$R�x��t�y��1�`�s3˲AJ�(�e�/F�@�ŰRj`��R�l|�e��Z߱�nh�o����\r!�-�����k~}���t�i�1�\"K�4\r� O��G���ߢa+\Zk�\rkm\"�ȥ��R*B�I�$Ƙ�GQ�)� ��]*�Ux�q�W-�w�}��D��f/��j�5���8��\n�8ą�B�� 6ܶ鮟����a�Y�������\n&����3\0a!@���PƘЭ�wQQ��*SԴ־��oZk{B�,���o}뉧�����\'�НN\'SJ%���V��O�i�z�>��*�������]�z��� �R�5\Z\r4�����������Zk+�l[k��{B�}\0a��5)�ֺ��eف�n_�¢?}Ϻ5�鿐-f#�ߥ��w\0��Z���B�e��ۇ8��f*ڝ����{�w�Zz%�?��k\\\r�v��Q��%�ׅc�9q�����ظ��}��/��΂�f1��{-��މ%$qp���ZUϔ�Z{Gx�3�3\0��8}�@e�	� �Yk�\n�\0~����Z[쿟Yk[B�L�}쾌}��u�!�ɱ�S�^�5�g��R\n[[[�t:[a��1��z�?��y�G���Ŕ{?|�?�1@��΍1���b��������� ʳ�{>��\Zj�&���Zk)�VJ�����x��*�Sv[�Q��S�8����Q��	�����醇y�n)�`Jb�L�|���Q�j�l�U�}��~1�/��VTk�tzG̸����S���@�f�\0\r��fssS�����jRʚ����0��u��utB�	!��J���ǵb}��^3&�ò�\"�b������R~����7J)垵vq���\\�b��h\"�1��1)�uQ��Rj)�6�0��+�Pxl@&��i��4M�1I�4\0��x�\0U��`�DoK\'�Qĸw�a���Ĭl:�����_���>�I�\0�5�\Z�.��C\'p�|?���9)3p��s��!3\04\0��$I��ZA\n!\"c�j��j\Z����ϱB�>R��¹��򫵶�Xm�؏��7�g��\Z�vY�}U�5c��\0v���Z�RJ�Y�e���t������#��O��Zk&�pb��ej\0�B�eYy�(H1�_�\\P7*P�i)Ϸ?��SQd��Gþw���1�q�O:���;@��/�{���+�=�1h�Y�;@h\0NqKc���B���Rj��V�_V��7	��.��1Rk-���p��܏�!�D�1ΰ)��2\0��t:�q��W�����[n��B�<�笵/�q|���h�4��R1S0n��C�����As�~Rd�#�xߣ��qTyΣf/��<(OE<��W��pT^@�hp�(���l�\'���\Z�<��S������o���G\Z��3�a�QJ��ZI)��R�p��s��)�&@k}AJcB���z��w�B�,ˤ�6�Ō\0V���e��^����~5��]����r���i�w�1��y�8�G��7J�G�xU��������!��!��s����k����ᵺ#��a��=!C4����������	��3aA@�xz��������8Ո,�\0�g|��H����k�Q����oB4� �j�Z���y��իWU�$A�5!DC1\'�8��i�;L|]!_�McL�k�{�Z-QJ�N(^���Eq�\0������e~�h�o�t:��������ڏ\"D��?H�q?ǙG�Τ�Ƀ�3����|�[\'���ϋ�tO��/�u}��Y\Z\0\Z�S��ZZk����!��`Xj�Z�F��0!�|\n�����eYmgg\'B���&�׮]SY�ERʆRj�� �Z힪�I�����8���6B�B�a�q���U���y>0\0���̪8�ʸ����E�՚F�OZ��u!��Dh+D��^�8�\0��)yř�\'��z�������t@:�Qs���j�4��Q\Z\0\Z�ә0�Hk��RB�5���GΣD�h\n�1���C�р�A�(��,kt���ʕ+J�+$8b����j�.zX��^	�\0�f��J|e�2��l\n|@km�Z�k�3)���A��o��B�}k�����e����4������o�Au6{Q>��=�c2b�vRtpp\r���G�+?�w���L!pR�S��9r�c���:t�`�Op��z����\n_<g�����}�@����EE�<Ͽ�Z�Eт�r��͛\'�B�W_}5�v��Z�6/�\\�V)�{��&���L�+v�&�Ì��\"u=L�$FJi��6MS#�����F;C������\"�QY�2~�\n��\n�w\\4\n\"z\Zw��ŉ1�TC!�8�=�;��8�!;��}�Ņ��pwQ���9��}�1<w}�y$4\0��V�%�ͦ����Yo\0�F��\0c����f�	)巇axNJ����l��j\\�t):Ρ\0!�x׻����ՔRs��e)����j�Z0;;{�3_Y����&�S��1��� �RjН����U:	˲S��?�褨�Y8y��a�څEw\"?J$\ry������o�<Næ/������\0V�g�M�q�q���8,��\n�;��\0(\Z\0\Z�S�1F�a(�R�b�X9�~��3\0Zk���`qq�z����#B��A�\n!�www�/_��!ĕ+W�۷o��8���.+���`��,\\��b���3\0\n�3�;\rm����a�{�~�Q�B�$����(0�7[�	����G<�/b��/<�A��Ǔ\"Ãk��诪��y�[P���>zL:S��?�p��q�k\0��Vh�)}ũkÊ\0�e��8s���.�,����kJ���2��z��;w��˗!�Ȭ��j`\"���z׻��^{���v�(ZUJ�WJ]���`������`\\��h���a�]^\\Ǚ�A/� ly��Q3\rFeO&�����i����\\ا*��i;N7\"?l \"������Ig\02���xNr�o��r�7qw=	�~3��_#����g2��+\0�{L��\n�E���#IQ�\'�M!�`\n`1���\rw�1�\0kkk����Yk�vE�R^l4\Z��8^���l����>���\n!ć>��੧��nܸ��t:�a�Ap1�KZ�_��ז����G-_\\e��â�{n5�`*U��8�OKkQ�~��$�:���;�;��$>j�Q�~eRFE�~��O���\n��\0���Zw�q�:�؝6꯹����\\t�g�q�C�?3\0�k��@	!����\0���be}1����4Ma�Yj�Z/��繬��*����������K��������o}����>6t��B\\�zU]�|Y}�_��8�+���0\\RJ]PJ=a���z�����E������(����u�un5�aC\0##�qK)W��G����� ��h��0~�+D��R���Q>��Q�i�>��U�WT�������j���ϯ��ǧ�Wџ��^\0?��/��S�i\0\n�}4_�aV&�rWk�,˰�����_j���X)�\0>�i����v��$���줯��z~��}��%\0a�,�D��rmmM~���\r�,�i���z}�Z����[��?U��޽�����UdYv��i�36Be\0�h����H)m�V��nw���#�*�%��N������[Ǡ��s��N~-��	&�~51��.��E\'�ug\n�	�K��X\'�pw������\0~bB밨S��x���|�ŔR\nc�B��Pe��g�,�ٳg���v���B|,��O�y~�Z����]km��t2!D�d,����aX���᜔rIJ�&�|���\'������@�ˋU�a�����z��\r�$!?l/�I��.��LH;�~1�Ӳ��\n���0zبu������<F���oۼ���w��_��\0��~��	Ѕ�GY��8X���0Nvh��Op�}��G���ᓌ����ɲ����\0���3�V��i�mR�߫�j_�Z�h�[��^�VK�y�d#\\w�HJY�R�	!��o��~����������搦�`�ޢ9�� �_�Q��Ñ?!�e�}�����b���ri�*����Z��t;G����t��e����=��\n�?�]g�������(F�~�����D��ϫ�\Z���\"@�(��V+_h�A�e���C�^����������ަ�~��a~�5km���Z+���R�f�=�ƘwH)�Q�ץ�rE� *>�����\"�`���cXN�[�g��`Ge�$9�_�C�i��\rm{\"oO�����~,|�h�?U�\0��/|�\0?;�^~����o�>���z��\0��h\0Nm����m��b&���/^����y�����-Mӷ�i�k���D�6z�����j��F��������^o\Z�b��pϭ0|*ہ)n�L�a�v�Ai�����{�\ZW�;�Y�I�s���֘H�0��~����s�|�I��_ x�en8�e�wΧ��џ�� �5���\0<�ك��~=�s4�M��΢������!˲%��Ry�\\!� �R\n�Z\r�F�z}PhX��\'��T��! r풥�V$I\"��~\Z�B����J��E��;�_�\n����nr�9>l@�y�Ǳ�I�r�r��)�|�q�S��H\Z���d~@�FU���^�}]�_(��(�E�����\nS�����)����a�2�U:\0����!Ĝ�2B���vU���T���@�k(c�����J�ߏS��*�OrH$|b��S�������~ܶ�����i\0ȱ�G	���������a�����=����	�M��bo�!Ģ�!��� {�^��VJ��*�!}�o��~����	�I*�#��v2��Ű���bh�sq�sZy_N2ͼ��X�w��x�K�&��T㧶�7�,����q����8K`�}�͝/����E���\0�\r�Y)�1fNk�� �R*c̬b���BJU���9A�$*�!W%���$X�oxL@�q��4�qY���X�p�gџGO�?�\0\Z�S�%�cQlQ�&�����IF`�t�Q�=��ߴ�_�@�Z��W(�\ZZ��H)7\0��<��J�\"�X�V_�X�ey�f?�	����՛��B���sV5/5�`��c�G9n�q�������,�������u�\0.���P\Z_\Z\0A0H�\Zc����,��p��V�r�X4?��`Ů}���s\0@�VCE����_v��y)��֮H)/Zk���؅�Ƒ$�I��GC��ޢ��\nh�H�4�G��Fy]�i�A(.bߋ����П6�q��s��,��s90�q����	��#�0Ƙ��\r�����*\">N�G��i��\rk�3�5��Zk4\Z\r�y��\0����cZ��-Xk�Z��f��z`�X�!�[��t=j���V?�s��sT��d�T�uQ�f��ſ�_�|̛\'|�~\0�-g4w�V|?Ϟ�)�4\0��\0dYf� �\0b/x�b=_t7�?�a��\0W����J�W��\'])������~�Z��R�5k�*���Ro)��l���RJZk�1FcD��jŰ��4N����\'dO��\"�;>�>��������d}����7�y�E���n\'����\0\Z�SI�V����b���-��a#�r]�q�����������^|� 0??&I�<�?�*��Î��F(�5cLA��tj�VK�����o\Z2l�8��B4IȆ����߿�q�~D���t���s�wbRW;U�X05���y�{�Ϛ�)�%�\0\r��^�[!�`�����#�\0Fu�\ZI�+5�~��|�u�b6�Z� ��z�x\r;F�g�Ƙ�[I0@�u��uIZ1\"�Я�VS>_Y�c\"�����~��h����-9�U���Ҕ���o���4�,��<�w��<�q)@@p��R�,ˌ\"Bt�1��|���\"�I�>����s�\'�6�p��\0�\0!�5b���M��a���XI�d/˲��8�ҟ��JT�pp��(�5�����#��T�\Zq���I7*��f\0�p�\\z/�5Ln�#J��@,��\n����E��,�;Y�?\r��fnn�v�]\r@!�1f`\0FQ�����{�/�j��F��m~�5(��>��a�믻�\0�vww�c2yuq���\0~�JҦ�	w٨�E8��.\nP�S������p��d��ĆD��{��a��՜(���W����y�o�ןs��\r���̈p�=�{x<���	�8�<��sfqqѺ\09�=?�ذ�/�3It\'��A�/G���B[��p\\-@լ���@q�F5M\Z�I�����Z��\0��+�/�Z��ݨV0�C�Yw}Rt?�]+��_%m��(��azjB]�Fw�!���\0\r���35�z�Ob�[\0\\�݂@��^!{��g�_��5\'����?��jy/��\"[�_Z������)\0�\0�J��Ҹ�_A��Ǵ�ѳ�\r0��A��p�8Ӡ�r/��(#p�a�a��^G	��,˰��S��i�M�.j��� u�t�	¤�l��S�����T�텥�A�	ٓc�We+f +�����bHd�{�)D�Q�S��x�/�Ϯ��rE�}�y�@�xG��K\'���tw�\r@^0�����2y��\Z�-o\0�=�}������W~��\n�e�$,�#�D���(���	�8��O3a�k����u\0��ǝ��.�;뢼IY�.\n��~�8�Qm%5�λ�a�E��\0\\����`��P����i�)F���f��{��޻q�7�*��\r�s�3M�y���c��ϭ�>7��q�l@r4�N��̀\r���\0X!��ZgAt\0$�ښ/5`�U�����v��v�=_Q���!��:fgg�X6��@�j�������χ����:�=��\r|��NHbw��U|�yyꂈ��-����9w�&��50~�@���y0QE�׷�rν�K�涴��XE���П;�y�M��~�\0�.��o��?d4��שf����8}�ah�4�Ƙ�Z�Zk�Z�Z�e����/����}�,��Zlll��� M�M��W��.a��+��3i�^��z�{�����E��N10m��$�r\nſ,F��V\0���v��k����Y݉X�����\'v��9R\'�K�V�>��)x����*�gw��{�ꄹ�p��)\0-�-����+�r�����:���6����k\0n��~�sٱw`�\"��b�i��,\0�8e4l�$:�@j��5ƬdY�Z�6�\n8l��*�:L��<�����v�Z�\0>!���6�$�+�\04�s�ڷu�ݿ�eٻ�֘��	��Nx��?�y�c{{{�z\n��u��������Q1\n~���o��9g\"&�����9ܭ���g+�狸�>�qw���@��7�����ow����/tǐ/�\0~�g�����N�\0���W��~�t��\0\Z�S��̌�R�i��bǯI?,�>���������B����Ƙ��y~�n�e!D�TYk#c�|�B�7�<������RJ�j��sW��p�?�6�5�ܹsZ��8x��RL׹��\0�	w��}��\0~�S�����(�q\'�U���U��V��\n��8����L��p�:�{\'\'Ǘ�<�Cb[�\0����}/�џq�ˀ=q�˸���\0�\0�\0�N\\7@��yEQf���Z֥/Χ�F��S���R���@��έ��l��4�7��Z떔2�R�1&D����N�R��e��v��No\0���+R<��O�k�Os��F\0���/�(�m�\0T�����q�q��:���5�Я�����p�ip���+\0�����D���=����v��)����Z��Qh��\r\0\r��fnn�J)��67Ƥ\0nzP^�w�r����\0)%:�:��֟@?%|-���\0v���sss���8���ޞj��]��Ƙ���$yg��F�Ѹg��$SRܿQ�a����;;;�F2����0����C߃��y�>E��d�\0���>\\wѶ���x��W�u�o��_�38�;�59\r��t��sϙ��e�q&�H�0��VY�w����ڿ%��_�,����\0�������?�������\'}E�����:0+���7�$y��l�An̢AUfT�����ɱ�\0����@\0|\n�K���A?K�\"��`�̓Ϣ?��ܿmg\02�\0�X���ǆa����6B�2�dy�#I��;�E~X�b:\\k�8�a����v��ֺ�h4z�/_�>���i[r�z����y޵ֶ�mc̵<�,�;l�F��QFeZ��bgg��O���e�?�>i���~�N�������Fd�[Hh\0N�0R�L�j�;��\r_8L8�cYX�<!������2YXX�>��̝;����\"5����߬hT�a\\�b�{��!��bwwY��D���.���n�}��\Z\'ĉ��=>=��{�`\0��8���u#��R���HneY�^�74B�$���~ꟻ��,��LJ���<a�\n!���kkm2ʔT�i���\Z����C�$��r鸈ޏ�WX�-F�f�$0���\r\0\r��gaa�H)�<�}���1�G�Cp��80| ����aJk���J+Ua���.�_�f��G��WE�����1�8�<�]�	���txB����P3\04\0�?��� ��<�R�J���k\0�_/�/?_@]Q7Ƅ{{{��g��\"�+TƘ�Z	!�R���Rc#�i�\\V��n���v��!��0��4�\Z�/!���P~\r�*\r��\r�;4A@p��Ah)e��y�kƘ8M�A�[^ħlF\r@EB�SJ�����R��n�k_�җ�(7�/����B-���rN1\'���ج�I���E��淅��{���8AGh�/�3N�߃��0�k�1$` \r��B�V�B�LhYk����^o����	(��v�5\Z������ ւ X0���:�@!�BH\0���J#I�Yk�bI�)��Z�v`]�����8���>�(�<x>�~&q�NMg����̠��\n� ����V�H�\0�P`aaA���eƘ�ֺ�kY��=�c������5ܙ$�333��z��j��R�<�c)��Z����V�^O�04.\\���L�$�t:3a�\n!�)�.c��^��(��N���\rp��A�e���㷄���:����S\0}���]o\0Bg�_��{�I-��ߞ��`������/腅�<M�DJ�QJ�������+���OW����e��8��f�S�eR)�v�$��y���J��1f^qV)����G�(z�/T\\�`TA�4�?������I��G9ߏ~kg��O��b׿\Z�)�U���\n�Np�^E�\rp,\0�x�0�z=K�$�R�\0����K�t��xX�]�,�	����,..bgg��I���0�Z;��޶ֶ�1���J)Ck�l�R������333\n�\Z�Wi�����\'�a\"��N>�~������\0�����_��>}�i��@��Q��u��J��])e�+Y�}C��C�ٜz���pz��YZZ�����{�����a�)�T@\Z�5ƄR�9c�k퇢(:7333���Y܏a&eR��q�`ww���	9��\0�\0����&@�`\0�\0��w�˓��7(�qwQ\"B�P`WWW���v���	!ZB�����v/�oՅ��b�3���h�Z��^��<Ͽ�����H)k�ڷAЌ�hP�0,\Z\'��\Z���b����!�����w�߀gw����O��]�\0x��������+++Y���)��A|Zk��q�ˑ}��w��}-Aq�`���Ł3y����	!°߯�h>���\'3$�\"�Q��j��臐��������3\0���x��\0�F#�v����c�ٵ־���[�\Z���v/�V���0b?��P9�_|�I��V�n��F?��i�$�E�]\Z��uy�\r����� 1�t�1{B�O�u�QwQ��u,���E���3�@k\r����B����\\��*�_�-I�Z-~!Ӱ��������\Z���/}�KyEY��\0-!ħ�<���z���Q��VYh�����7L�����>��[�_���O9�E����P�\Z��30;;�)�|G�;\0>��)���=c�U���ab?I����Y�gRq ��B�A�7\0L��\0<�`eeE�a�c:Ƙ]!�fYfz��`\n`y��iW�7^_�I����������~����%l\0�\Z����|�3�V�ey�w���\0^2Ƽ������ P���ezG�y9�?N�����i��r�3�������i\0�,���\\Al�mi����)MSt:�{�\0��vԂA�d���QF`Z���z;\"��)x\r���\0��\\����7\0/��r^���u���3Z�/�z=���0��.���+�\r3\nU�\0U�\n~KӔ�������7\0����G��`� z���<�7������t:�����y�)�;���Kc��%��-\0`��?W��xd�\0�Ƙ-k�����q�����3�����%�Ŀj�a��B���\0�@���o�Ó\n\r���8s�L\ZEQWk�`KJ��y���z=W	,�鯚�?�2�_��t:��O9\n�\0���cp�\r����җ�����$A���[Ƙk\0~%�c�Z�A-����T�����j&��,�#����]ܝ�����47o�Lk�Z�Z�k��\0�gZ���z=t:�K���8��Q�e0Ɖ��,�#����S�k\0��?\r�}��=\0\0���ϧY�u�����Y��/fYv���,6\Z�U��z�W���x9����=^n��qd	�%fg�5x����?������}@�]�1�R��	�3g��[�ּ��\\�oB|�R����ϣ^�Ck=��o����m�3�>{{{�?^�?�?����g�S��}4\0,�V\0� ����5\0�=�/x�e\0��\Z\0�3\0+fcc#]\\\\��w����Z�7���7\Z\r!�W5\0U2�\\�oc�߱�\0?_:�=.�O�ۂ��s��?\0���x�#��L����\0<FX\0zww7n6�k�.�;J��gY��i�ł�a�wR�T�/_�iʢ��\r��\0��N�[�?���\0H\05��~w���~~Ei�Й�m,�c�?\r��\0��a��y��Z��R׵��4M����@��P������ۿ8��n���Z~���g��	�8���g|\n��X���%E?��;�%\Z������e�Z-�R�Ƙ�Z�<�~9p\\�_u���j����qÝc��x<���;�\'��\'N6h\0i��O\n�{�\\h\0?��Vaܦ��Yy=�a`��&�$��n����K�b�&���	��ޏ��\'�e\0f�1��?$0ϯ�#�F?�兟�O@/\0�Xk��3�0T�I�>����Y�q����\0_@?�9|���!�Y\0kn��,�\"���΂)\Z\0r�G1���f��i�C���?1.�	\0��E�Kx�j\0��\0�X�M\0~�_Bh\0�J̀|?��4�����?Q���pw��q�\0��}؝�\Z\0\n����b~�9��^y���8Y��iB\r\0�G�˵\0�ဪ����<���v�!B\r\0�_c�(C0L�\'�U1ſ9�O!4\0�g\0���\0��ۿ|[�ۅ�\\��BuXps���#���4M�$	<!�0@NS6`��W��?�y�1�t:<؄B@����\0�\r��z|���Қ���!�S���q��l�K!4\0�A������Ö�=.��Z��/!�<�p��\nV���	!�\0r���O+�����!�0@Nq��\0U�ab_���9S��B@N�؏�}Rt_U���\'=�`o���IB\r\09�)���g���q|���^@�;�@@�����<\r�	\0�\0��I2�\02\0��/-\0|;�x����������S\0�\0�q�o/9#P�@�w8S�����G����\0���6��7��r��K�0�)\Z\0B�e\0ƙ�*�_���O��Q8�i\0ʝ�\"��\0��2��)��2�k�_pƠ�oyH�C`�\0�|\r@��N�3����f��d�9g\0�x�L�/�$���}H�;	��&G։*��d�)x\r��%S��L�[���c	������Y�[�q����ZIЋ�^y]��#��}��}7�\r\0ſ�����\'��������S������P30��E�ԝ�`��o��r�����\"����ޮ(���E��YwiFl���W�\"4\0����>mß��n��@���~4\0���)�U�\n[8��I�6����e�Ӧ�\0λ�]u�Yv&�<xQ��\"�M�����vQ-%�W�ڇ	z�6[��I�}N�>1@h\0#p�\Z\0[������S�L�t�jH��h\n�B��o\n�bC?5�>~;�~q�*��=�uQׂ3��F�Z|1]`�4���m��|o\nq%��!��wS��[g��	\Z\02�V��1Uß�)�\'˲)6|�J�Y2��o{iH�A��.no)<�9�E��D̻}.��s`���P��o��[\0������)��Q�(Aׅ�\"����Mh\0�Q��������>��!�\0C2ſ%�5(�1�0�2��kCn�#�Ky].ɐ���ź�\rs%�â�q)�Q�y�;� 60N��׳,{d��f\nJ�\0c0leʂ-G�g�cF=N�\0T6\0(�pQďRL7i̝�Nh\0����gL������/��Ǟ�+\Z��}�#1�6��t��ʇE���(��\0<�&���4���qcX0|Fa�a�au��hF��N\r��	�\"��$	�?h�@!4\0���?.�5�e~	!�L�S�Ni�?)�9J��,;�s�	!��\0��&`�9Vx���B� \'e����?I�B�xT3�ğ��B��E�A�?�og�B3\0��۲	�$�y����B\r�è��K3,�w���9_����=J=(��Eh\0k\0c��娿�w�z���Z������<B�Qy/4\0��?!�1�d\0RgT�\n�����?rB�M,��\">����4\0�����\"е��2� �s�m?��-I�Ӻ�oq�V�8!G;?��R`�x?;�x@h\0o���v3!D�Z���Zh���>�\n�ߌ1H�����7\0�\\6���������`�!~/\0/��{���@&��ؕR����ό1Ȳl`��)����\0�ݏ<� ����3ѩ�m\0����`ӝ4\0��ȓ$�\n!��1���/c��j�u�eH��!��Sjd�\'\0���\'��~WE�[\0����R\0�\Z�o���q�1�\0\\N���~�w��\n@���1fEq�;<�}B�PJ�<�O�0\0~�m�l������lR@���\Z\0�\0���p�:�o1�I\'�/��;7���9�Q��;�.���0Y�icL\"�ؗR�`��~�������	 |���q?��\0~����>!ǆ�����Wܹ��|�����׶���\n�K\0>��m��7���\00P<����	{�V�5��Mk팔r��TJͤi�\0P��Y��o�ǝ?淵�~:��7\\C?��u��w?�}��Ϭ���B�|���\0@�	`�����t[�[�mO���\Z��1�z�����7���=v�}���)\\���c�&L��xd@���\r\0D�z����[kky���9r���)�I��c�h�_vx���}ς������0���F�q�3d���ľ�.��ژs�(lG=/h��\\�s�?/��s�߼�kS�0�^h\0)0������?���V��F��?x[��M�.����u�k�rr�猂��sCP:/��A�ya��@~��^ y�,kgP�bh\0��?xQ��e)�?��0�?��ҏ�_*B��i�pn(n�l�Q����f������9��E�\rQ:���e\0�?��)\0�|BN�a����*����B!�6\"�Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �B\r\0!�Bh\0!�\Z\0B!��\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!��\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �B\r\0!�Bh\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �B\r\0!�B@!�\Z\0B!��\0B!��B!4\0�B� �B����?\0�#����\0\0\0\0IEND�B`�','car.png'),(49,'1231`','12312','2016-03-10',0,163,NULL,''),(50,'','','2017-02-03',0,176,NULL,''),(51,'sdfas','','2016-03-11',0,170,NULL,''),(52,'dsfasdfa','','2016-03-12',0,175,NULL,'');
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
