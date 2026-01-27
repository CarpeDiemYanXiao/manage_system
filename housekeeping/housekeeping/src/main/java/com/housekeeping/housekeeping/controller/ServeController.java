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
import com.housekeeping.housekeeping.domain.Serve;
import com.housekeeping.housekeeping.service.IServeService;
import com.housekeeping.common.utils.poi.ExcelUtil;
import com.housekeeping.common.core.page.TableDataInfo;

/**
 * 服务Controller
 *
 * @author Housekeeping
 * @date 2025-07-10
 */
@RestController
@RequestMapping("/housekeeping/serve")
public class ServeController extends BaseController
{
    @Autowired
    private IServeService serveService;

    /**
     * 查询服务列表
     */
    @GetMapping("/list")
    public TableDataInfo list(Serve serve)
    {
        startPage();
        List<Serve> list = serveService.selectServeList(serve);
        return getDataTable(list);
    }

    /**
     * 导出服务列表
     */
    @Log(title = "服务", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Serve serve)
    {
        List<Serve> list = serveService.selectServeList(serve);
        ExcelUtil<Serve> util = new ExcelUtil<Serve>(Serve.class);
        util.exportExcel(response, list, "服务数据");
    }

    /**
     * 下载模板
     */
    @PostMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response)
    {
        ExcelUtil<Serve> util = new ExcelUtil<Serve>(Serve.class);
        util.importTemplateExcel(response, "服务数据");
    }

    /**
     * 导入数据
     */
    @Log(title = "服务", businessType = BusinessType.IMPORT)
    @PostMapping("/importData")
    public AjaxResult importData(MultipartFile file) throws Exception
    {
        ExcelUtil<Serve> util = new ExcelUtil<Serve>(Serve.class);
        InputStream inputStream = file.getInputStream();
        List<Serve> list = util.importExcel(inputStream );
        inputStream.close();
        int count = serveService.batchInsertServe(list);
        return AjaxResult.success("导入成功" + count + "条信息！");
    }

    /**
     * 获取服务详细信息
     */
    @GetMapping(value = "/{serveId}")
    public AjaxResult getInfo(@PathVariable("serveId") String serveId)
    {
        return success(serveService.selectServeByServeId(serveId));
    }

    /**
     * 新增服务
     */
    @Log(title = "服务", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Serve serve)
    {
        return toAjax(serveService.insertServe(serve));
    }

    /**
     * 修改服务
     */
    @Log(title = "服务", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Serve serve)
    {
        return toAjax(serveService.updateServe(serve));
    }

    /**
     * 删除服务
     */
    @Log(title = "服务", businessType = BusinessType.DELETE)
	@DeleteMapping("/{serveIds}")
    public AjaxResult remove(@PathVariable String[] serveIds)
    {
        return toAjax(serveService.deleteServeByServeIds(serveIds));
    }
}

