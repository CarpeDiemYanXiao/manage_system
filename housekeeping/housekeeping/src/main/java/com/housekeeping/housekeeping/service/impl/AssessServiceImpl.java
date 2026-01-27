package com.housekeeping.housekeeping.service.impl;

import java.util.List;

import com.housekeeping.common.utils.DateUtils;
import com.housekeeping.common.utils.uuid.IdUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.housekeeping.housekeeping.mapper.AssessMapper;
import com.housekeeping.housekeeping.domain.Assess;
import com.housekeeping.housekeeping.service.IAssessService;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.util.CollectionUtils;

/**
 * 评价Service业务层处理
 *
 * @author Housekeeping
 * @date 2025-07-20
 */
@Service
public class AssessServiceImpl implements IAssessService {
    @Autowired
    private AssessMapper assessMapper;

    @Autowired
    private SqlSessionFactory sqlSessionFactory;

    /**
     * 查询评价
     *
     * @param assessId 评价主键
     * @return 评价
     */
    @Override
    public Assess selectAssessByAssessId(String assessId) {
        return assessMapper.selectAssessByAssessId(assessId);
    }

    /**
     * 查询评价列表
     *
     * @param assess 评价
     * @return 评价
     */
    @Override
    public List<Assess> selectAssessList(Assess assess) {
        return assessMapper.selectAssessList(assess);
    }

    /**
     * 新增评价
     *
     * @param assess 评价
     * @return 结果
     */
    @Override
    public int insertAssess(Assess assess) {
        assess.setCreateTime(DateUtils.getNowDate());
        assess.setAssessId(IdUtils.fastSimpleUUID());
        return assessMapper.insertAssess(assess);
    }

    /**
     * 批量新增评价
     *
     * @param assesss 评价List
     * @return 结果
     */
    @Override
    public int batchInsertAssess(List<Assess> assesss) {
        SqlSession sqlSession = sqlSessionFactory.openSession(ExecutorType.BATCH, false);
        int count = 0;
        if (!CollectionUtils.isEmpty(assesss)) {
            try {
                for (int i = 0; i < assesss.size(); i++) {
                    int row = assessMapper.insertAssess(assesss.get(i));
                    // 防止内存溢出，每100次提交一次,并清除缓存
                    boolean bool = (i > 0 && i % 100 == 0) || i == assesss.size() - 1;
                    if (bool) {
                        sqlSession.commit();
                        sqlSession.clearCache();
                    }
                    count = i + 1;
                }
            } catch (Exception e) {
                e.printStackTrace();
                // 没有提交的数据可以回滚
                sqlSession.rollback();
            } finally {
                sqlSession.close();
                return count;
            }
        }
        return count;
    }

    /**
     * 修改评价
     *
     * @param assess 评价
     * @return 结果
     */
    @Override
    public int updateAssess(Assess assess) {
        return assessMapper.updateAssess(assess);
    }

    /**
     * 批量删除评价
     *
     * @param assessIds 需要删除的评价主键
     * @return 结果
     */
    @Override
    public int deleteAssessByAssessIds(String[] assessIds) {
        return assessMapper.deleteAssessByAssessIds(assessIds);
    }

    /**
     * 删除评价信息
     *
     * @param assessId 评价主键
     * @return 结果
     */
    @Override
    public int deleteAssessByAssessId(String assessId) {
        return assessMapper.deleteAssessByAssessId(assessId);
    }
}

