<template>
  <div class="my-assess-container">
    <el-card>
      <template #header>
        <div class="card-header">
          <span>我的评价</span>
          <el-button type="primary" link @click="loadData">
            <el-icon><Refresh /></el-icon> 刷新
          </el-button>
        </div>
      </template>

      <!-- 评价统计 -->
      <div class="assess-stats">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-statistic title="总评价数" :value="total" />
          </el-col>
          <el-col :span="12">
            <el-statistic title="好评率" :value="goodRate" suffix="%" />
          </el-col>
        </el-row>
      </div>

      <el-divider />

      <!-- 评价列表 -->
      <div class="assess-list" v-loading="loading">
        <div v-if="assessList.length === 0" class="no-data">
          <el-empty description="暂无评价" />
        </div>
        <div v-else>
          <div v-for="assess in assessList" :key="assess.assessId" class="assess-item">
            <div class="assess-header">
              <div class="customer-info">
                <el-avatar :size="40" :src="assess.customerAvatar">
                  {{ assess.customerName?.charAt(0) || '用' }}
                </el-avatar>
                <div class="customer-detail">
                  <span class="customer-name">{{ assess.customerName || '匿名用户' }}</span>
                  <span class="assess-time">{{ assess.createTime }}</span>
                </div>
              </div>
              <div class="assess-score">
                <el-rate :model-value="Number(assess.score) || 0" disabled />
              </div>
            </div>
            <div class="assess-content">
              {{ assess.content || '用户未填写评价内容' }}
            </div>
            <div class="assess-order">
              <el-tag size="small">订单号: {{ assess.reservationId }}</el-tag>
              <el-tag size="small" type="info">{{ assess.serveName }}</el-tag>
            </div>
          </div>
        </div>
      </div>

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
import { ref, onMounted, computed } from 'vue'
import { Refresh } from '@element-plus/icons-vue'
import { listMyAssess } from '@/api/order'
import Pagination from '@/components/Pagination/index.vue'

const loading = ref(false)
const assessList = ref([])
const total = ref(0)
const avgScore = computed(() => {
  if (assessList.value.length === 0) return 0
  const validScores = assessList.value
    .map(item => Number(item.score))
    .filter(score => !Number.isNaN(score) && score > 0)
  if (validScores.length === 0) return 0
  const sum = validScores.reduce((acc, val) => acc + val, 0)
  return Math.round((sum / validScores.length) * 10) / 10
})

const queryParams = ref({
  pageNum: 1,
  pageSize: 10
})

const goodRate = computed(() => {
  if (total.value === 0) return 0
  const goodCount = assessList.value.filter(a => Number(a.score) >= 4).length
  // 使用总评价数计算好评率（基于当前页面数据估算）
  return Math.round((goodCount / assessList.value.length) * 100)
})

onMounted(() => {
  loadData()
})

const loadData = async () => {
  loading.value = true
  try {
    const res = await listMyAssess(queryParams.value)
    assessList.value = res.rows || []
    total.value = res.total || 0
    
    // 平均评分改为由computed基于列表自动计算
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.my-assess-container {
  padding: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.assess-stats {
  padding: 20px;
  background: #f5f7fa;
  border-radius: 8px;
  margin-bottom: 20px;
}

.assess-list {
  min-height: 300px;
}

.assess-item {
  padding: 20px;
  border-bottom: 1px solid #ebeef5;
}

.assess-item:last-child {
  border-bottom: none;
}

.assess-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
}

.customer-info {
  display: flex;
  align-items: center;
  gap: 10px;
}

.customer-detail {
  display: flex;
  flex-direction: column;
}

.customer-name {
  font-weight: bold;
}

.assess-time {
  font-size: 12px;
  color: #999;
}

.assess-content {
  color: #666;
  line-height: 1.6;
  margin: 10px 0;
  padding-left: 50px;
}

.assess-order {
  display: flex;
  gap: 10px;
  padding-left: 50px;
}

.no-data {
  padding: 40px;
  text-align: center;
}
</style>
