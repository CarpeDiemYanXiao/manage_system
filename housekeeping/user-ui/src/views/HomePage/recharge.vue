<template>
  <!-- 充值页面主容器 -->
    <div class="recharge-page">
        <div class="container">
            <!-- 充值卡片 -->
            <div class="recharge-card">
                <!-- 标题 -->
                <h2 class="title">账户充值</h2>

                <!-- 当前余额展示区域 -->
                <div class="balance-section">
                    <div class="balance-label">当前余额</div>
                    <!-- 余额 -->
                    <div class="balance-amount">¥{{ balance }}</div>
                </div>

                <!-- 充值金额选择区域 -->
                <div>
                    <h3 class="section-title">选择充值金额</h3>
                    <div class="amount-options">
                        <!-- 循环渲染预设金额选项 -->
                        <div v-for="amount in amountOptions" :key="amount"
                             class="amount-option" :class="{ 'active': selectedAmount === amount }"
                             @click="selectAmount(amount)"
                        >
                            ¥{{ amount }}
                        </div>
                        <!-- 自定义金额输入框 -->
                        <div class="amount-option custom" :class="{ 'active': isCustomAmount }">
                            <el-input v-model="customAmount" placeholder="自定义金额" size="small"
                                      @focus="selectCustomAmount" @blur="validateCustomAmount"
                            >
                                <template #prepend>¥</template>
                            </el-input>
                        </div>
                    </div>
                </div>

                <!-- 充值按钮区域 -->
                <div class="action-section">
                    <el-button type="primary" size="small" :disabled="!canSubmit" @click="payment"
                    >
                        立即充值 ¥{{ payAmount }}
                    </el-button>
                </div>
            </div>
        </div>

        <!-- 充值结果弹窗 -->
        <vxe-modal :title="payResult.title" v-model="rechargeOpen" width="400px" show-maximize showFooter resize>
            <div class="result-dialog">
                <div class="result-icon" :class="payResult.status">
                    <!-- 根据支付结果显示不同图标 -->
                    <el-icon v-if="payResult.status === 'success'" color="#67C23A" :size="60">
                        <SuccessFilled/>
                    </el-icon>
                    <el-icon v-else color="#c7171c" :size="60">
                        <CircleCloseFilled/>
                    </el-icon>
                </div>
                <!-- 支付结果消息 -->
                <div class="result-message">{{ payResult.message }}</div>
                <!-- 支付详情 -->
                <div v-if="payResult.detail" class="result-detail">
                    {{ payResult.detail }}
                </div>
            </div>
        </vxe-modal>

    </div>
</template>

<script setup>
import useUserStore from "@/store/modules/user.js";
import {getUser, recharge} from "@/api/system/user.js";
import {ElLoading} from "element-plus";
import {CircleCloseFilled, SuccessFilled} from "@element-plus/icons-vue";

//获取当前登录用户的信息
const userStore = useUserStore()

//预设充值金额选项
const amountOptions = ref([50, 100, 200, 500, 1000])
//默认选中的金额
const selectedAmount = ref(100)
//是否使用自定义金额
const isCustomAmount = ref(false)
//自定义金额
const customAmount = ref()

//计算属性: 当前充值金额
const payAmount = computed(() => {
    return isCustomAmount.value ? parseFloat(customAmount.value) || 0 : selectedAmount.value
})

//计算属性: 是否可以提交 (充值金额必须大于0)
const canSubmit = computed(() => {
    return payAmount.value > 0
})

//支付结果信息
const payResult = ref({})
//充值结果弹窗
const rechargeOpen = ref(false)

//执行支付操作
const payment = () => {
    //调取API更新用户余额
    recharge(payAmount.value).then(res => {
        const loading = ElLoading.service({
            lock: true,
            text: '加载中',
            background: 'rgba(0, 0, 0, 0.7)',
        })
        //设置支付成功结果
        payResult.value = {
            status: 'success',
            title: '支付成功',
            message: '充值成功',
            detail: `充值金额: ¥${payAmount.value}`
        }
        //刷新用户余额
        getUserBalance()
        loading.close()
        //打开结果弹窗
        rechargeOpen.value = true
    })
}

//选择预设金额
const selectAmount = (amount) => {
    selectedAmount.value = amount
    isCustomAmount.value = false //取消自定义金额模式
    customAmount.value = null //清空自定义金额
}

//选择自定义金额 (输入框获取焦点时调用)
const selectCustomAmount = () => {
    isCustomAmount.value = true //启用自定义金额模式
    selectedAmount.value = 0 //取消预设金额选择
}

//验证自定义金额 (输入框失去焦点时调用)
const validateCustomAmount = () => {
    //如果最定义金额无效 (空或者小于等于0), 则回复默认选择
    if (customAmount.value === null || customAmount.value <= 0) {
        isCustomAmount.value = false
        customAmount.value = null
        selectedAmount.value = 100
    }
}

//用户余额
const balance = ref(null)
//获取当前用户余额
const getUserBalance = () => {
    getUser(userStore.id).then(res => {
        balance.value = res.data.balance
    })
}

//页面加载时调用方法
getUserBalance()
</script>

<style scoped>
/* 页面整体样式 - 充值页面容器 */
.recharge-page {
    padding: 40px 0; /* 上下内边距40px */
    background-color: #f5f7fa; /* 浅灰色背景 */
    min-height: calc(100vh - 80px); /* 最小高度为视口高度减80px */
}

/* 内容容器 - 限制内容最大宽度并居中 */
.container {
    max-width: 800px; /* 最大宽度限制为800px */
    margin: 0 auto; /* 水平居中 */
    padding: 0 20px; /* 左右内边距20px */
}

/* 充值卡片样式 - 主要内容区域 */
.recharge-card {
    background-color: #fff; /* 白色背景 */
    border-radius: 8px; /* 8px圆角 */
    padding: 30px; /* 内边距30px */
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1); /* 轻微阴影效果 */
}

/* 标题样式 - "账户充值"标题 */
.title {
    margin: 0 0 30px; /* 下外边距30px */
    font-size: 24px; /* 24px字体大小 */
    color: #303133; /* 深灰色文字 */
    text-align: center; /* 文本居中 */
}

/* 余额展示区域样式 - 包含余额标签和金额 */
.balance-section {
    display: flex; /* 弹性布局 */
    justify-content: space-between; /* 两端对齐 */
    align-items: center; /* 垂直居中 */
    padding: 15px 20px; /* 内边距15px上下，20px左右 */
    background-color: #f5f7fa; /* 浅灰色背景 */
    border-radius: 4px; /* 4px圆角 */
    margin-bottom: 30px; /* 下外边距30px */
}

/* 余额标签样式 - "当前余额"文字 */
.balance-label {
    font-size: 16px; /* 16px字体大小 */
    color: #606266; /* 中灰色文字 */
}

/* 余额金额样式 - 具体金额数字 */
.balance-amount {
    font-size: 24px; /* 24px字体大小 */
    font-weight: bold; /* 加粗 */
    color: #ff4d4f; /* 红色文字 */
}

/* 区块标题样式 - "选择充值金额"标题 */
.section-title {
    margin: 0 0 15px; /* 下外边距15px */
    font-size: 18px; /* 18px字体大小 */
    color: #303133; /* 深灰色文字 */
    padding-bottom: 10px; /* 下内边距10px */
    border-bottom: 1px solid #ebeef5; /* 底部1px浅灰色边框 */
}

/* 金额选项容器样式 - 包含所有金额选项 */
.amount-options {
    display: grid; /* 网格布局 */
    grid-template-columns: repeat(3, 1fr); /* 3列等宽 */
    gap: 15px; /* 网格间距15px */
    margin-bottom: 30px; /* 下外边距30px */
}

/* 单个金额选项样式 - 每个金额按钮 */
.amount-option {
    height: 60px; /* 固定高度60px */
    display: flex; /* 弹性布局 */
    align-items: center; /* 垂直居中 */
    justify-content: center; /* 水平居中 */
    border: 1px solid #dcdfe6; /* 1px浅灰色边框 */
    border-radius: 4px; /* 4px圆角 */
    font-size: 18px; /* 18px字体大小 */
    font-weight: 500; /* 中等字重 */
    color: #606266; /* 中灰色文字 */
    cursor: pointer; /* 手型光标 */
    transition: all 0.3s; /* 0.3秒过渡效果 */
}

/* 金额选项悬停效果 - 鼠标悬停时 */
.amount-option:hover {
    border-color: #c0c4cc; /* 悬停时边框颜色变深 */
}

/* 选中状态的金额选项样式 - 当前选中的金额 */
.amount-option.active {
    border-color: #409eff; /* 选中状态蓝色边框 */
    background-color: #ecf5ff; /* 浅蓝色背景 */
    color: #409eff; /* 蓝色文字 */
}

/* 自定义金额输入框样式 - 包含输入框的容器 */
.amount-option.custom {
    padding: 0 10px; /* 左右内边距10px */
    grid-column: span 1; /* 网格跨1列 */
}

/* 操作按钮区域样式 - 包含充值按钮 */
.action-section {
    text-align: center; /* 文本居中 */
}

/* 充值按钮样式 - 立即充值按钮 */
.action-section .el-button {
    width: 100%; /* 宽度100% */
    max-width: 300px; /* 最大宽度300px */
    height: 50px; /* 高度50px */
    font-size: 18px; /* 18px字体大小 */
}

/* 结果弹窗内容样式 - 支付结果对话框内容 */
.result-dialog {
    text-align: center; /* 文本居中 */
    padding: 0 20px 20px; /* 左右内边距20px，下内边距20px */
}

/* 结果图标样式 - 成功/失败图标容器 */
.result-icon {
    margin-bottom: 20px; /* 下外边距20px */
}

/* 结果消息样式 - 主要结果文字 */
.result-message {
    font-size: 18px; /* 18px字体大小 */
    margin-bottom: 10px; /* 下外边距10px */
    color: #303133; /* 深灰色文字 */
}

/* 结果详情样式 - 支付详情文字 */
.result-detail {
    font-size: 14px; /* 14px字体大小 */
    color: #606266; /* 中灰色文字 */
    line-height: 1.6; /* 1.6倍行高 */
}

/* 弹窗底部样式 - 对话框底部按钮区域 */
.dialog-footer {
    display: flex; /* 弹性布局 */
    justify-content: center; /* 内容居中 */
}
</style>
