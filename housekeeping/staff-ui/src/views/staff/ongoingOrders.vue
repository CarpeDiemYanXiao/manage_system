<template>
  <div class="ongoing-orders-container">
    <el-card>
      <template #header>
        <div class="card-header">
          <span>进行中订单列表</span>
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
        <el-table-column label="操作" width="120" fixed="right">
          <template #default="scope">
            <el-button type="success" size="small" @click="handleComplete(scope.row)">
              <el-icon><CircleCheck /></el-icon> 完成
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
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { Refresh, CircleCheck } from '@element-plus/icons-vue'
import { listOngoingOrders, completeOrder } from '@/api/order'
import { ElMessageBox, ElMessage } from 'element-plus'
import Pagination from '@/components/Pagination/index.vue'

const loading = ref(false)
const orderList = ref([])
const total = ref(0)

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
    const res = await listOngoingOrders(queryParams.value)
    orderList.value = res.rows || []
    total.value = res.total || 0
  } finally {
    loading.value = false
  }
}

const handleComplete = (row) => {
  ElMessageBox.confirm(
    `确认订单 [${row.reservationId}] 已完成吗？
    服务项目：${row.serveName}
    客户：${row.customerName}`,
    '确认完成',
    {
      confirmButtonText: '确认完成',
      cancelButtonText: '取消',
      type: 'success'
    }
  ).then(() => {
    completeOrder(row.reservationId).then(() => {
      ElMessage.success('订单已完成！')
      loadData()
    })
  }).catch(() => {})
}
</script>

<style scoped>
.ongoing-orders-container {
  padding: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
