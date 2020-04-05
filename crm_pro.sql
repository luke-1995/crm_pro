/*
Navicat MySQL Data Transfer

Source Server         : 本地测试
Source Server Version : 50645
Source Host           : localhost:3306
Source Database       : crm

Target Server Type    : MYSQL
Target Server Version : 50645
File Encoding         : 65001

Date: 2019-12-23 15:39:43
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_group_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_permission`
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('5', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('8', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('9', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('10', 'Can add content type', '4', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('11', 'Can change content type', '4', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('12', 'Can delete content type', '4', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('13', 'Can add session', '5', 'add_session');
INSERT INTO `auth_permission` VALUES ('14', 'Can change session', '5', 'change_session');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete session', '5', 'delete_session');
INSERT INTO `auth_permission` VALUES ('16', 'Can add first menu', '6', 'add_firstmenu');
INSERT INTO `auth_permission` VALUES ('17', 'Can change first menu', '6', 'change_firstmenu');
INSERT INTO `auth_permission` VALUES ('18', 'Can delete first menu', '6', 'delete_firstmenu');
INSERT INTO `auth_permission` VALUES ('19', 'Can add icon', '7', 'add_icon');
INSERT INTO `auth_permission` VALUES ('20', 'Can change icon', '7', 'change_icon');
INSERT INTO `auth_permission` VALUES ('21', 'Can delete icon', '7', 'delete_icon');
INSERT INTO `auth_permission` VALUES ('22', 'Can add permission', '8', 'add_permission');
INSERT INTO `auth_permission` VALUES ('23', 'Can change permission', '8', 'change_permission');
INSERT INTO `auth_permission` VALUES ('24', 'Can delete permission', '8', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('25', 'Can add role', '9', 'add_role');
INSERT INTO `auth_permission` VALUES ('26', 'Can change role', '9', 'change_role');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete role', '9', 'delete_role');
INSERT INTO `auth_permission` VALUES ('28', 'Can add user info', '10', 'add_userinfo');
INSERT INTO `auth_permission` VALUES ('29', 'Can change user info', '10', 'change_userinfo');
INSERT INTO `auth_permission` VALUES ('30', 'Can delete user info', '10', 'delete_userinfo');
INSERT INTO `auth_permission` VALUES ('31', 'Can add class list', '11', 'add_classlist');
INSERT INTO `auth_permission` VALUES ('32', 'Can change class list', '11', 'change_classlist');
INSERT INTO `auth_permission` VALUES ('33', 'Can delete class list', '11', 'delete_classlist');
INSERT INTO `auth_permission` VALUES ('34', 'Can add consult record', '12', 'add_consultrecord');
INSERT INTO `auth_permission` VALUES ('35', 'Can change consult record', '12', 'change_consultrecord');
INSERT INTO `auth_permission` VALUES ('36', 'Can delete consult record', '12', 'delete_consultrecord');
INSERT INTO `auth_permission` VALUES ('37', 'Can add course', '13', 'add_course');
INSERT INTO `auth_permission` VALUES ('38', 'Can change course', '13', 'change_course');
INSERT INTO `auth_permission` VALUES ('39', 'Can delete course', '13', 'delete_course');
INSERT INTO `auth_permission` VALUES ('40', 'Can add course record', '14', 'add_courserecord');
INSERT INTO `auth_permission` VALUES ('41', 'Can change course record', '14', 'change_courserecord');
INSERT INTO `auth_permission` VALUES ('42', 'Can delete course record', '14', 'delete_courserecord');
INSERT INTO `auth_permission` VALUES ('43', 'Can add customer', '15', 'add_customer');
INSERT INTO `auth_permission` VALUES ('44', 'Can change customer', '15', 'change_customer');
INSERT INTO `auth_permission` VALUES ('45', 'Can delete customer', '15', 'delete_customer');
INSERT INTO `auth_permission` VALUES ('46', 'Can add department', '16', 'add_department');
INSERT INTO `auth_permission` VALUES ('47', 'Can change department', '16', 'change_department');
INSERT INTO `auth_permission` VALUES ('48', 'Can delete department', '16', 'delete_department');
INSERT INTO `auth_permission` VALUES ('49', 'Can add homework', '17', 'add_homework');
INSERT INTO `auth_permission` VALUES ('50', 'Can change homework', '17', 'change_homework');
INSERT INTO `auth_permission` VALUES ('51', 'Can delete homework', '17', 'delete_homework');
INSERT INTO `auth_permission` VALUES ('52', 'Can add homework record', '18', 'add_homeworkrecord');
INSERT INTO `auth_permission` VALUES ('53', 'Can change homework record', '18', 'change_homeworkrecord');
INSERT INTO `auth_permission` VALUES ('54', 'Can delete homework record', '18', 'delete_homeworkrecord');
INSERT INTO `auth_permission` VALUES ('55', 'Can add student', '19', 'add_student');
INSERT INTO `auth_permission` VALUES ('56', 'Can change student', '19', 'change_student');
INSERT INTO `auth_permission` VALUES ('57', 'Can delete student', '19', 'delete_student');
INSERT INTO `auth_permission` VALUES ('58', 'Can add study record', '20', 'add_studyrecord');
INSERT INTO `auth_permission` VALUES ('59', 'Can change study record', '20', 'change_studyrecord');
INSERT INTO `auth_permission` VALUES ('60', 'Can delete study record', '20', 'delete_studyrecord');

-- ----------------------------
-- Table structure for `django_admin_log`
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
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
  KEY `django_admin_log_user_id_c564eba6_fk_web_userinfo_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_web_userinfo_id` FOREIGN KEY (`user_id`) REFERENCES `web_userinfo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for `django_content_type`
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('4', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('6', 'rbac', 'firstmenu');
INSERT INTO `django_content_type` VALUES ('7', 'rbac', 'icon');
INSERT INTO `django_content_type` VALUES ('8', 'rbac', 'permission');
INSERT INTO `django_content_type` VALUES ('9', 'rbac', 'role');
INSERT INTO `django_content_type` VALUES ('5', 'sessions', 'session');
INSERT INTO `django_content_type` VALUES ('11', 'web', 'classlist');
INSERT INTO `django_content_type` VALUES ('12', 'web', 'consultrecord');
INSERT INTO `django_content_type` VALUES ('13', 'web', 'course');
INSERT INTO `django_content_type` VALUES ('14', 'web', 'courserecord');
INSERT INTO `django_content_type` VALUES ('15', 'web', 'customer');
INSERT INTO `django_content_type` VALUES ('16', 'web', 'department');
INSERT INTO `django_content_type` VALUES ('17', 'web', 'homework');
INSERT INTO `django_content_type` VALUES ('18', 'web', 'homeworkrecord');
INSERT INTO `django_content_type` VALUES ('19', 'web', 'student');
INSERT INTO `django_content_type` VALUES ('20', 'web', 'studyrecord');
INSERT INTO `django_content_type` VALUES ('10', 'web', 'userinfo');

-- ----------------------------
-- Table structure for `django_migrations`
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'rbac', '0001_initial', '2019-12-21 11:14:08.113153');
INSERT INTO `django_migrations` VALUES ('2', 'contenttypes', '0001_initial', '2019-12-21 11:14:08.910033');
INSERT INTO `django_migrations` VALUES ('3', 'contenttypes', '0002_remove_content_type_name', '2019-12-21 11:14:10.378744');
INSERT INTO `django_migrations` VALUES ('4', 'auth', '0001_initial', '2019-12-21 11:14:15.300713');
INSERT INTO `django_migrations` VALUES ('5', 'auth', '0002_alter_permission_name_max_length', '2019-12-21 11:14:16.331970');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0003_alter_user_email_max_length', '2019-12-21 11:14:16.394427');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0004_alter_user_username_opts', '2019-12-21 11:14:16.472574');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0005_alter_user_last_login_null', '2019-12-21 11:14:16.535053');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0006_require_contenttypes_0002', '2019-12-21 11:14:16.581971');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0007_alter_validators_add_error_messages', '2019-12-21 11:14:16.644436');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0008_alter_user_username_max_length', '2019-12-21 11:14:16.722546');
INSERT INTO `django_migrations` VALUES ('12', 'auth', '0009_alter_user_last_name_max_length', '2019-12-21 11:14:16.910048');
INSERT INTO `django_migrations` VALUES ('13', 'web', '0001_initial', '2019-12-21 11:14:43.879021');
INSERT INTO `django_migrations` VALUES ('14', 'admin', '0001_initial', '2019-12-21 11:14:45.660314');
INSERT INTO `django_migrations` VALUES ('15', 'admin', '0002_logentry_remove_auto_add', '2019-12-21 11:14:45.738414');
INSERT INTO `django_migrations` VALUES ('16', 'sessions', '0001_initial', '2019-12-21 11:14:46.394719');
INSERT INTO `django_migrations` VALUES ('17', 'web', '0002_customer_consultant', '2019-12-21 11:25:00.913908');
INSERT INTO `django_migrations` VALUES ('18', 'web', '0003_auto_20191221_1146', '2019-12-21 11:47:08.264985');
INSERT INTO `django_migrations` VALUES ('19', 'web', '0004_auto_20191221_2231', '2019-12-21 22:31:42.084567');
INSERT INTO `django_migrations` VALUES ('20', 'web', '0005_auto_20191221_2302', '2019-12-21 23:02:51.757072');
INSERT INTO `django_migrations` VALUES ('21', 'web', '0006_auto_20191221_2349', '2019-12-21 23:49:57.228575');
INSERT INTO `django_migrations` VALUES ('22', 'web', '0007_auto_20191222_0910', '2019-12-22 09:11:03.523990');
INSERT INTO `django_migrations` VALUES ('23', 'web', '0008_auto_20191222_0928', '2019-12-22 09:28:34.306438');
INSERT INTO `django_migrations` VALUES ('24', 'web', '0009_auto_20191222_1305', '2019-12-22 13:06:09.810784');
INSERT INTO `django_migrations` VALUES ('25', 'web', '0010_auto_20191222_1339', '2019-12-22 13:40:09.335463');
INSERT INTO `django_migrations` VALUES ('26', 'web', '0011_auto_20191223_1106', '2019-12-23 11:07:42.768455');
INSERT INTO `django_migrations` VALUES ('27', 'web', '0012_auto_20191223_1423', '2019-12-23 14:23:34.748387');

-- ----------------------------
-- Table structure for `django_session`
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('p2v4x4otsmhoeh2a7h3u64xps3eyqlfq', 'MTA1YzY4MzFhZDA2OTkwMDRkZGE3NGIwMjU2ZjRlMjE0Zjg0M2QwNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiN2NlMDE4ZGIxYzZlODNkNDFjNmQ1OTU1MDc4NmY5NGYxNWJhYzUyIiwicGVybWlzc2lvbl9rZXkiOnsicmJhYzpyb2xlX2xpc3QiOnsiaWQiOjEsInVybCI6Ii9yb2xlX2xpc3QvIiwidGl0bGUiOiJcdTg5ZDJcdTgyNzJcdTUyMTdcdTg4NjgiLCJwYXJlbnRfcGVybWlzc2lvbl9pZCI6bnVsbH0sInJiYWM6cm9sZV9hZGQiOnsiaWQiOjIsInVybCI6Ii9yb2xlX2FkZC8iLCJ0aXRsZSI6Ilx1NmRmYlx1NTJhMFx1ODlkMlx1ODI3MiIsInBhcmVudF9wZXJtaXNzaW9uX2lkIjoxLCJwYXJlbnRfcGVybWlzc2lvbl90aXRsZSI6Ilx1ODlkMlx1ODI3Mlx1NTIxN1x1ODg2OCIsInBhcmVudF9wZXJtaXNzaW9uX3VybCI6Ii9yb2xlX2xpc3QvIn0sInJiYWM6cm9sZV9lZGl0Ijp7ImlkIjozLCJ1cmwiOiIvcm9sZV9lZGl0Lyg/UDxyb2xlX3BrPlxcZCspLyIsInRpdGxlIjoiXHU0ZmVlXHU2NTM5XHU4OWQyXHU4MjcyIiwicGFyZW50X3Blcm1pc3Npb25faWQiOjEsInBhcmVudF9wZXJtaXNzaW9uX3RpdGxlIjoiXHU4OWQyXHU4MjcyXHU1MjE3XHU4ODY4IiwicGFyZW50X3Blcm1pc3Npb25fdXJsIjoiL3JvbGVfbGlzdC8ifSwicmJhYzpyb2xlX2RlbCI6eyJpZCI6NCwidXJsIjoiL3JvbGVfZGVsLyg/UDxyb2xlX3BrPlxcZCspLyIsInRpdGxlIjoiXHU1MjIwXHU5NjY0XHU4OWQyXHU4MjcyIiwicGFyZW50X3Blcm1pc3Npb25faWQiOjEsInBhcmVudF9wZXJtaXNzaW9uX3RpdGxlIjoiXHU4OWQyXHU4MjcyXHU1MjE3XHU4ODY4IiwicGFyZW50X3Blcm1pc3Npb25fdXJsIjoiL3JvbGVfbGlzdC8ifSwicmJhYzptZW51X2xpc3QiOnsiaWQiOjUsInVybCI6Ii9tZW51X2xpc3QvIiwidGl0bGUiOiJcdTgzZGNcdTUzNTVcdTUyMTdcdTg4NjgiLCJwYXJlbnRfcGVybWlzc2lvbl9pZCI6bnVsbH0sInJiYWM6bWVudV9hZGQiOnsiaWQiOjYsInVybCI6Ii9tZW51X2FkZC8iLCJ0aXRsZSI6Ilx1NmRmYlx1NTJhMFx1NGUwMFx1N2VhN1x1ODNkY1x1NTM1NSIsInBhcmVudF9wZXJtaXNzaW9uX2lkIjo1LCJwYXJlbnRfcGVybWlzc2lvbl90aXRsZSI6Ilx1ODNkY1x1NTM1NVx1NTIxN1x1ODg2OCIsInBhcmVudF9wZXJtaXNzaW9uX3VybCI6Ii9tZW51X2xpc3QvIn0sInJiYWM6bWVudV9lZGl0Ijp7ImlkIjo3LCJ1cmwiOiIvbWVudV9lZGl0Lyg/UDxtZW51X3BrPlxcZCspLyIsInRpdGxlIjoiXHU0ZmVlXHU2NTM5XHU0ZTAwXHU3ZWE3XHU4M2RjXHU1MzU1IiwicGFyZW50X3Blcm1pc3Npb25faWQiOjUsInBhcmVudF9wZXJtaXNzaW9uX3RpdGxlIjoiXHU4M2RjXHU1MzU1XHU1MjE3XHU4ODY4IiwicGFyZW50X3Blcm1pc3Npb25fdXJsIjoiL21lbnVfbGlzdC8ifSwicmJhYzptZW51X2RlbCI6eyJpZCI6OCwidXJsIjoiL21lbnVfZGVsLyg/UDxtZW51X3BrPlxcZCspLyIsInRpdGxlIjoiXHU1MjIwXHU5NjY0XHU0ZTAwXHU3ZWE3XHU4M2RjXHU1MzU1IiwicGFyZW50X3Blcm1pc3Npb25faWQiOjUsInBhcmVudF9wZXJtaXNzaW9uX3RpdGxlIjoiXHU4M2RjXHU1MzU1XHU1MjE3XHU4ODY4IiwicGFyZW50X3Blcm1pc3Npb25fdXJsIjoiL21lbnVfbGlzdC8ifSwicmJhYzpzZWNvbmRfbWVudV9hZGQiOnsiaWQiOjksInVybCI6Ii9zZWNvbmRfbWVudV9hZGQvIiwidGl0bGUiOiJcdTZkZmJcdTUyYTBcdTRlOGNcdTdlYTdcdTgzZGNcdTUzNTUiLCJwYXJlbnRfcGVybWlzc2lvbl9pZCI6NSwicGFyZW50X3Blcm1pc3Npb25fdGl0bGUiOiJcdTgzZGNcdTUzNTVcdTUyMTdcdTg4NjgiLCJwYXJlbnRfcGVybWlzc2lvbl91cmwiOiIvbWVudV9saXN0LyJ9LCJyYmFjOnNlY29uZF9tZW51X2VkaXQiOnsiaWQiOjEwLCJ1cmwiOiIvc2Vjb25kX21lbnVfZWRpdC8oP1A8c2Vjb25kX21lbnVfcGs+XFxkKykvIiwidGl0bGUiOiJcdTRmZWVcdTY1MzlcdTRlOGNcdTdlYTdcdTgzZGNcdTUzNTUiLCJwYXJlbnRfcGVybWlzc2lvbl9pZCI6NSwicGFyZW50X3Blcm1pc3Npb25fdGl0bGUiOiJcdTgzZGNcdTUzNTVcdTUyMTdcdTg4NjgiLCJwYXJlbnRfcGVybWlzc2lvbl91cmwiOiIvbWVudV9saXN0LyJ9LCJyYmFjOnNlY29uZF9tZW51X2RlbCI6eyJpZCI6MTEsInVybCI6Ii9zZWNvbmRfbWVudV9kZWwvKD9QPHNlY29uZF9tZW51X3BrPlxcZCspLyIsInRpdGxlIjoiXHU1MjIwXHU5NjY0XHU0ZThjXHU3ZWE3XHU4M2RjXHU1MzU1IiwicGFyZW50X3Blcm1pc3Npb25faWQiOjUsInBhcmVudF9wZXJtaXNzaW9uX3RpdGxlIjoiXHU4M2RjXHU1MzU1XHU1MjE3XHU4ODY4IiwicGFyZW50X3Blcm1pc3Npb25fdXJsIjoiL21lbnVfbGlzdC8ifSwicmJhYzpwZXJtaXNzaW9uX2ltcG9ydF9saXN0Ijp7ImlkIjoxMiwidXJsIjoiL3Blcm1pc3Npb25faW1wb3J0X2xpc3QvIiwidGl0bGUiOiJcdTYyNzlcdTkxY2ZcdTY3NDNcdTk2NTBcdTUyMTdcdTg4NjgiLCJwYXJlbnRfcGVybWlzc2lvbl9pZCI6bnVsbH0sInJiYWM6cGVybWlzc2lvbl9pbXBvcnRfZGVsIjp7ImlkIjoxMywidXJsIjoiL3Blcm1pc3Npb25faW1wb3J0X2RlbC8oP1A8cGVybWlzc2lvbl9waz5cXGQrKS8iLCJ0aXRsZSI6Ilx1NjI3OVx1OTFjZlx1NTIyMFx1OTY2NFx1Njc0M1x1OTY1MCIsInBhcmVudF9wZXJtaXNzaW9uX2lkIjoxMiwicGFyZW50X3Blcm1pc3Npb25fdGl0bGUiOiJcdTYyNzlcdTkxY2ZcdTY3NDNcdTk2NTBcdTUyMTdcdTg4NjgiLCJwYXJlbnRfcGVybWlzc2lvbl91cmwiOiIvcGVybWlzc2lvbl9pbXBvcnRfbGlzdC8ifSwicmJhYzpkaXN0cmlidXRlX3Blcm1pc3Npb25fbGlzdCI6eyJpZCI6MTQsInVybCI6Ii9kaXN0cmlidXRlX3Blcm1pc3Npb25fbGlzdC8iLCJ0aXRsZSI6Ilx1Njc0M1x1OTY1MFx1NTIwNlx1OTE0ZFx1NTIxN1x1ODg2OCIsInBhcmVudF9wZXJtaXNzaW9uX2lkIjpudWxsfSwid2ViX3VzZXJpbmZvX2xpc3QiOnsiaWQiOjE1LCJ1cmwiOiIvd2ViL3VzZXJpbmZvL2xpc3QvIiwidGl0bGUiOiJcdTc1MjhcdTYyMzdcdTUyMTdcdTg4NjgiLCJwYXJlbnRfcGVybWlzc2lvbl9pZCI6bnVsbH0sIndlYl91c2VyaW5mb19hZGQiOnsiaWQiOjE2LCJ1cmwiOiIvd2ViL3VzZXJpbmZvL2FkZC8iLCJ0aXRsZSI6Ilx1NmRmYlx1NTJhMFx1NzUyOFx1NjIzNyIsInBhcmVudF9wZXJtaXNzaW9uX2lkIjoxNSwicGFyZW50X3Blcm1pc3Npb25fdGl0bGUiOiJcdTc1MjhcdTYyMzdcdTUyMTdcdTg4NjgiLCJwYXJlbnRfcGVybWlzc2lvbl91cmwiOiIvd2ViL3VzZXJpbmZvL2xpc3QvIn0sIndlYl91c2VyaW5mb19jaGFuZ2UiOnsiaWQiOjE3LCJ1cmwiOiIvd2ViL3VzZXJpbmZvL2NoYW5nZS8oP1A8cGs+XFxkKykvIiwidGl0bGUiOiJcdTRmZWVcdTY1MzlcdTc1MjhcdTYyMzciLCJwYXJlbnRfcGVybWlzc2lvbl9pZCI6MTUsInBhcmVudF9wZXJtaXNzaW9uX3RpdGxlIjoiXHU3NTI4XHU2MjM3XHU1MjE3XHU4ODY4IiwicGFyZW50X3Blcm1pc3Npb25fdXJsIjoiL3dlYi91c2VyaW5mby9saXN0LyJ9LCJ3ZWJfdXNlcmluZm9fZGVsIjp7ImlkIjoxOCwidXJsIjoiL3dlYi91c2VyaW5mby9kZWwvKD9QPHBrPlxcZCspLyIsInRpdGxlIjoiXHU1MjIwXHU5NjY0XHU3NTI4XHU2MjM3IiwicGFyZW50X3Blcm1pc3Npb25faWQiOjE1LCJwYXJlbnRfcGVybWlzc2lvbl90aXRsZSI6Ilx1NzUyOFx1NjIzN1x1NTIxN1x1ODg2OCIsInBhcmVudF9wZXJtaXNzaW9uX3VybCI6Ii93ZWIvdXNlcmluZm8vbGlzdC8ifSwid2ViX3VzZXJpbmZvX3Jlc2V0X3B3ZCI6eyJpZCI6MTksInVybCI6Ii93ZWIvdXNlcmluZm8vcmVzZXRfcHdkLyg/UDxwaz5cXGQrKS8iLCJ0aXRsZSI6Ilx1OTFjZFx1N2Y2ZVx1NWJjNlx1NzgwMSIsInBhcmVudF9wZXJtaXNzaW9uX2lkIjoxNSwicGFyZW50X3Blcm1pc3Npb25fdGl0bGUiOiJcdTc1MjhcdTYyMzdcdTUyMTdcdTg4NjgiLCJwYXJlbnRfcGVybWlzc2lvbl91cmwiOiIvd2ViL3VzZXJpbmZvL2xpc3QvIn0sIndlYl9kZXBhcnRtZW50X2xpc3QiOnsiaWQiOjIwLCJ1cmwiOiIvd2ViL2RlcGFydG1lbnQvbGlzdC8iLCJ0aXRsZSI6Ilx1OTBlOFx1OTVlOFx1NTIxN1x1ODg2OCIsInBhcmVudF9wZXJtaXNzaW9uX2lkIjpudWxsfSwid2ViX2RlcGFydG1lbnRfYWRkIjp7ImlkIjoyMSwidXJsIjoiL3dlYi9kZXBhcnRtZW50L2FkZC8iLCJ0aXRsZSI6Ilx1NmRmYlx1NTJhMFx1OTBlOFx1OTVlOCIsInBhcmVudF9wZXJtaXNzaW9uX2lkIjoyMCwicGFyZW50X3Blcm1pc3Npb25fdGl0bGUiOiJcdTkwZThcdTk1ZThcdTUyMTdcdTg4NjgiLCJwYXJlbnRfcGVybWlzc2lvbl91cmwiOiIvd2ViL2RlcGFydG1lbnQvbGlzdC8ifSwid2ViX2RlcGFydG1lbnRfY2hhbmdlIjp7ImlkIjoyMiwidXJsIjoiL3dlYi9kZXBhcnRtZW50L2NoYW5nZS8oP1A8cGs+XFxkKykvIiwidGl0bGUiOiJcdTRmZWVcdTY1MzlcdTkwZThcdTk1ZTgiLCJwYXJlbnRfcGVybWlzc2lvbl9pZCI6MjAsInBhcmVudF9wZXJtaXNzaW9uX3RpdGxlIjoiXHU5MGU4XHU5NWU4XHU1MjE3XHU4ODY4IiwicGFyZW50X3Blcm1pc3Npb25fdXJsIjoiL3dlYi9kZXBhcnRtZW50L2xpc3QvIn0sIndlYl9kZXBhcnRtZW50X2RlbCI6eyJpZCI6MjMsInVybCI6Ii93ZWIvZGVwYXJ0bWVudC9kZWwvKD9QPHBrPlxcZCspLyIsInRpdGxlIjoiXHU1MjIwXHU5NjY0XHU5MGU4XHU5NWU4IiwicGFyZW50X3Blcm1pc3Npb25faWQiOjIwLCJwYXJlbnRfcGVybWlzc2lvbl90aXRsZSI6Ilx1OTBlOFx1OTVlOFx1NTIxN1x1ODg2OCIsInBhcmVudF9wZXJtaXNzaW9uX3VybCI6Ii93ZWIvZGVwYXJ0bWVudC9saXN0LyJ9LCJ3ZWJfY291cnNlX2xpc3QiOnsiaWQiOjI0LCJ1cmwiOiIvd2ViL2NvdXJzZS9saXN0LyIsInRpdGxlIjoiXHU4YmZlXHU3YTBiXHU1MjE3XHU4ODY4IiwicGFyZW50X3Blcm1pc3Npb25faWQiOm51bGx9LCJ3ZWJfY2xhc3NsaXN0X2xpc3QiOnsiaWQiOjI4LCJ1cmwiOiIvd2ViL2NsYXNzbGlzdC9saXN0LyIsInRpdGxlIjoiXHU3M2VkXHU3ZWE3XHU1MjE3XHU4ODY4IiwicGFyZW50X3Blcm1pc3Npb25faWQiOm51bGx9LCJ3ZWJfY2xhc3NsaXN0X2FkZCI6eyJpZCI6MjksInVybCI6Ii93ZWIvY2xhc3NsaXN0L2FkZC8iLCJ0aXRsZSI6Ilx1NmRmYlx1NTJhMFx1NzNlZFx1N2VhNyIsInBhcmVudF9wZXJtaXNzaW9uX2lkIjoyOCwicGFyZW50X3Blcm1pc3Npb25fdGl0bGUiOiJcdTczZWRcdTdlYTdcdTUyMTdcdTg4NjgiLCJwYXJlbnRfcGVybWlzc2lvbl91cmwiOiIvd2ViL2NsYXNzbGlzdC9saXN0LyJ9LCJ3ZWJfY2xhc3NsaXN0X2NoYW5nZSI6eyJpZCI6MzAsInVybCI6Ii93ZWIvY2xhc3NsaXN0L2NoYW5nZS8oP1A8cGs+XFxkKykvIiwidGl0bGUiOiJcdTRmZWVcdTY1MzlcdTczZWRcdTdlYTciLCJwYXJlbnRfcGVybWlzc2lvbl9pZCI6MjgsInBhcmVudF9wZXJtaXNzaW9uX3RpdGxlIjoiXHU3M2VkXHU3ZWE3XHU1MjE3XHU4ODY4IiwicGFyZW50X3Blcm1pc3Npb25fdXJsIjoiL3dlYi9jbGFzc2xpc3QvbGlzdC8ifSwid2ViX2NsYXNzbGlzdF9kZWwiOnsiaWQiOjMxLCJ1cmwiOiIvd2ViL2NsYXNzbGlzdC9kZWwvKD9QPHBrPlxcZCspLyIsInRpdGxlIjoiXHU1MjIwXHU5NjY0XHU3M2VkXHU3ZWE3IiwicGFyZW50X3Blcm1pc3Npb25faWQiOjI4LCJwYXJlbnRfcGVybWlzc2lvbl90aXRsZSI6Ilx1NzNlZFx1N2VhN1x1NTIxN1x1ODg2OCIsInBhcmVudF9wZXJtaXNzaW9uX3VybCI6Ii93ZWIvY2xhc3NsaXN0L2xpc3QvIn0sIndlYl9jdXN0b21lcl9saXN0Ijp7ImlkIjozMiwidXJsIjoiL3dlYi9jdXN0b21lci9saXN0LyIsInRpdGxlIjoiXHU1YmEyXHU2MjM3XHU1MjE3XHU4ODY4IiwicGFyZW50X3Blcm1pc3Npb25faWQiOm51bGx9LCJ3ZWJfY3VzdG9tZXJfYWRkIjp7ImlkIjozMywidXJsIjoiL3dlYi9jdXN0b21lci9hZGQvIiwidGl0bGUiOiJcdTZkZmJcdTUyYTBcdTViYTJcdTYyMzciLCJwYXJlbnRfcGVybWlzc2lvbl9pZCI6MzIsInBhcmVudF9wZXJtaXNzaW9uX3RpdGxlIjoiXHU1YmEyXHU2MjM3XHU1MjE3XHU4ODY4IiwicGFyZW50X3Blcm1pc3Npb25fdXJsIjoiL3dlYi9jdXN0b21lci9saXN0LyJ9LCJ3ZWJfY3VzdG9tZXJfY2hhbmdlIjp7ImlkIjozNCwidXJsIjoiL3dlYi9jdXN0b21lci9jaGFuZ2UvKD9QPHBrPlxcZCspLyIsInRpdGxlIjoiXHU0ZmVlXHU2NTM5XHU1YmEyXHU2MjM3IiwicGFyZW50X3Blcm1pc3Npb25faWQiOjMyLCJwYXJlbnRfcGVybWlzc2lvbl90aXRsZSI6Ilx1NWJhMlx1NjIzN1x1NTIxN1x1ODg2OCIsInBhcmVudF9wZXJtaXNzaW9uX3VybCI6Ii93ZWIvY3VzdG9tZXIvbGlzdC8ifSwid2ViX2N1c3RvbWVyX2RlbCI6eyJpZCI6MzUsInVybCI6Ii93ZWIvY3VzdG9tZXIvZGVsLyg/UDxwaz5cXGQrKS8iLCJ0aXRsZSI6Ilx1NTIyMFx1OTY2NFx1NWJhMlx1NjIzNyIsInBhcmVudF9wZXJtaXNzaW9uX2lkIjozMiwicGFyZW50X3Blcm1pc3Npb25fdGl0bGUiOiJcdTViYTJcdTYyMzdcdTUyMTdcdTg4NjgiLCJwYXJlbnRfcGVybWlzc2lvbl91cmwiOiIvd2ViL2N1c3RvbWVyL2xpc3QvIn0sIndlYl9jb25zdWx0cmVjb3JkX2xpc3QiOnsiaWQiOjM2LCJ1cmwiOiIvd2ViL2NvbnN1bHRyZWNvcmQvbGlzdC8oP1A8Y3VzdG9tZXJfaWQ+XFxkKykvIiwidGl0bGUiOiJcdTViYTJcdTYyMzdcdThkZGZcdThmZGJcdThiYjBcdTVmNTVcdTUyMTdcdTg4NjgiLCJwYXJlbnRfcGVybWlzc2lvbl9pZCI6MzIsInBhcmVudF9wZXJtaXNzaW9uX3RpdGxlIjoiXHU1YmEyXHU2MjM3XHU1MjE3XHU4ODY4IiwicGFyZW50X3Blcm1pc3Npb25fdXJsIjoiL3dlYi9jdXN0b21lci9saXN0LyJ9LCJ3ZWJfY29uc3VsdHJlY29yZF9hZGQiOnsiaWQiOjM3LCJ1cmwiOiIvd2ViL2NvbnN1bHRyZWNvcmQvYWRkLyg/UDxjdXN0b21lcl9pZD5cXGQrKS8iLCJ0aXRsZSI6Ilx1NmRmYlx1NTJhMFx1NWJhMlx1NjIzN1x1OGRkZlx1OGZkYlx1OGJiMFx1NWY1NSIsInBhcmVudF9wZXJtaXNzaW9uX2lkIjozMiwicGFyZW50X3Blcm1pc3Npb25fdGl0bGUiOiJcdTViYTJcdTYyMzdcdTUyMTdcdTg4NjgiLCJwYXJlbnRfcGVybWlzc2lvbl91cmwiOiIvd2ViL2N1c3RvbWVyL2xpc3QvIn0sIndlYl9jb25zdWx0cmVjb3JkX2NoYW5nZSI6eyJpZCI6MzgsInVybCI6Ii93ZWIvY29uc3VsdHJlY29yZC9jaGFuZ2UvKD9QPHBrPlxcZCspLyg/UDxjdXN0b21lcl9pZD5cXGQrKS8iLCJ0aXRsZSI6Ilx1NGZlZVx1NjUzOVx1NWJhMlx1NjIzN1x1OGRkZlx1OGZkYlx1OGJiMFx1NWY1NSIsInBhcmVudF9wZXJtaXNzaW9uX2lkIjozMiwicGFyZW50X3Blcm1pc3Npb25fdGl0bGUiOiJcdTViYTJcdTYyMzdcdTUyMTdcdTg4NjgiLCJwYXJlbnRfcGVybWlzc2lvbl91cmwiOiIvd2ViL2N1c3RvbWVyL2xpc3QvIn0sIndlYl9jb25zdWx0cmVjb3JkX2RlbCI6eyJpZCI6MzksInVybCI6Ii93ZWIvY29uc3VsdHJlY29yZC9kZWwvKD9QPHBrPlxcZCspLyg/UDxjdXN0b21lcl9pZD5cXGQrKS8iLCJ0aXRsZSI6Ilx1NTIyMFx1OTY2NFx1NWJhMlx1NjIzN1x1OGRkZlx1OGZkYlx1OGJiMFx1NWY1NSIsInBhcmVudF9wZXJtaXNzaW9uX2lkIjozMiwicGFyZW50X3Blcm1pc3Npb25fdGl0bGUiOiJcdTViYTJcdTYyMzdcdTUyMTdcdTg4NjgiLCJwYXJlbnRfcGVybWlzc2lvbl91cmwiOiIvd2ViL2N1c3RvbWVyL2xpc3QvIn0sIndlYl9jb3Vyc2VyZWNvcmRfbGlzdCI6eyJpZCI6NDAsInVybCI6Ii93ZWIvY291cnNlcmVjb3JkL2xpc3QvKD9QPGNsYXNzX2lkPlxcZCspLyIsInRpdGxlIjoiXHU0ZTBhXHU4YmZlXHU4YmIwXHU1ZjU1XHU1MjE3XHU4ODY4IiwicGFyZW50X3Blcm1pc3Npb25faWQiOjI4LCJwYXJlbnRfcGVybWlzc2lvbl90aXRsZSI6Ilx1NzNlZFx1N2VhN1x1NTIxN1x1ODg2OCIsInBhcmVudF9wZXJtaXNzaW9uX3VybCI6Ii93ZWIvY2xhc3NsaXN0L2xpc3QvIn0sIndlYl9jb3Vyc2VyZWNvcmRfYWRkIjp7ImlkIjo0MSwidXJsIjoiL3dlYi9jb3Vyc2VyZWNvcmQvYWRkLyg/UDxjbGFzc19pZD5cXGQrKS8iLCJ0aXRsZSI6Ilx1NmRmYlx1NTJhMFx1NGUwYVx1OGJmZVx1OGJiMFx1NWY1NSIsInBhcmVudF9wZXJtaXNzaW9uX2lkIjoyOCwicGFyZW50X3Blcm1pc3Npb25fdGl0bGUiOiJcdTczZWRcdTdlYTdcdTUyMTdcdTg4NjgiLCJwYXJlbnRfcGVybWlzc2lvbl91cmwiOiIvd2ViL2NsYXNzbGlzdC9saXN0LyJ9LCJ3ZWJfY291cnNlcmVjb3JkX2NoYW5nZSI6eyJpZCI6NDIsInVybCI6Ii93ZWIvY291cnNlcmVjb3JkL2NoYW5nZS8oP1A8cGs+XFxkKykvKD9QPGNsYXNzX2lkPlxcZCspLyIsInRpdGxlIjoiXHU0ZmVlXHU2NTM5XHU0ZTBhXHU4YmZlXHU4YmIwXHU1ZjU1IiwicGFyZW50X3Blcm1pc3Npb25faWQiOjI4LCJwYXJlbnRfcGVybWlzc2lvbl90aXRsZSI6Ilx1NzNlZFx1N2VhN1x1NTIxN1x1ODg2OCIsInBhcmVudF9wZXJtaXNzaW9uX3VybCI6Ii93ZWIvY2xhc3NsaXN0L2xpc3QvIn0sIndlYl9jb3Vyc2VyZWNvcmRfZGVsIjp7ImlkIjo0MywidXJsIjoiL3dlYi9jb3Vyc2VyZWNvcmQvZGVsLyg/UDxwaz5cXGQrKS8oP1A8Y2xhc3NfaWQ+XFxkKykvIiwidGl0bGUiOiJcdTUyMjBcdTk2NjRcdTRlMGFcdThiZmVcdThiYjBcdTVmNTUiLCJwYXJlbnRfcGVybWlzc2lvbl9pZCI6MjgsInBhcmVudF9wZXJtaXNzaW9uX3RpdGxlIjoiXHU3M2VkXHU3ZWE3XHU1MjE3XHU4ODY4IiwicGFyZW50X3Blcm1pc3Npb25fdXJsIjoiL3dlYi9jbGFzc2xpc3QvbGlzdC8ifSwid2ViX2NvdXJzZXJlY29yZF9zdHVkZW50X3JlY29yZCI6eyJpZCI6NDQsInVybCI6Ii93ZWIvY291cnNlcmVjb3JkL3N0dWRlbnRfcmVjb3JkLyg/UDxwaz5cXGQrKS8oP1A8Y2xhc3NfaWQ+XFxkKykvIiwidGl0bGUiOiJcdTgwMDNcdTUyZTRcdThiYjBcdTVmNTUiLCJwYXJlbnRfcGVybWlzc2lvbl9pZCI6MjgsInBhcmVudF9wZXJtaXNzaW9uX3RpdGxlIjoiXHU3M2VkXHU3ZWE3XHU1MjE3XHU4ODY4IiwicGFyZW50X3Blcm1pc3Npb25fdXJsIjoiL3dlYi9jbGFzc2xpc3QvbGlzdC8ifSwid2ViX2hvbWV3b3JrX2xpc3QiOnsiaWQiOjQ1LCJ1cmwiOiIvd2ViL2hvbWV3b3JrL2xpc3QvKD9QPGNsYXNzX2lkPlxcZCspLyIsInRpdGxlIjoiXHU0ZjVjXHU0ZTFhXHU1MjE3XHU4ODY4IiwicGFyZW50X3Blcm1pc3Npb25faWQiOjI4LCJwYXJlbnRfcGVybWlzc2lvbl90aXRsZSI6Ilx1NzNlZFx1N2VhN1x1NTIxN1x1ODg2OCIsInBhcmVudF9wZXJtaXNzaW9uX3VybCI6Ii93ZWIvY2xhc3NsaXN0L2xpc3QvIn0sIndlYl9ob21ld29ya19hZGQiOnsiaWQiOjQ2LCJ1cmwiOiIvd2ViL2hvbWV3b3JrL2FkZC8oP1A8Y2xhc3NfaWQ+XFxkKykvIiwidGl0bGUiOiJcdTZkZmJcdTUyYTBcdTRmNWNcdTRlMWEiLCJwYXJlbnRfcGVybWlzc2lvbl9pZCI6MjgsInBhcmVudF9wZXJtaXNzaW9uX3RpdGxlIjoiXHU3M2VkXHU3ZWE3XHU1MjE3XHU4ODY4IiwicGFyZW50X3Blcm1pc3Npb25fdXJsIjoiL3dlYi9jbGFzc2xpc3QvbGlzdC8ifSwid2ViX2hvbWV3b3JrX2NoYW5nZSI6eyJpZCI6NDcsInVybCI6Ii93ZWIvaG9tZXdvcmsvY2hhbmdlLyg/UDxwaz5cXGQrKS8oP1A8Y2xhc3NfaWQ+XFxkKykvIiwidGl0bGUiOiJcdTRmZWVcdTY1MzlcdTRmNWNcdTRlMWEiLCJwYXJlbnRfcGVybWlzc2lvbl9pZCI6MjgsInBhcmVudF9wZXJtaXNzaW9uX3RpdGxlIjoiXHU3M2VkXHU3ZWE3XHU1MjE3XHU4ODY4IiwicGFyZW50X3Blcm1pc3Npb25fdXJsIjoiL3dlYi9jbGFzc2xpc3QvbGlzdC8ifSwid2ViX2hvbWV3b3JrX2RlbCI6eyJpZCI6NDgsInVybCI6Ii93ZWIvaG9tZXdvcmsvZGVsLyg/UDxwaz5cXGQrKS8oP1A8Y2xhc3NfaWQ+XFxkKykvIiwidGl0bGUiOiJcdTUyMjBcdTk2NjRcdTRmNWNcdTRlMWEiLCJwYXJlbnRfcGVybWlzc2lvbl9pZCI6MjgsInBhcmVudF9wZXJtaXNzaW9uX3RpdGxlIjoiXHU3M2VkXHU3ZWE3XHU1MjE3XHU4ODY4IiwicGFyZW50X3Blcm1pc3Npb25fdXJsIjoiL3dlYi9jbGFzc2xpc3QvbGlzdC8ifSwid2ViX2hvbWV3b3JrX2hvbWV3b3JrX3JlY29yZCI6eyJpZCI6NDksInVybCI6Ii93ZWIvaG9tZXdvcmsvaG9tZXdvcmtfcmVjb3JkLyg/UDxwaz5cXGQrKS8oP1A8Y2xhc3NfaWQ+XFxkKykvIiwidGl0bGUiOiJcdTViNjZcdTc1MWZcdTRmNWNcdTRlMWFcdThiYjBcdTVmNTUiLCJwYXJlbnRfcGVybWlzc2lvbl9pZCI6MjgsInBhcmVudF9wZXJtaXNzaW9uX3RpdGxlIjoiXHU3M2VkXHU3ZWE3XHU1MjE3XHU4ODY4IiwicGFyZW50X3Blcm1pc3Npb25fdXJsIjoiL3dlYi9jbGFzc2xpc3QvbGlzdC8ifSwid2ViX2hvbWV3b3JrcmVjb3JkX2xpc3QiOnsiaWQiOjUwLCJ1cmwiOiIvd2ViL2hvbWV3b3JrcmVjb3JkL2xpc3QvIiwidGl0bGUiOiJcdTYzZDBcdTRlYTRcdTRmNWNcdTRlMWFcdTUyMTdcdTg4NjgiLCJwYXJlbnRfcGVybWlzc2lvbl9pZCI6bnVsbH0sIndlYl9ob21ld29ya3JlY29yZF9jaGFuZ2UiOnsiaWQiOjUxLCJ1cmwiOiIvd2ViL2hvbWV3b3JrcmVjb3JkL2NoYW5nZS8oP1A8cGs+XFxkKykvIiwidGl0bGUiOiJcdTRlMGFcdTRmMjBcdTRmNWNcdTRlMWEiLCJwYXJlbnRfcGVybWlzc2lvbl9pZCI6NTAsInBhcmVudF9wZXJtaXNzaW9uX3RpdGxlIjoiXHU2M2QwXHU0ZWE0XHU0ZjVjXHU0ZTFhXHU1MjE3XHU4ODY4IiwicGFyZW50X3Blcm1pc3Npb25fdXJsIjoiL3dlYi9ob21ld29ya3JlY29yZC9saXN0LyJ9fSwibWVudV9rZXkiOnsiMSI6eyJ0aXRsZSI6Ilx1NGZlMVx1NjA2Zlx1N2JhMVx1NzQwNiIsImljb24iOiI8aSBjbGFzcz1cImZhIGZhLWFkZHJlc3MtYm9va1wiIGFyaWEtaGlkZGVuPVwidHJ1ZVwiPjwvaT4iLCJjaGlsZHJlbiI6W3siaWQiOjEsInRpdGxlIjoiXHU4OWQyXHU4MjcyXHU1MjE3XHU4ODY4IiwidXJsIjoiL3JvbGVfbGlzdC8iLCJpY29uIjoiTm9uZSJ9LHsiaWQiOjE1LCJ0aXRsZSI6Ilx1NzUyOFx1NjIzN1x1NTIxN1x1ODg2OCIsInVybCI6Ii93ZWIvdXNlcmluZm8vbGlzdC8iLCJpY29uIjoiTm9uZSJ9LHsiaWQiOjIwLCJ0aXRsZSI6Ilx1OTBlOFx1OTVlOFx1NTIxN1x1ODg2OCIsInVybCI6Ii93ZWIvZGVwYXJ0bWVudC9saXN0LyIsImljb24iOiJOb25lIn0seyJpZCI6MzIsInRpdGxlIjoiXHU1YmEyXHU2MjM3XHU1MjE3XHU4ODY4IiwidXJsIjoiL3dlYi9jdXN0b21lci9saXN0LyIsImljb24iOiJOb25lIn1dfSwiMiI6eyJ0aXRsZSI6Ilx1Njc0M1x1OTY1MFx1N2JhMVx1NzQwNiIsImljb24iOiI8aSBjbGFzcz1cImZhIGZhLWhhbmRzaGFrZS1vXCIgYXJpYS1oaWRkZW49XCJ0cnVlXCI+PC9pPiIsImNoaWxkcmVuIjpbeyJpZCI6MTIsInRpdGxlIjoiXHU2Mjc5XHU5MWNmXHU2NzQzXHU5NjUwXHU1MjE3XHU4ODY4IiwidXJsIjoiL3Blcm1pc3Npb25faW1wb3J0X2xpc3QvIiwiaWNvbiI6Ik5vbmUifSx7ImlkIjoxNCwidGl0bGUiOiJcdTY3NDNcdTk2NTBcdTUyMDZcdTkxNGRcdTUyMTdcdTg4NjgiLCJ1cmwiOiIvZGlzdHJpYnV0ZV9wZXJtaXNzaW9uX2xpc3QvIiwiaWNvbiI6Ik5vbmUifV19LCIzIjp7InRpdGxlIjoiXHU4M2RjXHU1MzU1XHU3YmExXHU3NDA2IiwiaWNvbiI6IjxpIGNsYXNzPVwiZmEgZmEtdW5pdmVyc2l0eVwiIGFyaWEtaGlkZGVuPVwidHJ1ZVwiPjwvaT4iLCJjaGlsZHJlbiI6W3siaWQiOjUsInRpdGxlIjoiXHU4M2RjXHU1MzU1XHU1MjE3XHU4ODY4IiwidXJsIjoiL21lbnVfbGlzdC8iLCJpY29uIjoiTm9uZSJ9XX0sIjQiOnsidGl0bGUiOiJcdTViNjZcdTY4MjFcdTdiYTFcdTc0MDYiLCJpY29uIjoiPGkgY2xhc3M9XCJmYSBmYS10YWJsZXRcIiBhcmlhLWhpZGRlbj1cInRydWVcIj48L2k+IiwiY2hpbGRyZW4iOlt7ImlkIjoyNCwidGl0bGUiOiJcdThiZmVcdTdhMGJcdTUyMTdcdTg4NjgiLCJ1cmwiOiIvd2ViL2NvdXJzZS9saXN0LyIsImljb24iOiJOb25lIn0seyJpZCI6MjgsInRpdGxlIjoiXHU3M2VkXHU3ZWE3XHU1MjE3XHU4ODY4IiwidXJsIjoiL3dlYi9jbGFzc2xpc3QvbGlzdC8iLCJpY29uIjoiTm9uZSJ9XX0sIjUiOnsidGl0bGUiOiJcdTRmNWNcdTRlMWFcdTdiYTFcdTc0MDYiLCJpY29uIjoiPGkgY2xhc3M9XCJmYSBmYS1zdGFyXCIgYXJpYS1oaWRkZW49XCJ0cnVlXCI+PC9pPiIsImNoaWxkcmVuIjpbeyJpZCI6NTAsInRpdGxlIjoiXHU2M2QwXHU0ZWE0XHU0ZjVjXHU0ZTFhXHU1MjE3XHU4ODY4IiwidXJsIjoiL3dlYi9ob21ld29ya3JlY29yZC9saXN0LyIsImljb24iOiJOb25lIn1dfX19', '2020-01-06 15:22:26.244828');

-- ----------------------------
-- Table structure for `rbac_firstmenu`
-- ----------------------------
DROP TABLE IF EXISTS `rbac_firstmenu`;
CREATE TABLE `rbac_firstmenu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `icon_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `rbac_firstmenu_icon_id_8aa5d6b2_fk_rbac_icon_id` (`icon_id`),
  CONSTRAINT `rbac_firstmenu_icon_id_8aa5d6b2_fk_rbac_icon_id` FOREIGN KEY (`icon_id`) REFERENCES `rbac_icon` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rbac_firstmenu
-- ----------------------------
INSERT INTO `rbac_firstmenu` VALUES ('1', '信息管理', '1');
INSERT INTO `rbac_firstmenu` VALUES ('2', '权限管理', '2');
INSERT INTO `rbac_firstmenu` VALUES ('3', '菜单管理', '3');
INSERT INTO `rbac_firstmenu` VALUES ('4', '学校管理', '4');
INSERT INTO `rbac_firstmenu` VALUES ('5', '作业管理', '5');

-- ----------------------------
-- Table structure for `rbac_icon`
-- ----------------------------
DROP TABLE IF EXISTS `rbac_icon`;
CREATE TABLE `rbac_icon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rbac_icon
-- ----------------------------
INSERT INTO `rbac_icon` VALUES ('1', '<i class=\"fa fa-address-book\" aria-hidden=\"true\"></i>');
INSERT INTO `rbac_icon` VALUES ('2', '<i class=\"fa fa-handshake-o\" aria-hidden=\"true\"></i>');
INSERT INTO `rbac_icon` VALUES ('3', '<i class=\"fa fa-university\" aria-hidden=\"true\"></i>');
INSERT INTO `rbac_icon` VALUES ('4', '<i class=\"fa fa-tablet\" aria-hidden=\"true\"></i>');
INSERT INTO `rbac_icon` VALUES ('5', '<i class=\"fa fa-star\" aria-hidden=\"true\"></i>');
INSERT INTO `rbac_icon` VALUES ('6', '<i class=\"fa fa-umbrella\" aria-hidden=\"true\"></i>');
INSERT INTO `rbac_icon` VALUES ('7', '<i class=\"fa fa-wrench\" aria-hidden=\"true\"></i>');
INSERT INTO `rbac_icon` VALUES ('8', '<i class=\"fa fa-futbol-o\" aria-hidden=\"true\"></i>');

-- ----------------------------
-- Table structure for `rbac_permission`
-- ----------------------------
DROP TABLE IF EXISTS `rbac_permission`;
CREATE TABLE `rbac_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `url` varchar(64) NOT NULL,
  `name` varchar(32) NOT NULL,
  `firstmenu_id` int(11) DEFAULT NULL,
  `icon_id` int(11) DEFAULT NULL,
  `parent_permission_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `rbac_permission_firstmenu_id_71460ceb_fk_rbac_firstmenu_id` (`firstmenu_id`),
  KEY `rbac_permission_icon_id_286ad900_fk_rbac_icon_id` (`icon_id`),
  KEY `rbac_permission_parent_permission_id_eab0f039_fk_rbac_perm` (`parent_permission_id`),
  CONSTRAINT `rbac_permission_firstmenu_id_71460ceb_fk_rbac_firstmenu_id` FOREIGN KEY (`firstmenu_id`) REFERENCES `rbac_firstmenu` (`id`),
  CONSTRAINT `rbac_permission_icon_id_286ad900_fk_rbac_icon_id` FOREIGN KEY (`icon_id`) REFERENCES `rbac_icon` (`id`),
  CONSTRAINT `rbac_permission_parent_permission_id_eab0f039_fk_rbac_perm` FOREIGN KEY (`parent_permission_id`) REFERENCES `rbac_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rbac_permission
-- ----------------------------
INSERT INTO `rbac_permission` VALUES ('1', '角色列表', '/role_list/', 'rbac:role_list', '1', null, null);
INSERT INTO `rbac_permission` VALUES ('2', '添加角色', '/role_add/', 'rbac:role_add', null, null, '1');
INSERT INTO `rbac_permission` VALUES ('3', '修改角色', '/role_edit/(?P<role_pk>\\d+)/', 'rbac:role_edit', null, null, '1');
INSERT INTO `rbac_permission` VALUES ('4', '删除角色', '/role_del/(?P<role_pk>\\d+)/', 'rbac:role_del', null, null, '1');
INSERT INTO `rbac_permission` VALUES ('5', '菜单列表', '/menu_list/', 'rbac:menu_list', '3', null, null);
INSERT INTO `rbac_permission` VALUES ('6', '添加一级菜单', '/menu_add/', 'rbac:menu_add', null, null, '5');
INSERT INTO `rbac_permission` VALUES ('7', '修改一级菜单', '/menu_edit/(?P<menu_pk>\\d+)/', 'rbac:menu_edit', null, null, '5');
INSERT INTO `rbac_permission` VALUES ('8', '删除一级菜单', '/menu_del/(?P<menu_pk>\\d+)/', 'rbac:menu_del', null, null, '5');
INSERT INTO `rbac_permission` VALUES ('9', '添加二级菜单', '/second_menu_add/', 'rbac:second_menu_add', null, null, '5');
INSERT INTO `rbac_permission` VALUES ('10', '修改二级菜单', '/second_menu_edit/(?P<second_menu_pk>\\d+)/', 'rbac:second_menu_edit', null, null, '5');
INSERT INTO `rbac_permission` VALUES ('11', '删除二级菜单', '/second_menu_del/(?P<second_menu_pk>\\d+)/', 'rbac:second_menu_del', null, null, '5');
INSERT INTO `rbac_permission` VALUES ('12', '批量权限列表', '/permission_import_list/', 'rbac:permission_import_list', '2', null, null);
INSERT INTO `rbac_permission` VALUES ('13', '批量删除权限', '/permission_import_del/(?P<permission_pk>\\d+)/', 'rbac:permission_import_del', null, null, '12');
INSERT INTO `rbac_permission` VALUES ('14', '权限分配列表', '/distribute_permission_list/', 'rbac:distribute_permission_list', '2', null, null);
INSERT INTO `rbac_permission` VALUES ('15', '用户列表', '/web/userinfo/list/', 'web_userinfo_list', '1', null, null);
INSERT INTO `rbac_permission` VALUES ('16', '添加用户', '/web/userinfo/add/', 'web_userinfo_add', null, null, '15');
INSERT INTO `rbac_permission` VALUES ('17', '修改用户', '/web/userinfo/change/(?P<pk>\\d+)/', 'web_userinfo_change', null, null, '15');
INSERT INTO `rbac_permission` VALUES ('18', '删除用户', '/web/userinfo/del/(?P<pk>\\d+)/', 'web_userinfo_del', null, null, '15');
INSERT INTO `rbac_permission` VALUES ('19', '重置密码', '/web/userinfo/reset_pwd/(?P<pk>\\d+)/', 'web_userinfo_reset_pwd', null, null, '15');
INSERT INTO `rbac_permission` VALUES ('20', '部门列表', '/web/department/list/', 'web_department_list', '1', null, null);
INSERT INTO `rbac_permission` VALUES ('21', '添加部门', '/web/department/add/', 'web_department_add', null, null, '20');
INSERT INTO `rbac_permission` VALUES ('22', '修改部门', '/web/department/change/(?P<pk>\\d+)/', 'web_department_change', null, null, '20');
INSERT INTO `rbac_permission` VALUES ('23', '删除部门', '/web/department/del/(?P<pk>\\d+)/', 'web_department_del', null, null, '20');
INSERT INTO `rbac_permission` VALUES ('24', '课程列表', '/web/course/list/', 'web_course_list', '4', null, null);
INSERT INTO `rbac_permission` VALUES ('25', '添加课程', '/web/course/add/', 'web_course_add', null, null, '24');
INSERT INTO `rbac_permission` VALUES ('26', '修改课程', '/web/course/change/(?P<pk>\\d+)/', 'web_course_change', null, null, '24');
INSERT INTO `rbac_permission` VALUES ('27', '删除课程', '/web/course/del/(?P<pk>\\d+)/', 'web_course_del', null, null, '24');
INSERT INTO `rbac_permission` VALUES ('28', '班级列表', '/web/classlist/list/', 'web_classlist_list', '4', null, null);
INSERT INTO `rbac_permission` VALUES ('29', '添加班级', '/web/classlist/add/', 'web_classlist_add', null, null, '28');
INSERT INTO `rbac_permission` VALUES ('30', '修改班级', '/web/classlist/change/(?P<pk>\\d+)/', 'web_classlist_change', null, null, '28');
INSERT INTO `rbac_permission` VALUES ('31', '删除班级', '/web/classlist/del/(?P<pk>\\d+)/', 'web_classlist_del', null, null, '28');
INSERT INTO `rbac_permission` VALUES ('32', '客户列表', '/web/customer/list/', 'web_customer_list', '1', null, null);
INSERT INTO `rbac_permission` VALUES ('33', '添加客户', '/web/customer/add/', 'web_customer_add', null, null, '32');
INSERT INTO `rbac_permission` VALUES ('34', '修改客户', '/web/customer/change/(?P<pk>\\d+)/', 'web_customer_change', null, null, '32');
INSERT INTO `rbac_permission` VALUES ('35', '删除客户', '/web/customer/del/(?P<pk>\\d+)/', 'web_customer_del', null, null, '32');
INSERT INTO `rbac_permission` VALUES ('36', '客户跟进记录列表', '/web/consultrecord/list/(?P<customer_id>\\d+)/', 'web_consultrecord_list', null, null, '32');
INSERT INTO `rbac_permission` VALUES ('37', '添加客户跟进记录', '/web/consultrecord/add/(?P<customer_id>\\d+)/', 'web_consultrecord_add', null, null, '32');
INSERT INTO `rbac_permission` VALUES ('38', '修改客户跟进记录', '/web/consultrecord/change/(?P<pk>\\d+)/(?P<customer_id>\\d+)/', 'web_consultrecord_change', null, null, '32');
INSERT INTO `rbac_permission` VALUES ('39', '删除客户跟进记录', '/web/consultrecord/del/(?P<pk>\\d+)/(?P<customer_id>\\d+)/', 'web_consultrecord_del', null, null, '32');
INSERT INTO `rbac_permission` VALUES ('40', '上课记录列表', '/web/courserecord/list/(?P<class_id>\\d+)/', 'web_courserecord_list', null, null, '28');
INSERT INTO `rbac_permission` VALUES ('41', '添加上课记录', '/web/courserecord/add/(?P<class_id>\\d+)/', 'web_courserecord_add', null, null, '28');
INSERT INTO `rbac_permission` VALUES ('42', '修改上课记录', '/web/courserecord/change/(?P<pk>\\d+)/(?P<class_id>\\d+)/', 'web_courserecord_change', null, null, '28');
INSERT INTO `rbac_permission` VALUES ('43', '删除上课记录', '/web/courserecord/del/(?P<pk>\\d+)/(?P<class_id>\\d+)/', 'web_courserecord_del', null, null, '28');
INSERT INTO `rbac_permission` VALUES ('44', '考勤记录', '/web/courserecord/student_record/(?P<pk>\\d+)/(?P<class_id>\\d+)/', 'web_courserecord_student_record', null, null, '28');
INSERT INTO `rbac_permission` VALUES ('45', '作业列表', '/web/homework/list/(?P<class_id>\\d+)/', 'web_homework_list', null, null, '28');
INSERT INTO `rbac_permission` VALUES ('46', '添加作业', '/web/homework/add/(?P<class_id>\\d+)/', 'web_homework_add', null, null, '28');
INSERT INTO `rbac_permission` VALUES ('47', '修改作业', '/web/homework/change/(?P<pk>\\d+)/(?P<class_id>\\d+)/', 'web_homework_change', null, null, '28');
INSERT INTO `rbac_permission` VALUES ('48', '删除作业', '/web/homework/del/(?P<pk>\\d+)/(?P<class_id>\\d+)/', 'web_homework_del', null, null, '28');
INSERT INTO `rbac_permission` VALUES ('49', '学生作业记录', '/web/homework/homework_record/(?P<pk>\\d+)/(?P<class_id>\\d+)/', 'web_homework_homework_record', null, null, '28');
INSERT INTO `rbac_permission` VALUES ('50', '提交作业列表', '/web/homeworkrecord/list/', 'web_homeworkrecord_list', '5', null, null);
INSERT INTO `rbac_permission` VALUES ('51', '上传作业', '/web/homeworkrecord/change/(?P<pk>\\d+)/', 'web_homeworkrecord_change', null, null, '50');

-- ----------------------------
-- Table structure for `rbac_role`
-- ----------------------------
DROP TABLE IF EXISTS `rbac_role`;
CREATE TABLE `rbac_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rbac_role
-- ----------------------------
INSERT INTO `rbac_role` VALUES ('1', '销售');
INSERT INTO `rbac_role` VALUES ('2', '讲师');
INSERT INTO `rbac_role` VALUES ('3', '学生');
INSERT INTO `rbac_role` VALUES ('4', '超级管理员');

-- ----------------------------
-- Table structure for `rbac_role_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `rbac_role_permissions`;
CREATE TABLE `rbac_role_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rbac_role_permissions_role_id_permission_id_d01303da_uniq` (`role_id`,`permission_id`),
  KEY `rbac_role_permission_permission_id_f5e1e866_fk_rbac_perm` (`permission_id`),
  CONSTRAINT `rbac_role_permission_permission_id_f5e1e866_fk_rbac_perm` FOREIGN KEY (`permission_id`) REFERENCES `rbac_permission` (`id`),
  CONSTRAINT `rbac_role_permissions_role_id_d10416cb_fk_rbac_role_id` FOREIGN KEY (`role_id`) REFERENCES `rbac_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=485 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rbac_role_permissions
-- ----------------------------
INSERT INTO `rbac_role_permissions` VALUES ('6', '1', '32');
INSERT INTO `rbac_role_permissions` VALUES ('7', '1', '33');
INSERT INTO `rbac_role_permissions` VALUES ('8', '1', '36');
INSERT INTO `rbac_role_permissions` VALUES ('4', '1', '37');
INSERT INTO `rbac_role_permissions` VALUES ('5', '1', '38');
INSERT INTO `rbac_role_permissions` VALUES ('3', '1', '39');
INSERT INTO `rbac_role_permissions` VALUES ('267', '2', '28');
INSERT INTO `rbac_role_permissions` VALUES ('262', '2', '40');
INSERT INTO `rbac_role_permissions` VALUES ('268', '2', '41');
INSERT INTO `rbac_role_permissions` VALUES ('265', '2', '42');
INSERT INTO `rbac_role_permissions` VALUES ('260', '2', '43');
INSERT INTO `rbac_role_permissions` VALUES ('263', '2', '44');
INSERT INTO `rbac_role_permissions` VALUES ('261', '2', '45');
INSERT INTO `rbac_role_permissions` VALUES ('269', '2', '46');
INSERT INTO `rbac_role_permissions` VALUES ('264', '2', '47');
INSERT INTO `rbac_role_permissions` VALUES ('259', '2', '48');
INSERT INTO `rbac_role_permissions` VALUES ('266', '2', '49');
INSERT INTO `rbac_role_permissions` VALUES ('385', '3', '50');
INSERT INTO `rbac_role_permissions` VALUES ('386', '3', '51');
INSERT INTO `rbac_role_permissions` VALUES ('445', '4', '1');
INSERT INTO `rbac_role_permissions` VALUES ('456', '4', '2');
INSERT INTO `rbac_role_permissions` VALUES ('446', '4', '3');
INSERT INTO `rbac_role_permissions` VALUES ('463', '4', '4');
INSERT INTO `rbac_role_permissions` VALUES ('477', '4', '5');
INSERT INTO `rbac_role_permissions` VALUES ('482', '4', '6');
INSERT INTO `rbac_role_permissions` VALUES ('470', '4', '7');
INSERT INTO `rbac_role_permissions` VALUES ('484', '4', '8');
INSERT INTO `rbac_role_permissions` VALUES ('443', '4', '9');
INSERT INTO `rbac_role_permissions` VALUES ('478', '4', '10');
INSERT INTO `rbac_role_permissions` VALUES ('469', '4', '11');
INSERT INTO `rbac_role_permissions` VALUES ('473', '4', '12');
INSERT INTO `rbac_role_permissions` VALUES ('459', '4', '13');
INSERT INTO `rbac_role_permissions` VALUES ('480', '4', '14');
INSERT INTO `rbac_role_permissions` VALUES ('466', '4', '15');
INSERT INTO `rbac_role_permissions` VALUES ('440', '4', '16');
INSERT INTO `rbac_role_permissions` VALUES ('452', '4', '17');
INSERT INTO `rbac_role_permissions` VALUES ('438', '4', '18');
INSERT INTO `rbac_role_permissions` VALUES ('437', '4', '19');
INSERT INTO `rbac_role_permissions` VALUES ('479', '4', '20');
INSERT INTO `rbac_role_permissions` VALUES ('476', '4', '21');
INSERT INTO `rbac_role_permissions` VALUES ('449', '4', '22');
INSERT INTO `rbac_role_permissions` VALUES ('462', '4', '23');
INSERT INTO `rbac_role_permissions` VALUES ('468', '4', '24');
INSERT INTO `rbac_role_permissions` VALUES ('450', '4', '28');
INSERT INTO `rbac_role_permissions` VALUES ('458', '4', '29');
INSERT INTO `rbac_role_permissions` VALUES ('460', '4', '30');
INSERT INTO `rbac_role_permissions` VALUES ('481', '4', '31');
INSERT INTO `rbac_role_permissions` VALUES ('454', '4', '32');
INSERT INTO `rbac_role_permissions` VALUES ('447', '4', '33');
INSERT INTO `rbac_role_permissions` VALUES ('441', '4', '34');
INSERT INTO `rbac_role_permissions` VALUES ('474', '4', '35');
INSERT INTO `rbac_role_permissions` VALUES ('467', '4', '36');
INSERT INTO `rbac_role_permissions` VALUES ('461', '4', '37');
INSERT INTO `rbac_role_permissions` VALUES ('471', '4', '38');
INSERT INTO `rbac_role_permissions` VALUES ('475', '4', '39');
INSERT INTO `rbac_role_permissions` VALUES ('455', '4', '40');
INSERT INTO `rbac_role_permissions` VALUES ('444', '4', '41');
INSERT INTO `rbac_role_permissions` VALUES ('472', '4', '42');
INSERT INTO `rbac_role_permissions` VALUES ('451', '4', '43');
INSERT INTO `rbac_role_permissions` VALUES ('439', '4', '44');
INSERT INTO `rbac_role_permissions` VALUES ('457', '4', '45');
INSERT INTO `rbac_role_permissions` VALUES ('465', '4', '46');
INSERT INTO `rbac_role_permissions` VALUES ('442', '4', '47');
INSERT INTO `rbac_role_permissions` VALUES ('464', '4', '48');
INSERT INTO `rbac_role_permissions` VALUES ('483', '4', '49');
INSERT INTO `rbac_role_permissions` VALUES ('453', '4', '50');
INSERT INTO `rbac_role_permissions` VALUES ('448', '4', '51');

-- ----------------------------
-- Table structure for `web_classlist`
-- ----------------------------
DROP TABLE IF EXISTS `web_classlist`;
CREATE TABLE `web_classlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `semester` int(10) unsigned NOT NULL,
  `course_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `web_classlist_course_id_0d0bb3df_fk_web_course_id` (`course_id`),
  CONSTRAINT `web_classlist_course_id_0d0bb3df_fk_web_course_id` FOREIGN KEY (`course_id`) REFERENCES `web_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_classlist
-- ----------------------------
INSERT INTO `web_classlist` VALUES ('1', '1', '3');

-- ----------------------------
-- Table structure for `web_classlist_tech_teachers`
-- ----------------------------
DROP TABLE IF EXISTS `web_classlist_tech_teachers`;
CREATE TABLE `web_classlist_tech_teachers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `classlist_id` int(11) NOT NULL,
  `userinfo_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `web_classlist_tech_teach_classlist_id_userinfo_id_b70ec689_uniq` (`classlist_id`,`userinfo_id`),
  KEY `web_classlist_tech_t_userinfo_id_7d6dfc5e_fk_web_useri` (`userinfo_id`),
  CONSTRAINT `web_classlist_tech_t_classlist_id_c24729e2_fk_web_class` FOREIGN KEY (`classlist_id`) REFERENCES `web_classlist` (`id`),
  CONSTRAINT `web_classlist_tech_t_userinfo_id_7d6dfc5e_fk_web_useri` FOREIGN KEY (`userinfo_id`) REFERENCES `web_userinfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_classlist_tech_teachers
-- ----------------------------
INSERT INTO `web_classlist_tech_teachers` VALUES ('1', '1', '3');
INSERT INTO `web_classlist_tech_teachers` VALUES ('2', '1', '4');

-- ----------------------------
-- Table structure for `web_consultrecord`
-- ----------------------------
DROP TABLE IF EXISTS `web_consultrecord`;
CREATE TABLE `web_consultrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `note` longtext NOT NULL,
  `date` date NOT NULL,
  `consultant_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `web_consultrecord_consultant_id_914c38fa_fk_web_userinfo_id` (`consultant_id`),
  KEY `web_consultrecord_customer_id_befb7f7f_fk_web_customer_id` (`customer_id`),
  CONSTRAINT `web_consultrecord_consultant_id_914c38fa_fk_web_userinfo_id` FOREIGN KEY (`consultant_id`) REFERENCES `web_userinfo` (`id`),
  CONSTRAINT `web_consultrecord_customer_id_befb7f7f_fk_web_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `web_customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_consultrecord
-- ----------------------------
INSERT INTO `web_consultrecord` VALUES ('1', '第一次跟进', '2019-12-21', '2', '2');
INSERT INTO `web_consultrecord` VALUES ('2', '1', '2019-12-23', '1', '4');
INSERT INTO `web_consultrecord` VALUES ('3', '1', '2019-12-23', '2', '7');
INSERT INTO `web_consultrecord` VALUES ('5', '1', '2019-12-23', '2', '9');

-- ----------------------------
-- Table structure for `web_course`
-- ----------------------------
DROP TABLE IF EXISTS `web_course`;
CREATE TABLE `web_course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_course
-- ----------------------------
INSERT INTO `web_course` VALUES ('1', 'Linux基础');
INSERT INTO `web_course` VALUES ('2', 'Linux架构师');
INSERT INTO `web_course` VALUES ('3', 'Python自动化');

-- ----------------------------
-- Table structure for `web_courserecord`
-- ----------------------------
DROP TABLE IF EXISTS `web_courserecord`;
CREATE TABLE `web_courserecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `day_num` int(11) NOT NULL,
  `date` date NOT NULL,
  `class_object_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `web_courserecord_class_object_id_e107b311_fk_web_classlist_id` (`class_object_id`),
  KEY `web_courserecord_teacher_id_3d847927_fk_web_userinfo_id` (`teacher_id`),
  CONSTRAINT `web_courserecord_class_object_id_e107b311_fk_web_classlist_id` FOREIGN KEY (`class_object_id`) REFERENCES `web_classlist` (`id`),
  CONSTRAINT `web_courserecord_teacher_id_3d847927_fk_web_userinfo_id` FOREIGN KEY (`teacher_id`) REFERENCES `web_userinfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_courserecord
-- ----------------------------
INSERT INTO `web_courserecord` VALUES ('1', '1', '2019-12-21', '1', '3');

-- ----------------------------
-- Table structure for `web_customer`
-- ----------------------------
DROP TABLE IF EXISTS `web_customer`;
CREATE TABLE `web_customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `qq` varchar(64) NOT NULL,
  `status` int(11) NOT NULL,
  `gender` smallint(6) NOT NULL,
  `consultant_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `web_customer_consultant_id_e3c377b3_fk_web_userinfo_id` (`consultant_id`),
  CONSTRAINT `web_customer_consultant_id_e3c377b3_fk_web_userinfo_id` FOREIGN KEY (`consultant_id`) REFERENCES `web_userinfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_customer
-- ----------------------------
INSERT INTO `web_customer` VALUES ('1', '小明', '1111111111111111', '2', '1', '2');
INSERT INTO `web_customer` VALUES ('2', '小红', '222222222222222', '1', '2', '2');
INSERT INTO `web_customer` VALUES ('3', '小亮', '3333333333', '1', '1', '2');
INSERT INTO `web_customer` VALUES ('4', '打明', '55555555555555555555', '2', '1', '1');
INSERT INTO `web_customer` VALUES ('6', '小白', '1111111111111111', '2', '1', '2');
INSERT INTO `web_customer` VALUES ('7', '小慧', '1111111111111111', '2', '2', '2');
INSERT INTO `web_customer` VALUES ('8', '小花', '1111111111111111', '2', '2', '2');
INSERT INTO `web_customer` VALUES ('9', '小华', '1111111111111111', '2', '1', '2');
INSERT INTO `web_customer` VALUES ('10', '小可', '1111111111111111', '2', '2', '2');

-- ----------------------------
-- Table structure for `web_department`
-- ----------------------------
DROP TABLE IF EXISTS `web_department`;
CREATE TABLE `web_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_department
-- ----------------------------
INSERT INTO `web_department` VALUES ('1', '销售部');
INSERT INTO `web_department` VALUES ('2', '教学部');

-- ----------------------------
-- Table structure for `web_homework`
-- ----------------------------
DROP TABLE IF EXISTS `web_homework`;
CREATE TABLE `web_homework` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `content` varchar(500) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `class_object_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `web_homework_class_object_id_95ccf7b4_fk_web_classlist_id` (`class_object_id`),
  KEY `web_homework_teacher_id_1cfd9897_fk_web_userinfo_id` (`teacher_id`),
  CONSTRAINT `web_homework_class_object_id_95ccf7b4_fk_web_classlist_id` FOREIGN KEY (`class_object_id`) REFERENCES `web_classlist` (`id`),
  CONSTRAINT `web_homework_teacher_id_1cfd9897_fk_web_userinfo_id` FOREIGN KEY (`teacher_id`) REFERENCES `web_userinfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_homework
-- ----------------------------
INSERT INTO `web_homework` VALUES ('1', '作业1', '作业1内容,,,', '2019-12-21 23:13:54.169959', '1', '3');
INSERT INTO `web_homework` VALUES ('3', '1', '2', '2019-12-23 15:07:06.893442', '1', '3');

-- ----------------------------
-- Table structure for `web_homeworkrecord`
-- ----------------------------
DROP TABLE IF EXISTS `web_homeworkrecord`;
CREATE TABLE `web_homeworkrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `homework_status` int(11) NOT NULL,
  `mark` int(10) unsigned DEFAULT NULL,
  `homework_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `file` varchar(100) DEFAULT NULL,
  `file_count` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `web_homeworkrecord_homework_id_82dd20ef_fk_web_homework_id` (`homework_id`),
  KEY `web_homeworkrecord_student_id_1884c2f5` (`student_id`),
  CONSTRAINT `web_homeworkrecord_homework_id_82dd20ef_fk_web_homework_id` FOREIGN KEY (`homework_id`) REFERENCES `web_homework` (`id`),
  CONSTRAINT `web_homeworkrecord_student_id_1884c2f5_fk_web_student_id` FOREIGN KEY (`student_id`) REFERENCES `web_student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_homeworkrecord
-- ----------------------------
INSERT INTO `web_homeworkrecord` VALUES ('7', '1', null, '1', '1', null, '0');
INSERT INTO `web_homeworkrecord` VALUES ('8', '2', null, '1', '2', 'homework/小亮的作业', '2');
INSERT INTO `web_homeworkrecord` VALUES ('9', '2', '99', '3', '1', 'homework/小红的作业', '1');
INSERT INTO `web_homeworkrecord` VALUES ('10', '1', null, '3', '2', '', '0');

-- ----------------------------
-- Table structure for `web_student`
-- ----------------------------
DROP TABLE IF EXISTS `web_student`;
CREATE TABLE `web_student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_status` int(11) NOT NULL,
  `userinfo_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userinfo_id` (`userinfo_id`),
  CONSTRAINT `web_student_userinfo_id_1ed6524c_fk_web_userinfo_id` FOREIGN KEY (`userinfo_id`) REFERENCES `web_userinfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_student
-- ----------------------------
INSERT INTO `web_student` VALUES ('1', '2', '5');
INSERT INTO `web_student` VALUES ('2', '2', '6');

-- ----------------------------
-- Table structure for `web_student_class_list`
-- ----------------------------
DROP TABLE IF EXISTS `web_student_class_list`;
CREATE TABLE `web_student_class_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `classlist_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `web_student_class_list_student_id_classlist_id_7937e885_uniq` (`student_id`,`classlist_id`),
  KEY `web_student_class_list_classlist_id_c9c47794_fk_web_classlist_id` (`classlist_id`),
  CONSTRAINT `web_student_class_list_classlist_id_c9c47794_fk_web_classlist_id` FOREIGN KEY (`classlist_id`) REFERENCES `web_classlist` (`id`),
  CONSTRAINT `web_student_class_list_student_id_76222b07_fk_web_student_id` FOREIGN KEY (`student_id`) REFERENCES `web_student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_student_class_list
-- ----------------------------
INSERT INTO `web_student_class_list` VALUES ('1', '1', '1');
INSERT INTO `web_student_class_list` VALUES ('2', '2', '1');

-- ----------------------------
-- Table structure for `web_studyrecord`
-- ----------------------------
DROP TABLE IF EXISTS `web_studyrecord`;
CREATE TABLE `web_studyrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `record` varchar(64) NOT NULL,
  `course_record_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `web_studyrecord_course_record_id_a3162b0f_fk_web_courserecord_id` (`course_record_id`),
  KEY `web_studyrecord_student_id_a81eb429_fk_web_student_id` (`student_id`),
  CONSTRAINT `web_studyrecord_course_record_id_a3162b0f_fk_web_courserecord_id` FOREIGN KEY (`course_record_id`) REFERENCES `web_courserecord` (`id`),
  CONSTRAINT `web_studyrecord_student_id_a81eb429_fk_web_student_id` FOREIGN KEY (`student_id`) REFERENCES `web_student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_studyrecord
-- ----------------------------
INSERT INTO `web_studyrecord` VALUES ('1', 'checked', '1', '1');
INSERT INTO `web_studyrecord` VALUES ('2', 'checked', '1', '2');

-- ----------------------------
-- Table structure for `web_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `web_userinfo`;
CREATE TABLE `web_userinfo` (
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `name` varchar(16) NOT NULL,
  `phone` varchar(32) NOT NULL,
  `gender` int(11) NOT NULL,
  `depart_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `web_userinfo_depart_id_4df860bd_fk_web_department_id` (`depart_id`),
  CONSTRAINT `web_userinfo_depart_id_4df860bd_fk_web_department_id` FOREIGN KEY (`depart_id`) REFERENCES `web_department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_userinfo
-- ----------------------------
INSERT INTO `web_userinfo` VALUES ('pbkdf2_sha256$100000$mW4ufMAX42tk$DQfvw54OGzmq+ahcWsksSUodKJGcu6ayGKqyxrgenZQ=', '2019-12-23 15:22:25.710080', '1', '', '', '', '1', '1', '2019-12-21 11:47:52.360141', '1', 'alex', '金角', '', '1', null);
INSERT INTO `web_userinfo` VALUES ('pbkdf2_sha256$100000$cjkTscauqxZK$Y/xgC0WuGRLkU9U9y5Gw2/jl8tgpzRX7U4lDpDTSoVg=', '2019-12-23 14:08:04.965058', '0', '', '', '', '0', '1', '2019-12-21 12:00:53.771545', '2', 'a', '张三', '', '1', '1');
INSERT INTO `web_userinfo` VALUES ('pbkdf2_sha256$100000$96EJaluv6Xfk$kbRhbcByaxr85BDenqycTG50caZWYrTxND8p+fQny90=', '2019-12-23 15:15:41.585017', '0', '', '', '', '0', '1', '2019-12-21 12:25:03.204455', '3', 'b', '李四', '', '1', '2');
INSERT INTO `web_userinfo` VALUES ('pbkdf2_sha256$100000$ZKYG724Lon9G$PfNASDG2qOYQCgXhyWMbjm+yT/S/CKJiK/rpoxrZ5wc=', '2019-12-23 12:40:57.535275', '0', '', '', '', '0', '1', '2019-12-21 12:25:38.382835', '4', 'c', '王五', '', '1', '2');
INSERT INTO `web_userinfo` VALUES ('pbkdf2_sha256$100000$M3LN1hoR4H4w$fTS2Ql13XGSsFEA+2VUXH5oalcypfAjISHlrp7qIiV4=', '2019-12-23 15:19:53.407998', '0', '', '', '', '0', '1', '2019-12-22 13:00:23.943334', '5', 'd', '小红', '', '1', null);
INSERT INTO `web_userinfo` VALUES ('pbkdf2_sha256$100000$mCSelw3k8zGM$NkcoMF9kI4bdPNp27inHObMUP4c+E2T3T4hVk1C9MkI=', null, '0', '', '', '', '0', '1', '2019-12-22 13:01:02.719337', '6', 'e', '小亮', '', '1', null);

-- ----------------------------
-- Table structure for `web_userinfo_groups`
-- ----------------------------
DROP TABLE IF EXISTS `web_userinfo_groups`;
CREATE TABLE `web_userinfo_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userinfo_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `web_userinfo_groups_userinfo_id_group_id_5337b99a_uniq` (`userinfo_id`,`group_id`),
  KEY `web_userinfo_groups_group_id_f0e66acc_fk_auth_group_id` (`group_id`),
  CONSTRAINT `web_userinfo_groups_group_id_f0e66acc_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `web_userinfo_groups_userinfo_id_dfe01481_fk_web_userinfo_id` FOREIGN KEY (`userinfo_id`) REFERENCES `web_userinfo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_userinfo_groups
-- ----------------------------

-- ----------------------------
-- Table structure for `web_userinfo_roles`
-- ----------------------------
DROP TABLE IF EXISTS `web_userinfo_roles`;
CREATE TABLE `web_userinfo_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userinfo_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `web_userinfo_roles_userinfo_id_role_id_e0435f62_uniq` (`userinfo_id`,`role_id`),
  KEY `web_userinfo_roles_role_id_c9cdbf1d_fk_rbac_role_id` (`role_id`),
  CONSTRAINT `web_userinfo_roles_role_id_c9cdbf1d_fk_rbac_role_id` FOREIGN KEY (`role_id`) REFERENCES `rbac_role` (`id`),
  CONSTRAINT `web_userinfo_roles_userinfo_id_090d779f_fk_web_userinfo_id` FOREIGN KEY (`userinfo_id`) REFERENCES `web_userinfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_userinfo_roles
-- ----------------------------
INSERT INTO `web_userinfo_roles` VALUES ('1', '1', '4');
INSERT INTO `web_userinfo_roles` VALUES ('4', '2', '1');
INSERT INTO `web_userinfo_roles` VALUES ('5', '3', '2');
INSERT INTO `web_userinfo_roles` VALUES ('3', '4', '2');
INSERT INTO `web_userinfo_roles` VALUES ('6', '5', '3');
INSERT INTO `web_userinfo_roles` VALUES ('7', '6', '3');

-- ----------------------------
-- Table structure for `web_userinfo_user_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `web_userinfo_user_permissions`;
CREATE TABLE `web_userinfo_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userinfo_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `web_userinfo_user_permis_userinfo_id_permission_i_5fcd24d5_uniq` (`userinfo_id`,`permission_id`),
  KEY `web_userinfo_user_pe_permission_id_1a37ea1f_fk_auth_perm` (`permission_id`),
  CONSTRAINT `web_userinfo_user_pe_permission_id_1a37ea1f_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `web_userinfo_user_pe_userinfo_id_1565944c_fk_web_useri` FOREIGN KEY (`userinfo_id`) REFERENCES `web_userinfo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_userinfo_user_permissions
-- ----------------------------
