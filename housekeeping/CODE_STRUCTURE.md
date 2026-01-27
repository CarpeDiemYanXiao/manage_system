# 代码结构说明

本文档详细说明项目的代码结构和各模块的功能。

## 项目总体架构

```
housekeeping/                          # 项目根目录
├── admin/                             # 后端启动模块（管理端入口）
├── common/                            # 公共模块（工具类、常量、异常等）
├── framework/                         # 框架核心模块（安全、拦截器、配置等）
├── generator/                         # 代码生成器模块
├── housekeeping/                      # 家政业务模块（核心业务代码）
├── system/                            # 系统管理模块（用户、角色、菜单等）
├── staff-ui/                          # 家政人员端前端
├── user-ui/                           # 用户端前端
├── sql/                               # 数据库脚本
├── pom.xml                            # Maven父工程配置
└── README.md                          # 项目说明文档
```

---

## 一、后端模块详解

### 1. admin 模块（启动入口）

```
admin/
├── src/main/java/com/housekeeping/
│   ├── HousekeepingApplication.java      # SpringBoot启动类
│   ├── HousekeepingServletInitializer.java # War包部署初始化
│   └── web/
│       ├── controller/                    # 控制器
│       │   ├── common/                    # 通用控制器
│       │   │   ├── CaptchaController.java     # 验证码
│       │   │   └── CommonController.java      # 文件上传下载
│       │   ├── monitor/                   # 监控控制器
│       │   │   ├── CacheController.java       # 缓存监控
│       │   │   ├── ServerController.java      # 服务器监控
│       │   │   ├── SysLogininforController.java # 登录日志
│       │   │   ├── SysOperlogController.java  # 操作日志
│       │   │   └── SysUserOnlineController.java # 在线用户
│       │   ├── system/                    # 系统管理控制器
│       │   │   ├── SysConfigController.java   # 参数配置
│       │   │   ├── SysDeptController.java     # 部门管理
│       │   │   ├── SysDictDataController.java # 字典数据
│       │   │   ├── SysDictTypeController.java # 字典类型
│       │   │   ├── SysLoginController.java    # 登录认证
│       │   │   ├── SysMenuController.java     # 菜单管理
│       │   │   ├── SysPostController.java     # 岗位管理
│       │   │   ├── SysProfileController.java  # 个人信息
│       │   │   ├── SysRegisterController.java # 用户注册
│       │   │   ├── SysRoleController.java     # 角色管理
│       │   │   └── SysUserController.java     # 用户管理
│       │   └── tool/                      # 工具控制器
│       │       └── TestController.java        # 测试接口
│       └── core/config/
│           └── SwaggerConfig.java         # Swagger配置
└── src/main/resources/
    ├── application.yml                    # 主配置文件
    ├── application-druid.yml              # 数据源配置
    ├── banner.txt                         # 启动Banner
    ├── logback.xml                        # 日志配置
    ├── i18n/                              # 国际化资源
    └── META-INF/                          # 元数据
```

### 2. common 模块（公共模块）

```
common/src/main/java/com/housekeeping/common/
├── annotation/                            # 自定义注解
│   ├── Anonymous.java                     # 匿名访问
│   ├── DataScope.java                     # 数据权限
│   ├── DataSource.java                    # 数据源切换
│   ├── Excel.java                         # Excel导出
│   ├── Log.java                           # 操作日志
│   ├── RateLimiter.java                   # 限流
│   ├── RepeatSubmit.java                  # 防重复提交
│   └── Sensitive.java                     # 数据脱敏
├── config/
│   └── HousekeepingConfig.java            # 项目配置类
├── constant/                              # 常量定义
│   ├── CacheConstants.java                # 缓存常量
│   ├── Constants.java                     # 通用常量
│   ├── GenConstants.java                  # 代码生成常量
│   ├── HttpStatus.java                    # HTTP状态码
│   └── UserConstants.java                 # 用户常量
├── core/                                  # 核心类
│   ├── controller/
│   │   └── BaseController.java            # 基础控制器
│   ├── domain/                            # 基础实体
│   │   ├── AjaxResult.java                # 统一返回结果
│   │   ├── BaseEntity.java                # 基础实体类
│   │   ├── R.java                         # 通用返回对象
│   │   ├── TreeEntity.java                # 树形实体
│   │   └── TreeSelect.java                # 树形选择
│   ├── page/                              # 分页相关
│   │   ├── PageDomain.java                # 分页参数
│   │   ├── TableDataInfo.java             # 表格数据
│   │   └── TableSupport.java              # 分页支持
│   ├── redis/
│   │   └── RedisCache.java                # Redis缓存工具
│   └── text/                              # 文本处理
│       ├── CharsetKit.java
│       ├── Convert.java
│       └── StrFormatter.java
├── enums/                                 # 枚举类
│   ├── BusinessStatus.java                # 业务状态
│   ├── BusinessType.java                  # 业务类型
│   ├── DataSourceType.java                # 数据源类型
│   ├── DesensitizedType.java              # 脱敏类型
│   ├── HttpMethod.java                    # HTTP方法
│   ├── LimitType.java                     # 限流类型
│   ├── OperatorType.java                  # 操作类型
│   └── UserStatus.java                    # 用户状态
├── exception/                             # 异常类
│   ├── base/
│   │   └── BaseException.java             # 基础异常
│   ├── file/                              # 文件异常
│   ├── user/                              # 用户异常
│   ├── GlobalException.java               # 全局异常
│   ├── ServiceException.java              # 业务异常
│   └── UtilException.java                 # 工具异常
├── filter/                                # 过滤器
│   ├── RepeatableFilter.java              # 可重复读过滤器
│   └── XssFilter.java                     # XSS过滤器
├── utils/                                 # 工具类
│   ├── bean/
│   │   └── BeanUtils.java                 # Bean工具
│   ├── file/
│   │   ├── FileTypeUtils.java             # 文件类型
│   │   ├── FileUploadUtils.java           # 文件上传
│   │   ├── FileUtils.java                 # 文件工具
│   │   └── ImageUtils.java                # 图片工具
│   ├── html/
│   │   ├── EscapeUtil.java                # 转义工具
│   │   └── HTMLFilter.java                # HTML过滤
│   ├── http/
│   │   ├── HttpHelper.java
│   │   └── HttpUtils.java                 # HTTP工具
│   ├── ip/
│   │   ├── AddressUtils.java              # 地址工具
│   │   └── IpUtils.java                   # IP工具
│   ├── poi/
│   │   └── ExcelUtil.java                 # Excel工具
│   ├── reflect/
│   │   └── ReflectUtils.java              # 反射工具
│   ├── sign/
│   │   ├── Base64.java
│   │   └── Md5Utils.java                  # MD5工具
│   ├── spring/
│   │   └── SpringUtils.java               # Spring工具
│   ├── sql/
│   │   └── SqlUtil.java                   # SQL工具
│   ├── uuid/
│   │   ├── IdUtils.java                   # ID生成工具
│   │   └── UUID.java
│   ├── DateUtils.java                     # 日期工具
│   ├── DictUtils.java                     # 字典工具
│   ├── SecurityUtils.java                 # 安全工具
│   ├── ServletUtils.java                  # Servlet工具
│   └── StringUtils.java                   # 字符串工具
└── xss/                                   # XSS防护
    ├── Xss.java
    └── XssValidator.java
```

### 3. framework 模块（框架核心）

```
framework/src/main/java/com/housekeeping/framework/
├── aspectj/                               # 切面
│   ├── DataScopeAspect.java               # 数据权限切面
│   ├── DataSourceAspect.java              # 数据源切面
│   ├── LogAspect.java                     # 日志切面
│   └── RateLimiterAspect.java             # 限流切面
├── config/                                # 配置类
│   ├── properties/
│   │   ├── DruidProperties.java           # Druid配置
│   │   └── PermitAllUrlProperties.java    # 白名单配置
│   ├── ApplicationConfig.java             # 应用配置
│   ├── CaptchaConfig.java                 # 验证码配置
│   ├── DruidConfig.java                   # 数据源配置
│   ├── FilterConfig.java                  # 过滤器配置
│   ├── MyBatisConfig.java                 # MyBatis配置
│   ├── RedisConfig.java                   # Redis配置
│   ├── ResourcesConfig.java               # 资源配置
│   ├── SecurityConfig.java                # Spring Security配置 ⭐
│   ├── ServerConfig.java                  # 服务器配置
│   └── ThreadPoolConfig.java              # 线程池配置
├── datasource/                            # 多数据源
│   ├── DynamicDataSource.java
│   └── DynamicDataSourceContextHolder.java
├── interceptor/                           # 拦截器
│   ├── impl/
│   │   └── SameUrlDataInterceptor.java
│   └── RepeatSubmitInterceptor.java       # 防重复提交
├── manager/                               # 管理器
│   ├── factory/
│   │   └── AsyncFactory.java              # 异步工厂
│   ├── AsyncManager.java                  # 异步管理器
│   └── ShutdownManager.java               # 关闭管理器
├── security/                              # 安全相关 ⭐
│   ├── context/
│   │   ├── AuthenticationContextHolder.java
│   │   └── PermissionContextHolder.java
│   ├── filter/
│   │   └── JwtAuthenticationTokenFilter.java # JWT过滤器
│   ├── handle/
│   │   ├── AuthenticationEntryPointImpl.java # 认证入口
│   │   └── LogoutSuccessHandlerImpl.java     # 登出处理
│   └── web/
│       └── GlobalExceptionHandler.java     # 全局异常处理
└── service/                               # 框架服务
    ├── PermissionService.java             # 权限服务
    ├── SysLoginService.java               # 登录服务
    ├── SysPasswordService.java            # 密码服务
    ├── SysPermissionService.java          # 权限服务
    ├── SysRegisterService.java            # 注册服务
    ├── TokenService.java                  # Token服务 ⭐
    └── UserDetailsServiceImpl.java        # 用户详情服务
```

### 4. housekeeping 模块（家政业务核心）⭐

```
housekeeping/src/main/java/com/housekeeping/housekeeping/
├── controller/                            # 业务控制器
│   ├── AppUserController.java             # App用户管理（管理端）
│   ├── AssessController.java              # 评价管理
│   ├── BannerController.java              # 轮播图管理
│   ├── CancelController.java              # 取消记录管理
│   ├── ReservationController.java         # 预约/订单管理
│   ├── ServeController.java               # 服务项目管理
│   ├── StaffController.java               # 服务人员管理（管理端）
│   ├── StaffLoginController.java          # 服务人员登录（员工端）⭐
│   └── StaffOrderController.java          # 服务人员订单（员工端）⭐
├── domain/                                # 实体类
│   ├── AppUser.java                       # App用户实体
│   ├── Assess.java                        # 评价实体
│   ├── Banner.java                        # 轮播图实体
│   ├── Cancel.java                        # 取消记录实体
│   ├── Reservation.java                   # 预约/订单实体
│   ├── Serve.java                         # 服务项目实体
│   └── Staff.java                         # 服务人员实体
├── mapper/                                # MyBatis Mapper接口
│   ├── AppUserMapper.java
│   ├── AssessMapper.java
│   ├── BannerMapper.java
│   ├── CancelMapper.java
│   ├── ReservationMapper.java
│   ├── ServeMapper.java
│   └── StaffMapper.java
└── service/                               # 业务服务
    ├── impl/                              # 服务实现
    │   ├── AppUserServiceImpl.java
    │   ├── AssessServiceImpl.java
    │   ├── BannerServiceImpl.java
    │   ├── CancelServiceImpl.java
    │   ├── ReservationServiceImpl.java
    │   ├── ServeServiceImpl.java
    │   └── StaffServiceImpl.java
    ├── IAppUserService.java               # App用户服务接口
    ├── IAssessService.java                # 评价服务接口
    ├── IBannerService.java                # 轮播图服务接口
    ├── ICancelService.java                # 取消记录服务接口
    ├── IReservationService.java           # 预约服务接口
    ├── IServeService.java                 # 服务项目服务接口
    └── IStaffService.java                 # 服务人员服务接口

housekeeping/src/main/resources/mapper/housekeeping/
├── AppUserMapper.xml                      # App用户SQL映射
├── AssessMapper.xml                       # 评价SQL映射
├── BannerMapper.xml                       # 轮播图SQL映射
├── CancelMapper.xml                       # 取消记录SQL映射
├── ReservationMapper.xml                  # 预约SQL映射
├── ServeMapper.xml                        # 服务项目SQL映射
└── StaffMapper.xml                        # 服务人员SQL映射
```

### 5. system 模块（系统管理）

```
system/src/main/java/com/housekeeping/system/
├── domain/                                # 系统实体
│   ├── SysCache.java                      # 缓存实体
│   ├── SysConfig.java                     # 参数配置
│   ├── SysDept.java                       # 部门
│   ├── SysDictData.java                   # 字典数据
│   ├── SysDictType.java                   # 字典类型
│   ├── SysLogininfor.java                 # 登录日志
│   ├── SysMenu.java                       # 菜单
│   ├── SysOperLog.java                    # 操作日志
│   ├── SysPost.java                       # 岗位
│   ├── SysRole.java                       # 角色
│   ├── SysUser.java                       # 用户
│   └── vo/                                # 视图对象
│       ├── MetaVo.java
│       └── RouterVo.java
├── mapper/                                # Mapper接口
│   ├── SysConfigMapper.java
│   ├── SysDeptMapper.java
│   ├── SysDictDataMapper.java
│   ├── SysDictTypeMapper.java
│   ├── SysLogininforMapper.java
│   ├── SysMenuMapper.java
│   ├── SysOperLogMapper.java
│   ├── SysPostMapper.java
│   ├── SysRoleMapper.java
│   └── SysUserMapper.java
└── service/                               # 服务层
    ├── impl/                              # 实现类
    └── ISys*Service.java                  # 接口
```

### 6. generator 模块（代码生成器）

```
generator/src/main/java/com/housekeeping/generator/
├── config/
│   └── GenConfig.java                     # 代码生成配置
├── controller/
│   └── GenController.java                 # 代码生成控制器
├── domain/
│   ├── GenTable.java                      # 生成表
│   └── GenTableColumn.java                # 生成表字段
├── mapper/
│   ├── GenTableColumnMapper.java
│   └── GenTableMapper.java
├── service/
│   ├── impl/
│   │   ├── GenTableColumnServiceImpl.java
│   │   └── GenTableServiceImpl.java
│   ├── IGenTableColumnService.java
│   └── IGenTableService.java
└── util/
    ├── GenUtils.java                      # 代码生成工具
    ├── VelocityInitializer.java           # Velocity初始化
    └── VelocityUtils.java                 # Velocity工具

generator/src/main/resources/
├── generator.yml                          # 代码生成配置
├── mapper/generator/                      # Mapper XML
└── vm/                                    # Velocity模板
    ├── java/
    │   ├── controller.java.vm
    │   ├── domain.java.vm
    │   ├── mapper.java.vm
    │   ├── service.java.vm
    │   └── serviceImpl.java.vm
    ├── xml/
    │   └── mapper.xml.vm
    └── vue/                               # Vue模板
```

---

## 二、前端模块详解

### 1. user-ui（用户端前端）

```
user-ui/
├── public/                                # 静态资源
├── src/
│   ├── api/                               # API接口
│   │   ├── housekeeping/                  # 家政业务API
│   │   │   ├── assess.js                  # 评价接口
│   │   │   ├── banner.js                  # 轮播图接口
│   │   │   ├── cancel.js                  # 取消接口
│   │   │   ├── reservation.js             # 预约接口
│   │   │   ├── serve.js                   # 服务接口
│   │   │   └── staff.js                   # 员工接口
│   │   ├── system/                        # 系统API
│   │   │   └── user.js                    # 用户接口
│   │   ├── login.js                       # 登录接口
│   │   └── menu.js                        # 菜单接口
│   ├── assets/                            # 资源文件
│   │   ├── icons/                         # 图标
│   │   ├── images/                        # 图片
│   │   ├── logo/                          # Logo
│   │   └── styles/                        # 样式
│   ├── components/                        # 公共组件
│   │   ├── Breadcrumb/                    # 面包屑
│   │   ├── DictTag/                       # 字典标签
│   │   ├── Editor/                        # 富文本编辑器
│   │   ├── FileUpload/                    # 文件上传
│   │   ├── ImageUpload/                   # 图片上传
│   │   ├── Pagination/                    # 分页
│   │   └── ...
│   ├── directive/                         # 自定义指令
│   │   ├── permission/                    # 权限指令
│   │   └── ...
│   ├── layout/                            # 布局组件
│   │   ├── components/
│   │   │   ├── Navbar.vue                 # 导航栏
│   │   │   ├── Sidebar/                   # 侧边栏
│   │   │   └── TagsView/                  # 标签页
│   │   └── index.vue                      # 主布局
│   ├── plugins/                           # 插件
│   │   ├── auth.js                        # 认证插件
│   │   ├── cache.js                       # 缓存插件
│   │   ├── modal.js                       # 弹窗插件
│   │   └── tab.js                         # 标签页插件
│   ├── router/                            # 路由配置
│   │   └── index.js
│   ├── store/                             # Pinia状态管理
│   │   ├── modules/
│   │   │   ├── app.js                     # 应用状态
│   │   │   ├── dict.js                    # 字典状态
│   │   │   ├── permission.js              # 权限状态
│   │   │   ├── settings.js                # 设置状态
│   │   │   ├── tagsView.js                # 标签状态
│   │   │   └── user.js                    # 用户状态
│   │   └── index.js
│   ├── utils/                             # 工具函数
│   │   ├── auth.js                        # 认证工具
│   │   ├── dict.js                        # 字典工具
│   │   ├── errorCode.js                   # 错误码
│   │   ├── jsencrypt.js                   # 加密工具
│   │   ├── request.js                     # Axios封装
│   │   ├── ruoyi.js                       # 通用方法
│   │   └── validate.js                    # 验证工具
│   ├── views/                             # 页面视图 ⭐
│   │   ├── HomePage/                      # 首页模块
│   │   │   ├── index.vue                  # 首页布局
│   │   │   ├── home.vue                   # 首页（轮播图+评价）
│   │   │   ├── serve.vue                  # 服务列表
│   │   │   ├── booking.vue                # 服务预约
│   │   │   ├── myBooking.vue              # 我的预约
│   │   │   ├── recharge.vue               # 账户充值
│   │   │   └── components/
│   │   │       ├── Assess.vue             # 评价组件
│   │   │       └── cancel.vue             # 取消组件
│   │   ├── system/user/profile/           # 个人中心
│   │   │   ├── index.vue
│   │   │   ├── resetPwd.vue               # 修改密码
│   │   │   └── userInfo.vue               # 用户信息
│   │   ├── login.vue                      # 登录页
│   │   ├── register.vue                   # 注册页
│   │   └── error/                         # 错误页
│   │       ├── 401.vue
│   │       └── 404.vue
│   ├── App.vue                            # 根组件
│   ├── main.js                            # 入口文件
│   ├── permission.js                      # 路由权限
│   └── settings.js                        # 应用设置
├── vite/plugins/                          # Vite插件
├── index.html                             # HTML模板
├── package.json                           # 依赖配置
└── vite.config.js                         # Vite配置
```

### 2. staff-ui（家政人员端前端）

```
staff-ui/
├── src/
│   ├── api/
│   │   ├── login.js                       # 员工登录API ⭐
│   │   └── order.js                       # 订单管理API ⭐
│   ├── store/modules/
│   │   └── user.js                        # 员工状态管理 ⭐
│   ├── views/
│   │   ├── HomePage/
│   │   │   └── index.vue                  # 员工端布局
│   │   ├── staff/                         # 员工功能页面 ⭐
│   │   │   ├── workbench.vue              # 工作台
│   │   │   ├── pendingOrders.vue          # 待接订单
│   │   │   ├── ongoingOrders.vue          # 进行中订单
│   │   │   ├── orderHistory.vue           # 历史订单
│   │   │   ├── myAssess.vue               # 我的评价
│   │   │   └── profile/
│   │   │       └── index.vue              # 个人中心
│   │   ├── login.vue                      # 员工登录
│   │   └── register.vue                   # 员工注册
│   └── router/
│       └── index.js                       # 员工端路由
└── ... (其他同user-ui)
```

---

## 三、数据库结构

### 核心业务表

| 表名 | 说明 | 对应实体 |
|------|------|----------|
| serve | 服务项目表 | Serve.java |
| staff | 服务人员表 | Staff.java |
| reservation | 预约/订单表 | Reservation.java |
| assess | 评价表 | Assess.java |
| cancel | 取消记录表 | Cancel.java |
| banner | 轮播图表 | Banner.java |
| app_user | App用户表 | AppUser.java |

### 系统表（若依框架）

| 表名 | 说明 |
|------|------|
| sys_user | 系统用户 |
| sys_role | 角色 |
| sys_menu | 菜单 |
| sys_dept | 部门 |
| sys_dict_type | 字典类型 |
| sys_dict_data | 字典数据 |
| sys_config | 参数配置 |
| sys_oper_log | 操作日志 |
| sys_logininfor | 登录日志 |

---

## 四、API接口说明

### 管理端接口（需要登录后台）

| 模块 | 路径 | 说明 |
|------|------|------|
| 服务管理 | /housekeeping/serve | 服务项目CRUD |
| 人员管理 | /housekeeping/staff | 服务人员CRUD |
| 订单管理 | /housekeeping/reservation | 订单查看/分配 |
| 评价管理 | /housekeeping/assess | 评价查看/管理 |
| 取消记录 | /housekeeping/cancel | 取消记录查看 |
| 轮播图 | /housekeeping/banner | 轮播图CRUD |
| App用户 | /housekeeping/appuser | 用户查看/封禁 |

### 用户端接口（需要用户登录）

| 路径 | 说明 |
|------|------|
| POST /login | 用户登录 |
| POST /register | 用户注册 |
| GET /getInfo | 获取用户信息 |
| PUT /housekeeping/reservation/payment/{id} | 订单支付 |

### 员工端接口（需要员工登录）⭐

| 路径 | 说明 |
|------|------|
| POST /staff/login | 员工登录 |
| POST /staff/register | 员工注册 |
| GET /staff/getInfo | 获取员工信息 |
| PUT /staff/updateInfo | 更新个人信息 |
| PUT /staff/updatePwd | 修改密码 |
| GET /staff/order/pending | 待接订单列表 |
| GET /staff/order/ongoing | 进行中订单列表 |
| GET /staff/order/history | 历史订单列表 |
| PUT /staff/order/accept/{id} | 确认接单 |
| PUT /staff/order/reject/{id} | 拒绝订单 |
| PUT /staff/order/complete/{id} | 完成订单 |
| GET /staff/order/myAssess | 我的评价列表 |

---

## 五、核心流程

### 1. 用户预约流程

```
用户浏览服务 → 选择服务 → 填写预约信息 → 提交预约
    ↓
订单状态：待支付
    ↓
用户支付（扣除余额） → 订单状态：待确认
    ↓
管理员分配服务人员 / 服务人员接单
    ↓
订单状态：服务中
    ↓
服务完成 → 用户确认 → 订单状态：已完成
    ↓
用户评价服务
```

### 2. 员工接单流程

```
员工登录 → 查看待接订单列表
    ↓
选择订单 → 确认接单 / 拒绝订单
    ↓
接单成功 → 订单出现在"进行中"列表
    ↓
完成服务 → 订单转移到"历史订单"
    ↓
查看用户评价
```

### 3. 认证流程

```
管理端：JWT Token（若依框架标准）
用户端：JWT Token（复用若依框架）
员工端：JWT Token（独立认证，StaffLoginController）
```

---

## 六、配置文件说明

| 文件 | 位置 | 说明 |
|------|------|------|
| application.yml | admin/src/main/resources/ | 主配置（端口、Redis等） |
| application-druid.yml | admin/src/main/resources/ | 数据源配置 |
| logback.xml | admin/src/main/resources/ | 日志配置 |
| generator.yml | generator/src/main/resources/ | 代码生成配置 |
| vite.config.js | user-ui/ & staff-ui/ | 前端Vite配置 |
| .env.development | user-ui/ & staff-ui/ | 前端开发环境变量 |
