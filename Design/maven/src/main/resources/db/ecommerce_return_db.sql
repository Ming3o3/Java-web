/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80031 (8.0.31)
 Source Host           : localhost:3306
 Source Schema         : ecommerce_return_db

 Target Server Type    : MySQL
 Target Server Version : 80031 (8.0.31)
 File Encoding         : 65001

 Date: 22/05/2025 11:16:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_merchant_relation
-- ----------------------------
DROP TABLE IF EXISTS `admin_merchant_relation`;
CREATE TABLE `admin_merchant_relation`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `admin_id` int UNSIGNED NOT NULL,
  `merchant_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id_UNIQUE`(`id` ASC) USING BTREE,
  INDEX `fk_admin_merchant_relation_administrator1_idx`(`admin_id` ASC) USING BTREE,
  INDEX `fk_admin_merchant_relation_merchant1_idx`(`merchant_id` ASC) USING BTREE,
  CONSTRAINT `fk_admin_merchant_relation_administrator1` FOREIGN KEY (`admin_id`) REFERENCES `administrator` (`admin_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_admin_merchant_relation_merchant1` FOREIGN KEY (`merchant_id`) REFERENCES `merchant` (`merchant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_merchant_relation
-- ----------------------------
INSERT INTO `admin_merchant_relation` VALUES (1, 1, 1);
INSERT INTO `admin_merchant_relation` VALUES (2, 1, 2);
INSERT INTO `admin_merchant_relation` VALUES (3, 1, 3);
INSERT INTO `admin_merchant_relation` VALUES (4, 1, 4);
INSERT INTO `admin_merchant_relation` VALUES (5, 1, 5);
INSERT INTO `admin_merchant_relation` VALUES (6, 2, 1);
INSERT INTO `admin_merchant_relation` VALUES (7, 2, 3);
INSERT INTO `admin_merchant_relation` VALUES (8, 2, 5);
INSERT INTO `admin_merchant_relation` VALUES (9, 3, 2);
INSERT INTO `admin_merchant_relation` VALUES (10, 3, 4);

-- ----------------------------
-- Table structure for administrator
-- ----------------------------
DROP TABLE IF EXISTS `administrator`;
CREATE TABLE `administrator`  (
  `admin_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `contact_info` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_authorized` tinyint(1) NOT NULL DEFAULT 0,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`admin_id`) USING BTREE,
  UNIQUE INDEX `admin_id_UNIQUE`(`admin_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of administrator
-- ----------------------------
INSERT INTO `administrator` VALUES (1, '系统管理员', 'admin@example.com', 1, NULL, NULL);
INSERT INTO `administrator` VALUES (2, '系统管理员', 'admin@example.com', 1, NULL, NULL);
INSERT INTO `administrator` VALUES (3, '客服主管', 'support@example.com', 1, NULL, NULL);
INSERT INTO `administrator` VALUES (4, '运营经理', 'operation@example.com', 1, NULL, NULL);

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `customer_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `contact_info` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `shipping_address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`) USING BTREE,
  UNIQUE INDEX `customer_id_UNIQUE`(`customer_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES (1, '张三', '13800138000', '北京市朝阳区', '123456', 'Ming');
INSERT INTO `customer` VALUES (2, '李四', '13900139000', '上海市浦东新区', NULL, NULL);
INSERT INTO `customer` VALUES (3, '张三', '13800138000', '北京市朝阳区建国路88号', NULL, NULL);
INSERT INTO `customer` VALUES (4, '李四', '13900139000', '上海市浦东新区张江高科技园区', NULL, NULL);
INSERT INTO `customer` VALUES (5, '王五', '13700137000', '广州市天河区珠江新城', NULL, NULL);
INSERT INTO `customer` VALUES (6, '赵六', '13600136000', '深圳市南山区科技园', NULL, NULL);
INSERT INTO `customer` VALUES (7, '钱七', '13500135000', '杭州市西湖区文三路', NULL, NULL);
INSERT INTO `customer` VALUES (8, '孙八', '13400134000', '南京市鼓楼区中山路', NULL, NULL);
INSERT INTO `customer` VALUES (9, '周九', '13300133000', '成都市武侯区天府大道', NULL, NULL);
INSERT INTO `customer` VALUES (10, '吴十', '13200132000', '武汉市武昌区光谷广场', NULL, NULL);
INSERT INTO `customer` VALUES (11, '郑十一', '13100131000', '重庆市渝北区龙塔街道', NULL, NULL);
INSERT INTO `customer` VALUES (12, '王十二', '13000130000', '天津市和平区南京路', NULL, NULL);
INSERT INTO `customer` VALUES (13, 'Ming', '1', '1', '1', 'Ming');
INSERT INTO `customer` VALUES (14, 'test', '13800138000', '测试地址', '123456', '测试用户');
INSERT INTO `customer` VALUES (15, '1', '1', '1', '123456', '1');

-- ----------------------------
-- Table structure for evaluation
-- ----------------------------
DROP TABLE IF EXISTS `evaluation`;
CREATE TABLE `evaluation`  (
  `evaluation_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `evaluation_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`evaluation_id`) USING BTREE,
  UNIQUE INDEX `evaluation_id_UNIQUE`(`evaluation_id` ASC) USING BTREE,
  INDEX `fk_evaluation_customer1_idx`(`customer_id` ASC) USING BTREE,
  INDEX `fk_evaluation_product1_idx`(`product_id` ASC) USING BTREE,
  CONSTRAINT `fk_evaluation_customer1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_evaluation_product1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of evaluation
-- ----------------------------
INSERT INTO `evaluation` VALUES (1, 1, 1, '这款手机性能很棒，电池续航也不错！', '2025-05-02 15:30:00');
INSERT INTO `evaluation` VALUES (2, 1, 6, 'T恤质量很好，穿着很舒服。', '2025-05-02 15:45:00');
INSERT INTO `evaluation` VALUES (3, 2, 3, '平板屏幕清晰，很适合看视频。', '2025-05-03 17:10:00');
INSERT INTO `evaluation` VALUES (4, 2, 8, '牛仔裤版型很正，推荐购买！', '2025-05-03 17:20:00');
INSERT INTO `evaluation` VALUES (5, 3, 11, '台灯光线柔和，很适合阅读。', '2025-05-04 12:30:00');
INSERT INTO `evaluation` VALUES (6, 3, 16, '口红颜色很正，持久度也不错。', '2025-05-04 12:40:00');
INSERT INTO `evaluation` VALUES (7, 4, 4, '平板性能不错，但电池有点不耐用。', '2025-05-05 19:30:00');
INSERT INTO `evaluation` VALUES (8, 4, 19, '眼影盘颜色很实用，粉质细腻。', '2025-05-05 19:40:00');
INSERT INTO `evaluation` VALUES (9, 5, 7, 'T恤面料有点薄，夏天穿刚好。', '2025-05-06 15:15:00');
INSERT INTO `evaluation` VALUES (10, 5, 21, '运动鞋很轻便，穿着很舒服。', '2025-05-06 15:25:00');
INSERT INTO `evaluation` VALUES (11, 6, 12, '沙发质量很好，很舒服。', '2025-05-07 16:40:00');
INSERT INTO `evaluation` VALUES (12, 6, 24, '运动裤弹性很好，穿着很自在。', '2025-05-07 16:50:00');
INSERT INTO `evaluation` VALUES (13, 7, 5, '笔记本电脑性能强劲，散热也不错。', '2025-05-08 14:20:00');
INSERT INTO `evaluation` VALUES (14, 7, 20, '面膜很补水，效果不错。', '2025-05-08 14:30:00');
INSERT INTO `evaluation` VALUES (15, 8, 9, '牛仔裤穿着很舒服，尺码标准。', '2025-05-09 18:15:00');

-- ----------------------------
-- Table structure for merchant
-- ----------------------------
DROP TABLE IF EXISTS `merchant`;
CREATE TABLE `merchant`  (
  `merchant_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `store_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `contact_info` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`merchant_id`) USING BTREE,
  UNIQUE INDEX `merchant_id_UNIQUE`(`merchant_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of merchant
-- ----------------------------
INSERT INTO `merchant` VALUES (1, '电子产品专营店', '400-123-4567', '广东省深圳市', NULL, NULL);
INSERT INTO `merchant` VALUES (2, '服装旗舰店', '400-234-5678', '浙江省杭州市', NULL, NULL);
INSERT INTO `merchant` VALUES (3, '电子产品专营店', '400-123-4567', '广东省深圳市南山区', NULL, NULL);
INSERT INTO `merchant` VALUES (4, '服装旗舰店', '400-234-5678', '浙江省杭州市余杭区', NULL, NULL);
INSERT INTO `merchant` VALUES (5, '家居生活馆', '400-345-6789', '江苏省苏州市工业园区', NULL, NULL);
INSERT INTO `merchant` VALUES (6, '美妆个护店', '400-456-7890', '上海市静安区南京西路', NULL, NULL);
INSERT INTO `merchant` VALUES (7, '运动户外店', '400-567-8901', '北京市海淀区中关村', NULL, NULL);
INSERT INTO `merchant` VALUES (8, '2', '1', '1', '1', '1');

-- ----------------------------
-- Table structure for merchant_return_relation
-- ----------------------------
DROP TABLE IF EXISTS `merchant_return_relation`;
CREATE TABLE `merchant_return_relation`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `merchant_id` int UNSIGNED NOT NULL,
  `return_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id_UNIQUE`(`id` ASC) USING BTREE,
  INDEX `fk_merchant_return_relation_merchant1_idx`(`merchant_id` ASC) USING BTREE,
  INDEX `fk_merchant_return_relation_return_goods1_idx`(`return_id` ASC) USING BTREE,
  CONSTRAINT `fk_merchant_return_relation_merchant1` FOREIGN KEY (`merchant_id`) REFERENCES `merchant` (`merchant_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_merchant_return_relation_return_goods1` FOREIGN KEY (`return_id`) REFERENCES `return_goods` (`return_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of merchant_return_relation
-- ----------------------------
INSERT INTO `merchant_return_relation` VALUES (1, 1, 1);
INSERT INTO `merchant_return_relation` VALUES (2, 2, 2);
INSERT INTO `merchant_return_relation` VALUES (3, 3, 3);
INSERT INTO `merchant_return_relation` VALUES (4, 4, 4);
INSERT INTO `merchant_return_relation` VALUES (5, 5, 5);
INSERT INTO `merchant_return_relation` VALUES (6, 1, 6);
INSERT INTO `merchant_return_relation` VALUES (7, 2, 7);
INSERT INTO `merchant_return_relation` VALUES (8, 3, 8);
INSERT INTO `merchant_return_relation` VALUES (9, 4, 9);
INSERT INTO `merchant_return_relation` VALUES (10, 5, 10);

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `order_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` int UNSIGNED NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '待发货',
  `total_amount` decimal(10, 2) NOT NULL,
  `shipping_address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`) USING BTREE,
  UNIQUE INDEX `order_id_UNIQUE`(`order_id` ASC) USING BTREE,
  INDEX `fk_order_customer1_idx`(`customer_id` ASC) USING BTREE,
  CONSTRAINT `fk_order_customer1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (1, 15, '2025-05-21 15:08:51', '已取消', 4999.00, '1');
INSERT INTO `order` VALUES (2, 15, '2025-05-21 15:10:18', '已取消', 1999.00, '1');
INSERT INTO `order` VALUES (3, 15, '2025-05-21 15:31:18', '已取消', 4999.00, '1');
INSERT INTO `order` VALUES (4, 15, '2025-05-21 15:32:16', '已取消', 4999.00, '1');
INSERT INTO `order` VALUES (5, 15, '2025-05-21 15:33:36', '已取消', 299.00, '1');
INSERT INTO `order` VALUES (6, 15, '2025-05-21 15:36:51', '已取消', 4999.00, '1');
INSERT INTO `order` VALUES (7, 15, '2025-05-21 15:37:22', '已取消', 4999.00, '1');
INSERT INTO `order` VALUES (8, 15, '2025-05-21 15:39:56', '已取消', 4999.00, '1');
INSERT INTO `order` VALUES (9, 15, '2025-05-21 15:46:37', '待发货', 4999.00, '1');
INSERT INTO `order` VALUES (10, 15, '2025-05-21 16:03:42', '待发货', 4999.00, '1');
INSERT INTO `order` VALUES (11, 15, '2025-05-21 16:05:15', '已取消', 12997.00, '1');
INSERT INTO `order` VALUES (12, 15, '2025-05-21 18:58:22', '退货中', 5010.00, '1');
INSERT INTO `order` VALUES (13, 15, '2025-05-21 19:11:02', '已完成', 3333.00, '1');
INSERT INTO `order` VALUES (14, 15, '2025-05-21 19:11:42', '已退货', 3333.00, '1');
INSERT INTO `order` VALUES (15, 15, '2025-05-21 19:51:19', '退货中', 39996.00, '1');
INSERT INTO `order` VALUES (16, 15, '2025-05-21 20:07:03', '退货中', 3333.00, '1');
INSERT INTO `order` VALUES (17, 15, '2025-05-21 20:22:01', '已取消', 4999.00, '1');
INSERT INTO `order` VALUES (18, 15, '2025-05-21 20:22:28', '退货中', 3333.00, '1');
INSERT INTO `order` VALUES (19, 15, '2025-05-21 20:37:50', '已完成', 3333.00, '1');
INSERT INTO `order` VALUES (20, 15, '2025-05-21 20:43:14', '已取消', 3333.00, '1');
INSERT INTO `order` VALUES (21, 15, '2025-05-21 20:43:36', '已完成', 3333.00, '1');
INSERT INTO `order` VALUES (22, 15, '2025-05-21 20:53:09', '已取消', 3333.00, '1');
INSERT INTO `order` VALUES (23, 15, '2025-05-21 20:53:20', '已完成', 3333.00, '1');
INSERT INTO `order` VALUES (24, 15, '2025-05-21 20:53:54', '已退货', 3333.00, '1');
INSERT INTO `order` VALUES (25, 15, '2025-05-21 21:00:55', '已取消', 3333.00, '1');
INSERT INTO `order` VALUES (26, 15, '2025-05-21 21:01:02', '已退货', 3333.00, '1');
INSERT INTO `order` VALUES (27, 15, '2025-05-21 21:54:00', '待发货', 4999.00, '1');
INSERT INTO `order` VALUES (28, 15, '2025-05-21 22:01:55', '待发货', 3333.00, '1');
INSERT INTO `order` VALUES (29, 15, '2025-05-22 01:42:54', '已取消', 38588.00, '1');
INSERT INTO `order` VALUES (30, 15, '2025-05-22 01:46:47', '已完成', 3333.00, '1');
INSERT INTO `order` VALUES (31, 15, '2025-05-22 01:53:44', '已完成', 3333.00, '1');
INSERT INTO `order` VALUES (32, 15, '2025-05-22 02:38:00', '待发货', 299.00, '1');
INSERT INTO `order` VALUES (33, 15, '2025-05-22 02:44:08', '退货中', 3333.00, '1');
INSERT INTO `order` VALUES (34, 15, '2025-05-22 02:45:01', '退货中', 3333.00, '1');
INSERT INTO `order` VALUES (35, 15, '2025-05-22 02:48:32', '退货中', 3333.00, '1');
INSERT INTO `order` VALUES (36, 15, '2025-05-22 02:55:32', '退货中', 3333.00, '1');
INSERT INTO `order` VALUES (37, 15, '2025-05-22 03:00:25', '已退货', 3333.00, '1');
INSERT INTO `order` VALUES (38, 15, '2025-05-22 03:01:05', '已完成', 3333.00, '1');
INSERT INTO `order` VALUES (39, 15, '2025-05-22 03:03:46', '同意退货', 3333.00, '1');

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item`  (
  `order_item_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`order_item_id`) USING BTREE,
  UNIQUE INDEX `order_item_id_UNIQUE`(`order_item_id` ASC) USING BTREE,
  INDEX `fk_order_item_order1_idx`(`order_id` ASC) USING BTREE,
  INDEX `fk_order_item_product1_idx`(`product_id` ASC) USING BTREE,
  CONSTRAINT `fk_order_item_order1` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_order_item_product1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_item
-- ----------------------------
INSERT INTO `order_item` VALUES (1, 1, 1, 1, 4999.00);
INSERT INTO `order_item` VALUES (2, 2, 5, 1, 1999.00);
INSERT INTO `order_item` VALUES (3, 3, 1, 1, 4999.00);
INSERT INTO `order_item` VALUES (4, 4, 1, 1, 4999.00);
INSERT INTO `order_item` VALUES (5, 5, 2, 1, 299.00);
INSERT INTO `order_item` VALUES (6, 6, 1, 1, 4999.00);
INSERT INTO `order_item` VALUES (7, 7, 3, 1, 4999.00);
INSERT INTO `order_item` VALUES (8, 8, 1, 1, 4999.00);
INSERT INTO `order_item` VALUES (9, 9, 1, 1, 4999.00);
INSERT INTO `order_item` VALUES (10, 10, 1, 1, 4999.00);
INSERT INTO `order_item` VALUES (11, 11, 1, 1, 4999.00);
INSERT INTO `order_item` VALUES (12, 11, 5, 1, 1999.00);
INSERT INTO `order_item` VALUES (13, 11, 4, 1, 5999.00);
INSERT INTO `order_item` VALUES (14, 12, 1, 1, 4999.00);
INSERT INTO `order_item` VALUES (16, 13, 29, 1, 3333.00);
INSERT INTO `order_item` VALUES (17, 14, 29, 1, 3333.00);
INSERT INTO `order_item` VALUES (18, 15, 29, 12, 3333.00);
INSERT INTO `order_item` VALUES (19, 16, 29, 1, 3333.00);
INSERT INTO `order_item` VALUES (20, 17, 1, 1, 4999.00);
INSERT INTO `order_item` VALUES (21, 18, 29, 1, 3333.00);
INSERT INTO `order_item` VALUES (22, 19, 29, 1, 3333.00);
INSERT INTO `order_item` VALUES (23, 20, 29, 1, 3333.00);
INSERT INTO `order_item` VALUES (24, 21, 29, 1, 3333.00);
INSERT INTO `order_item` VALUES (25, 22, 29, 1, 3333.00);
INSERT INTO `order_item` VALUES (26, 23, 29, 1, 3333.00);
INSERT INTO `order_item` VALUES (27, 24, 29, 1, 3333.00);
INSERT INTO `order_item` VALUES (28, 25, 29, 1, 3333.00);
INSERT INTO `order_item` VALUES (29, 26, 29, 1, 3333.00);
INSERT INTO `order_item` VALUES (30, 27, 1, 1, 4999.00);
INSERT INTO `order_item` VALUES (31, 28, 29, 1, 3333.00);
INSERT INTO `order_item` VALUES (32, 29, 1, 4, 4999.00);
INSERT INTO `order_item` VALUES (33, 29, 6, 6, 2999.00);
INSERT INTO `order_item` VALUES (34, 29, 2, 2, 299.00);
INSERT INTO `order_item` VALUES (35, 30, 29, 1, 3333.00);
INSERT INTO `order_item` VALUES (36, 31, 29, 1, 3333.00);
INSERT INTO `order_item` VALUES (37, 32, 2, 1, 299.00);
INSERT INTO `order_item` VALUES (38, 33, 29, 1, 3333.00);
INSERT INTO `order_item` VALUES (39, 34, 29, 1, 3333.00);
INSERT INTO `order_item` VALUES (40, 35, 29, 1, 3333.00);
INSERT INTO `order_item` VALUES (41, 36, 29, 1, 3333.00);
INSERT INTO `order_item` VALUES (42, 37, 29, 1, 3333.00);
INSERT INTO `order_item` VALUES (43, 38, 29, 1, 3333.00);
INSERT INTO `order_item` VALUES (44, 39, 29, 1, 3333.00);

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `product_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `merchant_id` int UNSIGNED NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `quantity` int NOT NULL DEFAULT 0,
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `image` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`) USING BTREE,
  UNIQUE INDEX `product_id_UNIQUE`(`product_id` ASC) USING BTREE,
  INDEX `fk_product_merchant_idx`(`merchant_id` ASC) USING BTREE,
  CONSTRAINT `fk_product_merchant` FOREIGN KEY (`merchant_id`) REFERENCES `merchant` (`merchant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (1, 1, 4999.00, 100, '手机', '/images/products/apple.png');
INSERT INTO `product` VALUES (2, 2, 299.00, 200, 'T恤', 'https://picsum.photos/seed/tshirt/300/300');
INSERT INTO `product` VALUES (3, 1, 4999.00, 100, '手机', 'https://picsum.photos/seed/phone1/300/300');
INSERT INTO `product` VALUES (4, 1, 5999.00, 80, '手机', 'https://picsum.photos/seed/phone2/300/300');
INSERT INTO `product` VALUES (5, 1, 1999.00, 120, '平板', 'https://picsum.photos/seed/tablet1/300/300');
INSERT INTO `product` VALUES (6, 1, 2999.00, 90, '平板', 'https://picsum.photos/seed/tablet2/300/300');
INSERT INTO `product` VALUES (7, 1, 8999.00, 50, '笔记本电脑', 'https://picsum.photos/seed/laptop1/300/300');
INSERT INTO `product` VALUES (8, 2, 299.00, 200, 'T恤', 'https://picsum.photos/seed/tshirt1/300/300');
INSERT INTO `product` VALUES (9, 2, 399.00, 180, 'T恤', 'https://picsum.photos/seed/tshirt2/300/300');
INSERT INTO `product` VALUES (10, 2, 599.00, 150, '牛仔裤', 'https://picsum.photos/seed/jeans1/300/300');
INSERT INTO `product` VALUES (11, 2, 699.00, 120, '牛仔裤', 'https://picsum.photos/seed/jeans2/300/300');
INSERT INTO `product` VALUES (12, 2, 899.00, 100, '连衣裙', 'https://picsum.photos/seed/dress1/300/300');
INSERT INTO `product` VALUES (13, 3, 199.00, 150, '台灯', 'https://picsum.photos/seed/light1/300/300');
INSERT INTO `product` VALUES (14, 3, 299.00, 120, '台灯', 'https://picsum.photos/seed/light2/300/300');
INSERT INTO `product` VALUES (15, 3, 499.00, 80, '沙发', 'https://picsum.photos/seed/sofa1/300/300');
INSERT INTO `product` VALUES (16, 3, 599.00, 70, '沙发', 'https://picsum.photos/seed/sofa2/300/300');
INSERT INTO `product` VALUES (17, 3, 399.00, 100, '餐桌', 'https://picsum.photos/seed/table1/300/300');
INSERT INTO `product` VALUES (18, 4, 199.00, 200, '口红', 'https://picsum.photos/seed/lipstick1/300/300');
INSERT INTO `product` VALUES (19, 4, 299.00, 180, '口红', 'https://picsum.photos/seed/lipstick2/300/300');
INSERT INTO `product` VALUES (20, 4, 399.00, 150, '粉底液', 'https://picsum.photos/seed/foundation1/300/300');
INSERT INTO `product` VALUES (21, 4, 499.00, 120, '眼影盘', 'https://picsum.photos/seed/eyeshadow1/300/300');
INSERT INTO `product` VALUES (22, 4, 299.00, 160, '面膜', 'https://picsum.photos/seed/mask1/300/300');
INSERT INTO `product` VALUES (23, 5, 399.00, 100, '运动鞋', 'https://picsum.photos/seed/shoes1/300/300');
INSERT INTO `product` VALUES (24, 5, 499.00, 90, '运动鞋', 'https://picsum.photos/seed/shoes2/300/300');
INSERT INTO `product` VALUES (25, 5, 299.00, 120, '运动裤', 'https://picsum.photos/seed/pants1/300/300');
INSERT INTO `product` VALUES (26, 5, 399.00, 110, '运动裤', 'https://picsum.photos/seed/pants2/300/300');
INSERT INTO `product` VALUES (27, 5, 599.00, 80, '健身器材', 'https://picsum.photos/seed/equipment1/300/300');
INSERT INTO `product` VALUES (29, 8, 3333.00, 333, '333', '/images/products/apple.png');

-- ----------------------------
-- Table structure for return_goods
-- ----------------------------
DROP TABLE IF EXISTS `return_goods`;
CREATE TABLE `return_goods`  (
  `return_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  `order_id` int UNSIGNED NOT NULL,
  `return_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'pending',
  `reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`return_id`) USING BTREE,
  UNIQUE INDEX `return_id_UNIQUE`(`return_id` ASC) USING BTREE,
  INDEX `fk_return_goods_customer1_idx`(`customer_id` ASC) USING BTREE,
  INDEX `fk_return_goods_product1_idx`(`product_id` ASC) USING BTREE,
  INDEX `fk_return_goods_order1_idx`(`order_id` ASC) USING BTREE,
  CONSTRAINT `fk_return_goods_customer1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_return_goods_order1` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_return_goods_product1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of return_goods
-- ----------------------------
INSERT INTO `return_goods` VALUES (1, 1, 1, 1, '2025-05-21 02:18:37', '', '商品质量问题');
INSERT INTO `return_goods` VALUES (2, 2, 2, 2, '2025-05-21 02:18:37', '', '尺寸不合适');
INSERT INTO `return_goods` VALUES (3, 1, 1, 1, '2025-05-03 10:00:00', '', '商品损坏');
INSERT INTO `return_goods` VALUES (4, 2, 8, 4, '2025-05-04 11:30:00', '', '颜色与描述不符');
INSERT INTO `return_goods` VALUES (5, 3, 16, 6, '2025-05-05 14:15:00', '', '商品与描述不符');
INSERT INTO `return_goods` VALUES (6, 4, 19, 8, '2025-05-06 09:45:00', '', '个人原因');
INSERT INTO `return_goods` VALUES (7, 5, 21, 10, '2025-05-07 16:20:00', '', '商品质量问题');
INSERT INTO `return_goods` VALUES (8, 6, 24, 12, '2025-05-08 11:10:00', '', NULL);
INSERT INTO `return_goods` VALUES (9, 7, 20, 14, '2025-05-09 13:30:00', '', NULL);
INSERT INTO `return_goods` VALUES (10, 8, 14, 16, '2025-05-10 10:45:00', '', NULL);
INSERT INTO `return_goods` VALUES (11, 9, 22, 18, '2025-05-11 15:20:00', '', NULL);
INSERT INTO `return_goods` VALUES (12, 10, 10, 20, '2025-05-12 09:30:00', '', NULL);
INSERT INTO `return_goods` VALUES (13, 15, 1, 12, '2025-05-21 18:58:52', '待处理', '商品质量问题');
INSERT INTO `return_goods` VALUES (15, 15, 29, 14, '2025-05-21 19:12:03', '已完成', '商品质量问题');
INSERT INTO `return_goods` VALUES (16, 15, 29, 15, '2025-05-21 19:52:14', '已拒绝', '个人不喜欢');
INSERT INTO `return_goods` VALUES (17, 15, 29, 24, '2025-05-21 20:54:03', '已完成', '商品质量问题');
INSERT INTO `return_goods` VALUES (18, 15, 29, 26, '2025-05-21 21:01:14', '已完成', '商品质量问题');
INSERT INTO `return_goods` VALUES (19, 15, 29, 16, '2025-05-22 02:43:26', '已同意', 'ååè´¨éé®é¢');
INSERT INTO `return_goods` VALUES (20, 15, 29, 18, '2025-05-22 02:43:35', '已拒绝', 'ååè´¨éé®é¢');
INSERT INTO `return_goods` VALUES (21, 15, 29, 33, '2025-05-22 02:45:11', '已同意', 'ååè´¨éé®é¢');
INSERT INTO `return_goods` VALUES (22, 15, 29, 34, '2025-05-22 02:48:46', '已同意', 'ååè´¨éé®é¢');
INSERT INTO `return_goods` VALUES (23, 15, 29, 35, '2025-05-22 02:49:08', '已同意', 'ååè´¨éé®é¢');
INSERT INTO `return_goods` VALUES (24, 15, 29, 36, '2025-05-22 02:55:50', '已同意', 'ååè´¨éé®é¢');
INSERT INTO `return_goods` VALUES (25, 15, 29, 37, '2025-05-22 03:00:48', '已完成', 'ååè´¨éé®é¢');
INSERT INTO `return_goods` VALUES (26, 15, 29, 38, '2025-05-22 03:01:19', '已拒绝', 'ååè´¨éé®é¢');
INSERT INTO `return_goods` VALUES (27, 15, 29, 39, '2025-05-22 03:04:04', '已同意', '商品质量问题');

-- ----------------------------
-- Table structure for return_request
-- ----------------------------
DROP TABLE IF EXISTS `return_request`;
CREATE TABLE `return_request`  (
  `return_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `create_time` timestamp NOT NULL,
  `update_time` timestamp NOT NULL,
  `merchant_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`return_id`) USING BTREE,
  INDEX `order_id`(`order_id` ASC) USING BTREE,
  INDEX `product_id`(`product_id` ASC) USING BTREE,
  INDEX `merchant_id`(`merchant_id` ASC) USING BTREE,
  CONSTRAINT `return_request_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `return_request_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `return_request_ibfk_3` FOREIGN KEY (`merchant_id`) REFERENCES `merchant` (`merchant_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of return_request
-- ----------------------------

-- ----------------------------
-- Table structure for shopping_cart
-- ----------------------------
DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart`  (
  `cart_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  `quantity` int NOT NULL,
  `add_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cart_id`) USING BTREE,
  UNIQUE INDEX `cart_id_UNIQUE`(`cart_id` ASC) USING BTREE,
  INDEX `fk_shopping_cart_customer1_idx`(`customer_id` ASC) USING BTREE,
  INDEX `fk_shopping_cart_product1_idx`(`product_id` ASC) USING BTREE,
  CONSTRAINT `fk_shopping_cart_customer1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_shopping_cart_product1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 54 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shopping_cart
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
