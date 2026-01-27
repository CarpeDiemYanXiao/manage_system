package com.housekeeping.housekeeping.service.impl;

import java.util.List;

import com.housekeeping.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.housekeeping.housekeeping.mapper.AppUserMapper;
import com.housekeeping.housekeeping.domain.AppUser;
import com.housekeeping.housekeeping.service.IAppUserService;

/**
 * 应用端用户Service业务层处理
 *
 * @author Housekeeping
 * @date 2026-01-25
 */
@Service
public class AppUserServiceImpl implements IAppUserService {
    @Autowired
    private AppUserMapper appUserMapper;

    /**
     * 查询应用端用户
     *
     * @param userId 应用端用户主键
     * @return 应用端用户
     */
    @Override
    public AppUser selectAppUserByUserId(Long userId) {
        return appUserMapper.selectAppUserByUserId(userId);
    }

    /**
     * 根据用户名查询用户
     *
     * @param username 用户名
     * @return 应用端用户
     */
    @Override
    public AppUser selectAppUserByUsername(String username) {
        return appUserMapper.selectAppUserByUsername(username);
    }

    /**
     * 查询应用端用户列表
     *
     * @param appUser 应用端用户
     * @return 应用端用户
     */
    @Override
    public List<AppUser> selectAppUserList(AppUser appUser) {
        return appUserMapper.selectAppUserList(appUser);
    }

    /**
     * 新增应用端用户
     *
     * @param appUser 应用端用户
     * @return 结果
     */
    @Override
    public int insertAppUser(AppUser appUser) {
        appUser.setCreateTime(DateUtils.getNowDate());
        return appUserMapper.insertAppUser(appUser);
    }

    /**
     * 修改应用端用户
     *
     * @param appUser 应用端用户
     * @return 结果
     */
    @Override
    public int updateAppUser(AppUser appUser) {
        return appUserMapper.updateAppUser(appUser);
    }

    /**
     * 批量删除应用端用户
     *
     * @param userIds 需要删除的应用端用户主键
     * @return 结果
     */
    @Override
    public int deleteAppUserByUserIds(Long[] userIds) {
        return appUserMapper.deleteAppUserByUserIds(userIds);
    }

    /**
     * 删除应用端用户信息
     *
     * @param userId 应用端用户主键
     * @return 结果
     */
    @Override
    public int deleteAppUserByUserId(Long userId) {
        return appUserMapper.deleteAppUserByUserId(userId);
    }

    /**
     * 校验用户名是否唯一
     *
     * @param username 用户名
     * @return 结果
     */
    @Override
    public boolean checkUsernameUnique(String username) {
        int count = appUserMapper.checkUsernameUnique(username);
        return count == 0;
    }

    /**
     * 更新用户状态（封禁/解封）
     *
     * @param appUser 用户信息
     * @return 结果
     */
    @Override
    public int updateUserStatus(AppUser appUser) {
        return appUserMapper.updateAppUser(appUser);
    }
}

