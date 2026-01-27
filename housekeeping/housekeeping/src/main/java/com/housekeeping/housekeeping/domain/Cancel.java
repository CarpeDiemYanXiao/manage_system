package com.housekeeping.housekeeping.domain;

import com.housekeeping.common.annotation.Excel;
import lombok.*;
import com.housekeeping.common.core.domain.BaseEntity;

/**
 * 取消记录对象 cancel
 *
 * @author Housekeeping
 * @date 2025-07-19
 */
@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Cancel extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 取消记录ID */
    private String cancelId;

    /** 订单编号 */
    @Excel(name = "订单编号")
    private String reservationId;

    /** 取消原因 */
    @Excel(name = "取消原因")
    private String reason;

    /** 备注 */
    @Excel(name = "备注")
    private String notes;


}

