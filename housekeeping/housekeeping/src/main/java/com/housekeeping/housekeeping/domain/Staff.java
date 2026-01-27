package com.housekeeping.housekeeping.domain;

import com.housekeeping.common.annotation.Excel;
import lombok.*;
import com.housekeeping.common.core.domain.BaseEntity;

/**
 * 服务人员对象 staff
 *
 * @author Housekeeping
 * @date 2025-07-17
 */
@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Staff extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 服务人员ID */
    private String staffId;

    /** 登录账号 */
    @Excel(name = "登录账号")
    private String username;

    /** 登录密码 */
    private String password;

    /** 姓名 */
    @Excel(name = "姓名")
    private String name;

    /** 性别 */
    @Excel(name = "性别")
    private String gender;

    /** 联系电话 */
    @Excel(name = "联系电话")
    private String phone;

    /** 照片 */
    @Excel(name = "照片")
    private String photo;

    /** 人员类型 */
    @Excel(name = "人员类型")
    private String staffType;

    /** 服务技能 */
    @Excel(name = "服务技能")
    private String skills;

    /** 个人简介 */
    @Excel(name = "个人简介")
    private String introduction;

    /** 工作状态 */
    @Excel(name = "工作状态")
    private String status;

    /** 账号状态 */
    @Excel(name = "账号状态")
    private String accountStatus;

}

