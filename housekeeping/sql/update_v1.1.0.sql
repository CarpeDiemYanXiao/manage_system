-- =====================================================
-- 华彩家政服务系统 v1.1.0 数据库更新脚本
-- 功能：增加员工登录账户、用户管理功能
-- 日期：2026-01-25
-- =====================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- 1. 修改 staff 表，增加登录相关字段
-- ----------------------------
ALTER TABLE `staff` 
ADD COLUMN `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '登录账号' AFTER `staff_id`,
ADD COLUMN `password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '登录密码' AFTER `username`,
ADD COLUMN `skills` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '服务技能描述' AFTER `staff_type`,
ADD COLUMN `introduction` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '个人简介' AFTER `skills`,
ADD COLUMN `account_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '正常' COMMENT '账号状态(正常/封禁)' AFTER `status`,
ADD UNIQUE INDEX `idx_staff_username`(`username` ASC) USING BTREE;

-- ----------------------------
-- 2. 修改 reservation 表，增加订单状态字段
-- ----------------------------
ALTER TABLE `reservation` 
MODIFY COLUMN `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '待支付' COMMENT '预约状态(待支付/待确认/已接单/服务中/已完成/已取消/已拒绝)';

-- ----------------------------
-- 3. 创建 app_user 表 (应用端用户表)
-- ----------------------------
DROP TABLE IF EXISTS `app_user`;
CREATE TABLE `app_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户名',
  `password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '密码',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '用户昵称',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '头像',
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '性别',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '正常' COMMENT '账号状态(正常/封禁)',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `last_login_time` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `idx_app_user_username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '应用端用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- 4. 添加字典数据 - 账号状态
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (NULL, '账号状态', 'account_status', '0', 'admin', NOW(), '', NULL, '账号状态列表');

INSERT INTO `sys_dict_data` VALUES (NULL, 1, '正常', '正常', 'account_status', NULL, 'success', 'Y', '0', 'admin', NOW(), '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (NULL, 2, '封禁', '封禁', 'account_status', NULL, 'danger', 'N', '0', 'admin', NOW(), '', NULL, '封禁状态');

-- ----------------------------
-- 5. 添加字典数据 - 预约状态（扩展）
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (NULL, 5, '已接单', '已接单', 'reservation_status', NULL, 'primary', 'N', '0', 'admin', NOW(), '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (NULL, 6, '服务中', '服务中', 'reservation_status', NULL, 'warning', 'N', '0', 'admin', NOW(), '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (NULL, 7, '已拒绝', '已拒绝', 'reservation_status', NULL, 'info', 'N', '0', 'admin', NOW(), '', NULL, NULL);

-- ----------------------------
-- 6. 添加菜单 - 管理端用户管理
-- ----------------------------
INSERT INTO `sys_menu` VALUES (2050, '用户管理', 0, 4, 'appuser', NULL, '', '', 1, 0, 'M', '0', '0', '', '用户', 'admin', NOW(), '', NULL, 'App用户管理目录');
INSERT INTO `sys_menu` VALUES (2051, '用户信息管理', 2050, 1, 'info', 'housekeeping/appuser/index', NULL, '', 1, 1, 'C', '0', '0', 'housekeeping:appuser:list', '用户', 'admin', NOW(), '', NULL, 'App用户信息管理菜单');
INSERT INTO `sys_menu` VALUES (2052, '用户查询', 2051, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:appuser:query', '#', 'admin', NOW(), '', NULL, '');
INSERT INTO `sys_menu` VALUES (2053, '用户修改', 2051, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:appuser:edit', '#', 'admin', NOW(), '', NULL, '');
INSERT INTO `sys_menu` VALUES (2054, '状态变更', 2051, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:appuser:status', '#', 'admin', NOW(), '', NULL, '');
INSERT INTO `sys_menu` VALUES (2055, '用户删除', 2051, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:appuser:remove', '#', 'admin', NOW(), '', NULL, '');
INSERT INTO `sys_menu` VALUES (2056, '用户导出', 2051, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'housekeeping:appuser:export', '#', 'admin', NOW(), '', NULL, '');

-- ----------------------------
-- 7. 为现有员工生成默认登录账号（使用手机号作为用户名，密码为123456加密后的值）
-- 注意：密码为 123456 的BCrypt加密值
-- ----------------------------
UPDATE `staff` SET 
  `username` = `phone`,
  `password` = '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2'
WHERE `username` IS NULL;

SET FOREIGN_KEY_CHECKS = 1;
