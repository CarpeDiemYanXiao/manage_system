package com.housekeeping.housekeeping.mapper;

import java.util.List;
import com.housekeeping.housekeeping.domain.Cancel;

/**
 * 取消记录Mapper接口
 * 
 * @author Housekeeping
 * @date 2025-07-19
 */
public interface CancelMapper 
{
    /**
     * 查询取消记录
     * 
     * @param cancelId 取消记录主键
     * @return 取消记录
     */
    public Cancel selectCancelByCancelId(String cancelId);

    /**
     * 查询取消记录列表
     * 
     * @param cancel 取消记录
     * @return 取消记录集合
     */
    public List<Cancel> selectCancelList(Cancel cancel);

    /**
     * 新增取消记录
     * 
     * @param cancel 取消记录
     * @return 结果
     */
    public int insertCancel(Cancel cancel);

    /**
     * 修改取消记录
     * 
     * @param cancel 取消记录
     * @return 结果
     */
    public int updateCancel(Cancel cancel);

    /**
     * 删除取消记录
     * 
     * @param cancelId 取消记录主键
     * @return 结果
     */
    public int deleteCancelByCancelId(String cancelId);

    /**
     * 批量删除取消记录
     * 
     * @param cancelIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCancelByCancelIds(String[] cancelIds);
}

