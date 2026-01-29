package com.housekeeping.housekeeping.controller;

import com.housekeeping.common.core.controller.BaseController;
import com.housekeeping.common.core.domain.AjaxResult;
import com.housekeeping.common.core.page.TableDataInfo;
import com.housekeeping.common.utils.StringUtils;
import com.housekeeping.housekeeping.domain.Staff;
import com.housekeeping.housekeeping.service.IStaffService;
import com.housekeeping.common.core.domain.entity.SysUser;
import com.housekeeping.system.service.ISysUserService;
import com.housekeeping.housekeeping.domain.Assess;
import com.housekeeping.housekeeping.domain.Reservation;
import com.housekeeping.housekeeping.service.IAssessService;
import com.housekeeping.housekeeping.service.IReservationService;
import io.jsonwebtoken.Jwts;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 服务人员订单管理Controller
 *
 * @author Housekeeping
 * @date 2026-01-25
 */
@RestController
@RequestMapping("/staff/order")
public class StaffOrderController extends BaseController {

    @Autowired
    private IReservationService reservationService;

    @Autowired
    private IAssessService assessService;

    @Autowired
    private ISysUserService userService;

    @Autowired
    private IStaffService staffService;

    @Value("${token.secret}")
    private String secret;

    /**
     * 查询待接订单列表（分配给当前员工但未确认的订单）
     */
    @GetMapping("/pending")
    public TableDataInfo pendingList(@RequestHeader("Authorization") String token) {
        String staffId = getStaffIdFromToken(token);
        if (staffId == null) {
            return getDataTable(List.of());
        }

        startPage();
        Reservation query = new Reservation();
        query.setStaffId(staffId);
        query.setStatus("待确认"); // 只查询待确认状态的订单
        List<Reservation> list = reservationService.selectReservationList(query);
        return getDataTable(list);
    }

    /**
     * 查询进行中订单列表
     */
    @GetMapping("/ongoing")
    public TableDataInfo ongoingList(@RequestHeader("Authorization") String token) {
        String staffId = getStaffIdFromToken(token);
        if (staffId == null) {
            return getDataTable(List.of());
        }

        startPage();
        Reservation query = new Reservation();
        query.setStaffId(staffId);
        query.setStatus("进行中"); // 只查询进行中状态的订单
        List<Reservation> list = reservationService.selectReservationList(query);
        return getDataTable(list);
    }

    /**
     * 查询历史订单列表（已完成和已取消的订单）
     */
    @GetMapping("/history")
    public TableDataInfo historyList(@RequestHeader("Authorization") String token,
            @RequestParam(required = false) String status) {
        String staffId = getStaffIdFromToken(token);
        if (staffId == null) {
            return getDataTable(List.of());
        }

        startPage();
        Reservation query = new Reservation();
        query.setStaffId(staffId);
        // 如果指定了状态，按状态查询；否则查询已完成或已取消的订单
        if (StringUtils.isNotEmpty(status)) {
            query.setStatus(status);
        }
        List<Reservation> list = reservationService.selectReservationList(query);

        // 过滤只保留已完成和已取消的订单
        if (StringUtils.isEmpty(status)) {
            list = list.stream()
                    .filter(r -> "已完成".equals(r.getStatus()) || "已取消".equals(r.getStatus())
                            || "已拒绝".equals(r.getStatus()))
                    .toList();
        }
        return getDataTable(list);
    }

    /**
     * 获取订单详情
     */
    @GetMapping("/{reservationId}")
    public AjaxResult getInfo(@RequestHeader("Authorization") String token,
            @PathVariable String reservationId) {
        String staffId = getStaffIdFromToken(token);
        if (staffId == null) {
            return AjaxResult.error("未登录");
        }

        Reservation reservation = reservationService.selectReservationByReservationId(reservationId);
        if (reservation == null) {
            return AjaxResult.error("订单不存在");
        }

        // 只能查看分配给自己的订单
        if (!staffId.equals(reservation.getStaffId())) {
            return AjaxResult.error("无权查看此订单");
        }

        return AjaxResult.success(reservation);
    }

    /**
     * 确认接单
     */
    @PutMapping("/accept/{reservationId}")
    public AjaxResult acceptOrder(@RequestHeader("Authorization") String token,
            @PathVariable String reservationId) {
        String staffId = getStaffIdFromToken(token);
        if (staffId == null) {
            return AjaxResult.error("未登录");
        }

        Reservation reservation = reservationService.selectReservationByReservationId(reservationId);
        if (reservation == null) {
            return AjaxResult.error("订单不存在");
        }

        // 只能操作分配给自己的订单
        if (!staffId.equals(reservation.getStaffId())) {
            return AjaxResult.error("无权操作此订单");
        }

        // 只有待确认状态的订单才能接单
        if (!"待确认".equals(reservation.getStatus())) {
            return AjaxResult.error("订单状态不正确，无法接单");
        }

        // 更新订单状态为进行中
        Reservation update = new Reservation();
        update.setReservationId(reservationId);
        update.setStatus("进行中");

        return reservationService.updateReservation(update) > 0 ? AjaxResult.success("接单成功") : AjaxResult.error("接单失败");
    }

    /**
     * 拒绝订单
     */
    @PutMapping("/reject/{reservationId}")
    public AjaxResult rejectOrder(@RequestHeader("Authorization") String token,
            @PathVariable String reservationId,
            @RequestParam(required = false) String reason) {
        String staffId = getStaffIdFromToken(token);
        if (staffId == null) {
            return AjaxResult.error("未登录");
        }

        Reservation reservation = reservationService.selectReservationByReservationId(reservationId);
        if (reservation == null) {
            return AjaxResult.error("订单不存在");
        }

        // 只能操作分配给自己的订单
        if (!staffId.equals(reservation.getStaffId())) {
            return AjaxResult.error("无权操作此订单");
        }

        // 只有待确认状态的订单才能拒绝
        if (!"待确认".equals(reservation.getStatus())) {
            return AjaxResult.error("订单状态不正确，无法拒绝");
        }

        // 退还金额给用户
        if (reservation.getUserId() != null && reservation.getPrice() != null) {
            SysUser user = userService.selectUserById(reservation.getUserId());
            if (user != null) {
                // 如果余额为空，初始化为0
                double currentBalance = user.getBalance() != null ? user.getBalance() : 0.0;
                user.setBalance(currentBalance + reservation.getPrice());
                userService.updateUser(user);
            }
        }

        // 更新订单状态为已拒绝，并清空员工ID以便重新分配
        Reservation update = new Reservation();
        update.setReservationId(reservationId);
        update.setStatus("已拒绝");
        update.setStaffId(null); // 清空员工ID
        update.setRemark(reason);

        int result = reservationService.updateReservation(update);
        if (result > 0) {
            // 将服务人员状态改为空闲
            Staff staff = new Staff();
            staff.setStaffId(staffId);
            staff.setStatus("空闲");
            staffService.updateStaff(staff);
            return AjaxResult.success("已拒绝订单");
        }
        return AjaxResult.error("操作失败");
    }

    /**
     * 完成订单
     */
    @PutMapping("/complete/{reservationId}")
    public AjaxResult completeOrder(@RequestHeader("Authorization") String token,
            @PathVariable String reservationId) {
        String staffId = getStaffIdFromToken(token);
        if (staffId == null) {
            return AjaxResult.error("未登录");
        }

        Reservation reservation = reservationService.selectReservationByReservationId(reservationId);
        if (reservation == null) {
            return AjaxResult.error("订单不存在");
        }

        // 只能操作分配给自己的订单
        if (!staffId.equals(reservation.getStaffId())) {
            return AjaxResult.error("无权操作此订单");
        }

        // 只有进行中状态的订单才能完成
        if (!"进行中".equals(reservation.getStatus())) {
            return AjaxResult.error("订单状态不正确，无法完成");
        }

        // 更新订单状态为已完成
        Reservation update = new Reservation();
        update.setReservationId(reservationId);
        update.setStatus("已完成");

        int result = reservationService.updateReservation(update);
        if (result > 0) {
            // 将服务人员状态改为空闲
            Staff staff = new Staff();
            staff.setStaffId(staffId);
            staff.setStatus("空闲");
            staffService.updateStaff(staff);
            return AjaxResult.success("订单已完成");
        }
        return AjaxResult.error("操作失败");
    }

    /**
     * 查询订单评价
     */
    @GetMapping("/assess/{reservationId}")
    public AjaxResult getAssess(@RequestHeader("Authorization") String token,
            @PathVariable String reservationId) {
        String staffId = getStaffIdFromToken(token);
        if (staffId == null) {
            return AjaxResult.error("未登录");
        }

        Reservation reservation = reservationService.selectReservationByReservationId(reservationId);
        if (reservation == null) {
            return AjaxResult.error("订单不存在");
        }

        // 只能查看分配给自己的订单的评价
        if (!staffId.equals(reservation.getStaffId())) {
            return AjaxResult.error("无权查看此订单评价");
        }

        // 查询订单评价
        Assess query = new Assess();
        query.setReservationId(reservationId);
        List<Assess> assessList = assessService.selectAssessList(query);

        return AjaxResult.success(assessList.isEmpty() ? null : assessList.get(0));
    }

    /**
     * 查询我的所有评价列表
     */
    @GetMapping("/myAssess")
    public TableDataInfo myAssessList(@RequestHeader("Authorization") String token) {
        String staffId = getStaffIdFromToken(token);
        if (staffId == null) {
            return getDataTable(List.of());
        }

        startPage();
        Assess query = new Assess();
        query.setStaffId(staffId);
        List<Assess> list = assessService.selectAssessList(query);
        return getDataTable(list);
    }

    /**
     * 从Token中获取staffId
     */
    private String getStaffIdFromToken(String token) {
        try {
            if (StringUtils.isEmpty(token)) {
                return null;
            }
            if (token.startsWith("Bearer ")) {
                token = token.substring(7);
            }
            return Jwts.parser()
                    .setSigningKey(secret)
                    .parseClaimsJws(token)
                    .getBody()
                    .getSubject();
        } catch (Exception e) {
            return null;
        }
    }
}
