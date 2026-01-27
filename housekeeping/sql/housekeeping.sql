/*
 Navicat Premium Data Transfer

 Source Server         : test
 Source Server Type    : MySQL
 Source Server Version : 80031
 Source Host           : localhost:3306
 Source Schema         : housekeeping

 Target Server Type    : MySQL
 Target Server Version : 80031
 File Encoding         : 65001

 Date: 20/07/2025 22:06:52
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for assess
-- ----------------------------
DROP TABLE IF EXISTS `assess`;
CREATE TABLE `assess`  (
  `assess_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '评价ID',
  `reservation_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '预约ID',
  `score` double NOT NULL COMMENT '服务评分',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '评价内容',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '评价时间',
  `go_index` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '否' COMMENT '是否推送到主页',
  PRIMARY KEY (`assess_id`) USING BTREE,
  UNIQUE INDEX `assess_id`(`assess_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '评价' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of assess
-- ----------------------------
INSERT INTO `assess` VALUES ('4df50ab773994039b4870e290dfad91b', '43bf2ef81a444feeaf12ce57f2c2fc6c', 5, '师傅非常专业, 维修技术很好, 很有耐心, 强烈推荐!!', '2025-07-20 19:50:22', '推送');
INSERT INTO `assess` VALUES ('6c9ddfeaf2df45a188501b17fd19916e', 'dd9f58794d94415fa6bd23e36cb263d0', 5, '育儿嫂阿姨很有经验，宝宝很喜欢她，教会了我们很多育儿知识，现在宝宝作息规律多了，非常感谢！', '2025-07-20 21:36:51', '推送');
INSERT INTO `assess` VALUES ('83125b99eb8c448fa6a4e294eb33b9a6', 'dd89249def884c8f95b525e03b0968d6', 5, '保洁服务很到位，阿姨打扫得很仔细，特别是厨房和卫生间这些难清洁的地方都处理得很干净，下次还会选择。', '2025-07-20 21:36:35', '推送');

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner`  (
  `banner_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '轮播图ID',
  `image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '图片',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '描述',
  `sort` int NOT NULL COMMENT '排序',
  PRIMARY KEY (`banner_id`) USING BTREE,
  UNIQUE INDEX `banner_id`(`banner_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '轮播图' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of banner
-- ----------------------------
INSERT INTO `banner` VALUES ('877a09c9e81745fd9bf31c2e007236a6', '/profile/upload/2025/07/20/专业厨师上门_20250720201919A003.jpg', '专业厨师上门', '星级大厨为您定制私房美味，让家宴更美味', 2);
INSERT INTO `banner` VALUES ('8c41ce8b76254a82832f092ed4082bc5', '/profile/upload/2025/07/20/金牌月嫂服务_20250720201842A002.jpg', '金牌月嫂服务', '专业月嫂团队, 呵护母婴健康', 1);
INSERT INTO `banner` VALUES ('c021d8189759434089dcf0a53897ec30', '/profile/upload/2025/07/20/专业家政服务_20250720201944A004.jpg', '专业家政服务', '为您提供高品质的家政服务体验', 3);

-- ----------------------------
-- Table structure for cancel
-- ----------------------------
DROP TABLE IF EXISTS `cancel`;
CREATE TABLE `cancel`  (
  `cancel_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '取消记录ID',
  `reservation_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '预约ID',
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '取消原因',
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '取消时间',
  PRIMARY KEY (`cancel_id`) USING BTREE,
  UNIQUE INDEX `cancel_id`(`cancel_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '取消记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cancel
-- ----------------------------
INSERT INTO `cancel` VALUES ('7fc42084cb304a18a594bcd959539763', '0869970caed6415f901268a9c6f7e5f0', '不需要服务了', NULL, '2025-07-20 00:10:08');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (6, 'banner', '轮播图', NULL, NULL, 'Banner', 'crud', 'element-plus', 'com.huacai.housekeeping', 'housekeeping', 'banner', '轮播图', 'huacai', '0', '/', '{}', 'admin', '2025-07-20 20:13:18', '', '2025-07-20 20:13:59', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (39, 6, 'banner_id', '轮播图ID', 'varchar(255)', 'String', 'bannerId', '1', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-07-20 20:13:18', '', '2025-07-20 20:13:59');
INSERT INTO `gen_table_column` VALUES (40, 6, 'image', '图片', 'varchar(500)', 'String', 'image', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'imageUpload', '', 2, 'admin', '2025-07-20 20:13:18', '', '2025-07-20 20:13:59');
INSERT INTO `gen_table_column` VALUES (41, 6, 'title', '名称', 'varchar(255)', 'String', 'title', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2025-07-20 20:13:18', '', '2025-07-20 20:13:59');
INSERT INTO `gen_table_column` VALUES (42, 6, 'description', '描述', 'varchar(500)', 'String', 'description', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'textarea', '', 4, 'admin', '2025-07-20 20:13:18', '', '2025-07-20 20:13:59');
INSERT INTO `gen_table_column` VALUES (43, 6, 'sort', '排序', 'int', 'Long', 'sort', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 5, 'admin', '2025-07-20 20:13:18', '', '2025-07-20 20:13:59');

-- ----------------------------
-- Table structure for reservation
-- ----------------------------
DROP TABLE IF EXISTS `reservation`;
CREATE TABLE `reservation`  (
  `reservation_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '预约ID',
  `serve_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '服务ID',
  `time` datetime NOT NULL COMMENT '预约服务时间',
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '预约服务地址',
  `contacts` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '联系人',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '联系电话',
  `special` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '特别要求',
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '待支付' COMMENT '预约状态',
  `staff_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '服务人员ID',
  `user_id` int NOT NULL COMMENT '创建人ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`reservation_id`) USING BTREE,
  UNIQUE INDEX `reservation_id`(`reservation_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '预约' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reservation
-- ----------------------------
INSERT INTO `reservation` VALUES ('0869970caed6415f901268a9c6f7e5f0', '3827bcf413174065bf25ffee67ac7810', '2025-07-20 12:00:00', '成都市武侯区666号', '王杨', '13922223333', NULL, '已取消', NULL, 1, '2025-07-19 01:50:40');
INSERT INTO `reservation` VALUES ('43bf2ef81a444feeaf12ce57f2c2fc6c', '02929b4a92d14ee0991cb953cc3bd554', '2025-07-21 09:00:00', '成都市青羊区666号', '张三', '13699998888', '没有特别要求', '已完成', '4ec1d82b9c1a4db69cf75e181416b6d2', 1, '2025-07-17 22:12:21');
INSERT INTO `reservation` VALUES ('dd89249def884c8f95b525e03b0968d6', 'c6158a34eba547d49148bdd3623b6737', '2025-07-21 09:00:00', '成都市武侯区666号', '花菜', '13699998888', NULL, '已完成', '39074b7f7e3648d0a88216c48559a530', 1, '2025-07-20 21:33:30');
INSERT INTO `reservation` VALUES ('dd9f58794d94415fa6bd23e36cb263d0', '23f034009dcd41d0a6cf0b2c15a62a3c', '2025-07-22 12:00:00', '成都市青羊区999号', '赵六', '13677772222', NULL, '已完成', 'a6300d46d75340ed8dbf730209a38b70', 1, '2025-07-20 21:34:13');

-- ----------------------------
-- Table structure for serve
-- ----------------------------
DROP TABLE IF EXISTS `serve`;
CREATE TABLE `serve`  (
  `serve_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '服务ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '服务名称',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '服务类型',
  `image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '图片',
  `description` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '描述',
  `price` double NOT NULL COMMENT '价格',
  `tag` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '标签',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`serve_id`) USING BTREE,
  UNIQUE INDEX `serve_id`(`serve_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '服务' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of serve
-- ----------------------------
INSERT INTO `serve` VALUES ('02929b4a92d14ee0991cb953cc3bd554', '水电维修', '维修服务', '/profile/upload/2025/07/10/水电维修_20250710213635A002.png', '专业水电工上门服务，解决水管漏水、电路故障等常见问题', 150, '水电维修,漏水处理,电路检修,紧急服务', '2025-07-10 21:30:18');
INSERT INTO `serve` VALUES ('23f034009dcd41d0a6cf0b2c15a62a3c', '专业育儿嫂', '月嫂育儿', '/profile/upload/2025/07/10/专业育儿嫂_20250710213717A004.png', '有3年以上育儿经验，负责宝宝日常照料、辅食制作、早期教育等', 7500, '3年经验,辅食制作,早期教育,日常照料', '2025-07-10 21:30:18');
INSERT INTO `serve` VALUES ('33dc7558a5d245508ed187817a284f84', '宠物上门喂养', '宠物护理', '/profile/upload/2025/07/10/宠物上门喂养_20250710213732A006.png', '专业宠物护理师上门服务，包括喂食、遛狗、清理猫砂等', 88, '宠物喂养,遛狗服务,猫砂清理,宠物陪伴', '2025-07-10 21:30:18');
INSERT INTO `serve` VALUES ('3827bcf413174065bf25ffee67ac7810', '老人24小时陪护', '老人陪护', '/profile/upload/2025/07/10/老人24小时陪护_20250710213740A007.png', '全天候专业老人护理，包括生活照料、服药提醒、夜间看护等', 280, '24小时陪护,专业护理,服药提醒,夜间看护', '2025-07-10 21:30:18');
INSERT INTO `serve` VALUES ('3a055dac0dcc443ea327f466895d6798', '宠物美容护理', '宠物护理', '/profile/upload/2025/07/10/宠物美容护理_20250710213747A008.png', '专业宠物美容师上门服务，包括洗澡、剪毛、指甲修剪等全套护理', 168, '宠物美容,洗澡剪毛,指甲护理,上门服务', '2025-07-10 21:30:18');
INSERT INTO `serve` VALUES ('52eec2fe0085496b827d3f12fd5757fc', '家庭绿植养护', '其他服务', '/profile/upload/2025/07/10/家庭绿植养护_20250710213756A009.png', '专业园艺师上门服务，提供植物养护、换盆施肥、病虫害防治等服务', 199, '绿植养护,园艺服务,植物诊疗,定期维护', '2025-07-10 21:30:18');
INSERT INTO `serve` VALUES ('64071fbd33794697aeb9ac4a4c535208', '家电维修', '维修服务', '/profile/upload/2025/07/10/家电维修_20250710213801A010.png', '专业家电维修师傅，维修各类家用电器故障', 120, '家电维修,故障检测,配件更换,保修服务', '2025-07-10 21:30:18');
INSERT INTO `serve` VALUES ('690f71935a6d450a81164967a0f92494', '开荒保洁', '保洁服务', '/profile/upload/2025/07/10/开荒保洁_20250710213809A011.png', '新房装修后首次保洁，彻底清除装修残留和灰尘', 680, '新房开荒,深度清洁,装修残留清除,全屋打扫', '2025-07-10 21:30:18');
INSERT INTO `serve` VALUES ('8ea8d80661c34a909b058e92e255d38b', '金牌月嫂服务', '月嫂育儿', '/profile/upload/2025/07/10/金牌月嫂服务_20250710213823A012.png', '专业月嫂26天服务，科学护理母婴，包括新生儿护理、产妇护理、月子餐制作等', 12800, '26天服务,母婴护理,月子餐,专业培训', '2025-07-10 21:30:18');
INSERT INTO `serve` VALUES ('8fd31bfedc56402f96830f1d31be124c', '老人日间陪护', '老人陪护', '/profile/upload/2025/07/10/老人日间陪护_20250710213829A013.png', '8小时老人陪护，包括生活照料、陪伴聊天、简单家务等', 150, '8小时陪护,生活照料,陪伴聊天,简单家务', '2025-07-10 21:30:18');
INSERT INTO `serve` VALUES ('be76a520a55c4379b9192b0ac91678ac', '专业厨师上门', '厨师服务', '/profile/upload/2025/07/10/专业厨师上门_20250710213837A014.png', '专业厨师上门服务，根据您的口味定制3-4道菜品（含食材采购）', 398, '专业厨师,定制菜品,食材采购,厨房清洁', '2025-07-10 21:30:18');
INSERT INTO `serve` VALUES ('c6158a34eba547d49148bdd3623b6737', '日常深度保洁', '保洁服务', '/profile/upload/2025/07/10/日常深度保洁_20250710213843A015.png', '专业保洁团队，4小时深度清洁，包括客厅、卧室、厨房、卫生间等全屋清洁', 198, '深度清洁,全屋打扫,4小时服务,专业工具', '2025-07-10 21:30:18');
INSERT INTO `serve` VALUES ('d78acc78f3a5485685d19cfb1f11d034', '专业收纳整理', '其他服务', '/profile/upload/2025/07/10/专业收纳整理_20250710213849A016.png', '专业收纳师上门服务，帮助整理衣橱、书房等空间，提供收纳方案', 499, '专业收纳,空间规划,收纳方案,整理服务', '2025-07-10 21:30:18');
INSERT INTO `serve` VALUES ('f3dff13c039f43a79c278cc5858ad007', '宴会厨师上门', '厨师服务', '/profile/upload/2025/07/10/宴会厨师上门_20250710213856A017.png', '专业宴会厨师团队，提供8-10人份宴席制作（含食材采购和厨房清洁）', 1299, '宴会服务,团队服务,食材采购,厨房清洁', '2025-07-10 21:30:18');
INSERT INTO `serve` VALUES ('fe084b16962c49819978a310851cc08a', '长期钟点工', '保洁服务', '/profile/upload/2025/07/10/长期钟点工_20250710213905A018.png', '长期固定钟点工，每周固定时间上门服务，负责日常清洁和简单家务', 35, '长期服务,固定人员,日常清洁,简单家务', '2025-07-10 21:30:18');

-- ----------------------------
-- Table structure for staff
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff`  (
  `staff_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '服务人员ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '姓名',
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '性别',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '联系电话',
  `photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '照片',
  `staff_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '人员类型',
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '空闲' COMMENT '状态',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`staff_id`) USING BTREE,
  UNIQUE INDEX `staff_id`(`staff_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '服务人员' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of staff
-- ----------------------------
INSERT INTO `staff` VALUES ('166b8fd7099d4d6da1985eae25ffb045', '褚整理', '女', '13800138014', '/profile/upload/2025/07/17/专业收纳整理人员_20250717162153A017.png', '其他服务', '空闲', '2025-07-17 16:17:50');
INSERT INTO `staff` VALUES ('1cdd8a0321df416199bfec1796496c46', '吴师傅', '男', '13800138009', '/profile/upload/2025/07/17/厨师服务人员1_20250717162030A009.png', '厨师服务', '空闲', '2025-07-17 16:17:50');
INSERT INTO `staff` VALUES ('2b117f2f8bcc420dbb1e00e491e5f032', '卫维修', '男', '13800138015', '/profile/upload/2025/07/17/家电维修人员_20250717162128A015.png', '维修服务', '空闲', '2025-07-17 16:17:50');
INSERT INTO `staff` VALUES ('34b1bb6e1b074c5282d7b69bad2fcf34', '郑阿姨', '女', '13800138010', '/profile/upload/2025/07/17/老人陪护人员1_20250717162011A006.png', '老人陪护', '空闲', '2025-07-17 16:17:50');
INSERT INTO `staff` VALUES ('39074b7f7e3648d0a88216c48559a530', '张阿姨', '女', '13800138001', '/profile/upload/2025/07/17/保洁服务人员1_20250717161936A001.png', '保洁服务', '空闲', '2025-07-17 16:17:50');
INSERT INTO `staff` VALUES ('40f2e45f532d4b429f838bef8ca33990', '王师傅', '女', '13800138003', '/profile/upload/2025/07/17/保洁服务人员2_20250717161943A002.png', '保洁服务', '空闲', '2025-07-17 16:17:50');
INSERT INTO `staff` VALUES ('4e5e6f5d7c8a40bd8f5d9accd8cebafc', '韩育儿', '女', '13800138018', '/profile/upload/2025/07/17/月嫂育儿人员1_20250717161957A004.png', '月嫂育儿', '空闲', '2025-07-17 16:17:50');
INSERT INTO `staff` VALUES ('4ec1d82b9c1a4db69cf75e181416b6d2', '蒋师傅', '男', '13800138016', '/profile/upload/2025/07/17/水电维修人员_20250717162133A016.png', '维修服务', '空闲', '2025-07-17 16:17:50');
INSERT INTO `staff` VALUES ('50c0e04d38934d199ec7fa0061b890cf', '李阿姨', '女', '13800138002', '/profile/upload/2025/07/17/保洁服务人员3_20250717161947A003.png', '保洁服务', '空闲', '2025-07-17 16:17:50');
INSERT INTO `staff` VALUES ('6f22ada6b9d3494cb55da9f82a9e102c', '李师傅', '女', '13800138012', '/profile/upload/2025/07/17/老人陪护人员2_20250717162015A007.png', '老人陪护', '空闲', '2025-07-17 16:17:50');
INSERT INTO `staff` VALUES ('750de7da46624e2ea06b2f68cdbc7840', '周大厨', '男', '13800138008', '/profile/upload/2025/07/17/厨师服务人员2_20250717162035A010.png', '厨师服务', '空闲', '2025-07-17 16:17:50');
INSERT INTO `staff` VALUES ('a5925d9d5d9c4f7b9379621fe0c2fbb2', '孙护理', '女', '13800138011', '/profile/upload/2025/07/17/老人陪护人员3_20250717162019A008.png', '老人陪护', '空闲', '2025-07-17 16:17:50');
INSERT INTO `staff` VALUES ('a6300d46d75340ed8dbf730209a38b70', '沈月嫂', '女', '13800138017', '/profile/upload/2025/07/17/月嫂育儿人员2_20250717162001A005.png', '月嫂育儿', '服务中', '2025-07-17 16:17:50');
INSERT INTO `staff` VALUES ('a6e91faa5ad64abdba41919b821b5034', '赵护理', '女', '13800138006', '/profile/upload/2025/07/17/宠物护理人员1_20250717162043A011.png', '宠物护理', '空闲', '2025-07-17 16:17:50');
INSERT INTO `staff` VALUES ('b6b7713619744c62bf20c2d9927d77aa', '林护理', '女', '13800138005', '/profile/upload/2025/07/17/宠物护理人员2_20250717162047A012.png', '宠物护理', '空闲', '2025-07-17 16:17:50');
INSERT INTO `staff` VALUES ('c7ee938c6cd84066a70044c45e537bd1', '冯园艺', '男', '13800138013', '/profile/upload/2025/07/17/家庭绿植养护人员_20250717162200A018.png', '其他服务', '空闲', '2025-07-17 16:17:50');
INSERT INTO `staff` VALUES ('cea9dca15c37453c940cb311611ab11b', '陈医生', '女', '13800138004', '/profile/upload/2025/07/17/宠物护理人员3_20250717162052A013.png', '宠物护理', '空闲', '2025-07-17 16:17:50');
INSERT INTO `staff` VALUES ('e2a6da18039c4604b39e9d3c29e4d13f', '钱护理', '女', '13800138007', '/profile/upload/2025/07/17/宠物护理人员4_20250717162057A014.png', '宠物护理', '空闲', '2025-07-17 16:17:50');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-05-05 08:59:54', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-05-05 08:59:54', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-05-05 08:59:54', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'false', 'Y', 'admin', '2025-05-05 08:59:54', 'admin', '2025-05-09 13:21:16', '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2025-05-05 08:59:54', 'admin', '2025-07-10 23:03:51', '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-05-05 08:59:54', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '花菜编程', 0, 'huacai', '15888888888', 'huacai@qq.com', '0', '0', 'admin', '2025-05-05 08:59:53', 'admin', '2025-05-05 10:36:00');

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 115 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 1, '保洁服务', '保洁服务', 'serve_type', NULL, 'default', 'N', '0', 'admin', '2025-07-10 19:37:23', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (101, 2, '月嫂育儿', '月嫂育儿', 'serve_type', NULL, 'default', 'N', '0', 'admin', '2025-07-10 19:37:36', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (102, 3, '老人陪护', '老人陪护', 'serve_type', NULL, 'default', 'N', '0', 'admin', '2025-07-10 19:37:44', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (103, 4, '厨师服务', '厨师服务', 'serve_type', NULL, 'default', 'N', '0', 'admin', '2025-07-10 19:37:54', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (104, 5, '宠物护理', '宠物护理', 'serve_type', NULL, 'default', 'N', '0', 'admin', '2025-07-10 19:38:02', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (105, 6, '维修服务', '维修服务', 'serve_type', NULL, 'default', 'N', '0', 'admin', '2025-07-10 19:38:09', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (106, 7, '其他服务', '其他服务', 'serve_type', NULL, 'default', 'N', '0', 'admin', '2025-07-10 19:38:17', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (107, 1, '空闲', '空闲', 'staff_status', NULL, 'info', 'N', '0', 'admin', '2025-07-17 16:05:48', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (108, 2, '服务中', '服务中', 'staff_status', NULL, 'warning', 'N', '0', 'admin', '2025-07-17 16:06:00', 'admin', '2025-07-17 16:06:04', NULL);
INSERT INTO `sys_dict_data` VALUES (109, 1, '男', '男', 'gender', NULL, 'default', 'N', '0', 'admin', '2025-07-17 16:07:02', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (110, 2, '女', '女', 'gender', NULL, 'default', 'N', '0', 'admin', '2025-07-17 16:07:08', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (111, 1, '待支付', '待支付', 'reservation_status', NULL, 'warning', 'N', '0', 'admin', '2025-07-17 21:59:00', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (112, 2, '待确认', '待确认', 'reservation_status', NULL, 'info', 'N', '0', 'admin', '2025-07-17 21:59:16', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (113, 3, '已完成', '已完成', 'reservation_status', NULL, 'success', 'N', '0', 'admin', '2025-07-17 21:59:29', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (114, 4, '已取消', '已取消', 'reservation_status', NULL, 'danger', 'N', '0', 'admin', '2025-07-17 21:59:40', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (115, 1, '时间变更', '时间变更', 'cancel_reason', NULL, 'default', 'N', '0', 'admin', '2025-07-19 23:39:06', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (116, 2, '不需要服务了', '不需要服务了', 'cancel_reason', NULL, 'default', 'N', '0', 'admin', '2025-07-19 23:39:11', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (117, 3, '找到其他服务商', '找到其他服务商', 'cancel_reason', NULL, 'default', 'N', '0', 'admin', '2025-07-19 23:39:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (118, 4, '价格问题', '价格问题', 'cancel_reason', NULL, 'default', 'N', '0', 'admin', '2025-07-19 23:39:21', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (119, 5, '其他原因', '其他原因', 'cancel_reason', NULL, 'default', 'N', '0', 'admin', '2025-07-19 23:39:25', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (120, 1, '否', '否', 'go_index', NULL, 'info', 'N', '0', 'admin', '2025-07-20 15:52:17', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (121, 2, '推送', '推送', 'go_index', NULL, 'success', 'N', '0', 'admin', '2025-07-20 15:52:26', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '服务类型', 'serve_type', '0', 'admin', '2025-07-10 19:36:37', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (101, '服务人员状态', 'staff_status', '0', 'admin', '2025-07-17 16:05:19', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (102, '性别', 'gender', '0', 'admin', '2025-07-17 16:06:55', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (103, '预约状态', 'reservation_status', '0', 'admin', '2025-07-17 21:58:48', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (104, '取消原因', 'cancel_reason', '0', 'admin', '2025-07-19 23:38:58', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (105, '是否推送', 'go_index', '0', 'admin', '2025-07-20 15:52:06', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 125 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-07-09 22:42:46');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-07-09 22:42:54');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-07-10 15:38:30');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '退出成功', '2025-07-10 23:02:35');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-07-10 23:02:46');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '退出成功', '2025-07-10 23:03:54');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-07-10 23:03:59');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '退出成功', '2025-07-10 23:05:05');
INSERT INTO `sys_logininfor` VALUES (109, '张三', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '注册成功', '2025-07-10 23:05:33');
INSERT INTO `sys_logininfor` VALUES (110, '张三', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-07-10 23:05:44');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2025-07-14 21:37:26');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-07-14 21:37:34');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2025-07-16 19:16:42');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-07-16 19:16:49');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-07-17 00:32:17');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-07-17 09:59:11');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-07-17 14:21:45');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-07-17 21:57:42');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-07-18 16:22:50');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '退出成功', '2025-07-19 01:47:28');
INSERT INTO `sys_logininfor` VALUES (121, '张三', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-07-19 01:47:34');
INSERT INTO `sys_logininfor` VALUES (122, '张三', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '退出成功', '2025-07-19 01:49:34');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-07-19 01:49:46');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-07-19 16:48:36');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-07-20 15:49:13');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '退出成功', '2025-07-20 21:58:42');
INSERT INTO `sys_logininfor` VALUES (127, '张三', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2025-07-20 21:58:50');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2025 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-05-05 08:59:54', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2025-05-05 08:59:54', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2025-05-05 08:59:54', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-05-05 08:59:54', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-05-05 08:59:54', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-05-05 08:59:54', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-05-05 08:59:54', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2025-05-05 08:59:54', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2025-05-05 08:59:54', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2025-05-05 08:59:54', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-05-05 08:59:54', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2025-05-05 08:59:54', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2025-05-05 08:59:54', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2025-05-05 08:59:54', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2025-05-05 08:59:54', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-05-05 08:59:54', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-05-05 08:59:54', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-05-05 08:59:54', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-05-05 08:59:54', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-05-05 08:59:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '服务管理', 2012, 1, 'serve', 'housekeeping/serve/index', NULL, '', 1, 1, 'C', '0', '0', 'housekeeping:serve:list', '服务', 'admin', '2025-07-10 19:43:16', 'admin', '2025-07-10 19:56:53', '服务菜单');
INSERT INTO `sys_menu` VALUES (2007, '服务查询', 2006, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:serve:query', '#', 'admin', '2025-07-10 19:43:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2008, '服务新增', 2006, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:serve:add', '#', 'admin', '2025-07-10 19:43:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2009, '服务修改', 2006, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:serve:edit', '#', 'admin', '2025-07-10 19:43:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, '服务删除', 2006, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:serve:remove', '#', 'admin', '2025-07-10 19:43:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2011, '服务导出', 2006, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:serve:export', '#', 'admin', '2025-07-10 19:43:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2012, '家政服务管理', 0, 0, 'housekeeping', NULL, NULL, '', 1, 0, 'M', '0', '0', '', '家政服务', 'admin', '2025-07-10 19:54:02', 'admin', '2025-07-10 19:56:48', '');
INSERT INTO `sys_menu` VALUES (2013, '服务人员管理', 2012, 2, 'staff', 'housekeeping/staff/index', NULL, '', 1, 1, 'C', '0', '0', 'housekeeping:staff:list', '服务人员', 'admin', '2025-07-17 16:08:40', 'admin', '2025-07-17 16:12:14', '服务人员菜单');
INSERT INTO `sys_menu` VALUES (2014, '服务人员查询', 2013, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:staff:query', '#', 'admin', '2025-07-17 16:08:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2015, '服务人员新增', 2013, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:staff:add', '#', 'admin', '2025-07-17 16:08:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2016, '服务人员修改', 2013, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:staff:edit', '#', 'admin', '2025-07-17 16:08:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2017, '服务人员删除', 2013, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:staff:remove', '#', 'admin', '2025-07-17 16:08:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '服务人员导出', 2013, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:staff:export', '#', 'admin', '2025-07-17 16:08:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2019, '预约管理', 2012, 3, 'reservation', 'housekeeping/reservation/index', NULL, '', 1, 1, 'C', '0', '0', 'housekeeping:reservation:list', '预约', 'admin', '2025-07-17 22:02:20', 'admin', '2025-07-17 22:05:14', '预约菜单');
INSERT INTO `sys_menu` VALUES (2020, '预约查询', 2019, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:reservation:query', '#', 'admin', '2025-07-17 22:02:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, '预约新增', 2019, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:reservation:add', '#', 'admin', '2025-07-17 22:02:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2022, '预约修改', 2019, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:reservation:edit', '#', 'admin', '2025-07-17 22:02:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2023, '预约删除', 2019, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:reservation:remove', '#', 'admin', '2025-07-17 22:02:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2024, '预约导出', 2019, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:reservation:export', '#', 'admin', '2025-07-17 22:02:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2025, '取消记录', 2012, 4, 'cancel', 'housekeeping/cancel/index', NULL, '', 1, 1, 'C', '0', '0', 'housekeeping:cancel:list', '记录', 'admin', '2025-07-19 23:41:16', 'admin', '2025-07-19 23:43:38', '取消记录菜单');
INSERT INTO `sys_menu` VALUES (2026, '取消记录查询', 2025, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:cancel:query', '#', 'admin', '2025-07-19 23:41:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2027, '取消记录新增', 2025, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:cancel:add', '#', 'admin', '2025-07-19 23:41:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2028, '取消记录修改', 2025, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:cancel:edit', '#', 'admin', '2025-07-19 23:41:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2029, '取消记录删除', 2025, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:cancel:remove', '#', 'admin', '2025-07-19 23:41:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2030, '取消记录导出', 2025, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:cancel:export', '#', 'admin', '2025-07-19 23:41:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2031, '评价管理', 2012, 5, 'assess', 'housekeeping/assess/index', NULL, '', 1, 1, 'C', '0', '0', 'housekeeping:assess:list', '评价', 'admin', '2025-07-20 15:53:57', 'admin', '2025-07-20 15:56:54', '评价菜单');
INSERT INTO `sys_menu` VALUES (2032, '评价查询', 2031, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:assess:query', '#', 'admin', '2025-07-20 15:53:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2033, '评价新增', 2031, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:assess:add', '#', 'admin', '2025-07-20 15:53:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2034, '评价修改', 2031, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:assess:edit', '#', 'admin', '2025-07-20 15:53:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2035, '评价删除', 2031, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:assess:remove', '#', 'admin', '2025-07-20 15:53:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2036, '评价导出', 2031, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:assess:export', '#', 'admin', '2025-07-20 15:53:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2037, '轮播图管理', 2012, 6, 'banner', 'housekeeping/banner/index', NULL, '', 1, 1, 'C', '0', '0', 'housekeeping:banner:list', '轮播图', 'admin', '2025-07-20 20:14:23', 'admin', '2025-07-20 20:17:13', '轮播图菜单');
INSERT INTO `sys_menu` VALUES (2038, '轮播图查询', 2037, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:banner:query', '#', 'admin', '2025-07-20 20:14:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2039, '轮播图新增', 2037, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:banner:add', '#', 'admin', '2025-07-20 20:14:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2040, '轮播图修改', 2037, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:banner:edit', '#', 'admin', '2025-07-20 20:14:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2041, '轮播图删除', 2037, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:banner:remove', '#', 'admin', '2025-07-20 20:14:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2042, '轮播图导出', 2037, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:banner:export', '#', 'admin', '2025-07-20 20:14:23', '', NULL, '');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 246 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (1, '操作日志', 9, 'com.huacai.web.controller.monitor.SysOperlogController.clean()', 'DELETE', 1, 'admin', '花菜编程', '/monitor/operlog/clean', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-05-09 13:24:56', 25);
INSERT INTO `sys_oper_log` VALUES (2, '登录日志', 9, 'com.huacai.web.controller.monitor.SysLogininforController.clean()', 'DELETE', 1, 'admin', '花菜编程', '/monitor/logininfor/clean', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-05-09 13:24:58', 22);
INSERT INTO `sys_oper_log` VALUES (138, '代码生成', 6, 'com.huacai.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '花菜编程', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"serve\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 19:34:11', 178);
INSERT INTO `sys_oper_log` VALUES (139, '代码生成', 2, 'com.huacai.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '花菜编程', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"serve\",\"className\":\"Serve\",\"columns\":[{\"capJavaField\":\"ServeId\",\"columnComment\":\"服务ID\",\"columnId\":1,\"columnName\":\"serve_id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 19:34:11\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"serveId\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"服务名称\",\"columnId\":2,\"columnName\":\"name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 19:34:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Category\",\"columnComment\":\"服务类型\",\"columnId\":3,\"columnName\":\"category\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 19:34:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"category\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Image\",\"columnComment\":\"图片\",\"columnId\":4,\"columnName\":\"image\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 19:34:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"imageUpload\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaF', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 19:35:42', 35);
INSERT INTO `sys_oper_log` VALUES (140, '字典类型', 1, 'com.huacai.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"服务类型\",\"dictType\":\"serve_type\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 19:36:37', 10);
INSERT INTO `sys_oper_log` VALUES (141, '字典数据', 1, 'com.huacai.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"保洁服务\",\"dictSort\":1,\"dictType\":\"serve_type\",\"dictValue\":\"保洁服务\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 19:37:23', 10);
INSERT INTO `sys_oper_log` VALUES (142, '字典数据', 1, 'com.huacai.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"月嫂育儿\",\"dictSort\":2,\"dictType\":\"serve_type\",\"dictValue\":\"月嫂育儿\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 19:37:36', 7);
INSERT INTO `sys_oper_log` VALUES (143, '字典数据', 1, 'com.huacai.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"老人陪护\",\"dictSort\":3,\"dictType\":\"serve_type\",\"dictValue\":\"老人陪护\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 19:37:44', 7);
INSERT INTO `sys_oper_log` VALUES (144, '字典数据', 1, 'com.huacai.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"厨师服务\",\"dictSort\":4,\"dictType\":\"serve_type\",\"dictValue\":\"厨师服务\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 19:37:54', 7);
INSERT INTO `sys_oper_log` VALUES (145, '字典数据', 1, 'com.huacai.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"宠物护理\",\"dictSort\":5,\"dictType\":\"serve_type\",\"dictValue\":\"宠物护理\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 19:38:02', 6);
INSERT INTO `sys_oper_log` VALUES (146, '字典数据', 1, 'com.huacai.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"维修服务\",\"dictSort\":6,\"dictType\":\"serve_type\",\"dictValue\":\"维修服务\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 19:38:09', 8);
INSERT INTO `sys_oper_log` VALUES (147, '字典数据', 1, 'com.huacai.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"其他服务\",\"dictSort\":7,\"dictType\":\"serve_type\",\"dictValue\":\"其他服务\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 19:38:17', 6);
INSERT INTO `sys_oper_log` VALUES (148, '代码生成', 2, 'com.huacai.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '花菜编程', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"serve\",\"className\":\"Serve\",\"columns\":[{\"capJavaField\":\"ServeId\",\"columnComment\":\"服务ID\",\"columnId\":1,\"columnName\":\"serve_id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 19:34:11\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"serveId\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-07-10 19:35:42\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"服务名称\",\"columnId\":2,\"columnName\":\"name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 19:34:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-07-10 19:35:42\",\"usableColumn\":false},{\"capJavaField\":\"Category\",\"columnComment\":\"服务类型\",\"columnId\":3,\"columnName\":\"category\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 19:34:11\",\"dictType\":\"serve_type\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"category\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-07-10 19:35:42\",\"usableColumn\":false},{\"capJavaField\":\"Image\",\"columnComment\":\"图片\",\"columnId\":4,\"columnName\":\"image\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 19:34:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"imageUpload\",\"increment\":false,\"inse', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 19:41:10', 18);
INSERT INTO `sys_oper_log` VALUES (149, '代码生成', 2, 'com.huacai.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '花菜编程', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"serve\",\"className\":\"Serve\",\"columns\":[{\"capJavaField\":\"ServeId\",\"columnComment\":\"服务ID\",\"columnId\":1,\"columnName\":\"serve_id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 19:34:11\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"serveId\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-07-10 19:41:10\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"服务名称\",\"columnId\":2,\"columnName\":\"name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 19:34:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-07-10 19:41:10\",\"usableColumn\":false},{\"capJavaField\":\"Category\",\"columnComment\":\"服务类型\",\"columnId\":3,\"columnName\":\"category\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 19:34:11\",\"dictType\":\"serve_type\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"category\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-07-10 19:41:10\",\"usableColumn\":false},{\"capJavaField\":\"Image\",\"columnComment\":\"图片\",\"columnId\":4,\"columnName\":\"image\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-10 19:34:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"imageUpload\",\"increment\":false,\"inse', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 19:41:51', 63);
INSERT INTO `sys_oper_log` VALUES (150, '代码生成', 8, 'com.huacai.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '花菜编程', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"serve\"}', NULL, 0, NULL, '2025-07-10 19:41:54', 253);
INSERT INTO `sys_oper_log` VALUES (151, '服务', 1, 'com.huacai.housekeeping.controller.ServeController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/serve', '127.0.0.1', '内网IP', '{\"category\":\"保洁服务\",\"createTime\":\"2025-07-10 19:46:44\",\"description\":\"12\",\"image\":\"/profile/upload/2025/07/10/宠物美容护理_20250710194640A001.png\",\"name\":\"12\",\"params\":{},\"price\":12,\"tag\":\"12\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'serve_id\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\MSI\\Desktop\\huacai-housekeeping\\huacai-housekeeping\\target\\classes\\mapper\\housekeeping\\ServeMapper.xml]\r\n### The error may involve com.huacai.housekeeping.mapper.ServeMapper.insertServe-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into serve          ( name,             category,             image,             description,             price,             tag,             create_time )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'serve_id\' doesn\'t have a default value\n; Field \'serve_id\' doesn\'t have a default value', '2025-07-10 19:46:45', 223);
INSERT INTO `sys_oper_log` VALUES (152, '服务', 1, 'com.huacai.housekeeping.controller.ServeController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/serve', '127.0.0.1', '内网IP', '{\"category\":\"保洁服务\",\"createTime\":\"2025-07-10 19:48:20\",\"description\":\"12\",\"image\":\"/profile/upload/2025/07/10/宠物美容护理_20250710194640A001.png\",\"name\":\"12\",\"params\":{},\"price\":12,\"tag\":\"12\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'serve_id\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\MSI\\Desktop\\huacai-housekeeping\\huacai-housekeeping\\target\\classes\\mapper\\housekeeping\\ServeMapper.xml]\r\n### The error may involve com.huacai.housekeeping.mapper.ServeMapper.insertServe-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into serve          ( name,             category,             image,             description,             price,             tag,             create_time )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'serve_id\' doesn\'t have a default value\n; Field \'serve_id\' doesn\'t have a default value', '2025-07-10 19:48:20', 16944);
INSERT INTO `sys_oper_log` VALUES (153, '服务', 1, 'com.huacai.housekeeping.controller.ServeController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/serve', '127.0.0.1', '内网IP', '{\"category\":\"保洁服务\",\"createTime\":\"2025-07-10 19:49:58\",\"description\":\"12\",\"image\":\"/profile/upload/2025/07/10/宠物美容护理_20250710194640A001.png\",\"name\":\"12\",\"params\":{},\"price\":12,\"serveId\":\"9afdc292e8244f9b97db7dbb0f14baaf\",\"tag\":\"12\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 19:49:58', 115);
INSERT INTO `sys_oper_log` VALUES (154, '服务', 2, 'com.huacai.housekeeping.controller.ServeController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/serve', '127.0.0.1', '内网IP', '{\"category\":\"保洁服务\",\"createTime\":\"2025-07-10 19:49:58\",\"description\":\"123\",\"image\":\"/profile/upload/2025/07/10/宠物美容护理_20250710194640A001.png\",\"name\":\"123\",\"params\":{},\"price\":123,\"serveId\":\"9afdc292e8244f9b97db7dbb0f14baaf\",\"tag\":\"123\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 19:50:11', 5);
INSERT INTO `sys_oper_log` VALUES (155, '服务', 3, 'com.huacai.housekeeping.controller.ServeController.remove()', 'DELETE', 1, 'admin', '花菜编程', '/housekeeping/serve/9afdc292e8244f9b97db7dbb0f14baaf', '127.0.0.1', '内网IP', '[\"9afdc292e8244f9b97db7dbb0f14baaf\"]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 19:50:49', 7);
INSERT INTO `sys_oper_log` VALUES (156, '菜单管理', 1, 'com.huacai.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '花菜编程', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"家政服务管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"housekeeping\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 19:54:02', 17);
INSERT INTO `sys_oper_log` VALUES (157, '菜单管理', 2, 'com.huacai.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '花菜编程', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"housekeeping/serve/index\",\"createTime\":\"2025-07-10 19:43:16\",\"icon\":\"build\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2006,\"menuName\":\"服务管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2012,\"path\":\"serve\",\"perms\":\"housekeeping:serve:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 19:54:36', 9);
INSERT INTO `sys_oper_log` VALUES (158, '菜单管理', 2, 'com.huacai.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '花菜编程', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-07-10 19:54:02\",\"icon\":\"家政服务\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2012,\"menuName\":\"家政服务管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"housekeeping\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 19:56:48', 6);
INSERT INTO `sys_oper_log` VALUES (159, '菜单管理', 2, 'com.huacai.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '花菜编程', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"housekeeping/serve/index\",\"createTime\":\"2025-07-10 19:43:16\",\"icon\":\"服务\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2006,\"menuName\":\"服务管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2012,\"path\":\"serve\",\"perms\":\"housekeeping:serve:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 19:56:53', 7);
INSERT INTO `sys_oper_log` VALUES (160, '服务', 1, 'com.huacai.housekeeping.controller.ServeController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/serve', '127.0.0.1', '内网IP', '{\"category\":\"保洁服务\",\"createTime\":\"2025-07-10 21:09:31\",\"description\":\"12\",\"image\":\"/profile/upload/2025/07/10/宠物美容护理_20250710210926A003.png\",\"name\":\"12\",\"params\":{},\"price\":12,\"serveId\":\"7af6f33947bf43a89c77599d69b40369\",\"tag\":\"12,21,33,44\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 21:09:31', 5);
INSERT INTO `sys_oper_log` VALUES (161, '服务', 3, 'com.huacai.housekeeping.controller.ServeController.remove()', 'DELETE', 1, 'admin', '花菜编程', '/housekeeping/serve/7af6f33947bf43a89c77599d69b40369', '127.0.0.1', '内网IP', '[\"7af6f33947bf43a89c77599d69b40369\"]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 21:21:02', 20);
INSERT INTO `sys_oper_log` VALUES (162, '服务', 6, 'com.huacai.housekeeping.controller.ServeController.importData()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/serve/importData', '127.0.0.1', '内网IP', '{\"updateSupport\":\"undefined\"}', '{\"msg\":\"导入成功0条信息！\",\"code\":200}', 0, NULL, '2025-07-10 21:23:09', 224);
INSERT INTO `sys_oper_log` VALUES (163, '服务', 6, 'com.huacai.housekeeping.controller.ServeController.importData()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/serve/importData', '127.0.0.1', '内网IP', '{\"updateSupport\":\"undefined\"}', '{\"msg\":\"导入成功0条信息！\",\"code\":200}', 0, NULL, '2025-07-10 21:26:01', 21);
INSERT INTO `sys_oper_log` VALUES (164, '服务', 6, 'com.huacai.housekeeping.controller.ServeController.importData()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/serve/importData', '127.0.0.1', '内网IP', '{\"updateSupport\":\"undefined\"}', '{\"msg\":\"导入成功0条信息！\",\"code\":200}', 0, NULL, '2025-07-10 21:28:37', 35768);
INSERT INTO `sys_oper_log` VALUES (165, '服务', 6, 'com.huacai.housekeeping.controller.ServeController.importData()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/serve/importData', '127.0.0.1', '内网IP', '{\"updateSupport\":\"undefined\"}', '{\"msg\":\"导入成功15条信息！\",\"code\":200}', 0, NULL, '2025-07-10 21:30:18', 734);
INSERT INTO `sys_oper_log` VALUES (166, '服务', 2, 'com.huacai.housekeeping.controller.ServeController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/serve', '127.0.0.1', '内网IP', '{\"category\":\"维修服务\",\"createTime\":\"2025-07-10 21:30:18\",\"description\":\"专业水电工上门服务，解决水管漏水、电路故障等常见问题\",\"image\":\"/profile/upload/2025/07/10/水电维修_20250710213635A002.png\",\"name\":\"水电维修\",\"params\":{},\"price\":150.0,\"serveId\":\"02929b4a92d14ee0991cb953cc3bd554\",\"tag\":\"水电维修,漏水处理,电路检修,紧急服务\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 21:36:36', 15);
INSERT INTO `sys_oper_log` VALUES (167, '服务', 1, 'com.huacai.housekeeping.controller.ServeController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/serve', '127.0.0.1', '内网IP', '{\"category\":\"保洁服务\",\"createTime\":\"2025-07-10 21:36:48\",\"description\":\"12\",\"image\":\"/profile/upload/2025/07/10/家电维修_20250710213643A003.png\",\"name\":\"12\",\"params\":{},\"price\":12.0,\"serveId\":\"faeb2e9e7d0e49e7874f0bb31f0e9309\",\"tag\":\"12,21,33\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 21:36:48', 4);
INSERT INTO `sys_oper_log` VALUES (168, '服务', 3, 'com.huacai.housekeeping.controller.ServeController.remove()', 'DELETE', 1, 'admin', '花菜编程', '/housekeeping/serve/faeb2e9e7d0e49e7874f0bb31f0e9309', '127.0.0.1', '内网IP', '[\"faeb2e9e7d0e49e7874f0bb31f0e9309\"]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 21:36:51', 6);
INSERT INTO `sys_oper_log` VALUES (169, '服务', 2, 'com.huacai.housekeeping.controller.ServeController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/serve', '127.0.0.1', '内网IP', '{\"category\":\"月嫂育儿\",\"createTime\":\"2025-07-10 21:30:18\",\"description\":\"有3年以上育儿经验，负责宝宝日常照料、辅食制作、早期教育等\",\"image\":\"/profile/upload/2025/07/10/专业育儿嫂_20250710213717A004.png\",\"name\":\"专业育儿嫂\",\"params\":{},\"price\":7500.0,\"serveId\":\"23f034009dcd41d0a6cf0b2c15a62a3c\",\"tag\":\"3年经验,辅食制作,早期教育,日常照料\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 21:37:18', 5);
INSERT INTO `sys_oper_log` VALUES (170, '服务', 2, 'com.huacai.housekeeping.controller.ServeController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/serve', '127.0.0.1', '内网IP', '{\"category\":\"宠物护理\",\"createTime\":\"2025-07-10 21:30:18\",\"description\":\"专业宠物护理师上门服务，包括喂食、遛狗、清理猫砂等\",\"image\":\"/profile/upload/2025/07/10/宠物上门喂养_20250710213732A006.png\",\"name\":\"宠物上门喂养\",\"params\":{},\"price\":88.0,\"serveId\":\"33dc7558a5d245508ed187817a284f84\",\"tag\":\"宠物喂养,遛狗服务,猫砂清理,宠物陪伴\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 21:37:33', 4);
INSERT INTO `sys_oper_log` VALUES (171, '服务', 2, 'com.huacai.housekeeping.controller.ServeController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/serve', '127.0.0.1', '内网IP', '{\"category\":\"老人陪护\",\"createTime\":\"2025-07-10 21:30:18\",\"description\":\"全天候专业老人护理，包括生活照料、服药提醒、夜间看护等\",\"image\":\"/profile/upload/2025/07/10/老人24小时陪护_20250710213740A007.png\",\"name\":\"老人24小时陪护\",\"params\":{},\"price\":280.0,\"serveId\":\"3827bcf413174065bf25ffee67ac7810\",\"tag\":\"24小时陪护,专业护理,服药提醒,夜间看护\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 21:37:42', 5);
INSERT INTO `sys_oper_log` VALUES (172, '服务', 2, 'com.huacai.housekeeping.controller.ServeController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/serve', '127.0.0.1', '内网IP', '{\"category\":\"宠物护理\",\"createTime\":\"2025-07-10 21:30:18\",\"description\":\"专业宠物美容师上门服务，包括洗澡、剪毛、指甲修剪等全套护理\",\"image\":\"/profile/upload/2025/07/10/宠物美容护理_20250710213747A008.png\",\"name\":\"宠物美容护理\",\"params\":{},\"price\":168.0,\"serveId\":\"3a055dac0dcc443ea327f466895d6798\",\"tag\":\"宠物美容,洗澡剪毛,指甲护理,上门服务\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 21:37:48', 4);
INSERT INTO `sys_oper_log` VALUES (173, '服务', 2, 'com.huacai.housekeeping.controller.ServeController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/serve', '127.0.0.1', '内网IP', '{\"category\":\"其他服务\",\"createTime\":\"2025-07-10 21:30:18\",\"description\":\"专业园艺师上门服务，提供植物养护、换盆施肥、病虫害防治等服务\",\"image\":\"/profile/upload/2025/07/10/家庭绿植养护_20250710213756A009.png\",\"name\":\"家庭绿植养护\",\"params\":{},\"price\":199.0,\"serveId\":\"52eec2fe0085496b827d3f12fd5757fc\",\"tag\":\"绿植养护,园艺服务,植物诊疗,定期维护\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 21:37:56', 5);
INSERT INTO `sys_oper_log` VALUES (174, '服务', 2, 'com.huacai.housekeeping.controller.ServeController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/serve', '127.0.0.1', '内网IP', '{\"category\":\"维修服务\",\"createTime\":\"2025-07-10 21:30:18\",\"description\":\"专业家电维修师傅，维修各类家用电器故障\",\"image\":\"/profile/upload/2025/07/10/家电维修_20250710213801A010.png\",\"name\":\"家电维修\",\"params\":{},\"price\":120.0,\"serveId\":\"64071fbd33794697aeb9ac4a4c535208\",\"tag\":\"家电维修,故障检测,配件更换,保修服务\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 21:38:02', 5);
INSERT INTO `sys_oper_log` VALUES (175, '服务', 2, 'com.huacai.housekeeping.controller.ServeController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/serve', '127.0.0.1', '内网IP', '{\"category\":\"保洁服务\",\"createTime\":\"2025-07-10 21:30:18\",\"description\":\"新房装修后首次保洁，彻底清除装修残留和灰尘\",\"image\":\"/profile/upload/2025/07/10/开荒保洁_20250710213809A011.png\",\"name\":\"开荒保洁\",\"params\":{},\"price\":680.0,\"serveId\":\"690f71935a6d450a81164967a0f92494\",\"tag\":\"新房开荒,深度清洁,装修残留清除,全屋打扫\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 21:38:10', 5);
INSERT INTO `sys_oper_log` VALUES (176, '服务', 2, 'com.huacai.housekeeping.controller.ServeController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/serve', '127.0.0.1', '内网IP', '{\"category\":\"月嫂育儿\",\"createTime\":\"2025-07-10 21:30:18\",\"description\":\"专业月嫂26天服务，科学护理母婴，包括新生儿护理、产妇护理、月子餐制作等\",\"image\":\"/profile/upload/2025/07/10/金牌月嫂服务_20250710213823A012.png\",\"name\":\"金牌月嫂服务\",\"params\":{},\"price\":12800.0,\"serveId\":\"8ea8d80661c34a909b058e92e255d38b\",\"tag\":\"26天服务,母婴护理,月子餐,专业培训\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 21:38:23', 4);
INSERT INTO `sys_oper_log` VALUES (177, '服务', 2, 'com.huacai.housekeeping.controller.ServeController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/serve', '127.0.0.1', '内网IP', '{\"category\":\"老人陪护\",\"createTime\":\"2025-07-10 21:30:18\",\"description\":\"8小时老人陪护，包括生活照料、陪伴聊天、简单家务等\",\"image\":\"/profile/upload/2025/07/10/老人日间陪护_20250710213829A013.png\",\"name\":\"老人日间陪护\",\"params\":{},\"price\":150.0,\"serveId\":\"8fd31bfedc56402f96830f1d31be124c\",\"tag\":\"8小时陪护,生活照料,陪伴聊天,简单家务\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 21:38:30', 5);
INSERT INTO `sys_oper_log` VALUES (178, '服务', 2, 'com.huacai.housekeeping.controller.ServeController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/serve', '127.0.0.1', '内网IP', '{\"category\":\"厨师服务\",\"createTime\":\"2025-07-10 21:30:18\",\"description\":\"专业厨师上门服务，根据您的口味定制3-4道菜品（含食材采购）\",\"image\":\"/profile/upload/2025/07/10/专业厨师上门_20250710213837A014.png\",\"name\":\"专业厨师上门\",\"params\":{},\"price\":398.0,\"serveId\":\"be76a520a55c4379b9192b0ac91678ac\",\"tag\":\"专业厨师,定制菜品,食材采购,厨房清洁\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 21:38:37', 4);
INSERT INTO `sys_oper_log` VALUES (179, '服务', 2, 'com.huacai.housekeeping.controller.ServeController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/serve', '127.0.0.1', '内网IP', '{\"category\":\"保洁服务\",\"createTime\":\"2025-07-10 21:30:18\",\"description\":\"专业保洁团队，4小时深度清洁，包括客厅、卧室、厨房、卫生间等全屋清洁\",\"image\":\"/profile/upload/2025/07/10/日常深度保洁_20250710213843A015.png\",\"name\":\"日常深度保洁\",\"params\":{},\"price\":198.0,\"serveId\":\"c6158a34eba547d49148bdd3623b6737\",\"tag\":\"深度清洁,全屋打扫,4小时服务,专业工具\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 21:38:44', 4);
INSERT INTO `sys_oper_log` VALUES (180, '服务', 2, 'com.huacai.housekeeping.controller.ServeController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/serve', '127.0.0.1', '内网IP', '{\"category\":\"其他服务\",\"createTime\":\"2025-07-10 21:30:18\",\"description\":\"专业收纳师上门服务，帮助整理衣橱、书房等空间，提供收纳方案\",\"image\":\"/profile/upload/2025/07/10/专业收纳整理_20250710213849A016.png\",\"name\":\"专业收纳整理\",\"params\":{},\"price\":499.0,\"serveId\":\"d78acc78f3a5485685d19cfb1f11d034\",\"tag\":\"专业收纳,空间规划,收纳方案,整理服务\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 21:38:49', 4);
INSERT INTO `sys_oper_log` VALUES (181, '服务', 2, 'com.huacai.housekeeping.controller.ServeController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/serve', '127.0.0.1', '内网IP', '{\"category\":\"厨师服务\",\"createTime\":\"2025-07-10 21:30:18\",\"description\":\"专业宴会厨师团队，提供8-10人份宴席制作（含食材采购和厨房清洁）\",\"image\":\"/profile/upload/2025/07/10/宴会厨师上门_20250710213856A017.png\",\"name\":\"宴会厨师上门\",\"params\":{},\"price\":1299.0,\"serveId\":\"f3dff13c039f43a79c278cc5858ad007\",\"tag\":\"宴会服务,团队服务,食材采购,厨房清洁\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 21:38:57', 3);
INSERT INTO `sys_oper_log` VALUES (182, '服务', 2, 'com.huacai.housekeeping.controller.ServeController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/serve', '127.0.0.1', '内网IP', '{\"category\":\"保洁服务\",\"createTime\":\"2025-07-10 21:30:18\",\"description\":\"长期固定钟点工，每周固定时间上门服务，负责日常清洁和简单家务\",\"image\":\"/profile/upload/2025/07/10/长期钟点工_20250710213905A018.png\",\"name\":\"长期钟点工\",\"params\":{},\"price\":35.0,\"serveId\":\"fe084b16962c49819978a310851cc08a\",\"tag\":\"长期服务,固定人员,日常清洁,简单家务\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 21:39:06', 5);
INSERT INTO `sys_oper_log` VALUES (183, '参数管理', 2, 'com.huacai.web.controller.system.SysConfigController.edit()', 'PUT', 1, 'admin', '花菜编程', '/system/config', '127.0.0.1', '内网IP', '{\"configId\":5,\"configKey\":\"sys.account.registerUser\",\"configName\":\"账号自助-是否开启用户注册功能\",\"configType\":\"Y\",\"configValue\":\"true\",\"createBy\":\"admin\",\"createTime\":\"2025-05-05 08:59:54\",\"params\":{},\"remark\":\"是否开启注册用户功能（true开启，false关闭）\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-10 23:03:51', 11);
INSERT INTO `sys_oper_log` VALUES (184, '代码生成', 3, 'com.huacai.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '花菜编程', '/tool/gen/1', '127.0.0.1', '内网IP', '[1]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:03:36', 41);
INSERT INTO `sys_oper_log` VALUES (185, '代码生成', 6, 'com.huacai.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '花菜编程', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"staff\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:03:40', 50);
INSERT INTO `sys_oper_log` VALUES (186, '代码生成', 2, 'com.huacai.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '花菜编程', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"staff\",\"className\":\"Staff\",\"columns\":[{\"capJavaField\":\"StaffId\",\"columnComment\":\"服务人员ID\",\"columnId\":9,\"columnName\":\"staff_id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-17 16:03:40\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"staffId\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"姓名\",\"columnId\":10,\"columnName\":\"name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-17 16:03:40\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Gender\",\"columnComment\":\"性别\",\"columnId\":11,\"columnName\":\"gender\",\"columnType\":\"varchar(10)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-17 16:03:40\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"gender\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Phone\",\"columnComment\":\"联系电话\",\"columnId\":12,\"columnName\":\"phone\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-17 16:03:40\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"p', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:04:24', 27);
INSERT INTO `sys_oper_log` VALUES (187, '字典类型', 1, 'com.huacai.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"服务人员状态\",\"dictType\":\"staff_status\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:05:19', 8);
INSERT INTO `sys_oper_log` VALUES (188, '字典数据', 1, 'com.huacai.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"空闲\",\"dictSort\":1,\"dictType\":\"staff_status\",\"dictValue\":\"空闲\",\"listClass\":\"info\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:05:48', 7);
INSERT INTO `sys_oper_log` VALUES (189, '字典数据', 1, 'com.huacai.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"服务中\",\"dictSort\":0,\"dictType\":\"staff_status\",\"dictValue\":\"服务中\",\"listClass\":\"warning\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:06:00', 5);
INSERT INTO `sys_oper_log` VALUES (190, '字典数据', 2, 'com.huacai.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '花菜编程', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-17 16:06:00\",\"default\":false,\"dictCode\":108,\"dictLabel\":\"服务中\",\"dictSort\":2,\"dictType\":\"staff_status\",\"dictValue\":\"服务中\",\"isDefault\":\"N\",\"listClass\":\"warning\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:06:04', 6);
INSERT INTO `sys_oper_log` VALUES (191, '字典类型', 1, 'com.huacai.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"性别\",\"dictType\":\"gender\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:06:55', 5);
INSERT INTO `sys_oper_log` VALUES (192, '字典数据', 1, 'com.huacai.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"男\",\"dictSort\":1,\"dictType\":\"gender\",\"dictValue\":\"男\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:07:02', 9);
INSERT INTO `sys_oper_log` VALUES (193, '字典数据', 1, 'com.huacai.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"女\",\"dictSort\":2,\"dictType\":\"gender\",\"dictValue\":\"女\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:07:08', 6);
INSERT INTO `sys_oper_log` VALUES (194, '代码生成', 2, 'com.huacai.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '花菜编程', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"staff\",\"className\":\"Staff\",\"columns\":[{\"capJavaField\":\"StaffId\",\"columnComment\":\"服务人员ID\",\"columnId\":9,\"columnName\":\"staff_id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-17 16:03:40\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"staffId\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-07-17 16:04:24\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"姓名\",\"columnId\":10,\"columnName\":\"name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-17 16:03:40\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-07-17 16:04:24\",\"usableColumn\":false},{\"capJavaField\":\"Gender\",\"columnComment\":\"性别\",\"columnId\":11,\"columnName\":\"gender\",\"columnType\":\"varchar(10)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-17 16:03:40\",\"dictType\":\"gender\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"gender\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-07-17 16:04:24\",\"usableColumn\":false},{\"capJavaField\":\"Phone\",\"columnComment\":\"联系电话\",\"columnId\":12,\"columnName\":\"phone\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-17 16:03:40\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isE', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:08:02', 17);
INSERT INTO `sys_oper_log` VALUES (195, '代码生成', 8, 'com.huacai.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '花菜编程', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"staff\"}', NULL, 0, NULL, '2025-07-17 16:08:04', 252);
INSERT INTO `sys_oper_log` VALUES (196, '菜单管理', 2, 'com.huacai.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '花菜编程', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"housekeeping/staff/index\",\"createTime\":\"2025-07-17 16:08:40\",\"icon\":\"build\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"服务人员\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2012,\"path\":\"staff\",\"perms\":\"housekeeping:staff:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:10:59', 29);
INSERT INTO `sys_oper_log` VALUES (197, '菜单管理', 2, 'com.huacai.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '花菜编程', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"housekeeping/staff/index\",\"createTime\":\"2025-07-17 16:08:40\",\"icon\":\"build\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"服务人员管理\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2012,\"path\":\"staff\",\"perms\":\"housekeeping:staff:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:11:11', 6);
INSERT INTO `sys_oper_log` VALUES (198, '菜单管理', 2, 'com.huacai.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '花菜编程', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"housekeeping/staff/index\",\"createTime\":\"2025-07-17 16:08:40\",\"icon\":\"服务人员\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"服务人员管理\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2012,\"path\":\"staff\",\"perms\":\"housekeeping:staff:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:12:14', 6);
INSERT INTO `sys_oper_log` VALUES (199, '服务人员', 1, 'com.huacai.housekeeping.controller.StaffController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-07-17 16:13:53\",\"gender\":\"男\",\"name\":\"张三\",\"params\":{},\"phone\":\"13699998888\",\"photo\":\"/profile/upload/2025/07/17/logo_20250717161347A001.png\",\"staffId\":\"625326b5ba104b708ec7a989127fdc48\",\"staffType\":\"保洁服务\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:13:53', 14);
INSERT INTO `sys_oper_log` VALUES (200, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-07-17 16:13:53\",\"gender\":\"女\",\"name\":\"张三\",\"params\":{},\"phone\":\"13699998888\",\"photo\":\"/profile/upload/2025/07/17/logo_20250717161347A001.png\",\"staffId\":\"625326b5ba104b708ec7a989127fdc48\",\"staffType\":\"保洁服务\",\"status\":\"空闲\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:14:16', 4);
INSERT INTO `sys_oper_log` VALUES (201, '服务人员', 3, 'com.huacai.housekeeping.controller.StaffController.remove()', 'DELETE', 1, 'admin', '花菜编程', '/housekeeping/staff/625326b5ba104b708ec7a989127fdc48', '127.0.0.1', '内网IP', '[\"625326b5ba104b708ec7a989127fdc48\"]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:14:49', 6);
INSERT INTO `sys_oper_log` VALUES (202, '服务人员', 6, 'com.huacai.housekeeping.controller.StaffController.importData()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/staff/importData', '127.0.0.1', '内网IP', '{\"updateSupport\":\"undefined\"}', '{\"msg\":\"导入成功0条信息！\",\"code\":200}', 0, NULL, '2025-07-17 16:17:26', 878);
INSERT INTO `sys_oper_log` VALUES (203, '服务人员', 6, 'com.huacai.housekeeping.controller.StaffController.importData()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/staff/importData', '127.0.0.1', '内网IP', '{\"updateSupport\":\"undefined\"}', '{\"msg\":\"导入成功18条信息！\",\"code\":200}', 0, NULL, '2025-07-17 16:17:50', 683);
INSERT INTO `sys_oper_log` VALUES (204, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-07-17 16:17:50\",\"gender\":\"女\",\"name\":\"张阿姨\",\"params\":{},\"phone\":\"13800138001\",\"photo\":\"/profile/upload/2025/07/17/保洁服务人员1_20250717161936A001.png\",\"staffId\":\"39074b7f7e3648d0a88216c48559a530\",\"staffType\":\"保洁服务\",\"status\":\"空闲\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:19:37', 10);
INSERT INTO `sys_oper_log` VALUES (205, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-07-17 16:17:50\",\"gender\":\"女\",\"name\":\"王师傅\",\"params\":{},\"phone\":\"13800138003\",\"photo\":\"/profile/upload/2025/07/17/保洁服务人员2_20250717161943A002.png\",\"staffId\":\"40f2e45f532d4b429f838bef8ca33990\",\"staffType\":\"保洁服务\",\"status\":\"空闲\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:19:43', 4);
INSERT INTO `sys_oper_log` VALUES (206, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-07-17 16:17:50\",\"gender\":\"女\",\"name\":\"李阿姨\",\"params\":{},\"phone\":\"13800138002\",\"photo\":\"/profile/upload/2025/07/17/保洁服务人员3_20250717161947A003.png\",\"staffId\":\"50c0e04d38934d199ec7fa0061b890cf\",\"staffType\":\"保洁服务\",\"status\":\"空闲\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:19:48', 4);
INSERT INTO `sys_oper_log` VALUES (207, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-07-17 16:17:50\",\"gender\":\"女\",\"name\":\"韩育儿\",\"params\":{},\"phone\":\"13800138018\",\"photo\":\"/profile/upload/2025/07/17/月嫂育儿人员1_20250717161957A004.png\",\"staffId\":\"4e5e6f5d7c8a40bd8f5d9accd8cebafc\",\"staffType\":\"月嫂育儿\",\"status\":\"空闲\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:19:57', 4);
INSERT INTO `sys_oper_log` VALUES (208, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-07-17 16:17:50\",\"gender\":\"女\",\"name\":\"沈月嫂\",\"params\":{},\"phone\":\"13800138017\",\"photo\":\"/profile/upload/2025/07/17/月嫂育儿人员2_20250717162001A005.png\",\"staffId\":\"a6300d46d75340ed8dbf730209a38b70\",\"staffType\":\"月嫂育儿\",\"status\":\"空闲\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:20:02', 3);
INSERT INTO `sys_oper_log` VALUES (209, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-07-17 16:17:50\",\"gender\":\"女\",\"name\":\"郑阿姨\",\"params\":{},\"phone\":\"13800138010\",\"photo\":\"/profile/upload/2025/07/17/老人陪护人员1_20250717162011A006.png\",\"staffId\":\"34b1bb6e1b074c5282d7b69bad2fcf34\",\"staffType\":\"老人陪护\",\"status\":\"空闲\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:20:11', 3);
INSERT INTO `sys_oper_log` VALUES (210, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-07-17 16:17:50\",\"gender\":\"女\",\"name\":\"李师傅\",\"params\":{},\"phone\":\"13800138012\",\"photo\":\"/profile/upload/2025/07/17/老人陪护人员2_20250717162015A007.png\",\"staffId\":\"6f22ada6b9d3494cb55da9f82a9e102c\",\"staffType\":\"老人陪护\",\"status\":\"空闲\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:20:16', 4);
INSERT INTO `sys_oper_log` VALUES (211, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-07-17 16:17:50\",\"gender\":\"女\",\"name\":\"孙护理\",\"params\":{},\"phone\":\"13800138011\",\"photo\":\"/profile/upload/2025/07/17/老人陪护人员3_20250717162019A008.png\",\"staffId\":\"a5925d9d5d9c4f7b9379621fe0c2fbb2\",\"staffType\":\"老人陪护\",\"status\":\"空闲\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:20:20', 4);
INSERT INTO `sys_oper_log` VALUES (212, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-07-17 16:17:50\",\"gender\":\"男\",\"name\":\"吴师傅\",\"params\":{},\"phone\":\"13800138009\",\"photo\":\"/profile/upload/2025/07/17/厨师服务人员1_20250717162030A009.png\",\"staffId\":\"1cdd8a0321df416199bfec1796496c46\",\"staffType\":\"厨师服务\",\"status\":\"空闲\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:20:31', 4);
INSERT INTO `sys_oper_log` VALUES (213, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-07-17 16:17:50\",\"gender\":\"男\",\"name\":\"周大厨\",\"params\":{},\"phone\":\"13800138008\",\"photo\":\"/profile/upload/2025/07/17/厨师服务人员2_20250717162035A010.png\",\"staffId\":\"750de7da46624e2ea06b2f68cdbc7840\",\"staffType\":\"厨师服务\",\"status\":\"空闲\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:20:35', 4);
INSERT INTO `sys_oper_log` VALUES (214, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-07-17 16:17:50\",\"gender\":\"女\",\"name\":\"赵护理\",\"params\":{},\"phone\":\"13800138006\",\"photo\":\"/profile/upload/2025/07/17/宠物护理人员1_20250717162043A011.png\",\"staffId\":\"a6e91faa5ad64abdba41919b821b5034\",\"staffType\":\"宠物护理\",\"status\":\"空闲\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:20:44', 3);
INSERT INTO `sys_oper_log` VALUES (215, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-07-17 16:17:50\",\"gender\":\"女\",\"name\":\"林护理\",\"params\":{},\"phone\":\"13800138005\",\"photo\":\"/profile/upload/2025/07/17/宠物护理人员2_20250717162047A012.png\",\"staffId\":\"b6b7713619744c62bf20c2d9927d77aa\",\"staffType\":\"宠物护理\",\"status\":\"空闲\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:20:48', 4);
INSERT INTO `sys_oper_log` VALUES (216, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-07-17 16:17:50\",\"gender\":\"女\",\"name\":\"陈医生\",\"params\":{},\"phone\":\"13800138004\",\"photo\":\"/profile/upload/2025/07/17/宠物护理人员3_20250717162052A013.png\",\"staffId\":\"cea9dca15c37453c940cb311611ab11b\",\"staffType\":\"宠物护理\",\"status\":\"空闲\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:20:52', 4);
INSERT INTO `sys_oper_log` VALUES (217, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-07-17 16:17:50\",\"gender\":\"女\",\"name\":\"钱护理\",\"params\":{},\"phone\":\"13800138007\",\"photo\":\"/profile/upload/2025/07/17/宠物护理人员4_20250717162057A014.png\",\"staffId\":\"e2a6da18039c4604b39e9d3c29e4d13f\",\"staffType\":\"宠物护理\",\"status\":\"空闲\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:20:58', 4);
INSERT INTO `sys_oper_log` VALUES (218, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-07-17 16:17:50\",\"gender\":\"男\",\"name\":\"卫维修\",\"params\":{},\"phone\":\"13800138015\",\"photo\":\"/profile/upload/2025/07/17/家电维修人员_20250717162128A015.png\",\"staffId\":\"2b117f2f8bcc420dbb1e00e491e5f032\",\"staffType\":\"维修服务\",\"status\":\"空闲\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:21:29', 4);
INSERT INTO `sys_oper_log` VALUES (219, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-07-17 16:17:50\",\"gender\":\"男\",\"name\":\"蒋师傅\",\"params\":{},\"phone\":\"13800138016\",\"photo\":\"/profile/upload/2025/07/17/水电维修人员_20250717162133A016.png\",\"staffId\":\"4ec1d82b9c1a4db69cf75e181416b6d2\",\"staffType\":\"维修服务\",\"status\":\"空闲\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:21:34', 5);
INSERT INTO `sys_oper_log` VALUES (220, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-07-17 16:17:50\",\"gender\":\"女\",\"name\":\"褚整理\",\"params\":{},\"phone\":\"13800138014\",\"photo\":\"/profile/upload/2025/07/17/专业收纳整理人员_20250717162153A017.png\",\"staffId\":\"166b8fd7099d4d6da1985eae25ffb045\",\"staffType\":\"其他服务\",\"status\":\"空闲\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:21:53', 3);
INSERT INTO `sys_oper_log` VALUES (221, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-07-17 16:17:50\",\"gender\":\"男\",\"name\":\"冯园艺\",\"params\":{},\"phone\":\"13800138013\",\"photo\":\"/profile/upload/2025/07/17/家庭绿植养护人员_20250717162200A018.png\",\"staffId\":\"c7ee938c6cd84066a70044c45e537bd1\",\"staffType\":\"其他服务\",\"status\":\"空闲\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 16:22:01', 4);
INSERT INTO `sys_oper_log` VALUES (222, '代码生成', 3, 'com.huacai.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '花菜编程', '/tool/gen/2', '127.0.0.1', '内网IP', '[2]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 21:57:46', 20);
INSERT INTO `sys_oper_log` VALUES (223, '代码生成', 6, 'com.huacai.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '花菜编程', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"reservation\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 21:57:49', 39);
INSERT INTO `sys_oper_log` VALUES (224, '字典类型', 1, 'com.huacai.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"预约状态\",\"dictType\":\"reservation_status\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 21:58:48', 7);
INSERT INTO `sys_oper_log` VALUES (225, '字典数据', 1, 'com.huacai.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"待支付\",\"dictSort\":1,\"dictType\":\"reservation_status\",\"dictValue\":\"待支付\",\"listClass\":\"warning\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 21:59:00', 7);
INSERT INTO `sys_oper_log` VALUES (226, '字典数据', 1, 'com.huacai.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"待确认\",\"dictSort\":2,\"dictType\":\"reservation_status\",\"dictValue\":\"待确认\",\"listClass\":\"info\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 21:59:16', 6);
INSERT INTO `sys_oper_log` VALUES (227, '字典数据', 1, 'com.huacai.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"已完成\",\"dictSort\":3,\"dictType\":\"reservation_status\",\"dictValue\":\"已完成\",\"listClass\":\"success\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 21:59:29', 6);
INSERT INTO `sys_oper_log` VALUES (228, '字典数据', 1, 'com.huacai.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"已取消\",\"dictSort\":4,\"dictType\":\"reservation_status\",\"dictValue\":\"已取消\",\"listClass\":\"danger\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 21:59:40', 6);
INSERT INTO `sys_oper_log` VALUES (229, '代码生成', 2, 'com.huacai.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '花菜编程', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"reservation\",\"className\":\"Reservation\",\"columns\":[{\"capJavaField\":\"ReservationId\",\"columnComment\":\"预约ID\",\"columnId\":17,\"columnName\":\"reservation_id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-17 21:57:49\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"reservationId\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ServeId\",\"columnComment\":\"服务ID\",\"columnId\":18,\"columnName\":\"serve_id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-17 21:57:49\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"serveId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Time\",\"columnComment\":\"预约服务时间\",\"columnId\":19,\"columnName\":\"time\",\"columnType\":\"datetime\",\"createBy\":\"admin\",\"createTime\":\"2025-07-17 21:57:49\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"time\",\"javaType\":\"Date\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"BETWEEN\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Address\",\"columnComment\":\"预约服务地址\",\"columnId\":20,\"columnName\":\"address\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-07-17 21:57:49\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"is', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 22:01:51', 27);
INSERT INTO `sys_oper_log` VALUES (230, '代码生成', 8, 'com.huacai.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '花菜编程', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"reservation\"}', NULL, 0, NULL, '2025-07-17 22:01:53', 243);
INSERT INTO `sys_oper_log` VALUES (231, '菜单管理', 2, 'com.huacai.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '花菜编程', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"housekeeping/reservation/index\",\"createTime\":\"2025-07-17 22:02:20\",\"icon\":\"预约\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2019,\"menuName\":\"预约管理\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":3,\"path\":\"reservation\",\"perms\":\"housekeeping:reservation:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 22:05:04', 29);
INSERT INTO `sys_oper_log` VALUES (232, '菜单管理', 2, 'com.huacai.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '花菜编程', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"housekeeping/reservation/index\",\"createTime\":\"2025-07-17 22:02:20\",\"icon\":\"预约\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2019,\"menuName\":\"预约管理\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2012,\"path\":\"reservation\",\"perms\":\"housekeeping:reservation:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 22:05:14', 7);
INSERT INTO `sys_oper_log` VALUES (233, '预约', 1, 'com.huacai.housekeeping.controller.ReservationController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/reservation', '127.0.0.1', '内网IP', '{\"address\":\"12\",\"contacts\":\"12\",\"createTime\":\"2025-07-17 22:11:29\",\"params\":{},\"phone\":\"12\",\"reservationId\":\"22b4b5b06fbb48f79d4e935a3381c620\",\"serveId\":\"12\",\"special\":\"12\",\"staffId\":\"12\",\"time\":\"2025-07-17\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 22:11:29', 108);
INSERT INTO `sys_oper_log` VALUES (234, '预约', 2, 'com.huacai.housekeeping.controller.ReservationController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/reservation', '127.0.0.1', '内网IP', '{\"address\":\"1212\",\"contacts\":\"1212\",\"createTime\":\"2025-07-17 22:11:30\",\"params\":{},\"phone\":\"1212\",\"reservationId\":\"22b4b5b06fbb48f79d4e935a3381c620\",\"serveId\":\"12\",\"special\":\"1212\",\"staffId\":\"1212\",\"status\":\"待支付\",\"time\":\"2025-07-17\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 22:11:37', 5);
INSERT INTO `sys_oper_log` VALUES (235, '预约', 3, 'com.huacai.housekeeping.controller.ReservationController.remove()', 'DELETE', 1, 'admin', '花菜编程', '/housekeeping/reservation/22b4b5b06fbb48f79d4e935a3381c620', '127.0.0.1', '内网IP', '[\"22b4b5b06fbb48f79d4e935a3381c620\"]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 22:11:52', 6);
INSERT INTO `sys_oper_log` VALUES (236, '预约', 1, 'com.huacai.housekeeping.controller.ReservationController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/reservation', '127.0.0.1', '内网IP', '{\"address\":\"12\",\"contacts\":\"12\",\"createTime\":\"2025-07-17 22:12:20\",\"params\":{},\"phone\":\"12\",\"reservationId\":\"43bf2ef81a444feeaf12ce57f2c2fc6c\",\"serveId\":\"12\",\"special\":\"12\",\"staffId\":\"\",\"time\":\"2025-07-17\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 22:12:20', 4);
INSERT INTO `sys_oper_log` VALUES (237, '预约', 2, 'com.huacai.housekeeping.controller.ReservationController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/reservation', '127.0.0.1', '内网IP', '{\"address\":\"12\",\"contacts\":\"12\",\"createTime\":\"2025-07-17 22:12:21\",\"params\":{},\"phone\":\"12\",\"reservationId\":\"43bf2ef81a444feeaf12ce57f2c2fc6c\",\"serveId\":\"12\",\"special\":\"12\",\"staffId\":\"\",\"status\":\"待支付\",\"time\":\"2025-07-18 09:00:00\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 22:15:21', 29);
INSERT INTO `sys_oper_log` VALUES (238, '预约', 2, 'com.huacai.housekeeping.controller.ReservationController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/reservation', '127.0.0.1', '内网IP', '{\"address\":\"12\",\"contacts\":\"12\",\"createTime\":\"2025-07-17 22:12:21\",\"params\":{},\"phone\":\"12\",\"reservationId\":\"43bf2ef81a444feeaf12ce57f2c2fc6c\",\"serveId\":\"02929b4a92d14ee0991cb953cc3bd554\",\"special\":\"12\",\"staffId\":\"\",\"status\":\"待支付\",\"time\":\"2025-07-18 09:00:00\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 22:27:42', 29);
INSERT INTO `sys_oper_log` VALUES (239, '预约', 2, 'com.huacai.housekeeping.controller.ReservationController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/reservation', '127.0.0.1', '内网IP', '{\"address\":\"成都市青羊区666号\",\"contacts\":\"张三\",\"createTime\":\"2025-07-17 22:12:21\",\"params\":{},\"phone\":\"13699998888\",\"reservationId\":\"43bf2ef81a444feeaf12ce57f2c2fc6c\",\"serveId\":\"02929b4a92d14ee0991cb953cc3bd554\",\"special\":\"没有特别要求\",\"staffId\":\"\",\"status\":\"待支付\",\"time\":\"2025-07-18 09:00:00\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 01:34:17', 28);
INSERT INTO `sys_oper_log` VALUES (240, '预约', 1, 'com.huacai.housekeeping.controller.ReservationController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/reservation', '127.0.0.1', '内网IP', '{\"address\":\"成都市武侯区666号\",\"contacts\":\"王杨\",\"createTime\":\"2025-07-19 01:50:39\",\"params\":{},\"phone\":\"13922223333\",\"price\":null,\"reservationId\":\"0869970caed6415f901268a9c6f7e5f0\",\"serveId\":\"3827bcf413174065bf25ffee67ac7810\",\"time\":\"2025-07-20 12:00:00\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 01:50:39', 20);
INSERT INTO `sys_oper_log` VALUES (241, '预约', 1, 'com.huacai.housekeeping.controller.ReservationController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/reservation', '127.0.0.1', '内网IP', '{\"address\":\"112\",\"contacts\":\"12\",\"createTime\":\"2025-07-19 01:51:46\",\"params\":{},\"phone\":\"12\",\"price\":null,\"reservationId\":\"7246e0b5164a42ccb50ee0d2bc1f7275\",\"serveId\":\"52eec2fe0085496b827d3f12fd5757fc\",\"special\":\"12\",\"time\":\"2025-07-26 00:00:00\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 01:51:46', 5);
INSERT INTO `sys_oper_log` VALUES (242, '预约', 3, 'com.huacai.housekeeping.controller.ReservationController.remove()', 'DELETE', 1, 'admin', '花菜编程', '/housekeeping/reservation/7246e0b5164a42ccb50ee0d2bc1f7275', '127.0.0.1', '内网IP', '[\"7246e0b5164a42ccb50ee0d2bc1f7275\"]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 01:52:00', 7);
INSERT INTO `sys_oper_log` VALUES (243, '预约', 2, 'com.huacai.housekeeping.controller.ReservationController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/reservation', '127.0.0.1', '内网IP', '{\"address\":\"成都市青羊区666号\",\"contacts\":\"张三\",\"createTime\":\"2025-07-17 22:12:21\",\"params\":{},\"phone\":\"13699998888\",\"price\":null,\"reservationId\":\"43bf2ef81a444feeaf12ce57f2c2fc6c\",\"serveId\":\"02929b4a92d14ee0991cb953cc3bd554\",\"special\":\"没有特别要求\",\"staffId\":\"\",\"status\":\"待支付\",\"time\":\"2025-07-21 09:00:00\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 01:52:12', 4);
INSERT INTO `sys_oper_log` VALUES (244, '预约', 2, 'com.huacai.housekeeping.controller.ReservationController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/reservation', '127.0.0.1', '内网IP', '{\"params\":{},\"price\":null,\"reservationId\":\"43bf2ef81a444feeaf12ce57f2c2fc6c\",\"staffId\":\"2b117f2f8bcc420dbb1e00e491e5f032\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 21:31:31', 20);
INSERT INTO `sys_oper_log` VALUES (245, '预约', 2, 'com.huacai.housekeeping.controller.ReservationController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/reservation', '127.0.0.1', '内网IP', '{\"params\":{},\"price\":null,\"reservationId\":\"43bf2ef81a444feeaf12ce57f2c2fc6c\",\"staffId\":\"4ec1d82b9c1a4db69cf75e181416b6d2\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 21:31:57', 4);
INSERT INTO `sys_oper_log` VALUES (246, '代码生成', 3, 'com.huacai.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '花菜编程', '/tool/gen/3', '127.0.0.1', '内网IP', '[3]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 23:37:51', 42);
INSERT INTO `sys_oper_log` VALUES (247, '代码生成', 6, 'com.huacai.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '花菜编程', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"cancel\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 23:37:53', 42);
INSERT INTO `sys_oper_log` VALUES (248, '字典类型', 1, 'com.huacai.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"取消原因\",\"dictType\":\"cancel_reason\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 23:38:58', 10);
INSERT INTO `sys_oper_log` VALUES (249, '字典数据', 1, 'com.huacai.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"时间变更\",\"dictSort\":1,\"dictType\":\"cancel_reason\",\"dictValue\":\"时间变更\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 23:39:06', 8);
INSERT INTO `sys_oper_log` VALUES (250, '字典数据', 1, 'com.huacai.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"不需要服务了\",\"dictSort\":2,\"dictType\":\"cancel_reason\",\"dictValue\":\"不需要服务了\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 23:39:11', 6);
INSERT INTO `sys_oper_log` VALUES (251, '字典数据', 1, 'com.huacai.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"找到其他服务商\",\"dictSort\":3,\"dictType\":\"cancel_reason\",\"dictValue\":\"找到其他服务商\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 23:39:15', 7);
INSERT INTO `sys_oper_log` VALUES (252, '字典数据', 1, 'com.huacai.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"价格问题\",\"dictSort\":4,\"dictType\":\"cancel_reason\",\"dictValue\":\"价格问题\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 23:39:21', 7);
INSERT INTO `sys_oper_log` VALUES (253, '字典数据', 1, 'com.huacai.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"其他原因\",\"dictSort\":5,\"dictType\":\"cancel_reason\",\"dictValue\":\"其他原因\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 23:39:26', 6);
INSERT INTO `sys_oper_log` VALUES (254, '代码生成', 2, 'com.huacai.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '花菜编程', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"cancel\",\"className\":\"Cancel\",\"columns\":[{\"capJavaField\":\"CancelId\",\"columnComment\":\"取消记录ID\",\"columnId\":28,\"columnName\":\"cancel_id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-19 23:37:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cancelId\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ReservationId\",\"columnComment\":\"订单编号\",\"columnId\":29,\"columnName\":\"reservation_id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-19 23:37:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"reservationId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Reason\",\"columnComment\":\"取消原因\",\"columnId\":30,\"columnName\":\"reason\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-19 23:37:53\",\"dictType\":\"cancel_reason\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"reason\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Notes\",\"columnComment\":\"备注\",\"columnId\":31,\"columnName\":\"notes\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-07-19 23:37:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"i', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 23:40:45', 27);
INSERT INTO `sys_oper_log` VALUES (255, '代码生成', 8, 'com.huacai.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '花菜编程', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"cancel\"}', NULL, 0, NULL, '2025-07-19 23:40:47', 242);
INSERT INTO `sys_oper_log` VALUES (256, '菜单管理', 2, 'com.huacai.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '花菜编程', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"housekeeping/cancel/index\",\"createTime\":\"2025-07-19 23:41:16\",\"icon\":\"记录\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2025,\"menuName\":\"取消记录\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2012,\"path\":\"cancel\",\"perms\":\"housekeeping:cancel:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 23:43:39', 31);
INSERT INTO `sys_oper_log` VALUES (257, '取消记录', 1, 'com.huacai.housekeeping.controller.CancelController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/cancel', '127.0.0.1', '内网IP', '{\"cancelId\":\"ccf95450ebf642158a3ac7905e5511fc\",\"createTime\":\"2025-07-19 23:44:50\",\"notes\":\"12\",\"params\":{},\"reason\":\"时间变更\",\"reservationId\":\"12\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 23:44:51', 17);
INSERT INTO `sys_oper_log` VALUES (258, '取消记录', 2, 'com.huacai.housekeeping.controller.CancelController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/cancel', '127.0.0.1', '内网IP', '{\"cancelId\":\"ccf95450ebf642158a3ac7905e5511fc\",\"createTime\":\"2025-07-19 23:44:51\",\"notes\":\"121\",\"params\":{},\"reason\":\"时间变更\",\"reservationId\":\"121\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 23:44:54', 4);
INSERT INTO `sys_oper_log` VALUES (259, '取消记录', 3, 'com.huacai.housekeeping.controller.CancelController.remove()', 'DELETE', 1, 'admin', '花菜编程', '/housekeeping/cancel/ccf95450ebf642158a3ac7905e5511fc', '127.0.0.1', '内网IP', '[\"ccf95450ebf642158a3ac7905e5511fc\"]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 23:45:09', 7);
INSERT INTO `sys_oper_log` VALUES (260, '取消记录', 2, 'com.huacai.housekeeping.controller.CancelController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/cancel', '127.0.0.1', '内网IP', '{\"params\":{},\"reservationId\":\"0869970caed6415f901268a9c6f7e5f0\"}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2025-07-20 00:08:34', 2);
INSERT INTO `sys_oper_log` VALUES (261, '取消记录', 1, 'com.huacai.housekeeping.controller.CancelController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/cancel', '127.0.0.1', '内网IP', '{\"cancelId\":\"7fc42084cb304a18a594bcd959539763\",\"createTime\":\"2025-07-20 00:10:08\",\"params\":{},\"reason\":\"不需要服务了\",\"reservationId\":\"0869970caed6415f901268a9c6f7e5f0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 00:10:08', 4);
INSERT INTO `sys_oper_log` VALUES (262, '预约', 2, 'com.huacai.housekeeping.controller.ReservationController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/reservation', '127.0.0.1', '内网IP', '{\"params\":{},\"price\":null,\"reservationId\":\"0869970caed6415f901268a9c6f7e5f0\",\"status\":\"已取消\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 00:10:08', 9);
INSERT INTO `sys_oper_log` VALUES (263, '预约', 2, 'com.huacai.housekeeping.controller.ReservationController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/reservation', '127.0.0.1', '内网IP', '{\"params\":{},\"price\":null,\"reservationId\":\"43bf2ef81a444feeaf12ce57f2c2fc6c\",\"status\":\"已完成\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 00:23:20', 4);
INSERT INTO `sys_oper_log` VALUES (264, '代码生成', 3, 'com.huacai.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '花菜编程', '/tool/gen/4', '127.0.0.1', '内网IP', '[4]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 15:51:21', 42);
INSERT INTO `sys_oper_log` VALUES (265, '代码生成', 6, 'com.huacai.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '花菜编程', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"assess\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 15:51:23', 47);
INSERT INTO `sys_oper_log` VALUES (266, '字典类型', 1, 'com.huacai.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"是否推送\",\"dictType\":\"go_index\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 15:52:06', 8);
INSERT INTO `sys_oper_log` VALUES (267, '字典数据', 1, 'com.huacai.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"否\",\"dictSort\":1,\"dictType\":\"go_index\",\"dictValue\":\"否\",\"listClass\":\"info\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 15:52:17', 9);
INSERT INTO `sys_oper_log` VALUES (268, '字典数据', 1, 'com.huacai.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '花菜编程', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"推送\",\"dictSort\":2,\"dictType\":\"go_index\",\"dictValue\":\"推送\",\"listClass\":\"success\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 15:52:26', 7);
INSERT INTO `sys_oper_log` VALUES (269, '代码生成', 2, 'com.huacai.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '花菜编程', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"assess\",\"className\":\"Assess\",\"columns\":[{\"capJavaField\":\"AssessId\",\"columnComment\":\"评价ID\",\"columnId\":33,\"columnName\":\"assess_id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 15:51:23\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"assessId\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ReservationId\",\"columnComment\":\"订单编号\",\"columnId\":34,\"columnName\":\"reservation_id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 15:51:23\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"reservationId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Score\",\"columnComment\":\"服务评分\",\"columnId\":35,\"columnName\":\"score\",\"columnType\":\"double\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 15:51:23\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"score\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Content\",\"columnComment\":\"评价内容\",\"columnId\":36,\"columnName\":\"content\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 15:51:23\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequi', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 15:53:19', 24);
INSERT INTO `sys_oper_log` VALUES (270, '代码生成', 8, 'com.huacai.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '花菜编程', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"assess\"}', NULL, 0, NULL, '2025-07-20 15:53:21', 222);
INSERT INTO `sys_oper_log` VALUES (271, '代码生成', 2, 'com.huacai.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '花菜编程', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"assess\",\"className\":\"Assess\",\"columns\":[{\"capJavaField\":\"AssessId\",\"columnComment\":\"评价ID\",\"columnId\":33,\"columnName\":\"assess_id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 15:51:23\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"assessId\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"updateTime\":\"2025-07-20 15:53:19\",\"usableColumn\":false},{\"capJavaField\":\"ReservationId\",\"columnComment\":\"订单编号\",\"columnId\":34,\"columnName\":\"reservation_id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 15:51:23\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"reservationId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"updateTime\":\"2025-07-20 15:53:19\",\"usableColumn\":false},{\"capJavaField\":\"Score\",\"columnComment\":\"服务评分\",\"columnId\":35,\"columnName\":\"score\",\"columnType\":\"double\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 15:51:23\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"score\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"updateTime\":\"2025-07-20 15:53:19\",\"usableColumn\":false},{\"capJavaField\":\"Content\",\"columnComment\":\"评价内容\",\"columnId\":36,\"columnName\":\"content\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 15:51:23\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 15:53:31', 12);
INSERT INTO `sys_oper_log` VALUES (272, '代码生成', 8, 'com.huacai.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '花菜编程', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"assess\"}', NULL, 0, NULL, '2025-07-20 15:53:32', 81);
INSERT INTO `sys_oper_log` VALUES (273, '菜单管理', 2, 'com.huacai.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '花菜编程', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"housekeeping/assess/index\",\"createTime\":\"2025-07-20 15:53:57\",\"icon\":\"评价\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2031,\"menuName\":\"评价管理\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2012,\"path\":\"assess\",\"perms\":\"housekeeping:assess:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 15:56:54', 27);
INSERT INTO `sys_oper_log` VALUES (274, '评价', 1, 'com.huacai.housekeeping.controller.AssessController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/assess', '127.0.0.1', '内网IP', '{\"assessId\":\"6ac773be1ffa4389abe6691b5e9c5836\",\"createTime\":\"2025-07-20 15:59:04\",\"params\":{},\"reservationId\":\"1\",\"score\":2.5}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 15:59:05', 107);
INSERT INTO `sys_oper_log` VALUES (275, '评价', 2, 'com.huacai.housekeeping.controller.AssessController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/assess', '127.0.0.1', '内网IP', '{\"assessId\":\"6ac773be1ffa4389abe6691b5e9c5836\",\"content\":\"122121\",\"createTime\":\"2025-07-20 15:59:05\",\"goIndex\":\"否\",\"params\":{},\"reservationId\":\"112\",\"score\":3.0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 15:59:37', 6);
INSERT INTO `sys_oper_log` VALUES (276, '评价', 3, 'com.huacai.housekeeping.controller.AssessController.remove()', 'DELETE', 1, 'admin', '花菜编程', '/housekeeping/assess/6ac773be1ffa4389abe6691b5e9c5836', '127.0.0.1', '内网IP', '[\"6ac773be1ffa4389abe6691b5e9c5836\"]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 15:59:47', 6);
INSERT INTO `sys_oper_log` VALUES (277, '评价', 1, 'com.huacai.housekeeping.controller.AssessController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/assess', '127.0.0.1', '内网IP', '{\"assessId\":\"2d29851321bf4b1ab3fca9bf41ffa457\",\"content\":\"121\",\"createTime\":\"2025-07-20 16:01:02\",\"params\":{},\"reservationId\":\"121\",\"score\":3.5}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 16:01:02', 5);
INSERT INTO `sys_oper_log` VALUES (278, '评价', 1, 'com.huacai.housekeeping.controller.AssessController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/assess', '127.0.0.1', '内网IP', '{\"assessId\":\"4df50ab773994039b4870e290dfad91b\",\"content\":\"师傅非常专业, 维修技术很好, 很有耐心, 强烈推荐!!\",\"createTime\":\"2025-07-20 19:50:22\",\"params\":{},\"reservationId\":\"43bf2ef81a444feeaf12ce57f2c2fc6c\",\"score\":5.0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 19:50:22', 4);
INSERT INTO `sys_oper_log` VALUES (279, '评价', 3, 'com.huacai.housekeeping.controller.AssessController.remove()', 'DELETE', 1, 'admin', '花菜编程', '/housekeeping/assess/2d29851321bf4b1ab3fca9bf41ffa457', '127.0.0.1', '内网IP', '[\"2d29851321bf4b1ab3fca9bf41ffa457\"]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 19:50:34', 3);
INSERT INTO `sys_oper_log` VALUES (280, '代码生成', 3, 'com.huacai.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '花菜编程', '/tool/gen/5', '127.0.0.1', '内网IP', '[5]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 20:13:17', 21);
INSERT INTO `sys_oper_log` VALUES (281, '代码生成', 6, 'com.huacai.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '花菜编程', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"banner\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 20:13:18', 43);
INSERT INTO `sys_oper_log` VALUES (282, '代码生成', 2, 'com.huacai.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '花菜编程', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"banner\",\"className\":\"Banner\",\"columns\":[{\"capJavaField\":\"BannerId\",\"columnComment\":\"轮播图ID\",\"columnId\":39,\"columnName\":\"banner_id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 20:13:18\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"bannerId\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Image\",\"columnComment\":\"图片\",\"columnId\":40,\"columnName\":\"image\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 20:13:18\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"imageUpload\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"image\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"名称\",\"columnId\":41,\"columnName\":\"title\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 20:13:18\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"title\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Description\",\"columnComment\":\"描述\",\"columnId\":42,\"columnName\":\"description\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 20:13:18\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isReq', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 20:13:59', 22);
INSERT INTO `sys_oper_log` VALUES (283, '代码生成', 8, 'com.huacai.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '花菜编程', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"banner\"}', NULL, 0, NULL, '2025-07-20 20:14:01', 223);
INSERT INTO `sys_oper_log` VALUES (284, '菜单管理', 2, 'com.huacai.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '花菜编程', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"housekeeping/banner/index\",\"createTime\":\"2025-07-20 20:14:23\",\"icon\":\"轮播图\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2037,\"menuName\":\"轮播图\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":2012,\"path\":\"banner\",\"perms\":\"housekeeping:banner:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 20:17:01', 24);
INSERT INTO `sys_oper_log` VALUES (285, '菜单管理', 2, 'com.huacai.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '花菜编程', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"housekeeping/banner/index\",\"createTime\":\"2025-07-20 20:14:23\",\"icon\":\"轮播图\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2037,\"menuName\":\"轮播图管理\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":2012,\"path\":\"banner\",\"perms\":\"housekeeping:banner:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 20:17:13', 7);
INSERT INTO `sys_oper_log` VALUES (286, '轮播图', 1, 'com.huacai.housekeeping.controller.BannerController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/banner', '127.0.0.1', '内网IP', '{\"bannerId\":\"458857f1fabb424b8ee2ee016e4884bd\",\"description\":\"1\",\"image\":\"/profile/upload/2025/07/20/logo_20250720201727A001.png\",\"params\":{},\"sort\":1,\"title\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 20:17:29', 9);
INSERT INTO `sys_oper_log` VALUES (287, '轮播图', 2, 'com.huacai.housekeeping.controller.BannerController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/banner', '127.0.0.1', '内网IP', '{\"bannerId\":\"458857f1fabb424b8ee2ee016e4884bd\",\"description\":\"12\",\"image\":\"/profile/upload/2025/07/20/logo_20250720201727A001.png\",\"params\":{},\"sort\":12,\"title\":\"12\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 20:17:32', 5);
INSERT INTO `sys_oper_log` VALUES (288, '轮播图', 3, 'com.huacai.housekeeping.controller.BannerController.remove()', 'DELETE', 1, 'admin', '花菜编程', '/housekeeping/banner/458857f1fabb424b8ee2ee016e4884bd', '127.0.0.1', '内网IP', '[\"458857f1fabb424b8ee2ee016e4884bd\"]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 20:17:40', 6);
INSERT INTO `sys_oper_log` VALUES (289, '轮播图', 1, 'com.huacai.housekeeping.controller.BannerController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/banner', '127.0.0.1', '内网IP', '{\"bannerId\":\"8c41ce8b76254a82832f092ed4082bc5\",\"description\":\"专业月嫂团队, 呵护母婴健康\",\"image\":\"/profile/upload/2025/07/20/金牌月嫂服务_20250720201842A002.jpg\",\"params\":{},\"sort\":1,\"title\":\"金牌月嫂服务\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 20:19:11', 5);
INSERT INTO `sys_oper_log` VALUES (290, '轮播图', 1, 'com.huacai.housekeeping.controller.BannerController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/banner', '127.0.0.1', '内网IP', '{\"bannerId\":\"877a09c9e81745fd9bf31c2e007236a6\",\"description\":\"星级大厨为您定制私房美味，让家宴更美味\",\"image\":\"/profile/upload/2025/07/20/专业厨师上门_20250720201919A003.jpg\",\"params\":{},\"sort\":2,\"title\":\"专业出事上门\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 20:19:40', 3);
INSERT INTO `sys_oper_log` VALUES (291, '轮播图', 1, 'com.huacai.housekeeping.controller.BannerController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/banner', '127.0.0.1', '内网IP', '{\"bannerId\":\"c021d8189759434089dcf0a53897ec30\",\"description\":\"为您提供高品质的家政服务体验\",\"image\":\"/profile/upload/2025/07/20/专业家政服务_20250720201944A004.jpg\",\"params\":{},\"sort\":3,\"title\":\"专业家政服务\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 20:19:54', 3);
INSERT INTO `sys_oper_log` VALUES (292, '轮播图', 2, 'com.huacai.housekeeping.controller.BannerController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/banner', '127.0.0.1', '内网IP', '{\"bannerId\":\"877a09c9e81745fd9bf31c2e007236a6\",\"description\":\"星级大厨为您定制私房美味，让家宴更美味\",\"image\":\"/profile/upload/2025/07/20/专业厨师上门_20250720201919A003.jpg\",\"params\":{},\"sort\":2,\"title\":\"专业厨师上门\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 20:39:24', 22);
INSERT INTO `sys_oper_log` VALUES (293, '预约', 2, 'com.huacai.housekeeping.controller.ReservationController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/reservation', '127.0.0.1', '内网IP', '{\"params\":{},\"price\":null,\"reservationId\":\"43bf2ef81a444feeaf12ce57f2c2fc6c\",\"staffId\":\"4ec1d82b9c1a4db69cf75e181416b6d2\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 21:19:33', 9);
INSERT INTO `sys_oper_log` VALUES (294, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"params\":{},\"staffId\":\"4ec1d82b9c1a4db69cf75e181416b6d2\",\"status\":\"服务中\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 21:19:33', 9);
INSERT INTO `sys_oper_log` VALUES (295, '预约', 1, 'com.huacai.housekeeping.controller.ReservationController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/reservation', '127.0.0.1', '内网IP', '{\"address\":\"成都市武侯区666号\",\"contacts\":\"花菜\",\"createTime\":\"2025-07-20 21:33:29\",\"params\":{},\"phone\":\"13699998888\",\"price\":null,\"reservationId\":\"dd89249def884c8f95b525e03b0968d6\",\"serveId\":\"c6158a34eba547d49148bdd3623b6737\",\"time\":\"2025-07-21 09:00:00\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 21:33:29', 15);
INSERT INTO `sys_oper_log` VALUES (296, '预约', 1, 'com.huacai.housekeeping.controller.ReservationController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/reservation', '127.0.0.1', '内网IP', '{\"address\":\"成都市青羊区999号\",\"contacts\":\"赵六\",\"createTime\":\"2025-07-20 21:34:13\",\"params\":{},\"phone\":\"13677772222\",\"price\":null,\"reservationId\":\"dd9f58794d94415fa6bd23e36cb263d0\",\"serveId\":\"23f034009dcd41d0a6cf0b2c15a62a3c\",\"time\":\"2025-07-22 12:00:00\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 21:34:13', 3);
INSERT INTO `sys_oper_log` VALUES (297, '预约', 2, 'com.huacai.housekeeping.controller.ReservationController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/reservation', '127.0.0.1', '内网IP', '{\"params\":{},\"price\":null,\"reservationId\":\"43bf2ef81a444feeaf12ce57f2c2fc6c\",\"status\":\"已完成\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 21:34:56', 3);
INSERT INTO `sys_oper_log` VALUES (298, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"params\":{},\"staffId\":\"4ec1d82b9c1a4db69cf75e181416b6d2\",\"status\":\"空闲\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 21:34:56', 3);
INSERT INTO `sys_oper_log` VALUES (299, '预约', 2, 'com.huacai.housekeeping.controller.ReservationController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/reservation', '127.0.0.1', '内网IP', '{\"params\":{},\"price\":null,\"reservationId\":\"dd9f58794d94415fa6bd23e36cb263d0\",\"staffId\":\"a6300d46d75340ed8dbf730209a38b70\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 21:35:17', 3);
INSERT INTO `sys_oper_log` VALUES (300, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"params\":{},\"staffId\":\"a6300d46d75340ed8dbf730209a38b70\",\"status\":\"服务中\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 21:35:17', 2);
INSERT INTO `sys_oper_log` VALUES (301, '预约', 2, 'com.huacai.housekeeping.controller.ReservationController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/reservation', '127.0.0.1', '内网IP', '{\"params\":{},\"price\":null,\"reservationId\":\"dd89249def884c8f95b525e03b0968d6\",\"staffId\":\"39074b7f7e3648d0a88216c48559a530\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 21:35:28', 3);
INSERT INTO `sys_oper_log` VALUES (302, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"params\":{},\"staffId\":\"39074b7f7e3648d0a88216c48559a530\",\"status\":\"服务中\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 21:35:28', 3);
INSERT INTO `sys_oper_log` VALUES (303, '预约', 2, 'com.huacai.housekeeping.controller.ReservationController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/reservation', '127.0.0.1', '内网IP', '{\"params\":{},\"price\":null,\"reservationId\":\"dd9f58794d94415fa6bd23e36cb263d0\",\"status\":\"已完成\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 21:35:39', 5);
INSERT INTO `sys_oper_log` VALUES (304, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"params\":{},\"status\":\"空闲\"}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2025-07-20 21:35:39', 2);
INSERT INTO `sys_oper_log` VALUES (305, '预约', 2, 'com.huacai.housekeeping.controller.ReservationController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/reservation', '127.0.0.1', '内网IP', '{\"params\":{},\"price\":null,\"reservationId\":\"dd89249def884c8f95b525e03b0968d6\",\"status\":\"已完成\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 21:35:51', 3);
INSERT INTO `sys_oper_log` VALUES (306, '服务人员', 2, 'com.huacai.housekeeping.controller.StaffController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/staff', '127.0.0.1', '内网IP', '{\"params\":{},\"staffId\":\"39074b7f7e3648d0a88216c48559a530\",\"status\":\"空闲\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 21:35:51', 2);
INSERT INTO `sys_oper_log` VALUES (307, '评价', 1, 'com.huacai.housekeeping.controller.AssessController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/assess', '127.0.0.1', '内网IP', '{\"assessId\":\"318267104b144852b9221c8e79e2dc88\",\"content\":\"保洁服务很到位，阿姨打扫得很仔细，特别是厨房和卫生间这些难清洁的地方都处理得很干净，下次还会选择。\",\"createTime\":\"2025-07-20 21:36:20\",\"params\":{},\"reservationId\":\"dd9f58794d94415fa6bd23e36cb263d0\",\"score\":5.0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 21:36:20', 7);
INSERT INTO `sys_oper_log` VALUES (308, '评价', 3, 'com.huacai.housekeeping.controller.AssessController.remove()', 'DELETE', 1, 'admin', '花菜编程', '/housekeeping/assess/318267104b144852b9221c8e79e2dc88', '127.0.0.1', '内网IP', '[\"318267104b144852b9221c8e79e2dc88\"]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 21:36:31', 6);
INSERT INTO `sys_oper_log` VALUES (309, '评价', 1, 'com.huacai.housekeeping.controller.AssessController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/assess', '127.0.0.1', '内网IP', '{\"assessId\":\"83125b99eb8c448fa6a4e294eb33b9a6\",\"content\":\"保洁服务很到位，阿姨打扫得很仔细，特别是厨房和卫生间这些难清洁的地方都处理得很干净，下次还会选择。\",\"createTime\":\"2025-07-20 21:36:34\",\"params\":{},\"reservationId\":\"dd89249def884c8f95b525e03b0968d6\",\"score\":5.0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 21:36:34', 4);
INSERT INTO `sys_oper_log` VALUES (310, '评价', 1, 'com.huacai.housekeeping.controller.AssessController.add()', 'POST', 1, 'admin', '花菜编程', '/housekeeping/assess', '127.0.0.1', '内网IP', '{\"assessId\":\"6c9ddfeaf2df45a188501b17fd19916e\",\"content\":\"育儿嫂阿姨很有经验，宝宝很喜欢她，教会了我们很多育儿知识，现在宝宝作息规律多了，非常感谢！\",\"createTime\":\"2025-07-20 21:36:51\",\"params\":{},\"reservationId\":\"dd9f58794d94415fa6bd23e36cb263d0\",\"score\":5.0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 21:36:51', 4);
INSERT INTO `sys_oper_log` VALUES (311, '评价', 2, 'com.huacai.housekeeping.controller.AssessController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/assess', '127.0.0.1', '内网IP', '{\"assessId\":\"4df50ab773994039b4870e290dfad91b\",\"goIndex\":\"推送\",\"params\":{},\"score\":null}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 21:40:24', 3);
INSERT INTO `sys_oper_log` VALUES (312, '评价', 2, 'com.huacai.housekeeping.controller.AssessController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/assess', '127.0.0.1', '内网IP', '{\"assessId\":\"4df50ab773994039b4870e290dfad91b\",\"goIndex\":\"否\",\"params\":{},\"score\":null}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 21:42:58', 4);
INSERT INTO `sys_oper_log` VALUES (313, '评价', 2, 'com.huacai.housekeeping.controller.AssessController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/assess', '127.0.0.1', '内网IP', '{\"assessId\":\"4df50ab773994039b4870e290dfad91b\",\"goIndex\":\"推送\",\"params\":{},\"score\":null}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 21:43:00', 3);
INSERT INTO `sys_oper_log` VALUES (314, '评价', 2, 'com.huacai.housekeeping.controller.AssessController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/assess', '127.0.0.1', '内网IP', '{\"assessId\":\"6c9ddfeaf2df45a188501b17fd19916e\",\"goIndex\":\"推送\",\"params\":{},\"score\":null}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 21:43:01', 4);
INSERT INTO `sys_oper_log` VALUES (315, '评价', 2, 'com.huacai.housekeeping.controller.AssessController.edit()', 'PUT', 1, 'admin', '花菜编程', '/housekeeping/assess', '127.0.0.1', '内网IP', '{\"assessId\":\"83125b99eb8c448fa6a4e294eb33b9a6\",\"goIndex\":\"推送\",\"params\":{},\"score\":null}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 21:43:01', 3);
INSERT INTO `sys_oper_log` VALUES (316, '用户头像', 2, 'com.huacai.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'admin', '花菜编程', '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2025/07/20/logo_20250720215625A001.png\",\"code\":200}', 0, NULL, '2025-07-20 21:56:25', 135);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'wuhoo~', '芜湖', 1, '0', 'admin', '2025-05-05 08:59:53', 'admin', '2025-05-05 10:52:42', '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-05-05 08:59:54', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '2', 'admin', '2025-05-05 08:59:54', 'admin', '2025-05-05 10:34:10', '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  `balance` double NOT NULL DEFAULT 0 COMMENT '账户余额',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 100, 'admin', '花菜', '00', 'huacai@163.com', '15888888888', '1', '/profile/avatar/2025/07/20/logo_20250720215625A001.png', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-07-20 15:49:13', 'admin', '2025-05-05 08:59:53', '', '2025-07-20 21:34:30', '管理员', 3372);
INSERT INTO `sys_user` VALUES (100, NULL, '张三', '张三', '00', '', '', '0', '', '$2a$10$J5.MD1ifelYcYa2pt5metefdbupBZEA9i4YOwTtQk3qvlQM9TJJbm', '0', '0', '127.0.0.1', '2025-07-20 21:58:50', '', '2025-07-10 23:05:33', '', '2025-07-20 21:58:50', NULL, 10);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
