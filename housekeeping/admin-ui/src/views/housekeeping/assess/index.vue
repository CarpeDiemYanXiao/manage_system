<template>
    <div class="app-container">
        <!-- 顶部搜索 -->
        <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="110px">
            <el-form-item label="订单编号" prop="reservationId">
                <el-input
                        v-model="queryParams.reservationId"
                        placeholder="请输入订单编号"
                        clearable
                        @keyup.enter="handleQuery"
                />
            </el-form-item>
            <el-form-item label="是否推送到主页" prop="goIndex">
                <el-select v-model="queryParams.goIndex" placeholder="请选择是否推送到主页" clearable
                           style="width: 200px;">
                    <el-option
                            v-for="dict in go_index"
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

        <!-- 顶部按钮 -->
        <el-row :gutter="10" class="mb8">
            <el-col :span="1.5">
                <el-button
                        type="primary"
                        plain
                        icon="Plus"
                        @click="handleAdd"
                        v-hasPermi="['housekeeping:assess:add']"
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
                        v-hasPermi="['housekeeping:assess:edit']"
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
                        v-hasPermi="['housekeeping:assess:remove']"
                >删除
                </el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button
                        type="warning"
                        plain
                        icon="Download"
                        @click="handleExport"
                        v-hasPermi="['housekeeping:assess:export']"
                >导出
                </el-button>
            </el-col>
            <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>

        <!-- 表格 -->
        <el-table @row-click="clickRow" ref="table" highlight-current-row
                  border v-loading="loading" :data="assessList" @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="55" align="center"/>
            <el-table-column label="序号" align="center" type="index" :index="indexMethod"/>
            <el-table-column label="订单编号" align="center" prop="reservationId"/>
            <el-table-column label="服务评分" align="center" prop="score">
                <template #default="scope">
                    <el-rate v-model="scope.row.score" disabled/>
                </template>
            </el-table-column>
            <el-table-column label="评价内容" align="center" prop="content"/>
            <el-table-column label="是否推送到主页" align="center" prop="goIndex">
                <template #default="scope">
                    <dict-tag :options="go_index" :value="scope.row.goIndex"/>
                </template>
            </el-table-column>
            <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
                <template #default="scope">
                    <el-button v-if="scope.row.goIndex === '否'" link
                               type="primary" icon="TopRight" @click="goToIndex(scope.row)"
                    >推送到前台首页
                    </el-button>
                    <el-button v-if="scope.row.goIndex === '推送'" link
                               type="primary" icon="CloseBold" @click="cancelToIndex(scope.row)"
                    >取消推送
                    </el-button>
                    <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)"
                               v-hasPermi="['housekeeping:assess:edit']">修改
                    </el-button>
                    <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)"
                               v-hasPermi="['housekeeping:assess:remove']">删除
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

        <!-- 添加或修改评价对话框 -->
        <vxe-modal :title="title" v-model="open" width="500px" show-maximize showFooter resize>
            <el-form ref="assessRef" :model="form" :rules="rules" label-width="80px">
                <el-form-item label="订单编号" prop="reservationId">
                    <el-input v-model="form.reservationId" placeholder="请输入订单编号"/>
                </el-form-item>
                <el-form-item label="服务评分" prop="score">
                    <el-rate v-model="form.score" allow-half/>
                </el-form-item>
                <el-form-item label="评价内容" prop="content">
                    <el-input v-model="form.content" type="textarea" placeholder="请输入内容"/>
                </el-form-item>
            </el-form>
            <template #footer>
                <div class="dialog-footer">
                    <el-button type="primary" @click="submitForm">确 定</el-button>
                    <el-button @click="cancel">取 消</el-button>
                </div>
            </template>
        </vxe-modal>
    </div>
</template>

<script setup name="Assess">
import {listAssess, getAssess, delAssess, addAssess, updateAssess} from "@/api/housekeeping/assess"
import {getToken} from "@/utils/auth.js";

const baseURL = import.meta.env.VITE_APP_BASE_API

const {proxy} = getCurrentInstance()
const {go_index} = proxy.useDict('go_index')

const assessList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")
const selectedRow = ref(null)

const data = reactive({
    form: {},
    queryParams: {
        pageNum: 1,
        pageSize: 10,
        reservationId: null,
        goIndex: null
    },
    rules: {
        reservationId: [
            {required: true, message: "订单编号不能为空", trigger: "blur"}
        ],
        score: [
            {required: true, message: "服务评分不能为空", trigger: "blur"}
        ]
    },
})

const {queryParams, form, rules} = toRefs(data)

//点击行 获取行
const clickRow = (row) => {
    selectedRow.value = row; // 更新选中的行
    const table = proxy.$refs.table;
    // 清除所有已选中的行
    table.clearSelection();
    // 选中当前点击的行
    table.toggleRowSelection(row, true);
}

//推送到前台首页
const goToIndex = (row) => {
  const item = {
      assessId: row.assessId,
      goIndex: '推送'
  }
  updateAssess(item).then(res => {
      getList()
      proxy.$modal.msgSuccess("推送成功!")
  })
}

//取消推送
const cancelToIndex = (row) => {
    const item = {
        assessId: row.assessId,
        goIndex: '否'
    }
    updateAssess(item).then(res => {
        getList()
        proxy.$modal.msgSuccess("已取消推送!")
    })
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

/** 查询评价列表 */
const getList = () => {
    loading.value = true
    listAssess(queryParams.value).then(response => {
        assessList.value = response.rows
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
        assessId: null,
        reservationId: null,
        score: null,
        content: null,
        createTime: null,
        goIndex: null
    }
    proxy.resetForm("assessRef")
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

// 多选框选中数据
const handleSelectionChange = (selection) => {
    ids.value = selection.map(item => item.assessId)
    single.value = selection.length != 1
    multiple.value = !selection.length
}

/** 新增按钮操作 */
const handleAdd = () => {
    reset()
    open.value = true
    title.value = "添加评价"
}

/** 修改按钮操作 */
const handleUpdate = (row) => {
    reset()
    const _assessId = row.assessId || ids.value
    getAssess(_assessId).then(response => {
        form.value = response.data
        open.value = true
        title.value = "修改评价"
    })
}

/** 提交按钮 */
const submitForm = () => {
    proxy.$refs["assessRef"].validate(valid => {
        if (valid) {
            if (form.value.assessId != null) {
                updateAssess(form.value).then(response => {
                    proxy.$modal.msgSuccess("修改成功")
                    open.value = false
                    getList()
                })
            } else {
                addAssess(form.value).then(response => {
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
    const _assessIds = row.assessId || ids.value
    proxy.$modal.confirm('是否确认删除该项数据？').then(function () {
        return delAssess(_assessIds)
    }).then(() => {
        getList()
        proxy.$modal.msgSuccess("删除成功")
    }).catch(() => {
    })
}

/** 导出按钮操作 */
const handleExport = () => {
    proxy.download('housekeeping/assess/export', {
        ...queryParams.value
    }, `assess_${new Date().getTime()}.xlsx`)
}

getList()
</script>
