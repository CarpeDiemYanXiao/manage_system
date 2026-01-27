<template>
  <!-- 预约页面主容器 -->
    <div class="booking-page">
        <!-- 服务概览和预约表单 -->
        <div class="booking-container">
            <!-- 服务信息概览部分 -->
            <div class="serve-overview">
                <!-- 服务图片 -->
                <div class="serve-image">
                    <img :src="serve.image" alt="">
                </div>
                <!-- 服务详细信息 -->
                <div class="serve-info">
                    <h2>{{ serve.name }}</h2>
                    <!-- 服务标签展示 -->
                    <div class="serve-tags">
                        <el-tag v-for="tag in serve.tags" :key="tag" size="small" type="info">
                            {{ tag }}
                        </el-tag>
                    </div>
                    <!-- 服务价格 -->
                    <div class="serve-price">
                        <span class="current-price">¥{{ serve.price }}</span>
                    </div>
                    <!-- 服务描述 -->
                    <p class="serve-desc">{{ serve.description }}</p>
                </div>
            </div>

            <!-- 预约表单 -->
            <div class="booking-form">
                <h3>填写预约信息</h3>

                <el-form ref="reservationRef" :model="form" :rules="rules" label-width="110px" label-position="top">
                    <el-form-item label="预约服务时间" prop="time">
                        <el-date-picker clearable style="width: 100%;"
                                        v-model="form.time"
                                        type="datetime"
                                        value-format="YYYY-MM-DD HH:mm:ss"
                                        placeholder="请选择预约服务时间">
                        </el-date-picker>
                    </el-form-item>
                    <el-form-item label="预约服务地址" prop="address">
                        <el-input v-model="form.address" type="textarea" placeholder="请输入内容"
                                  style="margin-top: 10px"/>
                    </el-form-item>
                    <el-form-item label="联系人" prop="contacts">
                        <el-input v-model="form.contacts" placeholder="请输入联系人"/>
                    </el-form-item>
                    <el-form-item label="联系电话" prop="phone">
                        <el-input v-model="form.phone" placeholder="请输入联系电话"/>
                    </el-form-item>
                    <el-form-item label="特别要求" prop="special">
                        <el-input v-model="form.special" :rows="3" type="textarea"
                                  placeholder="请填写您的特殊要求(选填)"/>
                    </el-form-item>

                    <!-- 表单操作按钮 -->
                    <el-form-item>
                        <el-button type="primary" size="large" @click="submitForm" :loading="loading">
                            提交预约
                        </el-button>
                        <el-button size="large" @click="goBack">返回</el-button>
                    </el-form-item>

                </el-form>

            </div>

        </div>
    </div>
</template>

<script setup>
import {useRoute, useRouter} from "vue-router";
import {getServe} from "@/api/housekeeping/serve.js";
import {addReservation} from "@/api/housekeeping/reservation.js";

// 获取路由实例和当前路由
const router = useRouter()
const route = useRoute()

//获取组件实例
const {proxy} = getCurrentInstance()

//加载状态
const loading = ref(false)

//表单数据
const form = ref({})

//表单验证
const rules = ref({
    serveId: [{required: true, message: "服务ID不能为空", trigger: "blur"}],
    time: [{required: true, message: "预约服务时间不能为空", trigger: "blur"}],
    address: [{required: true, message: "预约服务地址不能为空", trigger: "blur"}],
    contacts: [{required: true, message: "联系人不能为空", trigger: "blur"}],
    phone: [{required: true, message: "联系电话不能为空", trigger: "blur"}]
})

//返回上一页
const goBack = () => {
    router.go(-1)
}

// 表单重置
const reset = () => {
    form.value = {
        reservationId: null,
        serveId: route.params.id,
        time: null,
        address: null,
        contacts: null,
        phone: null,
        special: null,
        status: null,
        staffId: null,
        userId: null,
        createTime: null
    }
    proxy.resetForm("reservationRef")
}

//获取基础API URL
const baseUrl = import.meta.env.VITE_APP_BASE_API

//服务数据
const serve = ref({})

//提交表单
const submitForm = () => {
    loading.value = true
    proxy.$refs["reservationRef"].validate(valid => {
        if (valid) {
            addReservation(form.value).then(response => {
                proxy.$modal.msgSuccess("预约成功!")
                loading.value = false
                router.push('/index/myBooking')
            })
        }
    })
}

// 组件挂载时执行
onMounted(() => {
    reset()
    const serveId = route.params.id
    //根据服务ID查询服务详情
    getServe(serveId).then(res => {
        serve.value = res.data
        serve.value.image = baseUrl + serve.value.image
        console.log(serve.value.image)
    })
})
</script>

<style scoped>
/* 预约页面主样式 */
.booking-page {
    max-width: 1200px; /* 最大宽度限制 */
    margin: 0 auto; /* 水平居中 */
    padding: 20px; /* 内边距 */
}

/* 预约内容容器布局 */
.booking-container {
    margin-top: 20px; /* 上边距 */
    display: flex; /* 弹性布局 */
    gap: 30px; /* 子元素间距 */
}

/* 服务概览区域样式 */
.serve-overview {
    width: 350px; /* 固定宽度 */
    background-color: #fff; /* 白色背景 */
    border-radius: 8px; /* 圆角 */
    padding: 20px; /* 内边距 */
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1); /* 阴影效果 */
    position: sticky; /* 粘性定位 */
    top: 20px; /* 距离顶部距离 */
    height: fit-content; /* 高度自适应内容 */
}

/* 服务图片容器 */
.serve-image {
    width: 100%; /* 宽度100% */
    height: 200px; /* 固定高度 */
    border-radius: 4px; /* 圆角 */
    overflow: hidden; /* 溢出隐藏 */
    margin-bottom: 15px; /* 下边距 */
}

/* 服务图片样式 */
.serve-image img {
    width: 100%; /* 宽度100% */
    height: 100%; /* 高度100% */
    object-fit: cover; /* 图片填充方式 */
}

/* 服务信息标题 */
.serve-info h2 {
    font-size: 20px; /* 字体大小 */
    margin-bottom: 10px; /* 下边距 */
    color: #333; /* 字体颜色 */
}

/* 服务标签容器 */
.serve-tags {
    display: flex; /* 弹性布局 */
    flex-wrap: wrap; /* 允许换行 */
    gap: 2px; /* 子元素间距 */
    margin-bottom: 15px; /* 下边距 */
}

/* 服务价格容器 */
.serve-price {
    margin-bottom: 15px; /* 下边距 */
}

/* 当前价格样式 */
.current-price {
    font-size: 24px; /* 字体大小 */
    font-weight: bold; /* 加粗 */
    color: #ff4d4f; /* 红色 */
}

/* 服务描述样式 */
.serve-desc {
    font-size: 14px; /* 字体大小 */
    color: #666; /* 字体颜色 */
    line-height: 1.6; /* 行高 */
}

/* 预约表单区域 */
.booking-form {
    flex: 1; /* 弹性扩展 */
    background-color: #fff; /* 白色背景 */
    border-radius: 8px; /* 圆角 */
    padding: 30px; /* 内边距 */
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1); /* 阴影效果 */
}

/* 表单标题 */
.booking-form h3 {
    font-size: 18px; /* 字体大小 */
    margin-bottom: 25px; /* 下边距 */
    color: #333; /* 字体颜色 */
    padding-bottom: 10px; /* 下内边距 */
    border-bottom: 1px solid #eee; /* 底部边框 */
}

/* 汇总项样式 */
.summary-item {
    display: flex; /* 弹性布局 */
    justify-content: space-between; /* 两端对齐 */
    margin-bottom: 15px; /* 下边距 */
    font-size: 16px; /* 字体大小 */
}

/* 总计项特殊样式 */
.summary-item.total {
    margin-top: 20px; /* 上边距 */
    padding-top: 15px; /* 上内边距 */
    border-top: 1px solid #eee; /* 顶部边框 */
    font-weight: bold; /* 加粗 */
    font-size: 18px; /* 字体大小 */
}

/* 汇总项标签样式 */
.summary-item .label {
    color: #666; /* 字体颜色 */
}

/* 汇总项值样式 */
.summary-item .value {
    color: #ff4d4f; /* 红色 */
}

/* 响应式设计 - 小于992px时的样式 */
@media (max-width: 992px) {
    .booking-container {
        flex-direction: column; /* 垂直布局 */
    }

    .serve-overview {
        width: 100%; /* 宽度100% */
        position: static; /* 取消粘性定位 */
    }
}
</style>
