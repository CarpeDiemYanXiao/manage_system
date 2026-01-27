package com.housekeeping.housekeeping.service;

import java.util.List;
import com.housekeeping.housekeeping.domain.Serve;

/**
 * 服务Service接口
 *
 * @author Housekeeping
 * @date 2025-07-10
 */
public interface IServeService
{
    /**
     * 查询服务
     *
     * @param serveId 服务主键
     * @return 服务
     */
    public Serve selectServeByServeId(String serveId);

    /**
     * 查询服务列表
     *
     * @param serve 服务
     * @return 服务集合
     */
    public List<Serve> selectServeList(Serve serve);

    /**
     * 新增服务
     *
     * @param serve 服务
     * @return 结果
     */
    public int insertServe(Serve serve);

    /**
     * 批量新增服务
     *
     * @param serves 服务List
     * @return 结果
     */
    public int batchInsertServe(List<Serve> serves);

    /**
     * 修改服务
     *
     * @param serve 服务
     * @return 结果
     */
    public int updateServe(Serve serve);

    /**
     * 批量删除服务
     *
     * @param serveIds 需要删除的服务主键集合
     * @return 结果
     */
    public int deleteServeByServeIds(String[] serveIds);

    /**
     * 删除服务信息
     *
     * @param serveId 服务主键
     * @return 结果
     */
    public int deleteServeByServeId(String serveId);
}

