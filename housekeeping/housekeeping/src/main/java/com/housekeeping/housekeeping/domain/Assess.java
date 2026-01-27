package com.housekeeping.housekeeping.domain;

import com.housekeeping.common.annotation.Excel;
import lombok.*;
import com.housekeeping.common.core.domain.BaseEntity;

/**
 * 评价对象 assess
 *
 * @author Housekeeping
 * @date 2025-07-20
 */
@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Assess extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 评价ID */
    private String assessId;

    /** 订单编号 */
    @Excel(name = "订单编号")
    private String reservationId;

    /** 服务评分 */
    @Excel(name = "服务评分")
    private Double score;

    /** 评价内容 */
    @Excel(name = "评价内容")
    private String content;

    /** 是否推送到主页 */
    @Excel(name = "是否推送到主页")
    private String goIndex;

    /** 服务人员ID (用于查询) */
    private String staffId;

    /** 服务名称 (关联查询) */
    private String serveName;

    /** 客户姓名 (关联查询) */
    private String customerName;

    /** 客户头像 (关联查询) */
    private String customerAvatar;

    // 评价人用户名
    private String userName;

    // 评价人头像
    private String avatar;

}

