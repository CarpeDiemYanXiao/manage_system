package com.housekeeping.housekeeping.service;

import java.util.List;
import com.housekeeping.housekeeping.domain.AppUser;

/**
 * 应用端用户Service接口
 *
 * @author Housekeeping
 * @date 2026-01-25
 */
public interface IAppUserService {
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
     * 批量删除应用端用户
     *
     * @param userIds 需要删除的应用端用户主键集合
     * @return 结果
     */
    public int deleteAppUserByUserIds(Long[] userIds);

    /**
     * 删除应用端用户信息
     *
     * @param userId 应用端用户主键
     * @return 结果
     */
    public int deleteAppUserByUserId(Long userId);

    /**
     * 校验用户名是否唯一
     *
     * @param username 用户名
     * @return 结果
     */
    public boolean checkUsernameUnique(String username);

    /**
     * 更新用户状态（封禁/解封）
     *
     * @param appUser 用户信息
     * @return 结果
     */
    public int updateUserStatus(AppUser appUser);
}

