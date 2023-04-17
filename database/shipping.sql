/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : localhost:3306
 Source Schema         : shipping

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 17/04/2023 14:15:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for carriers
-- ----------------------------
DROP TABLE IF EXISTS `carriers`;
CREATE TABLE `carriers`  (
  `carrier_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `contact_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `country` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `postal_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`carrier_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of carriers
-- ----------------------------
INSERT INTO `carriers` VALUES (1, '顺丰速运', '李四', 'sf-express@qq.com', '400-811-1111', '广东省深圳市福田区新洲十一街华联工业园', '深圳市', '中国', '518000');
INSERT INTO `carriers` VALUES (2, '圆通速递', '王五', 'yuantong-express@qq.com', '95554', '北京市朝阳区建国路乙19号院3号楼圆通速递股份有限公司', '北京市', '中国', '100022');
INSERT INTO `carriers` VALUES (3, '中通快递', '张三', 'zhongtong-express@qq.com', '95311', '浙江省宁波市海曙区解放北路958号中通国际大厦', '宁波市', '中国', '315000');

-- ----------------------------
-- Table structure for carriers_billing
-- ----------------------------
DROP TABLE IF EXISTS `carriers_billing`;
CREATE TABLE `carriers_billing`  (
  `billing_id` int NOT NULL,
  `carrier_id` int NULL DEFAULT NULL,
  `order_id` int NULL DEFAULT NULL,
  `billing_date` date NULL DEFAULT NULL,
  `freight_charge` decimal(10, 2) NULL DEFAULT NULL,
  `handling_charge` decimal(10, 2) NULL DEFAULT NULL,
  `other_charge` decimal(10, 2) NULL DEFAULT NULL,
  `total_charge` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`billing_id`) USING BTREE,
  INDEX `carrier_id`(`carrier_id`) USING BTREE,
  INDEX `carriers_billing_ibfk_2`(`order_id`) USING BTREE,
  CONSTRAINT `carriers_billing_ibfk_1` FOREIGN KEY (`carrier_id`) REFERENCES `carriers` (`carrier_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `carriers_billing_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `shipment` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of carriers_billing
-- ----------------------------

-- ----------------------------
-- Table structure for customer_billing
-- ----------------------------
DROP TABLE IF EXISTS `customer_billing`;
CREATE TABLE `customer_billing`  (
  `payment_id` int NOT NULL,
  `customer_id` int NULL DEFAULT NULL,
  `order_id` int NULL DEFAULT NULL,
  `payment_date` date NULL DEFAULT NULL,
  `payment_amount` decimal(10, 2) NULL DEFAULT NULL,
  `payment_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`payment_id`) USING BTREE,
  INDEX `customer_id`(`customer_id`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE,
  CONSTRAINT `customer_billing_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `customer_billing_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `shipment` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of customer_billing
-- ----------------------------

-- ----------------------------
-- Table structure for customers
-- ----------------------------
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers`  (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `last_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `company_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `country` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `postal_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`customer_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of customers
-- ----------------------------
INSERT INTO `customers` VALUES (1, '陈', '小明', 'xiaomingchen@163.com', '13812345678', 'ABC 公司', '上海市徐汇区虹桥路1234号', '上海市', '中国', '200000');
INSERT INTO `customers` VALUES (2, '王', '芳', 'fangwang@163.com', '13887654321', 'XYZ 有限公司', '北京市朝阳区建国路555号', '北京市', '中国', '100000');
INSERT INTO `customers` VALUES (3, '李', '华', 'hualee@163.com', '13987654321', 'PQR 贸易公司', '广东省深圳市福田区深南大道8888号', '深圳市', '中国', '518000');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` tinyint NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `weight` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, 1, '服装', '运动T恤', 99.99, 0.30);
INSERT INTO `goods` VALUES (2, 2, '家具', '单人沙发', 1999.99, 20.00);
INSERT INTO `goods` VALUES (3, 3, '电子产品', '智能手环', 299.99, 0.10);
INSERT INTO `goods` VALUES (4, 4, '食品', '麻辣小龙虾', 39.99, 1.00);
INSERT INTO `goods` VALUES (5, 5, '化妆品', '口红', 49.99, 0.05);

-- ----------------------------
-- Table structure for goods_batch
-- ----------------------------
DROP TABLE IF EXISTS `goods_batch`;
CREATE TABLE `goods_batch`  (
  `id` int NOT NULL,
  `goods_id` int NULL DEFAULT NULL,
  `order_id` int NULL DEFAULT NULL,
  `num` float NULL DEFAULT NULL,
  `total_price` double NULL DEFAULT NULL,
  `total_weight` double NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_goods_batch_goods_id`(`goods_id`) USING BTREE,
  INDEX `fk_goods_batch_order_id`(`order_id`) USING BTREE,
  CONSTRAINT `fk_goods_batch_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_goods_batch_order` FOREIGN KEY (`order_id`) REFERENCES `shipment` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods_batch
-- ----------------------------

-- ----------------------------
-- Table structure for shipment
-- ----------------------------
DROP TABLE IF EXISTS `shipment`;
CREATE TABLE `shipment`  (
  `order_id` int NOT NULL,
  `customer_id` int NULL DEFAULT NULL COMMENT '客户id',
  `carrier_id` int NULL DEFAULT NULL COMMENT '承运方id',
  `shipment_type_id` int NULL DEFAULT NULL COMMENT '物流类型',
  `is_free_shipping` tinyint NULL DEFAULT 0 COMMENT '邮费类型',
  `origin_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发货详细地址',
  `origin_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发货地',
  `origin_country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发货地国家',
  `origin_postal_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发货地邮编',
  `destination_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货详细地址',
  `destination_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货地',
  `destination_country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货地国家',
  `destination_postal_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货地邮编',
  `des` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `weight` decimal(10, 2) NULL DEFAULT NULL COMMENT '总重量',
  `value` decimal(10, 2) NULL DEFAULT NULL COMMENT '总价值',
  `order_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '运单状态',
  `pickup_date` date NULL DEFAULT NULL COMMENT '发货日期',
  `estimated_delivery_date` date NULL DEFAULT NULL COMMENT '预计收货日期',
  `actual_delivery_date` date NULL DEFAULT NULL COMMENT '实际收货日期',
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `consignee_id`(`customer_id`) USING BTREE,
  INDEX `carrier_id`(`carrier_id`) USING BTREE,
  INDEX `shipment_type_id`(`shipment_type_id`) USING BTREE,
  CONSTRAINT `shipment_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `shipment_ibfk_2` FOREIGN KEY (`carrier_id`) REFERENCES `carriers` (`carrier_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `shipment_ibfk_3` FOREIGN KEY (`shipment_type_id`) REFERENCES `shipment_types` (`shipment_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shipment
-- ----------------------------

-- ----------------------------
-- Table structure for shipment_events
-- ----------------------------
DROP TABLE IF EXISTS `shipment_events`;
CREATE TABLE `shipment_events`  (
  `event_id` int NOT NULL,
  `order_id` int NULL DEFAULT NULL,
  `event_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `event_date` date NULL DEFAULT NULL,
  `event_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `event_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`event_id`) USING BTREE,
  INDEX `shipment_events_ibfk_1`(`order_id`) USING BTREE,
  CONSTRAINT `shipment_events_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `shipment` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shipment_events
-- ----------------------------

-- ----------------------------
-- Table structure for shipment_rates
-- ----------------------------
DROP TABLE IF EXISTS `shipment_rates`;
CREATE TABLE `shipment_rates`  (
  `shipment_rate_id` int NOT NULL,
  `carrier_id` int NULL DEFAULT NULL,
  `shipment_type_id` int NULL DEFAULT NULL,
  `price_per_kg` decimal(10, 2) NULL DEFAULT NULL,
  `price_per_km` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`shipment_rate_id`) USING BTREE,
  INDEX `carrier_id`(`carrier_id`) USING BTREE,
  INDEX `shipment_type_id`(`shipment_type_id`) USING BTREE,
  CONSTRAINT `shipment_rates_ibfk_1` FOREIGN KEY (`carrier_id`) REFERENCES `carriers` (`carrier_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `shipment_rates_ibfk_2` FOREIGN KEY (`shipment_type_id`) REFERENCES `shipment_types` (`shipment_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shipment_rates
-- ----------------------------
INSERT INTO `shipment_rates` VALUES (1, 1, 1, 5.00, 0.10);
INSERT INTO `shipment_rates` VALUES (2, 1, 2, 10.00, 0.20);
INSERT INTO `shipment_rates` VALUES (3, 1, 3, 20.00, 0.50);
INSERT INTO `shipment_rates` VALUES (4, 2, 1, 6.00, 0.15);
INSERT INTO `shipment_rates` VALUES (5, 2, 2, 12.00, 0.25);
INSERT INTO `shipment_rates` VALUES (6, 2, 3, 24.00, 0.60);
INSERT INTO `shipment_rates` VALUES (7, 3, 1, 4.50, 0.12);
INSERT INTO `shipment_rates` VALUES (8, 3, 2, 9.00, 0.22);
INSERT INTO `shipment_rates` VALUES (9, 3, 3, 18.00, 0.55);

-- ----------------------------
-- Table structure for shipment_types
-- ----------------------------
DROP TABLE IF EXISTS `shipment_types`;
CREATE TABLE `shipment_types`  (
  `shipment_type_id` int NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`shipment_type_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shipment_types
-- ----------------------------
INSERT INTO `shipment_types` VALUES (1, '陆运', '通过陆路运输货物');
INSERT INTO `shipment_types` VALUES (2, '海运', '通过海路运输货物');
INSERT INTO `shipment_types` VALUES (3, '空运', '通过空运运输货物');

-- ----------------------------
-- Table structure for sys_content
-- ----------------------------
DROP TABLE IF EXISTS `sys_content`;
CREATE TABLE `sys_content`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '主键',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '标题',
  `one_img` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '单图url',
  `multiple_img` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '多图url',
  `keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '关键字',
  `type` int NULL DEFAULT NULL COMMENT '文章类型',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT '内容',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `create_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '文章管理' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_content
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `dept_no` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门编号(规则：父级关系编码+自己的编码)',
  `name` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `pid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '父级id',
  `status` tinyint NULL DEFAULT NULL COMMENT '状态(1:正常；0:弃用)',
  `relation_code` varchar(3000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '为了维护更深层级关系',
  `dept_manager_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门经理user_id',
  `manager_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门经理名称',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门经理联系电话',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT NULL COMMENT '是否删除(1未删除；0已删除)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统部门' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('1', 'D000001', '总公司', '0', 1, 'D000001', NULL, '小李', '13888888888', NULL, NULL, 1);

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典名称',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据字典表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('1255790029680242690', 'sex', '性别', '2020-04-30 17:24:09');
INSERT INTO `sys_dict` VALUES ('1255790029680242691', 'content_keyword', '关键字', '2020-04-30 17:24:09');
INSERT INTO `sys_dict` VALUES ('1282504369620430849', 'content_type', '文章类型略略略', '2020-07-13 10:37:24');

-- ----------------------------
-- Table structure for sys_dict_detail
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_detail`;
CREATE TABLE `sys_dict_detail`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典标签',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典值',
  `sort` smallint NULL DEFAULT NULL COMMENT '排序',
  `dict_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据字典详情' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_dict_detail
-- ----------------------------
INSERT INTO `sys_dict_detail` VALUES ('1255790073535885314', '男', '1', 1, '1255790029680242690', '2020-04-30 17:24:19');
INSERT INTO `sys_dict_detail` VALUES ('1255790100115189761', '女', '2', 2, '1255790029680242690', '2020-04-30 17:24:25');
INSERT INTO `sys_dict_detail` VALUES ('1282504475715350530', '诗词', '1', 1, '1282504369620430849', '2020-07-13 10:37:49');
INSERT INTO `sys_dict_detail` VALUES ('1282504651729317889', '散文', '2', 2, '1282504369620430849', '2020-07-13 10:38:31');
INSERT INTO `sys_dict_detail` VALUES ('1282846022950842369', '剧本', '3', 3, '1282504369620430849', '2020-07-14 09:15:01');
INSERT INTO `sys_dict_detail` VALUES ('1282846022950842370', 'java', '1', 1, '1255790029680242691', '2020-07-14 09:15:01');
INSERT INTO `sys_dict_detail` VALUES ('1282846022950842371', 'mysql', '2', 2, '1255790029680242691', '2020-07-14 09:15:01');

-- ----------------------------
-- Table structure for sys_files
-- ----------------------------
DROP TABLE IF EXISTS `sys_files`;
CREATE TABLE `sys_files`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'URL地址',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `file_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文件上传' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_files
-- ----------------------------

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务id',
  `bean_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'spring bean名称',
  `params` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数',
  `cron_expression` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'cron表达式',
  `status` tinyint NULL DEFAULT NULL COMMENT '任务状态  0：正常  1：暂停',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES ('1252884495040782337', 'testTask', '1', '0 */1 * * * ?', 0, '1', '2020-04-22 16:58:35');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务日志id',
  `job_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务id',
  `bean_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'spring bean名称',
  `params` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数',
  `status` tinyint NOT NULL COMMENT '任务状态    0：成功    1：失败',
  `error` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '失败信息',
  `times` int NOT NULL COMMENT '耗时(单位：毫秒)',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `job_id`(`job_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务日志' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
INSERT INTO `sys_job_log` VALUES ('1647546373461774338', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 18:24:00');
INSERT INTO `sys_job_log` VALUES ('1647546625040322562', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 18:25:00');
INSERT INTO `sys_job_log` VALUES ('1647546876736311297', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 18:26:00');
INSERT INTO `sys_job_log` VALUES ('1647547128381968386', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 18:27:00');
INSERT INTO `sys_job_log` VALUES ('1647547380019236865', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 18:28:00');
INSERT INTO `sys_job_log` VALUES ('1647547631732002818', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 18:29:00');
INSERT INTO `sys_job_log` VALUES ('1647547883377659906', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 18:30:00');
INSERT INTO `sys_job_log` VALUES ('1647548135019122690', '1252884495040782337', 'testTask', '1', 0, NULL, 24, '2023-04-16 18:31:00');
INSERT INTO `sys_job_log` VALUES ('1647548386694139905', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 18:32:00');
INSERT INTO `sys_job_log` VALUES ('1647548638356574209', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 18:33:00');
INSERT INTO `sys_job_log` VALUES ('1647548890019008513', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 18:34:00');
INSERT INTO `sys_job_log` VALUES ('1647549141660471298', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 18:35:00');
INSERT INTO `sys_job_log` VALUES ('1647549393314516994', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 18:36:00');
INSERT INTO `sys_job_log` VALUES ('1647549644935008257', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 18:37:00');
INSERT INTO `sys_job_log` VALUES ('1647549896635191297', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 18:38:00');
INSERT INTO `sys_job_log` VALUES ('1647550148268265474', '1252884495040782337', 'testTask', '1', 0, NULL, 2, '2023-04-16 18:39:00');
INSERT INTO `sys_job_log` VALUES ('1647550399918116866', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 18:40:00');
INSERT INTO `sys_job_log` VALUES ('1647550651588939777', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 18:41:00');
INSERT INTO `sys_job_log` VALUES ('1647550903251374081', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 18:42:00');
INSERT INTO `sys_job_log` VALUES ('1647551154884448258', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 18:43:00');
INSERT INTO `sys_job_log` VALUES ('1647551406676905985', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 18:44:00');
INSERT INTO `sys_job_log` VALUES ('1647551658259648514', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 18:45:00');
INSERT INTO `sys_job_log` VALUES ('1647551909909499905', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 18:46:00');
INSERT INTO `sys_job_log` VALUES ('1647552161576128514', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 18:47:00');
INSERT INTO `sys_job_log` VALUES ('1647552413188231169', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 18:48:00');
INSERT INTO `sys_job_log` VALUES ('1647552664892608513', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 18:49:00');
INSERT INTO `sys_job_log` VALUES ('1647552916508905474', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 18:50:00');
INSERT INTO `sys_job_log` VALUES ('1647553168167145474', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 18:51:00');
INSERT INTO `sys_job_log` VALUES ('1647553419829579777', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 18:52:00');
INSERT INTO `sys_job_log` VALUES ('1647553671529762818', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 18:53:00');
INSERT INTO `sys_job_log` VALUES ('1647553923133476865', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 18:54:00');
INSERT INTO `sys_job_log` VALUES ('1647554174837854209', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 18:55:00');
INSERT INTO `sys_job_log` VALUES ('1647554426475122690', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 18:56:00');
INSERT INTO `sys_job_log` VALUES ('1647554678154334210', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 18:57:00');
INSERT INTO `sys_job_log` VALUES ('1647554929783214082', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 18:58:00');
INSERT INTO `sys_job_log` VALUES ('1647555181428871169', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 18:59:00');
INSERT INTO `sys_job_log` VALUES ('1647555433129054210', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:00:00');
INSERT INTO `sys_job_log` VALUES ('1647555684732768257', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:01:00');
INSERT INTO `sys_job_log` VALUES ('1647555936420368385', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:02:00');
INSERT INTO `sys_job_log` VALUES ('1647556188103774210', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:03:00');
INSERT INTO `sys_job_log` VALUES ('1647556439766208514', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:04:00');
INSERT INTO `sys_job_log` VALUES ('1647556691407671298', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:05:00');
INSERT INTO `sys_job_log` VALUES ('1647556943028162561', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 19:06:00');
INSERT INTO `sys_job_log` VALUES ('1647557194728345602', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:07:00');
INSERT INTO `sys_job_log` VALUES ('1647557446453731330', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:08:00');
INSERT INTO `sys_job_log` VALUES ('1647557698019696642', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:09:00');
INSERT INTO `sys_job_log` VALUES ('1647557949686325249', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:10:00');
INSERT INTO `sys_job_log` VALUES ('1647558201449431041', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:11:00');
INSERT INTO `sys_job_log` VALUES ('1647558453002813441', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:12:00');
INSERT INTO `sys_job_log` VALUES ('1647558704644276225', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:13:00');
INSERT INTO `sys_job_log` VALUES ('1647558956302516226', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:14:00');
INSERT INTO `sys_job_log` VALUES ('1647559207985922050', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:15:00');
INSERT INTO `sys_job_log` VALUES ('1647559459614801922', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:16:00');
INSERT INTO `sys_job_log` VALUES ('1647559711310790657', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:17:00');
INSERT INTO `sys_job_log` VALUES ('1647559963031945217', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:18:00');
INSERT INTO `sys_job_log` VALUES ('1647560214581133314', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:19:00');
INSERT INTO `sys_job_log` VALUES ('1647560466256150529', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:20:00');
INSERT INTO `sys_job_log` VALUES ('1647560718027681793', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 19:21:00');
INSERT INTO `sys_job_log` VALUES ('1647560969576869890', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:22:00');
INSERT INTO `sys_job_log` VALUES ('1647561221260275714', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:23:00');
INSERT INTO `sys_job_log` VALUES ('1647561472897544194', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 19:24:00');
INSERT INTO `sys_job_log` VALUES ('1647561724555784193', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:25:00');
INSERT INTO `sys_job_log` VALUES ('1647561976188858369', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:26:00');
INSERT INTO `sys_job_log` VALUES ('1647562227893235713', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:27:00');
INSERT INTO `sys_job_log` VALUES ('1647562479559864322', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:28:00');
INSERT INTO `sys_job_log` VALUES ('1647562731218104321', '1252884495040782337', 'testTask', '1', 0, NULL, 2, '2023-04-16 19:29:00');
INSERT INTO `sys_job_log` VALUES ('1647562982842789889', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:30:00');
INSERT INTO `sys_job_log` VALUES ('1647563234530390018', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:31:00');
INSERT INTO `sys_job_log` VALUES ('1647563486155075585', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:32:00');
INSERT INTO `sys_job_log` VALUES ('1647563737830092801', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:33:00');
INSERT INTO `sys_job_log` VALUES ('1647563989479944194', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:34:00');
INSERT INTO `sys_job_log` VALUES ('1647566254508933122', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:43:00');
INSERT INTO `sys_job_log` VALUES ('1647566506070704130', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:44:00');
INSERT INTO `sys_job_log` VALUES ('1647566757749915650', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 19:45:00');
INSERT INTO `sys_job_log` VALUES ('1647567009399767041', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 19:46:00');
INSERT INTO `sys_job_log` VALUES ('1647567261053812737', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:47:00');
INSERT INTO `sys_job_log` VALUES ('1647567512724635649', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:48:00');
INSERT INTO `sys_job_log` VALUES ('1647567764374487042', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:49:00');
INSERT INTO `sys_job_log` VALUES ('1647568016108244993', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 19:50:00');
INSERT INTO `sys_job_log` VALUES ('1647568267670016001', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:51:00');
INSERT INTO `sys_job_log` VALUES ('1647568519336644610', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:52:00');
INSERT INTO `sys_job_log` VALUES ('1647568770982301698', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:53:00');
INSERT INTO `sys_job_log` VALUES ('1647569526011506689', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:56:00');
INSERT INTO `sys_job_log` VALUES ('1647569777611026433', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:57:00');
INSERT INTO `sys_job_log` VALUES ('1647570029298626561', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:58:00');
INSERT INTO `sys_job_log` VALUES ('1647570281015582721', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 19:59:00');
INSERT INTO `sys_job_log` VALUES ('1647570532602519554', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:00:00');
INSERT INTO `sys_job_log` VALUES ('1647570784227205121', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:01:00');
INSERT INTO `sys_job_log` VALUES ('1647571035914805250', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:02:00');
INSERT INTO `sys_job_log` VALUES ('1647571287585628161', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:03:00');
INSERT INTO `sys_job_log` VALUES ('1647571539239673858', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:04:00');
INSERT INTO `sys_job_log` VALUES ('1647571790897913858', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:05:00');
INSERT INTO `sys_job_log` VALUES ('1647572042560348162', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:06:00');
INSERT INTO `sys_job_log` VALUES ('1647572294172450817', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:07:00');
INSERT INTO `sys_job_log` VALUES ('1647572545860050946', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:08:00');
INSERT INTO `sys_job_log` VALUES ('1647572797505708034', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:09:00');
INSERT INTO `sys_job_log` VALUES ('1647573049197502466', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:10:00');
INSERT INTO `sys_job_log` VALUES ('1647573300851548162', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:11:00');
INSERT INTO `sys_job_log` VALUES ('1647573552488816641', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:12:00');
INSERT INTO `sys_job_log` VALUES ('1647573804126085121', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:13:00');
INSERT INTO `sys_job_log` VALUES ('1647574055792713729', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:14:00');
INSERT INTO `sys_job_log` VALUES ('1647574307471925250', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:15:00');
INSERT INTO `sys_job_log` VALUES ('1647574559134359554', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:16:00');
INSERT INTO `sys_job_log` VALUES ('1647574810788405249', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:17:00');
INSERT INTO `sys_job_log` VALUES ('1647575062459228162', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:18:00');
INSERT INTO `sys_job_log` VALUES ('1647575314125856770', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:19:00');
INSERT INTO `sys_job_log` VALUES ('1647575565763125250', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:20:00');
INSERT INTO `sys_job_log` VALUES ('1647575817450725378', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:21:00');
INSERT INTO `sys_job_log` VALUES ('1647576069054439426', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:22:00');
INSERT INTO `sys_job_log` VALUES ('1647576320721068034', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:23:00');
INSERT INTO `sys_job_log` VALUES ('1647576572379308033', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:24:00');
INSERT INTO `sys_job_log` VALUES ('1647576824037548033', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:25:00');
INSERT INTO `sys_job_log` VALUES ('1647577075683205122', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:26:00');
INSERT INTO `sys_job_log` VALUES ('1647577327374999553', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:27:00');
INSERT INTO `sys_job_log` VALUES ('1647577579020656641', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:28:00');
INSERT INTO `sys_job_log` VALUES ('1647577830678896641', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:29:00');
INSERT INTO `sys_job_log` VALUES ('1647578082370691073', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:30:00');
INSERT INTO `sys_job_log` VALUES ('1647578333982793729', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:31:00');
INSERT INTO `sys_job_log` VALUES ('1647578585682976769', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:32:00');
INSERT INTO `sys_job_log` VALUES ('1647578837299273730', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:33:00');
INSERT INTO `sys_job_log` VALUES ('1647579088986873858', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:34:00');
INSERT INTO `sys_job_log` VALUES ('1647579340615753730', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:35:00');
INSERT INTO `sys_job_log` VALUES ('1647579592269799426', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:36:00');
INSERT INTO `sys_job_log` VALUES ('1647579843940622337', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:37:00');
INSERT INTO `sys_job_log` VALUES ('1647580095603056641', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:38:00');
INSERT INTO `sys_job_log` VALUES ('1647580347269685250', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:39:00');
INSERT INTO `sys_job_log` VALUES ('1647580598982434817', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:40:00');
INSERT INTO `sys_job_log` VALUES ('1647581605640601601', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:44:00');
INSERT INTO `sys_job_log` VALUES ('1647581857269538818', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:45:00');
INSERT INTO `sys_job_log` VALUES ('1647582108906807297', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:46:00');
INSERT INTO `sys_job_log` VALUES ('1647582360527298561', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:47:00');
INSERT INTO `sys_job_log` VALUES ('1647582612219092993', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 20:48:00');
INSERT INTO `sys_job_log` VALUES ('1647582863822807042', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 20:49:00');
INSERT INTO `sys_job_log` VALUES ('1647583115539767298', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:50:00');
INSERT INTO `sys_job_log` VALUES ('1647583367185424385', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:51:00');
INSERT INTO `sys_job_log` VALUES ('1647583618847858689', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:52:00');
INSERT INTO `sys_job_log` VALUES ('1647583870493515777', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:53:00');
INSERT INTO `sys_job_log` VALUES ('1647584122155950081', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 20:54:00');
INSERT INTO `sys_job_log` VALUES ('1647584373818384386', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 20:55:00');
INSERT INTO `sys_job_log` VALUES ('1647584625451458562', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 20:56:00');
INSERT INTO `sys_job_log` VALUES ('1647584877122281474', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 20:57:00');
INSERT INTO `sys_job_log` VALUES ('1647585128784715777', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 20:58:00');
INSERT INTO `sys_job_log` VALUES ('1647585380409401346', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 20:59:00');
INSERT INTO `sys_job_log` VALUES ('1647585632084418562', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:00:00');
INSERT INTO `sys_job_log` VALUES ('1647585883763630081', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 21:01:00');
INSERT INTO `sys_job_log` VALUES ('1647586135417675777', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:02:00');
INSERT INTO `sys_job_log` VALUES ('1647586387084304385', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 21:03:00');
INSERT INTO `sys_job_log` VALUES ('1647586638721572865', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:04:00');
INSERT INTO `sys_job_log` VALUES ('1647586890379812866', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:05:00');
INSERT INTO `sys_job_log` VALUES ('1647587393805238274', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 21:07:00');
INSERT INTO `sys_job_log` VALUES ('1647588148708691969', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:10:00');
INSERT INTO `sys_job_log` VALUES ('1647588400358543362', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:11:00');
INSERT INTO `sys_job_log` VALUES ('1647588652016783361', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:12:00');
INSERT INTO `sys_job_log` VALUES ('1647588903679217665', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:13:00');
INSERT INTO `sys_job_log` VALUES ('1647589155312291841', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:14:00');
INSERT INTO `sys_job_log` VALUES ('1647589406970531842', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 21:15:00');
INSERT INTO `sys_job_log` VALUES ('1647589658595217410', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 21:16:00');
INSERT INTO `sys_job_log` VALUES ('1647589910303789057', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 21:17:00');
INSERT INTO `sys_job_log` VALUES ('1647590161928474626', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:18:00');
INSERT INTO `sys_job_log` VALUES ('1647590413620269058', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 21:19:00');
INSERT INTO `sys_job_log` VALUES ('1647590665282703361', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 21:20:00');
INSERT INTO `sys_job_log` VALUES ('1647590916936749058', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:21:00');
INSERT INTO `sys_job_log` VALUES ('1647591168561434625', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 21:22:00');
INSERT INTO `sys_job_log` VALUES ('1647591420198703105', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:23:00');
INSERT INTO `sys_job_log` VALUES ('1647591671861137410', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:24:00');
INSERT INTO `sys_job_log` VALUES ('1647591923527766018', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:25:00');
INSERT INTO `sys_job_log` VALUES ('1647592175186006017', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 21:26:00');
INSERT INTO `sys_job_log` VALUES ('1647592426835857409', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 21:27:00');
INSERT INTO `sys_job_log` VALUES ('1647592678552817666', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:28:00');
INSERT INTO `sys_job_log` VALUES ('1647592930156531714', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:29:00');
INSERT INTO `sys_job_log` VALUES ('1647593181839937537', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:30:00');
INSERT INTO `sys_job_log` VALUES ('1647593433510760450', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 21:31:00');
INSERT INTO `sys_job_log` VALUES ('1647593685139640321', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:32:00');
INSERT INTO `sys_job_log` VALUES ('1647593936797880322', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:33:00');
INSERT INTO `sys_job_log` VALUES ('1647594188468703234', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:34:00');
INSERT INTO `sys_job_log` VALUES ('1647594440131137538', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:35:00');
INSERT INTO `sys_job_log` VALUES ('1647594691780988930', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:36:00');
INSERT INTO `sys_job_log` VALUES ('1647594943464394754', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:37:00');
INSERT INTO `sys_job_log` VALUES ('1647595195135217665', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 21:38:00');
INSERT INTO `sys_job_log` VALUES ('1647595446768291841', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:39:00');
INSERT INTO `sys_job_log` VALUES ('1647595698451697666', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 21:40:00');
INSERT INTO `sys_job_log` VALUES ('1647595950093160449', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 21:41:00');
INSERT INTO `sys_job_log` VALUES ('1647596201705263106', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 21:42:00');
INSERT INTO `sys_job_log` VALUES ('1647596453384474626', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:43:00');
INSERT INTO `sys_job_log` VALUES ('1647596705059491842', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:44:00');
INSERT INTO `sys_job_log` VALUES ('1647596956738703361', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:45:00');
INSERT INTO `sys_job_log` VALUES ('1647597208396943361', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 21:46:00');
INSERT INTO `sys_job_log` VALUES ('1647597460017434625', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:47:00');
INSERT INTO `sys_job_log` VALUES ('1647597711688257537', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 21:48:00');
INSERT INTO `sys_job_log` VALUES ('1647597963312943105', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 21:49:00');
INSERT INTO `sys_job_log` VALUES ('1647598215021514754', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:50:00');
INSERT INTO `sys_job_log` VALUES ('1647598466633617410', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 21:51:00');
INSERT INTO `sys_job_log` VALUES ('1647598970042376194', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 21:53:00');
INSERT INTO `sys_job_log` VALUES ('1647599221633507330', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:54:00');
INSERT INTO `sys_job_log` VALUES ('1647599473266581506', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:55:00');
INSERT INTO `sys_job_log` VALUES ('1647599724949987329', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:56:00');
INSERT INTO `sys_job_log` VALUES ('1647599976604033025', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 21:57:00');
INSERT INTO `sys_job_log` VALUES ('1647600228279050242', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 21:58:00');
INSERT INTO `sys_job_log` VALUES ('1647600479958261761', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 21:59:00');
INSERT INTO `sys_job_log` VALUES ('1647600731574558721', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:00:00');
INSERT INTO `sys_job_log` VALUES ('1647600983232798721', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:01:00');
INSERT INTO `sys_job_log` VALUES ('1647601234916204545', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:02:00');
INSERT INTO `sys_job_log` VALUES ('1647601486557667329', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:03:00');
INSERT INTO `sys_job_log` VALUES ('1647601738190741506', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 22:04:00');
INSERT INTO `sys_job_log` VALUES ('1647601989865758721', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:05:00');
INSERT INTO `sys_job_log` VALUES ('1647602241561747457', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:06:00');
INSERT INTO `sys_job_log` VALUES ('1647602493211598850', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:07:00');
INSERT INTO `sys_job_log` VALUES ('1647602744869838849', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:08:00');
INSERT INTO `sys_job_log` VALUES ('1647603499819393026', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 22:11:00');
INSERT INTO `sys_job_log` VALUES ('1647603751511187458', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:12:00');
INSERT INTO `sys_job_log` VALUES ('1647604003119095810', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 22:13:00');
INSERT INTO `sys_job_log` VALUES ('1647604254819278849', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 22:14:00');
INSERT INTO `sys_job_log` VALUES ('1647604506477518849', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 22:15:00');
INSERT INTO `sys_job_log` VALUES ('1647604758123175938', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:16:00');
INSERT INTO `sys_job_log` VALUES ('1647605009798193154', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:17:00');
INSERT INTO `sys_job_log` VALUES ('1647605261439655937', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:18:00');
INSERT INTO `sys_job_log` VALUES ('1647605513114673153', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:19:00');
INSERT INTO `sys_job_log` VALUES ('1647605764764524545', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:20:00');
INSERT INTO `sys_job_log` VALUES ('1647606016418570241', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:21:00');
INSERT INTO `sys_job_log` VALUES ('1647606268064227329', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:22:00');
INSERT INTO `sys_job_log` VALUES ('1647606519735050242', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 22:23:00');
INSERT INTO `sys_job_log` VALUES ('1647606771372318722', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:24:00');
INSERT INTO `sys_job_log` VALUES ('1647607023013781505', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:25:00');
INSERT INTO `sys_job_log` VALUES ('1647607274730741761', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 22:26:00');
INSERT INTO `sys_job_log` VALUES ('1647607526347038722', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:27:00');
INSERT INTO `sys_job_log` VALUES ('1647607777996890113', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:28:00');
INSERT INTO `sys_job_log` VALUES ('1647608029646741506', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 22:29:00');
INSERT INTO `sys_job_log` VALUES ('1647608281304981505', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:30:00');
INSERT INTO `sys_job_log` VALUES ('1647608533000970242', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:31:00');
INSERT INTO `sys_job_log` VALUES ('1647608784650821634', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:32:00');
INSERT INTO `sys_job_log` VALUES ('1647609036321644546', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 22:33:00');
INSERT INTO `sys_job_log` VALUES ('1647609287988273154', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:34:00');
INSERT INTO `sys_job_log` VALUES ('1647609539646513153', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:35:00');
INSERT INTO `sys_job_log` VALUES ('1647609791317336065', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:36:00');
INSERT INTO `sys_job_log` VALUES ('1647610042925244418', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:37:00');
INSERT INTO `sys_job_log` VALUES ('1647610294625427457', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:38:00');
INSERT INTO `sys_job_log` VALUES ('1647610546254307330', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:39:00');
INSERT INTO `sys_job_log` VALUES ('1647610797899964417', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 22:40:00');
INSERT INTO `sys_job_log` VALUES ('1647611049600147457', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:41:00');
INSERT INTO `sys_job_log` VALUES ('1647611301220638722', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:42:00');
INSERT INTO `sys_job_log` VALUES ('1647611552883073026', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:43:00');
INSERT INTO `sys_job_log` VALUES ('1647611804579061761', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:44:00');
INSERT INTO `sys_job_log` VALUES ('1647612056224718849', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 22:45:00');
INSERT INTO `sys_job_log` VALUES ('1647612307878764545', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:46:00');
INSERT INTO `sys_job_log` VALUES ('1647612559520227330', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 22:47:00');
INSERT INTO `sys_job_log` VALUES ('1647612811186855937', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 22:48:00');
INSERT INTO `sys_job_log` VALUES ('1647613062861873153', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 22:49:00');
INSERT INTO `sys_job_log` VALUES ('1647613314499141633', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 22:50:00');
INSERT INTO `sys_job_log` VALUES ('1647613566140604417', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:51:00');
INSERT INTO `sys_job_log` VALUES ('1647613817803038722', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:52:00');
INSERT INTO `sys_job_log` VALUES ('1647614069448695809', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:53:00');
INSERT INTO `sys_job_log` VALUES ('1647614321157267457', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 22:54:00');
INSERT INTO `sys_job_log` VALUES ('1647614572786147329', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 22:55:00');
INSERT INTO `sys_job_log` VALUES ('1647614824469553153', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 22:56:00');
INSERT INTO `sys_job_log` VALUES ('1647615076102627329', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:57:00');
INSERT INTO `sys_job_log` VALUES ('1647615327765061634', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:58:00');
INSERT INTO `sys_job_log` VALUES ('1647615579410718722', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 22:59:00');
INSERT INTO `sys_job_log` VALUES ('1647615831047987201', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 23:00:00');
INSERT INTO `sys_job_log` VALUES ('1647616082760753153', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 23:01:00');
INSERT INTO `sys_job_log` VALUES ('1647616334364467201', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 23:02:00');
INSERT INTO `sys_job_log` VALUES ('1647616586056261633', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 23:03:00');
INSERT INTO `sys_job_log` VALUES ('1647616837739667458', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 23:04:00');
INSERT INTO `sys_job_log` VALUES ('1647617089381130242', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 23:05:00');
INSERT INTO `sys_job_log` VALUES ('1647617341030981634', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 23:06:00');
INSERT INTO `sys_job_log` VALUES ('1647617592668250113', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-16 23:07:00');
INSERT INTO `sys_job_log` VALUES ('1647617844343267330', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-16 23:08:00');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户id',
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户操作',
  `time` int NULL DEFAULT NULL COMMENT '响应时间',
  `method` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求方法',
  `params` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求参数',
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('1647550961069854721', '1', 'admin', '角色管理-分页获取角色信息', 8, 'com.company.project.controller.sys.RoleController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.0.104', '2023-04-16 18:42:14');
INSERT INTO `sys_log` VALUES ('1647550964081364993', '1', 'admin', '菜单权限管理-获取所有菜单权限', 116, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.0.104', '2023-04-16 18:42:15');
INSERT INTO `sys_log` VALUES ('1647551015012798466', '1', 'admin', '角色管理-分页获取角色信息', 5, 'com.company.project.controller.sys.RoleController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.0.104', '2023-04-16 18:42:27');
INSERT INTO `sys_log` VALUES ('1647551019907551233', '1', 'admin', '机构管理-树型组织列表', 17, 'com.company.project.controller.sys.DeptController.getTree()', '[null]', '192.168.0.104', '2023-04-16 18:42:28');
INSERT INTO `sys_log` VALUES ('1647551019907551234', '1', 'admin', '用户管理-分页获取用户列表', 11, 'com.company.project.controller.sys.UserController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.0.104', '2023-04-16 18:42:28');
INSERT INTO `sys_log` VALUES ('1647551028690423810', '1', 'admin', '机构管理-获取所有组织机构', 3, 'com.company.project.controller.sys.DeptController.getDeptAll()', NULL, '192.168.0.104', '2023-04-16 18:42:30');
INSERT INTO `sys_log` VALUES ('1647551283498586114', '1', 'admin', '角色管理-分页获取角色信息', 5, 'com.company.project.controller.sys.RoleController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.0.104', '2023-04-16 18:43:31');
INSERT INTO `sys_log` VALUES ('1647551292415676417', '1', 'admin', '机构管理-树型组织列表', 2, 'com.company.project.controller.sys.DeptController.getTree()', '[null]', '192.168.0.104', '2023-04-16 18:43:33');
INSERT INTO `sys_log` VALUES ('1647551292482785281', '1', 'admin', '用户管理-分页获取用户列表', 14, 'com.company.project.controller.sys.UserController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.0.104', '2023-04-16 18:43:33');
INSERT INTO `sys_log` VALUES ('1647551296014389250', '1', 'admin', '机构管理-获取所有组织机构', 3, 'com.company.project.controller.sys.DeptController.getDeptAll()', NULL, '192.168.0.104', '2023-04-16 18:43:34');
INSERT INTO `sys_log` VALUES ('1647551315643731970', '1', 'admin', '系统操作日志管理-分页查询系统操作日志', 12, 'com.company.project.controller.sys.SysLogController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.0.104', '2023-04-16 18:43:38');
INSERT INTO `sys_log` VALUES ('1647551348128616449', '1', 'admin', '角色管理-分页获取角色信息', 5, 'com.company.project.controller.sys.RoleController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.0.104', '2023-04-16 18:43:46');
INSERT INTO `sys_log` VALUES ('1647551641977360385', '1', 'admin', '系统操作日志管理-分页查询系统操作日志', 8, 'com.company.project.controller.sys.SysLogController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.0.104', '2023-04-16 18:44:56');
INSERT INTO `sys_log` VALUES ('1647551778447429634', '1', 'admin', '角色管理-分页获取角色信息', 7, 'com.company.project.controller.sys.RoleController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.0.104', '2023-04-16 18:45:29');
INSERT INTO `sys_log` VALUES ('1647556772986884097', '1', 'admin', '机构管理-获取所有组织机构', 6, 'com.company.project.controller.sys.DeptController.getDeptAll()', NULL, '192.168.0.104', '2023-04-16 19:05:19');
INSERT INTO `sys_log` VALUES ('1647556829282832385', '1', 'admin', '机构管理-树型组织列表', 2, 'com.company.project.controller.sys.DeptController.getTree()', '[null]', '192.168.0.104', '2023-04-16 19:05:33');
INSERT INTO `sys_log` VALUES ('1647556829349941250', '1', 'admin', '用户管理-分页获取用户列表', 12, 'com.company.project.controller.sys.UserController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.0.104', '2023-04-16 19:05:33');
INSERT INTO `sys_log` VALUES ('1647556854394130433', '1', 'admin', '角色管理-分页获取角色信息', 4, 'com.company.project.controller.sys.RoleController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.0.104', '2023-04-16 19:05:39');
INSERT INTO `sys_log` VALUES ('1647556870928076802', '1', 'admin', '机构管理-获取所有组织机构', 4, 'com.company.project.controller.sys.DeptController.getDeptAll()', NULL, '192.168.0.104', '2023-04-16 19:05:43');
INSERT INTO `sys_log` VALUES ('1647556922840977410', '1', 'admin', '角色管理-分页获取角色信息', 6, 'com.company.project.controller.sys.RoleController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.0.104', '2023-04-16 19:05:55');
INSERT INTO `sys_log` VALUES ('1647556963274067970', '1', 'admin', '菜单权限管理-获取所有菜单权限', 114, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.0.104', '2023-04-16 19:06:05');
INSERT INTO `sys_log` VALUES ('1647559044328374274', '1', 'admin', '机构管理-树型组织列表', 25, 'com.company.project.controller.sys.DeptController.getTree()', '[null]', '192.168.0.104', '2023-04-16 19:14:21');
INSERT INTO `sys_log` VALUES ('1647559044328374275', '1', 'admin', '用户管理-分页获取用户列表', 24, 'com.company.project.controller.sys.UserController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.0.104', '2023-04-16 19:14:21');
INSERT INTO `sys_log` VALUES ('1647588587114123265', '1', 'admin', '机构管理-获取所有组织机构', 8, 'com.company.project.controller.sys.DeptController.getDeptAll()', NULL, '192.168.0.104', '2023-04-16 21:11:45');
INSERT INTO `sys_log` VALUES ('1647588594907140098', '1', 'admin', '机构管理-树型组织列表', 9, 'com.company.project.controller.sys.DeptController.getTree()', '[\"\"]', '192.168.0.104', '2023-04-16 21:11:46');
INSERT INTO `sys_log` VALUES ('1647598617997660161', '1', 'admin', '系统操作日志管理-分页查询系统操作日志', 42, 'com.company.project.controller.sys.SysLogController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.0.104', '2023-04-16 21:51:36');

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `name` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单权限名称',
  `perms` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：sys:user:add,sys:user:edit)',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '访问地址URL',
  `target` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'a target属性:_self _blank',
  `pid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父级菜单权限名称',
  `order_num` int NULL DEFAULT NULL COMMENT '排序',
  `type` tinyint NULL DEFAULT NULL COMMENT '菜单权限类型(1:目录;2:菜单;3:按钮)',
  `status` tinyint NULL DEFAULT NULL COMMENT '状态1:正常 0：禁用',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT NULL COMMENT '是否删除(1未删除；0已删除)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统权限' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES ('1', '删除', 'sysGenerator:delete', NULL, 'sysGenerator/delete', NULL, '15', 1, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('10', '赋予角色', 'sys:user:role:update', NULL, 'sys/user/roles/*', NULL, '24', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('11', '菜单权限管理', NULL, NULL, 'index/menus', '_self', '51', 98, 2, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('12', '列表', 'sys:dept:list', NULL, 'sys/depts', NULL, '41', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('13', '删除', 'sys:role:deleted', NULL, 'sys/role/*', NULL, '53', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('1311115974068449281', '数据权限', 'sys:role:bindDept', '', 'sys/role/bindDept', '_self', '53', 5, 3, 1, '2020-09-30 09:29:42', NULL, 1);
INSERT INTO `sys_permission` VALUES ('14', '定时任务立即执行', 'sysJob:run', NULL, 'sysJob/run', '_self', '59', 5, 3, 1, '2020-04-22 15:47:54', NULL, 1);
INSERT INTO `sys_permission` VALUES ('15', '代码生成', NULL, NULL, 'index/sysGenerator', '_self', '54', 1, 2, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('16', '列表', 'sysGenerator:list', NULL, 'sysGenerator/listByPage', NULL, '15', 1, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('1647547032789585922', '供应商', NULL, NULL, 'index/carriers', '_self', '21', 10, 2, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647547032789585923', '新增', 'carriers:add', NULL, 'carriers/add', NULL, '1647547032789585922', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647547032789585924', '修改', 'carriers:update', NULL, 'carriers/update', NULL, '1647547032789585922', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647547032789585925', '删除', 'carriers:delete', NULL, 'carriers/delete', NULL, '1647547032789585922', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647547032789585926', '列表', 'carriers:list', NULL, 'carriers/listByPage', NULL, '1647547032789585922', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647561651239350273', '客户', NULL, NULL, 'index/customers', '_self', '21', 10, 2, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647561651239350274', '新增', 'customers:add', NULL, 'customers/add', NULL, '1647561651239350273', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647561651239350275', '修改', 'customers:update', NULL, 'customers/update', NULL, '1647561651239350273', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647561651239350276', '删除', 'customers:delete', NULL, 'customers/delete', NULL, '1647561651239350273', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647561651239350277', '列表', 'customers:list', NULL, 'customers/listByPage', NULL, '1647561651239350273', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647572648771493890', '货物类型', NULL, NULL, 'index/goods', '_self', '21', 10, 2, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647572648771493891', '新增', 'goods:add', NULL, 'goods/add', NULL, '1647572648771493890', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647572648771493892', '修改', 'goods:update', NULL, 'goods/update', NULL, '1647572648771493890', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647572648771493893', '删除', 'goods:delete', NULL, 'goods/delete', NULL, '1647572648771493890', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647572648771493894', '列表', 'goods:list', NULL, 'goods/listByPage', NULL, '1647572648771493890', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647585172439031810', '运单', NULL, NULL, 'index/shipment', '_self', '21', 10, 2, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647585172439031811', '新增', 'shipment:add', NULL, 'shipment/add', NULL, '1647585172439031810', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647585172439031812', '修改', 'shipment:update', NULL, 'shipment/update', NULL, '1647585172439031810', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647585172439031813', '删除', 'shipment:delete', NULL, 'shipment/delete', NULL, '1647585172439031810', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647585172439031814', '列表', 'shipment:list', NULL, 'shipment/listByPage', NULL, '1647585172439031810', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('17', '详情', 'sys:permission:detail', NULL, 'sys/permission/*', NULL, '11', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('18', '定时任务恢复', 'sysJob:resume', NULL, 'sysJob/resume', '_self', '59', 4, 3, 1, '2020-04-22 15:48:40', NULL, 1);
INSERT INTO `sys_permission` VALUES ('19', '列表', 'sys:role:list', NULL, 'sys/roles', NULL, '53', 0, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('2', 'SQL 监控', '', '', 'druid/sql.html', '_self', '21', 98, 2, 1, '2020-03-19 13:29:40', '2020-05-07 13:36:59', 1);
INSERT INTO `sys_permission` VALUES ('20', '修改', 'sysGenerator:update', NULL, 'sysGenerator/update', NULL, '15', 1, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('21', '其他', NULL, 'layui-icon-list', NULL, NULL, '0', 200, 1, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('22', '详情', 'sys:dept:detail', NULL, 'sys/dept/*', NULL, '41', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('23', '列表', 'sys:user:list', NULL, 'sys/users', NULL, '24', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('24', '用户管理', NULL, NULL, 'index/users', '_self', '51', 100, 2, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('25', '详情', 'sys:user:detail', NULL, 'sys/user/*', NULL, '24', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('26', '删除', 'sys:permission:deleted', NULL, 'sys/permission/*', NULL, '11', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('27', '文件管理', '', '', 'index/sysFiles', '_self', '54', 10, 2, 1, NULL, '2020-06-15 16:00:29', 1);
INSERT INTO `sys_permission` VALUES ('28', '列表', 'sysFiles:list', NULL, 'sysFiles/listByPage', NULL, '27', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('29', '新增', 'sysFiles:add', NULL, 'sysFiles/add', NULL, '27', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('3', '新增', 'sys:role:add', NULL, 'sys/role', NULL, '53', 0, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('30', '删除', 'sysFiles:delete', NULL, 'sysFiles/delete', NULL, '27', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('31', '文章管理', NULL, NULL, 'index/sysContent', '_self', '54', 10, 2, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('32', '列表', 'sysContent:list', NULL, 'sysContent/listByPage', NULL, '31', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('33', '新增', 'sysContent:add', NULL, 'sysContent/add', NULL, '31', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('34', '修改', 'sysContent:update', NULL, 'sysContent/update', NULL, '31', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('35', '删除', 'sysContent:delete', NULL, 'sysContent/delete', NULL, '31', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('36', '更新', 'sys:role:update', NULL, 'sys/role', NULL, '53', 0, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('38', '更新', 'sys:dept:update', NULL, 'sys/dept', NULL, '41', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('39', '详情', 'sys:role:detail', NULL, 'sys/role/*', NULL, '53', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('4', '添加', 'sysGenerator:add', NULL, 'sysGenerator/add', NULL, '15', 1, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('40', '编辑', 'sys:permission:update', NULL, 'sys/permission', NULL, '11', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('41', '部门管理', NULL, NULL, 'index/depts', '_self', '51', 100, 2, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('42', '新增', 'sys:user:add', NULL, 'sys/user', NULL, '24', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('43', '列表', 'sys:permission:list', NULL, 'sys/permissions', NULL, '11', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('44', '新增', 'sys:permission:add', NULL, 'sys/permission', NULL, '11', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('45', '字典管理', NULL, '', 'index/sysDict', NULL, '54', 10, 2, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('46', '列表', 'sysDict:list', NULL, 'sysDict/listByPage', NULL, '45', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('47', '新增', 'sysDict:add', NULL, 'sysDict/add', NULL, '45', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('48', '修改', 'sysDict:update', NULL, 'sysDict/update', NULL, '45', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('49', '删除', 'sysDict:delete', NULL, 'sysDict/delete', NULL, '45', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('5', '删除', 'sys:dept:deleted', NULL, 'sys/dept/*', NULL, '41', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('50', '表单构建', '', '', 'index/build', '_self', '21', 1, 2, 1, '2020-04-22 13:09:41', '2020-05-07 13:36:47', 1);
INSERT INTO `sys_permission` VALUES ('51', '组织管理', NULL, 'layui-icon-user', NULL, NULL, '0', 1, 1, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('52', '拥有角色', 'sys:user:role:detail', NULL, 'sys/user/roles/*', NULL, '24', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('53', '角色管理', NULL, NULL, 'index/roles', '_self', '51', 99, 2, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('54', '系统管理', NULL, 'layui-icon-set-fill', NULL, NULL, '0', 98, 1, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('55', '定时任务暂停', 'sysJob:pause', NULL, 'sysJob/pause', '_self', '59', 1, 3, 1, '2020-04-22 15:48:18', NULL, 1);
INSERT INTO `sys_permission` VALUES ('56', '更新', 'sys:user:update', NULL, 'sys/user', NULL, '24', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('57', '删除', 'sys:user:deleted', NULL, 'sys/user', NULL, '24', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('58', '删除', 'sys:log:deleted', NULL, 'sys/logs', NULL, '8', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('59', '定时任务', NULL, NULL, 'index/sysJob', '_self', '54', 10, 2, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('6', '接口管理', '', '', 'doc.html', '_blank', '21', 100, 2, 1, '2020-03-19 13:29:40', '2020-05-07 13:36:02', 1);
INSERT INTO `sys_permission` VALUES ('60', '列表', 'sysJob:list', NULL, 'sysJob/listByPage', NULL, '59', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('61', '新增', 'sysJob:add', NULL, 'sysJob/add', NULL, '59', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('62', '修改', 'sysJob:update', NULL, 'sysJob/update', NULL, '59', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('63', '删除', 'sysJob:delete', NULL, 'sysJob/delete', NULL, '59', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('7', '列表', 'sys:log:list', NULL, 'sys/logs', NULL, '8', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('8', '日志管理', NULL, NULL, 'index/logs', '_self', '54', 97, 2, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('9', '新增', 'sys:dept:add', NULL, 'sys/dept', NULL, '41', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `description` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` tinyint NULL DEFAULT NULL COMMENT '状态(1:正常0:弃用)',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT NULL COMMENT '是否删除(1未删除；0已删除)',
  `data_scope` int NULL DEFAULT NULL COMMENT '数据范围（1：所有 2：自定义 3： 本部门及以下部门 4：仅本部门 5:自己）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '超级管理员', '拥有所有权限-不能删除', 1, '2019-11-01 19:26:29', '2020-03-19 13:29:51', 1, NULL);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `role_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色id',
  `dept_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色部门' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `role_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色id',
  `permission_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单权限id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES ('1', '1', '1', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('10', '1', '10', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('11', '1', '11', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('12', '1', '12', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('13', '1', '13', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('1311116066716430339', '1', '1311115974068449281', '2020-09-30 09:30:04');
INSERT INTO `sys_role_permission` VALUES ('14', '1', '14', '2020-05-26 17:04:21');
INSERT INTO `sys_role_permission` VALUES ('15', '1', '15', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('16', '1', '16', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('1647547032789585927', '1', '1647547032789585922', NULL);
INSERT INTO `sys_role_permission` VALUES ('1647547032789585928', '1', '1647547032789585923', NULL);
INSERT INTO `sys_role_permission` VALUES ('1647547032789585929', '1', '1647547032789585924', NULL);
INSERT INTO `sys_role_permission` VALUES ('1647547032789585930', '1', '1647547032789585925', NULL);
INSERT INTO `sys_role_permission` VALUES ('1647547032789585931', '1', '1647547032789585926', NULL);
INSERT INTO `sys_role_permission` VALUES ('1647561651239350278', '1', '1647561651239350273', NULL);
INSERT INTO `sys_role_permission` VALUES ('1647561651239350279', '1', '1647561651239350274', NULL);
INSERT INTO `sys_role_permission` VALUES ('1647561651239350280', '1', '1647561651239350275', NULL);
INSERT INTO `sys_role_permission` VALUES ('1647561651239350281', '1', '1647561651239350276', NULL);
INSERT INTO `sys_role_permission` VALUES ('1647561651239350282', '1', '1647561651239350277', NULL);
INSERT INTO `sys_role_permission` VALUES ('1647572648771493895', '1', '1647572648771493890', NULL);
INSERT INTO `sys_role_permission` VALUES ('1647572648771493896', '1', '1647572648771493891', NULL);
INSERT INTO `sys_role_permission` VALUES ('1647572648771493897', '1', '1647572648771493892', NULL);
INSERT INTO `sys_role_permission` VALUES ('1647572648771493898', '1', '1647572648771493893', NULL);
INSERT INTO `sys_role_permission` VALUES ('1647572648771493899', '1', '1647572648771493894', NULL);
INSERT INTO `sys_role_permission` VALUES ('1647585172439031815', '1', '1647585172439031810', NULL);
INSERT INTO `sys_role_permission` VALUES ('1647585172439031816', '1', '1647585172439031811', NULL);
INSERT INTO `sys_role_permission` VALUES ('1647585172439031817', '1', '1647585172439031812', NULL);
INSERT INTO `sys_role_permission` VALUES ('1647585172439031818', '1', '1647585172439031813', NULL);
INSERT INTO `sys_role_permission` VALUES ('1647585172439031819', '1', '1647585172439031814', NULL);
INSERT INTO `sys_role_permission` VALUES ('17', '1', '17', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('18', '1', '18', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('19', '1', '19', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('2', '1', '2', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('20', '1', '20', '2020-05-26 17:04:21');
INSERT INTO `sys_role_permission` VALUES ('21', '1', '21', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('22', '1', '22', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('23', '1', '23', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('24', '1', '24', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('25', '1', '25', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('26', '1', '26', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('27', '1', '27', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('28', '1', '28', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('29', '1', '29', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('3', '1', '3', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('30', '1', '30', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('31', '1', '31', '2020-05-26 17:04:21');
INSERT INTO `sys_role_permission` VALUES ('32', '1', '32', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('33', '1', '33', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('34', '1', '34', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('35', '1', '35', '2020-05-26 17:04:21');
INSERT INTO `sys_role_permission` VALUES ('36', '1', '36', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('38', '1', '38', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('39', '1', '39', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('4', '1', '4', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('40', '1', '40', '2020-06-15 15:21:17');
INSERT INTO `sys_role_permission` VALUES ('41', '1', '41', '2020-06-15 15:21:17');
INSERT INTO `sys_role_permission` VALUES ('42', '1', '42', '2020-06-15 15:21:17');
INSERT INTO `sys_role_permission` VALUES ('43', '1', '43', '2020-06-15 15:21:17');
INSERT INTO `sys_role_permission` VALUES ('44', '1', '44', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('45', '1', '45', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('46', '1', '46', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('47', '1', '47', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('48', '1', '48', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('49', '1', '49', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('5', '1', '5', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('50', '1', '50', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('51', '1', '51', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('52', '1', '52', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('53', '1', '53', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('54', '1', '54', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('55', '1', '55', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('56', '1', '56', '2020-05-26 17:04:21');
INSERT INTO `sys_role_permission` VALUES ('57', '1', '57', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('58', '1', '58', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('59', '1', '59', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('6', '1', '6', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('60', '1', '60', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('61', '1', '61', '2020-05-26 14:21:56');
INSERT INTO `sys_role_permission` VALUES ('62', '1', '62', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('63', '1', '63', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('7', '1', '7', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('8', '1', '8', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('9', '1', '9', '2020-04-22 15:48:47');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账户名称',
  `salt` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '加密盐值',
  `password` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户密码密文',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `dept_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门id',
  `real_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实名称',
  `nick_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱(唯一)',
  `status` tinyint NULL DEFAULT NULL COMMENT '账户状态(1.正常 0.锁定 )',
  `sex` tinyint NULL DEFAULT NULL COMMENT '性别(1.男 2.女)',
  `deleted` tinyint NULL DEFAULT NULL COMMENT '是否删除(1未删除；0已删除)',
  `create_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `create_where` tinyint NULL DEFAULT NULL COMMENT '创建来源(1.web 2.android 3.ios )',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', '324ce32d86224b00a02b', '2102b59a75ab87616b62d0b9432569d0', '13888888888', '1', '爱糖宝', '爱糖宝', 'xxxxxx@163.com', 1, 2, 1, '1', '1', 3, '2019-09-22 19:38:05', '2020-03-18 09:15:22');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `user_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `role_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统用户角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1', '1', '2020-03-19 02:23:13');

SET FOREIGN_KEY_CHECKS = 1;
