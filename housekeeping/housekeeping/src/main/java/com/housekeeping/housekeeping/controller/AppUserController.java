package com.housekeeping.housekeeping.controller;

import com.housekeeping.common.annotation.Log;
import com.housekeeping.common.core.controller.BaseController;
import com.housekeeping.common.core.domain.AjaxResult;
import com.housekeeping.common.core.page.TableDataInfo;
import com.housekeeping.common.enums.BusinessType;
import com.housekeeping.common.utils.poi.ExcelUtil;
import com.housekeeping.housekeeping.domain.AppUser;
import com.housekeeping.housekeeping.service.IAppUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * App用户管理Controller
 * 用于管理端查看和管理App端注册的用户
 *
 * @author Housekeeping
 * @date 2026-01-25
 */
@RestController
@RequestMapping("/housekeeping/appuser")
public class AppUserController extends BaseController {

    @Autowired
    private IAppUserService appUserService;

    /**
     * 查询App用户列表
     */
    @PreAuthorize("@ss.hasPermi('housekeeping:appuser:list')")
    @GetMapping("/list")
    public TableDataInfo list(AppUser appUser) {
        startPage();
        List<AppUser> list = appUserService.selectAppUserList(appUser);
        return getDataTable(list);
    }

    /**
     * 导出App用户列表
     */
    @PreAuthorize("@ss.hasPermi('housekeeping:appuser:export')")
    @Log(title = "App用户", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, AppUser appUser) {
        List<AppUser> list = appUserService.selectAppUserList(appUser);
        ExcelUtil<AppUser> util = new ExcelUtil<>(AppUser.class);
        util.exportExcel(response, list, "App用户数据");
    }

    /**
     * 获取App用户详细信息
     */
    @PreAuthorize("@ss.hasPermi('housekeeping:appuser:query')")
    @GetMapping(value = "/{userId}")
    public AjaxResult getInfo(@PathVariable("userId") Long userId) {
        return success(appUserService.selectAppUserByUserId(userId));
    }

    /**
     * 修改App用户状态（封禁/解封）
     */
    @PreAuthorize("@ss.hasPermi('housekeeping:appuser:edit')")
    @Log(title = "App用户", businessType = BusinessType.UPDATE)
    @PutMapping("/changeStatus")
    public AjaxResult changeStatus(@RequestBody AppUser appUser) {
        return toAjax(appUserService.updateUserStatus(appUser));
    }

    /**
     * 删除App用户
     */
    @PreAuthorize("@ss.hasPermi('housekeeping:appuser:remove')")
    @Log(title = "App用户", businessType = BusinessType.DELETE)
    @DeleteMapping("/{userIds}")
    public AjaxResult remove(@PathVariable Long[] userIds) {
        return toAjax(appUserService.deleteAppUserByUserIds(userIds));
    }

    /**
     * 重置用户密码
     */
    @PreAuthorize("@ss.hasPermi('housekeeping:appuser:resetPwd')")
    @Log(title = "App用户", businessType = BusinessType.UPDATE)
    @PutMapping("/resetPwd")
    public AjaxResult resetPwd(@RequestBody AppUser appUser) {
        // 默认重置为123456
        appUser.setPassword("$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2");
        return toAjax(appUserService.updateAppUser(appUser));
    }
}

