package com.housekeeping.housekeeping.controller;

import java.util.List;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.housekeeping.common.annotation.Log;
import com.housekeeping.common.core.controller.BaseController;
import com.housekeeping.common.core.domain.AjaxResult;
import com.housekeeping.common.enums.BusinessType;
import java.io.InputStream;
import org.springframework.web.multipart.MultipartFile;
import com.housekeeping.housekeeping.domain.Staff;
import com.housekeeping.housekeeping.service.IStaffService;
import com.housekeeping.common.utils.poi.ExcelUtil;
import com.housekeeping.common.core.page.TableDataInfo;

/**
 * 服务人员Controller
 *
 * @author Housekeeping
 * @date 2025-07-17
 */
@RestController
@RequestMapping("/housekeeping/staff")
public class StaffController extends BaseController
{
    @Autowired
    private IStaffService staffService;

    /**
     * 查询服务人员列表
     */
    @GetMapping("/list")
    public TableDataInfo list(Staff staff)
    {
        startPage();
        List<Staff> list = staffService.selectStaffList(staff);
        return getDataTable(list);
    }

    /**
     * 导出服务人员列表
     */
    @Log(title = "服务人员", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Staff staff)
    {
        List<Staff> list = staffService.selectStaffList(staff);
        ExcelUtil<Staff> util = new ExcelUtil<Staff>(Staff.class);
        util.exportExcel(response, list, "服务人员数据");
    }

    /**
     * 下载模板
     */
    @PostMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response)
    {
        ExcelUtil<Staff> util = new ExcelUtil<Staff>(Staff.class);
        util.importTemplateExcel(response, "服务人员数据");
    }

    /**
     * 导入数据
     */
    @Log(title = "服务人员", businessType = BusinessType.IMPORT)
    @PostMapping("/importData")
    public AjaxResult importData(MultipartFile file) throws Exception
    {
        ExcelUtil<Staff> util = new ExcelUtil<Staff>(Staff.class);
        InputStream inputStream = file.getInputStream();
        List<Staff> list = util.importExcel(inputStream );
        inputStream.close();
        int count = staffService.batchInsertStaff(list);
        return AjaxResult.success("导入成功" + count + "条信息！");
    }

    /**
     * 获取服务人员详细信息
     */
    @GetMapping(value = "/{staffId}")
    public AjaxResult getInfo(@PathVariable("staffId") String staffId)
    {
        return success(staffService.selectStaffByStaffId(staffId));
    }

    /**
     * 新增服务人员
     */
    @Log(title = "服务人员", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Staff staff)
    {
        return toAjax(staffService.insertStaff(staff));
    }

    /**
     * 修改服务人员
     */
    @Log(title = "服务人员", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Staff staff)
    {
        return toAjax(staffService.updateStaff(staff));
    }

    /**
     * 删除服务人员
     */
    @Log(title = "服务人员", businessType = BusinessType.DELETE)
	@DeleteMapping("/{staffIds}")
    public AjaxResult remove(@PathVariable String[] staffIds)
    {
        return toAjax(staffService.deleteStaffByStaffIds(staffIds));
    }
}

