<template>
  <div class="workbench-container">
    <el-row :gutter="20">
      <!-- 员工信息卡片 -->
      <el-col :span="8">
        <el-card class="info-card">
          <template #header>
            <div class="card-header">
              <span>个人信息</span>
            </div>
          </template>
          <div class="staff-info">
            <el-avatar :size="80" :src="userStore.avatar"></el-avatar>
            <div class="info-detail">
              <h3>{{ userStore.name }}</h3>
              <p><el-tag>{{ userStore.staffType }}</el-tag></p>
              <p>手机：{{ userStore.phone }}</p>
              <p>状态：
                <el-tag :type="userStore.status === '空闲' ? 'success' : 'warning'">
                  {{ userStore.status }}
                </el-tag>
              </p>
            </div>
          </div>
        </el-card>
      </el-col>

      <!-- 订单统计卡片 -->
      <el-col :span="16">
        <el-row :gutter="20">
          <el-col :span="8">
            <el-card class="stat-card pending" shadow="hover" @click="router.push('/index/pendingOrders')">
              <div class="stat-content">
                <el-icon :size="40"><Bell /></el-icon>
                <div class="stat-info">
                  <div class="stat-number">{{ stats.pendingCount }}</div>
                  <div class="stat-label">待接订单</div>
                </div>
              </div>
            </el-card>
          </el-col>
          <el-col :span="8">
            <el-card class="stat-card ongoing" shadow="hover" @click="router.push('/index/ongoingOrders')">
              <div class="stat-content">
                <el-icon :size="40"><Timer /></el-icon>
                <div class="stat-info">
                  <div class="stat-number">{{ stats.ongoingCount }}</div>
                  <div class="stat-label">进行中</div>
                </div>
              </div>
            </el-card>
          </el-col>
          <el-col :span="8">
            <el-card class="stat-card completed" shadow="hover" @click="router.push('/index/orderHistory')">
              <div class="stat-content">
                <el-icon :size="40"><CircleCheck /></el-icon>
                <div class="stat-info">
                  <div class="stat-number">{{ stats.completedCount }}</div>
                  <div class="stat-label">已完成</div>
                </div>
              </div>
            </el-card>
          </el-col>
        </el-row>
      </el-col>
    </el-row>

    <!-- 待处理订单列表 -->
    <el-card class="order-card" style="margin-top: 20px;">
      <template #header>
        <div class="card-header">
          <span>待接订单</span>
          <el-button type="primary" link @click="router.push('/index/pendingOrders')">查看更多</el-button>
        </div>
      </template>
      <el-table :data="pendingOrders" style="width: 100%" v-loading="loading">
        <el-table-column prop="reservationId" label="订单号" width="180" />
        <el-table-column prop="serveName" label="服务项目" />
        <el-table-column prop="contacts" label="客户姓名" />
        <el-table-column prop="phone" label="联系电话" />
        <el-table-column prop="time" label="服务时间" width="180" />
        <el-table-column prop="address" label="服务地址" />
        <el-table-column label="操作" width="180">
          <template #default="scope">
            <el-button type="primary" size="small" @click="handleAccept(scope.row)">接单</el-button>
            <el-button type="danger" size="small" @click="handleReject(scope.row)">拒绝</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <!-- 进行中订单列表 -->
    <el-card class="order-card" style="margin-top: 20px;">
      <template #header>
        <div class="card-header">
          <span>进行中订单</span>
          <el-button type="primary" link @click="router.push('/index/ongoingOrders')">查看更多</el-button>
        </div>
      </template>
      <el-table :data="ongoingOrders" style="width: 100%" v-loading="loading">
        <el-table-column prop="reservationId" label="订单号" width="180" />
        <el-table-column prop="serveName" label="服务项目" />
        <el-table-column prop="contacts" label="客户姓名" />
        <el-table-column prop="phone" label="联系电话" />
        <el-table-column prop="time" label="服务时间" width="180" />
        <el-table-column prop="address" label="服务地址" />
        <el-table-column label="操作" width="100">
          <template #default="scope">
            <el-button type="success" size="small" @click="handleComplete(scope.row)">完成</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { Bell, Timer, CircleCheck } from '@element-plus/icons-vue'
import { listPendingOrders, listOngoingOrders, acceptOrder, rejectOrder, completeOrder, getCompletedCount } from '@/api/order'
import useUserStore from '@/store/modules/user'
import { ElMessageBox, ElMessage } from 'element-plus'

const router = useRouter()
const userStore = useUserStore()

const loading = ref(false)
const pendingOrders = ref([])
const ongoingOrders = ref([])
const stats = ref({
  pendingCount: 0,
  ongoingCount: 0,
  completedCount: 0
})

onMounted(() => {
  loadData()
})

const loadData = async () => {
  loading.value = true
  try {
    // 加载待接订单
    const pendingRes = await listPendingOrders({ pageNum: 1, pageSize: 5 })
    pendingOrders.value = pendingRes.rows || []
    stats.value.pendingCount = pendingRes.total || 0

    // 加载进行中订单
    const ongoingRes = await listOngoingOrders({ pageNum: 1, pageSize: 5 })
    ongoingOrders.value = ongoingRes.rows || []
    stats.value.ongoingCount = ongoingRes.total || 0

    // 加载已完成订单数量
    const completedRes = await getCompletedCount()
    stats.value.completedCount = completedRes.data || 0
  } finally {
    loading.value = false
  }
}

const handleAccept = (row) => {
  ElMessageBox.confirm('确认接受此订单吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    acceptOrder(row.reservationId).then(() => {
      ElMessage.success('接单成功')
      loadData()
    })
  }).catch(() => {})
}

const handleReject = (row) => {
  ElMessageBox.prompt('请输入拒绝原因（可选）', '拒绝订单', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    inputPlaceholder: '请输入拒绝原因'
  }).then(({ value }) => {
    rejectOrder(row.reservationId, value).then(() => {
      ElMessage.success('已拒绝订单')
      loadData()
    })
  }).catch(() => {})
}

const handleComplete = (row) => {
  ElMessageBox.confirm('确认此订单已完成吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    completeOrder(row.reservationId).then(() => {
      ElMessage.success('订单已完成')
      loadData()
    })
  }).catch(() => {})
}
</script>

<style scoped>
.workbench-container {
  padding: 20px;
}

.info-card {
  height: 200px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.staff-info {
  display: flex;
  align-items: center;
  gap: 20px;
}

.info-detail h3 {
  margin: 0 0 10px 0;
}

.info-detail p {
  margin: 5px 0;
  color: #666;
}

.stat-card {
  cursor: pointer;
  transition: all 0.3s;
}

.stat-card:hover {
  transform: translateY(-5px);
}

.stat-card.pending {
  background: linear-gradient(135deg, #ff9500 0%, #ff5e3a 100%);
  color: white;
}

.stat-card.ongoing {
  background: linear-gradient(135deg, #1e88e5 0%, #42a5f5 100%);
  color: white;
}

.stat-card.completed {
  background: linear-gradient(135deg, #43a047 0%, #66bb6a 100%);
  color: white;
}

.stat-content {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 20px;
  padding: 20px;
}

.stat-number {
  font-size: 36px;
  font-weight: bold;
}

.stat-label {
  font-size: 14px;
  opacity: 0.9;
}

.order-card {
  margin-top: 20px;
}
</style>
