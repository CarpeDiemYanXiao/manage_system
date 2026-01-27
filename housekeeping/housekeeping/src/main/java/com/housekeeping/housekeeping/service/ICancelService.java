package com.housekeeping.housekeeping.service;

import java.util.List;
import com.housekeeping.housekeeping.domain.Cancel;

/**
 * 取消记录Service接口
 *
 * @author Housekeeping
 * @date 2025-07-19
 */
public interface ICancelService
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
     * 批量新增取消记录
     *
     * @param cancels 取消记录List
     * @return 结果
     */
    public int batchInsertCancel(List<Cancel> cancels);

    /**
     * 修改取消记录
     *
     * @param cancel 取消记录
     * @return 结果
     */
    public int updateCancel(Cancel cancel);

    /**
     * 批量删除取消记录
     *
     * @param cancelIds 需要删除的取消记录主键集合
     * @return 结果
     */
    public int deleteCancelByCancelIds(String[] cancelIds);

    /**
     * 删除取消记录信息
     *
     * @param cancelId 取消记录主键
     * @return 结果
     */
    public int deleteCancelByCancelId(String cancelId);
}

