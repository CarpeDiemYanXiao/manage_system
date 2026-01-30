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
import com.housekeeping.housekeeping.domain.Assess;
import com.housekeeping.housekeeping.service.IAssessService;
import com.housekeeping.common.utils.poi.ExcelUtil;
import com.housekeeping.common.core.page.TableDataInfo;

/**
 * 评价Controller
 *
 * @author Housekeeping
 * @date 2025-07-20
 */
@RestController
@RequestMapping("/housekeeping/assess")
public class AssessController extends BaseController {
    @Autowired
    private IAssessService assessService;

    /**
     * 查询评价列表
     */
    @GetMapping("/list")
    public TableDataInfo list(Assess assess) {
        startPage();
        List<Assess> list = assessService.selectAssessList(assess);
        return getDataTable(list);
    }

    /**
     * 导出评价列表
     */
    @Log(title = "评价", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Assess assess) {
        List<Assess> list = assessService.selectAssessList(assess);
        ExcelUtil<Assess> util = new ExcelUtil<Assess>(Assess.class);
        util.exportExcel(response, list, "评价数据");
    }

    /**
     * 下载模板
     */
    @PostMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response) {
        ExcelUtil<Assess> util = new ExcelUtil<Assess>(Assess.class);
        util.importTemplateExcel(response, "评价数据");
    }

    /**
     * 导入数据
     */
    @Log(title = "评价", businessType = BusinessType.IMPORT)
    @PostMapping("/importData")
    public AjaxResult importData(MultipartFile file) throws Exception {
        ExcelUtil<Assess> util = new ExcelUtil<Assess>(Assess.class);
        InputStream inputStream = file.getInputStream();
        List<Assess> list = util.importExcel(inputStream);
        inputStream.close();
        int count = assessService.batchInsertAssess(list);
        return AjaxResult.success("导入成功" + count + "条信息！");
    }

    /**
     * 获取评价详细信息
     */
    @GetMapping(value = "/{assessId}")
    public AjaxResult getInfo(@PathVariable("assessId") String assessId) {
        return success(assessService.selectAssessByAssessId(assessId));
    }

    /**
     * 新增评价
     */
    @Log(title = "评价", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Assess assess) {
        // 检查该订单是否已经评价过
        if (assess.getReservationId() != null && !assess.getReservationId().isEmpty()) {
            Assess query = new Assess();
            query.setReservationId(assess.getReservationId());
            List<Assess> existList = assessService.selectAssessList(query);
            if (existList != null && !existList.isEmpty()) {
                return AjaxResult.error("该订单已经评价过，不能重复评价");
            }
        }
        return toAjax(assessService.insertAssess(assess));
    }

    /**
     * 修改评价
     */
    @Log(title = "评价", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Assess assess) {
        return toAjax(assessService.updateAssess(assess));
    }

    /**
     * 删除评价
     */
    @Log(title = "评价", businessType = BusinessType.DELETE)
    @DeleteMapping("/{assessIds}")
    public AjaxResult remove(@PathVariable String[] assessIds) {
        return toAjax(assessService.deleteAssessByAssessIds(assessIds));
    }
}
