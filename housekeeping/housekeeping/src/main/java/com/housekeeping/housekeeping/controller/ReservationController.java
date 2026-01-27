package com.housekeeping.housekeeping.controller;

import java.util.List;

import com.housekeeping.common.core.domain.entity.SysUser;
import com.housekeeping.housekeeping.domain.Staff;
import com.housekeeping.housekeeping.service.IStaffService;
import com.housekeeping.system.service.ISysUserService;
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
import com.housekeeping.housekeeping.domain.Reservation;
import com.housekeeping.housekeeping.service.IReservationService;
import com.housekeeping.common.utils.poi.ExcelUtil;
import com.housekeeping.common.core.page.TableDataInfo;

/**
 * 预约Controller
 *
 * @author Housekeeping
 * @date 2025-07-17
 */
@RestController
@RequestMapping("/housekeeping/reservation")
public class ReservationController extends BaseController {
    @Autowired
    private IReservationService reservationService;

    @Autowired
    private ISysUserService sysUserService;

    @Autowired
    private IStaffService staffService;

    /**
     * 查询预约列表
     */
    @GetMapping("/list")
    public TableDataInfo list(Reservation reservation) {
        startPage();
        List<Reservation> list = reservationService.selectReservationList(reservation);
        return getDataTable(list);
    }

    /**
     * 导出预约列表
     */
    @Log(title = "预约", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Reservation reservation) {
        List<Reservation> list = reservationService.selectReservationList(reservation);
        ExcelUtil<Reservation> util = new ExcelUtil<Reservation>(Reservation.class);
        util.exportExcel(response, list, "预约数据");
    }

    /**
     * 下载模板
     */
    @PostMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response) {
        ExcelUtil<Reservation> util = new ExcelUtil<Reservation>(Reservation.class);
        util.importTemplateExcel(response, "预约数据");
    }

    /**
     * 导入数据
     */
    @Log(title = "预约", businessType = BusinessType.IMPORT)
    @PostMapping("/importData")
    public AjaxResult importData(MultipartFile file) throws Exception {
        ExcelUtil<Reservation> util = new ExcelUtil<Reservation>(Reservation.class);
        InputStream inputStream = file.getInputStream();
        List<Reservation> list = util.importExcel(inputStream);
        inputStream.close();
        int count = reservationService.batchInsertReservation(list);
        return AjaxResult.success("导入成功" + count + "条信息！");
    }

    /**
     * 获取预约详细信息
     */
    @GetMapping(value = "/{reservationId}")
    public AjaxResult getInfo(@PathVariable("reservationId") String reservationId) {
        return success(reservationService.selectReservationByReservationId(reservationId));
    }

    /**
     * 新增预约
     */
    @Log(title = "预约", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Reservation reservation) {
        return toAjax(reservationService.insertReservation(reservation));
    }

    /**
     * 修改预约
     */
    @Log(title = "预约", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Reservation reservation) {
        return toAjax(reservationService.updateReservation(reservation));
    }

    /**
     * 删除预约
     */
    @Log(title = "预约", businessType = BusinessType.DELETE)
    @DeleteMapping("/{reservationIds}")
    public AjaxResult remove(@PathVariable String[] reservationIds) {
        return toAjax(reservationService.deleteReservationByReservationIds(reservationIds));
    }

    /**
     * 订单支付
     */
    @PutMapping("/payment/{reservationId}")
    public AjaxResult payment(@PathVariable String reservationId) {
        // 获取当前操作用户的userId
        Long userId = getUserId();

        // 查询当前用户的余额
        Double balance = sysUserService.selectUserById(userId).getBalance();

        // 该服务的价格
        Double price = reservationService.selectReservationByReservationId(reservationId).getPrice();

        // 判断余额是否小于价格
        if (balance < price) { // 余额小于价格, 不能支付
            return error("余额不足, 请充值后再支付!");
        } else { // 余额大于或者等于价格, 可以进行支付
            // 对用户的余额进行扣费
            SysUser user = new SysUser();
            user.setUserId(userId);
            user.setBalance(balance - price);
            sysUserService.updateUser(user);

            // 将预约订单的状态修改为待确认
            Reservation reservation = new Reservation();
            reservation.setReservationId(reservationId);
            reservation.setStatus("待确认");
            return toAjax(reservationService.updateReservation(reservation));
        }
    }

    /**
     * 用户确认服务完成
     * 同时将服务人员状态改为空闲
     */
    @PutMapping("/complete/{reservationId}")
    public AjaxResult complete(@PathVariable String reservationId) {
        // 查询订单信息
        Reservation existingReservation = reservationService.selectReservationByReservationId(reservationId);
        if (existingReservation == null) {
            return error("订单不存在");
        }

        // 只有待确认状态的订单才能确认完成
        if (!"待确认".equals(existingReservation.getStatus())) {
            return error("订单状态不正确，无法确认完成");
        }

        // 更新订单状态为已完成
        Reservation reservation = new Reservation();
        reservation.setReservationId(reservationId);
        reservation.setStatus("已完成");
        int result = reservationService.updateReservation(reservation);

        if (result > 0) {
            // 将服务人员状态改为空闲
            String staffId = existingReservation.getStaffId();
            if (staffId != null && !staffId.isEmpty()) {
                Staff staff = new Staff();
                staff.setStaffId(staffId);
                staff.setStatus("空闲");
                staffService.updateStaff(staff);
            }
            return success("服务已确认完成");
        }
        return error("操作失败");
    }

}
