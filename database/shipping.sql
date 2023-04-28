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

 Date: 28/04/2023 08:29:19
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for carrier
-- ----------------------------
DROP TABLE IF EXISTS `carrier`;
CREATE TABLE `carrier`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '承运人id',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公司名',
  `contact_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人姓名',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '电话',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '地址',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市',
  `country` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '国家',
  `postal_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '邮编',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of carrier
-- ----------------------------
INSERT INTO `carrier` VALUES (1, '顺丰速运', '李四', 'sf-express@qq.com', '400-811-1111', '广东省深圳市福田区新洲十一街华联工业园', '深圳市', '中国', '518000');
INSERT INTO `carrier` VALUES (2, '圆通速递', '王五', 'yuantong-express@qq.com', '95554', '北京市朝阳区建国路乙19号院3号楼圆通速递股份有限公司', '北京市', '中国', '100022');
INSERT INTO `carrier` VALUES (3, '中通快递', '张三', 'zhongtong-express@qq.com', '95311', '浙江省宁波市海曙区解放北路958号中通国际大厦', '宁波市', '中国', '315000');

-- ----------------------------
-- Table structure for carrier_billing
-- ----------------------------
DROP TABLE IF EXISTS `carrier_billing`;
CREATE TABLE `carrier_billing`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '账单id',
  `carrier_id` int NULL DEFAULT NULL COMMENT '承运人',
  `order_id` int NULL DEFAULT NULL COMMENT '运单',
  `billing_date` date NULL DEFAULT NULL COMMENT '结算日期',
  `freight_charge` decimal(10, 2) NULL DEFAULT NULL COMMENT '金额',
  `state` int NULL DEFAULT 0 COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `carrier_id`(`carrier_id`) USING BTREE,
  INDEX `carriers_billing_ibfk_2`(`order_id`) USING BTREE,
  CONSTRAINT `carrier_billing_ibfk_1` FOREIGN KEY (`carrier_id`) REFERENCES `carrier` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `carrier_billing_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `shipment` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of carrier_billing
-- ----------------------------
INSERT INTO `carrier_billing` VALUES (3, 1, 10, '2023-04-27', 10000.00, 0);

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '客户id',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '姓名',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号',
  `company_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公司名',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '地址',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市',
  `country` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '国家',
  `postal_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '邮编',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES (1, '陈小明', 'xiaomingchen@163.com', '13812345678', 'ABC 公司', '上海市徐汇区虹桥路1234号', '上海市', '中国', '200000');
INSERT INTO `customer` VALUES (2, '王芳', 'fangwang@163.com', '13887654321', 'XYZ 有限公司', '北京市朝阳区建国路555号', '北京市', '中国', '100000');
INSERT INTO `customer` VALUES (3, '李华', 'hualee@163.com', '13987654321', 'PQR 贸易公司', '广东省深圳市福田区深南大道8888号', '深圳市', '中国', '518000');

-- ----------------------------
-- Table structure for customer_billing
-- ----------------------------
DROP TABLE IF EXISTS `customer_billing`;
CREATE TABLE `customer_billing`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '账单id',
  `customer_id` int NULL DEFAULT NULL COMMENT '客户',
  `order_id` int NULL DEFAULT NULL COMMENT '运单',
  `payment_date` date NULL DEFAULT NULL COMMENT '结算日期',
  `payment_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '金额',
  `payment_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '支付方式',
  `state` int NULL DEFAULT 0 COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `customer_id`(`customer_id`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE,
  CONSTRAINT `customer_billing_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `shipment` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of customer_billing
-- ----------------------------

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '货物名',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '单价',
  `weight` decimal(10, 2) NULL DEFAULT NULL COMMENT '单位重量',
  `volume` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '体积规格',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, '运动T恤', 99.99, 0.30, '50×30×5');
INSERT INTO `goods` VALUES (2, '单人沙发', 1999.99, 20.00, '200×100×80');
INSERT INTO `goods` VALUES (3, '智能手环', 299.99, 0.10, '10×10×5');
INSERT INTO `goods` VALUES (4, '麻辣小龙虾', 39.99, 1.00, '20×20×10');
INSERT INTO `goods` VALUES (5, '口红', 49.99, 0.05, '5×5×5');

-- ----------------------------
-- Table structure for shipment
-- ----------------------------
DROP TABLE IF EXISTS `shipment`;
CREATE TABLE `shipment`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NULL DEFAULT NULL COMMENT '客户id',
  `carrier_id` int NULL DEFAULT NULL COMMENT '承运方id',
  `shipment_type_id` int NULL DEFAULT NULL COMMENT '物流类型',
  `origin_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发货详细地址',
  `origin_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发货地',
  `origin_country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发货地国家',
  `origin_postal_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发货地邮编',
  `destination_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货详细地址',
  `destination_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货地',
  `destination_country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货地国家',
  `destination_postal_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货地邮编',
  `des` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `goods_id` int NULL DEFAULT NULL COMMENT '物资类型',
  `num` int NULL DEFAULT NULL COMMENT '物资数量',
  `weight` decimal(10, 2) NULL DEFAULT NULL COMMENT '总重量',
  `value` decimal(10, 2) NULL DEFAULT NULL COMMENT '物资价值',
  `order_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '运单状态',
  `pickup_date` date NULL DEFAULT NULL COMMENT '发货日期',
  `delivery_date` date NULL DEFAULT NULL COMMENT '收货日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `carrier_id`(`carrier_id`) USING BTREE,
  INDEX `shipment_type_id`(`shipment_type_id`) USING BTREE,
  INDEX `shipment_ibfk_1`(`customer_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shipment
-- ----------------------------
INSERT INTO `shipment` VALUES (1, 1, 1, 1, '广东省深圳市福田区新洲十一街华联工业园', '深圳市', '中国', '518000', '上海市徐汇区虹桥路1234号', '上海市', '中国', '200000', '哈哈哈', 1, 100, 30.00, 9999.00, NULL, '2023-04-21', NULL);
INSERT INTO `shipment` VALUES (6, 1, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '无', 2, 10, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `shipment` VALUES (7, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '111', 1, 90, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `shipment` VALUES (8, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 1, 100, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `shipment` VALUES (9, 1, 1, 1, '广东省深圳市福田区新洲十一街华联工业园', '深圳市', '中国', '518000', '上海市徐汇区虹桥路1234号', '上海市', '中国', '200000', '', 1, 100, 30.00, 9999.00, '0', NULL, NULL);
INSERT INTO `shipment` VALUES (10, 1, 1, 1, '广东省深圳市福田区新洲十一街华联工业园', '深圳市', '中国', '518000', '上海市徐汇区虹桥路1234号', '上海市', '中国', '200000', '', 2, 100, 2000.00, 199999.00, '0', NULL, NULL);

-- ----------------------------
-- Table structure for shipment_event
-- ----------------------------
DROP TABLE IF EXISTS `shipment_event`;
CREATE TABLE `shipment_event`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NULL DEFAULT NULL,
  `event_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `event_date` date NULL DEFAULT NULL,
  `event_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `event_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `shipment_events_ibfk_1`(`order_id`) USING BTREE,
  CONSTRAINT `shipment_event_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `shipment` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shipment_event
-- ----------------------------

-- ----------------------------
-- Table structure for shipment_rate
-- ----------------------------
DROP TABLE IF EXISTS `shipment_rate`;
CREATE TABLE `shipment_rate`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `related_id` int NULL DEFAULT NULL,
  `shipment_type_id` int NULL DEFAULT NULL,
  `price_per_kg` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `carrier_id`(`related_id`) USING BTREE,
  INDEX `shipment_type_id`(`shipment_type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shipment_rate
-- ----------------------------
INSERT INTO `shipment_rate` VALUES (1, 1, 1, 5.00);
INSERT INTO `shipment_rate` VALUES (2, 1, 2, 10.00);
INSERT INTO `shipment_rate` VALUES (3, 1, 3, 20.00);
INSERT INTO `shipment_rate` VALUES (4, 2, 1, 6.00);
INSERT INTO `shipment_rate` VALUES (5, 2, 2, 12.00);
INSERT INTO `shipment_rate` VALUES (6, 2, 3, 24.00);
INSERT INTO `shipment_rate` VALUES (7, 3, 1, 4.50);
INSERT INTO `shipment_rate` VALUES (8, 3, 2, 9.00);
INSERT INTO `shipment_rate` VALUES (9, 3, 3, 18.00);

-- ----------------------------
-- Table structure for shipment_type
-- ----------------------------
DROP TABLE IF EXISTS `shipment_type`;
CREATE TABLE `shipment_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shipment_type
-- ----------------------------
INSERT INTO `shipment_type` VALUES (1, '陆运', '通过陆路运输货物', 10.00);
INSERT INTO `shipment_type` VALUES (2, '海运', '通过海路运输货物', 16.00);
INSERT INTO `shipment_type` VALUES (3, '空运', '通过空运运输货物', 32.00);

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
INSERT INTO `sys_content` VALUES ('1647964220323385345', '哈哈哈', NULL, '', '1', 1, '', '2023-04-17 22:04:22', NULL);

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
INSERT INTO `sys_dict` VALUES ('1647947785794547714', 'customer_company', '用户id对应公司', '2023-04-17 20:59:04');
INSERT INTO `sys_dict` VALUES ('1647951583145472001', 'carrier_name', '供应商名', '2023-04-17 21:14:10');
INSERT INTO `sys_dict` VALUES ('1647953058743472130', 'shipment_type', '物流类型', '2023-04-17 21:20:01');
INSERT INTO `sys_dict` VALUES ('1647955274611052546', 'fee_type', '包邮/不包邮', '2023-04-17 21:28:50');
INSERT INTO `sys_dict` VALUES ('1647958980240941057', 'goods_type', '物资类型', '2023-04-17 21:43:33');

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
INSERT INTO `sys_dict_detail` VALUES ('1647948430584901634', 'ABC 公司', '1', 1, '1647947785794547714', '2023-04-17 21:01:38');
INSERT INTO `sys_dict_detail` VALUES ('1647948510041796610', 'XYZ 有限公司', '2', 2, '1647947785794547714', '2023-04-17 21:01:57');
INSERT INTO `sys_dict_detail` VALUES ('1647948606489817090', 'PQR 贸易公司', '3', 3, '1647947785794547714', '2023-04-17 21:02:20');
INSERT INTO `sys_dict_detail` VALUES ('1647951819821658113', '顺丰速运', '1', 1, '1647951583145472001', '2023-04-17 21:15:06');
INSERT INTO `sys_dict_detail` VALUES ('1647951867854827522', '圆通速运', '2', 2, '1647951583145472001', '2023-04-17 21:15:17');
INSERT INTO `sys_dict_detail` VALUES ('1647951918014509058', '中通快递', '3', 3, '1647951583145472001', '2023-04-17 21:15:29');
INSERT INTO `sys_dict_detail` VALUES ('1647953192294305794', '陆运', '1', 1, '1647953058743472130', '2023-04-17 21:20:33');
INSERT INTO `sys_dict_detail` VALUES ('1647953237148192770', '海运', '2', 2, '1647953058743472130', '2023-04-17 21:20:44');
INSERT INTO `sys_dict_detail` VALUES ('1647953283868545026', '空运', '3', 3, '1647953058743472130', '2023-04-17 21:20:55');
INSERT INTO `sys_dict_detail` VALUES ('1647955344781758466', '不包邮', '0', 1, '1647955274611052546', '2023-04-17 21:29:06');
INSERT INTO `sys_dict_detail` VALUES ('1647955395205681154', '包邮', '1', 2, '1647955274611052546', '2023-04-17 21:29:18');
INSERT INTO `sys_dict_detail` VALUES ('1647959336085692417', '运动T恤', '1', 1, '1647958980240941057', '2023-04-17 21:44:58');
INSERT INTO `sys_dict_detail` VALUES ('1647959383389052929', '单人沙发', '2', 2, '1647958980240941057', '2023-04-17 21:45:09');
INSERT INTO `sys_dict_detail` VALUES ('1647959459696025601', '智能手环', '3', 3, '1647958980240941057', '2023-04-17 21:45:27');
INSERT INTO `sys_dict_detail` VALUES ('1647959532660137986', '麻辣小龙虾', '4', 4, '1647958980240941057', '2023-04-17 21:45:45');
INSERT INTO `sys_dict_detail` VALUES ('1647959575869857793', '口红', '5', 5, '1647958980240941057', '2023-04-17 21:45:55');

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
INSERT INTO `sys_job_log` VALUES ('1647899198326878210', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 17:46:00');
INSERT INTO `sys_job_log` VALUES ('1647899449901232130', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 17:47:00');
INSERT INTO `sys_job_log` VALUES ('1647899701551083521', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 17:48:00');
INSERT INTO `sys_job_log` VALUES ('1647899953213517825', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 17:49:00');
INSERT INTO `sys_job_log` VALUES ('1647900204901117953', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 17:50:00');
INSERT INTO `sys_job_log` VALUES ('1647900456555163649', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 17:51:00');
INSERT INTO `sys_job_log` VALUES ('1647900708188237825', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 17:52:00');
INSERT INTO `sys_job_log` VALUES ('1647900959892615169', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 17:53:00');
INSERT INTO `sys_job_log` VALUES ('1647901211500523521', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 17:54:00');
INSERT INTO `sys_job_log` VALUES ('1647901463204900865', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 17:55:00');
INSERT INTO `sys_job_log` VALUES ('1647901714812809217', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 17:56:00');
INSERT INTO `sys_job_log` VALUES ('1647901966529769473', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 17:57:00');
INSERT INTO `sys_job_log` VALUES ('1647902218150260738', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 17:58:00');
INSERT INTO `sys_job_log` VALUES ('1647902469829472258', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 17:59:00');
INSERT INTO `sys_job_log` VALUES ('1647902721449963522', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 18:00:00');
INSERT INTO `sys_job_log` VALUES ('1647902973141757953', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 18:01:00');
INSERT INTO `sys_job_log` VALUES ('1647903224787415041', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 18:02:00');
INSERT INTO `sys_job_log` VALUES ('1647903476466626562', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 18:03:00');
INSERT INTO `sys_job_log` VALUES ('1647903728120672257', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 18:04:00');
INSERT INTO `sys_job_log` VALUES ('1647903979770523649', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 18:05:00');
INSERT INTO `sys_job_log` VALUES ('1647904231449735170', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 18:06:00');
INSERT INTO `sys_job_log` VALUES ('1647904483091197953', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 18:07:00');
INSERT INTO `sys_job_log` VALUES ('1647904734741049345', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 18:08:00');
INSERT INTO `sys_job_log` VALUES ('1647904986382512130', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 18:09:00');
INSERT INTO `sys_job_log` VALUES ('1647905238086889473', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 18:10:00');
INSERT INTO `sys_job_log` VALUES ('1647905489740935170', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 18:11:00');
INSERT INTO `sys_job_log` VALUES ('1647905741344649218', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 18:12:00');
INSERT INTO `sys_job_log` VALUES ('1647905993015472130', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 18:13:00');
INSERT INTO `sys_job_log` VALUES ('1647906244703072258', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 18:14:00');
INSERT INTO `sys_job_log` VALUES ('1647906496361312257', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 18:15:00');
INSERT INTO `sys_job_log` VALUES ('1647906748023746561', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 18:16:00');
INSERT INTO `sys_job_log` VALUES ('1647906999652626433', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 18:17:00');
INSERT INTO `sys_job_log` VALUES ('1647907251302477825', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 18:18:00');
INSERT INTO `sys_job_log` VALUES ('1647907502994272257', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 18:19:00');
INSERT INTO `sys_job_log` VALUES ('1647907754648317954', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 18:20:00');
INSERT INTO `sys_job_log` VALUES ('1647908006314946562', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 18:21:00');
INSERT INTO `sys_job_log` VALUES ('1647908257968992257', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 18:22:00');
INSERT INTO `sys_job_log` VALUES ('1647908509639815170', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 18:23:00');
INSERT INTO `sys_job_log` VALUES ('1647909767918432258', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 18:28:00');
INSERT INTO `sys_job_log` VALUES ('1647910019580866562', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 18:29:00');
INSERT INTO `sys_job_log` VALUES ('1647910271213940738', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 18:30:00');
INSERT INTO `sys_job_log` VALUES ('1647910522855403521', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 18:31:00');
INSERT INTO `sys_job_log` VALUES ('1647910774568169473', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 18:32:00');
INSERT INTO `sys_job_log` VALUES ('1647911026192855041', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 18:33:00');
INSERT INTO `sys_job_log` VALUES ('1647911277859483650', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 18:34:00');
INSERT INTO `sys_job_log` VALUES ('1647911529534500866', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 18:35:00');
INSERT INTO `sys_job_log` VALUES ('1647911781163380738', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 18:36:00');
INSERT INTO `sys_job_log` VALUES ('1647912032855175170', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 18:37:00');
INSERT INTO `sys_job_log` VALUES ('1647913291096043522', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 18:42:00');
INSERT INTO `sys_job_log` VALUES ('1647913542762672130', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 18:43:00');
INSERT INTO `sys_job_log` VALUES ('1647913794408329218', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 18:44:00');
INSERT INTO `sys_job_log` VALUES ('1647914046121095169', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 18:45:00');
INSERT INTO `sys_job_log` VALUES ('1647914297770946562', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 18:46:00');
INSERT INTO `sys_job_log` VALUES ('1647914549408215041', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 18:47:00');
INSERT INTO `sys_job_log` VALUES ('1647914801058066433', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 18:48:00');
INSERT INTO `sys_job_log` VALUES ('1647923609125826562', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:23:00');
INSERT INTO `sys_job_log` VALUES ('1647923860754706433', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:24:00');
INSERT INTO `sys_job_log` VALUES ('1647924112396169218', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:25:00');
INSERT INTO `sys_job_log` VALUES ('1647924364075380737', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 19:26:00');
INSERT INTO `sys_job_log` VALUES ('1647924615716843522', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 19:27:00');
INSERT INTO `sys_job_log` VALUES ('1647924867370889217', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:28:00');
INSERT INTO `sys_job_log` VALUES ('1647925119033323522', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 19:29:00');
INSERT INTO `sys_job_log` VALUES ('1647925370452488193', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:30:00');
INSERT INTO `sys_job_log` VALUES ('1647925622400135170', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:31:00');
INSERT INTO `sys_job_log` VALUES ('1647925874024820738', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:32:00');
INSERT INTO `sys_job_log` VALUES ('1647926125695643649', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 19:33:00');
INSERT INTO `sys_job_log` VALUES ('1647926377324523521', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:34:00');
INSERT INTO `sys_job_log` VALUES ('1647926629012123649', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 19:35:00');
INSERT INTO `sys_job_log` VALUES ('1647926880649392130', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 19:36:00');
INSERT INTO `sys_job_log` VALUES ('1647927132290854914', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:37:00');
INSERT INTO `sys_job_log` VALUES ('1647927383982649346', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:38:00');
INSERT INTO `sys_job_log` VALUES ('1647927635657666561', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:39:00');
INSERT INTO `sys_job_log` VALUES ('1647927887290740738', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 19:40:00');
INSERT INTO `sys_job_log` VALUES ('1647928138965757954', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:41:00');
INSERT INTO `sys_job_log` VALUES ('1647928390619803649', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:42:00');
INSERT INTO `sys_job_log` VALUES ('1647928642278043650', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:43:00');
INSERT INTO `sys_job_log` VALUES ('1647928893953060866', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:44:00');
INSERT INTO `sys_job_log` VALUES ('1647929145649086465', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 19:45:00');
INSERT INTO `sys_job_log` VALUES ('1647929397261189121', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:46:00');
INSERT INTO `sys_job_log` VALUES ('1647929648927817730', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:47:00');
INSERT INTO `sys_job_log` VALUES ('1647929900648947714', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:48:00');
INSERT INTO `sys_job_log` VALUES ('1647930152193941505', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:49:00');
INSERT INTO `sys_job_log` VALUES ('1647930418486116354', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 19:50:03');
INSERT INTO `sys_job_log` VALUES ('1647930655506235394', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:51:00');
INSERT INTO `sys_job_log` VALUES ('1647930907214807041', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:52:00');
INSERT INTO `sys_job_log` VALUES ('1647931158881435650', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:53:00');
INSERT INTO `sys_job_log` VALUES ('1647931410514509826', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:54:00');
INSERT INTO `sys_job_log` VALUES ('1647931662176944129', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 19:55:00');
INSERT INTO `sys_job_log` VALUES ('1647931913860349953', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:56:00');
INSERT INTO `sys_job_log` VALUES ('1647932165489229826', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 19:57:00');
INSERT INTO `sys_job_log` VALUES ('1647932417126498305', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 19:58:00');
INSERT INTO `sys_job_log` VALUES ('1647932668793126914', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 19:59:00');
INSERT INTO `sys_job_log` VALUES ('1647932920447172610', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:00:00');
INSERT INTO `sys_job_log` VALUES ('1647933172029915137', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 20:01:00');
INSERT INTO `sys_job_log` VALUES ('1647933423759458306', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:02:00');
INSERT INTO `sys_job_log` VALUES ('1647933675530977282', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:03:00');
INSERT INTO `sys_job_log` VALUES ('1647933941529530370', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 20:04:03');
INSERT INTO `sys_job_log` VALUES ('1647934178725810178', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:05:00');
INSERT INTO `sys_job_log` VALUES ('1647934430421798914', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:06:00');
INSERT INTO `sys_job_log` VALUES ('1647934682059067393', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 20:07:00');
INSERT INTO `sys_job_log` VALUES ('1647934933755056129', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:08:00');
INSERT INTO `sys_job_log` VALUES ('1647935185400713217', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 20:09:00');
INSERT INTO `sys_job_log` VALUES ('1647935437050564610', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 20:10:00');
INSERT INTO `sys_job_log` VALUES ('1647935688679444482', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 20:11:00');
INSERT INTO `sys_job_log` VALUES ('1647935940337684482', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 20:12:00');
INSERT INTO `sys_job_log` VALUES ('1647936192050450434', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:13:00');
INSERT INTO `sys_job_log` VALUES ('1647936443679330305', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:14:00');
INSERT INTO `sys_job_log` VALUES ('1647936695308210177', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 20:15:00');
INSERT INTO `sys_job_log` VALUES ('1647936946995810306', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:16:00');
INSERT INTO `sys_job_log` VALUES ('1647937198679216129', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:17:00');
INSERT INTO `sys_job_log` VALUES ('1647937450345844738', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:18:00');
INSERT INTO `sys_job_log` VALUES ('1647937701987307522', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:19:00');
INSERT INTO `sys_job_log` VALUES ('1647937953607798786', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:20:00');
INSERT INTO `sys_job_log` VALUES ('1647938205362507777', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 20:21:00');
INSERT INTO `sys_job_log` VALUES ('1647938456962027521', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 20:22:00');
INSERT INTO `sys_job_log` VALUES ('1647938708578324482', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:23:00');
INSERT INTO `sys_job_log` VALUES ('1647939212029001730', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:25:00');
INSERT INTO `sys_job_log` VALUES ('1647939463716593666', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 20:26:00');
INSERT INTO `sys_job_log` VALUES ('1647939715223838721', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:27:00');
INSERT INTO `sys_job_log` VALUES ('1647939966890467330', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:28:00');
INSERT INTO `sys_job_log` VALUES ('1647940218544513026', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:29:00');
INSERT INTO `sys_job_log` VALUES ('1647940470202753026', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:30:00');
INSERT INTO `sys_job_log` VALUES ('1647940721890353154', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:31:00');
INSERT INTO `sys_job_log` VALUES ('1647940973502455810', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 20:32:00');
INSERT INTO `sys_job_log` VALUES ('1647941225160695810', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 20:33:00');
INSERT INTO `sys_job_log` VALUES ('1647941476869267458', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 20:34:00');
INSERT INTO `sys_job_log` VALUES ('1647941728514924546', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:35:00');
INSERT INTO `sys_job_log` VALUES ('1647941980177358849', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:36:00');
INSERT INTO `sys_job_log` VALUES ('1647942231881773057', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 20:37:00');
INSERT INTO `sys_job_log` VALUES ('1647942483468709890', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 20:38:00');
INSERT INTO `sys_job_log` VALUES ('1647942735164698626', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:39:00');
INSERT INTO `sys_job_log` VALUES ('1647942986881617921', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:40:00');
INSERT INTO `sys_job_log` VALUES ('1647943490164547586', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:42:00');
INSERT INTO `sys_job_log` VALUES ('1647943741868953601', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 20:43:00');
INSERT INTO `sys_job_log` VALUES ('1647943993527115777', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:44:00');
INSERT INTO `sys_job_log` VALUES ('1647944245084692482', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:45:00');
INSERT INTO `sys_job_log` VALUES ('1647944496730349569', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:46:00');
INSERT INTO `sys_job_log` VALUES ('1647944748371812353', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:47:00');
INSERT INTO `sys_job_log` VALUES ('1647945000063606785', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:48:00');
INSERT INTO `sys_job_log` VALUES ('1647945259468779522', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 20:49:02');
INSERT INTO `sys_job_log` VALUES ('1647945503371751425', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:50:00');
INSERT INTO `sys_job_log` VALUES ('1647945755029991426', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:51:00');
INSERT INTO `sys_job_log` VALUES ('1647946006684037122', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:52:00');
INSERT INTO `sys_job_log` VALUES ('1647946258329694210', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 20:53:00');
INSERT INTO `sys_job_log` VALUES ('1647946509992128514', '1252884495040782337', 'testTask', '1', 0, NULL, 3, '2023-04-17 20:54:00');
INSERT INTO `sys_job_log` VALUES ('1647946761658757121', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:55:00');
INSERT INTO `sys_job_log` VALUES ('1647947013312802818', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 20:56:00');
INSERT INTO `sys_job_log` VALUES ('1647947264958459906', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 20:57:00');
INSERT INTO `sys_job_log` VALUES ('1647947516641865729', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 20:58:00');
INSERT INTO `sys_job_log` VALUES ('1647947768283328514', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 20:59:00');
INSERT INTO `sys_job_log` VALUES ('1647948019924791297', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:00:00');
INSERT INTO `sys_job_log` VALUES ('1647948271641751554', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:01:00');
INSERT INTO `sys_job_log` VALUES ('1647948523262242818', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:02:00');
INSERT INTO `sys_job_log` VALUES ('1647948774907899905', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 21:03:00');
INSERT INTO `sys_job_log` VALUES ('1647949026620665858', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 21:04:00');
INSERT INTO `sys_job_log` VALUES ('1647949278278905857', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:05:00');
INSERT INTO `sys_job_log` VALUES ('1647949529953972226', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 21:06:00');
INSERT INTO `sys_job_log` VALUES ('1647949781620600834', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 21:07:00');
INSERT INTO `sys_job_log` VALUES ('1647950033299812354', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:08:00');
INSERT INTO `sys_job_log` VALUES ('1647950284890943490', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:09:00');
INSERT INTO `sys_job_log` VALUES ('1647950536544989185', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:10:00');
INSERT INTO `sys_job_log` VALUES ('1647950788224200705', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:11:00');
INSERT INTO `sys_job_log` VALUES ('1647951039844691969', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 21:12:00');
INSERT INTO `sys_job_log` VALUES ('1647951291523903490', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 21:13:00');
INSERT INTO `sys_job_log` VALUES ('1647951543152783362', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 21:14:00');
INSERT INTO `sys_job_log` VALUES ('1647951794827800577', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 21:15:00');
INSERT INTO `sys_job_log` VALUES ('1647952046481846273', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 21:16:00');
INSERT INTO `sys_job_log` VALUES ('1647952298257436674', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:17:00');
INSERT INTO `sys_job_log` VALUES ('1647952549840179201', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 21:18:00');
INSERT INTO `sys_job_log` VALUES ('1647952801477447681', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:19:00');
INSERT INTO `sys_job_log` VALUES ('1647953053089550338', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 21:20:00');
INSERT INTO `sys_job_log` VALUES ('1647953304764567554', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 21:21:00');
INSERT INTO `sys_job_log` VALUES ('1647953556427001858', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 21:22:00');
INSERT INTO `sys_job_log` VALUES ('1647953808127184898', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 21:23:00');
INSERT INTO `sys_job_log` VALUES ('1647954059735093250', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 21:24:00');
INSERT INTO `sys_job_log` VALUES ('1647954311418499074', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:25:00');
INSERT INTO `sys_job_log` VALUES ('1647954563043184642', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:26:00');
INSERT INTO `sys_job_log` VALUES ('1647954814705618946', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:27:00');
INSERT INTO `sys_job_log` VALUES ('1647955066393219074', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 21:28:00');
INSERT INTO `sys_job_log` VALUES ('1647955318051459074', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 21:29:00');
INSERT INTO `sys_job_log` VALUES ('1647955569701310466', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 21:30:00');
INSERT INTO `sys_job_log` VALUES ('1647955821426659330', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:31:00');
INSERT INTO `sys_job_log` VALUES ('1647956072988430338', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:32:00');
INSERT INTO `sys_job_log` VALUES ('1647956324667641858', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:33:00');
INSERT INTO `sys_job_log` VALUES ('1647956576359436289', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:34:00');
INSERT INTO `sys_job_log` VALUES ('1647956828005093377', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:35:00');
INSERT INTO `sys_job_log` VALUES ('1647957079675916289', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:36:00');
INSERT INTO `sys_job_log` VALUES ('1647957331317379073', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:37:00');
INSERT INTO `sys_job_log` VALUES ('1647957583021756418', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:38:00');
INSERT INTO `sys_job_log` VALUES ('1647958086422175745', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:40:00');
INSERT INTO `sys_job_log` VALUES ('1647958337962975234', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:41:00');
INSERT INTO `sys_job_log` VALUES ('1647958589596049409', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:42:00');
INSERT INTO `sys_job_log` VALUES ('1647958841283649538', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:43:00');
INSERT INTO `sys_job_log` VALUES ('1647959092929306626', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:44:00');
INSERT INTO `sys_job_log` VALUES ('1647959344583352322', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:45:00');
INSERT INTO `sys_job_log` VALUES ('1647959596258369537', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:46:00');
INSERT INTO `sys_job_log` VALUES ('1647959847870472194', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:47:00');
INSERT INTO `sys_job_log` VALUES ('1647960351199535106', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:49:00');
INSERT INTO `sys_job_log` VALUES ('1647960602882940930', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:50:00');
INSERT INTO `sys_job_log` VALUES ('1647960854729924610', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 21:51:00');
INSERT INTO `sys_job_log` VALUES ('1647961106195226625', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:52:00');
INSERT INTO `sys_job_log` VALUES ('1647961358147051521', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:53:00');
INSERT INTO `sys_job_log` VALUES ('1647961609499107329', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:54:00');
INSERT INTO `sys_job_log` VALUES ('1647961861132181505', '1252884495040782337', 'testTask', '1', 0, NULL, 2, '2023-04-17 21:55:00');
INSERT INTO `sys_job_log` VALUES ('1647962112832364545', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:56:00');
INSERT INTO `sys_job_log` VALUES ('1647962616245374977', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:58:00');
INSERT INTO `sys_job_log` VALUES ('1647962867802951681', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 21:59:00');
INSERT INTO `sys_job_log` VALUES ('1647963119427637249', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 22:00:00');
INSERT INTO `sys_job_log` VALUES ('1647963371115237377', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 22:01:00');
INSERT INTO `sys_job_log` VALUES ('1647963622790254593', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 22:02:00');
INSERT INTO `sys_job_log` VALUES ('1647963874456883201', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 22:03:00');
INSERT INTO `sys_job_log` VALUES ('1647964126073180162', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 22:04:00');
INSERT INTO `sys_job_log` VALUES ('1647964377769168897', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 22:05:00');
INSERT INTO `sys_job_log` VALUES ('1647964629419020290', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 22:06:00');
INSERT INTO `sys_job_log` VALUES ('1647964881295294466', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 22:07:00');
INSERT INTO `sys_job_log` VALUES ('1647965132718653442', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 22:08:00');
INSERT INTO `sys_job_log` VALUES ('1647965636098097154', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 22:10:00');
INSERT INTO `sys_job_log` VALUES ('1647965887689228289', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 22:11:00');
INSERT INTO `sys_job_log` VALUES ('1647966139381022722', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 22:12:00');
INSERT INTO `sys_job_log` VALUES ('1647966391060234242', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 22:13:00');
INSERT INTO `sys_job_log` VALUES ('1647966643217563650', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 22:14:00');
INSERT INTO `sys_job_log` VALUES ('1647966894338932738', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-17 22:15:00');
INSERT INTO `sys_job_log` VALUES ('1647967145984589825', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 22:16:00');
INSERT INTO `sys_job_log` VALUES ('1647967397722583041', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-17 22:17:00');
INSERT INTO `sys_job_log` VALUES ('1651105324279300097', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:06:00');
INSERT INTO `sys_job_log` VALUES ('1651105575895597058', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:07:00');
INSERT INTO `sys_job_log` VALUES ('1651105827537059841', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:08:00');
INSERT INTO `sys_job_log` VALUES ('1651106079237242882', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:09:00');
INSERT INTO `sys_job_log` VALUES ('1651106330891288577', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:10:00');
INSERT INTO `sys_job_log` VALUES ('1651106582528557057', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:11:00');
INSERT INTO `sys_job_log` VALUES ('1651106834207768577', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:12:00');
INSERT INTO `sys_job_log` VALUES ('1651107085916340226', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:13:00');
INSERT INTO `sys_job_log` VALUES ('1651107337478111233', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:14:00');
INSERT INTO `sys_job_log` VALUES ('1651107589165711362', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:15:00');
INSERT INTO `sys_job_log` VALUES ('1651107840832339969', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:16:00');
INSERT INTO `sys_job_log` VALUES ('1651108092461219841', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:17:00');
INSERT INTO `sys_job_log` VALUES ('1651108344115265537', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:18:00');
INSERT INTO `sys_job_log` VALUES ('1651108595769311234', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:19:00');
INSERT INTO `sys_job_log` VALUES ('1651108847536603137', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:20:00');
INSERT INTO `sys_job_log` VALUES ('1651109099224203266', '1252884495040782337', 'testTask', '1', 0, NULL, 2, '2023-04-26 14:21:00');
INSERT INTO `sys_job_log` VALUES ('1651109350765002754', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 14:22:00');
INSERT INTO `sys_job_log` VALUES ('1651109602444214273', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 14:23:00');
INSERT INTO `sys_job_log` VALUES ('1651109854106648578', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 14:24:00');
INSERT INTO `sys_job_log` VALUES ('1651110105743917058', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 14:25:00');
INSERT INTO `sys_job_log` VALUES ('1651110357427322881', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:26:00');
INSERT INTO `sys_job_log` VALUES ('1651110609035231233', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:27:00');
INSERT INTO `sys_job_log` VALUES ('1651110860722831362', '1252884495040782337', 'testTask', '1', 0, NULL, 2, '2023-04-26 14:28:00');
INSERT INTO `sys_job_log` VALUES ('1651111112372682753', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:29:00');
INSERT INTO `sys_job_log` VALUES ('1651111364001562625', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:30:00');
INSERT INTO `sys_job_log` VALUES ('1651111618608398338', '1252884495040782337', 'testTask', '1', 0, NULL, 11, '2023-04-26 14:31:01');
INSERT INTO `sys_job_log` VALUES ('1651111867330625537', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:32:00');
INSERT INTO `sys_job_log` VALUES ('1651112119022419970', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:33:00');
INSERT INTO `sys_job_log` VALUES ('1651112370697437186', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:34:00');
INSERT INTO `sys_job_log` VALUES ('1651113125877694466', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 14:37:00');
INSERT INTO `sys_job_log` VALUES ('1651113377296859137', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 14:38:00');
INSERT INTO `sys_job_log` VALUES ('1651113628950904834', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 14:39:00');
INSERT INTO `sys_job_log` VALUES ('1651113880609144833', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 14:40:00');
INSERT INTO `sys_job_log` VALUES ('1651114132305133570', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:41:00');
INSERT INTO `sys_job_log` VALUES ('1651114383934013441', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:42:00');
INSERT INTO `sys_job_log` VALUES ('1651114635546116097', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:43:00');
INSERT INTO `sys_job_log` VALUES ('1651115139084922882', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 14:45:00');
INSERT INTO `sys_job_log` VALUES ('1651115390567002113', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:46:00');
INSERT INTO `sys_job_log` VALUES ('1651115642267185154', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 14:47:00');
INSERT INTO `sys_job_log` VALUES ('1651115893908647937', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:48:00');
INSERT INTO `sys_job_log` VALUES ('1651116145571082241', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:49:00');
INSERT INTO `sys_job_log` VALUES ('1651116397191573506', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 14:50:00');
INSERT INTO `sys_job_log` VALUES ('1651116649025974274', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:51:00');
INSERT INTO `sys_job_log` VALUES ('1651116900503859201', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 14:52:00');
INSERT INTO `sys_job_log` VALUES ('1651119681373597698', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:03:03');
INSERT INTO `sys_job_log` VALUES ('1651119920398594050', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:04:00');
INSERT INTO `sys_job_log` VALUES ('1651120172228800513', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:05:00');
INSERT INTO `sys_job_log` VALUES ('1651120423702491137', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:06:00');
INSERT INTO `sys_job_log` VALUES ('1651120675528503297', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:07:00');
INSERT INTO `sys_job_log` VALUES ('1651120927014776833', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:08:00');
INSERT INTO `sys_job_log` VALUES ('1651121178673016834', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:09:00');
INSERT INTO `sys_job_log` VALUES ('1651121682190761985', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:11:00');
INSERT INTO `sys_job_log` VALUES ('1651121933651869697', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:12:00');
INSERT INTO `sys_job_log` VALUES ('1651122185410797570', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:13:00');
INSERT INTO `sys_job_log` VALUES ('1651122436972568577', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:14:00');
INSERT INTO `sys_job_log` VALUES ('1651122940444250113', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:16:00');
INSERT INTO `sys_job_log` VALUES ('1651123191955689474', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:17:00');
INSERT INTO `sys_job_log` VALUES ('1651123443647483906', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:18:00');
INSERT INTO `sys_job_log` VALUES ('1651123695288946689', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:19:00');
INSERT INTO `sys_job_log` VALUES ('1651123946951380993', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:20:00');
INSERT INTO `sys_job_log` VALUES ('1651124198626398210', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:21:00');
INSERT INTO `sys_job_log` VALUES ('1651124452633350145', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:22:01');
INSERT INTO `sys_job_log` VALUES ('1651124701938585601', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:23:00');
INSERT INTO `sys_job_log` VALUES ('1651124953575854081', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:24:00');
INSERT INTO `sys_job_log` VALUES ('1651125205229899777', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:25:00');
INSERT INTO `sys_job_log` VALUES ('1651125456913305602', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:26:00');
INSERT INTO `sys_job_log` VALUES ('1651125708529602561', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:27:00');
INSERT INTO `sys_job_log` VALUES ('1651125960217202690', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:28:00');
INSERT INTO `sys_job_log` VALUES ('1651126211871248385', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:29:00');
INSERT INTO `sys_job_log` VALUES ('1651126463533682689', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:30:00');
INSERT INTO `sys_job_log` VALUES ('1651126715154173953', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:31:00');
INSERT INTO `sys_job_log` VALUES ('1651126966841774082', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:32:00');
INSERT INTO `sys_job_log` VALUES ('1651127218479042562', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:33:00');
INSERT INTO `sys_job_log` VALUES ('1651127470183419906', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:34:00');
INSERT INTO `sys_job_log` VALUES ('1651127721820688385', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:35:00');
INSERT INTO `sys_job_log` VALUES ('1651127973491511298', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:36:00');
INSERT INTO `sys_job_log` VALUES ('1651128225124585474', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:37:00');
INSERT INTO `sys_job_log` VALUES ('1651128476845801473', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:38:00');
INSERT INTO `sys_job_log` VALUES ('1651128728445321217', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:39:00');
INSERT INTO `sys_job_log` VALUES ('1651128980141309953', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:40:00');
INSERT INTO `sys_job_log` VALUES ('1651129231774384130', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:41:00');
INSERT INTO `sys_job_log` VALUES ('1651129483453595649', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:42:00');
INSERT INTO `sys_job_log` VALUES ('1651129986744909825', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:44:00');
INSERT INTO `sys_job_log` VALUES ('1651130238390566913', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:45:00');
INSERT INTO `sys_job_log` VALUES ('1651130490036224001', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:46:00');
INSERT INTO `sys_job_log` VALUES ('1651130741811912706', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:47:00');
INSERT INTO `sys_job_log` VALUES ('1651130993373683713', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:48:00');
INSERT INTO `sys_job_log` VALUES ('1651131245015146497', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:49:00');
INSERT INTO `sys_job_log` VALUES ('1651131496706940930', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:50:00');
INSERT INTO `sys_job_log` VALUES ('1651131748323237889', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:51:00');
INSERT INTO `sys_job_log` VALUES ('1651132000010838018', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:52:00');
INSERT INTO `sys_job_log` VALUES ('1651132251820077057', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:53:00');
INSERT INTO `sys_job_log` VALUES ('1651132503293767682', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:54:00');
INSERT INTO `sys_job_log` VALUES ('1651132755065266178', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:55:00');
INSERT INTO `sys_job_log` VALUES ('1651133258415271938', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:57:00');
INSERT INTO `sys_job_log` VALUES ('1651133509981237249', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 15:58:00');
INSERT INTO `sys_job_log` VALUES ('1651133761631088642', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 15:59:00');
INSERT INTO `sys_job_log` VALUES ('1651134013566173185', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:00:00');
INSERT INTO `sys_job_log` VALUES ('1651134265065029633', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:01:00');
INSERT INTO `sys_job_log` VALUES ('1651134516568080385', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:02:00');
INSERT INTO `sys_job_log` VALUES ('1651135019909726209', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:04:00');
INSERT INTO `sys_job_log` VALUES ('1651135271593132034', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:05:00');
INSERT INTO `sys_job_log` VALUES ('1651135523251372033', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:06:00');
INSERT INTO `sys_job_log` VALUES ('1651135774901223426', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:07:00');
INSERT INTO `sys_job_log` VALUES ('1651136026530103297', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:08:00');
INSERT INTO `sys_job_log` VALUES ('1651136278217703425', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:09:00');
INSERT INTO `sys_job_log` VALUES ('1651136529880137730', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:10:00');
INSERT INTO `sys_job_log` VALUES ('1651136781517406209', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:11:00');
INSERT INTO `sys_job_log` VALUES ('1651137033146286081', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:12:00');
INSERT INTO `sys_job_log` VALUES ('1651137284833886209', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:13:00');
INSERT INTO `sys_job_log` VALUES ('1651137536483737602', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:14:00');
INSERT INTO `sys_job_log` VALUES ('1651137788158754817', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:15:00');
INSERT INTO `sys_job_log` VALUES ('1651138039812800514', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:16:00');
INSERT INTO `sys_job_log` VALUES ('1651138291471040513', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:17:00');
INSERT INTO `sys_job_log` VALUES ('1651138543146057729', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:18:00');
INSERT INTO `sys_job_log` VALUES ('1651138794791714818', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:19:00');
INSERT INTO `sys_job_log` VALUES ('1651141311344754689', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:29:00');
INSERT INTO `sys_job_log` VALUES ('1651141563040743425', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:30:00');
INSERT INTO `sys_job_log` VALUES ('1651141814669623298', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:31:00');
INSERT INTO `sys_job_log` VALUES ('1651142066348834818', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:32:00');
INSERT INTO `sys_job_log` VALUES ('1651142317990297602', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:33:00');
INSERT INTO `sys_job_log` VALUES ('1651142569665314817', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:34:00');
INSERT INTO `sys_job_log` VALUES ('1651142821302583297', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:35:00');
INSERT INTO `sys_job_log` VALUES ('1651143072952434689', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:36:00');
INSERT INTO `sys_job_log` VALUES ('1651143324631646210', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:37:00');
INSERT INTO `sys_job_log` VALUES ('1651143576289886209', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:38:00');
INSERT INTO `sys_job_log` VALUES ('1651143827939737601', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:39:00');
INSERT INTO `sys_job_log` VALUES ('1651144079606366209', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:40:00');
INSERT INTO `sys_job_log` VALUES ('1651144331243634689', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:41:00');
INSERT INTO `sys_job_log` VALUES ('1651144582906068994', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:42:00');
INSERT INTO `sys_job_log` VALUES ('1651144834564308994', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:43:00');
INSERT INTO `sys_job_log` VALUES ('1651145086251909122', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:44:00');
INSERT INTO `sys_job_log` VALUES ('1651145337918537729', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:45:00');
INSERT INTO `sys_job_log` VALUES ('1651145589555806210', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:46:00');
INSERT INTO `sys_job_log` VALUES ('1651145841226629121', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:47:00');
INSERT INTO `sys_job_log` VALUES ('1651146092872286209', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:48:00');
INSERT INTO `sys_job_log` VALUES ('1651146344526331906', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:49:00');
INSERT INTO `sys_job_log` VALUES ('1651146596163600385', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:50:00');
INSERT INTO `sys_job_log` VALUES ('1651146847826034689', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:51:00');
INSERT INTO `sys_job_log` VALUES ('1651147099501051905', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:52:00');
INSERT INTO `sys_job_log` VALUES ('1651147351155097601', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:53:00');
INSERT INTO `sys_job_log` VALUES ('1651147602846892033', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:54:00');
INSERT INTO `sys_job_log` VALUES ('1651147854475771905', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:55:00');
INSERT INTO `sys_job_log` VALUES ('1651148106138206210', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:56:00');
INSERT INTO `sys_job_log` VALUES ('1651148357825806338', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:57:00');
INSERT INTO `sys_job_log` VALUES ('1651148609437908994', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 16:58:00');
INSERT INTO `sys_job_log` VALUES ('1651148861096148994', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 16:59:00');
INSERT INTO `sys_job_log` VALUES ('1651149112758583297', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 17:00:00');
INSERT INTO `sys_job_log` VALUES ('1651149364404240385', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 17:01:00');
INSERT INTO `sys_job_log` VALUES ('1651149616079257601', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:02:00');
INSERT INTO `sys_job_log` VALUES ('1651149867750080514', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:03:00');
INSERT INTO `sys_job_log` VALUES ('1651150119416709121', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:04:00');
INSERT INTO `sys_job_log` VALUES ('1651150371053977601', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 17:05:00');
INSERT INTO `sys_job_log` VALUES ('1651150622695440386', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 17:06:00');
INSERT INTO `sys_job_log` VALUES ('1651150874408206337', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 17:07:00');
INSERT INTO `sys_job_log` VALUES ('1651151126049669121', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:08:00');
INSERT INTO `sys_job_log` VALUES ('1651151377678548993', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 17:09:00');
INSERT INTO `sys_job_log` VALUES ('1651151629336788994', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 17:10:00');
INSERT INTO `sys_job_log` VALUES ('1651151881016000514', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:11:00');
INSERT INTO `sys_job_log` VALUES ('1651152132644880386', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:12:00');
INSERT INTO `sys_job_log` VALUES ('1651152384336674818', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 17:13:00');
INSERT INTO `sys_job_log` VALUES ('1651152635961360385', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:14:00');
INSERT INTO `sys_job_log` VALUES ('1651152887644766210', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:15:00');
INSERT INTO `sys_job_log` VALUES ('1651153139303006210', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:16:00');
INSERT INTO `sys_job_log` VALUES ('1651153390986412033', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 17:17:00');
INSERT INTO `sys_job_log` VALUES ('1651153642640457730', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:18:00');
INSERT INTO `sys_job_log` VALUES ('1651153894340640769', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:19:00');
INSERT INTO `sys_job_log` VALUES ('1651154145952743426', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:20:00');
INSERT INTO `sys_job_log` VALUES ('1651154397594206210', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:21:00');
INSERT INTO `sys_job_log` VALUES ('1651154649227280386', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:22:00');
INSERT INTO `sys_job_log` VALUES ('1651154900881326082', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 17:23:00');
INSERT INTO `sys_job_log` VALUES ('1651155152556343297', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:24:00');
INSERT INTO `sys_job_log` VALUES ('1651155404248137729', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:25:00');
INSERT INTO `sys_job_log` VALUES ('1651155655868628993', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:26:00');
INSERT INTO `sys_job_log` VALUES ('1651155907564617729', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:27:00');
INSERT INTO `sys_job_log` VALUES ('1651156159172526081', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 17:28:00');
INSERT INTO `sys_job_log` VALUES ('1651156410834960386', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:29:00');
INSERT INTO `sys_job_log` VALUES ('1651156662501588994', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:30:00');
INSERT INTO `sys_job_log` VALUES ('1651156914226946050', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:31:00');
INSERT INTO `sys_job_log` VALUES ('1651157165826465793', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:32:00');
INSERT INTO `sys_job_log` VALUES ('1651157417484705793', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:33:00');
INSERT INTO `sys_job_log` VALUES ('1651157669134557185', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:34:00');
INSERT INTO `sys_job_log` VALUES ('1651157920780214274', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:35:00');
INSERT INTO `sys_job_log` VALUES ('1651158172488785921', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:36:00');
INSERT INTO `sys_job_log` VALUES ('1651158424092499970', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:37:00');
INSERT INTO `sys_job_log` VALUES ('1651158675834638338', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:38:00');
INSERT INTO `sys_job_log` VALUES ('1651158927601885185', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 17:39:00');
INSERT INTO `sys_job_log` VALUES ('1651159430993874945', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 17:41:00');
INSERT INTO `sys_job_log` VALUES ('1651159682501169153', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 17:42:00');
INSERT INTO `sys_job_log` VALUES ('1651159934067134466', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 17:43:00');
INSERT INTO `sys_job_log` VALUES ('1651160185704402945', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:44:00');
INSERT INTO `sys_job_log` VALUES ('1651160437387808770', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 17:45:00');
INSERT INTO `sys_job_log` VALUES ('1651160689138249729', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:46:00');
INSERT INTO `sys_job_log` VALUES ('1651160940704215042', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:47:00');
INSERT INTO `sys_job_log` VALUES ('1651161192375037954', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 17:48:00');
INSERT INTO `sys_job_log` VALUES ('1651161444104556546', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:49:00');
INSERT INTO `sys_job_log` VALUES ('1651161695653744642', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:50:00');
INSERT INTO `sys_job_log` VALUES ('1651161947341344770', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:51:00');
INSERT INTO `sys_job_log` VALUES ('1651162198974418946', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:52:00');
INSERT INTO `sys_job_log` VALUES ('1651162450628464641', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 17:53:00');
INSERT INTO `sys_job_log` VALUES ('1651162702332841986', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:54:00');
INSERT INTO `sys_job_log` VALUES ('1651162954007859202', '1252884495040782337', 'testTask', '1', 0, NULL, 2, '2023-04-26 17:55:00');
INSERT INTO `sys_job_log` VALUES ('1651163205603184641', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 17:56:00');
INSERT INTO `sys_job_log` VALUES ('1651163457286590466', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 17:57:00');
INSERT INTO `sys_job_log` VALUES ('1651163708932247553', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 17:58:00');
INSERT INTO `sys_job_log` VALUES ('1651163960582098945', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 17:59:00');
INSERT INTO `sys_job_log` VALUES ('1651164212248727554', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 18:00:00');
INSERT INTO `sys_job_log` VALUES ('1651164463894384641', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 18:01:00');
INSERT INTO `sys_job_log` VALUES ('1651164715577790466', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 18:02:00');
INSERT INTO `sys_job_log` VALUES ('1651164967223447554', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 18:03:00');
INSERT INTO `sys_job_log` VALUES ('1651165218864910337', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 18:04:00');
INSERT INTO `sys_job_log` VALUES ('1651165470544121857', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 18:05:00');
INSERT INTO `sys_job_log` VALUES ('1651165722202361857', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 18:06:00');
INSERT INTO `sys_job_log` VALUES ('1651165973889961986', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 18:07:00');
INSERT INTO `sys_job_log` VALUES ('1651166225539813377', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 18:08:00');
INSERT INTO `sys_job_log` VALUES ('1651166477219024898', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 18:09:00');
INSERT INTO `sys_job_log` VALUES ('1651166728860487682', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 18:10:00');
INSERT INTO `sys_job_log` VALUES ('1651166980510339074', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 18:11:00');
INSERT INTO `sys_job_log` VALUES ('1651167232143413250', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 18:12:00');
INSERT INTO `sys_job_log` VALUES ('1651167987151687681', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 18:15:00');
INSERT INTO `sys_job_log` VALUES ('1651168238822510594', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 18:16:00');
INSERT INTO `sys_job_log` VALUES ('1651168490438807554', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 18:17:00');
INSERT INTO `sys_job_log` VALUES ('1651168742080270337', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 18:18:00');
INSERT INTO `sys_job_log` VALUES ('1651168993793036289', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 18:19:00');
INSERT INTO `sys_job_log` VALUES ('1651169245405138945', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 18:20:00');
INSERT INTO `sys_job_log` VALUES ('1651169497075961858', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 18:21:00');
INSERT INTO `sys_job_log` VALUES ('1651169748759367681', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 18:22:00');
INSERT INTO `sys_job_log` VALUES ('1651170252067459074', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 18:24:00');
INSERT INTO `sys_job_log` VALUES ('1651170503717310465', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 18:25:00');
INSERT INTO `sys_job_log` VALUES ('1651170755404910593', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 18:26:00');
INSERT INTO `sys_job_log` VALUES ('1651171007058956289', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 18:27:00');
INSERT INTO `sys_job_log` VALUES ('1651178305097584642', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 18:56:00');
INSERT INTO `sys_job_log` VALUES ('1651178556801961986', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 18:57:00');
INSERT INTO `sys_job_log` VALUES ('1651178808409870337', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 18:58:00');
INSERT INTO `sys_job_log` VALUES ('1651179060076498946', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 18:59:00');
INSERT INTO `sys_job_log` VALUES ('1651179311776681986', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 19:00:00');
INSERT INTO `sys_job_log` VALUES ('1651179563392978946', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:01:00');
INSERT INTO `sys_job_log` VALUES ('1651179815067996161', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:02:00');
INSERT INTO `sys_job_log` VALUES ('1651180066713653250', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 19:03:00');
INSERT INTO `sys_job_log` VALUES ('1651180318392864769', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:04:00');
INSERT INTO `sys_job_log` VALUES ('1651180570038521858', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:05:00');
INSERT INTO `sys_job_log` VALUES ('1651180821726121985', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 19:06:00');
INSERT INTO `sys_job_log` VALUES ('1651181073384361985', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 19:07:00');
INSERT INTO `sys_job_log` VALUES ('1651181325042601985', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:08:00');
INSERT INTO `sys_job_log` VALUES ('1651181576671481857', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 19:09:00');
INSERT INTO `sys_job_log` VALUES ('1651181828321333250', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:10:00');
INSERT INTO `sys_job_log` VALUES ('1651182080017321985', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:11:00');
INSERT INTO `sys_job_log` VALUES ('1651182331629424641', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:12:00');
INSERT INTO `sys_job_log` VALUES ('1651182583337996290', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 19:13:00');
INSERT INTO `sys_job_log` VALUES ('1651182834983653378', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:14:00');
INSERT INTO `sys_job_log` VALUES ('1651183086616727553', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:15:00');
INSERT INTO `sys_job_log` VALUES ('1651183338312716289', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 19:16:00');
INSERT INTO `sys_job_log` VALUES ('1651183589958373378', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 19:17:00');
INSERT INTO `sys_job_log` VALUES ('1651183841608224770', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:18:00');
INSERT INTO `sys_job_log` VALUES ('1651184344945676289', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:20:00');
INSERT INTO `sys_job_log` VALUES ('1651184596603916290', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:21:00');
INSERT INTO `sys_job_log` VALUES ('1651184848228601857', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 19:22:00');
INSERT INTO `sys_job_log` VALUES ('1651185099903619073', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:23:00');
INSERT INTO `sys_job_log` VALUES ('1651185351545081857', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 19:24:00');
INSERT INTO `sys_job_log` VALUES ('1651185603207516162', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 19:25:00');
INSERT INTO `sys_job_log` VALUES ('1651185854882533378', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:26:00');
INSERT INTO `sys_job_log` VALUES ('1651186106507218945', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:27:00');
INSERT INTO `sys_job_log` VALUES ('1651186358215790594', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 19:28:00');
INSERT INTO `sys_job_log` VALUES ('1651186609861447681', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 19:29:00');
INSERT INTO `sys_job_log` VALUES ('1651186861515493377', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:30:00');
INSERT INTO `sys_job_log` VALUES ('1651187113177927682', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:31:00');
INSERT INTO `sys_job_log` VALUES ('1651187364794224641', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:32:00');
INSERT INTO `sys_job_log` VALUES ('1651187616473436161', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:33:00');
INSERT INTO `sys_job_log` VALUES ('1651187868161036289', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 19:34:00');
INSERT INTO `sys_job_log` VALUES ('1651188119789916161', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 19:35:00');
INSERT INTO `sys_job_log` VALUES ('1651188371431378946', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:36:00');
INSERT INTO `sys_job_log` VALUES ('1651188623148339202', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:37:00');
INSERT INTO `sys_job_log` VALUES ('1651188874773024769', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:38:00');
INSERT INTO `sys_job_log` VALUES ('1651189126448041985', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:39:00');
INSERT INTO `sys_job_log` VALUES ('1651189378064338945', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 19:40:00');
INSERT INTO `sys_job_log` VALUES ('1651189629747744770', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:41:00');
INSERT INTO `sys_job_log` VALUES ('1651189881426956290', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 19:42:00');
INSERT INTO `sys_job_log` VALUES ('1651190133089390593', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 19:43:00');
INSERT INTO `sys_job_log` VALUES ('1651190384705687554', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:44:00');
INSERT INTO `sys_job_log` VALUES ('1651190636380704769', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 19:45:00');
INSERT INTO `sys_job_log` VALUES ('1651190888043139073', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:46:00');
INSERT INTO `sys_job_log` VALUES ('1651191139705573378', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:47:00');
INSERT INTO `sys_job_log` VALUES ('1651191391342841857', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:48:00');
INSERT INTO `sys_job_log` VALUES ('1651191643043024898', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:49:00');
INSERT INTO `sys_job_log` VALUES ('1651191894701264897', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:50:00');
INSERT INTO `sys_job_log` VALUES ('1651192146317561857', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:51:00');
INSERT INTO `sys_job_log` VALUES ('1651192397967413250', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 19:52:00');
INSERT INTO `sys_job_log` VALUES ('1651192649671790594', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 19:53:00');
INSERT INTO `sys_job_log` VALUES ('1651192901288087553', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:54:00');
INSERT INTO `sys_job_log` VALUES ('1651193152979881985', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:55:00');
INSERT INTO `sys_job_log` VALUES ('1651193404604567554', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:56:00');
INSERT INTO `sys_job_log` VALUES ('1651193656304750593', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:57:00');
INSERT INTO `sys_job_log` VALUES ('1651193907933630465', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:58:00');
INSERT INTO `sys_job_log` VALUES ('1651194159600259073', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 19:59:00');
INSERT INTO `sys_job_log` VALUES ('1651194411254304770', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:00:00');
INSERT INTO `sys_job_log` VALUES ('1651194662904156161', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 20:01:00');
INSERT INTO `sys_job_log` VALUES ('1651194914570784770', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 20:02:00');
INSERT INTO `sys_job_log` VALUES ('1651195166212247554', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:03:00');
INSERT INTO `sys_job_log` VALUES ('1651195417908236289', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:04:00');
INSERT INTO `sys_job_log` VALUES ('1651195669524533249', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:05:00');
INSERT INTO `sys_job_log` VALUES ('1651195921233104898', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:06:00');
INSERT INTO `sys_job_log` VALUES ('1651196172836818945', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:07:00');
INSERT INTO `sys_job_log` VALUES ('1651196424537001985', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:08:00');
INSERT INTO `sys_job_log` VALUES ('1651196676149104641', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:09:00');
INSERT INTO `sys_job_log` VALUES ('1651196927857676290', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 20:10:00');
INSERT INTO `sys_job_log` VALUES ('1651197179490750465', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 20:11:00');
INSERT INTO `sys_job_log` VALUES ('1651197431182544898', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 20:12:00');
INSERT INTO `sys_job_log` VALUES ('1651197682828201985', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:13:00');
INSERT INTO `sys_job_log` VALUES ('1651197934486441985', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:14:00');
INSERT INTO `sys_job_log` VALUES ('1651198186157264897', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:15:00');
INSERT INTO `sys_job_log` VALUES ('1651198437760978945', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 20:16:00');
INSERT INTO `sys_job_log` VALUES ('1651198689448579074', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 20:17:00');
INSERT INTO `sys_job_log` VALUES ('1651198941102624770', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:18:00');
INSERT INTO `sys_job_log` VALUES ('1651199192752476162', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:19:00');
INSERT INTO `sys_job_log` VALUES ('1651199444444270594', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:20:00');
INSERT INTO `sys_job_log` VALUES ('1651199696085733378', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:21:00');
INSERT INTO `sys_job_log` VALUES ('1651199947752361986', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 20:22:00');
INSERT INTO `sys_job_log` VALUES ('1651200199398019073', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 20:23:00');
INSERT INTO `sys_job_log` VALUES ('1651200451052064769', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 20:24:00');
INSERT INTO `sys_job_log` VALUES ('1651200702735470593', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 20:25:00');
INSERT INTO `sys_job_log` VALUES ('1651200954381127682', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 20:26:00');
INSERT INTO `sys_job_log` VALUES ('1651201206030979074', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:27:00');
INSERT INTO `sys_job_log` VALUES ('1651201457672441858', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 20:28:00');
INSERT INTO `sys_job_log` VALUES ('1651201709322293250', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:29:00');
INSERT INTO `sys_job_log` VALUES ('1651201961018281986', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 20:30:00');
INSERT INTO `sys_job_log` VALUES ('1651202212638773250', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:31:00');
INSERT INTO `sys_job_log` VALUES ('1651202464343150593', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 20:32:00');
INSERT INTO `sys_job_log` VALUES ('1651202715984613378', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:33:00');
INSERT INTO `sys_job_log` VALUES ('1651202967642853378', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 20:34:00');
INSERT INTO `sys_job_log` VALUES ('1651203219284316161', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:35:00');
INSERT INTO `sys_job_log` VALUES ('1651203470955139074', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 20:36:00');
INSERT INTO `sys_job_log` VALUES ('1651203722613379074', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:37:00');
INSERT INTO `sys_job_log` VALUES ('1651203974292590593', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:38:00');
INSERT INTO `sys_job_log` VALUES ('1651204225938247681', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:39:00');
INSERT INTO `sys_job_log` VALUES ('1651204477588099073', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:40:00');
INSERT INTO `sys_job_log` VALUES ('1651204729216978945', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:41:00');
INSERT INTO `sys_job_log` VALUES ('1651204980891996162', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:42:00');
INSERT INTO `sys_job_log` VALUES ('1651205232579596289', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:43:00');
INSERT INTO `sys_job_log` VALUES ('1651205484195893250', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:44:00');
INSERT INTO `sys_job_log` VALUES ('1651205735887687681', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 20:45:00');
INSERT INTO `sys_job_log` VALUES ('1651205987508178946', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 20:46:00');
INSERT INTO `sys_job_log` VALUES ('1651206239174807554', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 20:47:00');
INSERT INTO `sys_job_log` VALUES ('1651206490854019074', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 20:48:00');
INSERT INTO `sys_job_log` VALUES ('1651206742512259074', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-26 20:49:00');
INSERT INTO `sys_job_log` VALUES ('1651206994178887681', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-26 20:50:00');
INSERT INTO `sys_job_log` VALUES ('1651510494122504194', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 16:56:00');
INSERT INTO `sys_job_log` VALUES ('1651510745763966977', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 16:57:00');
INSERT INTO `sys_job_log` VALUES ('1651510997342515202', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 16:58:00');
INSERT INTO `sys_job_log` VALUES ('1651511249004949505', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 16:59:00');
INSERT INTO `sys_job_log` VALUES ('1651511500675772418', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:00:00');
INSERT INTO `sys_job_log` VALUES ('1651511752279486466', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:01:00');
INSERT INTO `sys_job_log` VALUES ('1651512003929337858', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:02:00');
INSERT INTO `sys_job_log` VALUES ('1651512255600160769', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:03:00');
INSERT INTO `sys_job_log` VALUES ('1651512507300343810', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:04:00');
INSERT INTO `sys_job_log` VALUES ('1651512758920835074', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:05:00');
INSERT INTO `sys_job_log` VALUES ('1651513010566492161', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:06:00');
INSERT INTO `sys_job_log` VALUES ('1651513262249897986', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:07:00');
INSERT INTO `sys_job_log` VALUES ('1651513513912332289', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:08:00');
INSERT INTO `sys_job_log` VALUES ('1651513765562183681', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:09:00');
INSERT INTO `sys_job_log` VALUES ('1651514017191063554', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:10:00');
INSERT INTO `sys_job_log` VALUES ('1651514268853497858', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:11:00');
INSERT INTO `sys_job_log` VALUES ('1651514520528515073', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:12:00');
INSERT INTO `sys_job_log` VALUES ('1651514772224503809', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:13:00');
INSERT INTO `sys_job_log` VALUES ('1651515023844995074', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:14:00');
INSERT INTO `sys_job_log` VALUES ('1651515275536789506', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:15:00');
INSERT INTO `sys_job_log` VALUES ('1651515527195029505', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:16:00');
INSERT INTO `sys_job_log` VALUES ('1651515778794549250', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:17:00');
INSERT INTO `sys_job_log` VALUES ('1651516030452789250', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:18:00');
INSERT INTO `sys_job_log` VALUES ('1651516282169749505', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:19:00');
INSERT INTO `sys_job_log` VALUES ('1651516533769269249', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:20:00');
INSERT INTO `sys_job_log` VALUES ('1651516785444286465', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:21:00');
INSERT INTO `sys_job_log` VALUES ('1651517037052194818', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:22:00');
INSERT INTO `sys_job_log` VALUES ('1651517288773349377', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:23:00');
INSERT INTO `sys_job_log` VALUES ('1651517540460949506', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:24:00');
INSERT INTO `sys_job_log` VALUES ('1651517792114995201', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:25:00');
INSERT INTO `sys_job_log` VALUES ('1651518043739680770', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:26:00');
INSERT INTO `sys_job_log` VALUES ('1651518295431475201', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:27:00');
INSERT INTO `sys_job_log` VALUES ('1651518547047772162', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:28:00');
INSERT INTO `sys_job_log` VALUES ('1651518798706012162', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:29:00');
INSERT INTO `sys_job_log` VALUES ('1651519050381029377', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:30:00');
INSERT INTO `sys_job_log` VALUES ('1651519302068629505', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:31:00');
INSERT INTO `sys_job_log` VALUES ('1651519553722675202', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:32:00');
INSERT INTO `sys_job_log` VALUES ('1651519805343166465', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:33:00');
INSERT INTO `sys_job_log` VALUES ('1651520056997212162', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:34:00');
INSERT INTO `sys_job_log` VALUES ('1651520308663840769', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:35:00');
INSERT INTO `sys_job_log` VALUES ('1651520560330469377', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:36:00');
INSERT INTO `sys_job_log` VALUES ('1651520811980320770', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:37:00');
INSERT INTO `sys_job_log` VALUES ('1651521063638560769', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:38:00');
INSERT INTO `sys_job_log` VALUES ('1651521315296800770', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:39:00');
INSERT INTO `sys_job_log` VALUES ('1651521566992789505', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:40:00');
INSERT INTO `sys_job_log` VALUES ('1651521818655223810', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:41:00');
INSERT INTO `sys_job_log` VALUES ('1651522070292492290', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:42:00');
INSERT INTO `sys_job_log` VALUES ('1651522321950732290', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:43:00');
INSERT INTO `sys_job_log` VALUES ('1651522573621555202', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:44:00');
INSERT INTO `sys_job_log` VALUES ('1651522825246240769', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:45:00');
INSERT INTO `sys_job_log` VALUES ('1651523076891897857', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:46:00');
INSERT INTO `sys_job_log` VALUES ('1651523328562720769', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:47:00');
INSERT INTO `sys_job_log` VALUES ('1651523580246126594', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:48:00');
INSERT INTO `sys_job_log` VALUES ('1651523831908560897', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:49:00');
INSERT INTO `sys_job_log` VALUES ('1651524083512274945', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:50:00');
INSERT INTO `sys_job_log` VALUES ('1651524335183097857', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:51:00');
INSERT INTO `sys_job_log` VALUES ('1651524586862309377', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:52:00');
INSERT INTO `sys_job_log` VALUES ('1651524838545715201', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:53:00');
INSERT INTO `sys_job_log` VALUES ('1651525090199760897', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:54:00');
INSERT INTO `sys_job_log` VALUES ('1651525341811863553', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 17:55:00');
INSERT INTO `sys_job_log` VALUES ('1651525593474297857', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:56:00');
INSERT INTO `sys_job_log` VALUES ('1651525845174480897', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:57:00');
INSERT INTO `sys_job_log` VALUES ('1651526096836915202', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:58:00');
INSERT INTO `sys_job_log` VALUES ('1651526348490960898', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 17:59:00');
INSERT INTO `sys_job_log` VALUES ('1651526600157589506', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:00:00');
INSERT INTO `sys_job_log` VALUES ('1651526851769692162', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:01:00');
INSERT INTO `sys_job_log` VALUES ('1651527103457292289', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:02:00');
INSERT INTO `sys_job_log` VALUES ('1651527355107143681', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:03:00');
INSERT INTO `sys_job_log` VALUES ('1651527606740217858', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:04:00');
INSERT INTO `sys_job_log` VALUES ('1651527858444595202', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:05:00');
INSERT INTO `sys_job_log` VALUES ('1651528584654778369', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:07:53');
INSERT INTO `sys_job_log` VALUES ('1651528613410926594', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:08:00');
INSERT INTO `sys_job_log` VALUES ('1651528865077555202', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:09:00');
INSERT INTO `sys_job_log` VALUES ('1651529116731600898', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:10:00');
INSERT INTO `sys_job_log` VALUES ('1651529368360480770', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:11:00');
INSERT INTO `sys_job_log` VALUES ('1651529620018720770', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:12:00');
INSERT INTO `sys_job_log` VALUES ('1651529871714709505', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:13:00');
INSERT INTO `sys_job_log` VALUES ('1651530123372949505', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:14:00');
INSERT INTO `sys_job_log` VALUES ('1651530375031189506', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:15:00');
INSERT INTO `sys_job_log` VALUES ('1651530626660069378', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:16:00');
INSERT INTO `sys_job_log` VALUES ('1651530878322503681', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:17:00');
INSERT INTO `sys_job_log` VALUES ('1651531129989132289', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:18:00');
INSERT INTO `sys_job_log` VALUES ('1651531381622206466', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:19:00');
INSERT INTO `sys_job_log` VALUES ('1651531633301417985', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:20:00');
INSERT INTO `sys_job_log` VALUES ('1651531884951269378', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:21:00');
INSERT INTO `sys_job_log` VALUES ('1651532136626286594', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:22:00');
INSERT INTO `sys_job_log` VALUES ('1651532388263555073', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:23:00');
INSERT INTO `sys_job_log` VALUES ('1651532639942766594', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:24:00');
INSERT INTO `sys_job_log` VALUES ('1651532891588423682', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:25:00');
INSERT INTO `sys_job_log` VALUES ('1651533143225692161', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:26:00');
INSERT INTO `sys_job_log` VALUES ('1651533394909097986', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:27:00');
INSERT INTO `sys_job_log` VALUES ('1651533646554755073', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:28:00');
INSERT INTO `sys_job_log` VALUES ('1651533898204606465', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:29:00');
INSERT INTO `sys_job_log` VALUES ('1651534149871235073', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:30:00');
INSERT INTO `sys_job_log` VALUES ('1651534401512697858', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:31:00');
INSERT INTO `sys_job_log` VALUES ('1651534653217075201', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:32:00');
INSERT INTO `sys_job_log` VALUES ('1651534904837566466', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:33:00');
INSERT INTO `sys_job_log` VALUES ('1651535156474834945', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:34:00');
INSERT INTO `sys_job_log` VALUES ('1651535408195989505', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:35:00');
INSERT INTO `sys_job_log` VALUES ('1651535659837452290', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:36:00');
INSERT INTO `sys_job_log` VALUES ('1651535911457943553', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:37:00');
INSERT INTO `sys_job_log` VALUES ('1651536163120377858', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:38:00');
INSERT INTO `sys_job_log` VALUES ('1651536414816366594', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:39:00');
INSERT INTO `sys_job_log` VALUES ('1651536666474606594', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:40:00');
INSERT INTO `sys_job_log` VALUES ('1651536918111875074', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:41:00');
INSERT INTO `sys_job_log` VALUES ('1651537169749143554', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:42:00');
INSERT INTO `sys_job_log` VALUES ('1651537673211187201', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:44:00');
INSERT INTO `sys_job_log` VALUES ('1651538176552747009', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:46:00');
INSERT INTO `sys_job_log` VALUES ('1651538428097740801', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:47:00');
INSERT INTO `sys_job_log` VALUES ('1651538679739203585', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:48:00');
INSERT INTO `sys_job_log` VALUES ('1651538942084612098', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:49:03');
INSERT INTO `sys_job_log` VALUES ('1651539183038988290', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:50:00');
INSERT INTO `sys_job_log` VALUES ('1651539434701422593', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:51:00');
INSERT INTO `sys_job_log` VALUES ('1651539686351273985', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:52:00');
INSERT INTO `sys_job_log` VALUES ('1651540189743230977', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:54:00');
INSERT INTO `sys_job_log` VALUES ('1651540441342750722', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 18:55:00');
INSERT INTO `sys_job_log` VALUES ('1651540693000990722', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:56:00');
INSERT INTO `sys_job_log` VALUES ('1651540944747245569', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:57:00');
INSERT INTO `sys_job_log` VALUES ('1651541196283850754', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:58:00');
INSERT INTO `sys_job_log` VALUES ('1651541447963062273', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 18:59:00');
INSERT INTO `sys_job_log` VALUES ('1651541699625496577', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:00:00');
INSERT INTO `sys_job_log` VALUES ('1651541951262765058', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:01:00');
INSERT INTO `sys_job_log` VALUES ('1651542202941976578', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:02:00');
INSERT INTO `sys_job_log` VALUES ('1651542454621188097', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:03:00');
INSERT INTO `sys_job_log` VALUES ('1651542706266845186', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 19:04:00');
INSERT INTO `sys_job_log` VALUES ('1651542957962833922', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:05:00');
INSERT INTO `sys_job_log` VALUES ('1651543209587519489', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:06:00');
INSERT INTO `sys_job_log` VALUES ('1651543461199622146', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:07:00');
INSERT INTO `sys_job_log` VALUES ('1651543712883027970', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:08:00');
INSERT INTO `sys_job_log` VALUES ('1651543964574822402', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 19:09:00');
INSERT INTO `sys_job_log` VALUES ('1651544216220479490', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 19:10:00');
INSERT INTO `sys_job_log` VALUES ('1651544467861942273', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 19:11:00');
INSERT INTO `sys_job_log` VALUES ('1651544719553736706', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:12:00');
INSERT INTO `sys_job_log` VALUES ('1651544971203588098', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:13:00');
INSERT INTO `sys_job_log` VALUES ('1651545222861828098', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:14:00');
INSERT INTO `sys_job_log` VALUES ('1651545474478125058', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 19:15:00');
INSERT INTO `sys_job_log` VALUES ('1651545726165725186', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 19:16:00');
INSERT INTO `sys_job_log` VALUES ('1651545986195795969', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:17:02');
INSERT INTO `sys_job_log` VALUES ('1651546229465427969', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:18:00');
INSERT INTO `sys_job_log` VALUES ('1651546481111085058', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 19:19:00');
INSERT INTO `sys_job_log` VALUES ('1651546732781907969', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 19:20:00');
INSERT INTO `sys_job_log` VALUES ('1651546984465313793', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 19:21:00');
INSERT INTO `sys_job_log` VALUES ('1651547236073222146', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 19:22:00');
INSERT INTO `sys_job_log` VALUES ('1651547487769210881', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 19:23:00');
INSERT INTO `sys_job_log` VALUES ('1651547739393896449', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:24:00');
INSERT INTO `sys_job_log` VALUES ('1651547991056330754', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 19:25:00');
INSERT INTO `sys_job_log` VALUES ('1651548242773291010', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:26:00');
INSERT INTO `sys_job_log` VALUES ('1651548494402170881', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:27:00');
INSERT INTO `sys_job_log` VALUES ('1651548746031050754', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:28:00');
INSERT INTO `sys_job_log` VALUES ('1651548997710262274', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:29:00');
INSERT INTO `sys_job_log` VALUES ('1651549249372696577', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 19:30:00');
INSERT INTO `sys_job_log` VALUES ('1651549501030936578', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:31:00');
INSERT INTO `sys_job_log` VALUES ('1651549752664010754', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 19:32:00');
INSERT INTO `sys_job_log` VALUES ('1651550004334833665', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:33:00');
INSERT INTO `sys_job_log` VALUES ('1651550255993073665', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:34:00');
INSERT INTO `sys_job_log` VALUES ('1651550507630342145', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 19:35:00');
INSERT INTO `sys_job_log` VALUES ('1651550759343108097', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:36:00');
INSERT INTO `sys_job_log` VALUES ('1651551010946822145', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 19:37:00');
INSERT INTO `sys_job_log` VALUES ('1651551262667976706', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:38:00');
INSERT INTO `sys_job_log` VALUES ('1651551514271690753', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 19:39:00');
INSERT INTO `sys_job_log` VALUES ('1651551765950902274', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:40:00');
INSERT INTO `sys_job_log` VALUES ('1651552017604947969', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:41:00');
INSERT INTO `sys_job_log` VALUES ('1651552269300936705', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:42:00');
INSERT INTO `sys_job_log` VALUES ('1651552520917233665', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 19:43:00');
INSERT INTO `sys_job_log` VALUES ('1651552772567085057', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:44:00');
INSERT INTO `sys_job_log` VALUES ('1651553024279851010', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:45:00');
INSERT INTO `sys_job_log` VALUES ('1651553275896147970', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:46:00');
INSERT INTO `sys_job_log` VALUES ('1651553527541805058', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:47:00');
INSERT INTO `sys_job_log` VALUES ('1651553779212627970', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 19:48:00');
INSERT INTO `sys_job_log` VALUES ('1651554030891839490', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:49:00');
INSERT INTO `sys_job_log` VALUES ('1651554282533302273', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:50:00');
INSERT INTO `sys_job_log` VALUES ('1651554534166376449', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:51:00');
INSERT INTO `sys_job_log` VALUES ('1651554785849782274', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:52:00');
INSERT INTO `sys_job_log` VALUES ('1651555037487050753', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 19:53:00');
INSERT INTO `sys_job_log` VALUES ('1651555289174650882', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:54:00');
INSERT INTO `sys_job_log` VALUES ('1651555540832890882', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 19:55:00');
INSERT INTO `sys_job_log` VALUES ('1651555792474353666', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 19:56:00');
INSERT INTO `sys_job_log` VALUES ('1651556044120010754', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 19:57:00');
INSERT INTO `sys_job_log` VALUES ('1651556295811805185', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:58:00');
INSERT INTO `sys_job_log` VALUES ('1651556547449073665', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 19:59:00');
INSERT INTO `sys_job_log` VALUES ('1651556808557068289', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 20:00:02');
INSERT INTO `sys_job_log` VALUES ('1651557050807484417', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 20:01:00');
INSERT INTO `sys_job_log` VALUES ('1651557302465724417', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 20:02:00');
INSERT INTO `sys_job_log` VALUES ('1651557554073632769', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 20:03:00');
INSERT INTO `sys_job_log` VALUES ('1651557805748649986', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 20:04:00');
INSERT INTO `sys_job_log` VALUES ('1651558069155188738', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 20:05:03');
INSERT INTO `sys_job_log` VALUES ('1651558309098737666', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 20:06:00');
INSERT INTO `sys_job_log` VALUES ('1651558560723423234', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 20:07:00');
INSERT INTO `sys_job_log` VALUES ('1651558812364886018', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 20:08:00');
INSERT INTO `sys_job_log` VALUES ('1651559064102871041', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 20:09:00');
INSERT INTO `sys_job_log` VALUES ('1651559315727556610', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 20:10:00');
INSERT INTO `sys_job_log` VALUES ('1651559567356436481', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 20:11:00');
INSERT INTO `sys_job_log` VALUES ('1651559818989510658', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 20:12:00');
INSERT INTO `sys_job_log` VALUES ('1651560070647750658', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 20:13:00');
INSERT INTO `sys_job_log` VALUES ('1651560322331156481', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 20:14:00');
INSERT INTO `sys_job_log` VALUES ('1651560574006173698', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 20:15:00');
INSERT INTO `sys_job_log` VALUES ('1651560825676996609', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 20:16:00');
INSERT INTO `sys_job_log` VALUES ('1651561077289099266', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 20:17:00');
INSERT INTO `sys_job_log` VALUES ('1651561328964116482', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 20:18:00');
INSERT INTO `sys_job_log` VALUES ('1651562001524957186', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 20:20:40');
INSERT INTO `sys_job_log` VALUES ('1651562083930447873', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 20:21:00');
INSERT INTO `sys_job_log` VALUES ('1651562335576104962', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 20:22:00');
INSERT INTO `sys_job_log` VALUES ('1651562587255316482', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 20:23:00');
INSERT INTO `sys_job_log` VALUES ('1651562838926139393', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 20:24:00');
INSERT INTO `sys_job_log` VALUES ('1651563090559213570', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 20:25:00');
INSERT INTO `sys_job_log` VALUES ('1651563342242619394', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 20:26:00');
INSERT INTO `sys_job_log` VALUES ('1651563593900859394', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 20:27:00');
INSERT INTO `sys_job_log` VALUES ('1651563845559099393', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 20:28:00');
INSERT INTO `sys_job_log` VALUES ('1651564097217339394', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 20:29:00');
INSERT INTO `sys_job_log` VALUES ('1651564348900745217', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 20:30:00');
INSERT INTO `sys_job_log` VALUES ('1651564600512847873', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 20:31:00');
INSERT INTO `sys_job_log` VALUES ('1651564852171087874', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 20:32:00');
INSERT INTO `sys_job_log` VALUES ('1651565103833522178', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 20:33:00');
INSERT INTO `sys_job_log` VALUES ('1651565355466596353', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 20:34:00');
INSERT INTO `sys_job_log` VALUES ('1651565607233871874', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 20:35:00');
INSERT INTO `sys_job_log` VALUES ('1651565858795642881', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 20:36:00');
INSERT INTO `sys_job_log` VALUES ('1651566110466465793', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 20:37:00');
INSERT INTO `sys_job_log` VALUES ('1651566362103734274', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 20:38:00');
INSERT INTO `sys_job_log` VALUES ('1651566613812305922', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 20:39:00');
INSERT INTO `sys_job_log` VALUES ('1651566865416019970', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 20:40:00');
INSERT INTO `sys_job_log` VALUES ('1651567117137174530', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 20:41:00');
INSERT INTO `sys_job_log` VALUES ('1651567368745082881', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 20:42:00');
INSERT INTO `sys_job_log` VALUES ('1651574666850820098', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 21:11:00');
INSERT INTO `sys_job_log` VALUES ('1651574918500671489', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 21:12:00');
INSERT INTO `sys_job_log` VALUES ('1651575170175688706', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 21:13:00');
INSERT INTO `sys_job_log` VALUES ('1651575421854900225', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 21:14:00');
INSERT INTO `sys_job_log` VALUES ('1651575673479585793', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-27 21:15:00');
INSERT INTO `sys_job_log` VALUES ('1651575925162991618', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 21:16:00');
INSERT INTO `sys_job_log` VALUES ('1651576176825425921', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 21:17:00');
INSERT INTO `sys_job_log` VALUES ('1651576428462694402', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-27 21:18:00');

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
INSERT INTO `sys_log` VALUES ('1647934628493611009', '1', 'admin', '机构管理-树型组织列表', 24, 'com.company.project.controller.sys.DeptController.getTree()', '[null]', '172.27.181.221', '2023-04-17 20:06:47');
INSERT INTO `sys_log` VALUES ('1647934628560719874', '1', 'admin', '用户管理-分页获取用户列表', 36, 'com.company.project.controller.sys.UserController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '172.27.181.221', '2023-04-17 20:06:47');
INSERT INTO `sys_log` VALUES ('1647934729681195010', '1', 'admin', '角色管理-分页获取角色信息', 19, 'com.company.project.controller.sys.RoleController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '172.27.181.221', '2023-04-17 20:07:11');
INSERT INTO `sys_log` VALUES ('1647934736849260546', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 189, 'com.company.project.controller.sys.PermissionController.getAllPermissionTree()', NULL, '172.27.181.221', '2023-04-17 20:07:13');
INSERT INTO `sys_log` VALUES ('1647934763101409282', '1', 'admin', '菜单权限管理-获取所有菜单权限', 175, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '172.27.181.221', '2023-04-17 20:07:19');
INSERT INTO `sys_log` VALUES ('1647934768738553857', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 171, 'com.company.project.controller.sys.PermissionController.getAllMenusPermissionTree()', '[\"\"]', '172.27.181.221', '2023-04-17 20:07:21');
INSERT INTO `sys_log` VALUES ('1647934799201783810', '1', 'admin', '机构管理-树型组织列表', 2, 'com.company.project.controller.sys.DeptController.getTree()', '[null]', '172.27.181.221', '2023-04-17 20:07:28');
INSERT INTO `sys_log` VALUES ('1647934799331807233', '1', 'admin', '用户管理-分页获取用户列表', 16, 'com.company.project.controller.sys.UserController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '172.27.181.221', '2023-04-17 20:07:28');
INSERT INTO `sys_log` VALUES ('1647934800715927553', '1', 'admin', '机构管理-获取所有组织机构', 6, 'com.company.project.controller.sys.DeptController.getDeptAll()', NULL, '172.27.181.221', '2023-04-17 20:07:28');
INSERT INTO `sys_log` VALUES ('1647934806214660097', '1', 'admin', '机构管理-树型组织列表', 2, 'com.company.project.controller.sys.DeptController.getTree()', '[\"\"]', '172.27.181.221', '2023-04-17 20:07:30');
INSERT INTO `sys_log` VALUES ('1647934830914916353', '1', 'admin', '机构管理-获取所有组织机构', 3, 'com.company.project.controller.sys.DeptController.getDeptAll()', NULL, '172.27.181.221', '2023-04-17 20:07:36');
INSERT INTO `sys_log` VALUES ('1647935039917084674', '1', 'admin', '系统操作日志管理-分页查询系统操作日志', 36, 'com.company.project.controller.sys.SysLogController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '172.27.181.221', '2023-04-17 20:08:25');
INSERT INTO `sys_log` VALUES ('1647936045719572481', '1', 'admin', '系统操作日志管理-分页查询系统操作日志', 9, 'com.company.project.controller.sys.SysLogController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '172.27.181.221', '2023-04-17 20:12:25');
INSERT INTO `sys_log` VALUES ('1647936220475248642', '1', 'admin', '系统操作日志管理-分页查询系统操作日志', 7, 'com.company.project.controller.sys.SysLogController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '172.27.181.221', '2023-04-17 20:13:07');
INSERT INTO `sys_log` VALUES ('1647946108433657858', '1', 'admin', '机构管理-获取所有组织机构', 8, 'com.company.project.controller.sys.DeptController.getDeptAll()', NULL, '172.27.181.221', '2023-04-17 20:52:24');
INSERT INTO `sys_log` VALUES ('1647946119624060930', '1', 'admin', '机构管理-树型组织列表', 18, 'com.company.project.controller.sys.DeptController.getTree()', '[null]', '172.27.181.221', '2023-04-17 20:52:27');
INSERT INTO `sys_log` VALUES ('1647946119733112833', '1', 'admin', '用户管理-分页获取用户列表', 43, 'com.company.project.controller.sys.UserController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '172.27.181.221', '2023-04-17 20:52:27');
INSERT INTO `sys_log` VALUES ('1647946136577437697', '1', 'admin', '角色管理-分页获取角色信息', 12, 'com.company.project.controller.sys.RoleController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '172.27.181.221', '2023-04-17 20:52:31');
INSERT INTO `sys_log` VALUES ('1647946151857287170', '1', 'admin', '菜单权限管理-获取所有菜单权限', 190, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '172.27.181.221', '2023-04-17 20:52:35');
INSERT INTO `sys_log` VALUES ('1647946173730582529', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 168, 'com.company.project.controller.sys.PermissionController.getAllMenusPermissionTree()', '[\"17\"]', '172.27.181.221', '2023-04-17 20:52:40');
INSERT INTO `sys_log` VALUES ('1647952185883734017', '1', 'admin', '系统操作日志管理-分页查询系统操作日志', 37, 'com.company.project.controller.sys.SysLogController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '172.27.181.221', '2023-04-17 21:16:33');
INSERT INTO `sys_log` VALUES ('1647955107484815362', '1', 'admin', '系统操作日志管理-分页查询系统操作日志', 18, 'com.company.project.controller.sys.SysLogController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '172.27.181.221', '2023-04-17 21:28:10');
INSERT INTO `sys_log` VALUES ('1647955123096014849', '1', 'admin', '系统操作日志管理-分页查询系统操作日志', 17, 'com.company.project.controller.sys.SysLogController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '172.27.181.221', '2023-04-17 21:28:14');
INSERT INTO `sys_log` VALUES ('1647963957634125826', '1', 'admin', '机构管理-获取所有组织机构', 11, 'com.company.project.controller.sys.DeptController.getDeptAll()', NULL, '172.27.181.221', '2023-04-17 22:03:20');

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
INSERT INTO `sys_permission` VALUES ('1651163911873646593', '承运结算', NULL, NULL, 'index/carrierBilling', '_self', '21', 10, 2, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1651163911873646594', '新增', 'carrierBilling:add', NULL, 'carrierBilling/add', NULL, '1651163911873646593', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1651163911873646595', '修改', 'carrierBilling:update', NULL, 'carrierBilling/update', NULL, '1651163911873646593', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1651163911873646596', '删除', 'carrierBilling:delete', NULL, 'carrierBilling/delete', NULL, '1651163911873646593', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1651163911873646597', '列表', 'carrierBilling:list', NULL, 'carrierBilling/listByPage', NULL, '1651163911873646593', NULL, 3, 1, NULL, NULL, 1);
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
INSERT INTO `sys_role_permission` VALUES ('1651163911873646598', '1', '1651163911873646593', NULL);
INSERT INTO `sys_role_permission` VALUES ('1651163911873646599', '1', '1651163911873646594', NULL);
INSERT INTO `sys_role_permission` VALUES ('1651163911873646600', '1', '1651163911873646595', NULL);
INSERT INTO `sys_role_permission` VALUES ('1651163911873646601', '1', '1651163911873646596', NULL);
INSERT INTO `sys_role_permission` VALUES ('1651163911873646602', '1', '1651163911873646597', NULL);
INSERT INTO `sys_role_permission` VALUES ('1651521115941531655', '1', '1651521115941531650', NULL);
INSERT INTO `sys_role_permission` VALUES ('1651521115941531656', '1', '1651521115941531651', NULL);
INSERT INTO `sys_role_permission` VALUES ('1651521115941531657', '1', '1651521115941531652', NULL);
INSERT INTO `sys_role_permission` VALUES ('1651521115941531658', '1', '1651521115941531653', NULL);
INSERT INTO `sys_role_permission` VALUES ('1651521115941531659', '1', '1651521115941531654', NULL);
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
