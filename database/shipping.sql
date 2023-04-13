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

 Date: 13/04/2023 20:55:04
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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of carriers
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of customers
-- ----------------------------

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
  `customer_id` int NULL DEFAULT NULL,
  `carrier_id` int NULL DEFAULT NULL,
  `shipment_type_id` int NULL DEFAULT NULL,
  `is_free_shipping` tinyint NULL DEFAULT 0 COMMENT '0-不包邮 1-包邮 默认0 不包也有billing垫付',
  `origin_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `origin_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `origin_country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `origin_postal_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `destination_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `destination_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `destination_country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `destination_postal_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `des` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `weight` decimal(10, 2) NULL DEFAULT NULL,
  `value` decimal(10, 2) NULL DEFAULT NULL,
  `order_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tracking_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `pickup_date` date NULL DEFAULT NULL,
  `estimated_delivery_date` date NULL DEFAULT NULL,
  `actual_delivery_date` date NULL DEFAULT NULL,
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

-- ----------------------------
-- Table structure for shipping_rates
-- ----------------------------
DROP TABLE IF EXISTS `shipping_rates`;
CREATE TABLE `shipping_rates`  (
  `shipping_rate_id` int NOT NULL,
  `carrier_id` int NULL DEFAULT NULL,
  `shipment_type_id` int NULL DEFAULT NULL,
  `price_per_kg` decimal(10, 2) NULL DEFAULT NULL,
  `price_per_km` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`shipping_rate_id`) USING BTREE,
  INDEX `carrier_id`(`carrier_id`) USING BTREE,
  INDEX `shipment_type_id`(`shipment_type_id`) USING BTREE,
  CONSTRAINT `shipping_rates_ibfk_1` FOREIGN KEY (`carrier_id`) REFERENCES `carriers` (`carrier_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `shipping_rates_ibfk_2` FOREIGN KEY (`shipment_type_id`) REFERENCES `shipment_types` (`shipment_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shipping_rates
-- ----------------------------

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
