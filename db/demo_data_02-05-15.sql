# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.6.21)
# Database: groupmates_development
# Generation Time: 2015-05-02 19:26:20 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table channels
# ------------------------------------------------------------

LOCK TABLES `channels` WRITE;
/*!40000 ALTER TABLE `channels` DISABLE KEYS */;

INSERT INTO `channels` (`id`, `name`, `created_at`, `updated_at`, `project_id`, `is_private`, `is_main`)
VALUES
  (1,'Everyone','2015-04-29 15:30:17','2015-04-29 15:30:17',1,0,1),
  (2,'Research','2015-04-29 19:13:38','2015-04-29 19:13:38',1,0,NULL),
  (3,'Experiments','2015-04-29 19:13:58','2015-04-29 19:13:58',1,0,NULL),
  (4,'Evelyn Huber','2015-04-29 19:14:12','2015-04-29 19:14:12',1,1,NULL),
  (5,'Aline Moss','2015-04-29 19:17:17','2015-04-29 19:17:17',1,1,NULL),
  (6,'David Burris','2015-04-29 19:17:22','2015-04-29 19:17:22',1,1,NULL),
  (7,'Thomas Quiroga','2015-04-29 19:18:26','2015-04-29 19:18:26',1,1,NULL),
  (8,'Aline Moss','2015-04-29 23:03:39','2015-04-29 23:03:39',1,1,NULL);

/*!40000 ALTER TABLE `channels` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table channels_users
# ------------------------------------------------------------

LOCK TABLES `channels_users` WRITE;
/*!40000 ALTER TABLE `channels_users` DISABLE KEYS */;

INSERT INTO `channels_users` (`channel_id`, `user_id`)
VALUES
  (1,2),
  (1,8),
  (1,9),
  (1,10),
  (1,11),
  (1,12),
  (2,2),
  (2,8),
  (2,11),
  (3,2),
  (3,12),
  (3,9),
  (4,2),
  (4,8),
  (5,8),
  (5,9),
  (6,8),
  (6,11),
  (7,2),
  (7,11),
  (3,11),
  (8,9),
  (8,11);

/*!40000 ALTER TABLE `channels_users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table events
# ------------------------------------------------------------

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;

INSERT INTO `events` (`id`, `title`, `description`, `happening`, `project_id`, `created_at`, `updated_at`)
VALUES
  (1,'Research Report Submission','We need to submit the report before 4pm, keep in mind that we need to print and bind it.','2015-06-15 15:00:00',1,'2015-04-29 19:49:54','2015-04-29 19:49:54'),
  (2,'Research Meeting','We will need to meet and discuss the research we have got so far and see what directions we are taking.','2015-05-04 19:30:54',1,'2015-04-29 19:51:00','2015-04-29 19:51:00'),
  (3,'Run of the first experiment','An important moment for all of us, this will happen in the lab as usual.','2015-05-22 19:30:15',1,'2015-04-29 19:52:02','2015-04-29 19:52:02'),
  (4,'Meeting with Tutor','We are meeting our tutor, so just me (Thomas) and David will go.','2015-05-29 19:30:04',1,'2015-04-29 19:53:44','2015-04-29 19:53:44');

/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table events_users
# ------------------------------------------------------------

LOCK TABLES `events_users` WRITE;
/*!40000 ALTER TABLE `events_users` DISABLE KEYS */;

INSERT INTO `events_users` (`event_id`, `user_id`)
VALUES
  (1,2),
  (1,8),
  (1,9),
  (1,10),
  (1,11),
  (1,12),
  (2,2),
  (2,8),
  (2,12),
  (3,2),
  (3,8),
  (3,9),
  (4,2),
  (4,11);

/*!40000 ALTER TABLE `events_users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table favorites
# ------------------------------------------------------------

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;

INSERT INTO `favorites` (`id`, `user_id`, `message_id`, `content`, `created_at`, `updated_at`)
VALUES
  (1,11,8,' ','2015-04-30 10:22:51','2015-04-30 10:22:51');

/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table folders
# ------------------------------------------------------------

LOCK TABLES `folders` WRITE;
/*!40000 ALTER TABLE `folders` DISABLE KEYS */;

INSERT INTO `folders` (`id`, `name`, `parent_id`, `project_id`, `user_id`, `created_at`, `updated_at`)
VALUES
  (1,'Research',NULL,1,11,'2015-04-29 19:42:28','2015-04-29 19:42:28'),
  (2,'Experiments',NULL,1,11,'2015-04-29 19:43:33','2015-04-29 19:43:33');

/*!40000 ALTER TABLE `folders` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table identities
# ------------------------------------------------------------



# Dump of table invitations
# ------------------------------------------------------------



# Dump of table ip_addresses
# ------------------------------------------------------------



# Dump of table messages
# ------------------------------------------------------------

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;

INSERT INTO `messages` (`id`, `content`, `user_id`, `created_at`, `updated_at`, `channel_id`)
VALUES
  (1,'We welcome you to your new project. Get a whole new experience of collaborative working using Groupmates ;)',1,'2015-04-29 15:30:17','2015-04-29 15:30:17',1),
  (2,'Hi Evelyn!',2,'2015-04-29 19:14:36','2015-04-29 19:14:36',4),
  (3,'Could you send me the name of the thing you were talking about today?',2,'2015-04-29 19:14:59','2015-04-29 19:14:59',4),
  (4,'Sure, here it is: http://www.huffingtonpost.com/bryan-johnson/after-the-biofuel-fail-do_b_7166268.html',8,'2015-04-29 19:18:19','2015-04-29 19:18:19',4),
  (5,'Thanks :)',2,'2015-04-29 19:18:37','2015-04-29 19:18:37',4),
  (6,'Hey guys, here is a discussion for research only',2,'2015-04-29 19:19:15','2015-04-29 19:19:15',2),
  (7,'Yay! Much better than polluting the group discussion :p',11,'2015-04-29 19:19:58','2015-04-29 19:19:58',2),
  (8,'So here is what I found very useful for our research: http://www.postonline.co.uk/post/analysis/2404175/synthetic-biology-the-dark-side-of-dna',8,'2015-04-29 19:20:58','2015-04-29 19:20:58',2),
  (9,'Wow that\'s great!',2,'2015-04-29 19:26:11','2015-04-29 19:26:11',2),
  (10,'Did everyone joined?',2,'2015-04-29 19:26:34','2015-04-29 19:26:34',1),
  (11,'Hmm yes I think so',11,'2015-04-29 19:27:04','2015-04-29 19:27:04',1),
  (12,'Oh wait, we are missing  John :o !',8,'2015-04-29 19:27:44','2015-04-29 19:27:44',1),
  (13,'You\'re welcome, let me know if you find similar articles',8,'2015-04-29 19:28:12','2015-04-29 19:28:12',4),
  (14,'Here I am! :D',10,'2015-04-29 19:28:55','2015-04-29 19:28:55',1),
  (15,'Yes, perfect! I\'m going to create discussion for the different tasks we have to do',2,'2015-04-29 19:29:51','2015-04-29 19:29:51',1),
  (16,'So, for now we have to work on the Research and the Experiments mainly',11,'2015-04-29 19:31:18','2015-04-29 19:31:18',1),
  (17,'Then will come the Report and Presentation',10,'2015-04-29 19:31:49','2015-04-29 19:31:49',1),
  (18,'I can\'t wait to start the experiments!! :innocent:',9,'2015-04-29 19:36:08','2015-04-29 19:36:08',1),
  (19,'That\'s the fun part but for now, let\'s focus on research',2,'2015-04-29 19:36:40','2015-04-29 19:36:40',1),
  (20,'Check this one http://blogs.biomedcentral.com/on-biology/2015/04/24/dna-day/ :)',11,'2015-04-29 19:39:06','2015-04-29 19:39:06',2),
  (21,'There is video on the topic: https://www.youtube.com/watch?v=27TxKoFU2Nw',11,'2015-04-29 19:40:32','2015-04-29 19:40:32',2),
  (22,'Experiments discussion, anything to share?',11,'2015-04-29 19:42:09','2015-04-29 19:42:09',3),
  (23,'Hi David',9,'2015-04-29 23:12:02','2015-04-29 23:12:02',8),
  (24,'Are you free to meet soon?',9,'2015-04-29 23:12:09','2015-04-29 23:12:09',8),
  (25,'Yeah sure, I\'m free in the afternoon, we can meet at the Lab',11,'2015-04-29 23:13:08','2015-04-29 23:13:08',8);

/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table msg_views
# ------------------------------------------------------------



# Dump of table notes
# ------------------------------------------------------------

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;

INSERT INTO `notes` (`id`, `title`, `content`, `user_id`, `project_id`, `permission`, `created_at`, `updated_at`)
VALUES
  (1,'Nerve Junctions','<title></title><div class=\"page\" title=\"Page 1\"><div class=\"section\"><div class=\"layoutArea\"><div class=\"column\"><p><span style=\"color: rgb(50.200000%, 0.000000%, 50.200000%);\">Nerve junctions</span></p><p><span>A nerve junction occurs between two neurones. This is called a </span><span style=\"color: rgb(60.000000%, 0.000000%, 60.000000%);\">synapse </span><span>and using specialised processes will allow two ormore neurones to communicate and send signals to one another. At a synaptic junction you will find the </span><span style=\"color: rgb(60.000000%, 0.000000%, 60.000000%);\">synaptic knob </span><span>onthe neurone sending the signal (the </span><span style=\"color: rgb(60.000000%, 0.000000%, 60.000000%);\">pre-synaptic neurone</span><span>), which communicates with the </span><span style=\"color: rgb(60.000000%, 0.000000%, 60.000000%);\">post-synaptic neurone</span><span>.</span></p></div></div></div></div>',11,1,0,'2015-04-29 20:01:02','2015-04-29 20:01:02'),
  (2,'Endocrines and exocrines','<title></title><div class=\"page\" title=\"Page 1\"><div class=\"layoutArea\"><div class=\"column\"><p><span>Hormonal communication is just another communication system, as is </span><span>nervouscommunication</span><span>. But this system involves the use of </span><span style=\"color: rgb(153, 0, 153);\">hormones</span><span>. The system,known as the </span><span style=\"color: rgb(153, 0, 153);\">endocrine system</span><span>, relies on blood circulation to transport itssignals. Molecules called hormones are released into the blood directly by</span><span style=\"color: rgb(153, 0, 153);\">endocrine </span><span>glands (ductless glands). However, there are two types of gland in ourbodies </span><span>– </span><span>those with and without ducts. The duct glands, called </span><span style=\"color: rgb(153, 0, 153);\">exocrine </span><span>glandsdo not release hormones, but secrete materials along a duct directly to the targetlocation, for example, salivary glands secreting saliva which flows to the mouth.</span><br/></p></div></div></div>',11,1,NULL,'2015-04-29 20:02:54','2015-04-29 20:02:54');

/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table projects
# ------------------------------------------------------------

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;

INSERT INTO `projects` (`id`, `name`, `duration`, `created_at`, `updated_at`, `slug`, `creator`)
VALUES
  (1,'Biology Coursework Group 2',20,'2015-04-29 15:30:17','2015-04-29 15:30:17','biology-coursework-group-2',2);

/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table projects_users
# ------------------------------------------------------------

LOCK TABLES `projects_users` WRITE;
/*!40000 ALTER TABLE `projects_users` DISABLE KEYS */;

INSERT INTO `projects_users` (`project_id`, `user_id`)
VALUES
  (1,2),
  (1,8),
  (1,9),
  (1,10),
  (1,11),
  (1,12);

/*!40000 ALTER TABLE `projects_users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table reviews
# ------------------------------------------------------------


# Dump of table subscriptions
# ------------------------------------------------------------



# Dump of table users
# ------------------------------------------------------------

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `first_name`, `last_name`, `created_at`, `updated_at`, `email`, `encrypted_password`, `reset_password_token`, `reset_password_sent_at`, `remember_created_at`, `sign_in_count`, `current_sign_in_at`, `last_sign_in_at`, `current_sign_in_ip`, `last_sign_in_ip`, `confirmation_token`, `confirmed_at`, `confirmation_sent_at`, `unconfirmed_email`, `authentication_token`, `profile_picture_file_name`, `profile_picture_content_type`, `profile_picture_file_size`, `profile_picture_updated_at`, `admin`, `last_project_opened`, `last_project_quit`, `is_oauth`)
VALUES
  (2,'Thomas','Quiroga','2015-04-29 15:29:39','2015-04-30 23:23:53','thomas@groupmates.uk','$2a$10$g7fTc1b89kc0fYa2e7xhgOVZQaQZwNaadYJGmNQGT4MPpTucOtVbS',NULL,NULL,NULL,5,'2015-04-30 08:49:27','2015-04-29 19:15:27','127.0.0.1','127.0.0.1',NULL,'2015-04-29 15:29:39',NULL,NULL,'VtSpanuak_9pJ6Y_vRze','10636757_10204340569737020_4719487178542385653_o.jpg','image/jpeg',131045,'2015-04-29 19:13:25',NULL,1,'2015-04-30 23:23:53',NULL),
  (8,'Evelyn','Huber','2015-04-29 15:51:30','2015-04-29 19:15:40','evelyn@groupmates.uk','$2a$10$Pum5abHkKwKWyEqrhVSCVuJJzOZS7Cuq7GulpuXdhej.7Awb32XP2',NULL,NULL,NULL,3,'2015-04-29 19:15:40','2015-04-29 16:02:18','127.0.0.1','127.0.0.1',NULL,'2015-04-29 15:51:30',NULL,NULL,'hw8ByxJj8ctHs-Vz41Rw','user_evelyn.jpg','image/jpeg',4857,'2015-04-29 15:51:40',NULL,1,'2015-04-29 18:09:26',NULL),
  (9,'Aline','Moss','2015-04-29 15:52:37','2015-04-29 19:48:28','aline@groupmates.uk','$2a$10$pKcMfyyIY5BR3o9gsO2bN.zZvWDdbapS5CY0a5uhxT4FBj0Wou4mO',NULL,NULL,NULL,2,'2015-04-29 19:34:02','2015-04-29 15:52:37','127.0.0.1','127.0.0.1',NULL,'2015-04-29 15:52:37',NULL,NULL,'y2mr6Lmytq1FUvL8KLbX','user_dawn.jpg','image/jpeg',3823,'2015-04-29 15:53:15',NULL,1,'2015-04-29 19:48:28',NULL),
  (10,'John','Norris','2015-04-29 15:55:45','2015-04-29 22:36:19','john@groupmates.uk','$2a$10$aXMAf1ebDS1MN840uIfhNuOoJRi2tp2/eKCeypTgVMW13j7r9mJfC',NULL,NULL,NULL,2,'2015-04-29 19:28:48','2015-04-29 15:55:45','127.0.0.1','127.0.0.1',NULL,'2015-04-29 15:55:45',NULL,NULL,'6Pk_zvynVe47nYC4xBFA','user_john.jpg','image/jpeg',5728,'2015-04-29 15:55:57',NULL,1,'2015-04-29 22:36:19',NULL),
  (11,'David','Burris','2015-04-29 15:56:32','2015-05-02 19:23:28','david@groupmates.uk','$2a$10$/.7fTb9oxATsiEx2loD0H.o6qDI81HlPFZqGpT/JBFIz/MDEZigYm',NULL,NULL,'2015-04-29 23:03:26',6,'2015-05-02 19:23:28','2015-05-02 19:23:28','127.0.0.1','127.0.0.1',NULL,'2015-04-29 15:56:32',NULL,NULL,'pMkxfDA2zxPPnn1k9qKu','user_david.jpg','image/jpeg',3309,'2015-04-29 15:59:02',NULL,1,'2015-04-30 23:23:57',NULL),
  (12,'Kylan','Currys','2015-04-29 16:00:05','2015-04-29 16:00:17','kylan@groupmates.uk','$2a$10$JsvUg67hKniIbIrruTOHJeCal4KmXwqXdsYLbwZoX1/ByEYlaDl8i',NULL,NULL,NULL,1,'2015-04-29 16:00:05','2015-04-29 16:00:05','127.0.0.1','127.0.0.1',NULL,'2015-04-29 16:00:05',NULL,NULL,'ZtW9oszaKWJzFuoSBDfL','user_kylan.jpg','image/jpeg',4954,'2015-04-29 16:00:17',NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
