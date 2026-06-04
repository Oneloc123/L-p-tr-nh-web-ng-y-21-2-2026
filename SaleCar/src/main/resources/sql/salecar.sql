/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 100432 (10.4.32-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : salecar

 Target Server Type    : MySQL
 Target Server Version : 100432 (10.4.32-MariaDB)
 File Encoding         : 65001

 Date: 04/06/2026 22:11:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `street` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `commune` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `province` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ghn_district_id` int NULL DEFAULT NULL,
  `ghn_ward_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (3, 1, 'Ho Chi Minh City', 'Ho Chi Minh city', 'Thu Duc', 'main', 'Doan Anh', NULL, NULL);
INSERT INTO `address` VALUES (4, 3, 'Ho Chi Minh City', 'Ho Chi Minh city', 'Thu Duc', 'main', 'Doan Anh', NULL, NULL);
INSERT INTO `address` VALUES (5, 4, '120 yên lãng', 'Xã Cẩm La, Thị xã Quảng Yên', 'Tỉnh Quảng Ninh', 'sub', 'Lê Trần Nhật Huy', NULL, NULL);
INSERT INTO `address` VALUES (6, 4, '120 yên lãng', 'Xã Vĩnh Hưng A, Huyện Vĩnh Lợi', 'Bạc Liêu', 'sub', 'Lê Trần Nhật Huy', 2050, '600208');
INSERT INTO `address` VALUES (7, 4, '120 yên lãng', 'Xã Long Trị A, Thị xã Long Mỹ', 'Hậu Giang', 'sub', 'Lê Trần Nhật Huy', 3218, '640808');
INSERT INTO `address` VALUES (8, 4, '120 yên lãng', 'Xã Hồng Sơn, Huyện Mỹ Đức', 'Hà Nội', 'sub', 'Lê Trần Nhật Huy', 1806, '1B2509');
INSERT INTO `address` VALUES (9, 4, '120 yên lãng', 'Xã Mường Toong, Huyện Mường Nhé', 'Điện Biên', 'sub', 'Lê Trần Nhật Huy', 1979, '620805');
INSERT INTO `address` VALUES (10, 4, '120 yên lãng', 'Phường Phạm Ngũ Lão, Quận 1', 'Hồ Chí Minh', 'sub', 'Lê Trần Nhật Huy', 1442, '20109');

-- ----------------------------
-- Table structure for addresses
-- ----------------------------
DROP TABLE IF EXISTS `addresses`;
CREATE TABLE `addresses`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` bigint NULL DEFAULT NULL,
  `address_line` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `province_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ward_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `full_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `nameAddress` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `distric_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of addresses
-- ----------------------------

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `image_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `redirect_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `display_order` int NULL DEFAULT 0,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_display_order`(`display_order` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of banner
-- ----------------------------
INSERT INTO `banner` VALUES (2, 'Đánh thức bản năng chinh phục', '', '/uploads/banners/70ae7d1f-b754-4eed-ab28-b03fe9d8d1c6.jpg', '', 3, '1', '2026-05-25 21:54:57', '2026-05-26 23:39:11');
INSERT INTO `banner` VALUES (3, 'Tuyên ngôn tốc độ', '', '/uploads/banners/75ee2d63-51a2-4998-ab0c-c7885f84e2b3.jpg', '', 4, '1', '2026-05-25 22:18:10', '2026-05-26 23:39:17');
INSERT INTO `banner` VALUES (4, 'Tốc độ tạo nên khác biệt', '', '/uploads/banners/0615e520-2217-455e-af78-44e6fe551cee.jpg', 'http://localhost:8080/product-detail?id=376', 1, '1', '2026-05-26 23:13:43', '2026-05-26 23:39:03');
INSERT INTO `banner` VALUES (5, 'Đẳng cấp anh chấp mọi cuộc đua', '', '/uploads/banners/e44bbc56-9c8c-4ac4-b28f-c47140b14356.jpg', '', 0, '1', '2026-05-26 23:19:47', '2026-05-26 23:32:59');
INSERT INTO `banner` VALUES (6, '.', '', '/uploads/banners/61d921be-027b-488d-8c51-3bca4937f253.jpg', '', 5, '1', '2026-05-26 23:37:37', '2026-05-26 23:40:29');

-- ----------------------------
-- Table structure for brand
-- ----------------------------
DROP TABLE IF EXISTS `brand`;
CREATE TABLE `brand`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `link_brand` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT NULL,
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  `updated_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of brand
-- ----------------------------
INSERT INTO `brand` VALUES (1, 'Toyota a1', 'https://www.toyota.com', 'Toyota is a well-known global automobile manufacturer.', '11', 1, '/uploads/brands/8021bb7a-d82e-4464-8145-8e9e3e50ea94.png', '2024-03-21 08:11:30', '2026-05-26 22:52:41');
INSERT INTO `brand` VALUES (2, 'Honda', 'https://www.honda.com', 'Honda is a well-known global automobile manufacturer.', '24', 1, '/uploads/brands/ebf4de13-f754-4455-83d7-2f94b5fb7a53.png', '2022-04-22 18:34:39', '2026-05-26 22:52:51');
INSERT INTO `brand` VALUES (3, 'Ford', 'https://www.ford.com', 'Ford is a well-known global automobile manufacturer.', '27', 1, '/uploads/brands/528d7d31-a265-4f11-a849-bcace179b575.png', '2024-08-12 23:25:21', '2026-05-26 22:52:58');
INSERT INTO `brand` VALUES (4, 'Chevrolet', 'https://www.chevrolet.com', 'Chevrolet is a well-known global automobile manufacturer.', '35', 1, '/uploads/brands/5d0bc3b2-5537-4d46-90bd-578d77d01d45.png', '2023-05-18 02:17:15', '2026-05-26 22:53:04');
INSERT INTO `brand` VALUES (5, 'BMW', 'https://www.bmw.com', 'BMW is a well-known global automobile manufacturer.', '49', 1, '/uploads/brands/67897bd2-610a-4e44-8fda-b7b9c9f1a1bf.png', '2024-08-26 02:45:11', '2026-05-26 22:54:47');
INSERT INTO `brand` VALUES (6, 'Mercedes-Benz', 'https://www.mercedes-benz.com', 'Mercedes-Benz is a well-known global automobile manufacturer.', '10', 1, '/uploads/brands/f624032c-72d5-4a6b-93ee-9e11d0cfa053.png', '2023-07-06 06:37:00', '2026-05-26 22:53:21');
INSERT INTO `brand` VALUES (7, 'Audi', 'https://www.audi.com', 'Audi is a well-known global automobile manufacturer.', '33', 1, '/uploads/brands/26ca880a-5667-42e8-9f3e-884381bcd2cd.jpg', '2024-02-29 12:50:16', '2026-05-26 22:53:31');
INSERT INTO `brand` VALUES (8, 'Hyundai', 'https://www.hyundai.com', 'Hyundai is a well-known global automobile manufacturer.', '50', 1, '/uploads/brands/8a7c4a00-0cf7-44a1-8f10-9d71daa4fef1.png', '2024-06-21 05:59:55', '2026-05-26 22:53:38');
INSERT INTO `brand` VALUES (9, 'Kia', 'https://www.kia.com', 'Kia is a well-known global automobile manufacturer.', '36', 1, '/uploads/brands/4f0a3f48-e5e2-40f1-a894-50baad37c471.jpeg', '2023-04-09 13:21:59', '2026-05-26 22:53:45');
INSERT INTO `brand` VALUES (10, 'Mazda', 'https://www.mazda.com', 'Mazda is a well-known global automobile manufacturer.', '23', 1, '/uploads/brands/b3fb0da0-d1b9-4eb4-9c37-f8203eb50ea6.png', '2023-10-27 17:09:09', '2026-05-26 22:53:51');
INSERT INTO `brand` VALUES (11, 'Nissan', 'https://www.nissan.com', 'Nissan is a well-known global automobile manufacturer.', '15', 1, '/uploads/brands/38a3a903-aac7-4b51-922d-6f2c1ba57a61.png', '2024-02-28 18:04:06', '2026-05-26 22:54:11');
INSERT INTO `brand` VALUES (12, 'Mitsubishi', 'https://www.mitsubishi.com', 'Mitsubishi is a well-known global automobile manufacturer.', '4', 1, '/uploads/brands/8f8b8ce8-3306-4be6-b3b8-52278c7a7590.png', '2024-02-26 07:07:24', '2026-05-26 22:54:22');
INSERT INTO `brand` VALUES (13, 'Volkswagen', 'https://www.volkswagen.com', 'Volkswagen is a well-known global automobile manufacturer.', '24', 1, '/uploads/brands/7d45ff0c-0c66-4d6a-b1a6-beee0d58de29.png', '2024-04-11 20:08:00', '2026-05-26 22:54:36');
INSERT INTO `brand` VALUES (14, 'Porsche', 'https://www.porsche.com', 'Porsche is a well-known global automobile manufacturer.', '15', 1, '/uploads/brands/2205caf2-445b-46bc-be8e-da48ff558d55.png', '2022-06-12 14:22:53', '2026-05-26 22:54:57');
INSERT INTO `brand` VALUES (15, 'Lexus', 'https://www.lexus.com', 'Lexus is a well-known global automobile manufacturer.', '43', 1, '/uploads/brands/abd02910-0941-4625-9120-ff97f114d414.png', '2022-12-14 03:09:37', '2026-05-26 22:55:06');
INSERT INTO `brand` VALUES (16, 'Subaru', 'https://www.subaru.com', 'Subaru is a well-known global automobile manufacturer.', '40', 1, '/uploads/brands/61360abc-4be3-4fac-a10a-29d6618233fd.png', '2024-09-04 10:11:33', '2026-05-26 22:55:15');
INSERT INTO `brand` VALUES (17, 'Volvo', 'https://www.volvo.com', 'Volvo is a well-known global automobile manufacturer.', '50', 1, '/uploads/brands/e78b3ff4-527a-4c77-9b5d-25b0caa30fae.png', '2023-12-10 16:46:20', '2026-05-26 22:55:24');
INSERT INTO `brand` VALUES (18, 'Land Rover', 'https://www.landrover.com', 'Land Rover is a well-known global automobile manufacturer.', '33', 1, '/uploads/brands/86ed5b9f-1c47-4120-ad5c-f7bcce02f33d.png', '2024-10-15 11:48:34', '2026-05-26 22:55:34');
INSERT INTO `brand` VALUES (19, 'Jeep', 'https://www.jeep.com', 'Jeep is a well-known global automobile manufacturer.', '22', 1, '/uploads/brands/76af792a-ff32-47ca-b979-85d213cdcbfc.png', '2024-11-05 05:30:18', '2026-05-26 22:55:42');
INSERT INTO `brand` VALUES (20, 'Peugeot', 'https://www.peugeot.com', 'Peugeot is a well-known global automobile manufacturer.', '34', 1, '/uploads/brands/a60e31a2-6456-4333-a54d-da711f1cff7f.png', '2022-03-23 02:40:23', '2026-05-26 22:55:52');
INSERT INTO `brand` VALUES (21, 'Sakura v1', '', '', NULL, 1, '/uploads/brands/dd712c2a-3c66-48e0-a16f-d166d6fc3c1b.png', '2026-05-26 11:34:47', '2026-05-26 12:22:45');
INSERT INTO `brand` VALUES (22, 'Toyota a1f', '', '', NULL, 1, '/uploads/brands/cc61ad80-e779-4ef5-888a-be8cd89bc480.png', '2026-05-26 11:39:03', '2026-05-26 12:22:45');
INSERT INTO `brand` VALUES (23, 'Sakura v1ff', '', '', NULL, 1, '/uploads/brands/b9395965-6e5f-4721-bc94-94c7af6178a2.png', '2026-05-26 11:48:20', '2026-05-26 12:22:45');
INSERT INTO `brand` VALUES (24, 'Mecedes v500', '', '', NULL, 1, '/uploads/brands/023aecac-6a31-43e1-ad20-fb3da761bd39.png', '2026-05-26 12:23:05', '2026-05-26 12:23:05');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` tinyint(1) NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  `updated_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 'Sedan 3', 'Sedan vehicle category.', 'bi-speedometer2', 1, '2022-03-10 05:21:27', '2026-05-26 11:21:43');
INSERT INTO `category` VALUES (2, 'SUV', 'SUV vehicle category.', 'bi-shield-check', 1, '2022-11-07 16:05:15', '2026-05-26 11:21:46');
INSERT INTO `category` VALUES (3, 'Hatchback', 'Hatchback vehicle category.', 'bi-lightning', 1, '2024-06-07 13:09:38', '2026-05-26 11:21:47');
INSERT INTO `category` VALUES (4, 'Pickup', 'Pickup vehicle category.', 'bi-gear-wide-connected', 1, '2022-10-05 22:47:54', '2026-05-26 11:21:49');
INSERT INTO `category` VALUES (5, 'Coupe', 'Coupe vehicle category.', 'bi-lightning-charge', 0, '2024-12-06 03:22:22', '2026-05-26 11:21:41');
INSERT INTO `category` VALUES (6, 'Convertible', 'Convertible vehicle category.', 'bi-sun', 0, '2023-08-25 18:23:31', '2026-05-26 11:21:41');
INSERT INTO `category` VALUES (7, 'Minivan', 'Minivan vehicle category.', 'bi-people-fill', 0, '2022-01-26 07:05:31', '2026-05-26 11:21:41');
INSERT INTO `category` VALUES (8, 'Crossover', 'Crossover vehicle category.', 'bi-diagram-3-fill', 0, '2024-12-11 11:06:08', '2026-05-26 11:21:41');
INSERT INTO `category` VALUES (9, 'Electric', 'Electric vehicle category.', 'bi-battery-charging', 0, '2024-07-13 12:01:54', '2026-05-26 11:21:41');
INSERT INTO `category` VALUES (10, 'Hybrid', 'Hybrid vehicle category.', 'bi-recycle', 0, '2023-09-19 20:53:55', '2026-05-26 11:21:41');
INSERT INTO `category` VALUES (11, 'Toyota SY', 'aaa', 'bi-speedometer2', 0, '2026-05-09 21:56:42', '2026-05-26 11:17:25');
INSERT INTO `category` VALUES (12, 'Supper car', '', 'bi-diagram-3-fill', 0, '2026-05-12 15:47:37', '2026-05-26 11:17:25');
INSERT INTO `category` VALUES (13, 'Toyota a15', '', 'bi-speedometer2', 0, '2026-05-26 11:16:30', '2026-05-26 11:17:25');
INSERT INTO `category` VALUES (14, 'ádasas', '', 'bi-diagram-3-fill', 0, '2026-05-26 11:17:12', '2026-05-26 11:17:25');
INSERT INTO `category` VALUES (15, 'Deepseek v4 flashdf', '', 'bi-diagram-3-fill', 0, '2026-05-26 11:20:29', '2026-05-26 11:20:29');
INSERT INTO `category` VALUES (16, 'sdfsdfsdf', '', 'bi-diagram-3-fill', 0, '2026-05-26 11:21:11', '2026-05-26 11:21:11');
INSERT INTO `category` VALUES (17, 'ưerwerwe', '', 'bi-diagram-3-fill', 0, '2026-05-26 11:21:28', '2026-05-26 11:21:28');

-- ----------------------------
-- Table structure for discount
-- ----------------------------
DROP TABLE IF EXISTS `discount`;
CREATE TABLE `discount`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value_type` enum('percent','amount') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` decimal(15, 2) NOT NULL,
  `entity_type` enum('category','product','brand') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_id` int NOT NULL,
  `priority` int NULL DEFAULT NULL,
  `status` int NULL DEFAULT NULL,
  `start_at` datetime NULL DEFAULT NULL,
  `end_at` datetime NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  `updated_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_discount_entity`(`entity_type` ASC, `entity_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of discount
-- ----------------------------
INSERT INTO `discount` VALUES (1, 'Toyota', 'percent', 20.00, 'brand', 1, NULL, NULL, '2026-03-06 12:06:35', '2026-03-31 12:06:40', '2026-03-06 12:07:09', '2026-05-15 22:10:12');
INSERT INTO `discount` VALUES (2, 'Honda', 'amount', 11000000.00, 'brand', 2, NULL, NULL, '2026-03-07 10:39:45', '2026-03-29 10:39:49', '2026-03-07 10:39:54', '2026-03-07 10:39:54');
INSERT INTO `discount` VALUES (3, 'sp mới', 'amount', 20.00, 'product', 402, 1, NULL, '2026-05-13 00:00:00', '2026-05-24 00:00:00', '2026-05-13 16:46:06', '2026-05-13 16:46:06');
INSERT INTO `discount` VALUES (5, 'Toyota a1', 'percent', 99.00, 'product', 409, 1, 1, '2026-06-04 00:00:00', '2026-07-05 00:00:00', '2026-06-04 18:19:15', '2026-06-04 18:19:15');

-- ----------------------------
-- Table structure for export_receipt_items
-- ----------------------------
DROP TABLE IF EXISTS `export_receipt_items`;
CREATE TABLE `export_receipt_items`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `receipt_id` int NOT NULL,
  `product_id` int NOT NULL,
  `variant_id` int NULL DEFAULT NULL,
  `quantity` int NOT NULL,
  `export_price` decimal(12, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `receipt_id`(`receipt_id` ASC) USING BTREE,
  INDEX `product_id`(`product_id` ASC) USING BTREE,
  INDEX `variant_id`(`variant_id` ASC) USING BTREE,
  CONSTRAINT `export_receipt_items_ibfk_1` FOREIGN KEY (`receipt_id`) REFERENCES `export_receipts` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `export_receipt_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `export_receipt_items_ibfk_3` FOREIGN KEY (`variant_id`) REFERENCES `product_variants` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of export_receipt_items
-- ----------------------------
INSERT INTO `export_receipt_items` VALUES (1, 3, 409, 13, 1, 120000.00);
INSERT INTO `export_receipt_items` VALUES (2, 4, 406, 7, 2, 1700000.00);
INSERT INTO `export_receipt_items` VALUES (3, 5, 406, 8, 5, 1800000.00);

-- ----------------------------
-- Table structure for export_receipts
-- ----------------------------
DROP TABLE IF EXISTS `export_receipts`;
CREATE TABLE `export_receipts`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_by` int NULL DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of export_receipts
-- ----------------------------
INSERT INTO `export_receipts` VALUES (1, 1, NULL, 'completed', '2026-05-22 13:55:22');
INSERT INTO `export_receipts` VALUES (2, 1, NULL, 'completed', '2026-05-22 17:30:24');
INSERT INTO `export_receipts` VALUES (3, 1, 'order', 'completed', '2026-06-04 17:46:52');
INSERT INTO `export_receipts` VALUES (4, 1, 'order', 'completed', '2026-06-04 20:29:55');
INSERT INTO `export_receipts` VALUES (5, 1, 'order', 'completed', '2026-06-04 20:32:20');

-- ----------------------------
-- Table structure for image
-- ----------------------------
DROP TABLE IF EXISTS `image`;
CREATE TABLE `image`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `entity_type` enum('product','brand','category','user','banner') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_id` int NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `is_main` tinyint(1) NULL DEFAULT 0,
  `image_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_entity`(`entity_type` ASC, `entity_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 321 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of image
-- ----------------------------
INSERT INTO `image` VALUES (1, 'product', 1, NULL, 0, 'products/00001/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (2, 'product', 1, NULL, 1, 'products/00001/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (3, 'product', 1, NULL, 0, 'products/00001/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (4, 'product', 1, NULL, 0, 'products/00001/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (5, 'product', 2, NULL, 0, 'products/00002/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (6, 'product', 2, NULL, 0, 'products/00002/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (7, 'product', 2, NULL, 1, 'products/00002/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (8, 'product', 2, NULL, 0, 'products/00002/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (9, 'product', 3, NULL, 1, 'products/00003/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (10, 'product', 3, NULL, 0, 'products/00003/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (11, 'product', 3, NULL, 0, 'products/00003/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (12, 'product', 3, NULL, 0, 'products/00003/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (13, 'product', 4, NULL, 0, 'products/00004/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (14, 'product', 4, NULL, 1, 'products/00004/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (15, 'product', 4, NULL, 0, 'products/00004/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (16, 'product', 4, NULL, 0, 'products/00004/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (17, 'product', 5, NULL, 0, 'products/00005/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (18, 'product', 5, NULL, 0, 'products/00005/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (19, 'product', 5, NULL, 0, 'products/00005/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (20, 'product', 5, NULL, 1, 'products/00005/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (21, 'product', 6, NULL, 0, 'products/00006/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (22, 'product', 6, NULL, 1, 'products/00006/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (23, 'product', 6, NULL, 0, 'products/00006/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (24, 'product', 6, NULL, 0, 'products/00006/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (25, 'product', 7, NULL, 1, 'products/00007/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (26, 'product', 7, NULL, 0, 'products/00007/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (27, 'product', 7, NULL, 0, 'products/00007/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (28, 'product', 7, NULL, 0, 'products/00007/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (29, 'product', 8, NULL, 0, 'products/00008/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (30, 'product', 8, NULL, 1, 'products/00008/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (31, 'product', 8, NULL, 0, 'products/00008/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (32, 'product', 8, NULL, 0, 'products/00008/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (33, 'product', 9, NULL, 0, 'products/00009/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (34, 'product', 9, NULL, 0, 'products/00009/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (35, 'product', 9, NULL, 1, 'products/00009/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (36, 'product', 9, NULL, 0, 'products/00009/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (37, 'product', 10, NULL, 1, 'products/00010/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (38, 'product', 10, NULL, 0, 'products/00010/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (39, 'product', 10, NULL, 0, 'products/00010/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (40, 'product', 10, NULL, 0, 'products/00010/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (41, 'product', 11, NULL, 0, 'products/00011/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (42, 'product', 11, NULL, 1, 'products/00011/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (43, 'product', 11, NULL, 0, 'products/00011/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (44, 'product', 11, NULL, 0, 'products/00011/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (45, 'product', 12, NULL, 0, 'products/00012/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (46, 'product', 12, NULL, 0, 'products/00012/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (47, 'product', 12, NULL, 0, 'products/00012/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (48, 'product', 12, NULL, 1, 'products/00012/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (49, 'product', 13, NULL, 1, 'products/00013/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (50, 'product', 13, NULL, 0, 'products/00013/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (51, 'product', 13, NULL, 0, 'products/00013/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (52, 'product', 13, NULL, 0, 'products/00013/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (53, 'product', 14, NULL, 0, 'products/00014/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (54, 'product', 14, NULL, 0, 'products/00014/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (55, 'product', 14, NULL, 1, 'products/00014/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (56, 'product', 14, NULL, 0, 'products/00014/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (57, 'product', 15, NULL, 0, 'products/00015/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (58, 'product', 15, NULL, 0, 'products/00015/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (59, 'product', 15, NULL, 0, 'products/00015/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (60, 'product', 15, NULL, 1, 'products/00015/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (61, 'product', 16, NULL, 0, 'products/00016/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (62, 'product', 16, NULL, 0, 'products/00016/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (63, 'product', 16, NULL, 0, 'products/00016/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (64, 'product', 16, NULL, 1, 'products/00016/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (65, 'product', 17, NULL, 0, 'products/00017/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (66, 'product', 17, NULL, 1, 'products/00017/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (67, 'product', 17, NULL, 0, 'products/00017/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (68, 'product', 17, NULL, 0, 'products/00017/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (69, 'product', 18, NULL, 0, 'products/00018/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (70, 'product', 18, NULL, 0, 'products/00018/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (71, 'product', 18, NULL, 1, 'products/00018/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (72, 'product', 18, NULL, 0, 'products/00018/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (73, 'product', 19, NULL, 1, 'products/00019/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (74, 'product', 19, NULL, 0, 'products/00019/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (75, 'product', 19, NULL, 0, 'products/00019/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (76, 'product', 19, NULL, 0, 'products/00019/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (77, 'product', 20, NULL, 0, 'products/00020/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (78, 'product', 20, NULL, 1, 'products/00020/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (79, 'product', 20, NULL, 0, 'products/00020/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (80, 'product', 20, NULL, 0, 'products/00020/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (81, 'product', 21, NULL, 0, 'products/00021/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (82, 'product', 21, NULL, 0, 'products/00021/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (83, 'product', 21, NULL, 0, 'products/00021/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (84, 'product', 21, NULL, 1, 'products/00021/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (85, 'product', 22, NULL, 0, 'products/00022/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (86, 'product', 22, NULL, 1, 'products/00022/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (87, 'product', 22, NULL, 0, 'products/00022/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (88, 'product', 22, NULL, 0, 'products/00022/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (89, 'product', 23, NULL, 1, 'products/00023/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (90, 'product', 23, NULL, 0, 'products/00023/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (91, 'product', 23, NULL, 0, 'products/00023/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (92, 'product', 23, NULL, 0, 'products/00023/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (93, 'product', 24, NULL, 0, 'products/00024/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (94, 'product', 24, NULL, 0, 'products/00024/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (95, 'product', 24, NULL, 1, 'products/00024/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (96, 'product', 24, NULL, 0, 'products/00024/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (97, 'product', 25, NULL, 1, 'products/00025/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (98, 'product', 25, NULL, 0, 'products/00025/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (99, 'product', 25, NULL, 0, 'products/00025/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (100, 'product', 25, NULL, 0, 'products/00025/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (101, 'product', 26, NULL, 0, 'products/00026/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (102, 'product', 26, NULL, 1, 'products/00026/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (103, 'product', 26, NULL, 0, 'products/00026/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (104, 'product', 26, NULL, 0, 'products/00026/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (105, 'product', 27, NULL, 0, 'products/00027/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (106, 'product', 27, NULL, 0, 'products/00027/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (107, 'product', 27, NULL, 0, 'products/00027/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (108, 'product', 27, NULL, 1, 'products/00027/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (109, 'product', 28, NULL, 0, 'products/00028/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (110, 'product', 28, NULL, 1, 'products/00028/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (111, 'product', 28, NULL, 0, 'products/00028/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (112, 'product', 28, NULL, 0, 'products/00028/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (113, 'product', 29, NULL, 1, 'products/00029/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (114, 'product', 29, NULL, 0, 'products/00029/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (115, 'product', 29, NULL, 0, 'products/00029/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (116, 'product', 29, NULL, 0, 'products/00029/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (117, 'product', 30, NULL, 0, 'products/00030/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (118, 'product', 30, NULL, 0, 'products/00030/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (119, 'product', 30, NULL, 1, 'products/00030/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (120, 'product', 30, NULL, 0, 'products/00030/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (121, 'product', 31, NULL, 0, 'products/00031/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (122, 'product', 31, NULL, 0, 'products/00031/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (123, 'product', 31, NULL, 0, 'products/00031/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (124, 'product', 31, NULL, 1, 'products/00031/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (125, 'product', 32, NULL, 1, 'products/00032/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (126, 'product', 32, NULL, 0, 'products/00032/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (127, 'product', 32, NULL, 0, 'products/00032/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (128, 'product', 32, NULL, 0, 'products/00032/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (129, 'product', 33, NULL, 0, 'products/00033/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (130, 'product', 33, NULL, 1, 'products/00033/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (131, 'product', 33, NULL, 0, 'products/00033/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (132, 'product', 33, NULL, 0, 'products/00033/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (133, 'product', 34, NULL, 0, 'products/00034/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (134, 'product', 34, NULL, 0, 'products/00034/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (135, 'product', 34, NULL, 1, 'products/00034/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (136, 'product', 34, NULL, 0, 'products/00034/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (137, 'product', 35, NULL, 1, 'products/00035/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (138, 'product', 35, NULL, 0, 'products/00035/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (139, 'product', 35, NULL, 0, 'products/00035/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (140, 'product', 35, NULL, 0, 'products/00035/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (141, 'product', 36, NULL, 0, 'products/00036/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (142, 'product', 36, NULL, 1, 'products/00036/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (143, 'product', 36, NULL, 0, 'products/00036/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (144, 'product', 36, NULL, 0, 'products/00036/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (145, 'product', 37, NULL, 0, 'products/00037/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (146, 'product', 37, NULL, 0, 'products/00037/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (147, 'product', 37, NULL, 0, 'products/00037/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (148, 'product', 37, NULL, 1, 'products/00037/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (149, 'product', 38, NULL, 0, 'products/00038/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (150, 'product', 38, NULL, 1, 'products/00038/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (151, 'product', 38, NULL, 0, 'products/00038/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (152, 'product', 38, NULL, 0, 'products/00038/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (153, 'product', 39, NULL, 1, 'products/00039/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (154, 'product', 39, NULL, 0, 'products/00039/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (155, 'product', 39, NULL, 0, 'products/00039/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (156, 'product', 39, NULL, 0, 'products/00039/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (157, 'product', 40, NULL, 0, 'products/00040/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (158, 'product', 40, NULL, 0, 'products/00040/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (159, 'product', 40, NULL, 1, 'products/00040/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (160, 'product', 40, NULL, 0, 'products/00040/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (161, 'product', 41, NULL, 1, 'products/00041/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (162, 'product', 41, NULL, 0, 'products/00041/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (163, 'product', 41, NULL, 0, 'products/00041/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (164, 'product', 41, NULL, 0, 'products/00041/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (165, 'product', 42, NULL, 0, 'products/00042/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (166, 'product', 42, NULL, 1, 'products/00042/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (167, 'product', 42, NULL, 0, 'products/00042/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (168, 'product', 42, NULL, 0, 'products/00042/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (169, 'product', 43, NULL, 0, 'products/00043/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (170, 'product', 43, NULL, 0, 'products/00043/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (171, 'product', 43, NULL, 0, 'products/00043/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (172, 'product', 43, NULL, 1, 'products/00043/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (173, 'product', 44, NULL, 0, 'products/00044/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (174, 'product', 44, NULL, 1, 'products/00044/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (175, 'product', 44, NULL, 0, 'products/00044/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (176, 'product', 44, NULL, 0, 'products/00044/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (177, 'product', 45, NULL, 1, 'products/00045/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (178, 'product', 45, NULL, 0, 'products/00045/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (179, 'product', 45, NULL, 0, 'products/00045/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (180, 'product', 45, NULL, 0, 'products/00045/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (181, 'product', 46, NULL, 0, 'products/00046/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (182, 'product', 46, NULL, 0, 'products/00046/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (183, 'product', 46, NULL, 1, 'products/00046/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (184, 'product', 46, NULL, 0, 'products/00046/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (185, 'product', 47, NULL, 0, 'products/00047/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (186, 'product', 47, NULL, 0, 'products/00047/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (187, 'product', 47, NULL, 0, 'products/00047/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (188, 'product', 47, NULL, 1, 'products/00047/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (189, 'product', 48, NULL, 1, 'products/00048/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (190, 'product', 48, NULL, 0, 'products/00048/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (191, 'product', 48, NULL, 0, 'products/00048/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (192, 'product', 48, NULL, 0, 'products/00048/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (193, 'product', 49, NULL, 0, 'products/00049/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (194, 'product', 49, NULL, 1, 'products/00049/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (195, 'product', 49, NULL, 0, 'products/00049/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (196, 'product', 49, NULL, 0, 'products/00049/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (197, 'product', 50, NULL, 0, 'products/00050/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (198, 'product', 50, NULL, 0, 'products/00050/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (199, 'product', 50, NULL, 1, 'products/00050/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (200, 'product', 50, NULL, 0, 'products/00050/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (201, 'product', 51, NULL, 1, 'products/00051/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (202, 'product', 51, NULL, 0, 'products/00051/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (203, 'product', 51, NULL, 0, 'products/00051/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (204, 'product', 51, NULL, 0, 'products/00051/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (205, 'product', 52, NULL, 0, 'products/00052/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (206, 'product', 52, NULL, 1, 'products/00052/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (207, 'product', 52, NULL, 0, 'products/00052/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (208, 'product', 52, NULL, 0, 'products/00052/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (209, 'product', 53, NULL, 0, 'products/00053/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (210, 'product', 53, NULL, 0, 'products/00053/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (211, 'product', 53, NULL, 0, 'products/00053/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (212, 'product', 53, NULL, 1, 'products/00053/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (213, 'product', 54, NULL, 0, 'products/00054/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (214, 'product', 54, NULL, 1, 'products/00054/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (215, 'product', 54, NULL, 0, 'products/00054/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (216, 'product', 54, NULL, 0, 'products/00054/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (217, 'product', 55, NULL, 1, 'products/00055/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (218, 'product', 55, NULL, 0, 'products/00055/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (219, 'product', 55, NULL, 0, 'products/00055/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (220, 'product', 55, NULL, 0, 'products/00055/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (221, 'product', 56, NULL, 0, 'products/00056/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (222, 'product', 56, NULL, 0, 'products/00056/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (223, 'product', 56, NULL, 1, 'products/00056/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (224, 'product', 56, NULL, 0, 'products/00056/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (225, 'product', 57, NULL, 0, 'products/00057/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (226, 'product', 57, NULL, 0, 'products/00057/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (227, 'product', 57, NULL, 0, 'products/00057/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (228, 'product', 57, NULL, 1, 'products/00057/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (229, 'product', 58, NULL, 1, 'products/00058/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (230, 'product', 58, NULL, 0, 'products/00058/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (231, 'product', 58, NULL, 0, 'products/00058/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (232, 'product', 58, NULL, 0, 'products/00058/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (233, 'product', 59, NULL, 0, 'products/00059/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (234, 'product', 59, NULL, 1, 'products/00059/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (235, 'product', 59, NULL, 0, 'products/00059/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (236, 'product', 59, NULL, 0, 'products/00059/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (237, 'product', 60, NULL, 0, 'products/00060/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (238, 'product', 60, NULL, 0, 'products/00060/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (239, 'product', 60, NULL, 1, 'products/00060/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (240, 'product', 60, NULL, 0, 'products/00060/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (241, 'product', 61, NULL, 1, 'products/00061/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (242, 'product', 61, NULL, 0, 'products/00061/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (243, 'product', 61, NULL, 0, 'products/00061/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (244, 'product', 61, NULL, 0, 'products/00061/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (245, 'product', 62, NULL, 0, 'products/00062/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (246, 'product', 62, NULL, 1, 'products/00062/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (247, 'product', 62, NULL, 0, 'products/00062/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (248, 'product', 62, NULL, 0, 'products/00062/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (249, 'product', 63, NULL, 0, 'products/00063/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (250, 'product', 63, NULL, 0, 'products/00063/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (251, 'product', 63, NULL, 0, 'products/00063/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (252, 'product', 63, NULL, 1, 'products/00063/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (253, 'product', 64, NULL, 0, 'products/00064/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (254, 'product', 64, NULL, 1, 'products/00064/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (255, 'product', 64, NULL, 0, 'products/00064/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (256, 'product', 64, NULL, 0, 'products/00064/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (257, 'product', 65, NULL, 1, 'products/00065/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (258, 'product', 65, NULL, 0, 'products/00065/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (259, 'product', 65, NULL, 0, 'products/00065/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (260, 'product', 65, NULL, 0, 'products/00065/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (261, 'product', 66, NULL, 0, 'products/00066/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (262, 'product', 66, NULL, 0, 'products/00066/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (263, 'product', 66, NULL, 1, 'products/00066/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (264, 'product', 66, NULL, 0, 'products/00066/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (265, 'product', 67, NULL, 0, 'products/00067/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (266, 'product', 67, NULL, 0, 'products/00067/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (267, 'product', 67, NULL, 0, 'products/00067/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (268, 'product', 67, NULL, 1, 'products/00067/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (269, 'product', 68, NULL, 1, 'products/00068/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (270, 'product', 68, NULL, 0, 'products/00068/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (271, 'product', 68, NULL, 0, 'products/00068/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (272, 'product', 68, NULL, 0, 'products/00068/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (273, 'product', 69, NULL, 0, 'products/00069/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (274, 'product', 69, NULL, 1, 'products/00069/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (275, 'product', 69, NULL, 0, 'products/00069/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (276, 'product', 69, NULL, 0, 'products/00069/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (277, 'product', 70, NULL, 0, 'products/00070/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (278, 'product', 70, NULL, 0, 'products/00070/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (279, 'product', 70, NULL, 1, 'products/00070/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (280, 'product', 70, NULL, 0, 'products/00070/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (281, 'product', 71, NULL, 1, 'products/00071/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (282, 'product', 71, NULL, 0, 'products/00071/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (283, 'product', 71, NULL, 0, 'products/00071/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (284, 'product', 71, NULL, 0, 'products/00071/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (285, 'product', 72, NULL, 0, 'products/00072/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (286, 'product', 72, NULL, 1, 'products/00072/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (287, 'product', 72, NULL, 0, 'products/00072/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (288, 'product', 72, NULL, 0, 'products/00072/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (289, 'product', 73, NULL, 0, 'products/00073/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (290, 'product', 73, NULL, 0, 'products/00073/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (291, 'product', 73, NULL, 0, 'products/00073/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (292, 'product', 73, NULL, 1, 'products/00073/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (293, 'product', 74, NULL, 0, 'products/00074/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (294, 'product', 74, NULL, 1, 'products/00074/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (295, 'product', 74, NULL, 0, 'products/00074/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (296, 'product', 74, NULL, 0, 'products/00074/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (297, 'product', 75, NULL, 1, 'products/00075/gallery/1.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (298, 'product', 75, NULL, 0, 'products/00075/gallery/2.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (299, 'product', 75, NULL, 0, 'products/00075/gallery/3.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (300, 'product', 75, NULL, 0, 'products/00075/gallery/4.png', '2026-06-04 20:36:28');
INSERT INTO `image` VALUES (301, 'brand', 1, NULL, 0, 'https://1000logos.net/wp-content/uploads/2018/02/Toyota-logo.png', '2026-03-21 21:31:57');
INSERT INTO `image` VALUES (302, 'brand', 2, NULL, 0, 'https://1000logos.net/wp-content/uploads/2018/03/Honda-Logo.png', '2026-03-21 21:31:57');
INSERT INTO `image` VALUES (303, 'brand', 3, NULL, 0, 'https://1000logos.net/wp-content/uploads/2018/02/Ford-Logo.png', '2026-03-21 21:31:57');
INSERT INTO `image` VALUES (304, 'brand', 4, NULL, 0, 'https://1000logos.net/wp-content/uploads/2019/12/Chevrolet-logo.png', '2026-03-21 21:31:57');
INSERT INTO `image` VALUES (305, 'brand', 5, NULL, 0, 'https://1000logos.net/wp-content/uploads/2018/02/BMW-Logo.png', '2026-03-21 21:31:57');
INSERT INTO `image` VALUES (306, 'brand', 6, NULL, 0, 'https://1000logos.net/wp-content/uploads/2018/04/Mercedes-Benz-Logo.png', '2026-03-21 21:31:57');
INSERT INTO `image` VALUES (307, 'brand', 7, NULL, 0, 'http://1000logos.net/wp-content/uploads/2018/05/Audi-logo-500x313.jpg', '2026-03-21 21:31:57');
INSERT INTO `image` VALUES (308, 'brand', 8, NULL, 0, 'https://1000logos.net/wp-content/uploads/2018/04/Hyundai-Logo-2023.png', '2026-03-21 21:31:57');
INSERT INTO `image` VALUES (309, 'brand', 9, NULL, 0, 'https://1000logos.net/wp-content/uploads/2020/02/kia-logo-500x333.jpeg', '2026-03-21 21:31:57');
INSERT INTO `image` VALUES (310, 'brand', 10, NULL, 0, 'https://1000logos.net/wp-content/uploads/2019/12/Mazda-Logo-500x281.png', '2026-03-21 21:31:57');
INSERT INTO `image` VALUES (311, 'brand', 11, NULL, 0, 'https://1000logos.net/wp-content/uploads/2020/03/nissan-logo-500x334.png', '2026-03-21 21:31:57');
INSERT INTO `image` VALUES (312, 'brand', 12, NULL, 0, 'https://1000logos.net/wp-content/uploads/2020/03/Mitsubishi-logo-500x342.png', '2026-03-21 21:31:57');
INSERT INTO `image` VALUES (313, 'brand', 13, NULL, 0, 'https://1000logos.net/wp-content/uploads/2021/04/Volkswagen-logo-500x281.png', '2026-03-21 21:31:57');
INSERT INTO `image` VALUES (314, 'brand', 14, NULL, 0, 'https://1000logos.net/wp-content/uploads/2018/02/Porsche-Logo-500x281.png', '2026-03-21 21:31:57');
INSERT INTO `image` VALUES (315, 'brand', 15, NULL, 0, 'https://1000logos.net/wp-content/uploads/2020/02/Lexus-L%D0%BEgo-500x281.png', '2026-03-21 21:31:57');
INSERT INTO `image` VALUES (316, 'brand', 16, NULL, 0, 'https://1000logos.net/wp-content/uploads/2021/09/Subaru-Logo-500x281.png', '2026-03-21 21:31:57');
INSERT INTO `image` VALUES (317, 'brand', 17, NULL, 0, 'https://1000logos.net/wp-content/uploads/2020/03/Volvo-Logo-500x281.png', '2026-03-21 21:31:57');
INSERT INTO `image` VALUES (318, 'brand', 18, NULL, 0, 'https://1000logos.net/wp-content/uploads/2020/02/Land-Rover-Logo-500x281.png', '2026-03-21 21:31:57');
INSERT INTO `image` VALUES (319, 'brand', 19, NULL, 0, 'https://1000logos.net/wp-content/uploads/2018/04/Jeep-logo-500x281.png', '2026-03-21 21:31:57');
INSERT INTO `image` VALUES (320, 'brand', 20, NULL, 0, 'https://1000logos.net/wp-content/uploads/2021/02/Peugeot-logo-500x333.png', '2026-03-21 21:31:57');

-- ----------------------------
-- Table structure for import_receipt_items
-- ----------------------------
DROP TABLE IF EXISTS `import_receipt_items`;
CREATE TABLE `import_receipt_items`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `receipt_id` int NOT NULL,
  `product_id` int NOT NULL,
  `variant_id` int NULL DEFAULT NULL,
  `quantity` int NOT NULL,
  `import_price` decimal(12, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `receipt_id`(`receipt_id` ASC) USING BTREE,
  INDEX `product_id`(`product_id` ASC) USING BTREE,
  INDEX `variant_id`(`variant_id` ASC) USING BTREE,
  CONSTRAINT `import_receipt_items_ibfk_1` FOREIGN KEY (`receipt_id`) REFERENCES `import_receipts` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `import_receipt_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `import_receipt_items_ibfk_3` FOREIGN KEY (`variant_id`) REFERENCES `product_variants` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of import_receipt_items
-- ----------------------------
INSERT INTO `import_receipt_items` VALUES (1, 1, 406, 7, 100, 1700000.00);
INSERT INTO `import_receipt_items` VALUES (2, 2, 406, 7, 200, 1700000.00);
INSERT INTO `import_receipt_items` VALUES (3, 3, 406, 7, 141, 1700000.00);
INSERT INTO `import_receipt_items` VALUES (4, 4, 406, 7, 241, 1700000.00);
INSERT INTO `import_receipt_items` VALUES (5, 5, 406, 7, 341, 1700000.00);
INSERT INTO `import_receipt_items` VALUES (6, 6, 406, 7, 441, 1700000.00);
INSERT INTO `import_receipt_items` VALUES (7, 7, 406, 7, 442, 1700000.00);
INSERT INTO `import_receipt_items` VALUES (8, 8, 406, 7, 444, 1700000.00);
INSERT INTO `import_receipt_items` VALUES (9, 9, 406, 7, 544, 1700000.00);
INSERT INTO `import_receipt_items` VALUES (10, 10, 406, 8, 100, 1800000.00);
INSERT INTO `import_receipt_items` VALUES (11, 11, 406, 7, 1533, 1700000.00);
INSERT INTO `import_receipt_items` VALUES (12, 12, 406, 7, 1723, 1700000.00);
INSERT INTO `import_receipt_items` VALUES (13, 13, 408, 11, 122, 1000001.00);
INSERT INTO `import_receipt_items` VALUES (14, 14, 409, 13, 100, 120000.00);
INSERT INTO `import_receipt_items` VALUES (15, 15, 408, 12, 1000, 100001.00);
INSERT INTO `import_receipt_items` VALUES (16, 16, 1, 14, 200, 1000001.00);
INSERT INTO `import_receipt_items` VALUES (17, 17, 1, 15, 200, 1000001.00);
INSERT INTO `import_receipt_items` VALUES (18, 18, 1, 16, 200, 1200001.00);
INSERT INTO `import_receipt_items` VALUES (19, 19, 1, 17, 200, 1400001.00);

-- ----------------------------
-- Table structure for import_receipts
-- ----------------------------
DROP TABLE IF EXISTS `import_receipts`;
CREATE TABLE `import_receipts`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_by` int NULL DEFAULT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of import_receipts
-- ----------------------------
INSERT INTO `import_receipts` VALUES (1, 1, NULL, 'completed', '2026-05-22 13:42:48');
INSERT INTO `import_receipts` VALUES (2, 1, NULL, 'completed', '2026-05-22 13:43:26');
INSERT INTO `import_receipts` VALUES (3, 1, NULL, 'completed', '2026-05-22 17:10:24');
INSERT INTO `import_receipts` VALUES (4, 1, NULL, 'completed', '2026-05-22 17:12:57');
INSERT INTO `import_receipts` VALUES (5, 1, NULL, 'completed', '2026-05-22 17:19:37');
INSERT INTO `import_receipts` VALUES (6, 1, NULL, 'completed', '2026-05-22 17:23:34');
INSERT INTO `import_receipts` VALUES (7, 1, NULL, 'completed', '2026-05-22 17:28:22');
INSERT INTO `import_receipts` VALUES (8, 1, NULL, 'completed', '2026-05-22 17:30:01');
INSERT INTO `import_receipts` VALUES (9, 1, NULL, 'completed', '2026-05-22 17:30:11');
INSERT INTO `import_receipts` VALUES (10, 1, NULL, 'completed', '2026-05-22 17:30:35');
INSERT INTO `import_receipts` VALUES (11, 1, NULL, 'completed', '2026-05-22 17:37:59');
INSERT INTO `import_receipts` VALUES (12, 1, NULL, 'completed', '2026-05-24 16:44:17');
INSERT INTO `import_receipts` VALUES (13, 1, NULL, 'completed', '2026-05-24 22:45:27');
INSERT INTO `import_receipts` VALUES (14, 1, NULL, 'completed', '2026-05-26 09:45:29');
INSERT INTO `import_receipts` VALUES (15, 1, NULL, 'completed', '2026-06-04 17:14:14');
INSERT INTO `import_receipts` VALUES (16, 1, NULL, 'completed', '2026-06-04 20:39:07');
INSERT INTO `import_receipts` VALUES (17, 1, NULL, 'completed', '2026-06-04 20:39:12');
INSERT INTO `import_receipts` VALUES (18, 1, NULL, 'completed', '2026-06-04 20:39:16');
INSERT INTO `import_receipts` VALUES (19, 1, NULL, 'completed', '2026-06-04 20:39:21');

-- ----------------------------
-- Table structure for inventory
-- ----------------------------
DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `variant_id` int NULL DEFAULT NULL,
  `quantity` int NOT NULL DEFAULT 0,
  `last_updated` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `product_id`(`product_id` ASC, `variant_id` ASC) USING BTREE,
  INDEX `variant_id`(`variant_id` ASC) USING BTREE,
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`variant_id`) REFERENCES `product_variants` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of inventory
-- ----------------------------
INSERT INTO `inventory` VALUES (1, 406, 7, 1721, '2026-06-04 20:29:54');
INSERT INTO `inventory` VALUES (12, 406, 8, 95, '2026-06-04 20:32:20');
INSERT INTO `inventory` VALUES (15, 408, 11, 122, '2026-05-24 22:45:27');
INSERT INTO `inventory` VALUES (16, 409, 13, 99, '2026-06-04 17:46:51');
INSERT INTO `inventory` VALUES (17, 408, 12, 1000, '2026-06-04 17:14:14');
INSERT INTO `inventory` VALUES (18, 1, 14, 200, '2026-06-04 20:39:07');
INSERT INTO `inventory` VALUES (19, 1, 15, 200, '2026-06-04 20:39:12');
INSERT INTO `inventory` VALUES (20, 1, 16, 200, '2026-06-04 20:39:16');
INSERT INTO `inventory` VALUES (21, 1, 17, 200, '2026-06-04 20:39:21');

-- ----------------------------
-- Table structure for notification
-- ----------------------------
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_read` tinyint(1) NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_user_read`(`user_id` ASC, `is_read` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notification
-- ----------------------------
INSERT INTO `notification` VALUES (1, 4, 'Đơn hàng #12 của bạn đã được xác nhận.', 1, '2026-05-29 14:30:12');
INSERT INTO `notification` VALUES (2, 4, 'Đơn hàng #16 đã được giao thành công!', 1, '2026-05-29 14:34:43');
INSERT INTO `notification` VALUES (3, 4, 'Đơn hàng #22 của bạn đã được xác nhận.', 1, '2026-06-04 20:41:07');
INSERT INTO `notification` VALUES (4, 4, 'Đơn hàng #21 của bạn đã được xác nhận.', 1, '2026-06-04 20:41:08');
INSERT INTO `notification` VALUES (5, 4, 'Đơn hàng #20 của bạn đã được xác nhận.', 1, '2026-06-04 20:41:09');
INSERT INTO `notification` VALUES (6, 4, 'Đơn hàng #19 của bạn đã được xác nhận.', 1, '2026-06-04 20:41:11');
INSERT INTO `notification` VALUES (7, 4, 'Đơn hàng #18 của bạn đã được xác nhận.', 1, '2026-06-04 20:41:12');
INSERT INTO `notification` VALUES (8, 4, 'Đơn hàng #19 đã được giao thành công!', 1, '2026-06-04 20:41:12');
INSERT INTO `notification` VALUES (9, 4, 'Đơn hàng #20 đã được giao thành công!', 1, '2026-06-04 20:41:13');
INSERT INTO `notification` VALUES (10, 4, 'Đơn hàng #21 đã được giao thành công!', 1, '2026-06-04 20:41:14');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `order_date` datetime NULL DEFAULT current_timestamp(),
  `total_price` decimal(18, 2) NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `payment_method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `payment_status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `order_status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  `updated_at` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `shipping_fee` double UNSIGNED NULL DEFAULT NULL,
  `inventory_deducted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0=chưa trừ kho, 1=đã trừ kho',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (1, 1, '2026-03-29 22:49:42', 34643000.00, 'anh - SĐT: 0987654321 - Địa chỉ: Ho Chi Minh City, Ho Chi Minh city, Thu Duc', 'COD', 'chưa thanh toán', 'Đang xử lý', '2026-03-29 22:49:42', NULL, NULL, 0);
INSERT INTO `order` VALUES (2, 1, '2026-03-29 22:50:01', 34643000.00, 'anh - SĐT: 0987654321 - Địa chỉ: Ho Chi Minh City, Ho Chi Minh city, Thu Duc', 'COD', 'chưa thanh toán', 'Đang xử lý', '2026-03-29 22:50:01', NULL, NULL, 0);
INSERT INTO `order` VALUES (3, 1, '2026-03-29 22:51:11', 138572000.00, 'anh - SĐT: 0987654321 - Địa chỉ: Ho Chi Minh City, Ho Chi Minh city, Thu Duc', 'COD', 'chưa thanh toán', 'CANCELLED', '2026-03-29 22:51:11', '2026-03-30 09:54:58', NULL, 0);
INSERT INTO `order` VALUES (4, 3, '2026-03-30 10:03:14', 34643000.00, 'anh2 - SĐT: 0987654321 - Địa chỉ: Ho Chi Minh City, Ho Chi Minh city, Thu Duc', 'COD', 'chưa thanh toán', 'Đang xử lý', '2026-03-30 10:03:14', NULL, NULL, 0);
INSERT INTO `order` VALUES (5, 1, '2026-03-30 10:07:42', 34643000.00, 'anh - SĐT: 0987654321 - Địa chỉ: Ho Chi Minh City, Ho Chi Minh city, Thu Duc', 'COD', 'chưa thanh toán', 'Đang xử lý', '2026-03-30 10:07:42', NULL, NULL, 0);
INSERT INTO `order` VALUES (6, 1, '2026-03-30 10:07:53', 118323000.00, 'anh - SĐT: 0987654321 - Địa chỉ: Ho Chi Minh City, Ho Chi Minh city, Thu Duc', 'COD', 'chưa thanh toán', 'Đang xử lý', '2026-03-30 10:07:53', NULL, NULL, 0);
INSERT INTO `order` VALUES (7, 1, '2026-03-30 10:09:57', 127738000.00, 'anh - SĐT: 0987654321 - Địa chỉ: Ho Chi Minh City, Ho Chi Minh city, Thu Duc', 'COD', 'chưa thanh toán', 'Đang xử lý', '2026-03-30 10:09:57', NULL, NULL, 0);
INSERT INTO `order` VALUES (8, 1, '2026-03-30 10:16:47', 34643000.00, 'anh - SĐT: 0987654321 - Địa chỉ: Ho Chi Minh City, Ho Chi Minh city, Thu Duc', 'COD', 'chưa thanh toán', 'Đang xử lý', '2026-03-30 10:16:47', NULL, NULL, 0);
INSERT INTO `order` VALUES (9, 1, '2026-05-26 20:15:43', 424326000.00, 'anh - SĐT: 123456789 - Địa chỉ: Ho Chi Minh City, Ho Chi Minh city, Thu Duc', 'VNPAY', 'chưa thanh toán', 'Đang xử lý', '2026-05-26 20:15:43', NULL, NULL, 0);
INSERT INTO `order` VALUES (10, 1, '2026-05-26 20:16:23', 141442000.00, 'anh - SĐT: 123456789 - Địa chỉ: Ho Chi Minh City, Ho Chi Minh city, Thu Duc', 'COD', 'chưa thanh toán', 'Đang xử lý', '2026-05-26 20:16:23', NULL, NULL, 0);
INSERT INTO `order` VALUES (11, 4, '2026-05-27 20:47:55', 34643000.00, 'huy - SĐT: 0112233445 - Địa chỉ: 120 yên lãng, Xã Cẩm La, Thị xã Quảng Yên, Tỉnh Quảng Ninh', 'VNPAY', 'chưa thanh toán', 'Đã huỷ (Tôi tìm thấy chỗ khác giá rẻ hơn)', '2026-05-27 20:47:55', '2026-05-29 09:32:10', NULL, 0);
INSERT INTO `order` VALUES (12, 4, '2026-05-27 20:52:31', 144664000.00, 'huy - SĐT: 0112233445 - Địa chỉ: 120 yên lãng, Xã Cẩm La, Thị xã Quảng Yên, Tỉnh Quảng Ninh', 'VNPAY', 'chưa thanh toán', 'Đang xử lý', '2026-05-27 20:52:31', NULL, NULL, 0);
INSERT INTO `order` VALUES (13, 4, '2026-05-27 21:07:09', 144664000.00, 'huy - SĐT: 0112233445 - Địa chỉ: 120 yên lãng, Xã Cẩm La, Thị xã Quảng Yên, Tỉnh Quảng Ninh', 'VNPAY', 'chưa thanh toán', 'CONFIRMED', '2026-05-27 21:07:09', '2026-05-27 21:08:01', NULL, 0);
INSERT INTO `order` VALUES (14, 4, '2026-05-27 21:11:38', 34643000.00, 'huy - SĐT: 0112233445 - Địa chỉ: 120 yên lãng, Xã Cẩm La, Thị xã Quảng Yên, Tỉnh Quảng Ninh', 'COD', 'chưa thanh toán', 'Đang xử lý', '2026-05-27 21:11:38', NULL, NULL, 0);
INSERT INTO `order` VALUES (15, 4, '2026-05-27 21:11:44', 144664000.00, 'huy - SĐT: 0112233445 - Địa chỉ: 120 yên lãng, Xã Cẩm La, Thị xã Quảng Yên, Tỉnh Quảng Ninh', 'VNPAY', 'chưa thanh toán', 'CONFIRMED', '2026-05-27 21:11:44', '2026-05-27 21:13:22', NULL, 0);
INSERT INTO `order` VALUES (16, 4, '2026-05-27 21:14:02', 144664000.00, 'huy - SĐT: 0112233445 - Địa chỉ: 120 yên lãng, Xã Cẩm La, Thị xã Quảng Yên, Tỉnh Quảng Ninh', 'VNPAY', 'chưa thanh toán', 'SHIPPING', '2026-05-27 21:14:02', '2026-05-29 09:32:38', NULL, 0);
INSERT INTO `order` VALUES (17, 4, '2026-05-27 22:16:01', 127738000.00, 'huy - SĐT: 0112233445 - Địa chỉ: 120 yên lãng, Xã Cẩm La, Thị xã Quảng Yên, Tỉnh Quảng Ninh', 'COD', 'chưa thanh toán', 'Đang xử lý', '2026-05-27 22:16:01', NULL, 0, 0);
INSERT INTO `order` VALUES (18, 4, '2026-05-28 15:34:44', 141442000.00, 'huy - SĐT: 0112233445 - Địa chỉ: 120 yên lãng, Xã Cẩm La, Thị xã Quảng Yên, Tỉnh Quảng Ninh', 'COD', 'chưa thanh toán', 'Đang xử lý', '2026-05-28 15:34:44', NULL, 0, 0);
INSERT INTO `order` VALUES (19, 4, '2026-05-28 15:49:54', 141442000.00, 'huy - SĐT: 0112233445 - Địa chỉ: 120 yên lãng, Xã Cẩm La, Thị xã Quảng Yên, Tỉnh Quảng Ninh', 'COD', 'chưa thanh toán', 'Đang xử lý', '2026-05-28 15:49:54', NULL, 0, 0);
INSERT INTO `order` VALUES (20, 4, '2026-05-28 16:03:49', 101000001.00, 'huy - SĐT: 0112233445 - Địa chỉ: 120 yên lãng, Phường Phạm Ngũ Lão, Quận 1, Hồ Chí Minh', 'VNPAY', 'chưa thanh toán', 'Đang xử lý', '2026-05-28 16:03:49', NULL, 21001, 0);
INSERT INTO `order` VALUES (21, 1, '2026-06-04 17:15:28', 100001.00, 'anh - SĐT: 123456789 - Địa chỉ: Ho Chi Minh City, Ho Chi Minh city, Thu Duc', 'COD', 'chưa thanh toán', 'Đang xử lý', '2026-06-04 17:15:28', NULL, 0, 0);
INSERT INTO `order` VALUES (22, 1, '2026-06-04 17:46:38', 120000.00, 'anh - SĐT: 123456789 - Địa chỉ: Ho Chi Minh City, Ho Chi Minh city, Thu Duc', 'COD', 'chưa thanh toán', 'CONFIRMED', '2026-06-04 17:46:38', '2026-06-04 17:46:51', 0, 1);
INSERT INTO `order` VALUES (23, 1, '2026-06-04 20:29:22', 3400000.00, 'anh - SĐT: 123456789 - Địa chỉ: Ho Chi Minh City, Ho Chi Minh city, Thu Duc', 'COD', 'chưa thanh toán', 'DELIVERED', '2026-06-04 20:29:22', '2026-06-04 20:30:06', 0, 1);
INSERT INTO `order` VALUES (24, 1, '2026-06-04 20:31:28', 9000000.00, 'anh - SĐT: 123456789 - Địa chỉ: Ho Chi Minh City, Ho Chi Minh city, Thu Duc', 'COD', 'chưa thanh toán', 'CONFIRMED', '2026-06-04 20:31:28', '2026-06-04 20:32:20', 0, 1);

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `variant_id` int NULL DEFAULT NULL,
  `quantity` int NOT NULL,
  `price` decimal(18, 2) NULL DEFAULT NULL,
  `total_price` decimal(18, 2) NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  `updated_at` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order_item_variant`(`variant_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_item
-- ----------------------------
INSERT INTO `order_item` VALUES (1, 1, 30, NULL, 1, 34643000.00, 34643000.00, '2026-03-29 22:49:42', NULL);
INSERT INTO `order_item` VALUES (2, 2, 30, NULL, 1, 34643000.00, 34643000.00, '2026-03-29 22:50:01', NULL);
INSERT INTO `order_item` VALUES (3, 3, 30, NULL, 4, 34643000.00, 138572000.00, '2026-03-29 22:51:11', NULL);
INSERT INTO `order_item` VALUES (4, 4, 30, NULL, 1, 34643000.00, 34643000.00, '2026-03-30 10:03:14', NULL);
INSERT INTO `order_item` VALUES (5, 5, 30, NULL, 1, 34643000.00, 34643000.00, '2026-03-30 10:07:42', NULL);
INSERT INTO `order_item` VALUES (6, 6, 6, NULL, 1, 118323000.00, 118323000.00, '2026-03-30 10:07:53', NULL);
INSERT INTO `order_item` VALUES (7, 7, 72, NULL, 1, 127738000.00, 127738000.00, '2026-03-30 10:09:57', NULL);
INSERT INTO `order_item` VALUES (8, 8, 30, NULL, 1, 34643000.00, 34643000.00, '2026-03-30 10:16:47', NULL);
INSERT INTO `order_item` VALUES (9, 9, 24, NULL, 3, 141442000.00, 424326000.00, '2026-05-26 20:15:43', NULL);
INSERT INTO `order_item` VALUES (10, 10, 24, NULL, 1, 141442000.00, 141442000.00, '2026-05-26 20:16:23', NULL);
INSERT INTO `order_item` VALUES (11, 11, 30, NULL, 1, 34643000.00, 34643000.00, '2026-05-27 20:47:55', NULL);
INSERT INTO `order_item` VALUES (12, 12, 34, NULL, 1, 144664000.00, 144664000.00, '2026-05-27 20:52:31', NULL);
INSERT INTO `order_item` VALUES (13, 13, 34, NULL, 1, 144664000.00, 144664000.00, '2026-05-27 21:07:09', NULL);
INSERT INTO `order_item` VALUES (14, 14, 30, NULL, 1, 34643000.00, 34643000.00, '2026-05-27 21:11:38', NULL);
INSERT INTO `order_item` VALUES (15, 15, 34, NULL, 1, 144664000.00, 144664000.00, '2026-05-27 21:11:44', NULL);
INSERT INTO `order_item` VALUES (16, 16, 34, NULL, 1, 144664000.00, 144664000.00, '2026-05-27 21:14:02', NULL);
INSERT INTO `order_item` VALUES (17, 17, 72, NULL, 1, 127738000.00, 127738000.00, '2026-05-27 22:16:01', NULL);
INSERT INTO `order_item` VALUES (18, 18, 24, NULL, 1, 141442000.00, 141442000.00, '2026-05-28 15:34:44', NULL);
INSERT INTO `order_item` VALUES (19, 19, 24, NULL, 1, 141442000.00, 141442000.00, '2026-05-28 15:49:54', NULL);
INSERT INTO `order_item` VALUES (20, 20, 35, NULL, 1, 100979000.00, 100979000.00, '2026-05-28 16:03:49', NULL);
INSERT INTO `order_item` VALUES (21, 21, 408, 12, 1, 100001.00, 100001.00, '2026-06-04 17:15:28', NULL);
INSERT INTO `order_item` VALUES (22, 22, 409, 13, 1, 120000.00, 120000.00, '2026-06-04 17:46:38', NULL);
INSERT INTO `order_item` VALUES (23, 23, 406, 7, 2, 1700000.00, 3400000.00, '2026-06-04 20:29:22', NULL);
INSERT INTO `order_item` VALUES (24, 24, 406, 8, 5, 1800000.00, 9000000.00, '2026-06-04 20:31:28', NULL);

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(15, 2) NOT NULL,
  `final_price` decimal(15, 2) NULL DEFAULT NULL,
  `discount_percent` float NULL DEFAULT NULL,
  `discount_updated_at` datetime NULL DEFAULT NULL,
  `brand_id` int NULL DEFAULT NULL,
  `category_id` int NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `ratio` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `size` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `material` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `origin` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  `updated_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_product_brand`(`brand_id` ASC) USING BTREE,
  INDEX `fk_product_category`(`category_id` ASC) USING BTREE,
  CONSTRAINT `fk_product_brand` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 410 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (1, 'Subaru Camry 2022', 78323000.00, 78323000.00, 0, '2024-10-28 00:00:00', 16, 7, 'Subaru Camry 2022 is a reliable and high-performance vehicle.', '21:9', 'Large', 'Aluminum', 'Germany', 0, '2024-10-28 19:46:00', '2026-06-04 20:38:40');
INSERT INTO `product` VALUES (2, 'Mitsubishi Land Cruiser 2021', 51832000.00, 51832000.00, 0, '2024-02-11 00:00:00', 12, 4, 'Mitsubishi Land Cruiser 2021 is a reliable and high-performance vehicle.', '4:3', 'Compact', 'Steel', 'UK', 0, '2024-02-11 22:54:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (3, 'BMW Accord 2025', 64118000.00, 64118000.00, 0, '2023-11-24 00:00:00', 5, 5, 'BMW Accord 2025 is a reliable and high-performance vehicle.', '16:9', 'Compact', 'Carbon Fiber', 'UK', 0, '2023-11-24 02:54:00', '2026-06-04 20:35:23');
INSERT INTO `product` VALUES (4, 'Volkswagen E-Class 2024', 22842000.00, 22842000.00, 0, '2022-02-24 00:00:00', 13, 2, 'Volkswagen E-Class 2024 is a reliable and high-performance vehicle.', '1:1', 'Full-size', 'Aluminum', 'Germany', 0, '2022-02-24 19:03:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (5, 'Ford Q7 2020', 88190000.00, 88190000.00, 0, '2024-07-09 00:00:00', 3, 8, 'Ford Q7 2020 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Steel', 'UK', 0, '2024-07-09 03:09:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (6, 'Nissan Q5 2018', 118323000.00, 118323000.00, 0, '2024-01-19 00:00:00', 11, 1, 'Nissan Q5 2018 is a reliable and high-performance vehicle.', '1:1', 'Mini', 'Steel', 'Japan', 0, '2024-01-19 03:55:00', '2026-06-04 20:35:28');
INSERT INTO `product` VALUES (7, 'Mazda XC60 2021', 89033000.00, 89033000.00, 0, '2022-06-21 00:00:00', 10, 3, 'Mazda XC60 2021 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Carbon Fiber', 'UK', 0, '2022-06-21 08:36:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (8, 'Hyundai Taycan 2023', 69778000.00, 69778000.00, 0, '2022-11-12 00:00:00', 8, 10, 'Hyundai Taycan 2023 is a reliable and high-performance vehicle.', '1:1', 'Compact', 'Alloy', 'Japan', 0, '2022-11-12 02:22:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (9, 'Chevrolet Ranger 2018', 115726000.00, 115726000.00, 0, '2023-12-31 00:00:00', 4, 4, 'Chevrolet Ranger 2018 is a reliable and high-performance vehicle.', '1:1', 'Mid-size', 'Steel', 'Germany', 0, '2023-12-31 02:31:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (10, 'Mitsubishi Tucson 2019', 115681000.00, 115681000.00, 0, '2022-11-30 00:00:00', 12, 4, 'Mitsubishi Tucson 2019 is a reliable and high-performance vehicle.', '1:1', 'Compact', 'Composite', 'Sweden', 0, '2022-11-30 10:20:00', '2026-06-04 20:35:31');
INSERT INTO `product` VALUES (11, 'Kia Passat 2019', 113299000.00, 113299000.00, 0, '2024-09-07 00:00:00', 9, 3, 'Kia Passat 2019 is a reliable and high-performance vehicle.', '4:3', 'Full-size', 'Composite', 'Italy', 0, '2024-09-07 01:23:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (12, 'Ford Tucson 2023', 148620000.00, 148620000.00, 0, '2022-08-08 00:00:00', 3, 3, 'Ford Tucson 2023 is a reliable and high-performance vehicle.', '21:9', 'Large', 'Steel', 'Germany', 0, '2022-08-08 12:11:00', '2026-06-04 20:35:35');
INSERT INTO `product` VALUES (13, 'Toyota Taycan 2024', 80405000.00, 80405000.00, 0, '2023-11-22 00:00:00', 1, 3, 'Toyota Taycan 2024 is a reliable and high-performance vehicle.', '21:9', 'Large', 'Steel', 'USA', 0, '2023-11-22 03:43:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (14, 'BMW Tucson 2019', 94294000.00, 94294000.00, 0, '2023-05-01 00:00:00', 5, 10, 'BMW Tucson 2019 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Composite', 'USA', 0, '2023-05-01 20:45:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (15, 'Land Rover CX-8 2018', 45051000.00, 45051000.00, 0, '2022-04-09 00:00:00', 18, 8, 'Land Rover CX-8 2018 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Carbon Fiber', 'USA', 0, '2022-04-09 17:59:00', '2026-06-04 20:35:37');
INSERT INTO `product` VALUES (16, 'Honda Corolla 2023', 33579000.00, 33579000.00, 0, '2024-06-01 00:00:00', 2, 3, 'Honda Corolla 2023 is a reliable and high-performance vehicle.', '4:3', 'Mid-size', 'Composite', 'USA', 0, '2024-06-01 12:52:00', '2026-06-04 20:35:38');
INSERT INTO `product` VALUES (17, 'Subaru Mustang 2021', 78418000.00, 78418000.00, 0, '2023-03-06 00:00:00', 16, 6, 'Subaru Mustang 2021 is a reliable and high-performance vehicle.', '1:1', 'Mid-size', 'Steel', 'USA', 0, '2023-03-06 14:16:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (18, 'Kia Civic 2022', 28982000.00, 28982000.00, 0, '2023-03-02 00:00:00', 9, 8, 'Kia Civic 2022 is a reliable and high-performance vehicle.', '16:9', 'Compact', 'Composite', 'South Korea', 0, '2023-03-02 00:42:00', '2026-06-04 20:35:39');
INSERT INTO `product` VALUES (19, 'Jeep Santa Fe 2025', 61450000.00, 61450000.00, 0, '2023-02-10 00:00:00', 19, 7, 'Jeep Santa Fe 2025 is a reliable and high-performance vehicle.', '16:9', 'Compact', 'Composite', 'Germany', 0, '2023-02-10 20:23:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (20, 'Toyota Q5 2019', 62706000.00, 62706000.00, 0, '2022-08-31 00:00:00', 1, 8, 'Toyota Q5 2019 is a reliable and high-performance vehicle.', '21:9', 'Mini', 'Carbon Fiber', 'Italy', 0, '2022-08-31 09:49:00', '2026-06-04 20:35:41');
INSERT INTO `product` VALUES (21, 'Mercedes-Benz A4 2019', 129498000.00, 129498000.00, 0, '2023-01-24 00:00:00', 6, 6, 'Mercedes-Benz A4 2019 is a reliable and high-performance vehicle.', '16:9', 'Mid-size', 'Steel', 'France', 0, '2023-01-24 03:38:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (22, 'Jeep A6 2019', 123760000.00, 123760000.00, 0, '2022-08-04 00:00:00', 19, 4, 'Jeep A6 2019 is a reliable and high-performance vehicle.', '4:3', 'Mini', 'Carbon Fiber', 'Japan', 0, '2022-08-04 07:16:00', '2026-06-04 20:35:47');
INSERT INTO `product` VALUES (23, 'Mercedes-Benz XC90 2018', 94246000.00, 94246000.00, 0, '2024-07-04 00:00:00', 6, 3, 'Mercedes-Benz XC90 2018 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Composite', 'South Korea', 0, '2024-07-04 01:53:00', '2026-06-04 20:35:48');
INSERT INTO `product` VALUES (24, 'Toyota CX-8 2024', 141442000.00, 141442000.00, 0, '2024-12-30 00:00:00', 1, 7, 'Toyota CX-8 2024 is a reliable and high-performance vehicle.', '1:1', 'Mid-size', 'Alloy', 'Japan', 0, '2024-12-30 08:01:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (25, 'Volkswagen Altima 2025', 39987000.00, 39987000.00, 0, '2022-05-03 00:00:00', 13, 4, 'Volkswagen Altima 2025 is a reliable and high-performance vehicle.', '16:9', 'Mid-size', 'Carbon Fiber', 'Germany', 0, '2022-05-03 07:33:00', '2026-06-04 20:35:51');
INSERT INTO `product` VALUES (26, 'Mazda F-150 2023', 113733000.00, 113733000.00, 0, '2024-09-05 00:00:00', 10, 4, 'Mazda F-150 2023 is a reliable and high-performance vehicle.', '21:9', 'Full-size', 'Aluminum', 'France', 0, '2024-09-05 11:16:00', '2026-06-04 20:35:52');
INSERT INTO `product` VALUES (27, 'Chevrolet Model S 2019', 102282000.00, 102282000.00, 0, '2022-05-18 00:00:00', 4, 9, 'Chevrolet Model S 2019 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Composite', 'South Korea', 0, '2022-05-18 08:30:00', '2026-06-04 20:35:54');
INSERT INTO `product` VALUES (28, 'Peugeot Defender 2020', 65484000.00, 65484000.00, 0, '2023-01-28 00:00:00', 20, 7, 'Peugeot Defender 2020 is a reliable and high-performance vehicle.', '16:9', 'Compact', 'Steel', 'France', 0, '2023-01-28 22:54:00', '2026-06-04 20:35:59');
INSERT INTO `product` VALUES (29, 'Audi CX-8 2020', 31667000.00, 31667000.00, 0, '2024-04-09 00:00:00', 7, 6, 'Audi CX-8 2020 is a reliable and high-performance vehicle.', '21:9', 'Full-size', 'Steel', 'Germany', 0, '2024-04-09 18:40:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (30, 'Mercedes-Benz Model S 2019', 34643000.00, 34643000.00, 0, '2023-12-30 00:00:00', 6, 1, 'Mercedes-Benz Model S 2019 is a reliable and high-performance vehicle.', '1:1', 'Mini', 'Steel', 'USA', 0, '2023-12-30 13:32:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (31, 'Ford Model S 2020', 97592000.00, 97592000.00, 0, '2024-09-30 00:00:00', 3, 3, 'Ford Model S 2020 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Steel', 'Italy', 0, '2024-09-30 22:49:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (32, 'Peugeot C-Class 2022', 132826000.00, 132826000.00, 0, '2022-12-29 00:00:00', 20, 8, 'Peugeot C-Class 2022 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Aluminum', 'Sweden', 0, '2022-12-29 07:25:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (33, 'Hyundai Hilux 2019', 122885000.00, 122885000.00, 0, '2023-09-20 00:00:00', 8, 10, 'Hyundai Hilux 2019 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Carbon Fiber', 'Italy', 0, '2023-09-20 02:14:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (34, 'Peugeot Land Cruiser 2019', 144664000.00, 144664000.00, 0, '2024-04-23 00:00:00', 20, 1, 'Peugeot Land Cruiser 2019 is a reliable and high-performance vehicle.', '4:3', 'Large', 'Aluminum', 'Italy', 0, '2024-04-23 21:00:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (35, 'Toyota C-Class 2023', 100979000.00, 100979000.00, 0, '2024-04-25 00:00:00', 1, 2, 'Toyota C-Class 2023 is a reliable and high-performance vehicle.', '16:9', 'Full-size', 'Carbon Fiber', 'Sweden', 0, '2024-04-25 22:01:00', '2026-06-04 20:36:01');
INSERT INTO `product` VALUES (36, 'Audi A4 2023', 84055000.00, 84055000.00, 0, '2023-04-19 00:00:00', 7, 9, 'Audi A4 2023 is a reliable and high-performance vehicle.', '4:3', 'Compact', 'Carbon Fiber', 'South Korea', 0, '2023-04-19 07:48:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (37, 'Land Rover Tucson 2025', 145372000.00, 145372000.00, 0, '2024-11-05 00:00:00', 18, 7, 'Land Rover Tucson 2025 is a reliable and high-performance vehicle.', '4:3', 'Mid-size', 'Alloy', 'Sweden', 0, '2024-11-05 00:40:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (38, 'Land Rover Sorento 2022', 128417000.00, 128417000.00, 0, '2024-07-15 00:00:00', 18, 5, 'Land Rover Sorento 2022 is a reliable and high-performance vehicle.', '21:9', 'Mid-size', 'Composite', 'Italy', 0, '2024-07-15 16:39:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (39, 'Toyota Tucson 2022', 131246000.00, 131246000.00, 0, '2022-06-20 00:00:00', 1, 4, 'Toyota Tucson 2022 is a reliable and high-performance vehicle.', '1:1', 'Mid-size', 'Steel', 'Sweden', 0, '2022-06-20 14:52:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (40, 'Nissan Rio 2018', 47771000.00, 47771000.00, 0, '2023-10-03 00:00:00', 11, 10, 'Nissan Rio 2018 is a reliable and high-performance vehicle.', '4:3', 'Mid-size', 'Carbon Fiber', 'Japan', 1, '2023-10-03 21:43:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (41, 'Volkswagen Hilux 2021', 139671000.00, 139671000.00, 0, '2022-11-28 00:00:00', 13, 9, 'Volkswagen Hilux 2021 is a reliable and high-performance vehicle.', '4:3', 'Mid-size', 'Carbon Fiber', 'USA', 0, '2022-11-28 04:23:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (42, 'Audi XC90 2020', 127425000.00, 127425000.00, 0, '2023-07-26 00:00:00', 7, 8, 'Audi XC90 2020 is a reliable and high-performance vehicle.', '21:9', 'Mini', 'Steel', 'South Korea', 0, '2023-07-26 04:51:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (43, 'Honda Model S 2024', 130561000.00, 130561000.00, 0, '2022-04-26 00:00:00', 2, 8, 'Honda Model S 2024 is a reliable and high-performance vehicle.', '4:3', 'Mid-size', 'Carbon Fiber', 'USA', 1, '2022-04-26 18:40:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (44, 'BMW Model S 2024', 33252000.00, 33252000.00, 0, '2022-08-08 00:00:00', 5, 6, 'BMW Model S 2024 is a reliable and high-performance vehicle.', '16:9', 'Mid-size', 'Aluminum', 'Japan', 0, '2022-08-08 20:45:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (45, 'Porsche Cherokee 2024', 28252000.00, 28252000.00, 0, '2023-09-30 00:00:00', 14, 7, 'Porsche Cherokee 2024 is a reliable and high-performance vehicle.', '1:1', 'Mini', 'Composite', 'USA', 1, '2023-09-30 13:51:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (46, 'Jeep Defender 2024', 53105000.00, 53105000.00, 0, '2022-06-12 00:00:00', 19, 9, 'Jeep Defender 2024 is a reliable and high-performance vehicle.', '1:1', 'Mid-size', 'Alloy', 'France', 0, '2022-06-12 01:54:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (47, 'Mercedes-Benz Explorer 2025', 53424000.00, 53424000.00, 0, '2023-02-23 00:00:00', 6, 4, 'Mercedes-Benz Explorer 2025 is a reliable and high-performance vehicle.', '4:3', 'Full-size', 'Alloy', 'France', 0, '2023-02-23 04:13:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (48, 'Hyundai A6 2022', 49647000.00, 49647000.00, 0, '2022-05-15 00:00:00', 8, 2, 'Hyundai A6 2022 is a reliable and high-performance vehicle.', '1:1', 'Mini', 'Aluminum', 'UK', 1, '2022-05-15 17:08:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (49, 'Volkswagen X3 2020', 28471000.00, 28471000.00, 0, '2023-03-09 00:00:00', 13, 1, 'Volkswagen X3 2020 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Carbon Fiber', 'Italy', 0, '2023-03-09 14:37:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (50, 'Toyota Accord 2021', 50624000.00, 50624000.00, 0, '2024-06-16 00:00:00', 1, 9, 'Toyota Accord 2021 is a reliable and high-performance vehicle.', '4:3', 'Mid-size', 'Composite', 'Sweden', 0, '2024-06-16 03:27:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (51, 'Porsche Model 3 2019', 144394000.00, 144394000.00, 0, '2022-04-04 00:00:00', 14, 4, 'Porsche Model 3 2019 is a reliable and high-performance vehicle.', '16:9', 'Mid-size', 'Steel', 'South Korea', 1, '2022-04-04 23:15:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (52, 'Chevrolet Civic 2023', 76083000.00, 76083000.00, 0, '2022-01-12 00:00:00', 4, 6, 'Chevrolet Civic 2023 is a reliable and high-performance vehicle.', '21:9', 'Large', 'Composite', 'Italy', 1, '2022-01-12 17:26:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (53, 'Honda Defender 2020', 108091000.00, 108091000.00, 0, '2024-07-30 00:00:00', 2, 4, 'Honda Defender 2020 is a reliable and high-performance vehicle.', '21:9', 'Large', 'Alloy', 'Sweden', 1, '2024-07-30 14:46:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (54, 'Mitsubishi X3 2019', 113174000.00, 113174000.00, 0, '2022-07-27 00:00:00', 12, 9, 'Mitsubishi X3 2019 is a reliable and high-performance vehicle.', '16:9', 'Large', 'Carbon Fiber', 'USA', 0, '2022-07-27 12:15:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (55, 'Subaru A6 2018', 83254000.00, 83254000.00, 0, '2023-05-10 00:00:00', 16, 2, 'Subaru A6 2018 is a reliable and high-performance vehicle.', '4:3', 'Full-size', 'Steel', 'Germany', 1, '2023-05-10 12:14:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (56, 'Jeep Cherokee 2023', 73919000.00, 73919000.00, 0, '2022-10-06 00:00:00', 19, 4, 'Jeep Cherokee 2023 is a reliable and high-performance vehicle.', '21:9', 'Mini', 'Carbon Fiber', 'UK', 1, '2022-10-06 01:12:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (57, 'Jeep Santa Fe 2022', 77491000.00, 77491000.00, 0, '2023-06-23 00:00:00', 19, 3, 'Jeep Santa Fe 2022 is a reliable and high-performance vehicle.', '4:3', 'Mini', 'Steel', 'UK', 0, '2023-06-23 23:43:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (58, 'Mazda F-150 2024', 131449000.00, 131449000.00, 0, '2022-06-16 00:00:00', 10, 9, 'Mazda F-150 2024 is a reliable and high-performance vehicle.', '16:9', 'Large', 'Alloy', 'Sweden', 1, '2022-06-16 13:37:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (59, 'Nissan Santa Fe 2020', 113563000.00, 113563000.00, 0, '2024-03-30 00:00:00', 11, 6, 'Nissan Santa Fe 2020 is a reliable and high-performance vehicle.', '21:9', 'Mid-size', 'Composite', 'South Korea', 0, '2024-03-30 19:17:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (60, 'Land Rover Corolla 2020', 37235000.00, 37235000.00, 0, '2022-05-10 00:00:00', 18, 4, 'Land Rover Corolla 2020 is a reliable and high-performance vehicle.', '21:9', 'Large', 'Steel', 'South Korea', 1, '2022-05-10 15:00:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (61, 'Mercedes-Benz Wrangler 2019', 39130000.00, 39130000.00, 0, '2023-08-03 00:00:00', 6, 6, 'Mercedes-Benz Wrangler 2019 is a reliable and high-performance vehicle.', '1:1', 'Compact', 'Steel', 'Germany', 0, '2023-08-03 04:38:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (62, 'Mercedes-Benz XC90 2019', 129058000.00, 129058000.00, 0, '2024-01-18 00:00:00', 6, 6, 'Mercedes-Benz XC90 2019 is a reliable and high-performance vehicle.', '4:3', 'Compact', 'Carbon Fiber', 'Italy', 1, '2024-01-18 07:45:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (63, 'Mitsubishi Explorer 2023', 120441000.00, 120441000.00, 0, '2024-06-21 00:00:00', 12, 6, 'Mitsubishi Explorer 2023 is a reliable and high-performance vehicle.', '4:3', 'Mini', 'Aluminum', 'Sweden', 1, '2024-06-21 06:43:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (64, 'Volvo Q7 2018', 89228000.00, 89228000.00, 0, '2024-08-27 00:00:00', 17, 10, 'Volvo Q7 2018 is a reliable and high-performance vehicle.', '21:9', 'Large', 'Steel', 'Sweden', 1, '2024-08-27 18:56:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (65, 'Nissan Taycan 2021', 38863000.00, 38863000.00, 0, '2022-07-14 00:00:00', 11, 4, 'Nissan Taycan 2021 is a reliable and high-performance vehicle.', '1:1', 'Compact', 'Composite', 'Sweden', 0, '2022-07-14 21:39:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (66, 'Chevrolet Civic 2024', 115985000.00, 115985000.00, 0, '2024-08-23 00:00:00', 4, 9, 'Chevrolet Civic 2024 is a reliable and high-performance vehicle.', '21:9', 'Large', 'Composite', 'Japan', 1, '2024-08-23 10:15:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (67, 'Hyundai E-Class 2021', 147347000.00, 147347000.00, 0, '2024-10-14 00:00:00', 8, 3, 'Hyundai E-Class 2021 is a reliable and high-performance vehicle.', '21:9', 'Mini', 'Composite', 'France', 0, '2024-10-14 10:45:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (68, 'Audi Civic 2018', 141084000.00, 141084000.00, 0, '2022-03-28 00:00:00', 7, 10, 'Audi Civic 2018 is a reliable and high-performance vehicle.', '1:1', 'Mini', 'Composite', 'USA', 0, '2022-03-28 00:56:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (69, 'Peugeot Accord 2019', 116923000.00, 116923000.00, 0, '2024-10-01 00:00:00', 20, 1, 'Peugeot Accord 2019 is a reliable and high-performance vehicle.', '21:9', 'Full-size', 'Carbon Fiber', 'France', 1, '2024-10-01 06:45:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (70, 'Volkswagen Land Cruiser 2024', 44742000.00, 44742000.00, 0, '2024-08-10 00:00:00', 13, 5, 'Volkswagen Land Cruiser 2024 is a reliable and high-performance vehicle.', '16:9', 'Full-size', 'Carbon Fiber', 'Germany', 0, '2024-08-10 14:33:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (71, 'Mercedes-Benz Model S 2021', 20029000.00, 20029000.00, 0, '2023-02-02 00:00:00', 6, 3, 'Mercedes-Benz Model S 2021 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Composite', 'Sweden', 0, '2023-02-02 12:30:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (72, 'Kia Taycan 2021', 127738000.00, 127738000.00, 0, '2024-03-05 00:00:00', 9, 1, 'Kia Taycan 2021 is a reliable and high-performance vehicle.', '4:3', 'Full-size', 'Steel', 'Japan', 1, '2024-03-05 10:07:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (73, 'Nissan Civic 2024', 28112000.00, 28112000.00, 0, '2023-11-14 00:00:00', 11, 9, 'Nissan Civic 2024 is a reliable and high-performance vehicle.', '21:9', 'Mid-size', 'Aluminum', 'South Korea', 1, '2023-11-14 12:33:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (74, 'Volkswagen Ranger 2021', 131352000.00, 131352000.00, 0, '2023-10-08 00:00:00', 13, 8, 'Volkswagen Ranger 2021 is a reliable and high-performance vehicle.', '4:3', 'Mid-size', 'Aluminum', 'USA', 0, '2023-10-08 08:03:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (75, 'Jeep E-Class 2025', 90578000.00, 90578000.00, 0, '2024-04-06 00:00:00', 19, 1, 'Jeep E-Class 2025 is a reliable and high-performance vehicle.', '21:9', 'Mini', 'Steel', 'Japan', 1, '2024-04-06 23:41:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (76, 'Volvo C-Class 2025', 111259000.00, 111259000.00, 0, '2022-05-18 00:00:00', 17, 9, 'Volvo C-Class 2025 is a reliable and high-performance vehicle.', '21:9', 'Mid-size', 'Steel', 'USA', 1, '2022-05-18 08:33:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (77, 'Volkswagen Wrangler 2019', 60113000.00, 60113000.00, 0, '2024-08-09 00:00:00', 13, 4, 'Volkswagen Wrangler 2019 is a reliable and high-performance vehicle.', '16:9', 'Mid-size', 'Carbon Fiber', 'UK', 1, '2024-08-09 10:07:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (78, 'Chevrolet Explorer 2020', 145648000.00, 145648000.00, 0, '2024-10-03 00:00:00', 4, 10, 'Chevrolet Explorer 2020 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Alloy', 'Japan', 1, '2024-10-03 10:43:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (79, 'Mazda E-Class 2019', 25622000.00, 25622000.00, 0, '2023-05-26 00:00:00', 10, 10, 'Mazda E-Class 2019 is a reliable and high-performance vehicle.', '1:1', 'Mid-size', 'Composite', 'South Korea', 0, '2023-05-26 10:39:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (80, 'Ford Ranger 2024', 113736000.00, 113736000.00, 0, '2024-04-16 00:00:00', 3, 8, 'Ford Ranger 2024 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Steel', 'Germany', 1, '2024-04-16 15:01:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (81, 'BMW Land Cruiser 2025', 79356000.00, 79356000.00, 0, '2022-07-23 00:00:00', 5, 9, 'BMW Land Cruiser 2025 is a reliable and high-performance vehicle.', '1:1', 'Mini', 'Carbon Fiber', 'France', 0, '2022-07-23 05:46:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (82, 'Chevrolet Sorento 2022', 52102000.00, 52102000.00, 0, '2023-04-11 00:00:00', 4, 2, 'Chevrolet Sorento 2022 is a reliable and high-performance vehicle.', '4:3', 'Large', 'Aluminum', 'South Korea', 0, '2023-04-11 18:07:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (83, 'Mitsubishi C-Class 2020', 118218000.00, 118218000.00, 0, '2024-08-24 00:00:00', 12, 4, 'Mitsubishi C-Class 2020 is a reliable and high-performance vehicle.', '4:3', 'Large', 'Steel', 'Germany', 0, '2024-08-24 08:12:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (84, 'Volkswagen RX350 2024', 76010000.00, 76010000.00, 0, '2024-07-25 00:00:00', 13, 8, 'Volkswagen RX350 2024 is a reliable and high-performance vehicle.', '21:9', 'Mid-size', 'Carbon Fiber', 'UK', 0, '2024-07-25 21:55:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (85, 'Kia Accord 2025', 95811000.00, 95811000.00, 0, '2023-10-29 00:00:00', 9, 6, 'Kia Accord 2025 is a reliable and high-performance vehicle.', '1:1', 'Compact', 'Alloy', 'UK', 1, '2023-10-29 17:12:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (86, 'Audi Outlander 2018', 106795000.00, 106795000.00, 0, '2024-11-17 00:00:00', 7, 6, 'Audi Outlander 2018 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Carbon Fiber', 'Germany', 1, '2024-11-17 20:35:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (87, 'Land Rover Corolla 2018', 75096000.00, 75096000.00, 0, '2022-02-28 00:00:00', 18, 5, 'Land Rover Corolla 2018 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Aluminum', 'USA', 1, '2022-02-28 17:46:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (88, 'Subaru Tucson 2025', 29908000.00, 29908000.00, 0, '2022-06-22 00:00:00', 16, 6, 'Subaru Tucson 2025 is a reliable and high-performance vehicle.', '21:9', 'Full-size', 'Composite', 'Sweden', 1, '2022-06-22 09:10:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (89, 'Honda X5 2021', 56696000.00, 56696000.00, 0, '2023-01-20 00:00:00', 2, 4, 'Honda X5 2021 is a reliable and high-performance vehicle.', '16:9', 'Large', 'Composite', 'Germany', 0, '2023-01-20 19:45:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (90, 'Chevrolet RX350 2021', 135559000.00, 135559000.00, 0, '2022-04-19 00:00:00', 4, 1, 'Chevrolet RX350 2021 is a reliable and high-performance vehicle.', '16:9', 'Mid-size', 'Steel', 'Japan', 1, '2022-04-19 11:19:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (91, 'Lexus XC90 2020', 128232000.00, 128232000.00, 0, '2023-06-18 00:00:00', 15, 3, 'Lexus XC90 2020 is a reliable and high-performance vehicle.', '1:1', 'Mid-size', 'Composite', 'Japan', 1, '2023-06-18 18:01:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (92, 'Lexus Navara 2021', 96276000.00, 96276000.00, 0, '2023-12-26 00:00:00', 15, 3, 'Lexus Navara 2021 is a reliable and high-performance vehicle.', '21:9', 'Mid-size', 'Composite', 'Japan', 0, '2023-12-26 23:19:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (93, 'Land Rover Mustang 2022', 32525000.00, 32525000.00, 0, '2023-08-25 00:00:00', 18, 3, 'Land Rover Mustang 2022 is a reliable and high-performance vehicle.', '1:1', 'Mid-size', 'Steel', 'South Korea', 1, '2023-08-25 10:48:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (94, 'Honda CX-3 2020', 63472000.00, 63472000.00, 0, '2024-08-16 00:00:00', 2, 8, 'Honda CX-3 2020 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Steel', 'Japan', 0, '2024-08-16 23:23:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (95, 'Toyota Ranger 2019', 122521000.00, 122521000.00, 0, '2022-11-25 00:00:00', 1, 3, 'Toyota Ranger 2019 is a reliable and high-performance vehicle.', '1:1', 'Compact', 'Steel', 'USA', 1, '2022-11-25 07:43:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (96, 'Toyota Land Cruiser 2022', 118714000.00, 118714000.00, 0, '2023-02-21 00:00:00', 1, 10, 'Toyota Land Cruiser 2022 is a reliable and high-performance vehicle.', '1:1', 'Mini', 'Alloy', 'Sweden', 1, '2023-02-21 02:46:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (97, 'Nissan XC90 2018', 121168000.00, 121168000.00, 0, '2022-01-02 00:00:00', 11, 10, 'Nissan XC90 2018 is a reliable and high-performance vehicle.', '21:9', 'Mid-size', 'Carbon Fiber', 'Italy', 1, '2022-01-02 05:28:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (98, 'Jeep CX-3 2021', 22354000.00, 22354000.00, 0, '2024-09-25 00:00:00', 19, 9, 'Jeep CX-3 2021 is a reliable and high-performance vehicle.', '4:3', 'Mini', 'Aluminum', 'South Korea', 0, '2024-09-25 22:39:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (99, 'Toyota Land Cruiser 2023', 95877000.00, 95877000.00, 0, '2024-01-19 00:00:00', 1, 9, 'Toyota Land Cruiser 2023 is a reliable and high-performance vehicle.', '21:9', 'Mid-size', 'Steel', 'Italy', 1, '2024-01-19 09:01:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (100, 'Lexus Passat 2022', 115519000.00, 115519000.00, 0, '2023-03-12 00:00:00', 15, 7, 'Lexus Passat 2022 is a reliable and high-performance vehicle.', '4:3', 'Mid-size', 'Carbon Fiber', 'Japan', 1, '2023-03-12 20:43:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (101, 'Mazda Forester 2022', 41483000.00, 41483000.00, 0, '2023-01-21 00:00:00', 10, 2, 'Mazda Forester 2022 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Carbon Fiber', 'Italy', 1, '2023-01-21 15:46:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (102, 'Kia E-Class 2019', 129569000.00, 129569000.00, 0, '2023-11-30 00:00:00', 9, 10, 'Kia E-Class 2019 is a reliable and high-performance vehicle.', '4:3', 'Full-size', 'Carbon Fiber', 'UK', 1, '2023-11-30 20:41:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (103, 'Hyundai Tucson 2023', 44556000.00, 44556000.00, 0, '2024-02-07 00:00:00', 8, 9, 'Hyundai Tucson 2023 is a reliable and high-performance vehicle.', '1:1', 'Full-size', 'Carbon Fiber', 'South Korea', 1, '2024-02-07 16:11:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (104, 'Ford Defender 2019', 41948000.00, 41948000.00, 0, '2022-05-11 00:00:00', 3, 1, 'Ford Defender 2019 is a reliable and high-performance vehicle.', '4:3', 'Large', 'Composite', 'Sweden', 1, '2022-05-11 14:52:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (105, 'Honda CX-5 2020', 39697000.00, 39697000.00, 0, '2022-03-24 00:00:00', 2, 10, 'Honda CX-5 2020 is a reliable and high-performance vehicle.', '16:9', 'Compact', 'Composite', 'Sweden', 1, '2022-03-24 01:49:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (106, 'Audi RX350 2025', 103793000.00, 103793000.00, 0, '2023-07-15 00:00:00', 7, 2, 'Audi RX350 2025 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Alloy', 'UK', 1, '2023-07-15 01:00:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (107, 'Peugeot Q5 2025', 70252000.00, 70252000.00, 0, '2022-07-07 00:00:00', 20, 5, 'Peugeot Q5 2025 is a reliable and high-performance vehicle.', '4:3', 'Mini', 'Alloy', 'USA', 1, '2022-07-07 04:30:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (108, 'Audi Explorer 2020', 91140000.00, 91140000.00, 0, '2023-09-02 00:00:00', 7, 8, 'Audi Explorer 2020 is a reliable and high-performance vehicle.', '16:9', 'Mid-size', 'Composite', 'France', 0, '2023-09-02 01:59:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (109, 'Ford A4 2021', 97715000.00, 97715000.00, 0, '2022-10-26 00:00:00', 3, 7, 'Ford A4 2021 is a reliable and high-performance vehicle.', '21:9', 'Full-size', 'Steel', 'Sweden', 0, '2022-10-26 09:47:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (110, 'Ford Civic 2020', 94791000.00, 94791000.00, 0, '2024-03-09 00:00:00', 3, 5, 'Ford Civic 2020 is a reliable and high-performance vehicle.', '4:3', 'Compact', 'Steel', 'South Korea', 0, '2024-03-09 12:27:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (111, 'Kia Forester 2018', 132551000.00, 132551000.00, 0, '2024-10-15 00:00:00', 9, 7, 'Kia Forester 2018 is a reliable and high-performance vehicle.', '21:9', 'Full-size', 'Carbon Fiber', 'USA', 0, '2024-10-15 14:05:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (112, 'Land Rover Forester 2018', 41208000.00, 41208000.00, 0, '2024-02-14 00:00:00', 18, 10, 'Land Rover Forester 2018 is a reliable and high-performance vehicle.', '21:9', 'Mini', 'Carbon Fiber', 'South Korea', 0, '2024-02-14 01:03:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (113, 'Subaru Tucson 2020', 66766000.00, 66766000.00, 0, '2023-08-21 00:00:00', 16, 2, 'Subaru Tucson 2020 is a reliable and high-performance vehicle.', '16:9', 'Full-size', 'Carbon Fiber', 'South Korea', 1, '2023-08-21 23:54:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (114, 'Honda XC90 2018', 29340000.00, 29340000.00, 0, '2022-12-19 00:00:00', 2, 7, 'Honda XC90 2018 is a reliable and high-performance vehicle.', '4:3', 'Mid-size', 'Composite', 'France', 0, '2022-12-19 18:46:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (115, 'Lexus Outlander 2018', 27795000.00, 27795000.00, 0, '2023-01-28 00:00:00', 15, 8, 'Lexus Outlander 2018 is a reliable and high-performance vehicle.', '16:9', 'Large', 'Composite', 'South Korea', 1, '2023-01-28 16:18:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (116, 'Nissan CX-8 2022', 147457000.00, 147457000.00, 0, '2023-07-05 00:00:00', 11, 4, 'Nissan CX-8 2022 is a reliable and high-performance vehicle.', '21:9', 'Mini', 'Aluminum', 'Italy', 0, '2023-07-05 22:50:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (117, 'Toyota Sorento 2019', 94883000.00, 94883000.00, 0, '2022-09-29 00:00:00', 1, 10, 'Toyota Sorento 2019 is a reliable and high-performance vehicle.', '16:9', 'Large', 'Carbon Fiber', 'Japan', 1, '2022-09-29 12:30:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (118, 'Peugeot Wrangler 2022', 84121000.00, 84121000.00, 0, '2022-01-02 00:00:00', 20, 8, 'Peugeot Wrangler 2022 is a reliable and high-performance vehicle.', '16:9', 'Compact', 'Aluminum', 'Japan', 1, '2022-01-02 22:00:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (119, 'Volkswagen XC90 2021', 53829000.00, 53829000.00, 0, '2024-09-17 00:00:00', 13, 6, 'Volkswagen XC90 2021 is a reliable and high-performance vehicle.', '1:1', 'Mini', 'Composite', 'UK', 1, '2024-09-17 07:53:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (120, 'Toyota Hilux 2025', 29873000.00, 29873000.00, 0, '2022-05-03 00:00:00', 1, 9, 'Toyota Hilux 2025 is a reliable and high-performance vehicle.', '1:1', 'Full-size', 'Carbon Fiber', 'USA', 0, '2022-05-03 02:53:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (121, 'Ford Sorento 2025', 40106000.00, 40106000.00, 0, '2023-12-03 00:00:00', 3, 3, 'Ford Sorento 2025 is a reliable and high-performance vehicle.', '16:9', 'Mid-size', 'Aluminum', 'Italy', 0, '2023-12-03 12:23:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (122, 'Volvo Model 3 2020', 83031000.00, 83031000.00, 0, '2023-11-16 00:00:00', 17, 6, 'Volvo Model 3 2020 is a reliable and high-performance vehicle.', '1:1', 'Mini', 'Aluminum', 'Germany', 0, '2023-11-16 04:32:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (123, 'Audi Camry 2023', 144154000.00, 144154000.00, 0, '2023-01-07 00:00:00', 7, 5, 'Audi Camry 2023 is a reliable and high-performance vehicle.', '1:1', 'Mid-size', 'Steel', 'Italy', 0, '2023-01-07 01:43:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (124, 'Mitsubishi C-Class 2020', 49077000.00, 49077000.00, 0, '2024-04-17 00:00:00', 12, 9, 'Mitsubishi C-Class 2020 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Steel', 'France', 1, '2024-04-17 01:04:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (125, 'Audi X3 2020', 92272000.00, 92272000.00, 0, '2023-01-27 00:00:00', 7, 8, 'Audi X3 2020 is a reliable and high-performance vehicle.', '16:9', 'Full-size', 'Aluminum', 'France', 1, '2023-01-27 19:27:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (126, 'Mitsubishi Passat 2019', 56400000.00, 56400000.00, 0, '2023-07-22 00:00:00', 12, 9, 'Mitsubishi Passat 2019 is a reliable and high-performance vehicle.', '4:3', 'Compact', 'Carbon Fiber', 'South Korea', 0, '2023-07-22 05:22:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (127, 'BMW Explorer 2022', 70352000.00, 70352000.00, 0, '2024-03-30 00:00:00', 5, 8, 'BMW Explorer 2022 is a reliable and high-performance vehicle.', '16:9', 'Mid-size', 'Aluminum', 'Italy', 0, '2024-03-30 18:27:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (128, 'Mitsubishi E-Class 2021', 101451000.00, 101451000.00, 0, '2023-09-17 00:00:00', 12, 9, 'Mitsubishi E-Class 2021 is a reliable and high-performance vehicle.', '1:1', 'Mid-size', 'Carbon Fiber', 'Germany', 1, '2023-09-17 01:01:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (129, 'Porsche Rio 2023', 47814000.00, 47814000.00, 0, '2022-07-23 00:00:00', 14, 5, 'Porsche Rio 2023 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Alloy', 'Germany', 1, '2022-07-23 13:36:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (130, 'Honda Model 3 2021', 129729000.00, 129729000.00, 0, '2024-01-18 00:00:00', 2, 5, 'Honda Model 3 2021 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Composite', 'UK', 0, '2024-01-18 14:57:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (131, 'Chevrolet X3 2025', 119181000.00, 119181000.00, 0, '2022-06-23 00:00:00', 4, 1, 'Chevrolet X3 2025 is a reliable and high-performance vehicle.', '16:9', 'Large', 'Carbon Fiber', 'South Korea', 0, '2022-06-23 12:25:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (132, 'Mazda Sorento 2023', 82466000.00, 82466000.00, 0, '2022-07-11 00:00:00', 10, 6, 'Mazda Sorento 2023 is a reliable and high-performance vehicle.', '16:9', 'Large', 'Steel', 'Italy', 1, '2022-07-11 04:12:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (133, 'Mazda Ranger 2023', 143865000.00, 143865000.00, 0, '2023-06-26 00:00:00', 10, 9, 'Mazda Ranger 2023 is a reliable and high-performance vehicle.', '16:9', 'Compact', 'Alloy', 'Japan', 0, '2023-06-26 12:15:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (134, 'Nissan CX-8 2024', 26936000.00, 26936000.00, 0, '2023-03-25 00:00:00', 11, 2, 'Nissan CX-8 2024 is a reliable and high-performance vehicle.', '4:3', 'Mini', 'Composite', 'Italy', 0, '2023-03-25 11:27:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (135, 'Nissan E-Class 2023', 56913000.00, 56913000.00, 0, '2023-05-22 00:00:00', 11, 6, 'Nissan E-Class 2023 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Carbon Fiber', 'UK', 1, '2023-05-22 01:13:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (136, 'Lexus Taycan 2021', 138346000.00, 138346000.00, 0, '2022-06-29 00:00:00', 15, 3, 'Lexus Taycan 2021 is a reliable and high-performance vehicle.', '16:9', 'Large', 'Aluminum', 'Sweden', 1, '2022-06-29 12:13:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (137, 'Ford Land Cruiser 2018', 123144000.00, 123144000.00, 0, '2023-04-26 00:00:00', 3, 9, 'Ford Land Cruiser 2018 is a reliable and high-performance vehicle.', '4:3', 'Mini', 'Carbon Fiber', 'South Korea', 1, '2023-04-26 05:40:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (138, 'Kia Sorento 2021', 26467000.00, 26467000.00, 0, '2024-03-27 00:00:00', 9, 9, 'Kia Sorento 2021 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Carbon Fiber', 'Italy', 0, '2024-03-27 16:28:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (139, 'Honda Hilux 2025', 58089000.00, 58089000.00, 0, '2022-11-04 00:00:00', 2, 3, 'Honda Hilux 2025 is a reliable and high-performance vehicle.', '16:9', 'Compact', 'Carbon Fiber', 'Italy', 1, '2022-11-04 07:20:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (140, 'Audi XC90 2022', 82172000.00, 82172000.00, 0, '2023-12-17 00:00:00', 7, 6, 'Audi XC90 2022 is a reliable and high-performance vehicle.', '4:3', 'Mini', 'Steel', 'Germany', 1, '2023-12-17 23:47:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (141, 'Honda Accord 2021', 110866000.00, 110866000.00, 0, '2023-01-22 00:00:00', 2, 6, 'Honda Accord 2021 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Alloy', 'USA', 0, '2023-01-22 23:53:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (142, 'Ford Sorento 2021', 133636000.00, 133636000.00, 0, '2023-06-15 00:00:00', 3, 4, 'Ford Sorento 2021 is a reliable and high-performance vehicle.', '21:9', 'Mini', 'Steel', 'Sweden', 0, '2023-06-15 22:10:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (143, 'Peugeot E-Class 2019', 97947000.00, 97947000.00, 0, '2022-11-27 00:00:00', 20, 10, 'Peugeot E-Class 2019 is a reliable and high-performance vehicle.', '4:3', 'Large', 'Aluminum', 'Sweden', 1, '2022-11-27 07:42:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (144, 'Porsche Sorento 2021', 120529000.00, 120529000.00, 0, '2024-11-04 00:00:00', 14, 4, 'Porsche Sorento 2021 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Composite', 'South Korea', 1, '2024-11-04 21:56:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (145, 'Hyundai C-Class 2025', 30719000.00, 30719000.00, 0, '2023-06-23 00:00:00', 8, 2, 'Hyundai C-Class 2025 is a reliable and high-performance vehicle.', '21:9', 'Mid-size', 'Composite', 'Sweden', 0, '2023-06-23 16:48:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (146, 'Volkswagen A4 2018', 114561000.00, 114561000.00, 0, '2024-12-20 00:00:00', 13, 4, 'Volkswagen A4 2018 is a reliable and high-performance vehicle.', '21:9', 'Mini', 'Steel', 'South Korea', 0, '2024-12-20 14:22:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (147, 'Audi E-Class 2021', 26171000.00, 26171000.00, 0, '2022-03-27 00:00:00', 7, 8, 'Audi E-Class 2021 is a reliable and high-performance vehicle.', '21:9', 'Mini', 'Steel', 'France', 0, '2022-03-27 04:15:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (148, 'Volkswagen E-Class 2021', 31512000.00, 31512000.00, 0, '2022-02-16 00:00:00', 13, 10, 'Volkswagen E-Class 2021 is a reliable and high-performance vehicle.', '21:9', 'Full-size', 'Composite', 'USA', 1, '2022-02-16 10:52:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (149, 'Kia CX-3 2024', 32328000.00, 32328000.00, 0, '2023-06-28 00:00:00', 9, 7, 'Kia CX-3 2024 is a reliable and high-performance vehicle.', '16:9', 'Large', 'Carbon Fiber', 'South Korea', 1, '2023-06-28 12:35:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (150, 'Toyota X3 2019', 135999000.00, 135999000.00, 0, '2022-10-13 00:00:00', 1, 7, 'Toyota X3 2019 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Alloy', 'Italy', 0, '2022-10-13 16:19:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (151, 'BMW Defender 2019', 137050000.00, 137050000.00, 0, '2024-06-01 00:00:00', 5, 9, 'BMW Defender 2019 is a reliable and high-performance vehicle.', '21:9', 'Full-size', 'Carbon Fiber', 'Japan', 0, '2024-06-01 06:13:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (152, 'Toyota XC90 2022', 133942000.00, 133942000.00, 0, '2024-11-09 00:00:00', 1, 10, 'Toyota XC90 2022 is a reliable and high-performance vehicle.', '4:3', 'Compact', 'Aluminum', 'France', 1, '2024-11-09 20:21:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (153, 'BMW Civic 2019', 114742000.00, 114742000.00, 0, '2023-08-17 00:00:00', 5, 1, 'BMW Civic 2019 is a reliable and high-performance vehicle.', '4:3', 'Full-size', 'Carbon Fiber', 'Germany', 0, '2023-08-17 04:11:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (154, 'Peugeot RX350 2019', 43888000.00, 43888000.00, 0, '2024-08-13 00:00:00', 20, 6, 'Peugeot RX350 2019 is a reliable and high-performance vehicle.', '4:3', 'Mid-size', 'Composite', 'France', 0, '2024-08-13 15:13:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (155, 'Nissan CX-8 2018', 119390000.00, 119390000.00, 0, '2024-01-12 00:00:00', 11, 7, 'Nissan CX-8 2018 is a reliable and high-performance vehicle.', '21:9', 'Mini', 'Steel', 'UK', 0, '2024-01-12 00:42:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (156, 'Subaru Outlander 2025', 47945000.00, 47945000.00, 0, '2024-03-06 00:00:00', 16, 3, 'Subaru Outlander 2025 is a reliable and high-performance vehicle.', '4:3', 'Mid-size', 'Aluminum', 'Germany', 0, '2024-03-06 08:39:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (157, 'Peugeot Outlander 2024', 112762000.00, 112762000.00, 0, '2023-07-30 00:00:00', 20, 8, 'Peugeot Outlander 2024 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Composite', 'Japan', 1, '2023-07-30 00:12:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (158, 'Hyundai Hilux 2024', 94656000.00, 94656000.00, 0, '2024-11-22 00:00:00', 8, 10, 'Hyundai Hilux 2024 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Carbon Fiber', 'South Korea', 0, '2024-11-22 17:22:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (159, 'Chevrolet Defender 2022', 119388000.00, 119388000.00, 0, '2024-02-23 00:00:00', 4, 5, 'Chevrolet Defender 2022 is a reliable and high-performance vehicle.', '1:1', 'Compact', 'Steel', 'Sweden', 1, '2024-02-23 07:38:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (160, 'Jeep Taycan 2021', 28612000.00, 28612000.00, 0, '2024-10-21 00:00:00', 19, 2, 'Jeep Taycan 2021 is a reliable and high-performance vehicle.', '21:9', 'Mid-size', 'Aluminum', 'Japan', 0, '2024-10-21 14:09:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (161, 'Toyota Accord 2021', 85440000.00, 85440000.00, 0, '2024-04-29 00:00:00', 1, 5, 'Toyota Accord 2021 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Composite', 'South Korea', 0, '2024-04-29 13:06:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (162, 'Peugeot Land Cruiser 2022', 143654000.00, 143654000.00, 0, '2023-10-29 00:00:00', 20, 10, 'Peugeot Land Cruiser 2022 is a reliable and high-performance vehicle.', '1:1', 'Mini', 'Carbon Fiber', 'USA', 0, '2023-10-29 13:48:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (163, 'Subaru Taycan 2018', 117712000.00, 117712000.00, 0, '2022-01-22 00:00:00', 16, 10, 'Subaru Taycan 2018 is a reliable and high-performance vehicle.', '16:9', 'Large', 'Composite', 'France', 0, '2022-01-22 02:09:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (164, 'Chevrolet A4 2020', 69265000.00, 69265000.00, 0, '2023-05-14 00:00:00', 4, 7, 'Chevrolet A4 2020 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Composite', 'Japan', 0, '2023-05-14 14:38:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (165, 'Mercedes-Benz Corolla 2018', 36920000.00, 36920000.00, 0, '2024-06-18 00:00:00', 6, 9, 'Mercedes-Benz Corolla 2018 is a reliable and high-performance vehicle.', '21:9', 'Large', 'Aluminum', 'USA', 0, '2024-06-18 06:56:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (166, 'Hyundai Ranger 2024', 103739000.00, 103739000.00, 0, '2022-09-25 00:00:00', 8, 6, 'Hyundai Ranger 2024 is a reliable and high-performance vehicle.', '16:9', 'Full-size', 'Carbon Fiber', 'Italy', 1, '2022-09-25 10:02:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (167, 'Porsche E-Class 2019', 87964000.00, 87964000.00, 0, '2023-05-07 00:00:00', 14, 9, 'Porsche E-Class 2019 is a reliable and high-performance vehicle.', '1:1', 'Mini', 'Composite', 'UK', 0, '2023-05-07 22:07:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (168, 'Chevrolet Accord 2018', 69659000.00, 69659000.00, 0, '2023-04-30 00:00:00', 4, 8, 'Chevrolet Accord 2018 is a reliable and high-performance vehicle.', '4:3', 'Full-size', 'Carbon Fiber', 'Sweden', 1, '2023-04-30 11:22:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (169, 'Audi Taycan 2025', 143136000.00, 143136000.00, 0, '2024-10-17 00:00:00', 7, 3, 'Audi Taycan 2025 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Aluminum', 'France', 1, '2024-10-17 06:55:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (170, 'Lexus Q7 2018', 42595000.00, 42595000.00, 0, '2022-10-13 00:00:00', 15, 4, 'Lexus Q7 2018 is a reliable and high-performance vehicle.', '4:3', 'Mid-size', 'Carbon Fiber', 'Japan', 1, '2022-10-13 13:36:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (171, 'Toyota Model S 2024', 141447000.00, 141447000.00, 0, '2022-05-03 00:00:00', 1, 3, 'Toyota Model S 2024 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Composite', 'Japan', 0, '2022-05-03 17:18:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (172, 'Lexus XC60 2025', 52739000.00, 52739000.00, 0, '2023-09-10 00:00:00', 15, 6, 'Lexus XC60 2025 is a reliable and high-performance vehicle.', '1:1', 'Mid-size', 'Composite', 'Germany', 0, '2023-09-10 01:33:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (173, 'Nissan X5 2018', 39314000.00, 39314000.00, 0, '2023-12-05 00:00:00', 11, 9, 'Nissan X5 2018 is a reliable and high-performance vehicle.', '16:9', 'Full-size', 'Carbon Fiber', 'UK', 1, '2023-12-05 21:56:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (174, 'Nissan Sorento 2018', 126337000.00, 126337000.00, 0, '2023-03-05 00:00:00', 11, 4, 'Nissan Sorento 2018 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Alloy', 'France', 0, '2023-03-05 19:53:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (175, 'Nissan A4 2023', 119238000.00, 119238000.00, 0, '2023-08-27 00:00:00', 11, 3, 'Nissan A4 2023 is a reliable and high-performance vehicle.', '4:3', 'Mid-size', 'Aluminum', 'Germany', 1, '2023-08-27 17:28:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (176, 'Honda Camry 2021', 78961000.00, 78961000.00, 0, '2023-11-02 00:00:00', 2, 10, 'Honda Camry 2021 is a reliable and high-performance vehicle.', '1:1', 'Full-size', 'Composite', 'South Korea', 1, '2023-11-02 00:33:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (177, 'Jeep Outlander 2018', 125152000.00, 125152000.00, 0, '2022-01-10 00:00:00', 19, 1, 'Jeep Outlander 2018 is a reliable and high-performance vehicle.', '21:9', 'Mid-size', 'Aluminum', 'Japan', 0, '2022-01-10 04:48:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (178, 'Honda XC60 2024', 103013000.00, 103013000.00, 0, '2024-08-30 00:00:00', 2, 1, 'Honda XC60 2024 is a reliable and high-performance vehicle.', '21:9', 'Large', 'Composite', 'USA', 0, '2024-08-30 06:13:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (179, 'Nissan X5 2021', 134782000.00, 134782000.00, 0, '2023-12-17 00:00:00', 11, 10, 'Nissan X5 2021 is a reliable and high-performance vehicle.', '1:1', 'Mini', 'Composite', 'South Korea', 1, '2023-12-17 11:38:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (180, 'Jeep E-Class 2024', 84237000.00, 84237000.00, 0, '2022-02-04 00:00:00', 19, 6, 'Jeep E-Class 2024 is a reliable and high-performance vehicle.', '4:3', 'Mid-size', 'Composite', 'France', 0, '2022-02-04 23:09:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (181, 'Peugeot Ranger 2024', 70518000.00, 70518000.00, 0, '2024-12-12 00:00:00', 20, 4, 'Peugeot Ranger 2024 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Steel', 'Germany', 0, '2024-12-12 09:30:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (182, 'Mercedes-Benz Wrangler 2018', 98912000.00, 98912000.00, 0, '2023-11-27 00:00:00', 6, 7, 'Mercedes-Benz Wrangler 2018 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Composite', 'Sweden', 0, '2023-11-27 21:43:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (183, 'Mitsubishi CX-3 2019', 147320000.00, 147320000.00, 0, '2023-09-16 00:00:00', 12, 5, 'Mitsubishi CX-3 2019 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Composite', 'USA', 1, '2023-09-16 09:21:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (184, 'Mazda Outlander 2019', 107778000.00, 107778000.00, 0, '2022-11-24 00:00:00', 10, 4, 'Mazda Outlander 2019 is a reliable and high-performance vehicle.', '16:9', 'Large', 'Alloy', 'Sweden', 0, '2022-11-24 20:37:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (185, 'Honda Accord 2020', 93310000.00, 93310000.00, 0, '2022-06-28 00:00:00', 2, 6, 'Honda Accord 2020 is a reliable and high-performance vehicle.', '16:9', 'Mid-size', 'Carbon Fiber', 'USA', 1, '2022-06-28 02:49:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (186, 'Mazda Forester 2021', 107571000.00, 107571000.00, 0, '2024-08-08 00:00:00', 10, 7, 'Mazda Forester 2021 is a reliable and high-performance vehicle.', '4:3', 'Large', 'Aluminum', 'Germany', 0, '2024-08-08 13:18:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (187, 'Kia Model S 2025', 81610000.00, 81610000.00, 0, '2022-04-08 00:00:00', 9, 5, 'Kia Model S 2025 is a reliable and high-performance vehicle.', '16:9', 'Full-size', 'Carbon Fiber', 'France', 1, '2022-04-08 20:01:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (188, 'Nissan Accord 2025', 69479000.00, 69479000.00, 0, '2024-08-20 00:00:00', 11, 3, 'Nissan Accord 2025 is a reliable and high-performance vehicle.', '4:3', 'Mini', 'Alloy', 'France', 0, '2024-08-20 03:36:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (189, 'BMW Hilux 2018', 46843000.00, 46843000.00, 0, '2023-06-14 00:00:00', 5, 4, 'BMW Hilux 2018 is a reliable and high-performance vehicle.', '1:1', 'Compact', 'Steel', 'Japan', 0, '2023-06-14 17:30:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (190, 'Audi E-Class 2022', 81389000.00, 81389000.00, 0, '2023-11-23 00:00:00', 7, 8, 'Audi E-Class 2022 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Composite', 'Japan', 0, '2023-11-23 23:35:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (191, 'Volkswagen A6 2021', 89929000.00, 89929000.00, 0, '2022-08-26 00:00:00', 13, 4, 'Volkswagen A6 2021 is a reliable and high-performance vehicle.', '16:9', 'Compact', 'Steel', 'Italy', 1, '2022-08-26 13:41:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (192, 'Mercedes-Benz Model 3 2023', 35790000.00, 35790000.00, 0, '2022-06-25 00:00:00', 6, 3, 'Mercedes-Benz Model 3 2023 is a reliable and high-performance vehicle.', '1:1', 'Mini', 'Alloy', 'Sweden', 0, '2022-06-25 15:33:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (193, 'Kia CX-3 2022', 52666000.00, 52666000.00, 0, '2024-06-23 00:00:00', 9, 1, 'Kia CX-3 2022 is a reliable and high-performance vehicle.', '4:3', 'Mini', 'Alloy', 'South Korea', 1, '2024-06-23 22:00:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (194, 'Kia E-Class 2022', 99268000.00, 99268000.00, 0, '2024-04-09 00:00:00', 9, 1, 'Kia E-Class 2022 is a reliable and high-performance vehicle.', '1:1', 'Mini', 'Steel', 'UK', 1, '2024-04-09 19:42:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (195, 'Jeep Rio 2019', 76935000.00, 76935000.00, 0, '2024-08-31 00:00:00', 19, 7, 'Jeep Rio 2019 is a reliable and high-performance vehicle.', '1:1', 'Full-size', 'Composite', 'South Korea', 0, '2024-08-31 21:01:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (196, 'Peugeot Model S 2018', 127960000.00, 127960000.00, 0, '2022-09-22 00:00:00', 20, 10, 'Peugeot Model S 2018 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Steel', 'UK', 1, '2022-09-22 11:46:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (197, 'Audi Sorento 2023', 130069000.00, 130069000.00, 0, '2024-02-02 00:00:00', 7, 4, 'Audi Sorento 2023 is a reliable and high-performance vehicle.', '1:1', 'Mid-size', 'Aluminum', 'UK', 0, '2024-02-02 17:31:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (198, 'Kia Camry 2021', 49210000.00, 49210000.00, 0, '2023-01-26 00:00:00', 9, 2, 'Kia Camry 2021 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Aluminum', 'USA', 1, '2023-01-26 09:34:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (199, 'Ford Corolla 2022', 52154000.00, 52154000.00, 0, '2022-02-24 00:00:00', 3, 4, 'Ford Corolla 2022 is a reliable and high-performance vehicle.', '1:1', 'Compact', 'Composite', 'USA', 1, '2022-02-24 22:57:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (200, 'Volkswagen Navara 2019', 125284000.00, 125284000.00, 0, '2023-08-18 00:00:00', 13, 1, 'Volkswagen Navara 2019 is a reliable and high-performance vehicle.', '1:1', 'Mid-size', 'Aluminum', 'France', 0, '2023-08-18 14:46:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (201, 'Mazda C-Class 2018', 113396000.00, 113396000.00, 0, '2023-01-11 00:00:00', 10, 4, 'Mazda C-Class 2018 is a reliable and high-performance vehicle.', '16:9', 'Large', 'Aluminum', 'Italy', 0, '2023-01-11 11:54:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (202, 'Peugeot Q7 2022', 133629000.00, 133629000.00, 0, '2024-09-04 00:00:00', 20, 4, 'Peugeot Q7 2022 is a reliable and high-performance vehicle.', '21:9', 'Large', 'Carbon Fiber', 'France', 0, '2024-09-04 18:25:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (203, 'Peugeot Forester 2020', 90535000.00, 90535000.00, 0, '2024-04-07 00:00:00', 20, 8, 'Peugeot Forester 2020 is a reliable and high-performance vehicle.', '1:1', 'Compact', 'Carbon Fiber', 'USA', 1, '2024-04-07 04:37:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (204, 'Audi Passat 2019', 109109000.00, 109109000.00, 0, '2024-06-21 00:00:00', 7, 2, 'Audi Passat 2019 is a reliable and high-performance vehicle.', '16:9', 'Large', 'Carbon Fiber', 'South Korea', 1, '2024-06-21 21:29:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (205, 'Peugeot Sorento 2018', 53497000.00, 53497000.00, 0, '2022-07-03 00:00:00', 20, 7, 'Peugeot Sorento 2018 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Composite', 'USA', 1, '2022-07-03 05:34:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (206, 'Honda Cherokee 2023', 91059000.00, 91059000.00, 0, '2023-01-20 00:00:00', 2, 10, 'Honda Cherokee 2023 is a reliable and high-performance vehicle.', '4:3', 'Large', 'Composite', 'France', 1, '2023-01-20 00:33:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (207, 'Porsche Sorento 2021', 113964000.00, 113964000.00, 0, '2023-06-13 00:00:00', 14, 6, 'Porsche Sorento 2021 is a reliable and high-performance vehicle.', '4:3', 'Mid-size', 'Alloy', 'Sweden', 1, '2023-06-13 01:14:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (208, 'Mitsubishi RX350 2024', 65632000.00, 65632000.00, 0, '2024-02-07 00:00:00', 12, 4, 'Mitsubishi RX350 2024 is a reliable and high-performance vehicle.', '4:3', 'Large', 'Carbon Fiber', 'Sweden', 0, '2024-02-07 21:32:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (209, 'Peugeot CX-5 2019', 91647000.00, 91647000.00, 0, '2024-10-22 00:00:00', 20, 2, 'Peugeot CX-5 2019 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Alloy', 'France', 0, '2024-10-22 21:14:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (210, 'Audi E-Class 2022', 73146000.00, 73146000.00, 0, '2023-05-12 00:00:00', 7, 3, 'Audi E-Class 2022 is a reliable and high-performance vehicle.', '4:3', 'Compact', 'Composite', 'Sweden', 1, '2023-05-12 16:51:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (211, 'Toyota Taycan 2024', 111424000.00, 111424000.00, 0, '2022-08-17 00:00:00', 1, 9, 'Toyota Taycan 2024 is a reliable and high-performance vehicle.', '21:9', 'Mid-size', 'Composite', 'Italy', 1, '2022-08-17 04:39:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (212, 'Chevrolet Model S 2025', 74992000.00, 74992000.00, 0, '2024-05-16 00:00:00', 4, 3, 'Chevrolet Model S 2025 is a reliable and high-performance vehicle.', '1:1', 'Full-size', 'Alloy', 'Sweden', 0, '2024-05-16 17:51:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (213, 'Mercedes-Benz Land Cruiser 2018', 133984000.00, 133984000.00, 0, '2023-07-11 00:00:00', 6, 2, 'Mercedes-Benz Land Cruiser 2018 is a reliable and high-performance vehicle.', '16:9', 'Compact', 'Aluminum', 'South Korea', 0, '2023-07-11 15:26:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (214, 'Ford Santa Fe 2023', 87713000.00, 87713000.00, 0, '2022-02-11 00:00:00', 3, 7, 'Ford Santa Fe 2023 is a reliable and high-performance vehicle.', '1:1', 'Mini', 'Carbon Fiber', 'Italy', 0, '2022-02-11 19:10:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (215, 'Ford Defender 2025', 56389000.00, 56389000.00, 0, '2023-02-21 00:00:00', 3, 9, 'Ford Defender 2025 is a reliable and high-performance vehicle.', '4:3', 'Full-size', 'Composite', 'Italy', 1, '2023-02-21 11:49:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (216, 'BMW Ranger 2021', 64950000.00, 64950000.00, 0, '2022-12-09 00:00:00', 5, 7, 'BMW Ranger 2021 is a reliable and high-performance vehicle.', '21:9', 'Large', 'Composite', 'Germany', 0, '2022-12-09 14:07:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (217, 'Jeep CX-3 2020', 124396000.00, 124396000.00, 0, '2022-03-06 00:00:00', 19, 3, 'Jeep CX-3 2020 is a reliable and high-performance vehicle.', '4:3', 'Full-size', 'Aluminum', 'USA', 0, '2022-03-06 06:13:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (218, 'Honda Mustang 2022', 29363000.00, 29363000.00, 0, '2024-07-13 00:00:00', 2, 7, 'Honda Mustang 2022 is a reliable and high-performance vehicle.', '16:9', 'Large', 'Carbon Fiber', 'South Korea', 0, '2024-07-13 04:55:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (219, 'Kia A6 2019', 53635000.00, 53635000.00, 0, '2023-06-23 00:00:00', 9, 9, 'Kia A6 2019 is a reliable and high-performance vehicle.', '1:1', 'Mid-size', 'Alloy', 'Italy', 0, '2023-06-23 21:05:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (220, 'Land Rover Rio 2019', 96338000.00, 96338000.00, 0, '2024-06-16 00:00:00', 18, 6, 'Land Rover Rio 2019 is a reliable and high-performance vehicle.', '21:9', 'Large', 'Carbon Fiber', 'Japan', 0, '2024-06-16 20:04:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (221, 'Mitsubishi Mustang 2020', 132609000.00, 132609000.00, 0, '2024-05-08 00:00:00', 12, 2, 'Mitsubishi Mustang 2020 is a reliable and high-performance vehicle.', '16:9', 'Full-size', 'Composite', 'UK', 1, '2024-05-08 08:49:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (222, 'Hyundai Santa Fe 2020', 64635000.00, 64635000.00, 0, '2023-04-23 00:00:00', 8, 9, 'Hyundai Santa Fe 2020 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Composite', 'Japan', 1, '2023-04-23 13:54:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (223, 'Nissan Corolla 2023', 102049000.00, 102049000.00, 0, '2023-09-01 00:00:00', 11, 7, 'Nissan Corolla 2023 is a reliable and high-performance vehicle.', '16:9', 'Large', 'Steel', 'Japan', 1, '2023-09-01 14:54:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (224, 'Porsche A6 2020', 80397000.00, 80397000.00, 0, '2024-09-20 00:00:00', 14, 9, 'Porsche A6 2020 is a reliable and high-performance vehicle.', '16:9', 'Mid-size', 'Alloy', 'USA', 1, '2024-09-20 22:06:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (225, 'Hyundai Altima 2023', 54768000.00, 54768000.00, 0, '2023-03-30 00:00:00', 8, 8, 'Hyundai Altima 2023 is a reliable and high-performance vehicle.', '4:3', 'Full-size', 'Composite', 'Japan', 1, '2023-03-30 11:41:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (226, 'Mercedes-Benz Civic 2025', 52865000.00, 52865000.00, 0, '2023-08-25 00:00:00', 6, 7, 'Mercedes-Benz Civic 2025 is a reliable and high-performance vehicle.', '1:1', 'Mini', 'Alloy', 'Germany', 0, '2023-08-25 17:23:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (227, 'Peugeot Corolla 2018', 89556000.00, 89556000.00, 0, '2022-07-31 00:00:00', 20, 3, 'Peugeot Corolla 2018 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Aluminum', 'UK', 1, '2022-07-31 19:25:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (228, 'Subaru Model 3 2020', 148983000.00, 148983000.00, 0, '2024-05-30 00:00:00', 16, 10, 'Subaru Model 3 2020 is a reliable and high-performance vehicle.', '21:9', 'Full-size', 'Steel', 'Japan', 1, '2024-05-30 06:13:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (229, 'Mercedes-Benz Wrangler 2024', 75215000.00, 75215000.00, 0, '2022-11-17 00:00:00', 6, 3, 'Mercedes-Benz Wrangler 2024 is a reliable and high-performance vehicle.', '4:3', 'Mid-size', 'Carbon Fiber', 'France', 1, '2022-11-17 10:21:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (230, 'Volvo X3 2025', 147641000.00, 147641000.00, 0, '2022-09-16 00:00:00', 17, 8, 'Volvo X3 2025 is a reliable and high-performance vehicle.', '4:3', 'Large', 'Composite', 'Japan', 0, '2022-09-16 01:38:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (231, 'Volvo Accord 2022', 28088000.00, 28088000.00, 0, '2023-07-03 00:00:00', 17, 2, 'Volvo Accord 2022 is a reliable and high-performance vehicle.', '4:3', 'Mini', 'Alloy', 'France', 0, '2023-07-03 06:28:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (232, 'Jeep XC60 2019', 25864000.00, 25864000.00, 0, '2023-06-27 00:00:00', 19, 1, 'Jeep XC60 2019 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Composite', 'Italy', 1, '2023-06-27 03:42:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (233, 'Mazda Taycan 2025', 80199000.00, 80199000.00, 0, '2023-12-22 00:00:00', 10, 10, 'Mazda Taycan 2025 is a reliable and high-performance vehicle.', '4:3', 'Compact', 'Composite', 'UK', 0, '2023-12-22 13:58:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (234, 'Mitsubishi X3 2019', 68293000.00, 68293000.00, 0, '2024-07-22 00:00:00', 12, 7, 'Mitsubishi X3 2019 is a reliable and high-performance vehicle.', '21:9', 'Large', 'Alloy', 'USA', 0, '2024-07-22 17:15:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (235, 'Lexus Camry 2023', 114823000.00, 114823000.00, 0, '2023-11-23 00:00:00', 15, 1, 'Lexus Camry 2023 is a reliable and high-performance vehicle.', '1:1', 'Mid-size', 'Steel', 'Japan', 0, '2023-11-23 11:59:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (236, 'Porsche Taycan 2022', 25680000.00, 25680000.00, 0, '2024-12-03 00:00:00', 14, 6, 'Porsche Taycan 2022 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Carbon Fiber', 'South Korea', 1, '2024-12-03 18:28:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (237, 'Peugeot Model 3 2024', 69957000.00, 69957000.00, 0, '2024-11-13 00:00:00', 20, 10, 'Peugeot Model 3 2024 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Alloy', 'Japan', 0, '2024-11-13 19:16:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (238, 'Volkswagen Taycan 2025', 65435000.00, 65435000.00, 0, '2023-09-18 00:00:00', 13, 5, 'Volkswagen Taycan 2025 is a reliable and high-performance vehicle.', '1:1', 'Mid-size', 'Aluminum', 'Japan', 1, '2023-09-18 13:22:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (239, 'Volkswagen Santa Fe 2023', 33658000.00, 33658000.00, 0, '2023-07-15 00:00:00', 13, 3, 'Volkswagen Santa Fe 2023 is a reliable and high-performance vehicle.', '4:3', 'Compact', 'Steel', 'South Korea', 0, '2023-07-15 12:03:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (240, 'Lexus Camry 2019', 94104000.00, 94104000.00, 0, '2022-12-30 00:00:00', 15, 4, 'Lexus Camry 2019 is a reliable and high-performance vehicle.', '21:9', 'Full-size', 'Carbon Fiber', 'South Korea', 0, '2022-12-30 19:34:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (241, 'Ford X3 2018', 113133000.00, 113133000.00, 0, '2023-07-21 00:00:00', 3, 6, 'Ford X3 2018 is a reliable and high-performance vehicle.', '4:3', 'Large', 'Carbon Fiber', 'Sweden', 1, '2023-07-21 03:03:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (242, 'Nissan Defender 2020', 30034000.00, 30034000.00, 0, '2022-08-10 00:00:00', 11, 3, 'Nissan Defender 2020 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Composite', 'France', 0, '2022-08-10 05:03:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (243, 'Subaru Mustang 2019', 95365000.00, 95365000.00, 0, '2023-07-22 00:00:00', 16, 4, 'Subaru Mustang 2019 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Alloy', 'Germany', 0, '2023-07-22 05:01:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (244, 'Ford Explorer 2025', 84763000.00, 84763000.00, 0, '2022-09-12 00:00:00', 3, 9, 'Ford Explorer 2025 is a reliable and high-performance vehicle.', '16:9', 'Large', 'Aluminum', 'Germany', 1, '2022-09-12 20:42:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (245, 'Kia C-Class 2021', 52852000.00, 52852000.00, 0, '2024-07-13 00:00:00', 9, 3, 'Kia C-Class 2021 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Alloy', 'Germany', 0, '2024-07-13 02:02:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (246, 'Volvo Explorer 2021', 59030000.00, 59030000.00, 0, '2023-01-17 00:00:00', 17, 8, 'Volvo Explorer 2021 is a reliable and high-performance vehicle.', '1:1', 'Compact', 'Steel', 'Germany', 0, '2023-01-17 22:01:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (247, 'Audi XC60 2024', 33574000.00, 33574000.00, 0, '2024-03-17 00:00:00', 7, 6, 'Audi XC60 2024 is a reliable and high-performance vehicle.', '4:3', 'Compact', 'Steel', 'USA', 1, '2024-03-17 07:40:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (248, 'Hyundai Outlander 2022', 71184000.00, 71184000.00, 0, '2024-04-30 00:00:00', 8, 10, 'Hyundai Outlander 2022 is a reliable and high-performance vehicle.', '16:9', 'Compact', 'Steel', 'Germany', 1, '2024-04-30 01:28:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (249, 'Peugeot Model 3 2018', 93372000.00, 93372000.00, 0, '2022-09-10 00:00:00', 20, 5, 'Peugeot Model 3 2018 is a reliable and high-performance vehicle.', '4:3', 'Full-size', 'Steel', 'Sweden', 1, '2022-09-10 21:55:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (250, 'Toyota Forester 2020', 38817000.00, 38817000.00, 0, '2023-03-29 00:00:00', 1, 6, 'Toyota Forester 2020 is a reliable and high-performance vehicle.', '4:3', 'Large', 'Steel', 'Italy', 1, '2023-03-29 16:15:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (251, 'Land Rover A4 2019', 107485000.00, 107485000.00, 0, '2023-05-09 00:00:00', 18, 1, 'Land Rover A4 2019 is a reliable and high-performance vehicle.', '1:1', 'Full-size', 'Composite', 'France', 0, '2023-05-09 05:33:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (252, 'Hyundai Land Cruiser 2024', 77095000.00, 77095000.00, 0, '2023-10-27 00:00:00', 8, 7, 'Hyundai Land Cruiser 2024 is a reliable and high-performance vehicle.', '4:3', 'Large', 'Aluminum', 'Italy', 0, '2023-10-27 07:45:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (253, 'Lexus Ranger 2018', 83935000.00, 83935000.00, 0, '2023-11-01 00:00:00', 15, 7, 'Lexus Ranger 2018 is a reliable and high-performance vehicle.', '21:9', 'Large', 'Aluminum', 'South Korea', 1, '2023-11-01 07:33:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (254, 'Mazda Model S 2024', 88187000.00, 88187000.00, 0, '2023-03-18 00:00:00', 10, 2, 'Mazda Model S 2024 is a reliable and high-performance vehicle.', '21:9', 'Mini', 'Carbon Fiber', 'USA', 1, '2023-03-18 20:45:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (255, 'Volvo Camry 2020', 65187000.00, 65187000.00, 0, '2024-01-31 00:00:00', 17, 3, 'Volvo Camry 2020 is a reliable and high-performance vehicle.', '21:9', 'Mid-size', 'Composite', 'France', 1, '2024-01-31 04:07:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (256, 'Mazda Wrangler 2024', 40905000.00, 40905000.00, 0, '2024-10-05 00:00:00', 10, 6, 'Mazda Wrangler 2024 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Carbon Fiber', 'Germany', 0, '2024-10-05 18:35:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (257, 'Hyundai E-Class 2024', 43352000.00, 43352000.00, 0, '2023-01-18 00:00:00', 8, 6, 'Hyundai E-Class 2024 is a reliable and high-performance vehicle.', '1:1', 'Full-size', 'Steel', 'Japan', 1, '2023-01-18 11:12:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (258, 'Ford Accord 2022', 64908000.00, 64908000.00, 0, '2022-04-22 00:00:00', 3, 5, 'Ford Accord 2022 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Alloy', 'Japan', 0, '2022-04-22 18:48:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (259, 'Chevrolet Forester 2024', 92567000.00, 92567000.00, 0, '2024-02-08 00:00:00', 4, 10, 'Chevrolet Forester 2024 is a reliable and high-performance vehicle.', '1:1', 'Mini', 'Carbon Fiber', 'Germany', 1, '2024-02-08 22:38:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (260, 'Ford E-Class 2025', 61035000.00, 61035000.00, 0, '2024-10-16 00:00:00', 3, 9, 'Ford E-Class 2025 is a reliable and high-performance vehicle.', '4:3', 'Mid-size', 'Steel', 'Sweden', 1, '2024-10-16 06:15:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (261, 'Land Rover Q7 2025', 80122000.00, 80122000.00, 0, '2024-02-10 00:00:00', 18, 2, 'Land Rover Q7 2025 is a reliable and high-performance vehicle.', '4:3', 'Large', 'Steel', 'USA', 0, '2024-02-10 07:42:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (262, 'Audi Sorento 2019', 94804000.00, 94804000.00, 0, '2022-05-13 00:00:00', 7, 1, 'Audi Sorento 2019 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Steel', 'Japan', 1, '2022-05-13 06:29:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (263, 'Hyundai F-150 2024', 91321000.00, 91321000.00, 0, '2023-12-26 00:00:00', 8, 2, 'Hyundai F-150 2024 is a reliable and high-performance vehicle.', '1:1', 'Compact', 'Composite', 'Sweden', 0, '2023-12-26 03:16:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (264, 'Mitsubishi CX-3 2018', 107926000.00, 107926000.00, 0, '2023-10-18 00:00:00', 12, 5, 'Mitsubishi CX-3 2018 is a reliable and high-performance vehicle.', '16:9', 'Large', 'Aluminum', 'UK', 0, '2023-10-18 11:50:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (265, 'Toyota Cherokee 2023', 75781000.00, 75781000.00, 0, '2022-11-23 00:00:00', 1, 7, 'Toyota Cherokee 2023 is a reliable and high-performance vehicle.', '21:9', 'Mini', 'Composite', 'Japan', 1, '2022-11-23 04:15:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (266, 'Mazda CX-8 2021', 148954000.00, 148954000.00, 0, '2023-05-16 00:00:00', 10, 9, 'Mazda CX-8 2021 is a reliable and high-performance vehicle.', '1:1', 'Compact', 'Carbon Fiber', 'UK', 0, '2023-05-16 07:20:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (267, 'Toyota Outlander 2020', 122822000.00, 122822000.00, 0, '2023-05-18 00:00:00', 1, 10, 'Toyota Outlander 2020 is a reliable and high-performance vehicle.', '4:3', 'Full-size', 'Composite', 'France', 0, '2023-05-18 03:24:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (268, 'Subaru Q7 2023', 56569000.00, 56569000.00, 0, '2023-04-15 00:00:00', 16, 1, 'Subaru Q7 2023 is a reliable and high-performance vehicle.', '1:1', 'Full-size', 'Steel', 'UK', 0, '2023-04-15 23:57:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (269, 'Volkswagen Santa Fe 2023', 65322000.00, 65322000.00, 0, '2024-10-24 00:00:00', 13, 5, 'Volkswagen Santa Fe 2023 is a reliable and high-performance vehicle.', '16:9', 'Mid-size', 'Alloy', 'Sweden', 0, '2024-10-24 07:24:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (270, 'Subaru F-150 2018', 129657000.00, 129657000.00, 0, '2023-07-03 00:00:00', 16, 9, 'Subaru F-150 2018 is a reliable and high-performance vehicle.', '1:1', 'Mid-size', 'Steel', 'Germany', 1, '2023-07-03 12:25:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (271, 'Subaru Accord 2025', 144303000.00, 144303000.00, 0, '2024-05-10 00:00:00', 16, 2, 'Subaru Accord 2025 is a reliable and high-performance vehicle.', '1:1', 'Mini', 'Composite', 'Sweden', 0, '2024-05-10 15:05:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (272, 'Mitsubishi Model S 2025', 75689000.00, 75689000.00, 0, '2024-11-14 00:00:00', 12, 3, 'Mitsubishi Model S 2025 is a reliable and high-performance vehicle.', '21:9', 'Full-size', 'Carbon Fiber', 'South Korea', 0, '2024-11-14 08:49:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (273, 'Honda Model 3 2020', 85488000.00, 85488000.00, 0, '2024-11-26 00:00:00', 2, 4, 'Honda Model 3 2020 is a reliable and high-performance vehicle.', '21:9', 'Mid-size', 'Aluminum', 'Italy', 0, '2024-11-26 10:27:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (274, 'Toyota CX-8 2018', 40102000.00, 40102000.00, 0, '2022-11-20 00:00:00', 1, 7, 'Toyota CX-8 2018 is a reliable and high-performance vehicle.', '21:9', 'Mini', 'Composite', 'Sweden', 0, '2022-11-20 11:39:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (275, 'Mazda Outlander 2023', 87873000.00, 87873000.00, 0, '2022-05-03 00:00:00', 10, 3, 'Mazda Outlander 2023 is a reliable and high-performance vehicle.', '16:9', 'Mid-size', 'Carbon Fiber', 'France', 0, '2022-05-03 05:56:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (276, 'Toyota Hilux 2025', 91660000.00, 91660000.00, 0, '2024-08-20 00:00:00', 1, 4, 'Toyota Hilux 2025 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Steel', 'Japan', 0, '2024-08-20 19:19:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (277, 'Honda Outlander 2024', 90622000.00, 90622000.00, 0, '2022-02-07 00:00:00', 2, 6, 'Honda Outlander 2024 is a reliable and high-performance vehicle.', '4:3', 'Mini', 'Steel', 'France', 1, '2022-02-07 18:41:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (278, 'Mercedes-Benz Hilux 2023', 97522000.00, 97522000.00, 0, '2023-01-01 00:00:00', 6, 7, 'Mercedes-Benz Hilux 2023 is a reliable and high-performance vehicle.', '4:3', 'Compact', 'Steel', 'Germany', 1, '2023-01-01 10:29:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (279, 'Volvo A6 2020', 123763000.00, 123763000.00, 0, '2023-08-13 00:00:00', 17, 3, 'Volvo A6 2020 is a reliable and high-performance vehicle.', '1:1', 'Full-size', 'Composite', 'Sweden', 0, '2023-08-13 15:11:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (280, 'Kia A6 2021', 56517000.00, 56517000.00, 0, '2023-02-23 00:00:00', 9, 9, 'Kia A6 2021 is a reliable and high-performance vehicle.', '4:3', 'Full-size', 'Alloy', 'France', 0, '2023-02-23 21:26:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (281, 'Volkswagen Model 3 2022', 85035000.00, 85035000.00, 0, '2022-02-04 00:00:00', 13, 3, 'Volkswagen Model 3 2022 is a reliable and high-performance vehicle.', '4:3', 'Full-size', 'Aluminum', 'Sweden', 0, '2022-02-04 06:11:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (282, 'Jeep X3 2018', 86276000.00, 86276000.00, 0, '2022-05-25 00:00:00', 19, 10, 'Jeep X3 2018 is a reliable and high-performance vehicle.', '16:9', 'Full-size', 'Aluminum', 'Sweden', 1, '2022-05-25 03:18:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (283, 'Volkswagen Santa Fe 2024', 77525000.00, 77525000.00, 0, '2023-04-28 00:00:00', 13, 7, 'Volkswagen Santa Fe 2024 is a reliable and high-performance vehicle.', '16:9', 'Mid-size', 'Alloy', 'Japan', 1, '2023-04-28 22:08:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (284, 'Subaru F-150 2022', 65812000.00, 65812000.00, 0, '2024-04-29 00:00:00', 16, 9, 'Subaru F-150 2022 is a reliable and high-performance vehicle.', '4:3', 'Large', 'Aluminum', 'France', 0, '2024-04-29 14:03:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (285, 'Toyota Santa Fe 2022', 33805000.00, 33805000.00, 0, '2023-11-03 00:00:00', 1, 2, 'Toyota Santa Fe 2022 is a reliable and high-performance vehicle.', '4:3', 'Mid-size', 'Steel', 'South Korea', 0, '2023-11-03 11:28:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (286, 'Lexus Ranger 2019', 104173000.00, 104173000.00, 0, '2024-07-17 00:00:00', 15, 9, 'Lexus Ranger 2019 is a reliable and high-performance vehicle.', '21:9', 'Large', 'Aluminum', 'Japan', 1, '2024-07-17 14:36:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (287, 'Audi Sorento 2022', 80182000.00, 80182000.00, 0, '2023-10-21 00:00:00', 7, 8, 'Audi Sorento 2022 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Aluminum', 'South Korea', 1, '2023-10-21 01:00:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (288, 'Volkswagen Tucson 2021', 22187000.00, 22187000.00, 0, '2024-01-20 00:00:00', 13, 3, 'Volkswagen Tucson 2021 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Carbon Fiber', 'Japan', 0, '2024-01-20 04:12:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (289, 'Toyota C-Class 2019', 42549000.00, 42549000.00, 0, '2023-03-25 00:00:00', 1, 7, 'Toyota C-Class 2019 is a reliable and high-performance vehicle.', '21:9', 'Large', 'Aluminum', 'UK', 1, '2023-03-25 18:22:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (290, 'Land Rover Model S 2022', 108230000.00, 108230000.00, 0, '2022-01-14 00:00:00', 18, 7, 'Land Rover Model S 2022 is a reliable and high-performance vehicle.', '16:9', 'Mid-size', 'Aluminum', 'Italy', 1, '2022-01-14 23:27:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (291, 'Kia Ranger 2024', 44659000.00, 44659000.00, 0, '2024-04-24 00:00:00', 9, 5, 'Kia Ranger 2024 is a reliable and high-performance vehicle.', '4:3', 'Compact', 'Alloy', 'Italy', 1, '2024-04-24 02:32:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (292, 'Mitsubishi X5 2025', 135917000.00, 135917000.00, 0, '2022-06-15 00:00:00', 12, 6, 'Mitsubishi X5 2025 is a reliable and high-performance vehicle.', '21:9', 'Large', 'Steel', 'Italy', 1, '2022-06-15 19:34:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (293, 'Mercedes-Benz Mustang 2025', 26615000.00, 26615000.00, 0, '2024-07-28 00:00:00', 6, 8, 'Mercedes-Benz Mustang 2025 is a reliable and high-performance vehicle.', '1:1', 'Full-size', 'Aluminum', 'Japan', 0, '2024-07-28 01:44:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (294, 'Mitsubishi X3 2022', 54672000.00, 54672000.00, 0, '2022-06-14 00:00:00', 12, 10, 'Mitsubishi X3 2022 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Composite', 'Japan', 1, '2022-06-14 11:41:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (295, 'Kia Cherokee 2021', 79878000.00, 79878000.00, 0, '2024-04-26 00:00:00', 9, 4, 'Kia Cherokee 2021 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Steel', 'France', 0, '2024-04-26 09:21:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (296, 'Peugeot Outlander 2023', 57544000.00, 57544000.00, 0, '2024-11-10 00:00:00', 20, 4, 'Peugeot Outlander 2023 is a reliable and high-performance vehicle.', '16:9', 'Full-size', 'Aluminum', 'UK', 0, '2024-11-10 13:19:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (297, 'Toyota C-Class 2024', 75039000.00, 75039000.00, 0, '2023-06-13 00:00:00', 1, 9, 'Toyota C-Class 2024 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Alloy', 'France', 0, '2023-06-13 17:36:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (298, 'Lexus Mustang 2025', 28034000.00, 28034000.00, 0, '2023-01-04 00:00:00', 15, 5, 'Lexus Mustang 2025 is a reliable and high-performance vehicle.', '1:1', 'Full-size', 'Aluminum', 'Sweden', 1, '2023-01-04 11:15:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (299, 'Lexus CX-3 2023', 120053000.00, 120053000.00, 0, '2023-07-09 00:00:00', 15, 7, 'Lexus CX-3 2023 is a reliable and high-performance vehicle.', '21:9', 'Full-size', 'Aluminum', 'Germany', 0, '2023-07-09 09:24:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (300, 'Mazda Santa Fe 2020', 145339000.00, 145339000.00, 0, '2023-07-30 00:00:00', 10, 8, 'Mazda Santa Fe 2020 is a reliable and high-performance vehicle.', '4:3', 'Large', 'Steel', 'Japan', 1, '2023-07-30 11:53:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (301, 'Nissan Defender 2021', 90118000.00, 90118000.00, 0, '2023-06-12 00:00:00', 11, 9, 'Nissan Defender 2021 is a reliable and high-performance vehicle.', '4:3', 'Mini', 'Carbon Fiber', 'France', 0, '2023-06-12 14:59:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (302, 'Mercedes-Benz Ranger 2024', 41848000.00, 41848000.00, 0, '2023-11-26 00:00:00', 6, 1, 'Mercedes-Benz Ranger 2024 is a reliable and high-performance vehicle.', '16:9', 'Mid-size', 'Steel', 'France', 0, '2023-11-26 20:58:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (303, 'Mercedes-Benz Wrangler 2021', 84187000.00, 84187000.00, 0, '2024-04-30 00:00:00', 6, 9, 'Mercedes-Benz Wrangler 2021 is a reliable and high-performance vehicle.', '4:3', 'Large', 'Composite', 'France', 0, '2024-04-30 04:21:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (304, 'BMW Civic 2018', 32203000.00, 32203000.00, 0, '2024-03-15 00:00:00', 5, 7, 'BMW Civic 2018 is a reliable and high-performance vehicle.', '1:1', 'Mid-size', 'Composite', 'Sweden', 0, '2024-03-15 15:12:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (305, 'Lexus A4 2021', 96792000.00, 96792000.00, 0, '2023-11-15 00:00:00', 15, 3, 'Lexus A4 2021 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Alloy', 'Germany', 0, '2023-11-15 00:43:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (306, 'Porsche X5 2018', 28877000.00, 28877000.00, 0, '2024-07-15 00:00:00', 14, 10, 'Porsche X5 2018 is a reliable and high-performance vehicle.', '4:3', 'Large', 'Carbon Fiber', 'Italy', 1, '2024-07-15 10:22:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (307, 'Hyundai Corolla 2024', 87614000.00, 87614000.00, 0, '2023-07-10 00:00:00', 8, 2, 'Hyundai Corolla 2024 is a reliable and high-performance vehicle.', '1:1', 'Mid-size', 'Carbon Fiber', 'Japan', 1, '2023-07-10 15:15:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (308, 'Land Rover Model 3 2024', 31173000.00, 31173000.00, 0, '2023-02-07 00:00:00', 18, 6, 'Land Rover Model 3 2024 is a reliable and high-performance vehicle.', '4:3', 'Large', 'Aluminum', 'France', 0, '2023-02-07 18:14:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (309, 'Lexus Altima 2023', 66229000.00, 66229000.00, 0, '2024-11-19 00:00:00', 15, 2, 'Lexus Altima 2023 is a reliable and high-performance vehicle.', '1:1', 'Mini', 'Composite', 'France', 0, '2024-11-19 22:36:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (310, 'Nissan Sorento 2020', 105999000.00, 105999000.00, 0, '2023-02-13 00:00:00', 11, 6, 'Nissan Sorento 2020 is a reliable and high-performance vehicle.', '1:1', 'Compact', 'Composite', 'Sweden', 1, '2023-02-13 07:45:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (311, 'Volkswagen Defender 2024', 146415000.00, 146415000.00, 0, '2022-05-03 00:00:00', 13, 10, 'Volkswagen Defender 2024 is a reliable and high-performance vehicle.', '21:9', 'Mini', 'Steel', 'Sweden', 0, '2022-05-03 07:39:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (312, 'Lexus Taycan 2024', 138103000.00, 138103000.00, 0, '2024-12-07 00:00:00', 15, 10, 'Lexus Taycan 2024 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Composite', 'Japan', 0, '2024-12-07 15:53:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (313, 'Audi Model 3 2024', 89609000.00, 89609000.00, 0, '2023-08-27 00:00:00', 7, 10, 'Audi Model 3 2024 is a reliable and high-performance vehicle.', '4:3', 'Mini', 'Carbon Fiber', 'UK', 0, '2023-08-27 02:28:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (314, 'Volvo A6 2018', 135336000.00, 135336000.00, 0, '2022-01-10 00:00:00', 17, 5, 'Volvo A6 2018 is a reliable and high-performance vehicle.', '1:1', 'Mid-size', 'Aluminum', 'UK', 0, '2022-01-10 20:07:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (315, 'BMW Wrangler 2025', 22366000.00, 22366000.00, 0, '2024-10-06 00:00:00', 5, 2, 'BMW Wrangler 2025 is a reliable and high-performance vehicle.', '1:1', 'Mini', 'Aluminum', 'USA', 0, '2024-10-06 12:12:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (316, 'Volvo A6 2018', 55971000.00, 55971000.00, 0, '2023-08-17 00:00:00', 17, 6, 'Volvo A6 2018 is a reliable and high-performance vehicle.', '21:9', 'Mini', 'Alloy', 'Germany', 0, '2023-08-17 19:29:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (317, 'Mazda Hilux 2019', 110469000.00, 110469000.00, 0, '2023-02-24 00:00:00', 10, 8, 'Mazda Hilux 2019 is a reliable and high-performance vehicle.', '4:3', 'Full-size', 'Alloy', 'USA', 1, '2023-02-24 21:27:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (318, 'Land Rover Camry 2024', 127935000.00, 127935000.00, 0, '2024-01-27 00:00:00', 18, 9, 'Land Rover Camry 2024 is a reliable and high-performance vehicle.', '4:3', 'Compact', 'Alloy', 'Japan', 1, '2024-01-27 10:03:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (319, 'Toyota Taycan 2022', 30631000.00, 30631000.00, 0, '2022-08-14 00:00:00', 1, 8, 'Toyota Taycan 2022 is a reliable and high-performance vehicle.', '16:9', 'Full-size', 'Carbon Fiber', 'USA', 0, '2022-08-14 00:04:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (320, 'Chevrolet Navara 2025', 114328000.00, 114328000.00, 0, '2024-05-24 00:00:00', 4, 2, 'Chevrolet Navara 2025 is a reliable and high-performance vehicle.', '16:9', 'Full-size', 'Composite', 'UK', 1, '2024-05-24 07:23:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (321, 'Mercedes-Benz Accord 2023', 138395000.00, 138395000.00, 0, '2023-09-07 00:00:00', 6, 4, 'Mercedes-Benz Accord 2023 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Composite', 'Japan', 1, '2023-09-07 17:20:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (322, 'Kia Sorento 2018', 109519000.00, 109519000.00, 0, '2024-08-31 00:00:00', 9, 9, 'Kia Sorento 2018 is a reliable and high-performance vehicle.', '21:9', 'Full-size', 'Carbon Fiber', 'Japan', 0, '2024-08-31 11:36:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (323, 'Chevrolet Accord 2025', 69509000.00, 69509000.00, 0, '2024-07-23 00:00:00', 4, 8, 'Chevrolet Accord 2025 is a reliable and high-performance vehicle.', '21:9', 'Large', 'Aluminum', 'France', 0, '2024-07-23 23:09:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (324, 'Volkswagen E-Class 2023', 94994000.00, 94994000.00, 0, '2024-09-09 00:00:00', 13, 1, 'Volkswagen E-Class 2023 is a reliable and high-performance vehicle.', '4:3', 'Full-size', 'Aluminum', 'Japan', 0, '2024-09-09 04:37:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (325, 'Volvo CX-8 2019', 118276000.00, 118276000.00, 0, '2022-02-19 00:00:00', 17, 4, 'Volvo CX-8 2019 is a reliable and high-performance vehicle.', '16:9', 'Compact', 'Steel', 'Italy', 1, '2022-02-19 22:29:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (326, 'Mercedes-Benz F-150 2018', 111253000.00, 111253000.00, 0, '2023-03-21 00:00:00', 6, 1, 'Mercedes-Benz F-150 2018 is a reliable and high-performance vehicle.', '4:3', 'Mid-size', 'Alloy', 'France', 0, '2023-03-21 08:35:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (327, 'BMW CX-3 2023', 88118000.00, 88118000.00, 0, '2022-03-05 00:00:00', 5, 10, 'BMW CX-3 2023 is a reliable and high-performance vehicle.', '4:3', 'Large', 'Alloy', 'Sweden', 0, '2022-03-05 05:19:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (328, 'Jeep Rio 2023', 37850000.00, 37850000.00, 0, '2024-04-17 00:00:00', 19, 8, 'Jeep Rio 2023 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Alloy', 'UK', 0, '2024-04-17 00:39:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (329, 'Lexus Corolla 2021', 128621000.00, 128621000.00, 0, '2022-08-15 00:00:00', 15, 10, 'Lexus Corolla 2021 is a reliable and high-performance vehicle.', '1:1', 'Full-size', 'Steel', 'Germany', 0, '2022-08-15 03:55:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (330, 'Hyundai Model 3 2023', 77451000.00, 77451000.00, 0, '2024-12-11 00:00:00', 8, 3, 'Hyundai Model 3 2023 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Carbon Fiber', 'USA', 1, '2024-12-11 08:33:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (331, 'Nissan F-150 2018', 22754000.00, 22754000.00, 0, '2024-03-05 00:00:00', 11, 5, 'Nissan F-150 2018 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Carbon Fiber', 'South Korea', 1, '2024-03-05 14:00:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (332, 'Lexus Accord 2018', 123936000.00, 123936000.00, 0, '2023-08-25 00:00:00', 15, 2, 'Lexus Accord 2018 is a reliable and high-performance vehicle.', '21:9', 'Full-size', 'Carbon Fiber', 'Sweden', 1, '2023-08-25 23:04:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (333, 'Mazda A4 2025', 112458000.00, 112458000.00, 0, '2023-02-15 00:00:00', 10, 5, 'Mazda A4 2025 is a reliable and high-performance vehicle.', '16:9', 'Compact', 'Steel', 'South Korea', 0, '2023-02-15 03:17:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (334, 'Lexus Navara 2020', 80993000.00, 80993000.00, 0, '2022-09-23 00:00:00', 15, 7, 'Lexus Navara 2020 is a reliable and high-performance vehicle.', '4:3', 'Full-size', 'Alloy', 'USA', 0, '2022-09-23 04:35:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (335, 'Jeep Hilux 2020', 38622000.00, 38622000.00, 0, '2024-12-27 00:00:00', 19, 2, 'Jeep Hilux 2020 is a reliable and high-performance vehicle.', '4:3', 'Mini', 'Aluminum', 'France', 1, '2024-12-27 21:16:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (336, 'Audi Q7 2025', 107933000.00, 107933000.00, 0, '2023-09-27 00:00:00', 7, 9, 'Audi Q7 2025 is a reliable and high-performance vehicle.', '1:1', 'Compact', 'Alloy', 'Sweden', 0, '2023-09-27 15:31:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (337, 'Jeep Tucson 2019', 83464000.00, 83464000.00, 0, '2024-03-03 00:00:00', 19, 9, 'Jeep Tucson 2019 is a reliable and high-performance vehicle.', '4:3', 'Compact', 'Alloy', 'UK', 0, '2024-03-03 17:50:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (338, 'Mazda Hilux 2021', 107804000.00, 107804000.00, 0, '2023-01-05 00:00:00', 10, 8, 'Mazda Hilux 2021 is a reliable and high-performance vehicle.', '1:1', 'Compact', 'Alloy', 'France', 0, '2023-01-05 15:53:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (339, 'Volkswagen Outlander 2018', 33532000.00, 33532000.00, 0, '2022-07-23 00:00:00', 13, 5, 'Volkswagen Outlander 2018 is a reliable and high-performance vehicle.', '4:3', 'Mid-size', 'Steel', 'France', 1, '2022-07-23 05:16:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (340, 'Mitsubishi Wrangler 2025', 145089000.00, 145089000.00, 0, '2023-01-19 00:00:00', 12, 5, 'Mitsubishi Wrangler 2025 is a reliable and high-performance vehicle.', '21:9', 'Full-size', 'Steel', 'South Korea', 1, '2023-01-19 22:14:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (341, 'Mazda Navara 2021', 22913000.00, 22913000.00, 0, '2022-02-15 00:00:00', 10, 10, 'Mazda Navara 2021 is a reliable and high-performance vehicle.', '21:9', 'Mini', 'Carbon Fiber', 'France', 1, '2022-02-15 09:15:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (342, 'Chevrolet CX-5 2019', 44233000.00, 44233000.00, 0, '2022-08-23 00:00:00', 4, 4, 'Chevrolet CX-5 2019 is a reliable and high-performance vehicle.', '4:3', 'Mini', 'Steel', 'South Korea', 1, '2022-08-23 16:25:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (343, 'Land Rover Accord 2025', 99580000.00, 99580000.00, 0, '2024-05-09 00:00:00', 18, 1, 'Land Rover Accord 2025 is a reliable and high-performance vehicle.', '1:1', 'Compact', 'Composite', 'Italy', 1, '2024-05-09 14:35:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (344, 'Mitsubishi A6 2021', 34342000.00, 34342000.00, 0, '2023-06-01 00:00:00', 12, 3, 'Mitsubishi A6 2021 is a reliable and high-performance vehicle.', '16:9', 'Full-size', 'Aluminum', 'Italy', 1, '2023-06-01 22:40:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (345, 'Volvo Model 3 2025', 92813000.00, 92813000.00, 0, '2024-01-30 00:00:00', 17, 1, 'Volvo Model 3 2025 is a reliable and high-performance vehicle.', '21:9', 'Large', 'Steel', 'Japan', 0, '2024-01-30 22:46:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (346, 'Porsche Defender 2018', 117920000.00, 117920000.00, 0, '2022-03-08 00:00:00', 14, 6, 'Porsche Defender 2018 is a reliable and high-performance vehicle.', '21:9', 'Full-size', 'Aluminum', 'South Korea', 1, '2022-03-08 07:00:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (347, 'Toyota CX-8 2023', 129349000.00, 129349000.00, 0, '2023-03-25 00:00:00', 1, 5, 'Toyota CX-8 2023 is a reliable and high-performance vehicle.', '21:9', 'Full-size', 'Aluminum', 'South Korea', 1, '2023-03-25 11:35:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (348, 'Lexus A4 2020', 127709000.00, 127709000.00, 0, '2023-11-23 00:00:00', 15, 6, 'Lexus A4 2020 is a reliable and high-performance vehicle.', '4:3', 'Full-size', 'Aluminum', 'France', 1, '2023-11-23 12:03:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (349, 'Lexus Q7 2019', 87740000.00, 87740000.00, 0, '2022-02-06 00:00:00', 15, 8, 'Lexus Q7 2019 is a reliable and high-performance vehicle.', '21:9', 'Mid-size', 'Alloy', 'South Korea', 0, '2022-02-06 03:56:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (350, 'Kia Ranger 2025', 126555000.00, 126555000.00, 0, '2022-01-04 00:00:00', 9, 7, 'Kia Ranger 2025 is a reliable and high-performance vehicle.', '21:9', 'Full-size', 'Composite', 'France', 0, '2022-01-04 15:49:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (351, 'Mitsubishi XC90 2023', 23456000.00, 23456000.00, 0, '2024-02-10 00:00:00', 12, 9, 'Mitsubishi XC90 2023 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Aluminum', 'Japan', 0, '2024-02-10 08:03:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (352, 'Chevrolet Tucson 2023', 27133000.00, 27133000.00, 0, '2022-06-13 00:00:00', 4, 1, 'Chevrolet Tucson 2023 is a reliable and high-performance vehicle.', '4:3', 'Large', 'Alloy', 'Italy', 0, '2022-06-13 23:45:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (353, 'Volkswagen RX350 2019', 35818000.00, 35818000.00, 0, '2024-03-04 00:00:00', 13, 4, 'Volkswagen RX350 2019 is a reliable and high-performance vehicle.', '4:3', 'Full-size', 'Composite', 'UK', 1, '2024-03-04 07:51:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (354, 'Mazda Tucson 2024', 115914000.00, 115914000.00, 0, '2022-01-05 00:00:00', 10, 8, 'Mazda Tucson 2024 is a reliable and high-performance vehicle.', '21:9', 'Mini', 'Alloy', 'Sweden', 0, '2022-01-05 02:01:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (355, 'BMW Sorento 2023', 29269000.00, 29269000.00, 0, '2023-06-22 00:00:00', 5, 7, 'BMW Sorento 2023 is a reliable and high-performance vehicle.', '16:9', 'Mid-size', 'Composite', 'Sweden', 1, '2023-06-22 22:37:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (356, 'Subaru Taycan 2023', 131451000.00, 131451000.00, 0, '2023-08-03 00:00:00', 16, 8, 'Subaru Taycan 2023 is a reliable and high-performance vehicle.', '21:9', 'Large', 'Aluminum', 'Italy', 1, '2023-08-03 21:11:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (357, 'Lexus Rio 2018', 147205000.00, 147205000.00, 0, '2024-01-02 00:00:00', 15, 6, 'Lexus Rio 2018 is a reliable and high-performance vehicle.', '1:1', 'Mini', 'Carbon Fiber', 'Sweden', 1, '2024-01-02 05:25:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (358, 'Audi C-Class 2018', 142862000.00, 142862000.00, 0, '2023-08-03 00:00:00', 7, 6, 'Audi C-Class 2018 is a reliable and high-performance vehicle.', '4:3', 'Compact', 'Aluminum', 'Italy', 1, '2023-08-03 04:23:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (359, 'Mazda Passat 2023', 91732000.00, 91732000.00, 0, '2023-05-13 00:00:00', 10, 3, 'Mazda Passat 2023 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Composite', 'France', 1, '2023-05-13 03:36:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (360, 'Toyota Altima 2020', 57330000.00, 57330000.00, 0, '2024-04-08 00:00:00', 1, 3, 'Toyota Altima 2020 is a reliable and high-performance vehicle.', '21:9', 'Full-size', 'Composite', 'Japan', 0, '2024-04-08 14:46:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (361, 'Chevrolet Cherokee 2024', 131350000.00, 131350000.00, 0, '2023-08-14 00:00:00', 4, 3, 'Chevrolet Cherokee 2024 is a reliable and high-performance vehicle.', '16:9', 'Large', 'Aluminum', 'UK', 1, '2023-08-14 10:16:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (362, 'Subaru F-150 2021', 109197000.00, 109197000.00, 0, '2022-03-21 00:00:00', 16, 1, 'Subaru F-150 2021 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Composite', 'France', 0, '2022-03-21 17:33:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (363, 'Honda Explorer 2021', 76323000.00, 76323000.00, 0, '2024-04-11 00:00:00', 2, 6, 'Honda Explorer 2021 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Alloy', 'UK', 0, '2024-04-11 19:59:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (364, 'Mercedes-Benz Sorento 2018', 131167000.00, 131167000.00, 0, '2024-12-12 00:00:00', 6, 5, 'Mercedes-Benz Sorento 2018 is a reliable and high-performance vehicle.', '4:3', 'Compact', 'Composite', 'Italy', 0, '2024-12-12 00:03:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (365, 'Jeep Corolla 2018', 102557000.00, 102557000.00, 0, '2024-05-22 00:00:00', 19, 5, 'Jeep Corolla 2018 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Steel', 'USA', 0, '2024-05-22 17:13:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (366, 'Lexus CX-3 2023', 133110000.00, 133110000.00, 0, '2022-10-27 00:00:00', 15, 7, 'Lexus CX-3 2023 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Carbon Fiber', 'Sweden', 1, '2022-10-27 01:54:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (367, 'Mitsubishi E-Class 2024', 69872000.00, 69872000.00, 0, '2023-08-03 00:00:00', 12, 9, 'Mitsubishi E-Class 2024 is a reliable and high-performance vehicle.', '21:9', 'Mid-size', 'Carbon Fiber', 'France', 0, '2023-08-03 17:50:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (368, 'BMW Rio 2025', 113493000.00, 113493000.00, 0, '2022-05-26 00:00:00', 5, 7, 'BMW Rio 2025 is a reliable and high-performance vehicle.', '1:1', 'Compact', 'Steel', 'Italy', 1, '2022-05-26 07:58:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (369, 'Peugeot X3 2018', 71423000.00, 71423000.00, 0, '2022-07-22 00:00:00', 20, 3, 'Peugeot X3 2018 is a reliable and high-performance vehicle.', '4:3', 'Compact', 'Composite', 'Sweden', 0, '2022-07-22 17:25:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (370, 'Lexus XC60 2023', 25551000.00, 25551000.00, 0, '2022-03-16 00:00:00', 15, 2, 'Lexus XC60 2023 is a reliable and high-performance vehicle.', '1:1', 'Compact', 'Aluminum', 'South Korea', 1, '2022-03-16 01:43:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (371, 'Hyundai Q5 2025', 28699000.00, 28699000.00, 0, '2022-10-21 00:00:00', 8, 7, 'Hyundai Q5 2025 is a reliable and high-performance vehicle.', '16:9', 'Large', 'Composite', 'USA', 1, '2022-10-21 01:26:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (372, 'Peugeot Altima 2024', 141554000.00, 141554000.00, 0, '2024-12-16 00:00:00', 20, 5, 'Peugeot Altima 2024 is a reliable and high-performance vehicle.', '16:9', 'Compact', 'Aluminum', 'UK', 1, '2024-12-16 20:59:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (373, 'Honda XC90 2024', 143794000.00, 143794000.00, 0, '2022-09-16 00:00:00', 2, 7, 'Honda XC90 2024 is a reliable and high-performance vehicle.', '16:9', 'Full-size', 'Alloy', 'Italy', 1, '2022-09-16 06:49:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (374, 'Mercedes-Benz Passat 2018', 31648000.00, 31648000.00, 0, '2023-01-15 00:00:00', 6, 9, 'Mercedes-Benz Passat 2018 is a reliable and high-performance vehicle.', '1:1', 'Full-size', 'Alloy', 'Italy', 0, '2023-01-15 08:59:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (375, 'Land Rover Model S 2021', 43553000.00, 43553000.00, 0, '2024-08-24 00:00:00', 18, 5, 'Land Rover Model S 2021 is a reliable and high-performance vehicle.', '4:3', 'Compact', 'Aluminum', 'Germany', 1, '2024-08-24 12:38:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (376, 'Land Rover Civic 2022', 149444000.00, 149444000.00, 0, '2024-01-23 00:00:00', 18, 3, 'Land Rover Civic 2022 is a reliable and high-performance vehicle.', '4:3', 'Mini', 'Alloy', 'France', 1, '2024-01-23 19:59:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (377, 'Mercedes-Benz Defender 2022', 103793000.00, 103793000.00, 0, '2022-01-11 00:00:00', 6, 1, 'Mercedes-Benz Defender 2022 is a reliable and high-performance vehicle.', '1:1', 'Compact', 'Steel', 'Sweden', 1, '2022-01-11 06:39:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (378, 'Jeep E-Class 2022', 55052000.00, 55052000.00, 0, '2023-06-10 00:00:00', 19, 10, 'Jeep E-Class 2022 is a reliable and high-performance vehicle.', '21:9', 'Mini', 'Alloy', 'Japan', 0, '2023-06-10 22:24:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (379, 'BMW Camry 2025', 145893000.00, 145893000.00, 0, '2024-02-04 00:00:00', 5, 1, 'BMW Camry 2025 is a reliable and high-performance vehicle.', '21:9', 'Mini', 'Composite', 'France', 1, '2024-02-04 09:32:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (380, 'Volvo X5 2019', 41491000.00, 41491000.00, 0, '2022-10-27 00:00:00', 17, 6, 'Volvo X5 2019 is a reliable and high-performance vehicle.', '1:1', 'Mid-size', 'Composite', 'France', 0, '2022-10-27 05:23:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (381, 'Chevrolet Wrangler 2025', 121223000.00, 121223000.00, 0, '2023-12-24 00:00:00', 4, 9, 'Chevrolet Wrangler 2025 is a reliable and high-performance vehicle.', '16:9', 'Compact', 'Carbon Fiber', 'South Korea', 0, '2023-12-24 10:44:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (382, 'Volkswagen Outlander 2024', 57471000.00, 57471000.00, 0, '2024-12-11 00:00:00', 13, 8, 'Volkswagen Outlander 2024 is a reliable and high-performance vehicle.', '16:9', 'Mid-size', 'Steel', 'South Korea', 0, '2024-12-11 07:23:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (383, 'Kia RX350 2020', 126343000.00, 126343000.00, 0, '2024-09-09 00:00:00', 9, 1, 'Kia RX350 2020 is a reliable and high-performance vehicle.', '4:3', 'Mini', 'Alloy', 'South Korea', 1, '2024-09-09 00:17:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (384, 'Land Rover Ranger 2019', 20224000.00, 20224000.00, 0, '2024-06-18 00:00:00', 18, 8, 'Land Rover Ranger 2019 is a reliable and high-performance vehicle.', '21:9', 'Mini', 'Composite', 'France', 0, '2024-06-18 23:23:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (385, 'Ford Santa Fe 2021', 67193000.00, 67193000.00, 0, '2022-04-15 00:00:00', 3, 1, 'Ford Santa Fe 2021 is a reliable and high-performance vehicle.', '16:9', 'Compact', 'Alloy', 'Japan', 1, '2022-04-15 05:00:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (386, 'Chevrolet Navara 2021', 107998000.00, 107998000.00, 0, '2022-05-23 00:00:00', 4, 7, 'Chevrolet Navara 2021 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Steel', 'South Korea', 1, '2022-05-23 10:48:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (387, 'BMW Tucson 2018', 63873000.00, 63873000.00, 0, '2023-03-18 00:00:00', 5, 4, 'BMW Tucson 2018 is a reliable and high-performance vehicle.', '4:3', 'Compact', 'Composite', 'UK', 1, '2023-03-18 23:08:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (388, 'Porsche Explorer 2023', 69414000.00, 69414000.00, 0, '2022-04-19 00:00:00', 14, 4, 'Porsche Explorer 2023 is a reliable and high-performance vehicle.', '4:3', 'Mini', 'Alloy', 'South Korea', 0, '2022-04-19 11:04:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (389, 'Kia Navara 2022', 30415000.00, 30415000.00, 0, '2024-08-01 00:00:00', 9, 8, 'Kia Navara 2022 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Composite', 'UK', 0, '2024-08-01 22:24:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (390, 'Honda Camry 2022', 98191000.00, 98191000.00, 0, '2022-05-21 00:00:00', 2, 1, 'Honda Camry 2022 is a reliable and high-performance vehicle.', '21:9', 'Compact', 'Aluminum', 'Sweden', 1, '2022-05-21 14:16:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (391, 'Audi Passat 2023', 130612000.00, 130612000.00, 0, '2022-03-29 00:00:00', 7, 4, 'Audi Passat 2023 is a reliable and high-performance vehicle.', '4:3', 'Mid-size', 'Alloy', 'Italy', 1, '2022-03-29 22:48:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (392, 'Porsche CX-3 2023', 59265000.00, 59265000.00, 0, '2024-06-27 00:00:00', 14, 10, 'Porsche CX-3 2023 is a reliable and high-performance vehicle.', '21:9', 'Large', 'Alloy', 'Japan', 0, '2024-06-27 16:34:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (393, 'Chevrolet Accord 2022', 126099000.00, 126099000.00, 0, '2022-06-18 00:00:00', 4, 10, 'Chevrolet Accord 2022 is a reliable and high-performance vehicle.', '16:9', 'Mid-size', 'Steel', 'Italy', 0, '2022-06-18 00:32:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (394, 'Volvo CX-8 2020', 141157000.00, 141157000.00, 0, '2023-02-18 00:00:00', 17, 9, 'Volvo CX-8 2020 is a reliable and high-performance vehicle.', '1:1', 'Full-size', 'Steel', 'Japan', 0, '2023-02-18 03:07:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (395, 'Jeep X3 2024', 22203000.00, 22203000.00, 0, '2023-05-16 00:00:00', 19, 2, 'Jeep X3 2024 is a reliable and high-performance vehicle.', '21:9', 'Mini', 'Aluminum', 'Italy', 0, '2023-05-16 20:31:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (396, 'Volkswagen Q5 2018', 81870000.00, 81870000.00, 0, '2023-04-14 00:00:00', 13, 7, 'Volkswagen Q5 2018 is a reliable and high-performance vehicle.', '1:1', 'Large', 'Steel', 'Germany', 1, '2023-04-14 03:48:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (397, 'Lexus RX350 2025', 125268000.00, 125268000.00, 0, '2024-08-02 00:00:00', 15, 8, 'Lexus RX350 2025 is a reliable and high-performance vehicle.', '21:9', 'Large', 'Steel', 'Italy', 0, '2024-08-02 09:03:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (398, 'Mazda CX-3 2019', 111768000.00, 111768000.00, 0, '2022-06-30 00:00:00', 10, 8, 'Mazda CX-3 2019 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Composite', 'Sweden', 1, '2022-06-30 04:40:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (399, 'Hyundai Navara 2023', 113539000.00, 113539000.00, 0, '2022-01-03 00:00:00', 8, 9, 'Hyundai Navara 2023 is a reliable and high-performance vehicle.', '16:9', 'Mini', 'Composite', 'South Korea', 1, '2022-01-03 14:34:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (400, 'Chevrolet C-Class 2024', 135790000.00, 135790000.00, 0, '2024-04-23 00:00:00', 4, 1, 'Chevrolet C-Class 2024 is a reliable and high-performance vehicle.', '4:3', 'Mid-size', 'Aluminum', 'USA', 0, '2024-04-23 19:43:00', '2026-05-15 00:00:00');
INSERT INTO `product` VALUES (406, 'Mecedes v500', 1700000.00, 1700000.00, 0, NULL, 6, 3, 'Đẹp', '1:30', '28x14x7', 'Hợp kim', 'China', 1, '2026-05-20 08:51:04', '2026-05-20 08:51:04');
INSERT INTO `product` VALUES (408, 'Deepseek v4 flash', 100000.00, 100000.00, 0, NULL, 6, 2, 'Đẹp lắm', '1:30', '28x14x7', 'Hợp kim', 'ChinaUSA', 1, '2026-05-24 21:07:36', '2026-05-24 22:46:07');
INSERT INTO `product` VALUES (409, 'Toyota a1', 120000.00, 1200.00, 99, '2026-06-04 18:19:15', 13, 10, 'vvv', '1:30', '28x14x7', 'Hợp kim', 'ChinaUSA', 1, '2026-05-26 09:36:12', '2026-06-04 00:00:00');

-- ----------------------------
-- Table structure for product_variants
-- ----------------------------
DROP TABLE IF EXISTS `product_variants`;
CREATE TABLE `product_variants`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `price` decimal(12, 2) NULL DEFAULT NULL,
  `final_price` decimal(10, 2) NULL DEFAULT NULL,
  `sku` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `quantity` int NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sku`(`sku` ASC) USING BTREE,
  INDEX `product_id`(`product_id` ASC) USING BTREE,
  CONSTRAINT `product_variants_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 601 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_variants
-- ----------------------------
INSERT INTO `product_variants` VALUES (7, 2, 'Đỏ', 4200000.00, NULL, 'MITRED', 78, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (8, 2, 'Xanh', 4200000.00, NULL, 'MITBLU', 21, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (11, 3, 'Đỏ', 5100000.00, NULL, 'BMWRED', 54, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (12, 3, 'Xanh', 5100000.00, NULL, 'BMWBLU', 87, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (13, 4, 'Trắng', 3900000.00, NULL, 'VOLWHI', 62, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (14, 4, 'Đen', 3900000.00, NULL, 'VOLBLA', 31, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (15, 4, 'Đỏ', 3900000.00, NULL, 'VOLRED', 18, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (16, 4, 'Xanh', 3900000.00, NULL, 'VOLBLU', 74, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (17, 5, 'Trắng', 2800000.00, NULL, 'FORWHI', 49, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (301, 1, 'Trắng', 3500000.00, NULL, '001WHI', 23, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (302, 1, 'Đen', 3500000.00, NULL, '001BLA', 45, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (303, 1, 'Đỏ', 3500000.00, NULL, '001RED', 12, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (304, 1, 'Xanh', 3500000.00, NULL, '001BLU', 67, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (305, 2, 'Trắng', 4200000.00, NULL, '002WHI', 34, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (306, 2, 'Đen', 4200000.00, NULL, '002BLA', 56, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (307, 2, 'Đỏ', 4200000.00, NULL, '002RED', 78, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (308, 2, 'Xanh', 4200000.00, NULL, '002BLU', 21, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (309, 3, 'Trắng', 5100000.00, NULL, '003WHI', 43, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (310, 3, 'Đen', 5100000.00, NULL, '003BLA', 29, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (311, 3, 'Đỏ', 5100000.00, NULL, '003RED', 54, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (312, 3, 'Xanh', 5100000.00, NULL, '003BLU', 87, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (313, 4, 'Trắng', 3900000.00, NULL, '004WHI', 62, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (314, 4, 'Đen', 3900000.00, NULL, '004BLA', 31, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (315, 4, 'Đỏ', 3900000.00, NULL, '004RED', 18, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (316, 4, 'Xanh', 3900000.00, NULL, '004BLU', 74, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (317, 5, 'Trắng', 2800000.00, NULL, '005WHI', 49, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (318, 5, 'Đen', 2800000.00, NULL, '005BLA', 33, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (319, 5, 'Đỏ', 2800000.00, NULL, '005RED', 82, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (320, 5, 'Xanh', 2800000.00, NULL, '005BLU', 56, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (321, 6, 'Trắng', 3200000.00, NULL, '006WHI', 27, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (322, 6, 'Đen', 3200000.00, NULL, '006BLA', 61, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (323, 6, 'Đỏ', 3200000.00, NULL, '006RED', 44, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (324, 6, 'Xanh', 3200000.00, NULL, '006BLU', 19, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (325, 7, 'Trắng', 3800000.00, NULL, '007WHI', 73, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (326, 7, 'Đen', 3800000.00, NULL, '007BLA', 28, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (327, 7, 'Đỏ', 3800000.00, NULL, '007RED', 55, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (328, 7, 'Xanh', 3800000.00, NULL, '007BLU', 91, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (329, 8, 'Trắng', 4500000.00, NULL, '008WHI', 36, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (330, 8, 'Đen', 4500000.00, NULL, '008BLA', 47, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (331, 8, 'Đỏ', 4500000.00, NULL, '008RED', 58, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (332, 8, 'Xanh', 4500000.00, NULL, '008BLU', 12, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (333, 9, 'Trắng', 2900000.00, NULL, '009WHI', 84, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (334, 9, 'Đen', 2900000.00, NULL, '009BLA', 39, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (335, 9, 'Đỏ', 2900000.00, NULL, '009RED', 63, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (336, 9, 'Xanh', 2900000.00, NULL, '009BLU', 21, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (337, 10, 'Trắng', 4100000.00, NULL, '010WHI', 52, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (338, 10, 'Đen', 4100000.00, NULL, '010BLA', 17, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (339, 10, 'Đỏ', 4100000.00, NULL, '010RED', 45, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (340, 10, 'Xanh', 4100000.00, NULL, '010BLU', 78, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (341, 11, 'Trắng', 3600000.00, NULL, '011WHI', 66, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (342, 11, 'Đen', 3600000.00, NULL, '011BLA', 24, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (343, 11, 'Đỏ', 3600000.00, NULL, '011RED', 79, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (344, 11, 'Xanh', 3600000.00, NULL, '011BLU', 33, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (345, 12, 'Trắng', 3100000.00, NULL, '012WHI', 48, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (346, 12, 'Đen', 3100000.00, NULL, '012BLA', 65, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (347, 12, 'Đỏ', 3100000.00, NULL, '012RED', 14, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (348, 12, 'Xanh', 3100000.00, NULL, '012BLU', 82, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (349, 13, 'Trắng', 4900000.00, NULL, '013WHI', 37, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (350, 13, 'Đen', 4900000.00, NULL, '013BLA', 59, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (351, 13, 'Đỏ', 4900000.00, NULL, '013RED', 22, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (352, 13, 'Xanh', 4900000.00, NULL, '013BLU', 88, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (353, 14, 'Trắng', 5000000.00, NULL, '014WHI', 46, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (354, 14, 'Đen', 5000000.00, NULL, '014BLA', 73, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (355, 14, 'Đỏ', 5000000.00, NULL, '014RED', 29, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (356, 14, 'Xanh', 5000000.00, NULL, '014BLU', 61, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (357, 15, 'Trắng', 4700000.00, NULL, '015WHI', 53, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (358, 15, 'Đen', 4700000.00, NULL, '015BLA', 18, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (359, 15, 'Đỏ', 4700000.00, NULL, '015RED', 74, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (360, 15, 'Xanh', 4700000.00, NULL, '015BLU', 41, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (361, 16, 'Trắng', 3300000.00, NULL, '016WHI', 25, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (362, 16, 'Đen', 3300000.00, NULL, '016BLA', 68, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (363, 16, 'Đỏ', 3300000.00, NULL, '016RED', 32, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (364, 16, 'Xanh', 3300000.00, NULL, '016BLU', 94, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (365, 17, 'Trắng', 3700000.00, NULL, '017WHI', 57, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (366, 17, 'Đen', 3700000.00, NULL, '017BLA', 13, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (367, 17, 'Đỏ', 3700000.00, NULL, '017RED', 86, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (368, 17, 'Xanh', 3700000.00, NULL, '017BLU', 39, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (369, 18, 'Trắng', 3400000.00, NULL, '018WHI', 71, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (370, 18, 'Đen', 3400000.00, NULL, '018BLA', 27, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (371, 18, 'Đỏ', 3400000.00, NULL, '018RED', 44, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (372, 18, 'Xanh', 3400000.00, NULL, '018BLU', 62, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (373, 19, 'Trắng', 4400000.00, NULL, '019WHI', 15, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (374, 19, 'Đen', 4400000.00, NULL, '019BLA', 48, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (375, 19, 'Đỏ', 4400000.00, NULL, '019RED', 79, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (376, 19, 'Xanh', 4400000.00, NULL, '019BLU', 33, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (377, 20, 'Trắng', 4000000.00, NULL, '020WHI', 51, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (378, 20, 'Đen', 4000000.00, NULL, '020BLA', 69, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (379, 20, 'Đỏ', 4000000.00, NULL, '020RED', 24, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (380, 20, 'Xanh', 4000000.00, NULL, '020BLU', 77, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (381, 21, 'Trắng', 5300000.00, NULL, '021WHI', 38, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (382, 21, 'Đen', 5300000.00, NULL, '021BLA', 55, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (383, 21, 'Đỏ', 5300000.00, NULL, '021RED', 67, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (384, 21, 'Xanh', 5300000.00, NULL, '021BLU', 19, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (385, 22, 'Trắng', 4200000.00, NULL, '022WHI', 72, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (386, 22, 'Đen', 4200000.00, NULL, '022BLA', 31, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (387, 22, 'Đỏ', 4200000.00, NULL, '022RED', 58, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (388, 22, 'Xanh', 4200000.00, NULL, '022BLU', 14, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (389, 23, 'Trắng', 5600000.00, NULL, '023WHI', 47, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (390, 23, 'Đen', 5600000.00, NULL, '023BLA', 26, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (391, 23, 'Đỏ', 5600000.00, NULL, '023RED', 63, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (392, 23, 'Xanh', 5600000.00, NULL, '023BLU', 82, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (393, 24, 'Trắng', 4300000.00, NULL, '024WHI', 35, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (394, 24, 'Đen', 4300000.00, NULL, '024BLA', 54, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (395, 24, 'Đỏ', 4300000.00, NULL, '024RED', 41, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (396, 24, 'Xanh', 4300000.00, NULL, '024BLU', 78, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (397, 25, 'Trắng', 3800000.00, NULL, '025WHI', 64, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (398, 25, 'Đen', 3800000.00, NULL, '025BLA', 29, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (399, 25, 'Đỏ', 3800000.00, NULL, '025RED', 53, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (400, 25, 'Xanh', 3800000.00, NULL, '025BLU', 17, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (401, 26, 'Trắng', 3600000.00, NULL, '026WHI', 48, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (402, 26, 'Đen', 3600000.00, NULL, '026BLA', 62, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (403, 26, 'Đỏ', 3600000.00, NULL, '026RED', 25, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (404, 26, 'Xanh', 3600000.00, NULL, '026BLU', 79, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (405, 27, 'Trắng', 3400000.00, NULL, '027WHI', 31, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (406, 27, 'Đen', 3400000.00, NULL, '027BLA', 58, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (407, 27, 'Đỏ', 3400000.00, NULL, '027RED', 46, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (408, 27, 'Xanh', 3400000.00, NULL, '027BLU', 84, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (409, 28, 'Trắng', 3900000.00, NULL, '028WHI', 22, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (410, 28, 'Đen', 3900000.00, NULL, '028BLA', 74, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (411, 28, 'Đỏ', 3900000.00, NULL, '028RED', 39, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (412, 28, 'Xanh', 3900000.00, NULL, '028BLU', 61, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (413, 29, 'Trắng', 4600000.00, NULL, '029WHI', 55, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (414, 29, 'Đen', 4600000.00, NULL, '029BLA', 27, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (415, 29, 'Đỏ', 4600000.00, NULL, '029RED', 43, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (416, 29, 'Xanh', 4600000.00, NULL, '029BLU', 68, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (417, 30, 'Trắng', 5400000.00, NULL, '030WHI', 33, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (418, 30, 'Đen', 5400000.00, NULL, '030BLA', 59, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (419, 30, 'Đỏ', 5400000.00, NULL, '030RED', 71, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (420, 30, 'Xanh', 5400000.00, NULL, '030BLU', 16, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (421, 31, 'Trắng', 3100000.00, NULL, '031WHI', 67, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (422, 31, 'Đen', 3100000.00, NULL, '031BLA', 24, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (423, 31, 'Đỏ', 3100000.00, NULL, '031RED', 49, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (424, 31, 'Xanh', 3100000.00, NULL, '031BLU', 85, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (425, 32, 'Trắng', 3800000.00, NULL, '032WHI', 42, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (426, 32, 'Đen', 3800000.00, NULL, '032BLA', 76, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (427, 32, 'Đỏ', 3800000.00, NULL, '032RED', 28, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (428, 32, 'Xanh', 3800000.00, NULL, '032BLU', 55, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (429, 33, 'Trắng', 4100000.00, NULL, '033WHI', 33, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (430, 33, 'Đen', 4100000.00, NULL, '033BLA', 67, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (431, 33, 'Đỏ', 4100000.00, NULL, '033RED', 45, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (432, 33, 'Xanh', 4100000.00, NULL, '033BLU', 19, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (433, 34, 'Trắng', 4500000.00, NULL, '034WHI', 52, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (434, 34, 'Đen', 4500000.00, NULL, '034BLA', 38, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (435, 34, 'Đỏ', 4500000.00, NULL, '034RED', 64, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (436, 34, 'Xanh', 4500000.00, NULL, '034BLU', 22, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (437, 35, 'Trắng', 3600000.00, NULL, '035WHI', 58, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (438, 35, 'Đen', 3600000.00, NULL, '035BLA', 13, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (439, 35, 'Đỏ', 3600000.00, NULL, '035RED', 77, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (440, 35, 'Xanh', 3600000.00, NULL, '035BLU', 44, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (441, 36, 'Trắng', 4800000.00, NULL, '036WHI', 29, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (442, 36, 'Đen', 4800000.00, NULL, '036BLA', 56, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (443, 36, 'Đỏ', 4800000.00, NULL, '036RED', 83, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (444, 36, 'Xanh', 4800000.00, NULL, '036BLU', 41, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (445, 37, 'Trắng', 4300000.00, NULL, '037WHI', 66, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (446, 37, 'Đen', 4300000.00, NULL, '037BLA', 24, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (447, 37, 'Đỏ', 4300000.00, NULL, '037RED', 79, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (448, 37, 'Xanh', 4300000.00, NULL, '037BLU', 32, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (449, 38, 'Trắng', 4400000.00, NULL, '038WHI', 51, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (450, 38, 'Đen', 4400000.00, NULL, '038BLA', 37, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (451, 38, 'Đỏ', 4400000.00, NULL, '038RED', 64, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (452, 38, 'Xanh', 4400000.00, NULL, '038BLU', 15, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (453, 39, 'Trắng', 3900000.00, NULL, '039WHI', 48, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (454, 39, 'Đen', 3900000.00, NULL, '039BLA', 72, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (455, 39, 'Đỏ', 3900000.00, NULL, '039RED', 26, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (456, 39, 'Xanh', 3900000.00, NULL, '039BLU', 59, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (457, 40, 'Trắng', 3000000.00, NULL, '040WHI', 34, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (458, 40, 'Đen', 3000000.00, NULL, '040BLA', 68, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (459, 40, 'Đỏ', 3000000.00, NULL, '040RED', 47, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (460, 40, 'Xanh', 3000000.00, NULL, '040BLU', 81, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (461, 41, 'Trắng', 3700000.00, NULL, '041WHI', 23, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (462, 41, 'Đen', 3700000.00, NULL, '041BLA', 54, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (463, 41, 'Đỏ', 3700000.00, NULL, '041RED', 76, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (464, 41, 'Xanh', 3700000.00, NULL, '041BLU', 39, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (465, 42, 'Trắng', 4700000.00, NULL, '042WHI', 62, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (466, 42, 'Đen', 4700000.00, NULL, '042BLA', 28, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (467, 42, 'Đỏ', 4700000.00, NULL, '042RED', 55, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (468, 42, 'Xanh', 4700000.00, NULL, '042BLU', 43, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (469, 43, 'Trắng', 3500000.00, NULL, '043WHI', 77, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (470, 43, 'Đen', 3500000.00, NULL, '043BLA', 21, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (471, 43, 'Đỏ', 3500000.00, NULL, '043RED', 65, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (472, 43, 'Xanh', 3500000.00, NULL, '043BLU', 49, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (473, 44, 'Trắng', 5200000.00, NULL, '044WHI', 36, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (474, 44, 'Đen', 5200000.00, NULL, '044BLA', 58, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (475, 44, 'Đỏ', 5200000.00, NULL, '044RED', 27, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (476, 44, 'Xanh', 5200000.00, NULL, '044BLU', 82, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (477, 45, 'Trắng', 5000000.00, NULL, '045WHI', 45, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (478, 45, 'Đen', 5000000.00, NULL, '045BLA', 69, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (479, 45, 'Đỏ', 5000000.00, NULL, '045RED', 38, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (480, 45, 'Xanh', 5000000.00, NULL, '045BLU', 61, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (481, 46, 'Trắng', 4600000.00, NULL, '046WHI', 53, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (482, 46, 'Đen', 4600000.00, NULL, '046BLA', 17, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (483, 46, 'Đỏ', 4600000.00, NULL, '046RED', 84, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (484, 46, 'Xanh', 4600000.00, NULL, '046BLU', 42, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (485, 47, 'Trắng', 5800000.00, NULL, '047WHI', 29, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (486, 47, 'Đen', 5800000.00, NULL, '047BLA', 63, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (487, 47, 'Đỏ', 5800000.00, NULL, '047RED', 57, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (488, 47, 'Xanh', 5800000.00, NULL, '047BLU', 35, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (489, 48, 'Trắng', 4100000.00, NULL, '048WHI', 68, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (490, 48, 'Đen', 4100000.00, NULL, '048BLA', 44, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (491, 48, 'Đỏ', 4100000.00, NULL, '048RED', 79, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (492, 48, 'Xanh', 4100000.00, NULL, '048BLU', 22, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (493, 49, 'Trắng', 3500000.00, NULL, '049WHI', 56, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (494, 49, 'Đen', 3500000.00, NULL, '049BLA', 31, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (495, 49, 'Đỏ', 3500000.00, NULL, '049RED', 47, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (496, 49, 'Xanh', 3500000.00, NULL, '049BLU', 73, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (497, 50, 'Trắng', 4000000.00, NULL, '050WHI', 26, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (498, 50, 'Đen', 4000000.00, NULL, '050BLA', 59, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (499, 50, 'Đỏ', 4000000.00, NULL, '050RED', 81, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (500, 50, 'Xanh', 4000000.00, NULL, '050BLU', 34, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (501, 51, 'Trắng', 4900000.00, NULL, '051WHI', 52, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (502, 51, 'Đen', 4900000.00, NULL, '051BLA', 38, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (503, 51, 'Đỏ', 4900000.00, NULL, '051RED', 65, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (504, 51, 'Xanh', 4900000.00, NULL, '051BLU', 14, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (505, 52, 'Trắng', 3200000.00, NULL, '052WHI', 71, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (506, 52, 'Đen', 3200000.00, NULL, '052BLA', 27, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (507, 52, 'Đỏ', 3200000.00, NULL, '052RED', 49, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (508, 52, 'Xanh', 3200000.00, NULL, '052BLU', 63, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (509, 53, 'Trắng', 3700000.00, NULL, '053WHI', 45, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (510, 53, 'Đen', 3700000.00, NULL, '053BLA', 77, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (511, 53, 'Đỏ', 3700000.00, NULL, '053RED', 28, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (512, 53, 'Xanh', 3700000.00, NULL, '053BLU', 54, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (513, 54, 'Trắng', 4000000.00, NULL, '054WHI', 36, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (514, 54, 'Đen', 4000000.00, NULL, '054BLA', 62, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (515, 54, 'Đỏ', 4000000.00, NULL, '054RED', 15, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (516, 54, 'Xanh', 4000000.00, NULL, '054BLU', 84, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (517, 55, 'Trắng', 3400000.00, NULL, '055WHI', 58, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (518, 55, 'Đen', 3400000.00, NULL, '055BLA', 23, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (519, 55, 'Đỏ', 3400000.00, NULL, '055RED', 77, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (520, 55, 'Xanh', 3400000.00, NULL, '055BLU', 49, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (521, 56, 'Trắng', 4300000.00, NULL, '056WHI', 32, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (522, 56, 'Đen', 4300000.00, NULL, '056BLA', 67, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (523, 56, 'Đỏ', 4300000.00, NULL, '056RED', 43, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (524, 56, 'Xanh', 4300000.00, NULL, '056BLU', 78, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (525, 57, 'Trắng', 4400000.00, NULL, '057WHI', 55, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (526, 57, 'Đen', 4400000.00, NULL, '057BLA', 18, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (527, 57, 'Đỏ', 4400000.00, NULL, '057RED', 69, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (528, 57, 'Xanh', 4400000.00, NULL, '057BLU', 41, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (529, 58, 'Trắng', 3700000.00, NULL, '058WHI', 63, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (530, 58, 'Đen', 3700000.00, NULL, '058BLA', 29, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (531, 58, 'Đỏ', 3700000.00, NULL, '058RED', 52, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (532, 58, 'Xanh', 3700000.00, NULL, '058BLU', 86, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (533, 59, 'Trắng', 3300000.00, NULL, '059WHI', 46, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (534, 59, 'Đen', 3300000.00, NULL, '059BLA', 71, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (535, 59, 'Đỏ', 3300000.00, NULL, '059RED', 24, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (536, 59, 'Xanh', 3300000.00, NULL, '059BLU', 59, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (537, 60, 'Trắng', 4200000.00, NULL, '060WHI', 37, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (538, 60, 'Đen', 4200000.00, NULL, '060BLA', 64, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (539, 60, 'Đỏ', 4200000.00, NULL, '060RED', 25, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (540, 60, 'Xanh', 4200000.00, NULL, '060BLU', 78, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (541, 61, 'Trắng', 5500000.00, NULL, '061WHI', 48, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (542, 61, 'Đen', 5500000.00, NULL, '061BLA', 32, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (543, 61, 'Đỏ', 5500000.00, NULL, '061RED', 67, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (544, 61, 'Xanh', 5500000.00, NULL, '061BLU', 16, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (545, 62, 'Trắng', 5600000.00, NULL, '062WHI', 59, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (546, 62, 'Đen', 5600000.00, NULL, '062BLA', 23, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (547, 62, 'Đỏ', 5600000.00, NULL, '062RED', 74, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (548, 62, 'Xanh', 5600000.00, NULL, '062BLU', 45, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (549, 63, 'Trắng', 4300000.00, NULL, '063WHI', 28, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (550, 63, 'Đen', 4300000.00, NULL, '063BLA', 56, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (551, 63, 'Đỏ', 4300000.00, NULL, '063RED', 81, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (552, 63, 'Xanh', 4300000.00, NULL, '063BLU', 34, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (553, 64, 'Trắng', 4800000.00, NULL, '064WHI', 62, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (554, 64, 'Đen', 4800000.00, NULL, '064BLA', 27, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (555, 64, 'Đỏ', 4800000.00, NULL, '064RED', 59, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (556, 64, 'Xanh', 4800000.00, NULL, '064BLU', 42, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (557, 65, 'Trắng', 3500000.00, NULL, '065WHI', 74, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (558, 65, 'Đen', 3500000.00, NULL, '065BLA', 33, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (559, 65, 'Đỏ', 3500000.00, NULL, '065RED', 68, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (560, 65, 'Xanh', 3500000.00, NULL, '065BLU', 21, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (561, 66, 'Trắng', 3200000.00, NULL, '066WHI', 46, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (562, 66, 'Đen', 3200000.00, NULL, '066BLA', 79, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (563, 66, 'Đỏ', 3200000.00, NULL, '066RED', 15, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (564, 66, 'Xanh', 3200000.00, NULL, '066BLU', 64, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (565, 67, 'Trắng', 4100000.00, NULL, '067WHI', 38, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (566, 67, 'Đen', 4100000.00, NULL, '067BLA', 57, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (567, 67, 'Đỏ', 4100000.00, NULL, '067RED', 26, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (568, 67, 'Xanh', 4100000.00, NULL, '067BLU', 83, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (569, 68, 'Trắng', 3300000.00, NULL, '068WHI', 51, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (570, 68, 'Đen', 3300000.00, NULL, '068BLA', 44, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (571, 68, 'Đỏ', 3300000.00, NULL, '068RED', 72, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (572, 68, 'Xanh', 3300000.00, NULL, '068BLU', 19, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (573, 69, 'Trắng', 3800000.00, NULL, '069WHI', 63, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (574, 69, 'Đen', 3800000.00, NULL, '069BLA', 29, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (575, 69, 'Đỏ', 3800000.00, NULL, '069RED', 55, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (576, 69, 'Xanh', 3800000.00, NULL, '069BLU', 48, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (577, 70, 'Trắng', 4200000.00, NULL, '070WHI', 35, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (578, 70, 'Đen', 4200000.00, NULL, '070BLA', 68, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (579, 70, 'Đỏ', 4200000.00, NULL, '070RED', 22, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (580, 70, 'Xanh', 4200000.00, NULL, '070BLU', 79, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (581, 71, 'Trắng', 5400000.00, NULL, '071WHI', 47, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (582, 71, 'Đen', 5400000.00, NULL, '071BLA', 31, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (583, 71, 'Đỏ', 5400000.00, NULL, '071RED', 64, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (584, 71, 'Xanh', 5400000.00, NULL, '071BLU', 17, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (585, 72, 'Trắng', 3900000.00, NULL, '072WHI', 52, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (586, 72, 'Đen', 3900000.00, NULL, '072BLA', 38, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (587, 72, 'Đỏ', 3900000.00, NULL, '072RED', 66, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (588, 72, 'Xanh', 3900000.00, NULL, '072BLU', 24, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (589, 73, 'Trắng', 3400000.00, NULL, '073WHI', 45, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (590, 73, 'Đen', 3400000.00, NULL, '073BLA', 73, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (591, 73, 'Đỏ', 3400000.00, NULL, '073RED', 28, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (592, 73, 'Xanh', 3400000.00, NULL, '073BLU', 59, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (593, 74, 'Trắng', 4100000.00, NULL, '074WHI', 36, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (594, 74, 'Đen', 4100000.00, NULL, '074BLA', 67, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (595, 74, 'Đỏ', 4100000.00, NULL, '074RED', 25, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (596, 74, 'Xanh', 4100000.00, NULL, '074BLU', 82, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (597, 75, 'Trắng', 4600000.00, NULL, '075WHI', 53, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (598, 75, 'Đen', 4600000.00, NULL, '075BLA', 41, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (599, 75, 'Đỏ', 4600000.00, NULL, '075RED', 78, '2026-06-04 20:38:40');
INSERT INTO `product_variants` VALUES (600, 75, 'Xanh', 4600000.00, NULL, '075BLU', 19, '2026-06-04 20:38:40');

-- ----------------------------
-- Table structure for reviews
-- ----------------------------
DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `rating` int NULL DEFAULT NULL,
  `comment` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CreateAt` datetime NULL DEFAULT current_timestamp(),
  `UpdateAt` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reviews
-- ----------------------------
INSERT INTO `reviews` VALUES (1, 1, 6, 2, 'a', '2026-03-08 00:00:00', '2026-03-08 00:00:00');
INSERT INTO `reviews` VALUES (2, 1, 6, 1, 'qư', '2026-03-08 00:00:00', '2026-03-08 00:00:00');
INSERT INTO `reviews` VALUES (3, 1, 6, 1, 'Hay lắm', '2026-03-08 00:00:00', '2026-03-08 00:00:00');
INSERT INTO `reviews` VALUES (4, 1, 6, 5, '', '2026-03-09 00:00:00', '2026-03-09 00:00:00');
INSERT INTO `reviews` VALUES (5, 1, 400, 5, 'ánh\r\n', '2026-03-19 00:00:00', '2026-03-19 00:00:00');
INSERT INTO `reviews` VALUES (6, 1, 6, 5, 'hay vc', '2026-03-25 00:00:00', '2026-03-25 00:00:00');
INSERT INTO `reviews` VALUES (7, 1, 21, 5, 'da', '2026-03-25 00:00:00', '2026-03-25 00:00:00');
INSERT INTO `reviews` VALUES (8, 1, 5, 5, 'Tạm được', '2026-03-28 00:00:00', '2026-03-28 00:00:00');
INSERT INTO `reviews` VALUES (9, 1, 5, 4, 'Tạm được', '2026-03-28 00:00:00', '2026-03-28 00:00:00');
INSERT INTO `reviews` VALUES (10, 1, 5, 3, '', '2026-03-28 00:00:00', '2026-03-28 00:00:00');
INSERT INTO `reviews` VALUES (11, 1, 5, 2, '', '2026-03-28 00:00:00', '2026-03-28 00:00:00');
INSERT INTO `reviews` VALUES (12, 1, 5, 1, '', '2026-03-28 00:00:00', '2026-03-28 00:00:00');
INSERT INTO `reviews` VALUES (13, 1, 5, 5, '', '2026-03-28 00:00:00', '2026-03-28 00:00:00');
INSERT INTO `reviews` VALUES (14, 1, 5, 5, 'dở', '2026-03-28 00:00:00', '2026-03-28 00:00:00');
INSERT INTO `reviews` VALUES (15, 1, 5, 5, 'Không hay', '2026-03-28 00:00:00', '2026-03-28 00:00:00');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `fullname` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `phoneNumber` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT NULL,
  `CreateAt` datetime NULL DEFAULT current_timestamp(),
  `UpdateAt` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `imgURL` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'anh', '1', 'Đoàn Thị Ngọc Ánh ', '23130017@st.hcmuaf.edu.vn', 'tôi là gay', '123456789', 'admin', '', 1, '2026-03-08 00:00:00', '2026-03-25 00:00:00', '/uploads/users/5ab4abd6-f65c-450d-8e09-396c7d10db4e.png');
INSERT INTO `users` VALUES (2, 'username1', '123', 'Lộc Trần Bửu', '23130175@st.hcmuaf.edu.vn', '', '1313435', 'user', '', 1, '2026-03-11 00:00:00', '2026-03-11 00:00:00', NULL);
INSERT INTO `users` VALUES (3, 'anh2', '123456@Aa', 'Doan Anh', 'iloveyou100gir@gmail.com', 'aaa', '0311111111', 'user', NULL, 1, '2026-03-30 00:00:00', '2026-03-30 00:00:00', NULL);
INSERT INTO `users` VALUES (4, 'huy', '1', 'Nhật Huy', NULL, 'thiên cổ nhất đế', '0112233445', 'user', NULL, NULL, '2026-05-27 20:46:48', NULL, NULL);

-- ----------------------------
-- Table structure for voucher
-- ----------------------------
DROP TABLE IF EXISTS `voucher`;
CREATE TABLE `voucher`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value_type` enum('percent','amount') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` decimal(15, 2) NOT NULL,
  `max_discount` decimal(15, 2) NULL DEFAULT NULL,
  `min_order_value` decimal(15, 2) NULL DEFAULT NULL,
  `usage_limit` int NULL DEFAULT NULL,
  `used_count` int NULL DEFAULT 0,
  `max_usage_per_user` int NOT NULL DEFAULT 1,
  `start_at` datetime NULL DEFAULT NULL,
  `end_at` datetime NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT 1,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of voucher
-- ----------------------------
INSERT INTO `voucher` VALUES (1, 'WELCOME10', 'percent', 10.00, 5000000.00, 50000000.00, 100, 0, 1, '2026-01-01 00:00:00', '2026-12-31 00:00:00', 1, '2026-03-11 11:16:50');
INSERT INTO `voucher` VALUES (2, 'NEWUSER5', 'amount', 5000000.00, NULL, 100000000.00, 200, 0, 1, '2026-01-01 00:00:00', '2026-12-31 00:00:00', 1, '2026-03-11 11:16:50');
INSERT INTO `voucher` VALUES (3, 'SPRING15', 'percent', 15.00, 10000000.00, 200000000.00, 50, 0, 1, '2026-03-01 00:00:00', '2026-05-31 00:00:00', 1, '2026-03-11 11:16:50');
INSERT INTO `voucher` VALUES (4, 'BIGSALE20', 'percent', 20.00, 20000000.00, 300000000.00, 30, 0, 1, '2026-03-01 00:00:00', '2026-06-30 00:00:00', 1, '2026-03-11 11:16:50');
INSERT INTO `voucher` VALUES (5, 'SALE50M', 'amount', 50000000.00, NULL, 500000000.00, 20, 0, 1, '2026-01-01 00:00:00', '2026-12-31 00:00:00', 1, '2026-03-11 11:16:50');
INSERT INTO `voucher` VALUES (6, 'TEST10M', 'amount', 10000000.00, NULL, 100000000.00, 100, 0, 1, '2026-01-01 00:00:00', '2026-12-31 00:00:00', 1, '2026-03-11 11:16:50');
INSERT INTO `voucher` VALUES (7, 'VIP25', 'percent', 25.00, 50000000.00, 700000000.00, 10, 0, 1, '2026-01-01 00:00:00', '2026-12-31 00:00:00', 1, '2026-03-11 11:16:50');
INSERT INTO `voucher` VALUES (8, 'FLASH5', 'percent', 5.00, 2000000.00, 30000000.00, 500, 0, 1, '2026-01-01 00:00:00', '2026-12-31 00:00:00', 1, '2026-03-11 11:16:50');
INSERT INTO `voucher` VALUES (9, 'HOLIDAY30', 'percent', 30.00, 80000000.00, 800000000.00, 5, 0, 1, '2026-01-01 00:00:00', '2026-12-31 00:00:00', 1, '2026-03-11 11:16:50');
INSERT INTO `voucher` VALUES (10, 'CAR2026', 'amount', 20000000.00, NULL, 200000000.00, 100, 0, 1, '2026-01-01 00:00:00', '2026-12-31 00:00:00', 1, '2026-03-11 11:16:50');
INSERT INTO `voucher` VALUES (11, 'SUPER100M', 'amount', 100000000.00, NULL, 1000000000.00, 5, 0, 1, '2026-01-01 00:00:00', '2026-12-31 00:00:00', 1, '2026-03-11 11:16:50');
INSERT INTO `voucher` VALUES (12, 'SALE7', 'percent', 7.00, 3000000.00, 50000000.00, 150, 0, 1, '2026-01-01 00:00:00', '2026-12-31 00:00:00', 1, '2026-03-11 11:16:50');
INSERT INTO `voucher` VALUES (13, 'MIDYEAR12', 'percent', 12.00, 7000000.00, 150000000.00, 80, 0, 1, '2026-06-01 00:00:00', '2026-08-31 00:00:00', 1, '2026-03-11 11:16:50');
INSERT INTO `voucher` VALUES (14, 'AUTUMN8', 'percent', 8.00, 4000000.00, 60000000.00, 120, 0, 1, '2026-09-01 00:00:00', '2026-11-30 00:00:00', 1, '2026-03-11 11:16:50');
INSERT INTO `voucher` VALUES (15, 'MEGA15M', 'amount', 15000000.00, NULL, 250000000.00, 60, 0, 1, '2026-01-01 00:00:00', '2026-12-31 00:00:00', 1, '2026-03-11 11:16:50');
INSERT INTO `voucher` VALUES (16, 'MA111', 'percent', 12.00, NULL, NULL, 100, 0, 1, NULL, NULL, 1, '2026-06-04 16:35:40');

-- ----------------------------
-- Table structure for voucher_scope
-- ----------------------------
DROP TABLE IF EXISTS `voucher_scope`;
CREATE TABLE `voucher_scope`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `voucher_id` int NULL DEFAULT NULL,
  `entity_type` enum('product','brand','category','order') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `entity_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `voucher_id`(`voucher_id` ASC) USING BTREE,
  CONSTRAINT `voucher_scope_ibfk_1` FOREIGN KEY (`voucher_id`) REFERENCES `voucher` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of voucher_scope
-- ----------------------------
INSERT INTO `voucher_scope` VALUES (1, 16, 'order', 0);

-- ----------------------------
-- Table structure for voucher_usage
-- ----------------------------
DROP TABLE IF EXISTS `voucher_usage`;
CREATE TABLE `voucher_usage`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `voucher_id` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `order_id` int NULL DEFAULT NULL,
  `used_at` datetime NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `voucher_id`(`voucher_id` ASC) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `voucher_usage_ibfk_1` FOREIGN KEY (`voucher_id`) REFERENCES `voucher` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `voucher_usage_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of voucher_usage
-- ----------------------------

-- ----------------------------
-- Table structure for wishlist_item
-- ----------------------------
DROP TABLE IF EXISTS `wishlist_item`;
CREATE TABLE `wishlist_item`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `CreateAt` datetime NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 492 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wishlist_item
-- ----------------------------
INSERT INTO `wishlist_item` VALUES (491, 1, 178, '2026-03-28 11:58:08');

SET FOREIGN_KEY_CHECKS = 1;
