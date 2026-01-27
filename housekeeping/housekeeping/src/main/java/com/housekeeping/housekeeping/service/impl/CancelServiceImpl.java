package com.housekeeping.housekeeping.service.impl;

import java.util.List;

import com.housekeeping.common.utils.DateUtils;
import com.housekeeping.common.utils.uuid.IdUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.housekeeping.housekeeping.mapper.CancelMapper;
import com.housekeeping.housekeeping.domain.Cancel;
import com.housekeeping.housekeeping.service.ICancelService;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.util.CollectionUtils;

/**
 * 取消记录Service业务层处理
 *
 * @author Housekeeping
 * @date 2025-07-19
 */
@Service
public class CancelServiceImpl implements ICancelService {
    @Autowired
    private CancelMapper cancelMapper;

    @Autowired
    private SqlSessionFactory sqlSessionFactory;

    /**
     * 查询取消记录
     *
     * @param cancelId 取消记录主键
     * @return 取消记录
     */
    @Override
    public Cancel selectCancelByCancelId(String cancelId) {
        return cancelMapper.selectCancelByCancelId(cancelId);
    }

    /**
     * 查询取消记录列表
     *
     * @param cancel 取消记录
     * @return 取消记录
     */
    @Override
    public List<Cancel> selectCancelList(Cancel cancel) {
        return cancelMapper.selectCancelList(cancel);
    }

    /**
     * 新增取消记录
     *
     * @param cancel 取消记录
     * @return 结果
     */
    @Override
    public int insertCancel(Cancel cancel) {
        cancel.setCreateTime(DateUtils.getNowDate());
        cancel.setCancelId(IdUtils.fastSimpleUUID());
        return cancelMapper.insertCancel(cancel);
    }

    /**
     * 批量新增取消记录
     *
     * @param cancels 取消记录List
     * @return 结果
     */
    @Override
    public int batchInsertCancel(List<Cancel> cancels) {
        SqlSession sqlSession = sqlSessionFactory.openSession(ExecutorType.BATCH, false);
        int count = 0;
        if (!CollectionUtils.isEmpty(cancels)) {
            try {
                for (int i = 0; i < cancels.size(); i++) {
                    int row = cancelMapper.insertCancel(cancels.get(i));
                    // 防止内存溢出，每100次提交一次,并清除缓存
                    boolean bool = (i > 0 && i % 100 == 0) || i == cancels.size() - 1;
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
     * 修改取消记录
     *
     * @param cancel 取消记录
     * @return 结果
     */
    @Override
    public int updateCancel(Cancel cancel) {
        return cancelMapper.updateCancel(cancel);
    }

    /**
     * 批量删除取消记录
     *
     * @param cancelIds 需要删除的取消记录主键
     * @return 结果
     */
    @Override
    public int deleteCancelByCancelIds(String[] cancelIds) {
        return cancelMapper.deleteCancelByCancelIds(cancelIds);
    }

    /**
     * 删除取消记录信息
     *
     * @param cancelId 取消记录主键
     * @return 结果
     */
    @Override
    public int deleteCancelByCancelId(String cancelId) {
        return cancelMapper.deleteCancelByCancelId(cancelId);
    }
}

