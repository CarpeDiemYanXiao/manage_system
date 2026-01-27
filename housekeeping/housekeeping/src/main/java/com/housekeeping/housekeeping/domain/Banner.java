package com.housekeeping.housekeeping.domain;

import com.housekeeping.common.annotation.Excel;
import lombok.*;
import com.housekeeping.common.core.domain.BaseEntity;

/**
 * 轮播图对象 banner
 *
 * @author Housekeeping
 * @date 2025-07-20
 */
@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Banner extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 轮播图ID */
    private String bannerId;

    /** 图片 */
    @Excel(name = "图片")
    private String image;

    /** 名称 */
    @Excel(name = "名称")
    private String title;

    /** 描述 */
    @Excel(name = "描述")
    private String description;

    /** 排序 */
    @Excel(name = "排序")
    private Long sort;


}

