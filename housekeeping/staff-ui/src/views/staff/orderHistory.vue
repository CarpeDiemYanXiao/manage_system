<template>
  <div class="order-history-container">
    <el-card>
      <template #header>
        <div class="card-header">
          <span>订单记录</span>
        </div>
      </template>

      <!-- 搜索条件 -->
      <el-form :inline="true" :model="queryParams" class="search-form">
        <el-form-item label="订单状态">
          <el-select v-model="queryParams.status" placeholder="全部" clearable style="width: 120px">
            <el-option label="已完成" value="已完成" />
            <el-option label="已取消" value="已取消" />
            <el-option label="已拒绝" value="已拒绝" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">
            <el-icon><Search /></el-icon> 搜索
          </el-button>
          <el-button @click="resetQuery">
            <el-icon><Refresh /></el-icon> 重置
          </el-button>
        </el-form-item>
      </el-form>

      <el-table :data="orderList" style="width: 100%" v-loading="loading" border>
        <el-table-column prop="reservationId" label="订单号" width="180" />
        <el-table-column prop="serveName" label="服务项目" width="120" />
        <el-table-column prop="customerName" label="客户姓名" width="100" />
        <el-table-column prop="customerPhone" label="联系电话" width="120" />
        <el-table-column prop="serviceTime" label="服务时间" width="180" />
        <el-table-column prop="address" label="服务地址" min-width="150" show-overflow-tooltip />
        <el-table-column prop="price" label="服务金额" width="100">
          <template #default="scope">
            ¥{{ scope.row.price }}
          </template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="100">
          <template #default="scope">
            <el-tag :type="getStatusType(scope.row.status)">{{ scope.row.status }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="下单时间" width="180" />
        <el-table-column label="操作" width="100" fixed="right">
          <template #default="scope">
            <el-button type="primary" link size="small" @click="handleViewAssess(scope.row)" 
                       v-if="scope.row.status === '已完成'">
              查看评价
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

    <!-- 评价详情对话框 -->
    <el-dialog v-model="assessVisible" title="用户评价" width="500px">
      <div v-if="currentAssess">
        <el-descriptions :column="1" border>
          <el-descriptions-item label="评分">
            <el-rate v-model="currentAssess.score" disabled />
          </el-descriptions-item>
          <el-descriptions-item label="评价内容">{{ currentAssess.content || '暂无评价内容' }}</el-descriptions-item>
          <el-descriptions-item label="评价时间">{{ currentAssess.createTime }}</el-descriptions-item>
        </el-descriptions>
      </div>
      <div v-else class="no-assess">
        <el-empty description="暂无评价" />
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { Search, Refresh } from '@element-plus/icons-vue'
import { listHistoryOrders, getOrderAssess } from '@/api/order'
import Pagination from '@/components/Pagination/index.vue'

const loading = ref(false)
const orderList = ref([])
const total = ref(0)
const assessVisible = ref(false)
const currentAssess = ref(null)

const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  status: ''
})

onMounted(() => {
  loadData()
})

const loadData = async () => {
  loading.value = true
  try {
    const res = await listHistoryOrders(queryParams.value)
    orderList.value = res.rows || []
    total.value = res.total || 0
  } finally {
    loading.value = false
  }
}

const handleSearch = () => {
  queryParams.value.pageNum = 1
  loadData()
}

const resetQuery = () => {
  queryParams.value = {
    pageNum: 1,
    pageSize: 10,
    status: ''
  }
  loadData()
}

const getStatusType = (status) => {
  const types = {
    '已完成': 'success',
    '已取消': 'info',
    '已拒绝': 'danger'
  }
  return types[status] || 'info'
}

const handleViewAssess = async (row) => {
  const res = await getOrderAssess(row.reservationId)
  currentAssess.value = res.data
  assessVisible.value = true
}
</script>

<style scoped>
.order-history-container {
  padding: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.search-form {
  margin-bottom: 20px;
}

.no-assess {
  text-align: center;
  padding: 20px;
}
</style>
