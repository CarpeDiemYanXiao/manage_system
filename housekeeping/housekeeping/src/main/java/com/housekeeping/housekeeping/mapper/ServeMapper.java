package com.housekeeping.housekeeping.mapper;

import java.util.List;
import com.housekeeping.housekeeping.domain.Serve;

/**
 * 服务Mapper接口
 * 
 * @author Housekeeping
 * @date 2025-07-10
 */
public interface ServeMapper 
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
     * 修改服务
     * 
     * @param serve 服务
     * @return 结果
     */
    public int updateServe(Serve serve);

    /**
     * 删除服务
     * 
     * @param serveId 服务主键
     * @return 结果
     */
    public int deleteServeByServeId(String serveId);

    /**
     * 批量删除服务
     * 
     * @param serveIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteServeByServeIds(String[] serveIds);
}

