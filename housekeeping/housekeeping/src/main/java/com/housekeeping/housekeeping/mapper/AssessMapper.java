package com.housekeeping.housekeeping.mapper;

import java.util.List;
import com.housekeeping.housekeeping.domain.Assess;

/**
 * 评价Mapper接口
 * 
 * @author Housekeeping
 * @date 2025-07-20
 */
public interface AssessMapper {
    /**
     * 查询评价
     * 
     * @param assessId 评价主键
     * @return 评价
     */
    public Assess selectAssessByAssessId(String assessId);

    /**
     * 查询评价列表
     * 
     * @param assess 评价
     * @return 评价集合
     */
    public List<Assess> selectAssessList(Assess assess);

    /**
     * 新增评价
     * 
     * @param assess 评价
     * @return 结果
     */
    public int insertAssess(Assess assess);

    /**
     * 修改评价
     * 
     * @param assess 评价
     * @return 结果
     */
    public int updateAssess(Assess assess);

    /**
     * 删除评价
     * 
     * @param assessId 评价主键
     * @return 结果
     */
    public int deleteAssessByAssessId(String assessId);

    /**
     * 批量删除评价
     * 
     * @param assessIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAssessByAssessIds(String[] assessIds);

    /**
     * 查询服务人员的平均评分
     * 
     * @param staffId 服务人员ID
     * @return 平均评分
     */
    public Double selectAssessAvgScore(String staffId);
}
