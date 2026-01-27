<template>
  <!-- 页面容器 -->
    <div class="my-reservationList-page">
        <!-- 页面标题和筛选区域 -->
        <div class="page-header">
            <h2>我的预约</h2>
            <div class="filter-controls">
                <el-select v-model="queryParams.status" placeholder="请选择预约状态"
                           clearable @change="handleQuery">
                    <el-option
                            v-for="dict in reservation_status"
                            :key="dict.value"
                            :label="dict.label"
                            :value="dict.value"
                    />
                </el-select>
                <el-date-picker
                        v-model="daterangeTime"
                        value-format="YYYY-MM-DD"
                        type="daterange"
                        style="width: 500px;"
                        range-separator="-"
                        start-placeholder="开始日期"
                        end-placeholder="结束日期"
                ></el-date-picker>
                <!-- 搜索和重置按钮 -->
                <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
                <el-button icon="Refresh" @click="resetQuery">重置</el-button>
            </div>
        </div>

        <!-- 预约列表主主体内容 -->
        <div class="reservation-list">
            <!-- 空状态提示 -->
            <el-empty v-if="reservationList.length === 0" description="暂无预约记录" :image-size="200"/>

            <!-- 有预约记录的时候显示 -->
            <div v-else class="reservation-items">
                <!-- 单个预约项循环 -->
                <div v-for="reservation in reservationList"
                     :key="reservation.reservationId"
                     class="reservation-item"
                >
                    <!-- 预约项头部信息 -->
                    <div class="reservation-header">
                        <div class="reservation-no">
                            <span>订单编号: {{ reservation.reservationId }}</span>
                            <!-- 状态标签 -->
                            <dict-tag :options="reservation_status" :value="reservation.status"/>
                        </div>
                        <!-- 预约时间 -->
                        <div class="reservation-date">
                            预约时间: {{ reservation.time }}
                        </div>
                    </div>

                    <!-- 预约主要内容 -->
                    <div class="reservation-content">
                        <!-- 服务信息 -->
                        <div class="service-info">
                            <!-- 服务图片 -->
                            <div class="service-image">
                                <img :src="reservation.image" alt="">
                            </div>
                            <!-- 服务详情 -->
                            <div class="service-details">
                                <h3 class="service-name">{{ reservation.serveName }}</h3>
                                <div class="service-meta">
                                    <div>
                                        <el-icon>
                                            <Collection/>
                                        </el-icon>
                                        <span>{{ reservation.category }}</span>
                                    </div>
                                </div>
                                <!-- 服务地址 -->
                                <div class="service-address">
                                    <el-icon>
                                        <Location/>
                                    </el-icon>
                                    <span>{{ reservation.address }}</span>
                                </div>
                            </div>
                        </div>

                        <!-- 操作区域 -->
                        <div class="reservation-actions">
                            <!-- 价格 -->
                            <div class="reservation-price">
                                <span class="amount">¥{{ reservation.price }}</span>
                            </div>

                            <!-- 操作按钮 -->
                            <div class="action-buttons">
                                <!-- 根据状态显示不同区域 -->
                                <el-button v-if="reservation.status === '待支付'"
                                           type="primary"
                                           size="small"
                                           @click="handlePay(reservation.reservationId)"
                                >
                                    立即支付
                                </el-button>
                                <el-button v-if="reservation.status === '待支付'"
                                           type="danger"
                                           size="small"
                                           plain
                                           @click="handleCancel(reservation.reservationId)"
                                >
                                    取消预约
                                </el-button>
                                <el-button v-if="reservation.status === '待确认'"
                                           type="success"
                                           size="small"
                                           @click="handleComplete(reservation)"
                                >
                                    确认完成
                                </el-button>
                                <el-button v-if="reservation.status === '已完成'"
                                           type="success"
                                           size="small"
                                           plain
                                           @click="handleRate(reservation.reservationId)"
                                >
                                    评价服务
                                </el-button>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 分页组件 -->
            <div class="pagination" v-if="reservationList.length > 0">
                <pagination
                        v-show="total>0"
                        :total="total"
                        v-model:page="queryParams.pageNum"
                        v-model:limit="queryParams.pageSize"
                        @pagination="getList"
                />
            </div>
        </div>

        <!-- 取消预约组件 -->
        <Cancel ref="cancel" @ok="getList"/>

        <!-- 评价组件 -->
        <Assess ref="assess"/>

    </div>
</template>

<script setup>
import {listReservation, payment, updateReservation} from "@/api/housekeeping/reservation.js";
import {Collection, Location} from "@element-plus/icons-vue";
import useUserStore from "@/store/modules/user.js";
import {ElMessage, ElMessageBox} from "element-plus";
import Cancel from "@/views/HomePage/components/cancel.vue";
import Assess from "@/views/HomePage/components/Assess.vue";
import {updateStaff} from "@/api/housekeeping/staff.js";

//获取基础API URL
const baseUrl = import.meta.env.VITE_APP_BASE_API

//获取当前登录用户的信息
const loginUser = useUserStore()

//获取组件实例和获取字典信息
const {proxy} = getCurrentInstance()
const {reservation_status} = proxy.useDict('reservation_status')

//日期范围查询数据
const daterangeTime = ref([])

//加载状态
const loading = ref(false)

//查询参数
const queryParams = ref({
    pageNum: 1,
    pageSize: 10,
    serveId: null,
    time: null,
    status: null,
    staffId: null,
    userId: loginUser.id,
    userName: null,
    serveName: null,
})

//立即支付
const handlePay = (reservationId) => {
    ElMessageBox.confirm(
        '确认进行支付吗?',
        '提示',
        {confirmButtonText: '确定', cancelButtonText: '取消', type: 'warning',}
    )
        .then(() => {
            payment(reservationId).then(res => {
                getList()
                ElMessage({type: 'success', message: '支付成功!',})
            })
        })
        .catch(() => {
            ElMessage({type: 'info', message: '取消支付',})
        })
}

//取消预约组件实例
const cancel = ref(null)

//取消预约
const handleCancel = (reservationId) => {
    cancel.value.handleOpen(reservationId)
}

//确认完成
const handleComplete = (reservation) => {
    const reservationId = reservation.reservationId
    const staffId = reservation.staffId
    ElMessageBox.confirm(
        '确认服务已经完成了吗?',
        '提示',
        {confirmButtonText: '确定', cancelButtonText: '取消', type: 'warning',}
    )
        .then(() => {
            const item = {
                reservationId: reservationId,
                status: '已完成'
            }
            updateReservation(item).then(res => {
                //将服务人员的状态改为空闲
                const it = {
                    staffId: staffId,
                    status: '空闲'
                }
                updateStaff(it).then(res => {
                    getList()
                    ElMessage({type: 'success', message: '服务已确认完成!',})
                })
            })
        })
        .catch(() => {
        })
}

//评价组件实例
const assess = ref(null)

//评价服务
const handleRate = (reservationId) => {
    assess.value.handleOpen(reservationId)
}

/** 搜索按钮操作 */
const handleQuery = () => {
    queryParams.value.pageNum = 1
    getList()
}

/** 重置按钮操作 */
const resetQuery = () => {
    daterangeTime.value = []
    queryParams.value = {
        pageNum: 1,
        pageSize: 10,
        serveId: null,
        time: null,
        status: null,
        staffId: null,
        userId: loginUser.id,
        userName: null,
        serveName: null,
    }
    handleQuery()
}

//预约列表数据
const reservationList = ref([])

//数据总数
const total = ref(0)

/** 查询预约列表 */
const getList = () => {
    loading.value = true
    queryParams.value.params = {}
    if (null != daterangeTime && '' != daterangeTime) {
        queryParams.value.params["beginTime"] = daterangeTime.value[0]
        queryParams.value.params["endTime"] = daterangeTime.value[1]
    }
    listReservation(queryParams.value).then(response => {
        reservationList.value = response.rows
        reservationList.value.forEach(item => {
            item.image = baseUrl + item.image
        })
        total.value = response.total
        loading.value = false
    })
}

//组件加载时调用
getList()
</script>

<style scoped>
/* 整个预约列表页面容器样式 */
.my-reservationList-page {
    max-width: 1200px; /* 最大宽度限制 */
    margin: 0 auto; /* 水平居中 */
    padding: 1px; /* 微小内边距 */
}

/* 页面头部样式 - 包含标题和筛选控件 */
.page-header {
    display: flex; /* 弹性布局 */
    justify-content: space-between; /* 两端对齐 */
    align-items: center; /* 垂直居中 */
    margin: 10px 0; /* 上下外边距 */
}

/* 页面标题样式 */
.page-header h2 {
    font-size: 24px; /* 字体大小 */
    color: #333; /* 字体颜色 */
}

/* 筛选控件容器样式 */
.filter-controls {
    display: flex; /* 弹性布局 */
    gap: 10px; /* 子元素间距 */
}

/* 预约列表容器样式 */
.reservation-list {
    margin-top: 20px; /* 上边距 */
}

/* 预约项网格容器 */
.reservation-items {
    display: grid; /* 网格布局 */
    grid-template-columns: 1fr; /* 单列布局 */
    gap: 15px; /* 网格间距 */
}

/* 单个预约项样式 */
.reservation-item {
    background-color: #fff; /* 白色背景 */
    border-radius: 8px; /* 圆角 */
    padding: 20px; /* 内边距 */
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.05); /* 阴影效果 */
    border-left: 4px solid #3145a6; /* 左侧边框 */
    transition: all 0.3s ease; /* 过渡动画 */
}

/* 预约项悬停效果 */
.reservation-item:hover {
    transform: translateY(-3px); /* 上移效果 */
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1); /* 阴影增强 */
}

/* 预约项头部样式 */
.reservation-header {
    display: flex; /* 弹性布局 */
    justify-content: space-between; /* 两端对齐 */
    align-items: center; /* 垂直居中 */
    margin-bottom: 15px; /* 下边距 */
    padding-bottom: 10px; /* 下内边距 */
    border-bottom: 1px solid #f5f5f5; /* 底部边框 */
}

/* 预约编号区域样式 */
.reservation-no {
    display: flex; /* 弹性布局 */
    align-items: center; /* 垂直居中 */
    gap: 10px; /* 子元素间距 */
}

/* 预约编号文本样式 */
.reservation-no span {
    font-size: 14px; /* 字体大小 */
    color: #666; /* 字体颜色 */
}

/* 预约日期样式 */
.reservation-date {
    font-size: 14px; /* 字体大小 */
    color: #999; /* 字体颜色 */
}

/* 预约内容区域样式 */
.reservation-content {
    display: flex; /* 弹性布局 */
    gap: 20px; /* 子元素间距 */
}

/* 服务信息区域样式 */
.service-info {
    flex: 1; /* 占据剩余空间 */
    display: flex; /* 弹性布局 */
    gap: 15px; /* 子元素间距 */
}

/* 服务图片容器样式 */
.service-image {
    width: 120px; /* 固定宽度 */
    height: 90px; /* 固定高度 */
    border-radius: 4px; /* 圆角 */
    overflow: hidden; /* 溢出隐藏 */
    flex-shrink: 0; /* 防止缩小 */
}

/* 服务图片样式 */
.service-image img {
    width: 100%; /* 100%宽度 */
    height: 100%; /* 100%高度 */
    object-fit: cover; /* 图片填充方式 */
}

/* 服务详情区域样式 */
.service-details {
    flex: 1; /* 占据剩余空间 */
    min-width: 0; /* 防止内容溢出 */
}

/* 服务名称样式 */
.service-name {
    font-size: 16px; /* 字体大小 */
    margin-bottom: 8px; /* 下边距 */
    color: #333; /* 字体颜色 */
    white-space: nowrap; /* 不换行 */
    overflow: hidden; /* 溢出隐藏 */
    text-overflow: ellipsis; /* 溢出显示省略号 */
}

/* 服务元信息区域样式 */
.service-meta {
    display: flex; /* 弹性布局 */
    gap: 15px; /* 子元素间距 */
    margin-bottom: 8px; /* 下边距 */
    font-size: 13px; /* 字体大小 */
    color: #666; /* 字体颜色 */
}

/* 服务元信息图标样式 */
.service-meta .el-icon {
    margin-right: 5px; /* 图标右边距 */
}

/* 服务地址样式 */
.service-address {
    font-size: 13px; /* 字体大小 */
    color: #666; /* 字体颜色 */
    display: flex; /* 弹性布局 */
    align-items: flex-start; /* 顶部对齐 */
}

/* 服务地址图标样式 */
.service-address .el-icon {
    margin-right: 5px; /* 图标右边距 */
    margin-top: 2px; /* 图标上边距 */
}

/* 预约操作区域样式 */
.reservation-actions {
    width: 220px; /* 固定宽度 */
    display: flex; /* 弹性布局 */
    flex-direction: column; /* 垂直排列 */
    justify-content: space-between; /* 两端对齐 */
    align-items: flex-end; /* 右对齐 */
    flex-shrink: 0; /* 防止缩小 */
}

/* 价格显示区域样式 */
.reservation-price {
    text-align: right; /* 文本右对齐 */
}

/* 价格金额样式 */
.reservation-price .amount {
    font-size: 18px; /* 字体大小 */
    font-weight: bold; /* 加粗 */
    color: #ff4d4f; /* 红色 */
}

/* 优惠券信息样式 */
.reservation-price .coupon {
    display: block; /* 块级元素 */
    font-size: 12px; /* 字体大小 */
    color: #999; /* 字体颜色 */
    margin-top: 2px; /* 上边距 */
}

/* 操作按钮组样式 */
.action-buttons {
    display: flex; /* 弹性布局 */
    gap: 8px; /* 按钮间距 */
}

/* 分页区域样式 */
.pagination {
    margin-top: 30px; /* 上边距 */
    display: flex; /* 弹性布局 */
    justify-content: center; /* 水平居中 */
}

/* 响应式设计 - 移动端适配 */
@media (max-width: 768px) {
    /* 页面头部调整为垂直布局 */
    .page-header {
        flex-direction: column; /* 垂直排列 */
        align-items: flex-start; /* 左对齐 */
        gap: 15px; /* 子元素间距 */
    }

    /* 筛选控件调整为换行布局 */
    .filter-controls {
        width: 100%; /* 100%宽度 */
        flex-wrap: wrap; /* 允许换行 */
    }

    /* 内容区域调整为垂直布局 */
    .reservation-content {
        flex-direction: column; /* 垂直排列 */
        gap: 15px; /* 子元素间距 */
    }

    /* 操作区域调整为水平布局 */
    .reservation-actions {
        width: 100%; /* 100%宽度 */
        flex-direction: row; /* 水平排列 */
        justify-content: space-between; /* 两端对齐 */
        align-items: center; /* 垂直居中 */
    }

    /* 服务信息调整为垂直布局 */
    .service-info {
        flex-direction: column; /* 垂直排列 */
    }

    /* 服务图片调整为全宽 */
    .service-image {
        width: 100%; /* 100%宽度 */
        height: 150px; /* 固定高度 */
    }
}
</style>
