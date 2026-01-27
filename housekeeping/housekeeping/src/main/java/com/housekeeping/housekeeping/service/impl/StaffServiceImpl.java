package com.housekeeping.housekeeping.service.impl;

import java.util.List;

import com.housekeeping.common.utils.DateUtils;
import com.housekeeping.common.utils.uuid.IdUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.housekeeping.housekeeping.mapper.StaffMapper;
import com.housekeeping.housekeeping.domain.Staff;
import com.housekeeping.housekeeping.service.IStaffService;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.util.CollectionUtils;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

/**
 * 服务人员Service业务层处理
 *
 * @author Housekeeping
 * @date 2025-07-17
 */
@Service
public class StaffServiceImpl implements IStaffService {
    @Autowired
    private StaffMapper staffMapper;

    @Autowired
    private SqlSessionFactory sqlSessionFactory;

    /**
     * 查询服务人员
     *
     * @param staffId 服务人员主键
     * @return 服务人员
     */
    @Override
    public Staff selectStaffByStaffId(String staffId) {
        return staffMapper.selectStaffByStaffId(staffId);
    }

    /**
     * 根据用户名查询服务人员
     *
     * @param username 用户名
     * @return 服务人员
     */
    @Override
    public Staff selectStaffByUsername(String username) {
        return staffMapper.selectStaffByUsername(username);
    }

    /**
     * 查询服务人员列表
     *
     * @param staff 服务人员
     * @return 服务人员
     */
    @Override
    public List<Staff> selectStaffList(Staff staff) {
        return staffMapper.selectStaffList(staff);
    }

    /**
     * 新增服务人员
     *
     * @param staff 服务人员
     * @return 结果
     */
    @Override
    public int insertStaff(Staff staff) {
        staff.setCreateTime(DateUtils.getNowDate());
        staff.setStaffId(IdUtils.fastSimpleUUID());
        return staffMapper.insertStaff(staff);
    }

    /**
     * 批量新增服务人员
     *
     * @param staffs 服务人员List
     * @return 结果
     */
    @Override
    public int batchInsertStaff(List<Staff> staffs) {
        SqlSession sqlSession = sqlSessionFactory.openSession(ExecutorType.BATCH, false);
        int count = 0;
        if (!CollectionUtils.isEmpty(staffs)) {
            try {
                for (int i = 0; i < staffs.size(); i++) {
                    for (Staff staff : staffs) {
                        staff.setStaffId(IdUtils.fastSimpleUUID());
                    }
                    int row = staffMapper.insertStaff(staffs.get(i));
                    // 防止内存溢出，每100次提交一次,并清除缓存
                    boolean bool = (i > 0 && i % 100 == 0) || i == staffs.size() - 1;
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
     * 修改服务人员
     *
     * @param staff 服务人员
     * @return 结果
     */
    @Override
    public int updateStaff(Staff staff) {
        return staffMapper.updateStaff(staff);
    }

    /**
     * 批量删除服务人员
     *
     * @param staffIds 需要删除的服务人员主键
     * @return 结果
     */
    @Override
    public int deleteStaffByStaffIds(String[] staffIds) {
        return staffMapper.deleteStaffByStaffIds(staffIds);
    }

    /**
     * 删除服务人员信息
     *
     * @param staffId 服务人员主键
     * @return 结果
     */
    @Override
    public int deleteStaffByStaffId(String staffId) {
        return staffMapper.deleteStaffByStaffId(staffId);
    }

    /**
     * 校验用户名是否唯一
     *
     * @param username 用户名
     * @return 结果
     */
    @Override
    public boolean checkUsernameUnique(String username) {
        int count = staffMapper.checkUsernameUnique(username);
        return count == 0;
    }

    /**
     * 注册服务人员
     *
     * @param staff 服务人员信息
     * @return 结果
     */
    @Override
    public boolean registerStaff(Staff staff) {
        staff.setStaffId(IdUtils.fastSimpleUUID());
        staff.setCreateTime(DateUtils.getNowDate());
        staff.setStatus("空闲");
        staff.setAccountStatus("正常");
        // 加密密码
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        staff.setPassword(encoder.encode(staff.getPassword()));
        return staffMapper.insertStaff(staff) > 0;
    }
}

