package com.housekeeping.housekeeping.mapper;

import java.util.List;
import com.housekeeping.housekeeping.domain.Staff;

/**
 * 服务人员Mapper接口
 * 
 * @author Housekeeping
 * @date 2025-07-17
 */
public interface StaffMapper {
    /**
     * 查询服务人员
     * 
     * @param staffId 服务人员主键
     * @return 服务人员
     */
    public Staff selectStaffByStaffId(String staffId);

    /**
     * 根据用户名查询服务人员
     * 
     * @param username 用户名
     * @return 服务人员
     */
    public Staff selectStaffByUsername(String username);

    /**
     * 查询服务人员列表
     * 
     * @param staff 服务人员
     * @return 服务人员集合
     */
    public List<Staff> selectStaffList(Staff staff);

    /**
     * 新增服务人员
     * 
     * @param staff 服务人员
     * @return 结果
     */
    public int insertStaff(Staff staff);

    /**
     * 修改服务人员
     * 
     * @param staff 服务人员
     * @return 结果
     */
    public int updateStaff(Staff staff);

    /**
     * 删除服务人员
     * 
     * @param staffId 服务人员主键
     * @return 结果
     */
    public int deleteStaffByStaffId(String staffId);

    /**
     * 批量删除服务人员
     * 
     * @param staffIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteStaffByStaffIds(String[] staffIds);

    /**
     * 校验用户名是否唯一
     *
     * @param username 用户名
     * @return 结果
     */
    public int checkUsernameUnique(String username);
}

