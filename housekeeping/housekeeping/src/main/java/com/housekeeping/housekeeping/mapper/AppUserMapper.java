package com.housekeeping.housekeeping.mapper;

import java.util.List;
import com.housekeeping.housekeeping.domain.AppUser;

/**
 * 应用端用户Mapper接口
 * 
 * @author Housekeeping
 * @date 2026-01-25
 */
public interface AppUserMapper {
    /**
     * 查询应用端用户
     * 
     * @param userId 应用端用户主键
     * @return 应用端用户
     */
    public AppUser selectAppUserByUserId(Long userId);

    /**
     * 根据用户名查询用户
     * 
     * @param username 用户名
     * @return 应用端用户
     */
    public AppUser selectAppUserByUsername(String username);

    /**
     * 查询应用端用户列表
     * 
     * @param appUser 应用端用户
     * @return 应用端用户集合
     */
    public List<AppUser> selectAppUserList(AppUser appUser);

    /**
     * 新增应用端用户
     * 
     * @param appUser 应用端用户
     * @return 结果
     */
    public int insertAppUser(AppUser appUser);

    /**
     * 修改应用端用户
     * 
     * @param appUser 应用端用户
     * @return 结果
     */
    public int updateAppUser(AppUser appUser);

    /**
     * 删除应用端用户
     * 
     * @param userId 应用端用户主键
     * @return 结果
     */
    public int deleteAppUserByUserId(Long userId);

    /**
     * 批量删除应用端用户
     * 
     * @param userIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAppUserByUserIds(Long[] userIds);

    /**
     * 校验用户名是否唯一
     *
     * @param username 用户名
     * @return 结果
     */
    public int checkUsernameUnique(String username);
}

