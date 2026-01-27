# 家政服务管理系统

## 项目简介

本系统是一个完整的家政服务管理平台，包含三个端：

| 端 | 说明 | 目录 |
|----|------|------|
| **管理端** | 后台管理系统 | admin（后端） |
| **用户端** | C端用户使用 | user-ui |
| **家政人员端** | 服务人员使用 | staff-ui |

## 技术栈

- **后端**: Spring Boot 3.3.5 + Java 17 + MyBatis + MySQL 8.0 + Redis
- **前端**: Vue 3 + Vite + Element Plus + Pinia

## 环境要求

| 软件 | 版本要求 | 说明 |
|------|---------|------|
| JDK | 17+ | 后端运行环境 |
| Maven | 3.8+ | 后端构建工具 |
| Node.js | 18+ | 前端运行环境 |
| MySQL | 8.0+ | 数据库 |
| Redis | 6.0+ | 缓存服务 |

## 快速开始

### 1. 数据库配置

```sql
-- 创建数据库
CREATE DATABASE `housekeeping` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
```

导入SQL脚本（按顺序执行）：
```
sql/housekeeping.sql           -- 主数据库脚本
sql/update_v1.1.0.sql          -- 功能更新脚本
```

修改数据库连接配置 `admin/src/main/resources/application-druid.yml`：
```yaml
spring:
  datasource:
    druid:
      master:
        url: jdbc:mysql://localhost:3306/housekeeping?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8
        username: root      # 改为你的用户名
        password: root      # 改为你的密码
```

### 2. Redis配置

确保 Redis 服务已启动（默认端口6379）

如需修改，编辑 `admin/src/main/resources/application.yml`：
```yaml
spring:
  data:
    redis:
      host: localhost
      port: 6379
      password:           # 如有密码请填写
```

### 3. 启动后端

**方式一：命令行**
```bash
cd d:\atask\管理系统\housekeeping

# 编译
mvn clean package -DskipTests

# 运行
java -jar admin/target/admin.jar
```

**方式二：IDEA**
1. 用 IDEA 打开项目根目录
2. 等待 Maven 下载依赖
3. 运行 `admin/src/main/java/com/housekeeping/HousekeepingApplication.java`

后端启动成功后访问：`http://localhost:8080`

### 4. 启动用户端前端

```bash
cd user-ui

# 安装依赖（首次运行）
npm install --registry=https://registry.npmmirror.com

# 启动
npm run dev
```

访问地址：`http://localhost`

### 5. 启动管理后台前端

```bash
cd admin-ui

# 安装依赖（首次运行）
npm install --registry=https://registry.npmmirror.com

# 启动
npm run dev
```

访问地址：`http://localhost:90`（默认管理员账号：admin / admin123）

### 6. 启动家政人员端前端

首先修改端口避免冲突，编辑 `staff-ui/vite.config.js`：
```javascript
server: {
  port: 81,  // 改为81
  ...
}
```

然后启动：
```bash
cd staff-ui

# 安装依赖（首次运行）
npm install --registry=https://registry.npmmirror.com

# 启动
npm run dev
```

访问地址：`http://localhost:81`

## 端口汇总

| 服务 | 端口 | 地址 |
|------|------|------|
| 后端API | 8080 | http://localhost:8080 |
| 管理后台 | 90 | http://localhost:90 |
| 用户端 | 80 | http://localhost |
| 家政人员端 | 81 | http://localhost:81 |
| Druid监控 | 8080 | http://localhost:8080/druid |

## 默认账号

| 端 | 账号 | 密码 |
|----|------|------|
| 管理后台 | admin | admin123 |
| Druid监控 | housekeeping | 123456 |
| 用户端 | - | 自行注册 |
| 家政人员端 | - | 自行注册 |

## 项目结构

```
housekeeping/
├── admin/          # 后端启动模块
├── admin-ui/       # 管理后台前端
├── common/         # 公共模块
├── framework/      # 框架核心
├── generator/      # 代码生成器
├── housekeeping/   # 家政业务模块
├── system/         # 系统模块
├── staff-ui/       # 家政人员端前端
├── user-ui/        # 用户端前端
├── sql/            # 数据库脚本
└── pom.xml         # Maven父工程配置
```

## 功能模块

### 管理端
- 用户管理（查看/封禁/解封）
- 服务项目管理
- 服务人员管理
- 订单管理
- 取消记录管理
- 评价管理
- 轮播图管理

### 用户端
- 注册/登录
- 首页（轮播图+评价展示）
- 服务浏览/预约
- 我的预约（支付/取消/确认/评价）
- 账户充值

### 家政人员端
- 注册/登录
- 工作台
- 待接订单（接单/拒单）
- 进行中订单
- 历史订单
- 我的评价
- 个人中心

## 常见问题

### Maven依赖下载慢
配置阿里云镜像，编辑 `~/.m2/settings.xml`：
```xml
<mirrors>
  <mirror>
    <id>aliyunmaven</id>
    <mirrorOf>*</mirrorOf>
    <url>https://maven.aliyun.com/repository/public</url>
  </mirror>
</mirrors>
```

### npm安装依赖慢
```bash
npm config set registry https://registry.npmmirror.com
```

### 端口被占用
- 后端端口：修改 `admin/src/main/resources/application.yml` 中的 `server.port`
- 前端端口：修改对应项目的 `vite.config.js` 中的 `server.port`

### 文件上传目录
确保创建目录：
```bash
# Windows
mkdir D:\housekeeping\uploadPath

# 或修改 application.yml 中的 housekeeping.profile 配置
```
