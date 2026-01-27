<template>
    <div class="app-container">
        <!-- 顶部搜索 -->
        <el-form :model="queryParams" ref="queryRef" v-show="showSearch" label-width="100px">
            <el-row :gutter="24" class="mb8">
                <el-col :span="8">
                    <el-form-item label="服务名称" prop="serveName">
                        <el-input
                                v-model="queryParams.serveName"
                                placeholder="请输入服务名称"
                                clearable
                                @keyup.enter="handleQuery"
                        />
                    </el-form-item>
                </el-col>
                <el-col :span="8">
                    <el-form-item label="预约服务时间" style="width: 100%">
                        <el-date-picker
                                v-model="daterangeTime"
                                value-format="YYYY-MM-DD"
                                type="daterange"
                                range-separator="-"
                                start-placeholder="开始日期"
                                end-placeholder="结束日期"
                        ></el-date-picker>
                    </el-form-item>
                </el-col>
                <el-col :span="8">
                    <el-form-item label="预约状态" prop="status" style="width: 100%;">
                        <el-select v-model="queryParams.status" placeholder="请选择预约状态"
                                   clearable>
                            <el-option
                                    v-for="dict in reservation_status"
                                    :key="dict.value"
                                    :label="dict.label"
                                    :value="dict.value"
                            />
                        </el-select>
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row :gutter="24" class="mb8">
                <el-col :span="8">
                    <el-form-item label="服务人员姓名" prop="staffName">
                        <el-input
                                v-model="queryParams.staffName"
                                placeholder="请输入服务人员姓名"
                                clearable
                                @keyup.enter="handleQuery"
                        />
                    </el-form-item>
                </el-col>
                <el-col :span="8">
                    <el-form-item label="创建人用户名" prop="userName">
                        <el-input
                                v-model="queryParams.userName"
                                placeholder="请输入创建人用户名"
                                clearable
                                @keyup.enter="handleQuery"
                        />
                    </el-form-item>
                </el-col>
                <el-col :span="8">
                    <el-form-item>
                        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
                        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
                    </el-form-item>
                </el-col>
            </el-row>
        </el-form>

        <!-- 顶部按钮 -->
        <el-row :gutter="10" class="mb8">
            <el-col :span="1.5">
                <el-button
                        type="primary"
                        plain
                        icon="Plus"
                        @click="handleAdd"
                        v-hasPermi="['housekeeping:reservation:add']"
                >新增
                </el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button
                        type="success"
                        plain
                        icon="Edit"
                        :disabled="single"
                        @click="handleUpdate"
                        v-hasPermi="['housekeeping:reservation:edit']"
                >修改
                </el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button
                        type="danger"
                        plain
                        icon="Delete"
                        :disabled="multiple"
                        @click="handleDelete"
                        v-hasPermi="['housekeeping:reservation:remove']"
                >删除
                </el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button
                        type="warning"
                        plain
                        icon="Download"
                        @click="handleExport"
                        v-hasPermi="['housekeeping:reservation:export']"
                >导出
                </el-button>
            </el-col>
            <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>

        <!-- 表格 -->
        <el-table @row-click="clickRow" ref="table" highlight-current-row
                  border v-loading="loading" :data="reservationList" @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="55" align="center"/>
            <el-table-column label="序号" align="center" type="index" :index="indexMethod"/>
            <el-table-column label="服务名称" align="center" prop="serveName"/>
            <el-table-column label="预约服务时间" align="center" prop="time" width="180">
                <template #default="scope">
                    <span>{{ parseTime(scope.row.time, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
                </template>
            </el-table-column>
            <el-table-column label="预约服务地址" align="center" prop="address"/>
            <el-table-column label="联系人" align="center" prop="contacts"/>
            <el-table-column label="联系电话" align="center" prop="phone"/>
            <el-table-column label="特别要求" align="center" prop="special"/>
            <el-table-column label="预约状态" align="center" prop="status">
                <template #default="scope">
                    <dict-tag :options="reservation_status" :value="scope.row.status"/>
                </template>
            </el-table-column>
            <el-table-column label="服务人员姓名" align="center" prop="staffName"/>
            <el-table-column label="创建人用户名" align="center" prop="userName"/>
            <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="200px">
                <template #default="scope">
                    <el-button link type="primary" icon="UserFilled" @click="handleSelectStaff(scope.row)"
                               >分配服务人员
                    </el-button>
                    <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)"
                               v-hasPermi="['housekeeping:reservation:edit']">修改
                    </el-button>
                    <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)"
                               v-hasPermi="['housekeeping:reservation:remove']">删除
                    </el-button>
                </template>
            </el-table-column>
        </el-table>

        <!-- 分页组件 -->
        <pagination
                v-show="total>0"
                :total="total"
                v-model:page="queryParams.pageNum"
                v-model:limit="queryParams.pageSize"
                @pagination="getList"
        />

        <!-- 添加或修改预约对话框 -->
        <vxe-modal :title="title" v-model="open" width="500px" show-maximize showFooter resize>
            <el-form ref="reservationRef" :model="form" :rules="rules" label-width="80px">
                <el-form-item label="服务ID" prop="serveId">
                    <el-input v-model="form.serveId" placeholder="请输入服务ID"/>
                </el-form-item>
                <el-form-item label="预约服务时间" prop="time">
                    <el-date-picker clearable
                                    v-model="form.time"
                                    type="datetime"
                                    value-format="YYYY-MM-DD HH:mm:ss"
                                    placeholder="请选择预约服务时间">
                    </el-date-picker>
                </el-form-item>
                <el-form-item label="预约服务地址" prop="address">
                    <el-input v-model="form.address" type="textarea" placeholder="请输入内容"/>
                </el-form-item>
                <el-form-item label="联系人" prop="contacts">
                    <el-input v-model="form.contacts" placeholder="请输入联系人"/>
                </el-form-item>
                <el-form-item label="联系电话" prop="phone">
                    <el-input v-model="form.phone" placeholder="请输入联系电话"/>
                </el-form-item>
                <el-form-item label="特别要求" prop="special">
                    <el-input v-model="form.special" type="textarea" placeholder="请输入内容"/>
                </el-form-item>
            </el-form>
            <template #footer>
                <div class="dialog-footer">
                    <el-button type="primary" @click="submitForm">确 定</el-button>
                    <el-button @click="cancel">取 消</el-button>
                </div>
            </template>
        </vxe-modal>

        <!-- 选择服务人员组件 -->
        <SelectStaff ref="selectStaff" @ok="getList"/>
    </div>
</template>

<script setup name="Reservation">
import {
    listReservation,
    getReservation,
    delReservation,
    addReservation,
    updateReservation
} from "@/api/housekeeping/reservation"
import {getToken} from "@/utils/auth.js";
import SelectStaff from "@/views/housekeeping/reservation/SelectStaff.vue";

const baseURL = import.meta.env.VITE_APP_BASE_API

const {proxy} = getCurrentInstance()
const {reservation_status} = proxy.useDict('reservation_status')

const reservationList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")
const selectedRow = ref(null)
const daterangeTime = ref([])

const data = reactive({
    form: {},
    queryParams: {
        pageNum: 1,
        pageSize: 10,
        serveId: null,
        time: null,
        status: null,
        staffId: null,
        userId: null,
        userName: null,
        serveName: null,
        staffName: null
    },
    rules: {
        serveId: [
            {required: true, message: "服务ID不能为空", trigger: "blur"}
        ],
        time: [
            {required: true, message: "预约服务时间不能为空", trigger: "blur"}
        ],
        address: [
            {required: true, message: "预约服务地址不能为空", trigger: "blur"}
        ],
        contacts: [
            {required: true, message: "联系人不能为空", trigger: "blur"}
        ],
        phone: [
            {required: true, message: "联系电话不能为空", trigger: "blur"}
        ],
        special: [
            {required: true, message: "特别要求不能为空", trigger: "blur"}
        ]
    },
})

const {queryParams, form, rules} = toRefs(data)

//实例化选择服务人员组件
const selectStaff = ref(null)

//打开选择服务人员组件
const handleSelectStaff = (row) => {
    selectStaff.value.handleOpen(row.reservationId)
}

//点击行 获取行
const clickRow = (row) => {
    selectedRow.value = row; // 更新选中的行
    const table = proxy.$refs.table;
    // 清除所有已选中的行
    table.clearSelection();
    // 选中当前点击的行
    table.toggleRowSelection(row, true);
}

/** 自定义序号 */
const indexMethod = (index) => {
    let pageNum = queryParams.value.pageNum - 1;
    if ((pageNum !== -1 && pageNum !== 0)) {
        return (index + 1) + (pageNum * queryParams.value.pageSize);
    } else {
        return (index + 1)
    }
}

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
        total.value = response.total
        loading.value = false
    })
}

// 取消按钮
const cancel = () => {
    open.value = false
    reset()
}

// 表单重置
const reset = () => {
    form.value = {
        reservationId: null,
        serveId: null,
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

/** 搜索按钮操作 */
const handleQuery = () => {
    queryParams.value.pageNum = 1
    getList()
}

/** 重置按钮操作 */
const resetQuery = () => {
    daterangeTime.value = []
    proxy.resetForm("queryRef")
    handleQuery()
}

// 多选框选中数据
const handleSelectionChange = (selection) => {
    ids.value = selection.map(item => item.reservationId)
    single.value = selection.length != 1
    multiple.value = !selection.length
}

/** 新增按钮操作 */
const handleAdd = () => {
    reset()
    open.value = true
    title.value = "添加预约"
}

/** 修改按钮操作 */
const handleUpdate = (row) => {
    reset()
    const _reservationId = row.reservationId || ids.value
    getReservation(_reservationId).then(response => {
        form.value = response.data
        open.value = true
        title.value = "修改预约"
    })
}

/** 提交按钮 */
const submitForm = () => {
    proxy.$refs["reservationRef"].validate(valid => {
        if (valid) {
            if (form.value.reservationId != null) {
                updateReservation(form.value).then(response => {
                    proxy.$modal.msgSuccess("修改成功")
                    open.value = false
                    getList()
                })
            } else {
                addReservation(form.value).then(response => {
                    proxy.$modal.msgSuccess("新增成功")
                    open.value = false
                    getList()
                })
            }
        }
    })
}

/** 删除按钮操作 */
const handleDelete = (row) => {
    const _reservationIds = row.reservationId || ids.value
    proxy.$modal.confirm('是否确认删除该项数据？').then(function () {
        return delReservation(_reservationIds)
    }).then(() => {
        getList()
        proxy.$modal.msgSuccess("删除成功")
    }).catch(() => {
    })
}

/** 导出按钮操作 */
const handleExport = () => {
    proxy.download('housekeeping/reservation/export', {
        ...queryParams.value
    }, `reservation_${new Date().getTime()}.xlsx`)
}

getList()
</script>
