package com.housekeeping.housekeeping.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.housekeeping.common.annotation.Excel;
import lombok.*;
import com.housekeeping.common.core.domain.BaseEntity;

/**
 * 预约对象 reservation
 *
 * @author Housekeeping
 * @date 2025-07-17
 */
@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Reservation extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 预约ID */
    private String reservationId;

    /** 服务ID */
    @Excel(name = "服务ID")
    private String serveId;

    /** 预约服务时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "预约服务时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date time;

    /** 预约服务地址 */
    @Excel(name = "预约服务地址")
    private String address;

    /** 联系人 */
    @Excel(name = "联系人")
    private String contacts;

    /** 联系电话 */
    @Excel(name = "联系电话")
    private String phone;

    /** 特别要求 */
    @Excel(name = "特别要求")
    private String special;

    /** 预约状态 */
    @Excel(name = "预约状态")
    private String status;

    /** 服务人员ID */
    @Excel(name = "服务人员ID")
    private String staffId;

    /** 创建人ID */
    @Excel(name = "创建人ID")
    private Long userId;

    //创建人用户名
    private String userName;

    //服务名称
    private String serveName;

    //服务图片
    private String image;

    //服务类型
    private String category;

    //服务价格
    private Double price;

    //服务人员姓名
    private String staffName;

}

