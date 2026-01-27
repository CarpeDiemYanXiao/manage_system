<template>
    <vxe-modal title="选择服务人员" v-model="open" width="70%" show-maximize showFooter resize height="80vh">
        <!-- 顶部搜索 -->
        <el-form :model="queryParams" ref="queryRef" :inline="true" label-width="68px">
            <el-form-item label="姓名" prop="name">
                <el-input
                        v-model="queryParams.name"
                        placeholder="请输入姓名"
                        clearable
                        @keyup.enter="handleQuery"
                />
            </el-form-item>
            <el-form-item label="性别" prop="gender">
                <el-select style="width: 200px;" v-model="queryParams.gender" placeholder="请选择性别" clearable>
                    <el-option
                            v-for="dict in gender"
                            :key="dict.value"
                            :label="dict.label"
                            :value="dict.value"
                    />
                </el-select>
            </el-form-item>
            <el-form-item label="人员类型" prop="staffType">
                <el-select style="width: 200px;" v-model="queryParams.staffType" placeholder="请选择人员类型" clearable>
                    <el-option
                            v-for="dict in serve_type"
                            :key="dict.value"
                            :label="dict.label"
                            :value="dict.value"
                    />
                </el-select>
            </el-form-item>
            <el-form-item label="状态" prop="status">
                <el-select style="width: 200px;" v-model="queryParams.status" placeholder="请选择状态" clearable>
                    <el-option
                            v-for="dict in staff_status"
                            :key="dict.value"
                            :label="dict.label"
                            :value="dict.value"
                    />
                </el-select>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
                <el-button icon="Refresh" @click="resetQuery">重置</el-button>
            </el-form-item>
        </el-form>

        <!-- 表格 -->
        <el-table @row-click="clickRow" ref="table" highlight-current-row
                  border v-loading="loading" :data="staffList">
            <el-table-column label="序号" align="center" type="index" :index="indexMethod"/>
            <el-table-column label="姓名" align="center" prop="name"/>
            <el-table-column label="性别" align="center" prop="gender">
                <template #default="scope">
                    <dict-tag :options="gender" :value="scope.row.gender"/>
                </template>
            </el-table-column>
            <el-table-column label="联系电话" align="center" prop="phone"/>
            <el-table-column label="照片" align="center" prop="photo" width="100">
                <template #default="scope">
                    <image-preview :src="scope.row.photo" :width="50" :height="50"/>
                </template>
            </el-table-column>
            <el-table-column label="人员类型" align="center" prop="staffType">
                <template #default="scope">
                    <dict-tag :options="serve_type" :value="scope.row.staffType"/>
                </template>
            </el-table-column>
            <el-table-column label="状态" align="center" prop="status">
                <template #default="scope">
                    <dict-tag :options="staff_status" :value="scope.row.status"/>
                </template>
            </el-table-column>
        </el-table>

        <template #footer>
            <div class="dialog-footer">
                <el-button type="primary" @click="submitForm">确 定</el-button>
                <el-button @click="open = false">取 消</el-button>
            </div>
        </template>
    </vxe-modal>
</template>

<script setup>
import {listStaff, updateStaff} from "@/api/housekeeping/staff.js";
import {updateReservation} from "@/api/housekeeping/reservation.js";

//当前组件实例
const {proxy} = getCurrentInstance()

//字典数据
const {staff_status, serve_type, gender} = proxy.useDict('staff_status', 'serve_type', 'gender')

const data = reactive({
    form: {},
    queryParams: {
        pageNum: 1,
        pageSize: 10,
        name: null,
        gender: null,
        staffType: null,
        status: null,
    }
})

const {queryParams, form} = toRefs(data)

/** 自定义序号 */
const indexMethod = (index) => {
    let pageNum = queryParams.value.pageNum - 1;
    if ((pageNum !== -1 && pageNum !== 0)) {
        return (index + 1) + (pageNum * queryParams.value.pageSize);
    } else {
        return (index + 1)
    }
}

//当前选中的行
const selectedRow = ref(null)

//点击行 获取行
const clickRow = (row) => {
    selectedRow.value = row; // 更新选中的行
}

const emit = defineEmits(['ok'])

//确定方法
const submitForm = () => {
    //选中的服务人员的ID
    const staffId = selectedRow.value.staffId

    //构建预约单更新所需的表单数据
    const reservationForm = {
        reservationId: reservationId.value,
        staffId: staffId
    }

    //更新预约单数据, 分配服务人员
    updateReservation(reservationForm).then(res => {
        //将服务人员的状态改为服务中
        const item = {
            staffId: staffId,
            status: '服务中'
        }
        updateStaff(item).then(res => {
            proxy.$modal.msgSuccess("分配成功")
            open.value = false
            emit('ok')
        })
    })

}

//控制弹窗是否打开
const open = ref(false)

//预约单ID
const reservationId = ref('')

//父组件调用方法
const handleOpen = (id) => {
    reservationId.value = id
    getList()
    //打开弹窗
    open.value = true
}

/** 搜索按钮操作 */
const handleQuery = () => {
    queryParams.value.pageNum = 1
    getList()
}

/** 重置按钮操作 */
const resetQuery = () => {
    proxy.resetForm("queryRef")
    handleQuery()
}

//服务人员列表数据
const staffList = ref([])
//数据综述
const total = ref(0)
//加载状态
const loading = ref(false)

/** 查询服务人员列表 */
const getList = () => {
    loading.value = true
    listStaff(queryParams.value).then(response => {
        staffList.value = response.rows
        total.value = response.total
        loading.value = false
    })
}

//必须暴露方法, 父组件才能调用
defineExpose({
    handleOpen
})
</script>

<style scoped>

</style>
