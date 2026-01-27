<template>
    <div class="serveList-page">
        <!-- 服务分类和筛选区域 -->
        <div class="filter-section">
            <!-- 服务分类标签 -->
            <div class="category-filter">
                <div class="category-title">服务分类</div>
                <div class="category-tags">
                    <el-tag v-for="category in serve_type" :key="category.value"
                            :type="activeCategory === category.value ? 'primary' : 'info'"
                            size="large"
                            @click="changeCategory(category.value)"
                    >
                        {{ category.value }}
                    </el-tag>
                </div>
            </div>

            <!-- 搜索框 -->
            <div class="search-filter">
                <el-input
                  v-model="queryParams.name"
                  placeholder="搜索服务名称或关键词"
                  clearable
                  @keyup.enter="handleQuery"
                >
                    <template #append>
                        <el-button :icon="Search" @click="handleQuery"/>
                    </template>
                </el-input>
            </div>
        </div>

        <!-- 服务列表展示区域 -->
        <div class="service-list-section">
            <div class="service-list-header">
                <!-- 显示当前分类或者全部服务 -->
                <h2 v-if="activeCategory">
                    {{ serve_type.find(c => c.value === activeCategory)?.value }}
                </h2>
                <h2 v-else>全部服务</h2>
                <!-- 显示服务总数 -->
                <div class="total-count">共 {{ total }} 个服务</div>
            </div>

            <!-- 服务列表 -->
            <div v-if="serveList.length > 0" class="service-list">
                <!-- 遍历服务列表 -->
                <div v-for="serve in serveList" :key="serve.serveId" class="service-item">
                    <!-- 服务图片 -->
                    <div class="service-image">
                        <img :src="serve.image" alt="">
                    </div>
                    <!-- 服务信息 -->
                    <div class="service-info">
                        <h3 class="service-name">{{ serve.name }}</h3>
                        <p class="service-desc">{{ serve.description }}</p>
                        <!-- 服务标签 -->
                        <div class="service-tag">
                            <el-tag v-for="tag in serve.tags" :key="tag" type="info" size="small" effect="plain"
                            >
                                {{ tag }}
                            </el-tag>
                        </div>
                    </div>
                    <!-- 服务操作区域 (价格和预约按钮) -->
                    <div class="service-action">
                        <div class="service-price">
                            <span class="current-price">¥{{ serve.price }}</span>
                        </div>
                        <el-button type="primary" size="large" round @click="bookServe(serve.serveId)">
                            立即预约
                        </el-button>
                    </div>
                </div>
            </div>

            <!-- 无数据时显示的空状态 -->
            <div v-else class="empty-result">
                <el-empty description="没有找到符合条件的服务">
                    <el-button type="primary" @click="">重置筛选条件</el-button>
                </el-empty>
            </div>

            <!-- 分页组件 -->
            <div class="pagination">
                <pagination
                  v-show="total>0"
                  :total="total"
                  v-model:page="queryParams.pageNum"
                  v-model:limit="queryParams.pageSize"
                  @pagination="getList"
                />
            </div>

        </div>
    </div>
</template>

<script setup>

import {listServe} from "@/api/housekeeping/serve.js";
import {Search} from "@element-plus/icons-vue";
import {useRouter} from "vue-router";

const {proxy} = getCurrentInstance()
const {serve_type} = proxy.useDict('serve_type')

//获取基础API URL
const baseUrl = import.meta.env.VITE_APP_BASE_API

//初始化路由
const router = useRouter()

//查询参数
const queryParams = ref({
    pageNum: 1,
    pageSize: 10,
    name: null,
    category: null,
})

//立即预约按钮
const bookServe = (serveId) => {
    router.push(`/booking/${serveId}`)
}

//当前选中的分类
const activeCategory = ref('')

//切换分类
const changeCategory = (category) => {
    //如果点击的是已选中的分类, 则取消选中
    activeCategory.value = activeCategory.value === category ? '' : category
    //更新查询参数
    if (activeCategory.value === '') {
        queryParams.value.category = null
    } else {
        queryParams.value.category = category
    }
    //重新获取列表数据
    getList()
}

/** 搜索按钮操作 */
const handleQuery = () => {
    queryParams.value.pageNum = 1
    getList()
}

//服务列表数据
const serveList = ref([])
//服务列表数据的总数
const total = ref(0)

//获取数据
const getList = () => {
    listServe(queryParams.value).then(res => {
        serveList.value = res.rows
        total.value = res.total
        serveList.value.forEach(item => {
            item.image = baseUrl + item.image
        })
    })
}

//组件加载时调用方法
getList()
</script>

<style scoped>
/* 页面容器样式 */
.serveList-page {
    max-width: 1200px; /* 最大宽度限制 */
    margin: 0 auto; /* 水平居中 */
    padding: 20px; /* 内边距 */
}

/* 筛选区域样式 */
.filter-section {
    background-color: #fff; /* 白色背景 */
    border-radius: 8px; /* 圆角 */
    padding: 20px; /* 内边距 */
    margin-bottom: 20px; /* 底部外边距 */
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1); /* 阴影效果 */
}

/* 分类筛选区域样式 */
.category-filter {
    margin-bottom: 20px; /* 底部外边距 */
}

/* 分类标题样式 */
.category-title {
    font-size: 16px; /* 字体大小 */
    color: #666; /* 字体颜色 */
    margin-bottom: 10px; /* 底部外边距 */
}

/* 分类标签容器样式 */
.category-tags {
    display: flex; /* 弹性布局 */
    flex-wrap: wrap; /* 允许换行 */
    gap: 10px; /* 标签间距 */
}

/* 分类标签样式 */
.category-tags .el-tag {
    cursor: pointer; /* 鼠标指针样式 */
    padding: 0 20px; /* 内边距 */
}

/* 搜索区域样式 */
.search-filter {
    margin-bottom: 20px; /* 底部外边距 */
}

/* 服务列表区域样式 */
.service-list-section {
    background-color: #fff; /* 白色背景 */
    border-radius: 8px; /* 圆角 */
    padding: 20px; /* 内边距 */
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1); /* 阴影效果 */
}

/* 服务列表头部样式 */
.service-list-header {
    display: flex; /* 弹性布局 */
    justify-content: space-between; /* 两端对齐 */
    align-items: center; /* 垂直居中 */
    margin-bottom: 20px; /* 底部外边距 */
    padding-bottom: 10px; /* 底部内边距 */
    border-bottom: 1px solid #eee; /* 底部边框 */
}

/* 服务列表标题样式 */
.service-list-header h2 {
    font-size: 20px; /* 字体大小 */
    color: #333; /* 字体颜色 */
}

/* 总数显示样式 */
.total-count {
    font-size: 14px; /* 字体大小 */
    color: #999; /* 字体颜色 */
}

/* 服务列表容器样式 */
.service-list {
    display: grid; /* 网格布局 */
    grid-template-columns: 1fr; /* 单列布局 */
    gap: 20px; /* 项目间距 */
}

/* 单个服务项样式 */
.service-item {
    display: flex; /* 弹性布局 */
    padding: 20px; /* 内边距 */
    border-radius: 8px; /* 圆角 */
    border: 1px solid #eee; /* 边框 */
    transition: all 0.3s ease; /* 过渡效果 */
}

/* 服务项悬停效果 */
.service-item:hover {
    transform: translateY(-3px); /* 上移效果 */
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1); /* 阴影效果 */
}

/* 服务图片区域样式 */
.service-image {
    position: relative; /* 相对定位 */
    width: 200px; /* 固定宽度 */
    height: 150px; /* 固定高度 */
    margin-right: 20px; /* 右侧外边距 */
    flex-shrink: 0; /* 禁止缩小 */
    border-radius: 4px; /* 圆角 */
    overflow: hidden; /* 溢出隐藏 */
}

/* 服务图片样式 */
.service-image img {
    width: 100%; /* 宽度100% */
    height: 100%; /* 高度100% */
    object-fit: cover; /* 图片填充方式 */
}

/* 服务信息区域样式 */
.service-info {
    flex: 1; /* 占据剩余空间 */
    min-width: 0; /* 最小宽度为0，防止溢出 */
}

/* 服务名称样式 */
.service-name {
    font-size: 18px; /* 字体大小 */
    margin-bottom: 10px; /* 底部外边距 */
    color: #333; /* 字体颜色 */
    white-space: nowrap; /* 不换行 */
    overflow: hidden; /* 溢出隐藏 */
    text-overflow: ellipsis; /* 溢出显示省略号 */
}

/* 服务描述样式 */
.service-desc {
    font-size: 14px; /* 字体大小 */
    color: #666; /* 字体颜色 */
    margin-bottom: 10px; /* 底部外边距 */
    display: -webkit-box; /* 兼容性盒子模型 */
    -webkit-line-clamp: 2; /* 限制显示行数 */
    -webkit-box-orient: vertical; /* 垂直方向 */
    overflow: hidden; /* 溢出隐藏 */
}

/* 服务标签容器样式 */
.service-tag {
    display: flex; /* 弹性布局 */
    flex-wrap: wrap; /* 允许换行 */
    gap: 8px; /* 标签间距 */
    margin-bottom: 10px; /* 底部外边距 */
}

/* 服务操作区域样式 */
.service-action {
    width: 180px; /* 固定宽度 */
    display: flex; /* 弹性布局 */
    flex-direction: column; /* 垂直排列 */
    align-items: flex-end; /* 右对齐 */
    justify-content: space-between; /* 两端对齐 */
    flex-shrink: 0; /* 禁止缩小 */
}

/* 服务价格样式 */
.service-price {
    text-align: right; /* 文本右对齐 */
}

/* 当前价格样式 */
.current-price {
    font-size: 20px; /* 字体大小 */
    font-weight: bold; /* 加粗 */
    color: #ff4d4f; /* 红色 */
}

/* 空状态样式 */
.empty-result {
    padding: 50px 0; /* 上下内边距 */
    text-align: center; /* 文本居中 */
}

/* 分页样式 */
.pagination {
    margin-top: 30px; /* 顶部外边距 */
    display: flex; /* 弹性布局 */
    justify-content: center; /* 水平居中 */
}

/* 响应式设计 - 小于992px时的样式 */
@media (max-width: 992px) {
    /* 服务项改为垂直布局 */
    .service-item {
        flex-direction: column; /* 垂直排列 */
    }

    /* 图片全宽显示 */
    .service-image {
        width: 100%; /* 全宽 */
        height: 200px; /* 固定高度 */
        margin-right: 0; /* 取消右侧外边距 */
        margin-bottom: 15px; /* 底部外边距 */
    }

    /* 操作区域改为水平布局 */
    .service-action {
        width: 100%; /* 全宽 */
        flex-direction: row; /* 水平排列 */
        align-items: center; /* 垂直居中 */
        justify-content: space-between; /* 两端对齐 */
        margin-top: 15px; /* 顶部外边距 */
    }
}
</style>
