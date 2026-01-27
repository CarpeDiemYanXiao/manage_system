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
import com.housekeeping.housekeeping.domain.Cancel;
import com.housekeeping.housekeeping.service.ICancelService;
import com.housekeeping.common.utils.poi.ExcelUtil;
import com.housekeeping.common.core.page.TableDataInfo;

/**
 * 取消记录Controller
 *
 * @author Housekeeping
 * @date 2025-07-19
 */
@RestController
@RequestMapping("/housekeeping/cancel")
public class CancelController extends BaseController
{
    @Autowired
    private ICancelService cancelService;

    /**
     * 查询取消记录列表
     */
    @GetMapping("/list")
    public TableDataInfo list(Cancel cancel)
    {
        startPage();
        List<Cancel> list = cancelService.selectCancelList(cancel);
        return getDataTable(list);
    }

    /**
     * 导出取消记录列表
     */
    @Log(title = "取消记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Cancel cancel)
    {
        List<Cancel> list = cancelService.selectCancelList(cancel);
        ExcelUtil<Cancel> util = new ExcelUtil<Cancel>(Cancel.class);
        util.exportExcel(response, list, "取消记录数据");
    }

    /**
     * 下载模板
     */
    @PostMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response)
    {
        ExcelUtil<Cancel> util = new ExcelUtil<Cancel>(Cancel.class);
        util.importTemplateExcel(response, "取消记录数据");
    }

    /**
     * 导入数据
     */
    @Log(title = "取消记录", businessType = BusinessType.IMPORT)
    @PostMapping("/importData")
    public AjaxResult importData(MultipartFile file) throws Exception
    {
        ExcelUtil<Cancel> util = new ExcelUtil<Cancel>(Cancel.class);
        InputStream inputStream = file.getInputStream();
        List<Cancel> list = util.importExcel(inputStream );
        inputStream.close();
        int count = cancelService.batchInsertCancel(list);
        return AjaxResult.success("导入成功" + count + "条信息！");
    }

    /**
     * 获取取消记录详细信息
     */
    @GetMapping(value = "/{cancelId}")
    public AjaxResult getInfo(@PathVariable("cancelId") String cancelId)
    {
        return success(cancelService.selectCancelByCancelId(cancelId));
    }

    /**
     * 新增取消记录
     */
    @Log(title = "取消记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Cancel cancel)
    {
        return toAjax(cancelService.insertCancel(cancel));
    }

    /**
     * 修改取消记录
     */
    @Log(title = "取消记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Cancel cancel)
    {
        return toAjax(cancelService.updateCancel(cancel));
    }

    /**
     * 删除取消记录
     */
    @Log(title = "取消记录", businessType = BusinessType.DELETE)
	@DeleteMapping("/{cancelIds}")
    public AjaxResult remove(@PathVariable String[] cancelIds)
    {
        return toAjax(cancelService.deleteCancelByCancelIds(cancelIds));
    }
}

