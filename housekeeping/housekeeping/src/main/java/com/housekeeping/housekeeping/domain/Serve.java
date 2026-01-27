package com.housekeeping.housekeeping.domain;

import com.housekeeping.common.annotation.Excel;
import lombok.*;
import com.housekeeping.common.core.domain.BaseEntity;

/**
 * 服务对象 serve
 *
 * @author Housekeeping
 * @date 2025-07-10
 */
@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Serve extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 服务ID */
    private String serveId;

    /** 服务名称 */
    @Excel(name = "服务名称")
    private String name;

    /** 服务类型 */
    @Excel(name = "服务类型")
    private String category;

    /** 图片 */
    @Excel(name = "图片")
    private String image;

    /** 描述 */
    @Excel(name = "描述")
    private String description;

    /** 价格 */
    @Excel(name = "价格")
    private Double price;

    /** 标签 */
    @Excel(name = "标签")
    private String tag;

    // 标签(数组类型)
    private String[] tags;


}

