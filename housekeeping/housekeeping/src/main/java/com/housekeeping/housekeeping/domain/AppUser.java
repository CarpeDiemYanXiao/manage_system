package com.housekeeping.housekeeping.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.housekeeping.common.annotation.Excel;
import lombok.*;
import com.housekeeping.common.core.domain.BaseEntity;

/**
 * 应用端用户对象 app_user
 *
 * @author Housekeeping
 * @date 2026-01-25
 */
@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
public class AppUser extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 用户ID */
    private Long userId;

    /** 用户名 */
    @Excel(name = "用户名")
    private String username;

    /** 密码 */
    private String password;

    /** 用户昵称 */
    @Excel(name = "用户昵称")
    private String nickname;

    /** 手机号 */
    @Excel(name = "手机号")
    private String phone;

    /** 邮箱 */
    @Excel(name = "邮箱")
    private String email;

    /** 头像 */
    private String avatar;

    /** 性别 */
    @Excel(name = "性别")
    private String gender;

    /** 账号状态 */
    @Excel(name = "账号状态")
    private String status;

    /** 最后登录时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "最后登录时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date lastLoginTime;

}

