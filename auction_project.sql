/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 100121
 Source Host           : localhost:3306
 Source Schema         : auction_project

 Target Server Type    : MySQL
 Target Server Version : 100121
 File Encoding         : 65001

 Date: 28/05/2019 13:21:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auction
-- ----------------------------
DROP TABLE IF EXISTS `auction`;
CREATE TABLE `auction`  (
  `auction_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `starting_price` decimal(10, 2) UNSIGNED NOT NULL,
  `starts_at` datetime(0) NULL DEFAULT NULL,
  `ends_at` datetime(0) NULL DEFAULT NULL,
  `is_active` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  `category_id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `image_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`auction_id`) USING BTREE,
  INDEX `fk_auction_category_id`(`category_id`) USING BTREE,
  INDEX `idx_auction_ends_at`(`ends_at`) USING BTREE,
  INDEX `idx_auction_is_active`(`is_active`) USING BTREE,
  INDEX `fk_auction_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `fk_auction_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_auction_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of auction
-- ----------------------------
INSERT INTO `auction` VALUES (1, '2018-02-20 11:37:00', 'An oil painting of a snow covered mountain', 'An oil painting of a mountain covered in snow with cras in risus vel lorem mattis mollis in volutpat justo. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.', 170.00, '2018-02-20 11:37:00', '2019-06-20 11:37:00', 1, 3, 1, '1.jpg');
INSERT INTO `auction` VALUES (2, '2018-02-20 11:37:00', 'Painting 1', 'Opis ove slike je lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus hendrerit mattis nisl semper vulputate. Praesent magna ipsum, tincidunt quis tincidunt id, fringilla ut eros. Ut felis velit, semper id facilisis sit amet, accumsan eu erat. Vivamus quis suscipit arcu. Maecenas lacinia mauris ut risus vulputate maximus.', 120.00, '2018-02-20 11:37:00', '2019-06-29 11:37:00', 1, 3, 1, '2.jpg');
INSERT INTO `auction` VALUES (3, '2018-02-20 11:37:00', 'Painting #2', 'Neki drugi opis o slici koji pellentesque a velit magna. Duis a porttitor velit. Nulla porta luctus egestas. Aliquam ut vestibulum erat. Maecenas sit amet justo sit amet nunc eleifend finibus.', 230.00, '2018-02-20 11:37:00', '2019-06-22 10:27:57', 1, 3, 2, '3.jpg');
INSERT INTO `auction` VALUES (4, '2018-04-24 18:34:22', 'Lot grckih novcica', 'Novcici na prodaju su integer dignissim nibh vel mi convallis commodo. Aliquam erat volutpat. Ut laoreet diam leo, sit amet suscipit enim viverra rutrum. Mauris non nunc at ex placerat egestas luctus a nisl. Pellentesque viverra massa mi, eget ornare tortor rhoncus vitae.', 200.88, '2018-06-01 10:00:00', '2019-06-26 22:00:00', 1, 2, 3, '4.jpg');
INSERT INTO `auction` VALUES (5, '2018-06-04 13:53:49', 'Lot rimskih novcica', 'Na prodaju su grcki novcici sa duis quis eros velit. Curabitur in arcu ante. In varius, nisl eu imperdiet porttitor, erat tellus vulputate metus, quis porta ligula massa vitae justo. Sed non est dignissim, pulvinar ipsum at, semper nisl.', 200.77, '2018-06-03 13:02:00', '2019-06-30 04:04:00', 1, 2, 3, '5.jpg');

-- ----------------------------
-- Table structure for auction_view
-- ----------------------------
DROP TABLE IF EXISTS `auction_view`;
CREATE TABLE `auction_view`  (
  `auction_view_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `auction_id` int(11) UNSIGNED NOT NULL,
  `ip_address` varchar(24) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`auction_view_id`) USING BTREE,
  INDEX `fk_auction_view_auction_id`(`auction_id`) USING BTREE,
  INDEX `auction_view_ip_address_idx`(`ip_address`) USING BTREE,
  CONSTRAINT `fk_auction_view_auction_id` FOREIGN KEY (`auction_id`) REFERENCES `auction` (`auction_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 75 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of auction_view
-- ----------------------------
INSERT INTO `auction_view` VALUES (2, '2018-04-15 11:49:53', 2, '199.200.10.23', 'Firefox...');
INSERT INTO `auction_view` VALUES (3, '2018-04-15 11:49:53', 2, '199.200.10.23', 'Chrome...');
INSERT INTO `auction_view` VALUES (4, '2018-04-15 11:49:53', 2, '199.200.10.23', 'Chrome...');
INSERT INTO `auction_view` VALUES (5, '2018-04-15 11:51:31', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0');
INSERT INTO `auction_view` VALUES (6, '2018-04-15 11:55:22', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0');
INSERT INTO `auction_view` VALUES (7, '2018-04-15 11:57:03', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0');
INSERT INTO `auction_view` VALUES (8, '2018-04-15 11:57:04', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0');
INSERT INTO `auction_view` VALUES (9, '2018-04-15 11:57:15', 2, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0');
INSERT INTO `auction_view` VALUES (10, '2018-04-15 11:57:16', 2, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0');
INSERT INTO `auction_view` VALUES (11, '2018-04-15 11:57:16', 2, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0');
INSERT INTO `auction_view` VALUES (12, '2018-04-15 12:23:34', 3, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0');
INSERT INTO `auction_view` VALUES (13, '2018-04-15 12:52:02', 1, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0');
INSERT INTO `auction_view` VALUES (14, '2018-04-15 13:05:21', 1, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0');
INSERT INTO `auction_view` VALUES (15, '2018-04-15 13:09:33', 3, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0');
INSERT INTO `auction_view` VALUES (16, '2018-04-21 11:53:43', 1, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0');
INSERT INTO `auction_view` VALUES (17, '2018-04-30 19:18:06', 1, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (18, '2018-04-30 19:18:13', 4, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (19, '2018-04-30 19:19:24', 1, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (20, '2018-04-30 19:19:58', 1, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (21, '2018-04-30 21:05:46', 1, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (22, '2018-04-30 21:10:19', 1, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (23, '2018-04-30 21:15:03', 1, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (24, '2018-04-30 22:10:06', 1, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (25, '2018-04-30 22:11:07', 1, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (26, '2018-04-30 22:11:19', 3, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (27, '2018-04-30 22:12:22', 3, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (28, '2018-04-30 22:13:49', 3, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (29, '2018-04-30 22:14:07', 3, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (30, '2018-04-30 22:14:42', 3, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (31, '2018-04-30 22:14:44', 3, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (32, '2018-04-30 22:14:47', 3, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (33, '2018-04-30 22:15:07', 3, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (34, '2018-04-30 22:15:20', 1, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (35, '2018-04-30 22:15:23', 2, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (36, '2018-04-30 22:17:00', 2, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (37, '2018-04-30 22:17:01', 2, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (38, '2018-04-30 22:17:21', 3, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (39, '2018-04-30 22:24:17', 2, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (40, '2018-04-30 22:24:18', 3, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (41, '2018-04-30 22:24:26', 1, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (42, '2018-04-30 22:25:59', 3, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (43, '2018-04-30 22:25:59', 1, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (44, '2018-04-30 22:26:00', 2, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (45, '2018-04-30 22:26:00', 3, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (46, '2018-04-30 22:26:01', 1, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (47, '2018-04-30 22:26:41', 2, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0');
INSERT INTO `auction_view` VALUES (48, '2018-04-30 22:28:31', 1, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (49, '2018-04-30 22:28:39', 4, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (50, '2018-04-30 22:29:15', 2, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (51, '2018-04-30 22:33:29', 1, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (52, '2018-04-30 22:33:32', 1, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (53, '2018-04-30 22:33:32', 1, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (54, '2018-04-30 22:33:33', 1, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (55, '2018-05-06 16:18:29', 2, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (56, '2018-05-09 20:31:02', 2, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (57, '2018-05-09 20:31:10', 2, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (58, '2018-05-09 20:40:38', 1, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (59, '2018-05-09 20:40:44', 4, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (60, '2018-05-09 20:41:05', 4, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (61, '2018-05-09 20:42:12', 4, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (62, '2018-05-09 20:42:14', 4, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (63, '2018-05-09 20:43:15', 4, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (64, '2018-05-09 20:43:15', 4, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (65, '2018-05-09 20:43:16', 4, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (66, '2018-05-09 20:43:16', 4, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (67, '2018-05-09 20:43:23', 4, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (68, '2018-05-09 20:43:27', 2, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (69, '2018-05-09 20:45:22', 2, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (70, '2018-05-09 20:45:27', 4, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (71, '2018-05-09 20:45:28', 2, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (72, '2018-05-09 20:45:57', 2, '::1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36');
INSERT INTO `auction_view` VALUES (73, '2018-05-31 14:07:15', 4, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36');
INSERT INTO `auction_view` VALUES (74, '2018-05-31 14:07:18', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `category_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`category_id`) USING BTREE,
  UNIQUE INDEX `uq_category_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 'Antiques');
INSERT INTO `category` VALUES (3, 'Art');
INSERT INTO `category` VALUES (9, 'Fatal error');
INSERT INTO `category` VALUES (7, 'Nova kategorija');
INSERT INTO `category` VALUES (10, 'Nova kategorija izmenjena kroz CMS');
INSERT INTO `category` VALUES (2, 'Numismatics');
INSERT INTO `category` VALUES (6, 'Ovo je test kategorija');
INSERT INTO `category` VALUES (8, 'Proba proba');
INSERT INTO `category` VALUES (5, 'Sculptures');
INSERT INTO `category` VALUES (4, 'Some old things');

-- ----------------------------
-- Table structure for offer
-- ----------------------------
DROP TABLE IF EXISTS `offer`;
CREATE TABLE `offer`  (
  `offer_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `auction_id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `price` decimal(10, 2) UNSIGNED NOT NULL,
  PRIMARY KEY (`offer_id`) USING BTREE,
  INDEX `fk_offer_auction_id`(`auction_id`) USING BTREE,
  INDEX `fk_offer_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `fk_offer_auction_id` FOREIGN KEY (`auction_id`) REFERENCES `auction` (`auction_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_offer_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of offer
-- ----------------------------
INSERT INTO `offer` VALUES (1, '2018-03-13 20:25:41', 1, 2, 200.00);
INSERT INTO `offer` VALUES (2, '2018-03-13 20:28:20', 1, 1, 210.00);
INSERT INTO `offer` VALUES (3, '2018-03-13 20:28:25', 1, 2, 223.00);
INSERT INTO `offer` VALUES (4, '2018-03-13 20:35:40', 2, 2, 300.00);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `username` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `forename` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `surname` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `is_active` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `uq_user_username`(`username`) USING BTREE,
  UNIQUE INDEX `uq_user_email`(`email`) USING BTREE,
  INDEX `idx_user_is_active`(`is_active`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '2018-02-20 11:37:00', 'user_one', '$2y$10$ppZfAxjB9jlLiG.rTkkoSePC96dCit4Q4jfwSW/SwV0aFe4oSZgV2', 'user@some-site.com', 'User', 'One', 1);
INSERT INTO `user` VALUES (2, '2018-02-20 11:37:20', 'user_two', '$2y$10$zU.0/FwSndXO8iJPiU7x3OqIJcJDlM1VQGm2iYMz7GJlXtZ5Irhp.', 'user@some-other-site.com', 'User', 'Two', 1);
INSERT INTO `user` VALUES (3, '2018-05-06 16:54:55', 'user_3', '$2y$10$TZGaANU1NnGLn7wOlA5XOetqDPvFTpHOfaqBmfI69FHEEhUmWyqOi', 'user@some-site.rs', 'Pera', 'Peric', 1);
INSERT INTO `user` VALUES (4, '2019-04-09 15:23:07', 'test1', '$2y$10$TZGaANU1NnGLn7wOlA5XOetqDPvFTpHOfaqBmfI69FHEEhUmWyqOi', 'test@test.rs', 'Korisnik', 'Korisnic', 1);
INSERT INTO `user` VALUES (5, '2019-04-25 10:38:21', 'user_1', '$2y$10$w5nRxqp279ipo5QygCeuu.0kfNwJqY/MuvuHv6UONiZV9OF5gA5sS', 'pperic@test.com', 'Pera', 'Peric', 1);
INSERT INTO `user` VALUES (6, '2019-05-07 13:09:01', 'user_2', '$2y$10$FEa3b2AmPI4UZAYYzPJuyuAjf8apopq0s8YLpGs6vQQXV9QhHjeHy', 'user2@test.com', 'User', 'Test', 1);

SET FOREIGN_KEY_CHECKS = 1;
