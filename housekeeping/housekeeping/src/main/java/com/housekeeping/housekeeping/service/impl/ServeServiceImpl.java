package com.housekeeping.housekeeping.service.impl;

import java.util.Arrays;
import java.util.List;

import com.housekeeping.common.utils.DateUtils;
import com.housekeeping.common.utils.uuid.IdUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.housekeeping.housekeeping.mapper.ServeMapper;
import com.housekeeping.housekeeping.domain.Serve;
import com.housekeeping.housekeeping.service.IServeService;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.util.CollectionUtils;

/**
 * 服务Service业务层处理
 *
 * @author Housekeeping
 * @date 2025-07-10
 */
@Service
public class ServeServiceImpl implements IServeService {
    @Autowired
    private ServeMapper serveMapper;

    @Autowired
    private SqlSessionFactory sqlSessionFactory;

    /**
     * 查询服务
     *
     * @param serveId 服务主键
     * @return 服务
     */
    @Override
    public Serve selectServeByServeId(String serveId) {
        Serve serve = serveMapper.selectServeByServeId(serveId);
        //拿到每一条服务的标签数据
        String tag = serve.getTag();
        //转换为 String[]
        String[] tags = Arrays.stream(tag.split(",")).toArray(String[]::new);
        serve.setTags(tags);
        return serve;
    }

    /**
     * 查询服务列表
     *
     * @param serve 服务
     * @return 服务
     */
    @Override
    public List<Serve> selectServeList(Serve serve) {
        //从数据库中查询到的服务列表数据
        List<Serve> serveList = serveMapper.selectServeList(serve);
        //遍历循环每一条数据
        for (Serve toServe : serveList) {
            //拿到每一条服务的标签数据
            String tag = toServe.getTag();
            //转换为 String[]
            String[] tags = Arrays.stream(tag.split(",")).toArray(String[]::new);
            toServe.setTags(tags);
        }
        return serveList;
    }

    /**
     * 新增服务
     *
     * @param serve 服务
     * @return 结果
     */
    @Override
    public int insertServe(Serve serve) {
        serve.setCreateTime(DateUtils.getNowDate());
        //生成一个UUID并插入至对象中
        serve.setServeId(IdUtils.fastSimpleUUID());
        return serveMapper.insertServe(serve);
    }

    /**
     * 批量新增服务
     *
     * @param serves 服务List
     * @return 结果
     */
    @Override
    public int batchInsertServe(List<Serve> serves) {
        SqlSession sqlSession = sqlSessionFactory.openSession(ExecutorType.BATCH, false);
        int count = 0;
        if (!CollectionUtils.isEmpty(serves)) {
            try {
                for (Serve serve : serves) {
                    //生成一个UUID并插入至每条对象中
                    serve.setServeId(IdUtils.fastSimpleUUID());
                }
                for (int i = 0; i < serves.size(); i++) {
                    int row = serveMapper.insertServe(serves.get(i));
                    // 防止内存溢出，每100次提交一次,并清除缓存
                    boolean bool = (i > 0 && i % 100 == 0) || i == serves.size() - 1;
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
     * 修改服务
     *
     * @param serve 服务
     * @return 结果
     */
    @Override
    public int updateServe(Serve serve) {
        return serveMapper.updateServe(serve);
    }

    /**
     * 批量删除服务
     *
     * @param serveIds 需要删除的服务主键
     * @return 结果
     */
    @Override
    public int deleteServeByServeIds(String[] serveIds) {
        return serveMapper.deleteServeByServeIds(serveIds);
    }

    /**
     * 删除服务信息
     *
     * @param serveId 服务主键
     * @return 结果
     */
    @Override
    public int deleteServeByServeId(String serveId) {
        return serveMapper.deleteServeByServeId(serveId);
    }
}

