<template>
  <!-- 首页容器 -->
    <div class="home-container">
        <!-- 主体内容区域 -->
        <el-main class="main-content">
            <!-- 轮播图区域 -->
            <div class="banner-section">
                <el-carousel height="500px" :interval="5000" arrow="always">
                    <el-carousel-item v-for="banner in bannerList" :key="banner.bannerId">
                        <!-- 轮播图片 -->
                        <img :src="banner.image" alt="" class="banner-image">
                        <!-- 图片上的文字覆盖层 -->
                        <div class="banner-overlay">
                            <h2>{{ banner.title }}</h2>
                            <p>{{ banner.description }}</p>
                        </div>
                    </el-carousel-item>
                </el-carousel>
            </div>

            <!-- 宣传区域 -->
            <div class="why-choose-us">
                <h2 class="section-title">为什么选择我们</h2>
                <p class="section-subtitle">专业家政服务平台的优势</p>

                <!-- 网格布局 -->
                <div class="advantages">
                    <div v-for="ad in advantages" :key="ad.id" class="advantage-item">
                        <!-- 优势图标 -->
                        <div class="advantage-icon">
                            <el-icon :size="48">
                                <component :is="ad.icon"/>
                            </el-icon>
                            <h3>{{ ad.title }}</h3>
                            <p>{{ ad.description }}</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 宣传区域 -->
            <div class="customer-assessList">
                <h2 class="section-title">用户评价</h2>
                <p class="section-subtitle">真实用户的使用体验</p>

                <!-- 评价轮播 -->
                <el-carousel height="200px" :interval="6000" indicator-position="none">
                    <el-carousel-item v-for="assess in assessList" :key="assess.assessId">
                        <!-- 评价卡片 -->
                        <div class="assess-card">
                            <!-- 评价者信息 -->
                            <div class="reviewer-info">
                                <!-- 用户头像 -->
                                <el-avatar :size="60" :src="assess.avatar"/>
                                <div>
                                    <!-- 用户名 -->
                                    <h4>{{ assess.userName }}</h4>
                                    <!-- 评价日期 -->
                                    <p class="assess-date">{{ assess.createTime }}</p>
                                </div>
                            </div>
                            <!-- 评价内容 -->
                            <div class="assess-content">
                                <!-- 评分 -->
                                <el-rate v-model="assess.score" disabled/>
                                <p>{{ assess.content }}</p>
                            </div>
                        </div>

                    </el-carousel-item>
                </el-carousel>

            </div>
        </el-main>
    </div>
</template>

<script setup>
import {listBanner} from "@/api/housekeeping/banner.js";
import {Setting, Star, Trophy, User, List} from "@element-plus/icons-vue";
import {listAssess} from "@/api/housekeeping/assess.js";

//获取基础API URL
const baseUrl = import.meta.env.VITE_APP_BASE_API

//查询参数
const queryParams = ref({
    pageNum: 1,
    pageSize: 10,
    toIndex: '推送'
})

// 优势数据
const advantages = ref([
    {id: 1, title: '专业服务', description: '所有服务人员经过严格筛选和专业培训，持证上岗', icon: Star},
    {id: 2, title: '安全保障', description: '实名认证、背景调查、保险保障，服务更放心', icon: User},
    {id: 3, title: '明码标价', description: '服务价格透明，无隐形消费，消费更安心', icon: Setting},
    {id: 4, title: '严格标准', description: '标准化服务流程，服务质量有保障', icon: List},
    {id: 5, title: '售后无忧', description: '服务不满意可申请售后，平台全程保障', icon: Trophy}
])

//轮播图列表数据
const bannerList = ref([])

//评价列表数据
const assessList = ref([])

//查询数据
const getList = () => {
    //查询轮播图列表
    listBanner(queryParams.value).then(res => {
        bannerList.value = res.rows
        bannerList.value.forEach(item => {
            item.image = baseUrl + item.image
        })
    })

    //查询评价列表
    listAssess(queryParams.value).then(res => {
        assessList.value = res.rows
        assessList.value.forEach(item => {
            item.avatar = baseUrl + item.avatar
        })
    })
}

//组件加载时调用方法
getList()
</script>

<style scoped>
/* 首页容器样式 */
.home-container {
    min-height: 100vh; /* 最小高度为视口高度 */
    display: flex;
    flex-direction: column; /* 垂直布局 */
}

/* 主体内容区域样式 */
.main-content {
    flex: 1; /* 占据剩余空间 */
    padding: 0; /* 无内边距 */
    max-width: 1200px; /* 最大宽度 */
    margin: 0 auto; /* 水平居中 */
    width: 100%; /* 宽度100% */
}

/* 轮播图区域样式 */
.banner-section {
    top: 10px; /* 距离顶部10px */
    position: relative; /* 相对定位 */
}

/* 轮播图片样式 */
.banner-image {
    width: 100%; /* 宽度100% */
    height: 100%; /* 高度100% */
    object-fit: cover; /* 图片填充方式 */
}

/* 轮播图文字覆盖层样式 */
.banner-overlay {
    position: absolute; /* 绝对定位 */
    bottom: 0; /* 底部对齐 */
    left: 0; /* 左侧对齐 */
    right: 0; /* 右侧对齐 */
    /* 渐变背景，从半透明黑色到完全透明 */
    background: linear-gradient(to top, rgba(0, 0, 0, 0.7), transparent);
    color: white; /* 文字颜色 */
    padding: 40px; /* 内边距 */
    text-align: left; /* 文字左对齐 */
}

/* 轮播图标题样式 */
.banner-overlay h2 {
    font-size: 32px; /* 字体大小 */
    margin-bottom: 10px; /* 下边距 */
}

/* 轮播图描述文字样式 */
.banner-overlay p {
    font-size: 18px; /* 字体大小 */
    margin-bottom: 20px; /* 下边距 */
}

/* 区块标题样式 */
.section-title {
    text-align: center; /* 居中 */
    font-size: 28px; /* 字体大小 */
    color: #333; /* 颜色 */
    margin-bottom: 10px; /* 下边距 */
}

/* 区块副标题样式 */
.section-subtitle {
    text-align: center; /* 居中 */
    color: #999; /* 颜色 */
    margin-bottom: 30px; /* 下边距 */
}

/* "为什么选择我们"区域样式 */
.why-choose-us {
    padding: 40px 20px; /* 内边距 */
}

/* 优势项网格布局 */
.advantages {
    display: grid; /* 网格布局 */
    grid-template-columns: repeat(5, 1fr); /* 5列等宽 */
    gap: 20px; /* 网格间隙 */
    margin-top: 30px; /* 上边距 */
}

/* 单个优势项样式 */
.advantage-item {
    background-color: #fff; /* 白色背景 */
    border-radius: 8px; /* 圆角 */
    padding: 20px; /* 内边距 */
    text-align: center; /* 文字居中 */
    /* 阴影效果 */
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

/* 优势图标样式 */
.advantage-icon {
    color: #409EFF; /* Element主题蓝色 */
    margin-bottom: 15px; /* 下边距 */
}

/* 优势项标题样式 */
.advantage-item h3 {
    font-size: 18px; /* 字体大小 */
    margin-bottom: 10px; /* 下边距 */
}

/* 优势项描述样式 */
.advantage-item p {
    font-size: 14px; /* 字体大小 */
    color: #666; /* 颜色 */
}

/* 用户评价区域样式 */
.customer-assessList {
    padding: 40px 20px; /* 内边距 */
}

/* 评价卡片样式 */
.assess-card {
    display: flex; /* 弹性布局 */
    background-color: #fff; /* 白色背景 */
    border-radius: 8px; /* 圆角 */
    padding: 20px; /* 内边距 */
    height: 240px; /* 固定高度 */
    /* 阴影效果 */
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

/* 评价者信息区域样式 */
.reviewer-info {
    width: 150px; /* 固定宽度 */
    text-align: center; /* 文字居中 */
    padding-right: 20px; /* 右内边距 */
    border-right: 1px solid #eee; /* 右边框 */
}

/* 评价者姓名样式 */
.reviewer-info h4 {
    margin-top: 10px; /* 上边距 */
    margin-bottom: 5px; /* 下边距 */
}

/* 评价日期样式 */
.assess-date {
    font-size: 12px; /* 字体大小 */
    color: #999; /* 颜色 */
}

/* 评价内容区域样式 */
.assess-content {
    flex: 1; /* 占据剩余空间 */
    padding-left: 20px; /* 左内边距 */
    overflow-y: auto; /* 垂直方向溢出时滚动 */
}

/* 评价内容文字样式 */
.assess-content p {
    margin: 15px 0; /* 上下边距 */
    line-height: 1.6; /* 行高 */
}

/* 响应式设计 - 中等屏幕(992px以下) */
@media (max-width: 992px) {
    .advantages {
        grid-template-columns: repeat(2, 1fr); /* 改为2列 */
    }
}

/* 响应式设计 - 小屏幕(768px以下) */
@media (max-width: 768px) {
    .advantages {
        grid-template-columns: 1fr; /* 改为1列 */
    }

    /* 评价卡片改为垂直布局 */
    .assess-card {
        flex-direction: column; /* 垂直方向 */
        height: auto; /* 高度自动 */
    }

    /* 评价者信息区域调整 */
    .reviewer-info {
        width: 100%; /* 宽度100% */
        padding-right: 0; /* 无右内边距 */
        border-right: none; /* 无右边框 */
        border-bottom: 1px solid #eee; /* 底部边框 */
        padding-bottom: 15px; /* 底部内边距 */
        margin-bottom: 15px; /* 底部外边距 */
    }

    /* 评价内容区域调整 */
    .assess-content {
        padding-left: 0; /* 无左内边距 */
    }
}
</style>
