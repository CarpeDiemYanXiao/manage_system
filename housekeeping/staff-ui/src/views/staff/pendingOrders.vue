<template>
  <div class="pending-orders-container">
    <el-card>
      <template #header>
        <div class="card-header">
          <span>待接订单列表</span>
          <el-button type="primary" @click="loadData">
            <el-icon><Refresh /></el-icon> 刷新
          </el-button>
        </div>
      </template>

      <el-table :data="orderList" style="width: 100%" v-loading="loading" border>
        <el-table-column prop="reservationId" label="订单号" width="180" />
        <el-table-column prop="serveName" label="服务项目" width="120" />
        <el-table-column prop="customerName" label="客户姓名" width="100" />
        <el-table-column prop="customerPhone" label="联系电话" width="120" />
        <el-table-column prop="serviceTime" label="服务时间" width="180" />
        <el-table-column prop="address" label="服务地址" min-width="200" show-overflow-tooltip />
        <el-table-column prop="price" label="服务金额" width="100">
          <template #default="scope">
            ¥{{ scope.row.price }}
          </template>
        </el-table-column>
        <el-table-column prop="remark" label="备注" width="150" show-overflow-tooltip />
        <el-table-column prop="createTime" label="下单时间" width="180" />
        <el-table-column label="操作" width="180" fixed="right">
          <template #default="scope">
            <el-button type="primary" size="small" @click="handleAccept(scope.row)">
              <el-icon><Check /></el-icon> 接单
            </el-button>
            <el-button type="danger" size="small" @click="handleReject(scope.row)">
              <el-icon><Close /></el-icon> 拒绝
            </el-button>
          </template>
        </el-table-column>
      </el-table>

      <pagination
        v-show="total > 0"
        :total="total"
        v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize"
        @pagination="loadData"
      />
    </el-card>

    <!-- 订单详情对话框 -->
    <el-dialog v-model="detailVisible" title="订单详情" width="600px">
      <el-descriptions :column="2" border v-if="currentOrder">
        <el-descriptions-item label="订单号">{{ currentOrder.reservationId }}</el-descriptions-item>
        <el-descriptions-item label="服务项目">{{ currentOrder.serveName }}</el-descriptions-item>
        <el-descriptions-item label="客户姓名">{{ currentOrder.customerName }}</el-descriptions-item>
        <el-descriptions-item label="联系电话">{{ currentOrder.customerPhone }}</el-descriptions-item>
        <el-descriptions-item label="服务时间">{{ currentOrder.serviceTime }}</el-descriptions-item>
        <el-descriptions-item label="服务金额">¥{{ currentOrder.price }}</el-descriptions-item>
        <el-descriptions-item label="服务地址" :span="2">{{ currentOrder.address }}</el-descriptions-item>
        <el-descriptions-item label="备注" :span="2">{{ currentOrder.remark || '无' }}</el-descriptions-item>
      </el-descriptions>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { Refresh, Check, Close } from '@element-plus/icons-vue'
import { listPendingOrders, acceptOrder, rejectOrder, getOrderDetail } from '@/api/order'
import { ElMessageBox, ElMessage } from 'element-plus'
import Pagination from '@/components/Pagination/index.vue'

const loading = ref(false)
const orderList = ref([])
const total = ref(0)
const detailVisible = ref(false)
const currentOrder = ref(null)

const queryParams = ref({
  pageNum: 1,
  pageSize: 10
})

onMounted(() => {
  loadData()
})

const loadData = async () => {
  loading.value = true
  try {
    const res = await listPendingOrders(queryParams.value)
    orderList.value = res.rows || []
    total.value = res.total || 0
  } finally {
    loading.value = false
  }
}

const handleView = async (row) => {
  const res = await getOrderDetail(row.reservationId)
  currentOrder.value = res.data
  detailVisible.value = true
}

const handleAccept = (row) => {
  ElMessageBox.confirm(
    `确认接受订单 [${row.reservationId}] 吗？
    服务项目：${row.serveName}
    客户：${row.customerName}
    服务时间：${row.serviceTime}`,
    '确认接单',
    {
      confirmButtonText: '确定接单',
      cancelButtonText: '取消',
      type: 'info'
    }
  ).then(() => {
    acceptOrder(row.reservationId).then(() => {
      ElMessage.success('接单成功！请按时提供服务')
      loadData()
    })
  }).catch(() => {})
}

const handleReject = (row) => {
  ElMessageBox.prompt('请输入拒绝原因（可选）', '拒绝订单', {
    confirmButtonText: '确定拒绝',
    cancelButtonText: '取消',
    inputPlaceholder: '请输入拒绝原因',
    type: 'warning'
  }).then(({ value }) => {
    rejectOrder(row.reservationId, value).then(() => {
      ElMessage.success('已拒绝订单')
      loadData()
    })
  }).catch(() => {})
}
</script>

<style scoped>
.pending-orders-container {
  padding: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
