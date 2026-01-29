package com.housekeeping.housekeeping.controller;

import com.housekeeping.common.constant.Constants;
import com.housekeeping.common.core.domain.AjaxResult;
import com.housekeeping.common.core.domain.model.LoginBody;
import com.housekeeping.common.utils.StringUtils;
import com.housekeeping.housekeeping.domain.Staff;
import com.housekeeping.housekeeping.service.IStaffService;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import com.housekeeping.common.config.HousekeepingConfig;
import com.housekeeping.common.utils.file.FileUploadUtils;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * 服务人员登录验证Controller
 *
 * @author Housekeeping
 * @date 2026-01-25
 */
@RestController
@RequestMapping("/staff")
public class StaffLoginController {

    @Autowired
    private IStaffService staffService;

    @Value("${token.secret}")
    private String secret;

    @Value("${token.expireTime}")
    private int expireTime;

    /**
     * 服务人员登录
     */
    @PostMapping("/login")
    public AjaxResult login(@RequestBody LoginBody loginBody) {
        String username = loginBody.getUsername();
        String password = loginBody.getPassword();

        // 校验参数
        if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
            return AjaxResult.error("用户名或密码不能为空");
        }

        // 查询员工
        Staff staff = staffService.selectStaffByUsername(username);
        if (staff == null) {
            return AjaxResult.error("用户不存在");
        }

        // 校验密码
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        if (!encoder.matches(password, staff.getPassword())) {
            return AjaxResult.error("密码错误");
        }

        // 校验账号状态
        if ("封禁".equals(staff.getAccountStatus())) {
            return AjaxResult.error("账号已被封禁，请联系管理员");
        }

        // 生成Token
        String token = createToken(staff);

        AjaxResult ajax = AjaxResult.success();
        ajax.put(Constants.TOKEN, token);
        return ajax;
    }

    /**
     * 服务人员注册
     */
    @PostMapping("/register")
    public AjaxResult register(@RequestBody Staff staff) {
        // 校验参数
        if (StringUtils.isEmpty(staff.getUsername())) {
            return AjaxResult.error("用户名不能为空");
        }
        if (StringUtils.isEmpty(staff.getPassword())) {
            return AjaxResult.error("密码不能为空");
        }
        if (StringUtils.isEmpty(staff.getName())) {
            return AjaxResult.error("姓名不能为空");
        }
        if (StringUtils.isEmpty(staff.getPhone())) {
            return AjaxResult.error("手机号不能为空");
        }
        if (StringUtils.isEmpty(staff.getStaffType())) {
            return AjaxResult.error("服务类型不能为空");
        }

        // 校验用户名唯一
        if (!staffService.checkUsernameUnique(staff.getUsername())) {
            return AjaxResult.error("注册用户'" + staff.getUsername() + "'失败，账号已存在");
        }

        // 注册
        boolean result = staffService.registerStaff(staff);
        return result ? AjaxResult.success("注册成功") : AjaxResult.error("注册失败");
    }

    /**
     * 获取当前登录员工信息
     */
    @GetMapping("/getInfo")
    public AjaxResult getInfo(@RequestHeader(value = "Authorization", required = false) String token) {
        if (StringUtils.isEmpty(token)) {
            return AjaxResult.error("未登录");
        }

        try {
            // 去除Bearer前缀
            if (token.startsWith("Bearer ")) {
                token = token.substring(7);
            }

            // 解析token获取staffId
            String staffId = Jwts.parser()
                    .setSigningKey(secret)
                    .parseClaimsJws(token)
                    .getBody()
                    .getSubject();

            Staff staff = staffService.selectStaffByStaffId(staffId);
            if (staff == null) {
                return AjaxResult.error("用户不存在");
            }

            // 清除密码
            staff.setPassword(null);

            AjaxResult ajax = AjaxResult.success();
            ajax.put("staff", staff);
            return ajax;
        } catch (Exception e) {
            return AjaxResult.error("Token无效或已过期");
        }
    }

    /**
     * 更新个人信息
     */
    @PutMapping("/updateInfo")
    public AjaxResult updateInfo(@RequestHeader("Authorization") String token, @RequestBody Staff staff) {
        try {
            // 去除Bearer前缀
            if (token.startsWith("Bearer ")) {
                token = token.substring(7);
            }

            // 解析token获取staffId
            String staffId = Jwts.parser()
                    .setSigningKey(secret)
                    .parseClaimsJws(token)
                    .getBody()
                    .getSubject();

            // 只允许更新自己的信息
            staff.setStaffId(staffId);
            // 不允许通过此接口修改账号状态和密码
            staff.setAccountStatus(null);
            staff.setPassword(null);
            staff.setUsername(null);

            return staffService.updateStaff(staff) > 0 ? AjaxResult.success() : AjaxResult.error();
        } catch (Exception e) {
            return AjaxResult.error("Token无效或已过期");
        }
    }

    /**
     * 修改密码
     */
    @PutMapping("/updatePwd")
    public AjaxResult updatePwd(@RequestHeader("Authorization") String token,
            @RequestParam String oldPassword,
            @RequestParam String newPassword) {
        try {
            // 去除Bearer前缀
            if (token.startsWith("Bearer ")) {
                token = token.substring(7);
            }

            // 解析token获取staffId
            String staffId = Jwts.parser()
                    .setSigningKey(secret)
                    .parseClaimsJws(token)
                    .getBody()
                    .getSubject();

            Staff staff = staffService.selectStaffByStaffId(staffId);
            if (staff == null) {
                return AjaxResult.error("用户不存在");
            }

            // 校验旧密码
            BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
            if (!encoder.matches(oldPassword, staff.getPassword())) {
                return AjaxResult.error("旧密码错误");
            }

            // 更新新密码
            Staff updateStaff = new Staff();
            updateStaff.setStaffId(staffId);
            updateStaff.setPassword(encoder.encode(newPassword));

            return staffService.updateStaff(updateStaff) > 0 ? AjaxResult.success() : AjaxResult.error();
        } catch (Exception e) {
            return AjaxResult.error("Token无效或已过期");
        }
    }

    /**
     * 服务人员上传文件（照片等）
     */
    @PostMapping("/upload")
    public AjaxResult uploadFile(@RequestHeader("Authorization") String token, MultipartFile file) {
        try {
            // 验证token
            if (StringUtils.isEmpty(token)) {
                return AjaxResult.error("未登录");
            }
            if (token.startsWith("Bearer ")) {
                token = token.substring(7);
            }
            // 解析token验证有效性
            Jwts.parser().setSigningKey(secret).parseClaimsJws(token);

            // 上传文件路径
            String filePath = HousekeepingConfig.getUploadPath();
            // 上传并返回新文件名称
            String fileName = FileUploadUtils.upload(filePath, file);
            AjaxResult ajax = AjaxResult.success();
            ajax.put("url", fileName);
            ajax.put("fileName", fileName);
            return ajax;
        } catch (Exception e) {
            return AjaxResult.error("上传失败：" + e.getMessage());
        }
    }

    /**
     * 生成Token
     */
    private String createToken(Staff staff) {
        Map<String, Object> claims = new HashMap<>();
        claims.put("staffId", staff.getStaffId());
        claims.put("username", staff.getUsername());
        claims.put("name", staff.getName());

        return Jwts.builder()
                .setClaims(claims)
                .setSubject(staff.getStaffId())
                .setId(UUID.randomUUID().toString())
                .setIssuedAt(new java.util.Date())
                .setExpiration(new java.util.Date(System.currentTimeMillis() + expireTime * 60 * 1000L))
                .signWith(SignatureAlgorithm.HS512, secret)
                .compact();
    }
}
