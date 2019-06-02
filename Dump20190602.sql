-- MySQL dump 10.13  Distrib 5.7.26, for Linux (x86_64)
--
-- Host: localhost    Database: yachtship
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.18.04.1

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (2,'Basic'),(3,'Organiser'),(4,'Participant'),(1,'Referee');
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
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (2,1,33),(3,1,34),(4,1,35),(5,1,36),(6,1,45),(7,1,46),(8,1,47),(9,1,48),(1,2,37),(19,3,25),(20,3,26),(21,3,27),(22,3,28),(23,3,29),(24,3,30),(25,3,31),(10,3,32),(11,3,33),(12,3,34),(13,3,35),(14,3,36),(15,3,45),(16,3,46),(17,3,47),(18,3,48),(26,4,37),(27,4,38),(28,4,39),(29,4,40),(30,4,41),(31,4,42),(32,4,44);
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
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add event',7,'add_event'),(26,'Can change event',7,'change_event'),(27,'Can delete event',7,'delete_event'),(28,'Can view event',7,'view_event'),(29,'Can add competition',8,'add_competition'),(30,'Can change competition',8,'change_competition'),(31,'Can delete competition',8,'delete_competition'),(32,'Can view competition',8,'view_competition'),(33,'Can add race',9,'add_race'),(34,'Can change race',9,'change_race'),(35,'Can delete race',9,'delete_race'),(36,'Can view race',9,'view_race'),(37,'Can add team',10,'add_team'),(38,'Can change team',10,'change_team'),(39,'Can delete team',10,'delete_team'),(40,'Can view team',10,'view_team'),(41,'Can add gps coordinates',11,'add_gpscoordinates'),(42,'Can change gps coordinates',11,'change_gpscoordinates'),(43,'Can delete gps coordinates',11,'delete_gpscoordinates'),(44,'Can view gps coordinates',11,'view_gpscoordinates'),(45,'Can add result table',12,'add_resulttable'),(46,'Can change result table',12,'change_resulttable'),(47,'Can delete result table',12,'delete_resulttable'),(48,'Can view result table',12,'view_resulttable');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$120000$7gP7Kiq1YM48$vac8qUpu4X9uxOcdnsQ6aCXfmNqCIIPKSoDKIW5a3xo=','2019-05-28 08:34:08.703831',1,'admin','','','',1,1,'2019-04-16 17:35:30.759588'),(2,'pbkdf2_sha256$120000$uLpefBpA4tOH$CI9/dKLvCz4H8zyvUW05Q9z0SwoSc5ls2fUNHG1L+pc=','2019-05-28 08:59:48.794427',0,'Dalyvis123','test','','test@gmail.com',0,1,'2019-04-17 10:15:43.000000'),(3,'pbkdf2_sha256$120000$30Ymn071LXx2$cv8EKdsoE8v6ip5lFfXE8ZHpYf9x6v0862mvz2auSRk=','2019-05-28 09:00:18.807440',0,'teisejas123','petras','','petras@gmail.com',0,1,'2019-05-22 09:31:08.000000'),(4,'pbkdf2_sha256$120000$GhsN6Cz4oFZE$Sohf0l+jV1ImGredol5ISsDKntkmHvrSI8zrn6VBx4g=','2019-05-28 08:39:46.113318',0,'Antanas123','','','',0,1,'2019-05-22 10:20:41.000000'),(7,'pbkdf2_sha256$120000$n3u1uCZLsENW$qHctk+X3VIwpdWZP+ZR/zIBzogfhlTNhLxRgo3Z81bU=','2019-05-27 16:54:34.645341',0,'david','','','test@gmail.com',0,1,'2019-05-27 16:53:54.882638'),(8,'pbkdf2_sha256$120000$IpdnfpWMGOR1$S9sZKuptJ4IHdJoQlldfAmj7W2s3R83UagPjUCEUW/0=','2019-05-27 18:15:07.608191',0,'testasas','','','test@gmail.com',0,1,'2019-05-27 16:54:27.000000');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (15,2,4),(14,3,1),(1,4,1),(5,7,4),(6,8,3);
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
INSERT INTO `auth_user_user_permissions` VALUES (1,3,37);
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
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
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2019-05-22 09:32:25.698860','3','Petriukas',2,'[{\"changed\": {\"fields\": [\"user_permissions\"]}}]',4,1),(2,'2019-05-22 10:19:00.848410','1','Championship 2019',2,'[{\"changed\": {\"fields\": [\"title\", \"image\"]}}]',7,1),(3,'2019-05-22 10:19:22.397560','6','sdasdas',3,'',7,1),(4,'2019-05-22 10:19:22.533593','5','sadasd',3,'',7,1),(5,'2019-05-22 10:19:22.689367','3','testinis',3,'',7,1),(6,'2019-05-22 10:19:22.778675','2','Test',3,'',7,1),(7,'2019-05-22 10:20:17.385970','1','referee',1,'[{\"added\": {}}]',3,1),(8,'2019-05-22 10:20:41.975567','4','Antanas123',1,'[{\"added\": {}}]',4,1),(9,'2019-05-22 10:20:49.437110','4','Antanas123',2,'[{\"changed\": {\"fields\": [\"groups\"]}}]',4,1),(10,'2019-05-22 10:21:54.087024','1','Championship 2019',2,'[{\"deleted\": {\"name\": \"competition\", \"object\": \"test1\"}}, {\"deleted\": {\"name\": \"competition\", \"object\": \"test2\"}}, {\"deleted\": {\"name\": \"competition\", \"object\": \"naujas\"}}, {\"deleted\": {\"name\": \"competition\", \"object\": \"sadasda\"}}, {\"deleted\": {\"name\": \"competition\", \"object\": \"sfaasfas\"}}]',7,1),(11,'2019-05-22 10:35:40.040765','4','LTU9541',2,'[{\"changed\": {\"fields\": [\"team_name\"]}}]',10,1),(12,'2019-05-22 10:35:53.700671','2','LTU4582',2,'[{\"changed\": {\"fields\": [\"team_name\"]}}]',10,1),(13,'2019-05-27 16:45:42.294452','2','Basic',1,'[{\"added\": {}}]',3,1),(14,'2019-05-27 16:46:25.020234','1','Referee',2,'[{\"changed\": {\"fields\": [\"name\", \"permissions\"]}}]',3,1),(15,'2019-05-27 16:47:02.654628','3','Organiser',1,'[{\"added\": {}}]',3,1),(16,'2019-05-27 16:47:48.858115','4','Participant',1,'[{\"added\": {}}]',3,1),(17,'2019-05-27 16:51:16.942851','5','david',3,'',4,1),(18,'2019-05-27 16:53:46.718462','6','david',3,'',4,1),(19,'2019-05-27 16:56:02.377811','8','testasas',2,'[{\"changed\": {\"fields\": [\"groups\"]}}]',4,1),(20,'2019-05-27 16:57:03.397690','2','added',2,'[{\"changed\": {\"fields\": [\"groups\"]}}]',4,1),(21,'2019-05-27 16:57:15.727727','3','Petriukas',2,'[{\"changed\": {\"fields\": [\"groups\"]}}]',4,1),(22,'2019-05-28 08:41:32.485051','2','Dalyvis123',2,'[{\"changed\": {\"fields\": [\"username\", \"groups\"]}}]',4,1),(23,'2019-05-28 08:41:55.926142','2','Dalyvis123',2,'[{\"changed\": {\"fields\": [\"password\"]}}]',4,1),(24,'2019-05-28 08:49:44.817483','3','teisejas123',2,'[{\"changed\": {\"fields\": [\"username\"]}}]',4,1),(25,'2019-05-28 09:30:22.232712','1','Championship 2019',2,'[{\"changed\": {\"fields\": [\"image\"]}}]',7,1),(26,'2019-05-28 09:30:55.182010','1','Championship 2019',2,'[{\"changed\": {\"fields\": [\"image\"]}}]',7,1);
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
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(8,'events','competition'),(7,'events','event'),(11,'events','gpscoordinates'),(9,'events','race'),(12,'events','resulttable'),(10,'events','team'),(6,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-04-16 17:25:22.990316'),(2,'auth','0001_initial','2019-04-16 17:28:02.867450'),(3,'admin','0001_initial','2019-04-16 17:28:48.799475'),(4,'admin','0002_logentry_remove_auto_add','2019-04-16 17:28:49.059707'),(5,'admin','0003_logentry_add_action_flag_choices','2019-04-16 17:28:49.359655'),(6,'contenttypes','0002_remove_content_type_name','2019-04-16 17:28:50.325232'),(7,'auth','0002_alter_permission_name_max_length','2019-04-16 17:28:50.526368'),(8,'auth','0003_alter_user_email_max_length','2019-04-16 17:28:50.930224'),(9,'auth','0004_alter_user_username_opts','2019-04-16 17:28:51.069591'),(10,'auth','0005_alter_user_last_login_null','2019-04-16 17:28:51.554197'),(11,'auth','0006_require_contenttypes_0002','2019-04-16 17:28:51.579103'),(12,'auth','0007_alter_validators_add_error_messages','2019-04-16 17:28:51.763987'),(13,'auth','0008_alter_user_username_max_length','2019-04-16 17:28:52.350274'),(14,'auth','0009_alter_user_last_name_max_length','2019-04-16 17:28:52.719391'),(15,'events','0001_initial','2019-04-16 17:29:28.545912'),(16,'events','0002_event_price','2019-04-16 17:29:33.550161'),(17,'events','0003_auto_20190317_0943','2019-04-16 17:29:37.622269'),(18,'events','0004_auto_20190317_0954','2019-04-16 17:29:37.767375'),(19,'events','0005_competiton','2019-04-16 17:30:01.243441'),(20,'events','0006_competiton_event','2019-04-16 17:30:07.257409'),(21,'events','0007_auto_20190318_1041','2019-04-16 17:30:41.594074'),(22,'events','0008_race','2019-04-16 17:31:34.407043'),(23,'events','0009_auto_20190325_1011','2019-04-16 17:31:34.730929'),(24,'events','0010_auto_20190325_1042','2019-04-16 17:31:34.998327'),(25,'events','0011_remove_competition_race_amount','2019-04-16 17:31:35.321393'),(26,'events','0012_team','2019-04-16 17:32:09.282208'),(27,'events','0013_team_event','2019-04-16 17:32:16.022382'),(28,'events','0014_team_user','2019-04-16 17:32:23.446672'),(29,'events','0015_auto_20190328_1452','2019-04-16 17:32:24.031670'),(30,'events','0016_competition_referee','2019-04-16 17:32:42.965394'),(31,'events','0017_gpscoordinates','2019-04-16 17:33:01.342871'),(32,'events','0018_auto_20190416_0746','2019-04-16 17:33:17.998378'),(33,'events','0019_auto_20190416_0749','2019-04-16 17:33:18.670283'),(34,'sessions','0001_initial','2019-04-16 17:33:36.482432'),(35,'events','0020_auto_20190430_1308','2019-04-30 10:09:04.152825'),(36,'events','0021_auto_20190502_1211','2019-05-02 09:11:41.774417'),(37,'events','0022_auto_20190503_1503','2019-05-03 12:03:32.505882'),(38,'events','0023_auto_20190511_1534','2019-05-13 07:05:57.467300');
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
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('15qp5keuvy851n0n2dvtrshpan2epufi','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-05-17 14:59:30.517343'),('16fwxqu4jfrmiucepkqdpirw3gbshmr9','MjA3ODUwYjMxMWE4MjE5MTYwOWQzOTM0NTRlMDUzNTI4OGM3NTEyNTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4NjllNmE3NmE5MzNhNWU5NTQ1OTE4M2YxZGNkMTNjMWE5ZDJjODk5In0=','2019-06-11 08:42:37.397750'),('2ncvepbdkqb4cbqumogtlkybdelpatf4','ZTg3ZDQyN2UwNmY3MDc5MDMxOTM1ODQwZWQzMjA1ZDQwOGM0NDIyMTp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhY2I2YWQ2MTAzNTE2NDJkMTU4ODY2YjgyOGZhOGQ4NjIxOGQ4MWExIn0=','2019-06-11 09:00:18.814422'),('2nfcpt9bpyndfewa72247gf2f86v41xa','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-05-11 19:10:57.934625'),('2oiawklr6i2k331pp42prguyoxsjadjl','ODRlZTE5OTQ2ZTYwMDVmZTgwMWM3Y2U4ZTQxMDFmY2MyZjNiYWUzOTp7fQ==','2019-05-11 17:45:58.833781'),('2xrqye74k9x7e7y9p9awihe0ip23xdtm','ODRlZTE5OTQ2ZTYwMDVmZTgwMWM3Y2U4ZTQxMDFmY2MyZjNiYWUzOTp7fQ==','2019-06-11 08:46:50.836384'),('3z1rjp9tvhxnlt6l6hxee7tll1kjk93i','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-05-09 11:45:07.006394'),('4ji4l1rt1e7j67h5c2h2hqel2so9qcro','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-05-11 17:46:44.221456'),('4shkas4ttob2f2gz7aa8iwdzq3zhs8up','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-04-30 21:25:34.781871'),('5swhuypgulohi59mxvgwnnopxen96ag2','MWY5MGQ0YmU4OTRiNzFhYTMwMzE0NWEyMGRhYjU3YmU4MDc2NWRlNTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3OTBiNDljZTA0MTI0ZTg1ZjljNDkzZGFmY2JkOWI3YjI0MDM1OWU3In0=','2019-05-21 11:51:25.922291'),('741zzdqxmsdd1cqkoj8xobhcew2t4jt6','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-05-20 22:47:27.578904'),('7ae7sr23nrec8bqpq0p5resirwl47lvm','ODRlZTE5OTQ2ZTYwMDVmZTgwMWM3Y2U4ZTQxMDFmY2MyZjNiYWUzOTp7fQ==','2019-06-11 08:43:00.061933'),('8e9lol7t3np5dy3ossmkal8quvxfxcth','ODRlZTE5OTQ2ZTYwMDVmZTgwMWM3Y2U4ZTQxMDFmY2MyZjNiYWUzOTp7fQ==','2019-06-11 08:45:38.084485'),('9kcto9da8nujshf27ztsgod9ef3wam77','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-05-09 14:51:49.251857'),('9vv4x7fn3shllm1yorh34t6fclru8j67','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-05-09 14:07:08.763161'),('a1y29fleroo0y0csdlu00qx32ij45qkt','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-05-09 14:48:48.411860'),('ad3gitc2sbn06agzoh3bkr6pa1xn6379','MWY5MGQ0YmU4OTRiNzFhYTMwMzE0NWEyMGRhYjU3YmU4MDc2NWRlNTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3OTBiNDljZTA0MTI0ZTg1ZjljNDkzZGFmY2JkOWI3YjI0MDM1OWU3In0=','2019-05-01 11:34:07.589644'),('ezw6euz65r5edy8msy909lbeu1dayt6u','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-05-09 14:52:13.189757'),('g0b4qr5opguvbbrqvb7b259aukda1chz','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-05-11 18:44:41.872841'),('gmsokd7cqfhbcafnlbk4p796x3qb6bwk','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-06-10 16:49:43.689142'),('j3szgou7a5l14sx9ki2gv8v8fkspzfrg','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-05-09 12:50:32.292151'),('j6qc96645dt6zwcuzcyw8u0oijf1xnt7','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-06-11 08:41:55.934121'),('jc7bqueyo4oxhdfkkq0g5k5sxn5o7rd5','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-05-09 14:29:58.860511'),('koeatfbzg6h46ozstauv79nxr732yc6f','ODRlZTE5OTQ2ZTYwMDVmZTgwMWM3Y2U4ZTQxMDFmY2MyZjNiYWUzOTp7fQ==','2019-06-11 08:44:44.208893'),('nl7vxzbpmkt5wczccp5baflqccf3cnbw','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-05-09 12:46:55.733494'),('nmtbx1j4sldnrr5a6d4p4qwyvb055zkm','ODRlZTE5OTQ2ZTYwMDVmZTgwMWM3Y2U4ZTQxMDFmY2MyZjNiYWUzOTp7fQ==','2019-06-11 08:43:58.458514'),('npjjnf62aydd72falxel0bj3ehnwdnv4','MWY5MGQ0YmU4OTRiNzFhYTMwMzE0NWEyMGRhYjU3YmU4MDc2NWRlNTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3OTBiNDljZTA0MTI0ZTg1ZjljNDkzZGFmY2JkOWI3YjI0MDM1OWU3In0=','2019-05-17 07:40:07.032344'),('o3g029006hirbd7nrnydc1ik4837fu22','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-05-09 12:17:47.426726'),('omp8bml81z2ho05y5w6pf5nf2g8o7fgt','ODRlZTE5OTQ2ZTYwMDVmZTgwMWM3Y2U4ZTQxMDFmY2MyZjNiYWUzOTp7fQ==','2019-05-11 17:41:52.756171'),('pltitw2ezvrdnwofvmqp3unk4z52zt7a','ODRlZTE5OTQ2ZTYwMDVmZTgwMWM3Y2U4ZTQxMDFmY2MyZjNiYWUzOTp7fQ==','2019-06-11 08:47:32.453855'),('rk3svnfokb5joppmljjl3b1pw3ba3ipd','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-06-05 09:34:23.064292'),('te7yox0w4dl51wyr912jd5ckgu60ly55','YTQ4ZDFjOTMzOWMyMDI3M2RmMGEwZTg1NDdmYjE0N2ZjNzllMzUwZjp7Il9hdXRoX3VzZXJfaWQiOiI4IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxYzg2OGUzZDQ0MDVlYjAwNjQ4OWQwY2E4ZDE4ZDA0NWE2NTdkM2JhIn0=','2019-06-10 18:15:07.610185'),('th7n2tlmn7wpvn82oydgt3duofm6cnqz','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-05-09 12:07:04.230022'),('uiw9qo0y2nyw7x05h7ckb5oo9u51r7my','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-05-01 10:17:10.710910'),('vjy2508a9y1o13wn9iot9r53bpponj5a','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-05-09 12:04:55.660993'),('vnkuf1sktw22fmczcfjh30aesokeijks','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-05-11 18:27:36.175883'),('vssn8gkxtc3m1rprrh61sgh54f2mad8o','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-05-10 12:39:34.442784'),('wpggvnhg1xtmy0ow4wxwnoivinn8g6gl','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-05-14 13:43:35.738701'),('x2vq00f7mqbmbkdy8oye77dhzcww5taq','ODRlZTE5OTQ2ZTYwMDVmZTgwMWM3Y2U4ZTQxMDFmY2MyZjNiYWUzOTp7fQ==','2019-05-11 17:43:30.940547'),('x68vopzd7x9d07d2uvp7p8iyl418jwgz','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-05-02 19:46:17.557407'),('xi89tyrqe91v5y7d45n229fi6nukqdvy','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-05-09 12:02:49.441621'),('xyloccnkd683lwuu7g4w6b559xddr224','MzRlYmVkMTEzMTcxN2Y0YjQ5YTgyMDllODM5YmIxZGEyMjNiMjA3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMzM1N2VlOWU3MTliYWZlYzExY2MyNDQwNGNhZjQ4NTFjZGZhOTY2In0=','2019-06-05 09:31:32.765823'),('y10n67u1octyhvw6m7mvzuvcpa4tf3e5','ODRlZTE5OTQ2ZTYwMDVmZTgwMWM3Y2U4ZTQxMDFmY2MyZjNiYWUzOTp7fQ==','2019-06-11 08:42:21.226322');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events_competition`
--

DROP TABLE IF EXISTS `events_competition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events_competition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(80) NOT NULL,
  `start_date` date NOT NULL,
  `event_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `events_competition_event_id_ecbf7250_fk_events_event_id` (`event_id`),
  CONSTRAINT `events_competition_event_id_ecbf7250_fk_events_event_id` FOREIGN KEY (`event_id`) REFERENCES `events_event` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_competition`
--

LOCK TABLES `events_competition` WRITE;
/*!40000 ALTER TABLE `events_competition` DISABLE KEYS */;
INSERT INTO `events_competition` VALUES (1,'Competition 1','2019-05-28',1),(2,'Competition 2','2019-05-22',1);
/*!40000 ALTER TABLE `events_competition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events_competition_referee`
--

DROP TABLE IF EXISTS `events_competition_referee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events_competition_referee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `competition_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `events_competition_referee_competition_id_user_id_0704a8e4_uniq` (`competition_id`,`user_id`),
  KEY `events_competition_referee_user_id_6f3aa0d8_fk_auth_user_id` (`user_id`),
  CONSTRAINT `events_competition_r_competition_id_72bf0983_fk_events_co` FOREIGN KEY (`competition_id`) REFERENCES `events_competition` (`id`),
  CONSTRAINT `events_competition_referee_user_id_6f3aa0d8_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_competition_referee`
--

LOCK TABLES `events_competition_referee` WRITE;
/*!40000 ALTER TABLE `events_competition_referee` DISABLE KEYS */;
INSERT INTO `events_competition_referee` VALUES (42,1,4),(43,2,3);
/*!40000 ALTER TABLE `events_competition_referee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events_event`
--

DROP TABLE IF EXISTS `events_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(80) NOT NULL,
  `description` longtext,
  `created_at` datetime(6) NOT NULL,
  `edited_at` datetime(6) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `thumbnail` varchar(100) NOT NULL,
  `event_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_event`
--

LOCK TABLES `events_event` WRITE;
/*!40000 ALTER TABLE `events_event` DISABLE KEYS */;
INSERT INTO `events_event` VALUES (1,'Championship 2019','Cool event','2019-04-16 17:46:09.249307','2019-05-28 09:30:55.180740','user/images/IMG_0003.JPG','user/images/thumbnails/IMG_0003_thumb_9ixpohL.jpg','2019-04-16'),(7,'Trakai championship 2019','','2019-05-22 10:59:58.921091','2019-05-22 10:59:58.921122','','','2019-06-23'),(8,'Trakai championship 2018','','2019-05-28 09:31:16.974195','2019-05-28 09:31:16.974221','','','2018-05-28');
/*!40000 ALTER TABLE `events_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events_gpscoordinates`
--

DROP TABLE IF EXISTS `events_gpscoordinates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events_gpscoordinates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `latitude` varchar(80) NOT NULL,
  `longitude` varchar(80) NOT NULL,
  `team_id` int(11) NOT NULL,
  `time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `events_gpscoordinates_team_id_77f80b4e_fk_events_team_id` (`team_id`),
  CONSTRAINT `events_gpscoordinates_team_id_77f80b4e_fk_events_team_id` FOREIGN KEY (`team_id`) REFERENCES `events_team` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_gpscoordinates`
--

LOCK TABLES `events_gpscoordinates` WRITE;
/*!40000 ALTER TABLE `events_gpscoordinates` DISABLE KEYS */;
INSERT INTO `events_gpscoordinates` VALUES (1,'54.92165945470333','23.93421177752316',1,'2019-04-17 07:48:43.495885'),(2,'54.92163497954607','23.934232564643025',1,'2019-04-17 07:48:48.380198'),(3,'54.92164285853505','23.934238515794277',1,'2019-04-17 07:48:53.359995'),(4,'54.92164285853505','23.934238515794277',1,'2019-04-17 07:48:58.346657'),(5,'54.922068156301975','23.93437790684402',1,'2019-04-17 08:29:08.839018'),(6,'54.92208957206458','23.934355610981584',1,'2019-04-17 08:29:14.506116'),(7,'54.922037813812494','23.934311689808965',1,'2019-04-17 08:29:19.487199'),(8,'54.922034963965416','23.934272546321154',1,'2019-04-17 08:29:24.426880'),(9,'54.92203504778445','23.93426449969411',1,'2019-04-17 08:29:29.492895'),(10,'54.92205780465156','23.933967361226678',1,'2019-04-17 08:29:34.418846'),(11,'54.92215767502785','23.933422788977623',1,'2019-04-17 08:29:39.449603'),(12,'54.9221784202382','23.933255318552256',1,'2019-04-17 08:29:44.435103'),(13,'54.921914935112','23.933072425425053',1,'2019-04-17 08:29:49.422695'),(14,'54.92152982857078','23.93289196304977',1,'2019-04-17 08:29:54.450010'),(15,'54.920984795317054','23.93257479183376',1,'2019-04-17 08:29:59.570565'),(16,'54.9204428633675','23.932275054976344',1,'2019-04-17 08:30:04.519746'),(17,'54.919956251978874','23.932021167129278',1,'2019-04-17 08:30:09.520993'),(18,'54.91946884430945','23.931787982583046',1,'2019-04-17 08:30:14.541066'),(19,'54.91898369975388','23.931534681469202',1,'2019-04-17 08:30:19.490927'),(20,'54.918476594612','23.931283140555024',1,'2019-04-17 08:30:24.517788'),(21,'54.91798067931086','23.931013830006123',1,'2019-04-17 08:30:29.470302'),(22,'54.917524326592684','23.930915594100952',1,'2019-04-17 08:30:34.497280'),(23,'54.91723724640906','23.931570891290903',1,'2019-04-17 08:30:39.524066'),(24,'54.91690129972994','23.932248819619417',1,'2019-04-17 08:30:44.482677'),(25,'54.91644394118339','23.932427689433098',1,'2019-04-17 08:30:49.516020'),(26,'54.915906828828156','23.93245132640004',1,'2019-04-17 08:30:54.573016'),(27,'54.91538044530898','23.932500947266817',1,'2019-04-17 08:30:59.521676'),(28,'54.91496436763555','23.932455265894532',1,'2019-04-17 08:31:04.543874'),(29,'54.91468512453139','23.932411093264818',1,'2019-04-17 08:31:09.459549'),(30,'54.914351273328066','23.93233892507851',1,'2019-04-17 08:31:14.485898'),(31,'54.91404659114778','23.932141195982695',1,'2019-04-17 08:31:19.444737'),(32,'54.91357024759054','23.931799633428454',1,'2019-04-17 08:31:24.395294'),(33,'54.913264559581876','23.931604167446494',1,'2019-04-17 08:31:29.524784'),(34,'54.91321845911443','23.931075856089592',1,'2019-04-17 08:31:34.484330'),(35,'54.91315463092178','23.930106153711677',1,'2019-04-17 08:31:39.509277'),(36,'54.913134975358844','23.929160423576832',1,'2019-04-17 08:31:44.490826'),(37,'54.91311091929674','23.928778041154146',1,'2019-04-17 08:31:49.534936'),(38,'54.91309717297554','23.92842256464064',1,'2019-04-17 08:31:54.518681'),(39,'54.91311154793948','23.928039260208607',1,'2019-04-17 08:31:59.613234'),(40,'54.91319130174816','23.927683364599943',1,'2019-04-17 08:32:04.490557'),(41,'54.9132968718186','23.927220180630684',1,'2019-04-17 08:32:09.536213'),(42,'54.91334552876651','23.926798989996314',1,'2019-04-17 08:32:14.593412'),(43,'54.91334649268538','23.92642884515226',1,'2019-04-17 08:32:19.462298'),(44,'54.913318203762174','23.925860887393355',1,'2019-04-17 08:32:24.540145'),(45,'54.91326908580959','23.92533735372126',1,'2019-04-17 08:32:29.453718'),(46,'54.913261625915766','23.92510182224214',1,'2019-04-17 08:32:34.470950'),(47,'54.91326074581593','23.925101403146982',1,'2019-04-17 08:32:39.455731'),(48,'54.91326074581593','23.925101403146982',1,'2019-04-17 08:32:44.474562'),(49,'54.91326074581593','23.925101403146982',1,'2019-04-17 08:32:49.444408'),(50,'54.91326074581593','23.925101403146982',1,'2019-04-17 08:32:54.475526'),(51,'54.91326074581593','23.925101403146982',1,'2019-04-17 08:32:59.451606'),(52,'54.91326074581593','23.925101403146982',1,'2019-04-17 08:33:04.402324'),(53,'54.91326074581593','23.925101403146982',1,'2019-04-17 08:33:09.342422'),(54,'54.91326074581593','23.925101403146982',1,'2019-04-17 08:33:14.395398'),(55,'54.91327382158488','23.924861513078213',1,'2019-04-17 08:33:19.580033'),(56,'54.913009414449334','23.92456873320043',1,'2019-04-17 08:33:24.572133'),(57,'54.91244426462799','23.924828823655844',1,'2019-04-17 08:33:29.537037'),(58,'54.91173972375691','23.925137110054493',1,'2019-04-17 08:33:35.067395'),(59,'54.91108539048582','23.925621919333935',1,'2019-04-17 08:33:39.641780'),(60,'54.910532562062144','23.92636531032622',1,'2019-04-17 08:33:44.514140'),(61,'54.90999503061175','23.927083974704146',1,'2019-04-17 08:33:49.559647'),(62,'54.90959077142179','23.927618488669395',1,'2019-04-17 08:33:54.518451'),(63,'54.90930515807122','23.92800279892981',1,'2019-04-17 08:33:59.494513'),(64,'54.90899846423417','23.928395239636302',1,'2019-04-17 08:34:04.633620'),(65,'54.90862442180514','23.928819866850972',1,'2019-04-17 08:34:09.540036'),(66,'54.90817561279982','23.929285565391183',1,'2019-04-17 08:34:14.458537'),(67,'54.90772818680853','23.929872885346413',1,'2019-04-17 08:34:19.382374'),(68,'54.907180136069655','23.930536480620503',1,'2019-04-17 08:34:24.524249'),(69,'54.90662433207035','23.93124039284885',1,'2019-04-17 08:34:29.464215'),(70,'54.90605997852981','23.931794855743647',1,'2019-04-17 08:34:34.435319'),(71,'54.905492439866066','23.931948663666844',1,'2019-04-17 08:34:39.444901'),(72,'54.905303972773254','23.931913962587714',1,'2019-04-17 08:34:44.421189'),(73,'54.905295968055725','23.93191077746451',1,'2019-04-17 08:34:49.421378'),(74,'54.90524156950414','23.932112446054816',1,'2019-04-17 08:34:54.430143'),(75,'54.905381044372916','23.932711919769645',1,'2019-04-17 08:34:59.359789'),(76,'54.905487494543195','23.933222545310855',1,'2019-04-17 08:35:04.500374'),(77,'54.90564214065671','23.933055410161614',1,'2019-04-17 08:35:09.516156'),(78,'54.90567512344569','23.93297402188182',1,'2019-04-17 08:35:14.480942'),(79,'54.90569825749844','23.932945858687162',1,'2019-04-17 08:35:19.477767'),(80,'54.922671569511294','23.933275351300836',2,'2019-04-24 06:36:00.724671'),(81,'54.922661846503615','23.93344860523939',2,'2019-04-24 06:36:05.478531'),(82,'54.922966486774385','23.93363476730883',2,'2019-04-24 06:36:10.514944'),(83,'54.92313425056636','23.93382520414889',2,'2019-04-24 06:36:15.645516'),(84,'54.9230521498248','23.934478405863047',2,'2019-04-24 06:36:20.463023'),(85,'54.922897377982736','23.935453137382865',2,'2019-04-24 06:36:25.473188'),(86,'54.922741055488586','23.93649861216545',2,'2019-04-24 06:36:30.458978'),(87,'54.92259604856372','23.93750561401248',2,'2019-04-24 06:36:35.460653'),(88,'54.922480755485594','23.93819653429091',2,'2019-04-24 06:36:40.466631'),(89,'54.92248335387558','23.938691234216094',2,'2019-04-24 06:36:45.439539'),(90,'54.92289113346487','23.93918015062809',2,'2019-04-24 06:36:50.505296'),(91,'54.9233774933964','23.9398237131536',2,'2019-04-24 06:36:55.454905'),(92,'54.92379826493561','23.94074136391282',2,'2019-04-24 06:37:00.549567'),(93,'54.92416363209486','23.941711904481053',2,'2019-04-24 06:37:05.458194'),(94,'54.92435888852924','23.942536180838943',2,'2019-04-24 06:37:10.441827'),(95,'54.92440293543041','23.94273106008768',2,'2019-04-24 06:37:15.549641'),(96,'54.92440540809184','23.94273156300187',2,'2019-04-24 06:37:20.510490'),(97,'54.92440540809184','23.94273156300187',2,'2019-04-24 06:37:25.515530'),(98,'54.92440540809184','23.94273156300187',2,'2019-04-24 06:37:30.558247'),(99,'54.92447724100202','23.943088296800852',2,'2019-04-24 06:37:35.472597'),(100,'54.92434283718467','23.943660110235214',2,'2019-04-24 06:37:40.456377'),(101,'54.923824751749635','23.9442790299654',2,'2019-04-24 06:37:45.454815'),(102,'54.923245017416775','23.94513507373631',2,'2019-04-24 06:37:50.518171'),(103,'54.922668216750026','23.945937305688858',2,'2019-04-24 06:37:55.467177'),(104,'54.92209066171199','23.94670399837196',2,'2019-04-24 06:38:00.463994'),(105,'54.92151172365993','23.947478150948882',2,'2019-04-24 06:38:05.695465'),(106,'54.920959188602865','23.94824417307973',2,'2019-04-24 06:38:10.432281'),(107,'54.92037819698453','23.948962334543467',2,'2019-04-24 06:38:15.418093'),(108,'54.91981170605868','23.94969985820353',2,'2019-04-24 06:38:20.433183'),(109,'54.9193082889542','23.950372086837888',2,'2019-04-24 06:38:25.557057'),(110,'54.919022591784596','23.950739549472928',2,'2019-04-24 06:38:30.511195'),(111,'54.91897452156991','23.95081683062017',2,'2019-04-24 06:38:35.465973'),(112,'54.91887972224504','23.950872905552387',2,'2019-04-24 06:38:40.515578'),(113,'54.91887787822634','23.95087307319045',2,'2019-04-24 06:38:45.556869'),(114,'54.91879825014621','23.950846418738365',2,'2019-04-24 06:38:50.516832'),(115,'54.91861359681934','23.950539138168097',2,'2019-04-24 06:38:55.441378'),(116,'54.91826080251485','23.949800692498684',2,'2019-04-24 06:39:00.462340'),(117,'54.91790872067213','23.94901094958186',2,'2019-04-24 06:39:05.481041'),(118,'54.91756393108517','23.948226738721132',2,'2019-04-24 06:39:10.458831'),(119,'54.91718410514295','23.947389721870422',2,'2019-04-24 06:39:15.428386'),(120,'54.91678072605282','23.94649545662105',2,'2019-04-24 06:39:20.471576'),(121,'54.91638585459441','23.945614770054817',2,'2019-04-24 06:39:25.456191'),(122,'54.91597547661513','23.944727713242173',2,'2019-04-24 06:39:30.435951'),(123,'54.91570595651865','23.944136537611485',2,'2019-04-24 06:39:35.414284'),(124,'54.915700634010136','23.944153552874923',2,'2019-04-24 06:39:40.386142'),(125,'54.915700634010136','23.944153552874923',2,'2019-04-24 06:39:45.477195'),(126,'54.915700634010136','23.944153552874923',2,'2019-04-24 06:39:50.548512'),(127,'54.915700634010136','23.944153552874923',2,'2019-04-24 06:39:55.503484'),(128,'54.915580647066236','23.94385976716876',2,'2019-04-24 06:40:00.415187'),(129,'54.91525735706091','23.943141857162118',2,'2019-04-24 06:40:05.504636'),(130,'54.914867975749075','23.94227961078286',2,'2019-04-24 06:40:10.472918'),(131,'54.914531484246254','23.941572597250342',2,'2019-04-24 06:40:15.435881'),(132,'54.91436003241688','23.941203206777573',2,'2019-04-24 06:40:20.479645'),(133,'54.91435144096613','23.941175462678075',2,'2019-04-24 06:40:25.369958'),(134,'54.91435144096613','23.941175462678075',2,'2019-04-24 06:40:30.461912'),(135,'54.91435144096613','23.941175462678075',2,'2019-04-24 06:40:35.386720'),(136,'54.91435144096613','23.941175462678075',2,'2019-04-24 06:40:40.403530'),(137,'54.91435144096613','23.941175462678075',2,'2019-04-24 06:40:45.386158'),(138,'54.91435144096613','23.941175462678075',2,'2019-04-24 06:40:50.441277'),(139,'54.91435144096613','23.941175462678075',2,'2019-04-24 06:40:55.415079'),(140,'54.91435144096613','23.941175462678075',2,'2019-04-24 06:41:00.376517'),(141,'54.91435144096613','23.941175462678075',2,'2019-04-24 06:41:05.378066'),(142,'54.91435144096613','23.941175462678075',2,'2019-04-24 06:41:10.448619'),(143,'54.91435144096613','23.941175462678075',2,'2019-04-24 06:41:15.474497'),(144,'54.91423790808767','23.940925179049373',2,'2019-04-24 06:41:20.465783'),(145,'54.91399470716715','23.940396700054407',2,'2019-04-24 06:41:25.501303'),(146,'54.913686169311404','23.93972061574459',2,'2019-04-24 06:41:30.420340'),(147,'54.9133505159989','23.93897345289588',2,'2019-04-24 06:41:35.475063'),(148,'54.91301611997187','23.938256464898586',2,'2019-04-24 06:41:41.050544'),(149,'54.912640526890755','23.937501506879926',2,'2019-04-24 06:41:45.410410'),(150,'54.91227109450847','23.9367032982409',2,'2019-04-24 06:41:50.981848'),(151,'54.9119085771963','23.93591363914311',2,'2019-04-24 06:41:55.540410'),(152,'54.9115372588858','23.93510160036385',2,'2019-04-24 06:42:00.436273'),(153,'54.91114209406078','23.93422602675855',2,'2019-04-24 06:42:05.465256'),(154,'54.910740768536925','23.9333376288414',2,'2019-04-24 06:42:10.517298'),(155,'54.91034455597401','23.932438921183348',2,'2019-04-24 06:42:15.480701'),(156,'54.90991624072194','23.931468883529305',2,'2019-04-24 06:42:21.065496'),(157,'54.90950875449926','23.930561877787113',2,'2019-04-24 06:42:25.438269'),(158,'54.90913550835103','23.929732237011194',2,'2019-04-24 06:42:30.462110'),(159,'54.908847003243864','23.929048106074333',2,'2019-04-24 06:42:35.418987'),(160,'54.908633516170084','23.928782818838954',2,'2019-04-24 06:42:40.462797'),(161,'54.90828772075474','23.929242566227913',2,'2019-04-24 06:42:45.425456'),(162,'54.90774038247764','23.92988403327763',2,'2019-04-24 06:42:50.471574'),(163,'54.90717271808535','23.930563386529684',2,'2019-04-24 06:42:55.427622'),(164,'54.906600820831954','23.931240811944008',2,'2019-04-24 06:43:00.408796'),(165,'54.90602167323232','23.931797705590725',2,'2019-04-24 06:43:05.385992'),(166,'54.9054304137826','23.931935084983706',2,'2019-04-24 06:43:10.406853'),(167,'54.90527627058327','23.932182183489203',2,'2019-04-24 06:43:15.487509'),(168,'54.90539810154587','23.932818453758955',2,'2019-04-24 06:43:20.524610'),(169,'54.905472910031676','23.93326093442738',2,'2019-04-24 06:43:25.464881');
/*!40000 ALTER TABLE `events_gpscoordinates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events_race`
--

DROP TABLE IF EXISTS `events_race`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events_race` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(80) NOT NULL,
  `duration` bigint(20) DEFAULT NULL,
  `winner` varchar(80) DEFAULT NULL,
  `start_coordinates` varchar(80) DEFAULT NULL,
  `finish_coordinates` varchar(80) DEFAULT NULL,
  `start_date` datetime(6) DEFAULT NULL,
  `competition_id` int(11) NOT NULL,
  `checkpoint_coordinates` varchar(80) DEFAULT NULL,
  `referee_coordinates` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `events_race_competition_id_87246dcc_fk_events_competition_id` (`competition_id`),
  CONSTRAINT `events_race_competition_id_87246dcc_fk_events_competition_id` FOREIGN KEY (`competition_id`) REFERENCES `events_competition` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_race`
--

LOCK TABLES `events_race` WRITE;
/*!40000 ALTER TABLE `events_race` DISABLE KEYS */;
INSERT INTO `events_race` VALUES (2,'R1',600000000,NULL,'54.902565;23.931565999999997','54.902565;23.931565999999997','2019-05-27 23:00:00.000000',1,'54.91743174250156;23.93294585868716','54.902565;23.937565999999997'),(4,'R2',600000000,NULL,NULL,NULL,'2019-05-27 23:14:00.000000',1,NULL,NULL),(5,'R1',600000000,NULL,'13.422;-1.084','13.422;-1.084','2019-05-28 10:20:00.000000',2,'13.422;-1.084','13.422;-1.084');
/*!40000 ALTER TABLE `events_race` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events_resulttable`
--

DROP TABLE IF EXISTS `events_resulttable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events_resulttable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` time(6) NOT NULL,
  `race_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `events_resulttable_race_id_17dc7067_fk_events_race_id` (`race_id`),
  KEY `events_resulttable_team_id_3a3a87c0_fk_events_team_id` (`team_id`),
  CONSTRAINT `events_resulttable_race_id_17dc7067_fk_events_race_id` FOREIGN KEY (`race_id`) REFERENCES `events_race` (`id`),
  CONSTRAINT `events_resulttable_team_id_3a3a87c0_fk_events_team_id` FOREIGN KEY (`team_id`) REFERENCES `events_team` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_resulttable`
--

LOCK TABLES `events_resulttable` WRITE;
/*!40000 ALTER TABLE `events_resulttable` DISABLE KEYS */;
/*!40000 ALTER TABLE `events_resulttable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events_team`
--

DROP TABLE IF EXISTS `events_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events_team` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `team_name` varchar(80) NOT NULL,
  `captain_name` varchar(80) NOT NULL,
  `team_members` varchar(255) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `thumbnail` varchar(100) NOT NULL,
  `event_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `events_team_event_id_b5765a2f_fk_events_event_id` (`event_id`),
  KEY `events_team_user_id_a0f9081c_fk_auth_user_id` (`user_id`),
  CONSTRAINT `events_team_event_id_b5765a2f_fk_events_event_id` FOREIGN KEY (`event_id`) REFERENCES `events_event` (`id`),
  CONSTRAINT `events_team_user_id_a0f9081c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_team`
--

LOCK TABLES `events_team` WRITE;
/*!40000 ALTER TABLE `events_team` DISABLE KEYS */;
INSERT INTO `events_team` VALUES (1,'LTU145','Jonas Jonaitis','Jonas Jonaitis, Petras Petraitis, Kazys Kazaitis','user/images/Screenshot_from_2019-04-08_19-30-48.png','user/images/thumbnails/Screenshot_from_2019-04-08_19-30-48_thumb.png',1,1),(2,'LTU4582','Deivis','Deivis ir jo opelis','','',1,2),(4,'LTU9541','petriukas','petriukas ir kiti','','',1,3),(5,'davidTeam','davidas','davidas','','',1,7),(6,'davidasas','david','dav','','',7,7);
/*!40000 ALTER TABLE `events_team` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-06-02 17:43:06
