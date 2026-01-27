package com.housekeeping.housekeeping.service.impl;

import java.util.List;

import com.housekeeping.common.utils.DateUtils;
import com.housekeeping.common.utils.uuid.IdUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.housekeeping.housekeeping.mapper.ReservationMapper;
import com.housekeeping.housekeeping.domain.Reservation;
import com.housekeeping.housekeeping.service.IReservationService;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.util.CollectionUtils;

import static com.housekeeping.common.utils.SecurityUtils.getUserId;

/**
 * 预约Service业务层处理
 *
 * @author Housekeeping
 * @date 2025-07-17
 */
@Service
public class ReservationServiceImpl implements IReservationService {
    @Autowired
    private ReservationMapper reservationMapper;

    @Autowired
    private SqlSessionFactory sqlSessionFactory;

    /**
     * 查询预约
     *
     * @param reservationId 预约主键
     * @return 预约
     */
    @Override
    public Reservation selectReservationByReservationId(String reservationId) {
        return reservationMapper.selectReservationByReservationId(reservationId);
    }

    /**
     * 查询预约列表
     *
     * @param reservation 预约
     * @return 预约
     */
    @Override
    public List<Reservation> selectReservationList(Reservation reservation) {
        return reservationMapper.selectReservationList(reservation);
    }

    /**
     * 新增预约
     *
     * @param reservation 预约
     * @return 结果
     */
    @Override
    public int insertReservation(Reservation reservation) {
        reservation.setCreateTime(DateUtils.getNowDate());
        reservation.setReservationId(IdUtils.fastSimpleUUID());
        reservation.setUserId(getUserId());
        return reservationMapper.insertReservation(reservation);
    }

    /**
     * 批量新增预约
     *
     * @param reservations 预约List
     * @return 结果
     */
    @Override
    public int batchInsertReservation(List<Reservation> reservations) {
        SqlSession sqlSession = sqlSessionFactory.openSession(ExecutorType.BATCH, false);
        int count = 0;
        if (!CollectionUtils.isEmpty(reservations)) {
            try {
                for (int i = 0; i < reservations.size(); i++) {
                    int row = reservationMapper.insertReservation(reservations.get(i));
                    // 防止内存溢出，每100次提交一次,并清除缓存
                    boolean bool = (i > 0 && i % 100 == 0) || i == reservations.size() - 1;
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
     * 修改预约
     *
     * @param reservation 预约
     * @return 结果
     */
    @Override
    public int updateReservation(Reservation reservation) {
        return reservationMapper.updateReservation(reservation);
    }

    /**
     * 批量删除预约
     *
     * @param reservationIds 需要删除的预约主键
     * @return 结果
     */
    @Override
    public int deleteReservationByReservationIds(String[] reservationIds) {
        return reservationMapper.deleteReservationByReservationIds(reservationIds);
    }

    /**
     * 删除预约信息
     *
     * @param reservationId 预约主键
     * @return 结果
     */
    @Override
    public int deleteReservationByReservationId(String reservationId) {
        return reservationMapper.deleteReservationByReservationId(reservationId);
    }
}

