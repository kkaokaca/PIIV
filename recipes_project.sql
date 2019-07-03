/*
 Navicat MySQL Data Transfer

 Source Server         : xamppProjekat
 Source Server Type    : MySQL
 Source Server Version : 100138
 Source Host           : localhost:3306
 Source Schema         : recipes_project

 Target Server Type    : MySQL
 Target Server Version : 100138
 File Encoding         : 65001

 Date: 04/07/2019 00:38:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `admin_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `registered_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `username` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `password_hash` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `forename` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `surname` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`admin_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, '2019-07-03 02:57:46', 'admin', '$2y$10$8Z914AJNMmfY58oMuHZ2SuEWUGQLJuPZGZz.EzZQMBJY4xfjpnP8K', 0, 'Katarina', 'Jaksic', 'kkaokaca@hotmail.rs');
INSERT INTO `admin` VALUES (2, '2019-07-03 02:57:21', 'admin1', '$2y$10$r95JohdcIjah6vhnY7tmY.1WdF7Qg7KyLPqwOn61oVUnVOnWY6Dgm', 0, '', '', '');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `category_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `name` varchar(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `admin_id` int(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`) USING BTREE,
  INDEX `fk_category_admin_id`(`admin_id`) USING BTREE,
  CONSTRAINT `fk_category_admin_id` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '2019-07-03 02:52:29', 'Glavna jela', 1);
INSERT INTO `category` VALUES (2, '2019-07-03 02:53:26', 'Corbe', 1);
INSERT INTO `category` VALUES (3, '2019-07-03 02:58:11', 'Supe', 2);
INSERT INTO `category` VALUES (4, '2019-07-03 02:58:41', 'Grickalice', 2);
INSERT INTO `category` VALUES (5, '2019-07-03 02:59:07', 'Kolaci', 2);
INSERT INTO `category` VALUES (6, '2019-07-03 02:53:01', 'Predjela', 1);
INSERT INTO `category` VALUES (7, '2019-07-03 02:58:55', 'Torte', 1);
INSERT INTO `category` VALUES (8, '2019-07-03 13:05:16', 'Salate', 1);

-- ----------------------------
-- Table structure for category_recipe
-- ----------------------------
DROP TABLE IF EXISTS `category_recipe`;
CREATE TABLE `category_recipe`  (
  `recipe_category_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` int(11) UNSIGNED NOT NULL,
  `recipe_id` int(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`recipe_category_id`) USING BTREE,
  INDEX `fk_category_recipe_category_id`(`category_id`) USING BTREE,
  INDEX `fk_category_recipe_recipe_id`(`recipe_id`) USING BTREE,
  CONSTRAINT `fk_category_recipe_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_category_recipe_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of category_recipe
-- ----------------------------
INSERT INTO `category_recipe` VALUES (1, 1, 1);
INSERT INTO `category_recipe` VALUES (2, 1, 2);

-- ----------------------------
-- Table structure for ingredient
-- ----------------------------
DROP TABLE IF EXISTS `ingredient`;
CREATE TABLE `ingredient`  (
  `ingredient_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `unit_measure` enum('gram','decilitar','komad','litar','kilogram','mililitar') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ingredient_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ingredient
-- ----------------------------
INSERT INTO `ingredient` VALUES (1, '2019-07-02 12:31:34', 'voda', 'litar');
INSERT INTO `ingredient` VALUES (2, '2019-07-02 14:50:08', 'jaja', 'komad');
INSERT INTO `ingredient` VALUES (3, '2019-07-03 18:40:51', 'mleko', 'litar');
INSERT INTO `ingredient` VALUES (4, '2019-07-03 18:40:44', 'spagete', 'gram');
INSERT INTO `ingredient` VALUES (5, '2019-07-03 18:40:48', 'brasno', 'gram');
INSERT INTO `ingredient` VALUES (6, '2019-07-03 18:40:57', 'so', 'gram');
INSERT INTO `ingredient` VALUES (7, '2019-07-03 18:41:01', 'biber', 'gram');
INSERT INTO `ingredient` VALUES (8, '2019-07-03 18:41:06', 'mleveno meso', 'gram');
INSERT INTO `ingredient` VALUES (9, '2019-07-03 18:41:10', 'piletina', 'gram');
INSERT INTO `ingredient` VALUES (10, '2019-07-03 18:41:19', 'kulen', 'gram');

-- ----------------------------
-- Table structure for recipe
-- ----------------------------
DROP TABLE IF EXISTS `recipe`;
CREATE TABLE `recipe`  (
  `recipe_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `image_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `admin_id` int(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`recipe_id`) USING BTREE,
  INDEX `fk_recipe_admin_id`(`admin_id`) USING BTREE,
  CONSTRAINT `fk_recipe_admin_id` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of recipe
-- ----------------------------
INSERT INTO `recipe` VALUES (1, '2019-07-03 18:51:42', 'Pica sa kulenom', '1.jpg', 'Ovo je najbolji recept za pripremu pice sa kulenom', 1);
INSERT INTO `recipe` VALUES (2, '2019-07-03 18:51:20', 'Bolonjeze', '2.jpg', 'Ovo je najbolji recept za pripremu bolonjeza', 1);

-- ----------------------------
-- Table structure for recipe_ingredient
-- ----------------------------
DROP TABLE IF EXISTS `recipe_ingredient`;
CREATE TABLE `recipe_ingredient`  (
  `recipe_ingredient_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `amount` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `recipe_id` int(10) UNSIGNED NOT NULL,
  `ingredient_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`recipe_ingredient_id`) USING BTREE,
  INDEX `fk_recipe_ingredient_ingredient_id`(`ingredient_id`) USING BTREE,
  INDEX `fk_recipe_ingredient_recipe_id`(`recipe_id`) USING BTREE,
  CONSTRAINT `fk_recipe_ingredient_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`ingredient_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_recipe_ingredient_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of recipe_ingredient
-- ----------------------------
INSERT INTO `recipe_ingredient` VALUES (1, '2', 1, 1);
INSERT INTO `recipe_ingredient` VALUES (2, '200', 2, 4);
INSERT INTO `recipe_ingredient` VALUES (3, '100', 2, 6);
INSERT INTO `recipe_ingredient` VALUES (4, '20', 2, 7);
INSERT INTO `recipe_ingredient` VALUES (5, '200', 2, 8);
INSERT INTO `recipe_ingredient` VALUES (6, '50', 1, 2);
INSERT INTO `recipe_ingredient` VALUES (7, '10', 1, 3);
INSERT INTO `recipe_ingredient` VALUES (8, '90', 1, 5);
INSERT INTO `recipe_ingredient` VALUES (9, '150', 1, 6);
INSERT INTO `recipe_ingredient` VALUES (10, '200', 1, 10);

-- ----------------------------
-- Triggers structure for table admin
-- ----------------------------
DROP TRIGGER IF EXISTS `tigger_admin_bi`;
delimiter ;;
CREATE TRIGGER `tigger_admin_bi` BEFORE INSERT ON `admin` FOR EACH ROW BEGIN
IF NEW.username NOT RLIKE '^[a-z][a-z0-9]+$' THEN
	SIGNAL SQLSTATE '50004' SET MESSAGE_TEXT = 'Ovo nije validno korisničko ime.';
END IF;
IF NEW.forename NOT RLIKE '^[a-z][a-z0-9]+$' THEN
	SIGNAL SQLSTATE '50005' SET MESSAGE_TEXT = 'Ovo nije validno ime.';
END IF;
IF NEW.surname NOT RLIKE '^[a-z][a-z0-9]+$' THEN
	SIGNAL SQLSTATE '50006' SET MESSAGE_TEXT = 'Ovo nije validno prezime.';
END IF;
IF NEW.email NOT RLIKE '^[a-z0-9._%-]+@[a-z0-9.-]+\.[a-z]{2,4}$' THEN
	SIGNAL SQLSTATE '50007' SET MESSAGE_TEXT = 'Ovo nije validno prezime.';
END IF;

END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table admin
-- ----------------------------
DROP TRIGGER IF EXISTS `trigger_admin_bu`;
delimiter ;;
CREATE TRIGGER `trigger_admin_bu` BEFORE UPDATE ON `admin` FOR EACH ROW BEGIN
IF NEW.username NOT RLIKE '^[a-z][a-z0-9]+$' THEN
	SIGNAL SQLSTATE '50004' SET MESSAGE_TEXT = 'Ovo nije validno korisničko ime.';
END IF;
IF NEW.forename NOT RLIKE '^[a-z][a-z0-9]+$' THEN
	SIGNAL SQLSTATE '50005' SET MESSAGE_TEXT = 'Ovo nije validno ime.';
END IF;
IF NEW.surname NOT RLIKE '^[a-z][a-z0-9]+$' THEN
	SIGNAL SQLSTATE '50006' SET MESSAGE_TEXT = 'Ovo nije validno prezime.';
END IF;
IF NEW.email NOT RLIKE '^[a-z0-9._%-]+@[a-z0-9.-]+\.[a-z]{2,4}$' THEN
	SIGNAL SQLSTATE '50007' SET MESSAGE_TEXT = 'Ovo nije validno prezime.';
END IF;

END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table category
-- ----------------------------
DROP TRIGGER IF EXISTS `trigger_category_bi`;
delimiter ;;
CREATE TRIGGER `trigger_category_bi` BEFORE INSERT ON `category` FOR EACH ROW IF NEW.Name NOT RLIKE '^[A-Z][a-z]+$' THEN
	SIGNAL SQLSTATE '50004' SET MESSAGE_TEXT = 'Ovo nije validan naziv kategorije.';
END IF
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table category
-- ----------------------------
DROP TRIGGER IF EXISTS `trigger_category_bu`;
delimiter ;;
CREATE TRIGGER `trigger_category_bu` BEFORE UPDATE ON `category` FOR EACH ROW IF NEW.Name NOT RLIKE '^[A-Z][a-z]+$' THEN
	SIGNAL SQLSTATE '50004' SET MESSAGE_TEXT = 'Ovo nije validan naziv kategorije.';
END IF
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table recipe
-- ----------------------------
DROP TRIGGER IF EXISTS `trigger_recipe_bi`;
delimiter ;;
CREATE TRIGGER `trigger_recipe_bi` BEFORE INSERT ON `recipe` FOR EACH ROW BEGIN
IF LENGTH(NEW.title) <= 2 THEN
	SIGNAL SQLSTATE '50002' SET MESSAGE_TEXT = 'Naslov recepta mora da bude duži od 4 karaktera.';
END IF;

IF NEW.description <= 4 THEN
	SIGNAL SQLSTATE '50003' SET MESSAGE_TEXT = 'Detaljni opis recepta mora da bude duži od 10 karaktera.';
END IF;

IF NEW.title NOT RLIKE '^[A-Z][a-z]+$' THEN
	SIGNAL SQLSTATE '50004' SET MESSAGE_TEXT = 'Ovo nije validan naziv recepta.';
END IF;

END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table recipe
-- ----------------------------
DROP TRIGGER IF EXISTS `trigger_recipe_bu`;
delimiter ;;
CREATE TRIGGER `trigger_recipe_bu` BEFORE UPDATE ON `recipe` FOR EACH ROW BEGIN
IF LENGTH(NEW.title) <= 2 THEN
	SIGNAL SQLSTATE '50002' SET MESSAGE_TEXT = 'Naslov recepta mora da bude duži od 4 karaktera.';
END IF;

IF NEW.description <= 4 THEN
	SIGNAL SQLSTATE '50003' SET MESSAGE_TEXT = 'Detaljni opis recepta mora da bude duži od 10 karaktera.';
END IF;

IF NEW.title NOT RLIKE '^[A-Z][a-z]+$' THEN
	SIGNAL SQLSTATE '50004' SET MESSAGE_TEXT = 'Ovo nije validan naziv recepta.';
END IF;

END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
