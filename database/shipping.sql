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

 Date: 29/04/2023 01:13:12
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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of carrier
-- ----------------------------
INSERT INTO `carrier` VALUES (1, '顺丰速运', '李四', 'sf-express@qq.com', '400-811-1111');
INSERT INTO `carrier` VALUES (2, '圆通速递', '王五', 'yuantong-express@qq.com', '95554');
INSERT INTO `carrier` VALUES (3, '中通快递', '张三', 'zhongtong-express@qq.com', '95311');

-- ----------------------------
-- Table structure for carrier_billing
-- ----------------------------
DROP TABLE IF EXISTS `carrier_billing`;
CREATE TABLE `carrier_billing`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '账单id',
  `carrier_id` int NULL DEFAULT NULL COMMENT '承运人',
  `order_id` int NULL DEFAULT NULL COMMENT '运单',
  `billing_date` datetime(0) NULL DEFAULT NULL COMMENT '结算日期',
  `freight_charge` decimal(10, 2) NULL DEFAULT NULL COMMENT '金额',
  `state` int NULL DEFAULT 0 COMMENT '状态',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `payment_method` int NULL DEFAULT NULL COMMENT '支付方式',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `carrier_id`(`carrier_id`) USING BTREE,
  INDEX `carriers_billing_ibfk_2`(`order_id`) USING BTREE,
  CONSTRAINT `carrier_billing_ibfk_1` FOREIGN KEY (`carrier_id`) REFERENCES `carrier` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `carrier_billing_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `shipment` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of carrier_billing
-- ----------------------------
INSERT INTO `carrier_billing` VALUES (5, 2, 12, '2023-04-28 00:00:00', 24000.00, 1, NULL, NULL);
INSERT INTO `carrier_billing` VALUES (6, 2, 13, '2023-04-28 14:08:34', 240.00, 1, '2023-04-28 14:07:07', NULL);

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
  `send_id` int NULL DEFAULT NULL COMMENT '发货人',
  `order_id` int NULL DEFAULT NULL COMMENT '运单',
  `payment_date` datetime(0) NULL DEFAULT NULL COMMENT '结算日期',
  `payment_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '金额',
  `payment_method` int NULL DEFAULT NULL COMMENT '支付方式',
  `state` int NULL DEFAULT 0 COMMENT '状态',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `customer_id`(`send_id`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE,
  CONSTRAINT `customer_billing_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `shipment` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of customer_billing
-- ----------------------------
INSERT INTO `customer_billing` VALUES (1, 2, 13, '2023-04-28 14:14:16', 320.00, 1, 1, '2023-04-28 14:07:07');

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
INSERT INTO `goods` VALUES (1, '服装', 99.99, 0.30, '50×30×5');
INSERT INTO `goods` VALUES (2, '家具', 1999.99, 20.00, '200×100×80');
INSERT INTO `goods` VALUES (3, '电子设备', 299.99, 0.10, '10×10×5');
INSERT INTO `goods` VALUES (4, '食品', 39.99, 1.00, '20×20×10');
INSERT INTO `goods` VALUES (5, '日用品', 49.99, 0.05, '5×5×5');

-- ----------------------------
-- Table structure for shipment
-- ----------------------------
DROP TABLE IF EXISTS `shipment`;
CREATE TABLE `shipment`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NULL DEFAULT NULL COMMENT '客户id',
  `carrier_id` int NULL DEFAULT NULL COMMENT '承运方id',
  `send_id` int NULL DEFAULT NULL COMMENT '发货人id',
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
  `pickup_date` datetime(0) NULL DEFAULT NULL COMMENT '发货日期',
  `delivery_date` datetime(0) NULL DEFAULT NULL COMMENT '收货日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `carrier_id`(`carrier_id`) USING BTREE,
  INDEX `shipment_type_id`(`shipment_type_id`) USING BTREE,
  INDEX `shipment_ibfk_1`(`customer_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shipment
-- ----------------------------
INSERT INTO `shipment` VALUES (12, 2, 2, 1, 2, '上海市徐汇区虹桥路1234号', '上海市', '中国', '200000', '北京市朝阳区建国路555号', '北京市', '中国', '100000', '无', 2, 100, 2000.00, 199999.00, '1', '2023-04-28 00:00:00', NULL);
INSERT INTO `shipment` VALUES (13, 2, 2, 1, 2, '上海市徐汇区虹桥路1234号', '上海市', '中国', '200000', '北京市朝阳区建国路555号', '北京市', '中国', '100000', '很好吃的', 4, 20, 20.00, 799.80, '1', '2023-04-28 14:07:07', NULL);

-- ----------------------------
-- Table structure for shipment_event
-- ----------------------------
DROP TABLE IF EXISTS `shipment_event`;
CREATE TABLE `shipment_event`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '事件ID',
  `order_id` int NOT NULL COMMENT '运单ID',
  `event_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '事件类型',
  `event_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地点',
  `event_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `event_date` datetime(0) NULL DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `shipment_events_ibfk_1`(`order_id`) USING BTREE,
  CONSTRAINT `shipment_event_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `shipment` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shipment_event
-- ----------------------------
INSERT INTO `shipment_event` VALUES (1, 12, '1', '河北', '到达下一站点', '2023-04-28 22:13:08');
INSERT INTO `shipment_event` VALUES (2, 13, '1', '湖南', '已运达中转站', '2023-04-29 00:30:29');

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
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

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
INSERT INTO `sys_dept` VALUES ('1651997029803298818', 'D000002', '运输部门', '1', 1, 'D000001D000002', NULL, '祁麟', '13777777777', '2023-04-29 01:09:19', '2023-04-29 01:09:19', 1);

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
INSERT INTO `sys_dict` VALUES ('1651791521230188546', 'shipment_state', '运单状态', '2023-04-28 11:32:42');
INSERT INTO `sys_dict` VALUES ('1651797499564523521', 'billing_state', '订单状态', '2023-04-28 11:56:27');
INSERT INTO `sys_dict` VALUES ('1651824738951778306', 'payway', '支付方式', '2023-04-28 13:44:42');
INSERT INTO `sys_dict` VALUES ('1651946591775199233', 'event_type', '事件类型', '2023-04-28 21:48:54');

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
INSERT INTO `sys_dict_detail` VALUES ('1', '已送达', '2', 3, '1651791521230188546', '2023-04-28 11:34:04');
INSERT INTO `sys_dict_detail` VALUES ('1255790073535885314', '男', '1', 1, '1255790029680242690', '2020-04-30 17:24:19');
INSERT INTO `sys_dict_detail` VALUES ('1255790100115189761', '女', '2', 2, '1255790029680242690', '2020-04-30 17:24:25');
INSERT INTO `sys_dict_detail` VALUES ('1282504475715350530', '诗词', '1', 1, '1282504369620430849', '2020-07-13 10:37:49');
INSERT INTO `sys_dict_detail` VALUES ('1282504651729317889', '散文', '2', 2, '1282504369620430849', '2020-07-13 10:38:31');
INSERT INTO `sys_dict_detail` VALUES ('1282846022950842369', '剧本', '3', 3, '1282504369620430849', '2020-07-14 09:15:01');
INSERT INTO `sys_dict_detail` VALUES ('1282846022950842370', 'java', '1', 1, '1255790029680242691', '2020-07-14 09:15:01');
INSERT INTO `sys_dict_detail` VALUES ('1282846022950842371', 'mysql', '2', 2, '1255790029680242691', '2020-07-14 09:15:01');
INSERT INTO `sys_dict_detail` VALUES ('1651791821194227714', '待揽收', '0', 1, '1651791521230188546', '2023-04-28 11:33:54');
INSERT INTO `sys_dict_detail` VALUES ('1651791864408141825', '运输中', '1', 2, '1651791521230188546', '2023-04-28 11:34:04');
INSERT INTO `sys_dict_detail` VALUES ('1651791923023540225', '已完成', '3', 4, '1651791521230188546', '2023-04-28 11:34:18');
INSERT INTO `sys_dict_detail` VALUES ('1651797547933237249', '待支付', '0', 1, '1651797499564523521', '2023-04-28 11:56:39');
INSERT INTO `sys_dict_detail` VALUES ('1651797582154563586', '已支付', '1', 2, '1651797499564523521', '2023-04-28 11:56:47');
INSERT INTO `sys_dict_detail` VALUES ('1651824795407110146', '支付宝', '1', 1, '1651824738951778306', '2023-04-28 13:44:55');
INSERT INTO `sys_dict_detail` VALUES ('1651824840953057281', '微信支付', '2', 2, '1651824738951778306', '2023-04-28 13:45:06');
INSERT INTO `sys_dict_detail` VALUES ('1651947330798981121', '抵达下一站点', '1', 1, '1651946591775199233', '2023-04-28 21:51:50');
INSERT INTO `sys_dict_detail` VALUES ('1651947399866585090', '突发事件', '2', 2, '1651946591775199233', '2023-04-28 21:52:06');

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
INSERT INTO `sys_job_log` VALUES ('1651750576036040706', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 08:50:00');
INSERT INTO `sys_job_log` VALUES ('1651750827606200321', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 08:51:00');
INSERT INTO `sys_job_log` VALUES ('1651751079264440321', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 08:52:00');
INSERT INTO `sys_job_log` VALUES ('1651751330935263233', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 08:53:00');
INSERT INTO `sys_job_log` VALUES ('1651751582597697538', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 08:54:00');
INSERT INTO `sys_job_log` VALUES ('1651751834268520449', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 08:55:00');
INSERT INTO `sys_job_log` VALUES ('1651752085893206018', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 08:56:00');
INSERT INTO `sys_job_log` VALUES ('1651752337559834625', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 08:57:00');
INSERT INTO `sys_job_log` VALUES ('1651752589209686018', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 08:58:00');
INSERT INTO `sys_job_log` VALUES ('1651752840872120321', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 08:59:00');
INSERT INTO `sys_job_log` VALUES ('1651753092547137537', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:00:00');
INSERT INTO `sys_job_log` VALUES ('1651753344196988930', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:01:00');
INSERT INTO `sys_job_log` VALUES ('1651753595888783362', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 09:02:00');
INSERT INTO `sys_job_log` VALUES ('1651753847509274625', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 09:03:00');
INSERT INTO `sys_job_log` VALUES ('1651754099159126017', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:04:00');
INSERT INTO `sys_job_log` VALUES ('1651754350846726146', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 09:05:00');
INSERT INTO `sys_job_log` VALUES ('1651754602517549058', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:06:00');
INSERT INTO `sys_job_log` VALUES ('1651754854179983361', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:07:00');
INSERT INTO `sys_job_log` VALUES ('1651755105817251842', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 09:08:00');
INSERT INTO `sys_job_log` VALUES ('1651755357441937410', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:09:00');
INSERT INTO `sys_job_log` VALUES ('1651755609142120450', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:10:00');
INSERT INTO `sys_job_log` VALUES ('1651755860804554753', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:11:00');
INSERT INTO `sys_job_log` VALUES ('1651756112441823234', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 09:12:00');
INSERT INTO `sys_job_log` VALUES ('1651756364133617666', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:13:00');
INSERT INTO `sys_job_log` VALUES ('1651756615745720322', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:14:00');
INSERT INTO `sys_job_log` VALUES ('1651756867433320449', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 09:15:00');
INSERT INTO `sys_job_log` VALUES ('1651757119062200321', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:16:00');
INSERT INTO `sys_job_log` VALUES ('1651757370728828930', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 09:17:00');
INSERT INTO `sys_job_log` VALUES ('1651757622374486017', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:18:00');
INSERT INTO `sys_job_log` VALUES ('1651757874074669057', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:19:00');
INSERT INTO `sys_job_log` VALUES ('1651758125724520449', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:20:00');
INSERT INTO `sys_job_log` VALUES ('1651758377357594626', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:21:00');
INSERT INTO `sys_job_log` VALUES ('1651758629024223234', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:22:00');
INSERT INTO `sys_job_log` VALUES ('1651758880669880322', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 09:23:00');
INSERT INTO `sys_job_log` VALUES ('1651759132365869057', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 09:24:00');
INSERT INTO `sys_job_log` VALUES ('1651759384032497665', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 09:25:00');
INSERT INTO `sys_job_log` VALUES ('1651759635686543361', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:26:00');
INSERT INTO `sys_job_log` VALUES ('1651759887323811841', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:27:00');
INSERT INTO `sys_job_log` VALUES ('1651760138998829058', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:28:00');
INSERT INTO `sys_job_log` VALUES ('1651760390623514626', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:29:00');
INSERT INTO `sys_job_log` VALUES ('1651760642319503361', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:30:00');
INSERT INTO `sys_job_log` VALUES ('1651760893965160449', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 09:31:00');
INSERT INTO `sys_job_log` VALUES ('1651761145619206145', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:32:00');
INSERT INTO `sys_job_log` VALUES ('1651761397235503105', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 09:33:00');
INSERT INTO `sys_job_log` VALUES ('1651761648906326017', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:34:00');
INSERT INTO `sys_job_log` VALUES ('1651761900614897666', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:35:00');
INSERT INTO `sys_job_log` VALUES ('1651762152239583233', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 09:36:00');
INSERT INTO `sys_job_log` VALUES ('1651762403922989058', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 09:37:00');
INSERT INTO `sys_job_log` VALUES ('1651762655564451842', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 09:38:00');
INSERT INTO `sys_job_log` VALUES ('1651762907205914626', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:39:00');
INSERT INTO `sys_job_log` VALUES ('1651763158893514754', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:40:00');
INSERT INTO `sys_job_log` VALUES ('1651763410534977537', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 09:41:00');
INSERT INTO `sys_job_log` VALUES ('1651763662176440322', '1252884495040782337', 'testTask', '1', 0, NULL, 2, '2023-04-28 09:42:00');
INSERT INTO `sys_job_log` VALUES ('1651764165589454849', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:44:00');
INSERT INTO `sys_job_log` VALUES ('1651764417147031553', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:45:00');
INSERT INTO `sys_job_log` VALUES ('1651764668801077250', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:46:00');
INSERT INTO `sys_job_log` VALUES ('1651764920455122945', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:47:00');
INSERT INTO `sys_job_log` VALUES ('1651765172146917378', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:48:00');
INSERT INTO `sys_job_log` VALUES ('1651765423830323201', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 09:49:00');
INSERT INTO `sys_job_log` VALUES ('1651765675442425857', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 09:50:00');
INSERT INTO `sys_job_log` VALUES ('1651765927348129793', '1252884495040782337', 'testTask', '1', 0, NULL, 39, '2023-04-28 09:51:00');
INSERT INTO `sys_job_log` VALUES ('1651766178825953281', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:52:00');
INSERT INTO `sys_job_log` VALUES ('1651766430404501506', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:53:00');
INSERT INTO `sys_job_log` VALUES ('1651766682092101634', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:54:00');
INSERT INTO `sys_job_log` VALUES ('1651766933746147329', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 09:55:00');
INSERT INTO `sys_job_log` VALUES ('1651767185404387330', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:56:00');
INSERT INTO `sys_job_log` VALUES ('1651767437079404545', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:57:00');
INSERT INTO `sys_job_log` VALUES ('1651767688708284417', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:58:00');
INSERT INTO `sys_job_log` VALUES ('1651767940379107330', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 09:59:00');
INSERT INTO `sys_job_log` VALUES ('1651768192045735937', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:00:00');
INSERT INTO `sys_job_log` VALUES ('1651770205324238850', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:08:00');
INSERT INTO `sys_job_log` VALUES ('1651770457011830786', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:09:00');
INSERT INTO `sys_job_log` VALUES ('1651770708594573314', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:10:00');
INSERT INTO `sys_job_log` VALUES ('1651770960269590530', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:11:00');
INSERT INTO `sys_job_log` VALUES ('1651771211948802050', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:12:00');
INSERT INTO `sys_job_log` VALUES ('1651771463569293314', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 10:13:00');
INSERT INTO `sys_job_log` VALUES ('1651771715244310530', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 10:14:00');
INSERT INTO `sys_job_log` VALUES ('1651771966919327746', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 10:15:00');
INSERT INTO `sys_job_log` VALUES ('1651772218564984834', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:16:00');
INSERT INTO `sys_job_log` VALUES ('1651772470223224833', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:17:00');
INSERT INTO `sys_job_log` VALUES ('1651772721915019265', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:18:00');
INSERT INTO `sys_job_log` VALUES ('1651772973518733313', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:19:00');
INSERT INTO `sys_job_log` VALUES ('1651773225214722050', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 10:20:00');
INSERT INTO `sys_job_log` VALUES ('1651773476872962050', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:21:00');
INSERT INTO `sys_job_log` VALUES ('1651773728506036225', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 10:22:00');
INSERT INTO `sys_job_log` VALUES ('1651773980202024962', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:23:00');
INSERT INTO `sys_job_log` VALUES ('1651774231847682049', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 10:24:00');
INSERT INTO `sys_job_log` VALUES ('1651774483526893570', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 10:25:00');
INSERT INTO `sys_job_log` VALUES ('1651774735176744962', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:26:00');
INSERT INTO `sys_job_log` VALUES ('1651774986818207745', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:27:00');
INSERT INTO `sys_job_log` VALUES ('1651775238484836354', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:28:00');
INSERT INTO `sys_job_log` VALUES ('1651775490189213697', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:29:00');
INSERT INTO `sys_job_log` VALUES ('1651775741771956225', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 10:30:00');
INSERT INTO `sys_job_log` VALUES ('1651775993421807617', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 10:31:00');
INSERT INTO `sys_job_log` VALUES ('1651776245117796353', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:32:00');
INSERT INTO `sys_job_log` VALUES ('1651776496742481922', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:33:00');
INSERT INTO `sys_job_log` VALUES ('1651776748438470658', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 10:34:00');
INSERT INTO `sys_job_log` VALUES ('1651777000063156226', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:35:00');
INSERT INTO `sys_job_log` VALUES ('1651777251746562049', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 10:36:00');
INSERT INTO `sys_job_log` VALUES ('1651777503408996354', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 10:37:00');
INSERT INTO `sys_job_log` VALUES ('1651777755079819266', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:38:00');
INSERT INTO `sys_job_log` VALUES ('1651778006683533313', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 10:39:00');
INSERT INTO `sys_job_log` VALUES ('1651778258387910658', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 10:40:00');
INSERT INTO `sys_job_log` VALUES ('1651778509995819010', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 10:41:00');
INSERT INTO `sys_job_log` VALUES ('1651778761654059010', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 10:42:00');
INSERT INTO `sys_job_log` VALUES ('1651779013371019265', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:43:00');
INSERT INTO `sys_job_log` VALUES ('1651779516700139522', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:45:00');
INSERT INTO `sys_job_log` VALUES ('1651779768320630786', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:46:00');
INSERT INTO `sys_job_log` VALUES ('1651780019978870785', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:47:00');
INSERT INTO `sys_job_log` VALUES ('1651780271611944962', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:48:00');
INSERT INTO `sys_job_log` VALUES ('1651780775058440193', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:50:00');
INSERT INTO `sys_job_log` VALUES ('1651781026632794113', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:51:00');
INSERT INTO `sys_job_log` VALUES ('1651781278257479681', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:52:00');
INSERT INTO `sys_job_log` VALUES ('1651781781641011202', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:54:00');
INSERT INTO `sys_job_log` VALUES ('1651782033261502465', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:55:00');
INSERT INTO `sys_job_log` VALUES ('1651782284890382338', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:56:00');
INSERT INTO `sys_job_log` VALUES ('1651782536565399554', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:57:00');
INSERT INTO `sys_job_log` VALUES ('1651782788232028161', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:58:00');
INSERT INTO `sys_job_log` VALUES ('1651783039915433985', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 10:59:00');
INSERT INTO `sys_job_log` VALUES ('1651783291569524737', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 11:00:00');
INSERT INTO `sys_job_log` VALUES ('1651783543206793217', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:01:00');
INSERT INTO `sys_job_log` VALUES ('1651783794852450306', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 11:02:00');
INSERT INTO `sys_job_log` VALUES ('1651784046531661826', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 11:03:00');
INSERT INTO `sys_job_log` VALUES ('1651784298198290434', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:04:00');
INSERT INTO `sys_job_log` VALUES ('1651784549860724737', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:05:00');
INSERT INTO `sys_job_log` VALUES ('1651784801539960834', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:06:00');
INSERT INTO `sys_job_log` VALUES ('1651785053152063489', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:07:00');
INSERT INTO `sys_job_log` VALUES ('1651785304789331970', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:08:00');
INSERT INTO `sys_job_log` VALUES ('1651785556481126402', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:09:00');
INSERT INTO `sys_job_log` VALUES ('1651785808206442497', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 11:10:00');
INSERT INTO `sys_job_log` VALUES ('1651786059776602113', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 11:11:00');
INSERT INTO `sys_job_log` VALUES ('1651786311405481985', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 11:12:00');
INSERT INTO `sys_job_log` VALUES ('1651786563172810754', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 11:13:00');
INSERT INTO `sys_job_log` VALUES ('1651786814751358977', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:14:00');
INSERT INTO `sys_job_log` VALUES ('1651787066422181890', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:15:00');
INSERT INTO `sys_job_log` VALUES ('1651787328360615938', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:16:02');
INSERT INTO `sys_job_log` VALUES ('1651787569721839617', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:17:00');
INSERT INTO `sys_job_log` VALUES ('1651787821417828353', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:18:00');
INSERT INTO `sys_job_log` VALUES ('1651788073013153794', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:19:00');
INSERT INTO `sys_job_log` VALUES ('1651788324713336834', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:20:00');
INSERT INTO `sys_job_log` VALUES ('1651788576421933058', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:21:00');
INSERT INTO `sys_job_log` VALUES ('1651788827983704066', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 11:22:00');
INSERT INTO `sys_job_log` VALUES ('1651789079650332674', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 11:23:00');
INSERT INTO `sys_job_log` VALUES ('1651789331312766978', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:24:00');
INSERT INTO `sys_job_log` VALUES ('1651789582979395586', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:25:00');
INSERT INTO `sys_job_log` VALUES ('1651789834662801409', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:26:00');
INSERT INTO `sys_job_log` VALUES ('1651790086316847106', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 11:27:00');
INSERT INTO `sys_job_log` VALUES ('1651790337991864321', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 11:28:00');
INSERT INTO `sys_job_log` VALUES ('1651790589612355585', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 11:29:00');
INSERT INTO `sys_job_log` VALUES ('1651790841266401282', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:30:00');
INSERT INTO `sys_job_log` VALUES ('1651791092928835585', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 11:31:00');
INSERT INTO `sys_job_log` VALUES ('1651791344620630017', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 11:32:00');
INSERT INTO `sys_job_log` VALUES ('1651791596283064321', '1252884495040782337', 'testTask', '1', 0, NULL, 2, '2023-04-28 11:33:00');
INSERT INTO `sys_job_log` VALUES ('1651791847945498625', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:34:00');
INSERT INTO `sys_job_log` VALUES ('1651792099549212674', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 11:35:00');
INSERT INTO `sys_job_log` VALUES ('1651797384447655937', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:56:00');
INSERT INTO `sys_job_log` VALUES ('1651797636084924417', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:57:00');
INSERT INTO `sys_job_log` VALUES ('1651797887734775810', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:58:00');
INSERT INTO `sys_job_log` VALUES ('1651798139388821506', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 11:59:00');
INSERT INTO `sys_job_log` VALUES ('1651798391042867202', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 12:00:00');
INSERT INTO `sys_job_log` VALUES ('1651798642684329986', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 12:01:00');
INSERT INTO `sys_job_log` VALUES ('1651798894363541505', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 12:02:00');
INSERT INTO `sys_job_log` VALUES ('1651799146239885314', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 12:03:00');
INSERT INTO `sys_job_log` VALUES ('1651799397667438593', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 12:04:00');
INSERT INTO `sys_job_log` VALUES ('1651799649313095682', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 12:05:00');
INSERT INTO `sys_job_log` VALUES ('1651799901017477122', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 12:06:00');
INSERT INTO `sys_job_log` VALUES ('1651800152663134209', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 12:07:00');
INSERT INTO `sys_job_log` VALUES ('1651800907713351681', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 12:10:00');
INSERT INTO `sys_job_log` VALUES ('1651801159270928386', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 12:11:00');
INSERT INTO `sys_job_log` VALUES ('1651801413131177986', '1252884495040782337', 'testTask', '1', 0, NULL, 2, '2023-04-28 12:12:01');
INSERT INTO `sys_job_log` VALUES ('1651801662574825474', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 12:13:00');
INSERT INTO `sys_job_log` VALUES ('1651802165991993346', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 12:15:00');
INSERT INTO `sys_job_log` VALUES ('1651802669316861954', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 12:17:00');
INSERT INTO `sys_job_log` VALUES ('1651802920966737922', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 12:18:00');
INSERT INTO `sys_job_log` VALUES ('1651803172520120322', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 12:19:00');
INSERT INTO `sys_job_log` VALUES ('1651803424165777409', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 12:20:00');
INSERT INTO `sys_job_log` VALUES ('1651803675836600321', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 12:21:00');
INSERT INTO `sys_job_log` VALUES ('1651803927582994434', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 12:22:00');
INSERT INTO `sys_job_log` VALUES ('1651804179174125569', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 12:23:00');
INSERT INTO `sys_job_log` VALUES ('1651804430882656257', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 12:24:00');
INSERT INTO `sys_job_log` VALUES ('1651804682847006721', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 12:25:00');
INSERT INTO `sys_job_log` VALUES ('1651804934152925186', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 12:26:00');
INSERT INTO `sys_job_log` VALUES ('1651808205731016706', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 12:39:00');
INSERT INTO `sys_job_log` VALUES ('1651808457326342145', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 12:40:00');
INSERT INTO `sys_job_log` VALUES ('1651808709047496706', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 12:41:00');
INSERT INTO `sys_job_log` VALUES ('1651808960651210753', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 12:42:00');
INSERT INTO `sys_job_log` VALUES ('1651812232246079490', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 12:55:00');
INSERT INTO `sys_job_log` VALUES ('1651812483879153666', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 12:56:00');
INSERT INTO `sys_job_log` VALUES ('1651812735520616450', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 12:57:00');
INSERT INTO `sys_job_log` VALUES ('1651812987224993793', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 12:58:00');
INSERT INTO `sys_job_log` VALUES ('1651813238866456577', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 12:59:00');
INSERT INTO `sys_job_log` VALUES ('1651813490516307970', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:00:00');
INSERT INTO `sys_job_log` VALUES ('1651813742166159362', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:01:00');
INSERT INTO `sys_job_log` VALUES ('1651813993824399362', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:02:00');
INSERT INTO `sys_job_log` VALUES ('1651814245495222273', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:03:00');
INSERT INTO `sys_job_log` VALUES ('1651814497388343298', '1252884495040782337', 'testTask', '1', 0, NULL, 6, '2023-04-28 13:04:00');
INSERT INTO `sys_job_log` VALUES ('1651814748782342145', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:05:00');
INSERT INTO `sys_job_log` VALUES ('1651815000495108097', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:06:00');
INSERT INTO `sys_job_log` VALUES ('1651815252199546881', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:07:00');
INSERT INTO `sys_job_log` VALUES ('1651815503773900802', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:08:00');
INSERT INTO `sys_job_log` VALUES ('1651815755469889537', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:09:00');
INSERT INTO `sys_job_log` VALUES ('1651816007128129537', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:10:00');
INSERT INTO `sys_job_log` VALUES ('1651816258777980929', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 13:11:00');
INSERT INTO `sys_job_log` VALUES ('1651816510423638017', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 13:12:00');
INSERT INTO `sys_job_log` VALUES ('1651816762077683713', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:13:00');
INSERT INTO `sys_job_log` VALUES ('1651817013710757889', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 13:14:00');
INSERT INTO `sys_job_log` VALUES ('1651817265478037506', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:15:00');
INSERT INTO `sys_job_log` VALUES ('1651817517073362946', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:16:00');
INSERT INTO `sys_job_log` VALUES ('1651817768698048514', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 13:17:00');
INSERT INTO `sys_job_log` VALUES ('1651818020377260034', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:18:00');
INSERT INTO `sys_job_log` VALUES ('1651818272006139906', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:19:00');
INSERT INTO `sys_job_log` VALUES ('1651818775410753537', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:21:00');
INSERT INTO `sys_job_log` VALUES ('1651819026972524546', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:22:00');
INSERT INTO `sys_job_log` VALUES ('1651819278689484802', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:23:00');
INSERT INTO `sys_job_log` VALUES ('1651819530322558978', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:24:00');
INSERT INTO `sys_job_log` VALUES ('1651819781951438850', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 13:25:00');
INSERT INTO `sys_job_log` VALUES ('1651820033634844674', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:26:00');
INSERT INTO `sys_job_log` VALUES ('1651820285318250497', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:27:00');
INSERT INTO `sys_job_log` VALUES ('1651820536938741761', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:28:00');
INSERT INTO `sys_job_log` VALUES ('1651820788630536193', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 13:29:00');
INSERT INTO `sys_job_log` VALUES ('1651821040271998977', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:30:00');
INSERT INTO `sys_job_log` VALUES ('1651821291921850370', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:31:00');
INSERT INTO `sys_job_log` VALUES ('1651821543567507458', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:32:00');
INSERT INTO `sys_job_log` VALUES ('1651821795271884802', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 13:33:00');
INSERT INTO `sys_job_log` VALUES ('1651822046879793154', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:34:00');
INSERT INTO `sys_job_log` VALUES ('1651822298584170497', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 13:35:00');
INSERT INTO `sys_job_log` VALUES ('1651822561495613442', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:36:03');
INSERT INTO `sys_job_log` VALUES ('1651822801896341505', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:37:00');
INSERT INTO `sys_job_log` VALUES ('1651824060237893633', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:42:00');
INSERT INTO `sys_job_log` VALUES ('1651824311854190593', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:43:00');
INSERT INTO `sys_job_log` VALUES ('1651824563466293249', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:44:00');
INSERT INTO `sys_job_log` VALUES ('1651824815170670594', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:45:00');
INSERT INTO `sys_job_log` VALUES ('1651825066820521985', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:46:00');
INSERT INTO `sys_job_log` VALUES ('1651825318461984769', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:47:00');
INSERT INTO `sys_job_log` VALUES ('1651825570229276673', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:48:00');
INSERT INTO `sys_job_log` VALUES ('1651825821803630593', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:49:00');
INSERT INTO `sys_job_log` VALUES ('1651826073537368065', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:50:00');
INSERT INTO `sys_job_log` VALUES ('1651826325103333378', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:51:00');
INSERT INTO `sys_job_log` VALUES ('1651826576740601858', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 13:52:00');
INSERT INTO `sys_job_log` VALUES ('1651826828407230466', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:53:00');
INSERT INTO `sys_job_log` VALUES ('1651827080052887553', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 13:54:00');
INSERT INTO `sys_job_log` VALUES ('1651827331723710465', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 13:55:00');
INSERT INTO `sys_job_log` VALUES ('1651827583377756162', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 13:56:00');
INSERT INTO `sys_job_log` VALUES ('1651827835023413249', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 13:57:00');
INSERT INTO `sys_job_log` VALUES ('1651828093543534593', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:58:02');
INSERT INTO `sys_job_log` VALUES ('1651828338365059073', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 13:59:00');
INSERT INTO `sys_job_log` VALUES ('1651828590023299073', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 14:00:00');
INSERT INTO `sys_job_log` VALUES ('1651828841660567554', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 14:01:00');
INSERT INTO `sys_job_log` VALUES ('1651829093310418945', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 14:02:00');
INSERT INTO `sys_job_log` VALUES ('1651829345006407681', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 14:03:00');
INSERT INTO `sys_job_log` VALUES ('1651829596673036290', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 14:04:00');
INSERT INTO `sys_job_log` VALUES ('1651829848280944642', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 14:05:00');
INSERT INTO `sys_job_log` VALUES ('1651830100014682114', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:06:00');
INSERT INTO `sys_job_log` VALUES ('1651830351710748674', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:07:00');
INSERT INTO `sys_job_log` VALUES ('1651830603293491201', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 14:08:00');
INSERT INTO `sys_job_log` VALUES ('1651830854968508418', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 14:09:00');
INSERT INTO `sys_job_log` VALUES ('1651831106626748417', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 14:10:00');
INSERT INTO `sys_job_log` VALUES ('1651831358268211201', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:11:00');
INSERT INTO `sys_job_log` VALUES ('1651831609934839809', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 14:12:00');
INSERT INTO `sys_job_log` VALUES ('1651831861580496897', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:13:00');
INSERT INTO `sys_job_log` VALUES ('1651832113284841473', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:14:00');
INSERT INTO `sys_job_log` VALUES ('1651832364871778305', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 14:15:00');
INSERT INTO `sys_job_log` VALUES ('1651832616550989825', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:16:00');
INSERT INTO `sys_job_log` VALUES ('1651832868246978562', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:17:00');
INSERT INTO `sys_job_log` VALUES ('1651833119884247042', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:18:00');
INSERT INTO `sys_job_log` VALUES ('1651833371529904129', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:19:00');
INSERT INTO `sys_job_log` VALUES ('1651833623209115649', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:20:00');
INSERT INTO `sys_job_log` VALUES ('1651833874825412610', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:21:00');
INSERT INTO `sys_job_log` VALUES ('1651834126525595649', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 14:22:00');
INSERT INTO `sys_job_log` VALUES ('1651834378137698306', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 14:23:00');
INSERT INTO `sys_job_log` VALUES ('1651834629812715522', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:24:00');
INSERT INTO `sys_job_log` VALUES ('1651835133234073601', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:26:00');
INSERT INTO `sys_job_log` VALUES ('1651835384812621825', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:27:00');
INSERT INTO `sys_job_log` VALUES ('1651835636441501698', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:28:00');
INSERT INTO `sys_job_log` VALUES ('1651835888082964481', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 14:29:00');
INSERT INTO `sys_job_log` VALUES ('1651836139737010177', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:30:00');
INSERT INTO `sys_job_log` VALUES ('1651836391441387521', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 14:31:00');
INSERT INTO `sys_job_log` VALUES ('1651836643120578562', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:32:00');
INSERT INTO `sys_job_log` VALUES ('1651836894749458434', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 14:33:00');
INSERT INTO `sys_job_log` VALUES ('1651837146457985026', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:34:00');
INSERT INTO `sys_job_log` VALUES ('1651837398065893378', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:35:00');
INSERT INTO `sys_job_log` VALUES ('1651838153099325441', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:38:00');
INSERT INTO `sys_job_log` VALUES ('1651838404715622402', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:39:00');
INSERT INTO `sys_job_log` VALUES ('1651838656348696577', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:40:00');
INSERT INTO `sys_job_log` VALUES ('1651838908019519489', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:41:00');
INSERT INTO `sys_job_log` VALUES ('1651839159673565186', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:42:00');
INSERT INTO `sys_job_log` VALUES ('1651839411352776706', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 14:43:00');
INSERT INTO `sys_job_log` VALUES ('1651839663023587329', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:44:00');
INSERT INTO `sys_job_log` VALUES ('1651839914610524161', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:45:00');
INSERT INTO `sys_job_log` VALUES ('1651840166268764161', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:46:00');
INSERT INTO `sys_job_log` VALUES ('1651840417922809858', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:47:00');
INSERT INTO `sys_job_log` VALUES ('1651840669627187201', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:48:00');
INSERT INTO `sys_job_log` VALUES ('1651840921277038593', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:49:00');
INSERT INTO `sys_job_log` VALUES ('1651841172956250114', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:50:00');
INSERT INTO `sys_job_log` VALUES ('1651841424669077506', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:51:00');
INSERT INTO `sys_job_log` VALUES ('1651841676268597250', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:52:00');
INSERT INTO `sys_job_log` VALUES ('1651841927880699906', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 14:53:00');
INSERT INTO `sys_job_log` VALUES ('1651844192850997249', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:02:00');
INSERT INTO `sys_job_log` VALUES ('1651844444454711297', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:03:00');
INSERT INTO `sys_job_log` VALUES ('1651844947989266433', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:05:00');
INSERT INTO `sys_job_log` VALUES ('1651845199441985537', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:06:00');
INSERT INTO `sys_job_log` VALUES ('1651845451117002754', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:07:00');
INSERT INTO `sys_job_log` VALUES ('1651845702766854146', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:08:00');
INSERT INTO `sys_job_log` VALUES ('1651846206079139842', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:10:00');
INSERT INTO `sys_job_log` VALUES ('1651846457783517185', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:11:00');
INSERT INTO `sys_job_log` VALUES ('1651846709424979969', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:12:00');
INSERT INTO `sys_job_log` VALUES ('1651846961091608578', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:13:00');
INSERT INTO `sys_job_log` VALUES ('1651847212703711234', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:14:00');
INSERT INTO `sys_job_log` VALUES ('1651847464361951234', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:15:00');
INSERT INTO `sys_job_log` VALUES ('1651847716028579842', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:16:00');
INSERT INTO `sys_job_log` VALUES ('1651847967732957185', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:17:00');
INSERT INTO `sys_job_log` VALUES ('1651848219374419969', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:18:00');
INSERT INTO `sys_job_log` VALUES ('1651848471041048577', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:19:00');
INSERT INTO `sys_job_log` VALUES ('1651848722665734146', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 15:20:00');
INSERT INTO `sys_job_log` VALUES ('1651848974344945666', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:21:00');
INSERT INTO `sys_job_log` VALUES ('1651849226011574273', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 15:22:00');
INSERT INTO `sys_job_log` VALUES ('1651849477648842754', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 15:23:00');
INSERT INTO `sys_job_log` VALUES ('1651849729311277057', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 15:24:00');
INSERT INTO `sys_job_log` VALUES ('1651849980965322754', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:25:00');
INSERT INTO `sys_job_log` VALUES ('1651850232623562753', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 15:26:00');
INSERT INTO `sys_job_log` VALUES ('1651850484298579969', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:27:00');
INSERT INTO `sys_job_log` VALUES ('1651850735923265537', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:28:00');
INSERT INTO `sys_job_log` VALUES ('1651850987610865665', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:29:00');
INSERT INTO `sys_job_log` VALUES ('1651851239273299969', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:30:00');
INSERT INTO `sys_job_log` VALUES ('1651851490931539969', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 15:31:00');
INSERT INTO `sys_job_log` VALUES ('1651851742598168578', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 15:32:00');
INSERT INTO `sys_job_log` VALUES ('1651851994248019969', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:33:00');
INSERT INTO `sys_job_log` VALUES ('1651852245881094146', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 15:34:00');
INSERT INTO `sys_job_log` VALUES ('1651852497581277185', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 15:35:00');
INSERT INTO `sys_job_log` VALUES ('1651852749222739969', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:36:00');
INSERT INTO `sys_job_log` VALUES ('1651853000872591362', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:37:00');
INSERT INTO `sys_job_log` VALUES ('1651853252535025666', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:38:00');
INSERT INTO `sys_job_log` VALUES ('1651853504159711234', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 15:39:00');
INSERT INTO `sys_job_log` VALUES ('1651853755868282881', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:40:00');
INSERT INTO `sys_job_log` VALUES ('1651854007497162753', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:41:00');
INSERT INTO `sys_job_log` VALUES ('1651854259142819842', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 15:42:00');
INSERT INTO `sys_job_log` VALUES ('1651854510788476929', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 15:43:00');
INSERT INTO `sys_job_log` VALUES ('1651854762442522625', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 15:44:00');
INSERT INTO `sys_job_log` VALUES ('1651855014130122754', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 15:45:00');
INSERT INTO `sys_job_log` VALUES ('1651855265775779842', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:46:00');
INSERT INTO `sys_job_log` VALUES ('1651855517421436929', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:47:00');
INSERT INTO `sys_job_log` VALUES ('1651855769096454146', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 15:48:00');
INSERT INTO `sys_job_log` VALUES ('1651856020733722625', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 15:49:00');
INSERT INTO `sys_job_log` VALUES ('1651856272446488578', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:50:00');
INSERT INTO `sys_job_log` VALUES ('1651856524054396929', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 15:51:00');
INSERT INTO `sys_job_log` VALUES ('1651856775712636930', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:52:00');
INSERT INTO `sys_job_log` VALUES ('1651857027412819969', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:53:00');
INSERT INTO `sys_job_log` VALUES ('1651857279029116929', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:54:00');
INSERT INTO `sys_job_log` VALUES ('1651857530704134146', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:55:00');
INSERT INTO `sys_job_log` VALUES ('1651857782395928578', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 15:56:00');
INSERT INTO `sys_job_log` VALUES ('1651858034008031233', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 15:57:00');
INSERT INTO `sys_job_log` VALUES ('1651858285687242753', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:58:00');
INSERT INTO `sys_job_log` VALUES ('1651858537320316930', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 15:59:00');
INSERT INTO `sys_job_log` VALUES ('1651858789007917057', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:00:00');
INSERT INTO `sys_job_log` VALUES ('1651859040661962753', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:01:00');
INSERT INTO `sys_job_log` VALUES ('1651859292328591362', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:02:00');
INSERT INTO `sys_job_log` VALUES ('1651859544003608577', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:03:00');
INSERT INTO `sys_job_log` VALUES ('1651859795632488450', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:04:00');
INSERT INTO `sys_job_log` VALUES ('1651860047450112002', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:05:00');
INSERT INTO `sys_job_log` VALUES ('1651860298965745665', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:06:00');
INSERT INTO `sys_job_log` VALUES ('1651860550594625538', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:07:00');
INSERT INTO `sys_job_log` VALUES ('1651860802252865538', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:08:00');
INSERT INTO `sys_job_log` VALUES ('1651861053911105538', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:09:00');
INSERT INTO `sys_job_log` VALUES ('1651861305602899969', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:10:00');
INSERT INTO `sys_job_log` VALUES ('1651861557273722882', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:11:00');
INSERT INTO `sys_job_log` VALUES ('1651861808902602754', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:12:00');
INSERT INTO `sys_job_log` VALUES ('1651862060548259841', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:13:00');
INSERT INTO `sys_job_log` VALUES ('1651862312214888449', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:14:00');
INSERT INTO `sys_job_log` VALUES ('1651862563856351234', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:15:00');
INSERT INTO `sys_job_log` VALUES ('1651862815543951362', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:16:00');
INSERT INTO `sys_job_log` VALUES ('1651863067206385665', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:17:00');
INSERT INTO `sys_job_log` VALUES ('1651863318856237057', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:18:00');
INSERT INTO `sys_job_log` VALUES ('1651863570501894146', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:19:00');
INSERT INTO `sys_job_log` VALUES ('1651863822168522753', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:20:00');
INSERT INTO `sys_job_log` VALUES ('1651864073801596930', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:21:00');
INSERT INTO `sys_job_log` VALUES ('1651864325518557185', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:22:00');
INSERT INTO `sys_job_log` VALUES ('1651864577168408578', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:23:00');
INSERT INTO `sys_job_log` VALUES ('1651864828784705537', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:24:00');
INSERT INTO `sys_job_log` VALUES ('1651865080472305666', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:25:00');
INSERT INTO `sys_job_log` VALUES ('1651865332117962753', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:26:00');
INSERT INTO `sys_job_log` VALUES ('1651865583797174274', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:27:00');
INSERT INTO `sys_job_log` VALUES ('1651865835430248449', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:28:00');
INSERT INTO `sys_job_log` VALUES ('1651866087126237186', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:29:00');
INSERT INTO `sys_job_log` VALUES ('1651866338725756930', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:30:00');
INSERT INTO `sys_job_log` VALUES ('1651866590417551362', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:31:00');
INSERT INTO `sys_job_log` VALUES ('1651866842168066050', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:32:00');
INSERT INTO `sys_job_log` VALUES ('1651867093734031361', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:33:00');
INSERT INTO `sys_job_log` VALUES ('1651867345430020097', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:34:00');
INSERT INTO `sys_job_log` VALUES ('1651867597218336770', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:35:00');
INSERT INTO `sys_job_log` VALUES ('1651867848683638785', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:36:00');
INSERT INTO `sys_job_log` VALUES ('1651868100379627522', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:37:00');
INSERT INTO `sys_job_log` VALUES ('1651868351991730177', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:38:00');
INSERT INTO `sys_job_log` VALUES ('1651868603666747393', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:39:00');
INSERT INTO `sys_job_log` VALUES ('1651868855345958913', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:40:00');
INSERT INTO `sys_job_log` VALUES ('1651869106974838786', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:41:00');
INSERT INTO `sys_job_log` VALUES ('1651869358670827521', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:42:00');
INSERT INTO `sys_job_log` VALUES ('1651869610282930178', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:43:00');
INSERT INTO `sys_job_log` VALUES ('1651869861970530305', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:44:00');
INSERT INTO `sys_job_log` VALUES ('1651870113658130434', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:45:00');
INSERT INTO `sys_job_log` VALUES ('1651870365291204610', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:46:00');
INSERT INTO `sys_job_log` VALUES ('1651870616924278785', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:47:00');
INSERT INTO `sys_job_log` VALUES ('1651870868582518785', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:48:00');
INSERT INTO `sys_job_log` VALUES ('1651871120282701826', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:49:00');
INSERT INTO `sys_job_log` VALUES ('1651871373455085569', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:50:00');
INSERT INTO `sys_job_log` VALUES ('1651871623557238785', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:51:00');
INSERT INTO `sys_job_log` VALUES ('1651871875219673090', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:52:00');
INSERT INTO `sys_job_log` VALUES ('1651872127024713729', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:53:00');
INSERT INTO `sys_job_log` VALUES ('1651872378573901825', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:54:00');
INSERT INTO `sys_job_log` VALUES ('1651872630194393089', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:55:00');
INSERT INTO `sys_job_log` VALUES ('1651872881840050178', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 16:56:00');
INSERT INTO `sys_job_log` VALUES ('1651873133498290177', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:57:00');
INSERT INTO `sys_job_log` VALUES ('1651873385198473218', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:58:00');
INSERT INTO `sys_job_log` VALUES ('1651873636839936001', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 16:59:00');
INSERT INTO `sys_job_log` VALUES ('1651873888565284865', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 17:00:00');
INSERT INTO `sys_job_log` VALUES ('1651874140135444481', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 17:01:00');
INSERT INTO `sys_job_log` VALUES ('1651874391844016130', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 17:02:00');
INSERT INTO `sys_job_log` VALUES ('1651874643481284610', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 17:03:00');
INSERT INTO `sys_job_log` VALUES ('1651874895131136001', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 17:04:00');
INSERT INTO `sys_job_log` VALUES ('1651875146839707649', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 17:05:00');
INSERT INTO `sys_job_log` VALUES ('1651875398468587522', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 17:06:00');
INSERT INTO `sys_job_log` VALUES ('1651875650105856002', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 17:07:00');
INSERT INTO `sys_job_log` VALUES ('1651875901797650434', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 17:08:00');
INSERT INTO `sys_job_log` VALUES ('1651876153409753089', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 17:09:00');
INSERT INTO `sys_job_log` VALUES ('1651876405109936129', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 17:10:00');
INSERT INTO `sys_job_log` VALUES ('1651876656726233090', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 17:11:00');
INSERT INTO `sys_job_log` VALUES ('1651876908371890178', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 17:12:00');
INSERT INTO `sys_job_log` VALUES ('1651877160046907393', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 17:13:00');
INSERT INTO `sys_job_log` VALUES ('1651877411688370177', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 17:14:00');
INSERT INTO `sys_job_log` VALUES ('1651877663363387394', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 17:15:00');
INSERT INTO `sys_job_log` VALUES ('1651877915030016002', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 17:16:00');
INSERT INTO `sys_job_log` VALUES ('1651878166713421825', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 17:17:00');
INSERT INTO `sys_job_log` VALUES ('1651878418325524482', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 17:18:00');
INSERT INTO `sys_job_log` VALUES ('1651878669987958785', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 17:19:00');
INSERT INTO `sys_job_log` VALUES ('1651878921692336129', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 17:20:00');
INSERT INTO `sys_job_log` VALUES ('1651879173337993218', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 17:21:00');
INSERT INTO `sys_job_log` VALUES ('1651879425008816130', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 17:22:00');
INSERT INTO `sys_job_log` VALUES ('1651879676650278913', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 17:23:00');
INSERT INTO `sys_job_log` VALUES ('1651879928291741697', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 17:24:00');
INSERT INTO `sys_job_log` VALUES ('1651880180008701953', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 17:25:00');
INSERT INTO `sys_job_log` VALUES ('1651880431620804610', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 17:26:00');
INSERT INTO `sys_job_log` VALUES ('1651880683249684482', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 17:27:00');
INSERT INTO `sys_job_log` VALUES ('1651880934941478913', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 17:28:00');
INSERT INTO `sys_job_log` VALUES ('1651881186603913218', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 17:29:00');
INSERT INTO `sys_job_log` VALUES ('1651881438249570305', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 17:30:00');
INSERT INTO `sys_job_log` VALUES ('1651881689924587522', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 17:31:00');
INSERT INTO `sys_job_log` VALUES ('1651881941582827522', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 17:32:00');
INSERT INTO `sys_job_log` VALUES ('1651882193241067521', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 17:33:00');
INSERT INTO `sys_job_log` VALUES ('1651882444878336002', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 17:34:00');
INSERT INTO `sys_job_log` VALUES ('1651882696561741825', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 17:35:00');
INSERT INTO `sys_job_log` VALUES ('1651882948203204610', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 17:36:00');
INSERT INTO `sys_job_log` VALUES ('1651883199874027521', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 17:37:00');
INSERT INTO `sys_job_log` VALUES ('1651883451532267522', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 17:38:00');
INSERT INTO `sys_job_log` VALUES ('1651883703144370178', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 17:39:00');
INSERT INTO `sys_job_log` VALUES ('1651883954819387393', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 17:40:00');
INSERT INTO `sys_job_log` VALUES ('1651887981359616002', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 17:56:00');
INSERT INTO `sys_job_log` VALUES ('1651888233001078786', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 17:57:00');
INSERT INTO `sys_job_log` VALUES ('1651888484701261825', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 17:58:00');
INSERT INTO `sys_job_log` VALUES ('1651888736330141698', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 17:59:00');
INSERT INTO `sys_job_log` VALUES ('1651888987984187393', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 18:00:00');
INSERT INTO `sys_job_log` VALUES ('1651889239638233089', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 18:01:00');
INSERT INTO `sys_job_log` VALUES ('1651889491283890177', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 18:02:00');
INSERT INTO `sys_job_log` VALUES ('1651889742975684609', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 18:03:00');
INSERT INTO `sys_job_log` VALUES ('1651889994625536001', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 18:04:00');
INSERT INTO `sys_job_log` VALUES ('1651890246287970305', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 18:05:00');
INSERT INTO `sys_job_log` VALUES ('1651902577575284737', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 18:54:00');
INSERT INTO `sys_job_log` VALUES ('1651902829204164609', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 18:55:00');
INSERT INTO `sys_job_log` VALUES ('1651903080841433089', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 18:56:00');
INSERT INTO `sys_job_log` VALUES ('1651903332482895873', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 18:57:00');
INSERT INTO `sys_job_log` VALUES ('1651903584283742209', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 18:58:00');
INSERT INTO `sys_job_log` VALUES ('1651903835832930305', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 18:59:00');
INSERT INTO `sys_job_log` VALUES ('1651904088250339329', '1252884495040782337', 'testTask', '1', 0, NULL, 2, '2023-04-28 19:00:00');
INSERT INTO `sys_job_log` VALUES ('1651904590891540481', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:02:00');
INSERT INTO `sys_job_log` VALUES ('1651904842478477313', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:03:00');
INSERT INTO `sys_job_log` VALUES ('1651905094115745794', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 19:04:00');
INSERT INTO `sys_job_log` VALUES ('1651905345790763009', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 19:05:00');
INSERT INTO `sys_job_log` VALUES ('1651905597440614402', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 19:06:00');
INSERT INTO `sys_job_log` VALUES ('1651906100845142018', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:08:00');
INSERT INTO `sys_job_log` VALUES ('1651906352625057793', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:09:00');
INSERT INTO `sys_job_log` VALUES ('1651906604094554114', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:10:00');
INSERT INTO `sys_job_log` VALUES ('1651906855706656769', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 19:11:00');
INSERT INTO `sys_job_log` VALUES ('1651907107381673985', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:12:00');
INSERT INTO `sys_job_log` VALUES ('1651907359069274113', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 19:13:00');
INSERT INTO `sys_job_log` VALUES ('1651907610534576129', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 19:14:00');
INSERT INTO `sys_job_log` VALUES ('1651907862071181313', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 19:15:00');
INSERT INTO `sys_job_log` VALUES ('1651908114027216897', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:16:00');
INSERT INTO `sys_job_log` VALUES ('1651908365706428417', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:17:00');
INSERT INTO `sys_job_log` VALUES ('1651908617335308289', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:18:00');
INSERT INTO `sys_job_log` VALUES ('1651908869018714114', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:19:00');
INSERT INTO `sys_job_log` VALUES ('1651909120475627521', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 19:20:00');
INSERT INTO `sys_job_log` VALUES ('1651909370187710465', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 19:21:00');
INSERT INTO `sys_job_log` VALUES ('1651909623959879681', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:22:00');
INSERT INTO `sys_job_log` VALUES ('1651909875651674114', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 19:23:00');
INSERT INTO `sys_job_log` VALUES ('1651910126735294465', '1252884495040782337', 'testTask', '1', 0, NULL, 4, '2023-04-28 19:24:00');
INSERT INTO `sys_job_log` VALUES ('1651910378955571202', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 19:25:00');
INSERT INTO `sys_job_log` VALUES ('1651910630592839682', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:26:00');
INSERT INTO `sys_job_log` VALUES ('1651910882288828417', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:27:00');
INSERT INTO `sys_job_log` VALUES ('1651912392276000770', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:33:00');
INSERT INTO `sys_job_log` VALUES ('1651912643888103426', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:34:00');
INSERT INTO `sys_job_log` VALUES ('1651912896313901058', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 19:35:00');
INSERT INTO `sys_job_log` VALUES ('1651913147204583426', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:36:00');
INSERT INTO `sys_job_log` VALUES ('1651913398854434817', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 19:37:00');
INSERT INTO `sys_job_log` VALUES ('1651913902208700418', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 19:39:00');
INSERT INTO `sys_job_log` VALUES ('1651914153850163201', '1252884495040782337', 'testTask', '1', 0, NULL, 5, '2023-04-28 19:40:00');
INSERT INTO `sys_job_log` VALUES ('1651914405550288898', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:41:00');
INSERT INTO `sys_job_log` VALUES ('1651914657133031426', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:42:00');
INSERT INTO `sys_job_log` VALUES ('1651914908795465730', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 19:43:00');
INSERT INTO `sys_job_log` VALUES ('1651915160483065857', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:44:00');
INSERT INTO `sys_job_log` VALUES ('1651915412128722945', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:45:00');
INSERT INTO `sys_job_log` VALUES ('1651915663786962945', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 19:46:00');
INSERT INTO `sys_job_log` VALUES ('1651915915399065602', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 19:47:00');
INSERT INTO `sys_job_log` VALUES ('1651916167086665730', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 19:48:00');
INSERT INTO `sys_job_log` VALUES ('1651916418749100033', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 19:49:00');
INSERT INTO `sys_job_log` VALUES ('1651916670394757122', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:50:00');
INSERT INTO `sys_job_log` VALUES ('1651916922069774337', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:51:00');
INSERT INTO `sys_job_log` VALUES ('1651917173925167105', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:52:00');
INSERT INTO `sys_job_log` VALUES ('1651917929340309505', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 19:55:00');
INSERT INTO `sys_job_log` VALUES ('1651918180373598209', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 19:56:00');
INSERT INTO `sys_job_log` VALUES ('1651918432015060994', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 19:57:00');
INSERT INTO `sys_job_log` VALUES ('1651918683681689602', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 19:58:00');
INSERT INTO `sys_job_log` VALUES ('1651918935314763777', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 19:59:00');
INSERT INTO `sys_job_log` VALUES ('1651919186956226562', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:00:00');
INSERT INTO `sys_job_log` VALUES ('1651919438748659714', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:01:00');
INSERT INTO `sys_job_log` VALUES ('1651919690255904769', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 20:02:00');
INSERT INTO `sys_job_log` VALUES ('1651919941981253634', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 20:03:00');
INSERT INTO `sys_job_log` VALUES ('1651920193698181121', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:04:00');
INSERT INTO `sys_job_log` VALUES ('1651920445251563522', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:05:00');
INSERT INTO `sys_job_log` VALUES ('1651920697052418049', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:06:00');
INSERT INTO `sys_job_log` VALUES ('1651920948572246018', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 20:07:00');
INSERT INTO `sys_job_log` VALUES ('1651921200243068929', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:08:00');
INSERT INTO `sys_job_log` VALUES ('1651921451901308929', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:09:00');
INSERT INTO `sys_job_log` VALUES ('1651921703660216321', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 20:10:00');
INSERT INTO `sys_job_log` VALUES ('1651921955196821506', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:11:00');
INSERT INTO `sys_job_log` VALUES ('1651922206867644418', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 20:12:00');
INSERT INTO `sys_job_log` VALUES ('1651922458538467330', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 20:13:00');
INSERT INTO `sys_job_log` VALUES ('1651922710288949249', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:14:00');
INSERT INTO `sys_job_log` VALUES ('1651922961871691778', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:15:00');
INSERT INTO `sys_job_log` VALUES ('1651923213487988738', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:16:00');
INSERT INTO `sys_job_log` VALUES ('1651923465175588865', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 20:17:00');
INSERT INTO `sys_job_log` VALUES ('1651923717005795330', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 20:18:00');
INSERT INTO `sys_job_log` VALUES ('1651923968575983618', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:19:00');
INSERT INTO `sys_job_log` VALUES ('1651924220150337538', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 20:20:00');
INSERT INTO `sys_job_log` VALUES ('1651924471833743362', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:21:00');
INSERT INTO `sys_job_log` VALUES ('1651924723491983362', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:22:00');
INSERT INTO `sys_job_log` VALUES ('1651924975213199362', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:23:00');
INSERT INTO `sys_job_log` VALUES ('1651925226804330497', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:24:00');
INSERT INTO `sys_job_log` VALUES ('1651925478420627458', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:25:00');
INSERT INTO `sys_job_log` VALUES ('1651925730183671809', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:26:00');
INSERT INTO `sys_job_log` VALUES ('1651925991325208578', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:27:02');
INSERT INTO `sys_job_log` VALUES ('1651926736854380546', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 20:30:00');
INSERT INTO `sys_job_log` VALUES ('1651926988403568642', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 20:31:00');
INSERT INTO `sys_job_log` VALUES ('1651927240045031426', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:32:00');
INSERT INTO `sys_job_log` VALUES ('1651927491707465729', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:33:00');
INSERT INTO `sys_job_log` VALUES ('1651927743386677249', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 20:34:00');
INSERT INTO `sys_job_log` VALUES ('1651928247135182849', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 20:36:00');
INSERT INTO `sys_job_log` VALUES ('1651928498348826625', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:37:00');
INSERT INTO `sys_job_log` VALUES ('1651928750074175489', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:38:00');
INSERT INTO `sys_job_log` VALUES ('1651929001686278145', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:39:00');
INSERT INTO `sys_job_log` VALUES ('1651929253344518145', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:40:00');
INSERT INTO `sys_job_log` VALUES ('1651929504973398017', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 20:41:00');
INSERT INTO `sys_job_log` VALUES ('1651929756640026625', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:42:00');
INSERT INTO `sys_job_log` VALUES ('1651930008394735618', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 20:43:00');
INSERT INTO `sys_job_log` VALUES ('1651930259922952193', '1252884495040782337', 'testTask', '1', 0, NULL, 3, '2023-04-28 20:44:00');
INSERT INTO `sys_job_log` VALUES ('1651930511631523842', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:45:00');
INSERT INTO `sys_job_log` VALUES ('1651930763272986626', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:46:00');
INSERT INTO `sys_job_log` VALUES ('1651931014935420929', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:47:00');
INSERT INTO `sys_job_log` VALUES ('1651931266568495105', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 20:48:00');
INSERT INTO `sys_job_log` VALUES ('1651931518251900930', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 20:49:00');
INSERT INTO `sys_job_log` VALUES ('1651932021614555138', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 20:51:00');
INSERT INTO `sys_job_log` VALUES ('1651933783343820801', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 20:58:00');
INSERT INTO `sys_job_log` VALUES ('1651934034804928514', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 20:59:00');
INSERT INTO `sys_job_log` VALUES ('1651934286496722945', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:00:00');
INSERT INTO `sys_job_log` VALUES ('1651934538121408514', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 21:01:00');
INSERT INTO `sys_job_log` VALUES ('1651935293213593601', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:04:00');
INSERT INTO `sys_job_log` VALUES ('1651935544754393089', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:05:00');
INSERT INTO `sys_job_log` VALUES ('1651935796454576129', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:06:00');
INSERT INTO `sys_job_log` VALUES ('1651936048087650305', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 21:07:00');
INSERT INTO `sys_job_log` VALUES ('1651936299720724481', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 21:08:00');
INSERT INTO `sys_job_log` VALUES ('1651936551395741697', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 21:09:00');
INSERT INTO `sys_job_log` VALUES ('1651936803037204481', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:10:00');
INSERT INTO `sys_job_log` VALUES ('1651937054720610306', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:11:00');
INSERT INTO `sys_job_log` VALUES ('1651937306391433217', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:12:00');
INSERT INTO `sys_job_log` VALUES ('1651937558007730177', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:13:00');
INSERT INTO `sys_job_log` VALUES ('1651937809686941697', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:14:00');
INSERT INTO `sys_job_log` VALUES ('1651938061378736129', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:15:00');
INSERT INTO `sys_job_log` VALUES ('1651938313028587521', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:16:00');
INSERT INTO `sys_job_log` VALUES ('1651938564699410433', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:17:00');
INSERT INTO `sys_job_log` VALUES ('1651938816319901697', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 21:18:00');
INSERT INTO `sys_job_log` VALUES ('1651939067978141698', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 21:19:00');
INSERT INTO `sys_job_log` VALUES ('1651939319636381697', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:20:00');
INSERT INTO `sys_job_log` VALUES ('1651939571290427393', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:21:00');
INSERT INTO `sys_job_log` VALUES ('1651939822986416130', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:22:00');
INSERT INTO `sys_job_log` VALUES ('1651940074585935873', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:23:00');
INSERT INTO `sys_job_log` VALUES ('1651940326395170818', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:24:00');
INSERT INTO `sys_job_log` VALUES ('1651940577931776001', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:25:00');
INSERT INTO `sys_job_log` VALUES ('1651940829577433090', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:26:00');
INSERT INTO `sys_job_log` VALUES ('1651941081252450305', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 21:27:00');
INSERT INTO `sys_job_log` VALUES ('1651941333019742210', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:28:00');
INSERT INTO `sys_job_log` VALUES ('1651941584547958786', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:29:00');
INSERT INTO `sys_job_log` VALUES ('1651941836248141825', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:30:00');
INSERT INTO `sys_job_log` VALUES ('1651942087910576130', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 21:31:00');
INSERT INTO `sys_job_log` VALUES ('1651942339573010433', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:32:00');
INSERT INTO `sys_job_log` VALUES ('1651942591218667521', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 21:33:00');
INSERT INTO `sys_job_log` VALUES ('1651942842843353089', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 21:34:00');
INSERT INTO `sys_job_log` VALUES ('1651943094509981697', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:35:00');
INSERT INTO `sys_job_log` VALUES ('1651943346159833089', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:36:00');
INSERT INTO `sys_job_log` VALUES ('1651943850197770241', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 21:38:00');
INSERT INTO `sys_job_log` VALUES ('1651944101168144386', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:39:00');
INSERT INTO `sys_job_log` VALUES ('1651944352809607170', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:40:00');
INSERT INTO `sys_job_log` VALUES ('1651944604497207297', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:41:00');
INSERT INTO `sys_job_log` VALUES ('1651944856205783041', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 21:42:00');
INSERT INTO `sys_job_log` VALUES ('1651945107750776834', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:43:00');
INSERT INTO `sys_job_log` VALUES ('1651945359530602497', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:44:00');
INSERT INTO `sys_job_log` VALUES ('1651945611125927937', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 21:45:00');
INSERT INTO `sys_job_log` VALUES ('1651945862746419202', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:46:00');
INSERT INTO `sys_job_log` VALUES ('1651946114459209730', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 21:47:00');
INSERT INTO `sys_job_log` VALUES ('1651946366100672513', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:48:00');
INSERT INTO `sys_job_log` VALUES ('1651946617750523906', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:49:00');
INSERT INTO `sys_job_log` VALUES ('1651946869412958209', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:50:00');
INSERT INTO `sys_job_log` VALUES ('1651947121033449473', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 21:51:00');
INSERT INTO `sys_job_log` VALUES ('1651947372712660993', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 21:52:00');
INSERT INTO `sys_job_log` VALUES ('1651947624383483905', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:53:00');
INSERT INTO `sys_job_log` VALUES ('1651947876008169474', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:54:00');
INSERT INTO `sys_job_log` VALUES ('1651948127737712642', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:55:00');
INSERT INTO `sys_job_log` VALUES ('1651948379316260866', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 21:56:00');
INSERT INTO `sys_job_log` VALUES ('1651948630970306561', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 21:57:00');
INSERT INTO `sys_job_log` VALUES ('1651948882666295297', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 21:58:00');
INSERT INTO `sys_job_log` VALUES ('1651949134286786561', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 21:59:00');
INSERT INTO `sys_job_log` VALUES ('1651949386033004546', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:00:00');
INSERT INTO `sys_job_log` VALUES ('1651949637640912898', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:01:00');
INSERT INTO `sys_job_log` VALUES ('1651949889273987073', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:02:00');
INSERT INTO `sys_job_log` VALUES ('1651950140944809985', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:03:00');
INSERT INTO `sys_job_log` VALUES ('1651950392879874050', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 22:04:00');
INSERT INTO `sys_job_log` VALUES ('1651950644508753922', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:05:00');
INSERT INTO `sys_job_log` VALUES ('1651950895911141377', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:06:00');
INSERT INTO `sys_job_log` VALUES ('1651951147674238977', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:07:00');
INSERT INTO `sys_job_log` VALUES ('1651951399248592897', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:08:00');
INSERT INTO `sys_job_log` VALUES ('1651951650864889858', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:09:00');
INSERT INTO `sys_job_log` VALUES ('1651951902644822018', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:10:00');
INSERT INTO `sys_job_log` VALUES ('1651952154235953154', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:11:00');
INSERT INTO `sys_job_log` VALUES ('1651952405898387457', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:12:00');
INSERT INTO `sys_job_log` VALUES ('1651952657518878722', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:13:00');
INSERT INTO `sys_job_log` VALUES ('1651952909294559234', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 22:14:00');
INSERT INTO `sys_job_log` VALUES ('1651953160831164418', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 22:15:00');
INSERT INTO `sys_job_log` VALUES ('1651953412493598722', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:16:00');
INSERT INTO `sys_job_log` VALUES ('1651953664193781761', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 22:17:00');
INSERT INTO `sys_job_log` VALUES ('1651953915805884418', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:18:00');
INSERT INTO `sys_job_log` VALUES ('1651954167459930114', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 22:19:00');
INSERT INTO `sys_job_log` VALUES ('1651954419130753025', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:20:00');
INSERT INTO `sys_job_log` VALUES ('1651954670814158849', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:21:00');
INSERT INTO `sys_job_log` VALUES ('1651954922434650114', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 22:22:00');
INSERT INTO `sys_job_log` VALUES ('1651955174105473025', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 22:23:00');
INSERT INTO `sys_job_log` VALUES ('1651955425759518722', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 22:24:00');
INSERT INTO `sys_job_log` VALUES ('1651955677447118849', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:25:00');
INSERT INTO `sys_job_log` VALUES ('1651955929096970241', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 22:26:00');
INSERT INTO `sys_job_log` VALUES ('1651956180738433025', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:27:00');
INSERT INTO `sys_job_log` VALUES ('1651956432400867329', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:28:00');
INSERT INTO `sys_job_log` VALUES ('1651956684054913026', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 22:29:00');
INSERT INTO `sys_job_log` VALUES ('1651956935738318849', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 22:30:00');
INSERT INTO `sys_job_log` VALUES ('1651957187367198722', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:31:00');
INSERT INTO `sys_job_log` VALUES ('1651957439058993153', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:32:00');
INSERT INTO `sys_job_log` VALUES ('1651957690671095810', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 22:33:00');
INSERT INTO `sys_job_log` VALUES ('1651957942375473153', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 22:34:00');
INSERT INTO `sys_job_log` VALUES ('1651958194008547329', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 22:35:00');
INSERT INTO `sys_job_log` VALUES ('1651958697333465089', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:37:00');
INSERT INTO `sys_job_log` VALUES ('1651958949004288001', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 22:38:00');
INSERT INTO `sys_job_log` VALUES ('1651959200624779266', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:39:00');
INSERT INTO `sys_job_log` VALUES ('1651959452333350914', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:40:00');
INSERT INTO `sys_job_log` VALUES ('1651960207316443137', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:43:00');
INSERT INTO `sys_job_log` VALUES ('1651960458936934401', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:44:00');
INSERT INTO `sys_job_log` VALUES ('1651960710599368706', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:45:00');
INSERT INTO `sys_job_log` VALUES ('1651960962249220097', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:46:00');
INSERT INTO `sys_job_log` VALUES ('1651961213899071490', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:47:00');
INSERT INTO `sys_job_log` VALUES ('1651961465544728578', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:48:00');
INSERT INTO `sys_job_log` VALUES ('1651961717257494529', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:49:00');
INSERT INTO `sys_job_log` VALUES ('1651961968861208577', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:50:00');
INSERT INTO `sys_job_log` VALUES ('1651962220523642882', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:51:00');
INSERT INTO `sys_job_log` VALUES ('1651962472177688578', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:52:00');
INSERT INTO `sys_job_log` VALUES ('1651962975489974273', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:54:00');
INSERT INTO `sys_job_log` VALUES ('1651963227181768706', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:55:00');
INSERT INTO `sys_job_log` VALUES ('1651963478584156161', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:56:00');
INSERT INTO `sys_job_log` VALUES ('1651963730582130690', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:57:00');
INSERT INTO `sys_job_log` VALUES ('1651963982173261825', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:58:00');
INSERT INTO `sys_job_log` VALUES ('1651964233814724610', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 22:59:00');
INSERT INTO `sys_job_log` VALUES ('1651964485498130434', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:00:00');
INSERT INTO `sys_job_log` VALUES ('1651964737152176129', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:01:00');
INSERT INTO `sys_job_log` VALUES ('1651964988793638914', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:02:00');
INSERT INTO `sys_job_log` VALUES ('1651965240426713089', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:03:00');
INSERT INTO `sys_job_log` VALUES ('1651965492177223682', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:04:00');
INSERT INTO `sys_job_log` VALUES ('1651965743789326337', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:05:00');
INSERT INTO `sys_job_log` VALUES ('1651965995388846081', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:06:00');
INSERT INTO `sys_job_log` VALUES ('1651966247164530690', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:07:00');
INSERT INTO `sys_job_log` VALUES ('1651966498743078913', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:08:00');
INSERT INTO `sys_job_log` VALUES ('1651966750426484737', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:09:00');
INSERT INTO `sys_job_log` VALUES ('1651967002067947522', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 23:10:00');
INSERT INTO `sys_job_log` VALUES ('1651967253675855873', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:11:00');
INSERT INTO `sys_job_log` VALUES ('1651967505338290177', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:12:00');
INSERT INTO `sys_job_log` VALUES ('1651967757025890306', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:13:00');
INSERT INTO `sys_job_log` VALUES ('1651968008654770177', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:14:00');
INSERT INTO `sys_job_log` VALUES ('1651968260333981697', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:15:00');
INSERT INTO `sys_job_log` VALUES ('1651968763860099073', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:17:00');
INSERT INTO `sys_job_log` VALUES ('1651969015337984001', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:18:00');
INSERT INTO `sys_job_log` VALUES ('1651969267231105025', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:19:00');
INSERT INTO `sys_job_log` VALUES ('1651969518654464002', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:20:00');
INSERT INTO `sys_job_log` VALUES ('1651969770379812865', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:21:00');
INSERT INTO `sys_job_log` VALUES ('1651970021970944002', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:22:00');
INSERT INTO `sys_job_log` VALUES ('1651970273591435265', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:23:00');
INSERT INTO `sys_job_log` VALUES ('1651970525333680129', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:24:00');
INSERT INTO `sys_job_log` VALUES ('1651970776903839745', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:25:00');
INSERT INTO `sys_job_log` VALUES ('1651971028662734850', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:26:00');
INSERT INTO `sys_job_log` VALUES ('1651971280241283073', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 23:27:00');
INSERT INTO `sys_job_log` VALUES ('1651971531878551553', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:28:00');
INSERT INTO `sys_job_log` VALUES ('1651972035266281473', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:30:00');
INSERT INTO `sys_job_log` VALUES ('1651972538599563265', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 23:32:00');
INSERT INTO `sys_job_log` VALUES ('1651972790203277314', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:33:00');
INSERT INTO `sys_job_log` VALUES ('1651973041844740098', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 23:34:00');
INSERT INTO `sys_job_log` VALUES ('1651973293565865985', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:35:00');
INSERT INTO `sys_job_log` VALUES ('1651973545131831298', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:36:00');
INSERT INTO `sys_job_log` VALUES ('1651973796852985858', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:37:00');
INSERT INTO `sys_job_log` VALUES ('1651974048477671426', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:38:00');
INSERT INTO `sys_job_log` VALUES ('1651974300152688641', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 23:39:00');
INSERT INTO `sys_job_log` VALUES ('1651974551789957121', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 23:40:00');
INSERT INTO `sys_job_log` VALUES ('1651974803536269313', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 23:41:00');
INSERT INTO `sys_job_log` VALUES ('1651975055102234625', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:42:00');
INSERT INTO `sys_job_log` VALUES ('1651975306794029057', '1252884495040782337', 'testTask', '1', 0, NULL, 2, '2023-04-28 23:43:00');
INSERT INTO `sys_job_log` VALUES ('1651975558485852162', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 23:44:00');
INSERT INTO `sys_job_log` VALUES ('1651975810081177602', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-28 23:45:00');
INSERT INTO `sys_job_log` VALUES ('1651976061764583425', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-28 23:46:00');
INSERT INTO `sys_job_log` VALUES ('1651981598199726082', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:08:00');
INSERT INTO `sys_job_log` VALUES ('1651981849891520513', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:09:00');
INSERT INTO `sys_job_log` VALUES ('1651982101541371905', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:10:00');
INSERT INTO `sys_job_log` VALUES ('1651982353195417602', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 00:11:00');
INSERT INTO `sys_job_log` VALUES ('1651982604891406338', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:12:00');
INSERT INTO `sys_job_log` VALUES ('1651982856524480514', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:13:00');
INSERT INTO `sys_job_log` VALUES ('1651983108308516866', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 00:14:00');
INSERT INTO `sys_job_log` VALUES ('1651983359819956226', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:15:00');
INSERT INTO `sys_job_log` VALUES ('1651983611574681602', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 00:16:00');
INSERT INTO `sys_job_log` VALUES ('1651983863253884930', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:17:00');
INSERT INTO `sys_job_log` VALUES ('1651984115008638978', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 00:18:00');
INSERT INTO `sys_job_log` VALUES ('1651984366452969474', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 00:19:00');
INSERT INTO `sys_job_log` VALUES ('1651984618153152514', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 00:20:00');
INSERT INTO `sys_job_log` VALUES ('1651984869798809601', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:21:00');
INSERT INTO `sys_job_log` VALUES ('1651985121415106561', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 00:22:00');
INSERT INTO `sys_job_log` VALUES ('1651985373085929473', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:23:00');
INSERT INTO `sys_job_log` VALUES ('1651985624735780866', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 00:24:00');
INSERT INTO `sys_job_log` VALUES ('1651985876431769602', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 00:25:00');
INSERT INTO `sys_job_log` VALUES ('1651986128069038082', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 00:26:00');
INSERT INTO `sys_job_log` VALUES ('1651986379710500865', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 00:27:00');
INSERT INTO `sys_job_log` VALUES ('1651986631364546562', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 00:28:00');
INSERT INTO `sys_job_log` VALUES ('1651986883047952386', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 00:29:00');
INSERT INTO `sys_job_log` VALUES ('1651987134706192385', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:30:00');
INSERT INTO `sys_job_log` VALUES ('1651987386360238082', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:31:00');
INSERT INTO `sys_job_log` VALUES ('1651987638010089473', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 00:32:00');
INSERT INTO `sys_job_log` VALUES ('1651987889685106690', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 00:33:00');
INSERT INTO `sys_job_log` VALUES ('1651988141443944449', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 00:34:00');
INSERT INTO `sys_job_log` VALUES ('1651988392997326850', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:35:00');
INSERT INTO `sys_job_log` VALUES ('1651988644693315585', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:36:00');
INSERT INTO `sys_job_log` VALUES ('1651988896305418242', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 00:37:00');
INSERT INTO `sys_job_log` VALUES ('1651989147963658241', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 00:38:00');
INSERT INTO `sys_job_log` VALUES ('1651989399613509633', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:39:00');
INSERT INTO `sys_job_log` VALUES ('1651989651322081282', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 00:40:00');
INSERT INTO `sys_job_log` VALUES ('1651989902976126977', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 00:41:00');
INSERT INTO `sys_job_log` VALUES ('1651990154625978370', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:42:00');
INSERT INTO `sys_job_log` VALUES ('1651990406246469633', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:43:00');
INSERT INTO `sys_job_log` VALUES ('1651990658043154433', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:44:00');
INSERT INTO `sys_job_log` VALUES ('1651990909558788098', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:45:00');
INSERT INTO `sys_job_log` VALUES ('1651991412938166273', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:47:00');
INSERT INTO `sys_job_log` VALUES ('1651991664567046145', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:48:00');
INSERT INTO `sys_job_log` VALUES ('1651991916208508930', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:49:00');
INSERT INTO `sys_job_log` VALUES ('1651992167841583106', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 00:50:00');
INSERT INTO `sys_job_log` VALUES ('1651992419545960449', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:51:00');
INSERT INTO `sys_job_log` VALUES ('1651992671309058050', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:52:00');
INSERT INTO `sys_job_log` VALUES ('1651993174579404802', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:54:00');
INSERT INTO `sys_job_log` VALUES ('1651993426187313154', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 00:55:00');
INSERT INTO `sys_job_log` VALUES ('1651993929587720193', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:57:00');
INSERT INTO `sys_job_log` VALUES ('1651994181120131073', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:58:00');
INSERT INTO `sys_job_log` VALUES ('1651994432908406786', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 00:59:00');
INSERT INTO `sys_job_log` VALUES ('1651994684440817666', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 01:00:00');
INSERT INTO `sys_job_log` VALUES ('1651994936090669058', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 01:01:00');
INSERT INTO `sys_job_log` VALUES ('1651995187803435009', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 01:02:00');
INSERT INTO `sys_job_log` VALUES ('1651995439486816257', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 01:03:00');
INSERT INTO `sys_job_log` VALUES ('1651995690729820161', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 01:04:00');
INSERT INTO `sys_job_log` VALUES ('1651995942719410177', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 01:05:00');
INSERT INTO `sys_job_log` VALUES ('1651996446115565570', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 01:07:00');
INSERT INTO `sys_job_log` VALUES ('1651996697736056833', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 01:08:00');
INSERT INTO `sys_job_log` VALUES ('1651996949369131009', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2023-04-29 01:09:00');
INSERT INTO `sys_job_log` VALUES ('1651997201069314049', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 01:10:00');
INSERT INTO `sys_job_log` VALUES ('1651997452706582529', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 01:11:00');
INSERT INTO `sys_job_log` VALUES ('1651997704343851009', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 01:12:00');
INSERT INTO `sys_job_log` VALUES ('1651997955981119490', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2023-04-29 01:13:00');

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
INSERT INTO `sys_log` VALUES ('1651788235466936322', '1', 'admin', '角色管理-分页获取角色信息', 10, 'com.company.project.controller.sys.RoleController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.1.5', '2023-04-28 11:19:39');
INSERT INTO `sys_log` VALUES ('1651788278773125122', '1', 'admin', '菜单权限管理-获取所有菜单权限', 135, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.1.5', '2023-04-28 11:19:49');
INSERT INTO `sys_log` VALUES ('1651788283680460801', '1', 'admin', '角色管理-分页获取角色信息', 5, 'com.company.project.controller.sys.RoleController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.1.5', '2023-04-28 11:19:50');
INSERT INTO `sys_log` VALUES ('1651788286108962817', '1', 'admin', '机构管理-树型组织列表', 15, 'com.company.project.controller.sys.DeptController.getTree()', '[null]', '192.168.1.5', '2023-04-28 11:19:51');
INSERT INTO `sys_log` VALUES ('1651788286108962818', '1', 'admin', '用户管理-分页获取用户列表', 16, 'com.company.project.controller.sys.UserController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.1.5', '2023-04-28 11:19:51');
INSERT INTO `sys_log` VALUES ('1651788288399052801', '1', 'admin', '机构管理-获取所有组织机构', 5, 'com.company.project.controller.sys.DeptController.getDeptAll()', NULL, '192.168.1.5', '2023-04-28 11:19:51');
INSERT INTO `sys_log` VALUES ('1651788335446560770', '1', 'admin', '系统操作日志管理-分页查询系统操作日志', 11, 'com.company.project.controller.sys.SysLogController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.1.5', '2023-04-28 11:20:03');
INSERT INTO `sys_log` VALUES ('1651789152157265922', '1', 'admin', '角色管理-分页获取角色信息', 9, 'com.company.project.controller.sys.RoleController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.1.5', '2023-04-28 11:23:17');
INSERT INTO `sys_log` VALUES ('1651789247628013570', '1', 'admin', '机构管理-获取所有组织机构', 7, 'com.company.project.controller.sys.DeptController.getDeptAll()', NULL, '192.168.1.5', '2023-04-28 11:23:40');
INSERT INTO `sys_log` VALUES ('1651789427941142530', '1', 'admin', '系统操作日志管理-分页查询系统操作日志', 13, 'com.company.project.controller.sys.SysLogController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.1.5', '2023-04-28 11:24:23');
INSERT INTO `sys_log` VALUES ('1651790034752073730', '1', 'admin', '暂停定时任务-', 27, 'com.company.project.controller.sys.SysJobController.pause()', '[[\"1252884495040782337\"]]', '192.168.1.5', '2023-04-28 11:26:48');
INSERT INTO `sys_log` VALUES ('1651790037096689665', '1', 'admin', '恢复定时任务-', 12, 'com.company.project.controller.sys.SysJobController.resume()', '[[\"1252884495040782337\"]]', '192.168.1.5', '2023-04-28 11:26:48');
INSERT INTO `sys_log` VALUES ('1651797415506477057', '1', 'admin', '机构管理-树型组织列表', 29, 'com.company.project.controller.sys.DeptController.getTree()', '[null]', '192.168.1.5', '2023-04-28 11:56:07');
INSERT INTO `sys_log` VALUES ('1651797415506477058', '1', 'admin', '用户管理-分页获取用户列表', 17, 'com.company.project.controller.sys.UserController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.1.5', '2023-04-28 11:56:07');
INSERT INTO `sys_log` VALUES ('1651824667032047618', '1', 'admin', '机构管理-获取所有组织机构', 8, 'com.company.project.controller.sys.DeptController.getDeptAll()', NULL, '192.168.1.5', '2023-04-28 13:44:25');
INSERT INTO `sys_log` VALUES ('1651836215846850562', '1', 'admin', '系统操作日志管理-分页查询系统操作日志', 9, 'com.company.project.controller.sys.SysLogController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.1.5', '2023-04-28 14:30:18');
INSERT INTO `sys_log` VALUES ('1651955551974514690', '1', 'admin', '系统操作日志管理-分页查询系统操作日志', 12, 'com.company.project.controller.sys.SysLogController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.1.5', '2023-04-28 22:24:30');
INSERT INTO `sys_log` VALUES ('1651956087608107010', '1', 'admin', '系统操作日志管理-分页查询系统操作日志', 10, 'com.company.project.controller.sys.SysLogController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.1.5', '2023-04-28 22:26:38');
INSERT INTO `sys_log` VALUES ('1651956113851867138', '1', 'admin', '菜单权限管理-获取所有菜单权限', 170, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.1.5', '2023-04-28 22:26:44');
INSERT INTO `sys_log` VALUES ('1651956236103245825', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 130, 'com.company.project.controller.sys.PermissionController.getAllMenusPermissionTree()', '[\"21\"]', '192.168.1.5', '2023-04-28 22:27:13');
INSERT INTO `sys_log` VALUES ('1651956369909932034', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 121, 'com.company.project.controller.sys.PermissionController.getAllMenusPermissionTree()', '[\"\"]', '192.168.1.5', '2023-04-28 22:27:45');
INSERT INTO `sys_log` VALUES ('1651956627574415362', '1', 'admin', '菜单权限管理-新增菜单权限', 14, 'com.company.project.controller.sys.PermissionController.addPermission()', '[{\"createTime\":1682692126529,\"deleted\":1,\"icon\":\"layui-icon-read\",\"id\":\"1651956627511500801\",\"name\":\"信息管理\",\"orderNum\":500,\"perms\":\"\",\"pid\":\"0\",\"pidName\":\"默认顶级菜单\",\"status\":1,\"target\":\"_self\",\"type\":1,\"updateTime\":1682692126529,\"url\":\"\"}]', '192.168.1.5', '2023-04-28 22:28:47');
INSERT INTO `sys_log` VALUES ('1651956628170006530', '1', 'admin', '菜单权限管理-获取所有菜单权限', 132, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.1.5', '2023-04-28 22:28:47');
INSERT INTO `sys_log` VALUES ('1651956761670508546', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 112, 'com.company.project.controller.sys.PermissionController.getAllMenusPermissionTree()', '[\"1647561651239350273\"]', '192.168.1.5', '2023-04-28 22:29:19');
INSERT INTO `sys_log` VALUES ('1651956808286003202', '1', 'admin', '菜单权限管理-更新菜单权限', 19, 'com.company.project.controller.sys.PermissionController.updatePermission()', '[{\"icon\":\"\",\"id\":\"1647561651239350273\",\"name\":\"客户\",\"orderNum\":10,\"perms\":\"\",\"pid\":\"1651956627511500801\",\"pidName\":\"信息管理\",\"status\":1,\"target\":\"_self\",\"type\":2,\"updateTime\":1682692169606,\"url\":\"index/customers\"}]', '192.168.1.5', '2023-04-28 22:29:30');
INSERT INTO `sys_log` VALUES ('1651956808936120321', '1', 'admin', '菜单权限管理-获取所有菜单权限', 145, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.1.5', '2023-04-28 22:29:30');
INSERT INTO `sys_log` VALUES ('1651956866343559169', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 104, 'com.company.project.controller.sys.PermissionController.getAllMenusPermissionTree()', '[\"1647547032789585922\"]', '192.168.1.5', '2023-04-28 22:29:43');
INSERT INTO `sys_log` VALUES ('1651956899117850625', '1', 'admin', '菜单权限管理-更新菜单权限', 13, 'com.company.project.controller.sys.PermissionController.updatePermission()', '[{\"icon\":\"\",\"id\":\"1647547032789585922\",\"name\":\"承运方\",\"orderNum\":10,\"perms\":\"\",\"pid\":\"1651956627511500801\",\"pidName\":\"信息管理\",\"status\":1,\"target\":\"_self\",\"type\":2,\"updateTime\":1682692191276,\"url\":\"index/carriers\"}]', '192.168.1.5', '2023-04-28 22:29:51');
INSERT INTO `sys_log` VALUES ('1651956899654721537', '1', 'admin', '菜单权限管理-获取所有菜单权限', 118, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.1.5', '2023-04-28 22:29:51');
INSERT INTO `sys_log` VALUES ('1651957005456039938', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 97, 'com.company.project.controller.sys.PermissionController.getAllMenusPermissionTree()', '[\"1647572648771493890\"]', '192.168.1.5', '2023-04-28 22:30:17');
INSERT INTO `sys_log` VALUES ('1651957035793440769', '1', 'admin', '菜单权限管理-更新菜单权限', 7, 'com.company.project.controller.sys.PermissionController.updatePermission()', '[{\"icon\":\"\",\"id\":\"1647572648771493890\",\"name\":\"货物类型\",\"orderNum\":10,\"perms\":\"\",\"pid\":\"1651956627511500801\",\"pidName\":\"信息管理\",\"status\":1,\"target\":\"_self\",\"type\":2,\"updateTime\":1682692223863,\"url\":\"index/goods\"}]', '192.168.1.5', '2023-04-28 22:30:24');
INSERT INTO `sys_log` VALUES ('1651957036443557889', '1', 'admin', '菜单权限管理-获取所有菜单权限', 140, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.1.5', '2023-04-28 22:30:24');
INSERT INTO `sys_log` VALUES ('1651957093070856194', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 91, 'com.company.project.controller.sys.PermissionController.getAllMenusPermissionTree()', '[\"\"]', '192.168.1.5', '2023-04-28 22:30:38');
INSERT INTO `sys_log` VALUES ('1651957363632824321', '1', 'admin', '菜单权限管理-新增菜单权限', 19, 'com.company.project.controller.sys.PermissionController.addPermission()', '[{\"createTime\":1682692302009,\"deleted\":1,\"icon\":\"layui-icon-form\",\"id\":\"1651957363502800897\",\"name\":\"运单管理\",\"orderNum\":501,\"perms\":\"\",\"pid\":\"0\",\"pidName\":\"默认顶级菜单\",\"status\":1,\"target\":\"_self\",\"type\":1,\"updateTime\":1682692302009,\"url\":\"\"}]', '192.168.1.5', '2023-04-28 22:31:42');
INSERT INTO `sys_log` VALUES ('1651957364098392065', '1', 'admin', '菜单权限管理-获取所有菜单权限', 102, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.1.5', '2023-04-28 22:31:42');
INSERT INTO `sys_log` VALUES ('1651957437679067137', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 90, 'com.company.project.controller.sys.PermissionController.getAllMenusPermissionTree()', '[\"1647585172439031810\"]', '192.168.1.5', '2023-04-28 22:32:00');
INSERT INTO `sys_log` VALUES ('1651957477466234881', '1', 'admin', '菜单权限管理-更新菜单权限', 13, 'com.company.project.controller.sys.PermissionController.updatePermission()', '[{\"icon\":\"\",\"id\":\"1647585172439031810\",\"name\":\"运单\",\"orderNum\":10,\"perms\":\"\",\"pid\":\"1651957363502800897\",\"pidName\":\"运单管理\",\"status\":1,\"target\":\"_self\",\"type\":2,\"updateTime\":1682692329164,\"url\":\"index/shipment\"}]', '192.168.1.5', '2023-04-28 22:32:09');
INSERT INTO `sys_log` VALUES ('1651957478057631746', '1', 'admin', '菜单权限管理-获取所有菜单权限', 116, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.1.5', '2023-04-28 22:32:09');
INSERT INTO `sys_log` VALUES ('1651957509212921857', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 94, 'com.company.project.controller.sys.PermissionController.getAllMenusPermissionTree()', '[\"1651929365147885570\"]', '192.168.1.5', '2023-04-28 22:32:17');
INSERT INTO `sys_log` VALUES ('1651957545955024897', '1', 'admin', '菜单权限管理-更新菜单权限', 14, 'com.company.project.controller.sys.PermissionController.updatePermission()', '[{\"icon\":\"\",\"id\":\"1651929365147885570\",\"name\":\"运输事件\",\"orderNum\":10,\"perms\":\"\",\"pid\":\"1651957363502800897\",\"pidName\":\"运单管理\",\"status\":1,\"target\":\"_self\",\"type\":2,\"updateTime\":1682692345493,\"url\":\"index/shipmentEvent\"}]', '192.168.1.5', '2023-04-28 22:32:26');
INSERT INTO `sys_log` VALUES ('1651957546420592641', '1', 'admin', '菜单权限管理-获取所有菜单权限', 104, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.1.5', '2023-04-28 22:32:26');
INSERT INTO `sys_log` VALUES ('1651957582378360834', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 96, 'com.company.project.controller.sys.PermissionController.getAllMenusPermissionTree()', '[\"\"]', '192.168.1.5', '2023-04-28 22:32:34');
INSERT INTO `sys_log` VALUES ('1651957730030444546', '1', 'admin', '菜单权限管理-新增菜单权限', 5, 'com.company.project.controller.sys.PermissionController.addPermission()', '[{\"createTime\":1682692389380,\"deleted\":1,\"icon\":\"layui-icon-diamond\",\"id\":\"1651957729963335682\",\"name\":\"支付管理\",\"orderNum\":502,\"perms\":\"\",\"pid\":\"0\",\"pidName\":\"默认顶级菜单\",\"status\":1,\"target\":\"_self\",\"type\":1,\"updateTime\":1682692389380,\"url\":\"\"}]', '192.168.1.5', '2023-04-28 22:33:09');
INSERT INTO `sys_log` VALUES ('1651957730491817985', '1', 'admin', '菜单权限管理-获取所有菜单权限', 102, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.1.5', '2023-04-28 22:33:10');
INSERT INTO `sys_log` VALUES ('1651957814369509377', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 93, 'com.company.project.controller.sys.PermissionController.getAllMenusPermissionTree()', '[\"1651163911873646593\"]', '192.168.1.5', '2023-04-28 22:33:29');
INSERT INTO `sys_log` VALUES ('1651957856455155713', '1', 'admin', '菜单权限管理-更新菜单权限', 5, 'com.company.project.controller.sys.PermissionController.updatePermission()', '[{\"icon\":\"\",\"id\":\"1651163911873646593\",\"name\":\"承运结算\",\"orderNum\":10,\"perms\":\"\",\"pid\":\"1651957729963335682\",\"pidName\":\"支付管理\",\"status\":1,\"target\":\"_self\",\"type\":2,\"updateTime\":1682692419522,\"url\":\"index/carrierBilling\"}]', '192.168.1.5', '2023-04-28 22:33:40');
INSERT INTO `sys_log` VALUES ('1651957856920723457', '1', 'admin', '菜单权限管理-获取所有菜单权限', 113, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.1.5', '2023-04-28 22:33:40');
INSERT INTO `sys_log` VALUES ('1651957906640003073', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 91, 'com.company.project.controller.sys.PermissionController.getAllMenusPermissionTree()', '[\"1651819703941578753\"]', '192.168.1.5', '2023-04-28 22:33:51');
INSERT INTO `sys_log` VALUES ('1651957930711113730', '1', 'admin', '菜单权限管理-更新菜单权限', 12, 'com.company.project.controller.sys.PermissionController.updatePermission()', '[{\"icon\":\"\",\"id\":\"1651819703941578753\",\"name\":\"邮寄结算\",\"orderNum\":10,\"perms\":\"\",\"pid\":\"1651957729963335682\",\"pidName\":\"支付管理\",\"status\":1,\"target\":\"_self\",\"type\":2,\"updateTime\":1682692437226,\"url\":\"index/customerBilling\"}]', '192.168.1.5', '2023-04-28 22:33:57');
INSERT INTO `sys_log` VALUES ('1651957931310899201', '1', 'admin', '菜单权限管理-获取所有菜单权限', 122, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.1.5', '2023-04-28 22:33:57');
INSERT INTO `sys_log` VALUES ('1651958051733561346', NULL, NULL, '用户管理-退出', 2, 'com.company.project.controller.sys.UserController.logout()', NULL, '192.168.1.5', '2023-04-28 22:34:26');
INSERT INTO `sys_log` VALUES ('1651958083346030593', '1', 'admin', '用户管理-查询用户详情', 3, 'com.company.project.controller.sys.UserController.youSelfInfo()', NULL, '192.168.1.5', '2023-04-28 22:34:34');
INSERT INTO `sys_log` VALUES ('1651958347520073730', '1', 'admin', '菜单权限管理-获取所有菜单权限', 88, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.1.5', '2023-04-28 22:35:37');
INSERT INTO `sys_log` VALUES ('1651958573697966082', '1', 'admin', '菜单权限管理-获取所有菜单权限', 179, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.1.5', '2023-04-28 22:36:31');
INSERT INTO `sys_log` VALUES ('1651958741520457730', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 160, 'com.company.project.controller.sys.PermissionController.getAllMenusPermissionTree()', '[\"1651957729963335682\"]', '192.168.1.5', '2023-04-28 22:37:11');
INSERT INTO `sys_log` VALUES ('1651958775418822657', '1', 'admin', '菜单权限管理-更新菜单权限', 16, 'com.company.project.controller.sys.PermissionController.updatePermission()', '[{\"icon\":\"layui-icon-diamond\",\"id\":\"1651957729963335682\",\"name\":\"支付管理\",\"orderNum\":502,\"perms\":\"\",\"pid\":\"0\",\"pidName\":\"\",\"status\":1,\"target\":\"_self\",\"type\":1,\"updateTime\":1682692638612,\"url\":\"\"}]', '192.168.1.5', '2023-04-28 22:37:19');
INSERT INTO `sys_log` VALUES ('1651958776085716993', '1', 'admin', '菜单权限管理-获取所有菜单权限', 153, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.1.5', '2023-04-28 22:37:19');
INSERT INTO `sys_log` VALUES ('1651959487326429185', '1', 'admin', '角色管理-分页获取角色信息', 40, 'com.company.project.controller.sys.RoleController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.1.5', '2023-04-28 22:40:08');
INSERT INTO `sys_log` VALUES ('1651959489134174210', '1', 'admin', '菜单权限管理-获取所有菜单权限', 121, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.1.5', '2023-04-28 22:40:09');
INSERT INTO `sys_log` VALUES ('1651959504141393922', '1', 'admin', '角色管理-分页获取角色信息', 0, 'com.company.project.controller.sys.RoleController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.1.5', '2023-04-28 22:40:12');
INSERT INTO `sys_log` VALUES ('1651959519400271874', '1', 'admin', '角色管理-查询角色详情', 136, 'com.company.project.controller.sys.RoleController.detailInfo()', '[\"1\"]', '192.168.1.5', '2023-04-28 22:40:16');
INSERT INTO `sys_log` VALUES ('1651959592469241858', '1', 'admin', '角色管理-更新角色信息', 73, 'com.company.project.controller.sys.RoleController.updateDept()', '[{\"description\":\"拥有所有权限-不能删除\",\"id\":\"1\",\"name\":\"超级管理员\",\"permissions\":[\"51\",\"11\",\"17\",\"26\",\"40\",\"43\",\"44\",\"53\",\"19\",\"3\",\"36\",\"1311115974068449281\",\"13\",\"39\",\"24\",\"10\",\"23\",\"25\",\"42\",\"52\",\"56\",\"57\",\"41\",\"12\",\"22\",\"38\",\"5\",\"9\",\"54\",\"15\",\"1\",\"16\",\"20\",\"4\",\"27\",\"28\",\"29\",\"30\",\"31\",\"32\",\"33\",\"34\",\"35\",\"45\",\"46\",\"47\",\"48\",\"49\",\"59\",\"60\",\"61\",\"62\",\"63\",\"55\",\"18\",\"14\",\"8\",\"58\",\"7\",\"21\",\"50\",\"2\",\"6\",\"1651956627511500801\",\"1647547032789585922\",\"1647547032789585923\",\"1647547032789585924\",\"1647547032789585925\",\"1647547032789585926\",\"1647561651239350273\",\"1647561651239350274\",\"1647561651239350275\",\"1647561651239350276\",\"1647561651239350277\",\"1647572648771493890\",\"1647572648771493891\",\"1647572648771493892\",\"1647572648771493893\",\"1647572648771493894\",\"1651957363502800897\",\"1647585172439031810\",\"1647585172439031811\",\"1647585172439031812\",\"1647585172439031813\",\"1647585172439031814\",\"1651929365147885570\",\"1651929365147885571\",\"1651929365147885572\",\"1651929365147885573\",\"1651929365147885574\",\"1651957729963335682\",\"1651163911873646593\",\"1651163911873646594\",\"1651163911873646595\",\"1651163911873646596\",\"1651163911873646597\",\"1651819703941578753\",\"1651819703941578754\",\"1651819703941578755\",\"1651819703941578756\",\"1651819703941578757\"],\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"},\"status\":1,\"updateTime\":1682692833370}]', '192.168.1.5', '2023-04-28 22:40:33');
INSERT INTO `sys_log` VALUES ('1651959592603459586', '1', 'admin', '角色管理-分页获取角色信息', 0, 'com.company.project.controller.sys.RoleController.pageInfo()', '[{\"name\":\"\",\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.1.5', '2023-04-28 22:40:33');
INSERT INTO `sys_log` VALUES ('1651960295140974594', '1', 'admin', '机构管理-树型组织列表', 24, 'com.company.project.controller.sys.DeptController.getTree()', '[null]', '192.168.1.5', '2023-04-28 22:43:21');
INSERT INTO `sys_log` VALUES ('1651960295140974595', '1', 'admin', '用户管理-分页获取用户列表', 16, 'com.company.project.controller.sys.UserController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.1.5', '2023-04-28 22:43:21');
INSERT INTO `sys_log` VALUES ('1651960302669750273', '1', 'admin', '机构管理-获取所有组织机构', 0, 'com.company.project.controller.sys.DeptController.getDeptAll()', NULL, '192.168.1.5', '2023-04-28 22:43:23');
INSERT INTO `sys_log` VALUES ('1651960398325047298', '1', 'admin', '菜单权限管理-获取所有菜单权限', 160, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.1.5', '2023-04-28 22:43:46');
INSERT INTO `sys_log` VALUES ('1651960427949416449', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 135, 'com.company.project.controller.sys.PermissionController.getAllMenusPermissionTree()', '[\"21\"]', '192.168.1.5', '2023-04-28 22:43:53');
INSERT INTO `sys_log` VALUES ('1651960453190737921', '1', 'admin', '菜单权限管理-更新菜单权限', 20, 'com.company.project.controller.sys.PermissionController.updatePermission()', '[{\"icon\":\"layui-icon-list\",\"id\":\"21\",\"name\":\"其他\",\"orderNum\":503,\"perms\":\"\",\"pid\":\"0\",\"pidName\":\"\",\"status\":1,\"target\":\"_self\",\"type\":1,\"updateTime\":1682693038618,\"url\":\"\"}]', '192.168.1.5', '2023-04-28 22:43:59');
INSERT INTO `sys_log` VALUES ('1651960453928935426', '1', 'admin', '菜单权限管理-获取所有菜单权限', 176, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.1.5', '2023-04-28 22:43:59');
INSERT INTO `sys_log` VALUES ('1651960585307119618', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 144, 'com.company.project.controller.sys.PermissionController.getAllMenusPermissionTree()', '[\"54\"]', '192.168.1.5', '2023-04-28 22:44:30');
INSERT INTO `sys_log` VALUES ('1651960605951483906', '1', 'admin', '菜单权限管理-更新菜单权限', 11, 'com.company.project.controller.sys.PermissionController.updatePermission()', '[{\"icon\":\"layui-icon-set-fill\",\"id\":\"54\",\"name\":\"系统管理\",\"orderNum\":504,\"perms\":\"\",\"pid\":\"0\",\"pidName\":\"\",\"status\":1,\"target\":\"_self\",\"type\":1,\"updateTime\":1682693075051,\"url\":\"\"}]', '192.168.1.5', '2023-04-28 22:44:35');
INSERT INTO `sys_log` VALUES ('1651960606534492161', '1', 'admin', '菜单权限管理-获取所有菜单权限', 128, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.1.5', '2023-04-28 22:44:35');
INSERT INTO `sys_log` VALUES ('1651960631201193986', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 104, 'com.company.project.controller.sys.PermissionController.getAllMenusPermissionTree()', '[\"51\"]', '192.168.1.5', '2023-04-28 22:44:41');
INSERT INTO `sys_log` VALUES ('1651960693750849538', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 112, 'com.company.project.controller.sys.PermissionController.getAllMenusPermissionTree()', '[\"44\"]', '192.168.1.5', '2023-04-28 22:44:56');
INSERT INTO `sys_log` VALUES ('1651960710398042114', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 104, 'com.company.project.controller.sys.PermissionController.getAllMenusPermissionTree()', '[\"44\"]', '192.168.1.5', '2023-04-28 22:45:00');
INSERT INTO `sys_log` VALUES ('1651960718744707074', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 136, 'com.company.project.controller.sys.PermissionController.getAllMenusPermissionTree()', '[\"11\"]', '192.168.1.5', '2023-04-28 22:45:02');
INSERT INTO `sys_log` VALUES ('1651960743533043713', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 131, 'com.company.project.controller.sys.PermissionController.getAllMenusPermissionTree()', '[\"51\"]', '192.168.1.5', '2023-04-28 22:45:08');
INSERT INTO `sys_log` VALUES ('1651960767880978434', '1', 'admin', '菜单权限管理-更新菜单权限', 17, 'com.company.project.controller.sys.PermissionController.updatePermission()', '[{\"icon\":\"layui-icon-user\",\"id\":\"51\",\"name\":\"组织管理\",\"orderNum\":504,\"perms\":\"\",\"pid\":\"0\",\"pidName\":\"\",\"status\":1,\"target\":\"_self\",\"type\":1,\"updateTime\":1682693113657,\"url\":\"\"}]', '192.168.1.5', '2023-04-28 22:45:14');
INSERT INTO `sys_log` VALUES ('1651960768413655041', '1', 'admin', '菜单权限管理-获取所有菜单权限', 103, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.1.5', '2023-04-28 22:45:14');
INSERT INTO `sys_log` VALUES ('1651960828601917441', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 96, 'com.company.project.controller.sys.PermissionController.getAllMenusPermissionTree()', '[\"51\"]', '192.168.1.5', '2023-04-28 22:45:28');
INSERT INTO `sys_log` VALUES ('1651960848617136130', '1', 'admin', '菜单权限管理-更新菜单权限', 18, 'com.company.project.controller.sys.PermissionController.updatePermission()', '[{\"icon\":\"layui-icon-user\",\"id\":\"51\",\"name\":\"组织管理\",\"orderNum\":98,\"perms\":\"\",\"pid\":\"0\",\"pidName\":\"\",\"status\":1,\"target\":\"_self\",\"type\":1,\"updateTime\":1682693132906,\"url\":\"\"}]', '192.168.1.5', '2023-04-28 22:45:33');
INSERT INTO `sys_log` VALUES ('1651960849057538049', '1', 'admin', '菜单权限管理-获取所有菜单权限', 88, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.1.5', '2023-04-28 22:45:33');
INSERT INTO `sys_log` VALUES ('1651960959304818690', '1', 'admin', '角色管理-分页获取角色信息', 8, 'com.company.project.controller.sys.RoleController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.1.5', '2023-04-28 22:45:59');
INSERT INTO `sys_log` VALUES ('1651960976686014466', '1', 'admin', '机构管理-树型组织列表', 8, 'com.company.project.controller.sys.DeptController.getTree()', '[null]', '192.168.1.5', '2023-04-28 22:46:03');
INSERT INTO `sys_log` VALUES ('1651960976753123329', '1', 'admin', '用户管理-分页获取用户列表', 16, 'com.company.project.controller.sys.UserController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.1.5', '2023-04-28 22:46:03');
INSERT INTO `sys_log` VALUES ('1651961033476890625', '1', 'admin', '用户管理-查询用户详情', 8, 'com.company.project.controller.sys.UserController.youSelfInfo()', NULL, '192.168.1.5', '2023-04-28 22:46:17');
INSERT INTO `sys_log` VALUES ('1651974957916016642', '1', 'admin', '机构管理-获取所有组织机构', 6, 'com.company.project.controller.sys.DeptController.getDeptAll()', NULL, '192.168.1.5', '2023-04-28 23:41:37');
INSERT INTO `sys_log` VALUES ('1651974959874756610', '1', 'admin', '机构管理-树型组织列表', 15, 'com.company.project.controller.sys.DeptController.getTree()', '[null]', '192.168.1.5', '2023-04-28 23:41:37');
INSERT INTO `sys_log` VALUES ('1651974959937671170', '1', 'admin', '用户管理-分页获取用户列表', 15, 'com.company.project.controller.sys.UserController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.1.5', '2023-04-28 23:41:37');
INSERT INTO `sys_log` VALUES ('1651974965750976514', '1', 'admin', '角色管理-分页获取角色信息', 8, 'com.company.project.controller.sys.RoleController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.1.5', '2023-04-28 23:41:39');
INSERT INTO `sys_log` VALUES ('1651974971098714114', '1', 'admin', '机构管理-获取所有组织机构', 6, 'com.company.project.controller.sys.DeptController.getDeptAll()', NULL, '192.168.1.5', '2023-04-28 23:41:40');
INSERT INTO `sys_log` VALUES ('1651994662596882433', '1', 'admin', '机构管理-获取所有组织机构', 6, 'com.company.project.controller.sys.DeptController.getDeptAll()', NULL, '192.168.1.5', '2023-04-29 00:59:55');
INSERT INTO `sys_log` VALUES ('1651996528713994242', '1', 'admin', '角色管理-分页获取角色信息', 14, 'com.company.project.controller.sys.RoleController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.1.5', '2023-04-29 01:07:20');
INSERT INTO `sys_log` VALUES ('1651996535143862273', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 199, 'com.company.project.controller.sys.PermissionController.getAllPermissionTree()', NULL, '192.168.1.5', '2023-04-29 01:07:21');
INSERT INTO `sys_log` VALUES ('1651996664613638145', '1', 'admin', '角色管理-新增角色', 14, 'com.company.project.controller.sys.RoleController.addRole()', '[{\"createTime\":1682701672114,\"deleted\":1,\"description\":\"负责管理运单，包括信息管理\",\"id\":\"1651996664546529282\",\"name\":\"运单管理员\",\"permissions\":[],\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"},\"status\":1,\"updateTime\":1682701672114}]', '192.168.1.5', '2023-04-29 01:07:52');
INSERT INTO `sys_log` VALUES ('1651996664743661570', '1', 'admin', '角色管理-分页获取角色信息', 4, 'com.company.project.controller.sys.RoleController.pageInfo()', '[{\"name\":\"\",\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.1.5', '2023-04-29 01:07:52');
INSERT INTO `sys_log` VALUES ('1651996692056969218', '1', 'admin', '角色管理-查询角色详情', 195, 'com.company.project.controller.sys.RoleController.detailInfo()', '[\"1651996664546529282\"]', '192.168.1.5', '2023-04-29 01:07:59');
INSERT INTO `sys_log` VALUES ('1651996810747383809', '1', 'admin', '角色管理-更新角色信息', 34, 'com.company.project.controller.sys.RoleController.updateDept()', '[{\"description\":\"负责管理运单，包括信息管理、运单管理和支付管理\",\"id\":\"1651996664546529282\",\"name\":\"运单管理员\",\"permissions\":[\"1651956627511500801\",\"1647547032789585922\",\"1647547032789585923\",\"1647547032789585924\",\"1647547032789585925\",\"1647547032789585926\",\"1647561651239350273\",\"1647561651239350274\",\"1647561651239350275\",\"1647561651239350276\",\"1647561651239350277\",\"1647572648771493890\",\"1647572648771493891\",\"1647572648771493892\",\"1647572648771493893\",\"1647572648771493894\",\"1651957363502800897\",\"1647585172439031810\",\"1647585172439031811\",\"1647585172439031812\",\"1647585172439031813\",\"1647585172439031814\",\"1651929365147885570\",\"1651929365147885571\",\"1651929365147885572\",\"1651929365147885573\",\"1651929365147885574\",\"1651957729963335682\",\"1651163911873646593\",\"1651163911873646594\",\"1651163911873646595\",\"1651163911873646596\",\"1651163911873646597\",\"1651819703941578753\",\"1651819703941578754\",\"1651819703941578755\",\"1651819703941578756\",\"1651819703941578757\"],\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"},\"status\":1,\"updateTime\":1682701706927}]', '192.168.1.5', '2023-04-29 01:08:27');
INSERT INTO `sys_log` VALUES ('1651996810877407233', '1', 'admin', '角色管理-分页获取角色信息', 4, 'com.company.project.controller.sys.RoleController.pageInfo()', '[{\"name\":\"\",\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.1.5', '2023-04-29 01:08:27');
INSERT INTO `sys_log` VALUES ('1651996827021283330', '1', 'admin', '机构管理-树型组织列表', 4, 'com.company.project.controller.sys.DeptController.getTree()', '[null]', '192.168.1.5', '2023-04-29 01:08:31');
INSERT INTO `sys_log` VALUES ('1651996827084197890', '1', 'admin', '用户管理-分页获取用户列表', 11, 'com.company.project.controller.sys.UserController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.1.5', '2023-04-29 01:08:31');
INSERT INTO `sys_log` VALUES ('1651996902749442049', '1', 'admin', '机构管理-获取所有组织机构', 5, 'com.company.project.controller.sys.DeptController.getDeptAll()', NULL, '192.168.1.5', '2023-04-29 01:08:49');
INSERT INTO `sys_log` VALUES ('1651996927088988162', '1', 'admin', '机构管理-树型组织列表', 1, 'com.company.project.controller.sys.DeptController.getTree()', '[\"\"]', '192.168.1.5', '2023-04-29 01:08:55');
INSERT INTO `sys_log` VALUES ('1651997029866213378', '1', 'admin', '机构管理-新增组织', 10, 'com.company.project.controller.sys.DeptController.addDept()', '[{\"createTime\":1682701759193,\"deleted\":1,\"deptNo\":\"D000002\",\"id\":\"1651997029803298818\",\"managerName\":\"祁麟\",\"name\":\"运输部门\",\"phone\":\"13777777777\",\"pid\":\"1\",\"pidName\":\"总公司\",\"relationCode\":\"D000001D000002\",\"status\":1,\"updateTime\":1682701759193}]', '192.168.1.5', '2023-04-29 01:09:19');
INSERT INTO `sys_log` VALUES ('1651997029933322242', '1', 'admin', '机构管理-获取所有组织机构', 3, 'com.company.project.controller.sys.DeptController.getDeptAll()', NULL, '192.168.1.5', '2023-04-29 01:09:19');
INSERT INTO `sys_log` VALUES ('1651997058437812226', '1', 'admin', '机构管理-树型组织列表', 3, 'com.company.project.controller.sys.DeptController.getTree()', '[null]', '192.168.1.5', '2023-04-29 01:09:26');
INSERT INTO `sys_log` VALUES ('1651997058504921090', '1', 'admin', '用户管理-分页获取用户列表', 7, 'com.company.project.controller.sys.UserController.pageInfo()', '[{\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"}}]', '192.168.1.5', '2023-04-29 01:09:26');
INSERT INTO `sys_log` VALUES ('1651997250591461377', '1', 'admin', '用户管理-新增用户', 9, 'com.company.project.controller.sys.UserController.addUser()', '[{\"createTime\":1682701811819,\"createWhere\":1,\"deleted\":1,\"deptId\":\"1651997029803298818\",\"deptName\":\"运输部门\",\"id\":\"1651997250528546818\",\"password\":\"a9d22a439f6390107ca0642fd6db10b7\",\"phone\":\"1387654321\",\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"},\"salt\":\"08c2aba51c9f48cf97c2\",\"status\":1,\"updateTime\":1682701811819,\"username\":\"冰淇凌\"}]', '192.168.1.5', '2023-04-29 01:10:12');
INSERT INTO `sys_log` VALUES ('1651997250725679106', '1', 'admin', '用户管理-分页获取用户列表', 10, 'com.company.project.controller.sys.UserController.pageInfo()', '[{\"nickName\":\"\",\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"},\"username\":\"\"}]', '192.168.1.5', '2023-04-29 01:10:12');
INSERT INTO `sys_log` VALUES ('1651997446348017666', '1', 'admin', '用户管理-更新用户信息', 17, 'com.company.project.controller.sys.UserController.updateUserInfo()', '[{\"deptId\":\"1651997029803298818\",\"deptName\":\"运输部门\",\"id\":\"1651997250528546818\",\"password\":\"a9d22a439f6390107ca0642fd6db10b7\",\"phone\":\"1387654321\",\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"},\"status\":1,\"updateId\":\"1\",\"updateTime\":1682701858499,\"username\":\"冰淇淋\"}]', '192.168.1.5', '2023-04-29 01:10:59');
INSERT INTO `sys_log` VALUES ('1651997446545149953', '1', 'admin', '用户管理-分页获取用户列表', 8, 'com.company.project.controller.sys.UserController.pageInfo()', '[{\"nickName\":\"\",\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"},\"username\":\"\"}]', '192.168.1.5', '2023-04-29 01:10:59');
INSERT INTO `sys_log` VALUES ('1651997485069832194', '1', 'admin', '用户管理-赋予角色-获取所有角色接口', 4, 'com.company.project.controller.sys.UserController.getUserOwnRole()', '[\"1651997250528546818\"]', '192.168.1.5', '2023-04-29 01:11:08');
INSERT INTO `sys_log` VALUES ('1651997528367632385', '1', 'admin', '用户管理-赋予角色-用户赋予角色接口', 12, 'com.company.project.controller.sys.UserController.setUserOwnRole()', '[\"1651997250528546818\",[\"1651996664546529282\"]]', '192.168.1.5', '2023-04-29 01:11:18');
INSERT INTO `sys_log` VALUES ('1651997528497655810', '1', 'admin', '用户管理-分页获取用户列表', 9, 'com.company.project.controller.sys.UserController.pageInfo()', '[{\"nickName\":\"\",\"queryPage\":{\"current\":\"1\",\"hitCount\":false,\"optimizeCountSql\":true,\"orders\":[],\"pages\":\"0\",\"records\":[],\"searchCount\":true,\"size\":\"10\",\"total\":\"0\"},\"username\":\"\"}]', '192.168.1.5', '2023-04-29 01:11:18');
INSERT INTO `sys_log` VALUES ('1651997576526630914', '1', 'admin', '用户管理-赋予角色-获取所有角色接口', 3, 'com.company.project.controller.sys.UserController.getUserOwnRole()', '[\"1\"]', '192.168.1.5', '2023-04-29 01:11:30');
INSERT INTO `sys_log` VALUES ('1651997598949380097', '1', 'admin', '用户管理-赋予角色-获取所有角色接口', 3, 'com.company.project.controller.sys.UserController.getUserOwnRole()', '[\"1651997250528546818\"]', '192.168.1.5', '2023-04-29 01:11:35');
INSERT INTO `sys_log` VALUES ('1651997652732940290', NULL, NULL, '用户管理-退出', 2, 'com.company.project.controller.sys.UserController.logout()', NULL, '192.168.1.5', '2023-04-29 01:11:48');
INSERT INTO `sys_log` VALUES ('1651997750019821570', '1651997250528546818', '冰淇淋', '用户管理-查询用户详情', 4, 'com.company.project.controller.sys.UserController.youSelfInfo()', NULL, '192.168.1.5', '2023-04-29 01:12:11');
INSERT INTO `sys_log` VALUES ('1651997764615999489', NULL, NULL, '用户管理-退出', 1, 'com.company.project.controller.sys.UserController.logout()', NULL, '192.168.1.5', '2023-04-29 01:12:14');
INSERT INTO `sys_log` VALUES ('1651997836917411842', '1', 'admin', '菜单权限管理-获取所有菜单权限', 130, 'com.company.project.controller.sys.PermissionController.getAllMenusPermission()', NULL, '192.168.1.5', '2023-04-29 01:12:32');

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
INSERT INTO `sys_permission` VALUES ('1647547032789585922', '承运方', '', '', 'index/carriers', '_self', '1651956627511500801', 10, 2, 1, NULL, '2023-04-28 22:29:51', 1);
INSERT INTO `sys_permission` VALUES ('1647547032789585923', '新增', 'carriers:add', NULL, 'carriers/add', NULL, '1647547032789585922', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647547032789585924', '修改', 'carriers:update', NULL, 'carriers/update', NULL, '1647547032789585922', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647547032789585925', '删除', 'carriers:delete', NULL, 'carriers/delete', NULL, '1647547032789585922', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647547032789585926', '列表', 'carriers:list', NULL, 'carriers/listByPage', NULL, '1647547032789585922', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647561651239350273', '客户', '', '', 'index/customers', '_self', '1651956627511500801', 10, 2, 1, NULL, '2023-04-28 22:29:30', 1);
INSERT INTO `sys_permission` VALUES ('1647561651239350274', '新增', 'customers:add', NULL, 'customers/add', NULL, '1647561651239350273', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647561651239350275', '修改', 'customers:update', NULL, 'customers/update', NULL, '1647561651239350273', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647561651239350276', '删除', 'customers:delete', NULL, 'customers/delete', NULL, '1647561651239350273', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647561651239350277', '列表', 'customers:list', NULL, 'customers/listByPage', NULL, '1647561651239350273', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647572648771493890', '货物类型', '', '', 'index/goods', '_self', '1651956627511500801', 10, 2, 1, NULL, '2023-04-28 22:30:24', 1);
INSERT INTO `sys_permission` VALUES ('1647572648771493891', '新增', 'goods:add', NULL, 'goods/add', NULL, '1647572648771493890', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647572648771493892', '修改', 'goods:update', NULL, 'goods/update', NULL, '1647572648771493890', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647572648771493893', '删除', 'goods:delete', NULL, 'goods/delete', NULL, '1647572648771493890', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647572648771493894', '列表', 'goods:list', NULL, 'goods/listByPage', NULL, '1647572648771493890', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647585172439031810', '运单', '', '', 'index/shipment', '_self', '1651957363502800897', 10, 2, 1, NULL, '2023-04-28 22:32:09', 1);
INSERT INTO `sys_permission` VALUES ('1647585172439031811', '新增', 'shipment:add', NULL, 'shipment/add', NULL, '1647585172439031810', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647585172439031812', '修改', 'shipment:update', NULL, 'shipment/update', NULL, '1647585172439031810', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647585172439031813', '删除', 'shipment:delete', NULL, 'shipment/delete', NULL, '1647585172439031810', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1647585172439031814', '列表', 'shipment:list', NULL, 'shipment/listByPage', NULL, '1647585172439031810', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1651163911873646593', '承运结算', '', '', 'index/carrierBilling', '_self', '1651957729963335682', 10, 2, 1, NULL, '2023-04-28 22:33:40', 1);
INSERT INTO `sys_permission` VALUES ('1651163911873646594', '新增', 'carrierBilling:add', NULL, 'carrierBilling/add', NULL, '1651163911873646593', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1651163911873646595', '修改', 'carrierBilling:update', NULL, 'carrierBilling/update', NULL, '1651163911873646593', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1651163911873646596', '删除', 'carrierBilling:delete', NULL, 'carrierBilling/delete', NULL, '1651163911873646593', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1651163911873646597', '列表', 'carrierBilling:list', NULL, 'carrierBilling/listByPage', NULL, '1651163911873646593', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1651819703941578753', '邮寄结算', '', '', 'index/customerBilling', '_self', '1651957729963335682', 10, 2, 1, NULL, '2023-04-28 22:33:57', 1);
INSERT INTO `sys_permission` VALUES ('1651819703941578754', '新增', 'customerBilling:add', NULL, 'customerBilling/add', NULL, '1651819703941578753', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1651819703941578755', '修改', 'customerBilling:update', NULL, 'customerBilling/update', NULL, '1651819703941578753', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1651819703941578756', '删除', 'customerBilling:delete', NULL, 'customerBilling/delete', NULL, '1651819703941578753', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1651819703941578757', '列表', 'customerBilling:list', NULL, 'customerBilling/listByPage', NULL, '1651819703941578753', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1651929365147885570', '运输事件', '', '', 'index/shipmentEvent', '_self', '1651957363502800897', 10, 2, 1, NULL, '2023-04-28 22:32:25', 1);
INSERT INTO `sys_permission` VALUES ('1651929365147885571', '新增', 'shipmentEvent:add', NULL, 'shipmentEvent/add', NULL, '1651929365147885570', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1651929365147885572', '修改', 'shipmentEvent:update', NULL, 'shipmentEvent/update', NULL, '1651929365147885570', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1651929365147885573', '删除', 'shipmentEvent:delete', NULL, 'shipmentEvent/delete', NULL, '1651929365147885570', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1651929365147885574', '列表', 'shipmentEvent:list', NULL, 'shipmentEvent/listByPage', NULL, '1651929365147885570', NULL, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('1651956627511500801', '信息管理', '', 'layui-icon-read', '', '_self', '0', 500, 1, 1, '2023-04-28 22:28:47', '2023-04-28 22:28:47', 1);
INSERT INTO `sys_permission` VALUES ('1651957363502800897', '运单管理', '', 'layui-icon-form', '', '_self', '0', 501, 1, 1, '2023-04-28 22:31:42', '2023-04-28 22:31:42', 1);
INSERT INTO `sys_permission` VALUES ('1651957729963335682', '支付管理', '', 'layui-icon-diamond', '', '_self', '0', 502, 1, 1, '2023-04-28 22:33:09', '2023-04-28 22:37:19', 1);
INSERT INTO `sys_permission` VALUES ('17', '详情', 'sys:permission:detail', NULL, 'sys/permission/*', NULL, '11', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('18', '定时任务恢复', 'sysJob:resume', NULL, 'sysJob/resume', '_self', '59', 4, 3, 1, '2020-04-22 15:48:40', NULL, 1);
INSERT INTO `sys_permission` VALUES ('19', '列表', 'sys:role:list', NULL, 'sys/roles', NULL, '53', 0, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('2', 'SQL 监控', '', '', 'druid/sql.html', '_self', '21', 98, 2, 1, '2020-03-19 13:29:40', '2020-05-07 13:36:59', 1);
INSERT INTO `sys_permission` VALUES ('20', '修改', 'sysGenerator:update', NULL, 'sysGenerator/update', NULL, '15', 1, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('21', '其他', '', 'layui-icon-list', '', '_self', '0', 503, 1, 1, '2020-03-19 13:29:40', '2023-04-28 22:43:59', 1);
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
INSERT INTO `sys_permission` VALUES ('51', '组织管理', '', 'layui-icon-user', '', '_self', '0', 98, 1, 1, '2020-03-19 13:29:40', '2023-04-28 22:45:33', 1);
INSERT INTO `sys_permission` VALUES ('52', '拥有角色', 'sys:user:role:detail', NULL, 'sys/user/roles/*', NULL, '24', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('53', '角色管理', NULL, NULL, 'index/roles', '_self', '51', 99, 2, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('54', '系统管理', '', 'layui-icon-set-fill', '', '_self', '0', 504, 1, 1, '2020-03-19 13:29:40', '2023-04-28 22:44:35', 1);
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
INSERT INTO `sys_role` VALUES ('1', '超级管理员', '拥有所有权限-不能删除', 1, '2019-11-01 19:26:29', '2023-04-28 22:40:33', 1, NULL);
INSERT INTO `sys_role` VALUES ('1651996664546529282', '运单管理员', '负责管理运单，包括信息管理、运单管理和支付管理', 1, '2023-04-29 01:07:52', '2023-04-29 01:08:27', 1, NULL);

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
INSERT INTO `sys_role_permission` VALUES ('1651959592267915265', '1', '51', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592267915266', '1', '11', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592267915267', '1', '17', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592267915268', '1', '26', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592267915269', '1', '40', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592267915270', '1', '43', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592267915271', '1', '44', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024130', '1', '53', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024131', '1', '19', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024132', '1', '3', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024133', '1', '36', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024134', '1', '1311115974068449281', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024135', '1', '13', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024136', '1', '39', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024137', '1', '24', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024138', '1', '10', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024139', '1', '23', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024140', '1', '25', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024141', '1', '42', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024142', '1', '52', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024143', '1', '56', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024144', '1', '57', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024145', '1', '41', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024146', '1', '12', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024147', '1', '22', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024148', '1', '38', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024149', '1', '5', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024150', '1', '9', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024151', '1', '54', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024152', '1', '15', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024153', '1', '1', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024154', '1', '16', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024155', '1', '20', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024156', '1', '4', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024157', '1', '27', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024158', '1', '28', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024159', '1', '29', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024160', '1', '30', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024161', '1', '31', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024162', '1', '32', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024163', '1', '33', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024164', '1', '34', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024165', '1', '35', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024166', '1', '45', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024167', '1', '46', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024168', '1', '47', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024169', '1', '48', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024170', '1', '49', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024171', '1', '59', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024172', '1', '60', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024173', '1', '61', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024174', '1', '62', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024175', '1', '63', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024176', '1', '55', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024177', '1', '18', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024178', '1', '14', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024179', '1', '8', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024180', '1', '58', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024181', '1', '7', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024182', '1', '21', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024183', '1', '50', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024184', '1', '2', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024185', '1', '6', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024186', '1', '1651956627511500801', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024187', '1', '1647547032789585922', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024188', '1', '1647547032789585923', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024189', '1', '1647547032789585924', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024190', '1', '1647547032789585925', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024191', '1', '1647547032789585926', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024192', '1', '1647561651239350273', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024193', '1', '1647561651239350274', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024194', '1', '1647561651239350275', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024195', '1', '1647561651239350276', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024196', '1', '1647561651239350277', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024197', '1', '1647572648771493890', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024198', '1', '1647572648771493891', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024199', '1', '1647572648771493892', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024200', '1', '1647572648771493893', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024201', '1', '1647572648771493894', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024202', '1', '1651957363502800897', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024203', '1', '1647585172439031810', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024204', '1', '1647585172439031811', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024205', '1', '1647585172439031812', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024206', '1', '1647585172439031813', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024207', '1', '1647585172439031814', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024208', '1', '1651929365147885570', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024209', '1', '1651929365147885571', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024210', '1', '1651929365147885572', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024211', '1', '1651929365147885573', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024212', '1', '1651929365147885574', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024213', '1', '1651957729963335682', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024214', '1', '1651163911873646593', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024215', '1', '1651163911873646594', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024216', '1', '1651163911873646595', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024217', '1', '1651163911873646596', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024218', '1', '1651163911873646597', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024219', '1', '1651819703941578753', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024220', '1', '1651819703941578754', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024221', '1', '1651819703941578755', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024222', '1', '1651819703941578756', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651959592335024223', '1', '1651819703941578757', '2023-04-28 22:40:33');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274946', '1651996664546529282', '1651956627511500801', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274947', '1651996664546529282', '1647547032789585922', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274948', '1651996664546529282', '1647547032789585923', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274949', '1651996664546529282', '1647547032789585924', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274950', '1651996664546529282', '1647547032789585925', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274951', '1651996664546529282', '1647547032789585926', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274952', '1651996664546529282', '1647561651239350273', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274953', '1651996664546529282', '1647561651239350274', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274954', '1651996664546529282', '1647561651239350275', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274955', '1651996664546529282', '1647561651239350276', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274956', '1651996664546529282', '1647561651239350277', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274957', '1651996664546529282', '1647572648771493890', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274958', '1651996664546529282', '1647572648771493891', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274959', '1651996664546529282', '1647572648771493892', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274960', '1651996664546529282', '1647572648771493893', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274961', '1651996664546529282', '1647572648771493894', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274962', '1651996664546529282', '1651957363502800897', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274963', '1651996664546529282', '1647585172439031810', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274964', '1651996664546529282', '1647585172439031811', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274965', '1651996664546529282', '1647585172439031812', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274966', '1651996664546529282', '1647585172439031813', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274967', '1651996664546529282', '1647585172439031814', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274968', '1651996664546529282', '1651929365147885570', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274969', '1651996664546529282', '1651929365147885571', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274970', '1651996664546529282', '1651929365147885572', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274971', '1651996664546529282', '1651929365147885573', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274972', '1651996664546529282', '1651929365147885574', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274973', '1651996664546529282', '1651957729963335682', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274974', '1651996664546529282', '1651163911873646593', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274975', '1651996664546529282', '1651163911873646594', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274976', '1651996664546529282', '1651163911873646595', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274977', '1651996664546529282', '1651163911873646596', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274978', '1651996664546529282', '1651163911873646597', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274979', '1651996664546529282', '1651819703941578753', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274980', '1651996664546529282', '1651819703941578754', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274981', '1651996664546529282', '1651819703941578755', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274982', '1651996664546529282', '1651819703941578756', '2023-04-29 01:08:27');
INSERT INTO `sys_role_permission` VALUES ('1651996810680274983', '1651996664546529282', '1651819703941578757', '2023-04-29 01:08:27');

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
INSERT INTO `sys_user` VALUES ('1651997250528546818', '冰淇淋', '08c2aba51c9f48cf97c2', 'a9d22a439f6390107ca0642fd6db10b7', '1387654321', '1651997029803298818', NULL, NULL, NULL, 1, NULL, 1, NULL, '1', 1, '2023-04-29 01:10:12', '2023-04-29 01:10:58');

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
INSERT INTO `sys_user_role` VALUES ('1651997528300523521', '1651997250528546818', '1651996664546529282', '2023-04-29 01:11:18');

SET FOREIGN_KEY_CHECKS = 1;
