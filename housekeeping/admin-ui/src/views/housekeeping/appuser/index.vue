<template>
    <div class="app-container">
        <!-- 顶部搜索 -->
        <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
            <el-form-item label="用户名" prop="username">
                <el-input
                    v-model="queryParams.username"
                    placeholder="请输入用户名"
                    clearable
                    @keyup.enter="handleQuery"
                />
            </el-form-item>
            <el-form-item label="手机号" prop="phone">
                <el-input
                    v-model="queryParams.phone"
                    placeholder="请输入手机号"
                    clearable
                    @keyup.enter="handleQuery"
                />
            </el-form-item>
            <el-form-item label="状态" prop="status">
                <el-select v-model="queryParams.status" placeholder="请选择状态" clearable style="width: 200px;">
                    <el-option
                        v-for="dict in account_status"
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
                    type="danger"
                    plain
                    icon="Delete"
                    :disabled="multiple"
                    @click="handleDelete"
                    v-hasPermi="['housekeeping:appuser:remove']"
                >删除</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button
                    type="warning"
                    plain
                    icon="Download"
                    @click="handleExport"
                    v-hasPermi="['housekeeping:appuser:export']"
                >导出</el-button>
            </el-col>
            <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>

        <!-- 表格 -->
        <el-table @row-click="clickRow" ref="table" highlight-current-row
                  border v-loading="loading" :data="appUserList" @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="55" align="center"/>
            <el-table-column label="序号" align="center" type="index" :index="indexMethod"/>
            <el-table-column label="用户名" align="center" prop="username"/>
            <el-table-column label="昵称" align="center" prop="nickname"/>
            <el-table-column label="头像" align="center" prop="avatar" width="100">
                <template #default="scope">
                    <image-preview v-if="scope.row.avatar" :src="scope.row.avatar" :width="50" :height="50"/>
                    <span v-else>-</span>
                </template>
            </el-table-column>
            <el-table-column label="手机号" align="center" prop="phone"/>
            <el-table-column label="邮箱" align="center" prop="email"/>
            <el-table-column label="性别" align="center" prop="gender"/>
            <el-table-column label="状态" align="center" prop="status">
                <template #default="scope">
                    <el-switch
                        v-model="scope.row.status"
                        active-value="正常"
                        inactive-value="禁用"
                        @change="handleStatusChange(scope.row)"
                    ></el-switch>
                </template>
            </el-table-column>
            <el-table-column label="最后登录时间" align="center" prop="lastLoginTime" width="180">
                <template #default="scope">
                    <span>{{ parseTime(scope.row.lastLoginTime, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
                </template>
            </el-table-column>
            <el-table-column label="操作" align="center" width="180" class-name="small-padding fixed-width">
                <template #default="scope">
                    <el-button link type="primary" icon="Key" @click="handleResetPwd(scope.row)"
                               v-hasPermi="['housekeeping:appuser:edit']">重置密码</el-button>
                    <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)"
                               v-hasPermi="['housekeeping:appuser:remove']">删除</el-button>
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
    </div>
</template>

<script setup name="AppUser">
import { listAppUser, delAppUser, changeUserStatus, resetUserPwd } from "@/api/housekeeping/appuser";

const { proxy } = getCurrentInstance();
const { account_status } = proxy.useDict("account_status");

const appUserList = ref([]);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);

const data = reactive({
    queryParams: {
        pageNum: 1,
        pageSize: 10,
        username: null,
        phone: null,
        status: null
    }
});

const { queryParams } = toRefs(data);

/** 查询App用户列表 */
function getList() {
    loading.value = true;
    listAppUser(queryParams.value).then(response => {
        appUserList.value = response.rows;
        total.value = response.total;
        loading.value = false;
    });
}

/** 搜索按钮操作 */
function handleQuery() {
    queryParams.value.pageNum = 1;
    getList();
}

/** 重置按钮操作 */
function resetQuery() {
    proxy.resetForm("queryRef");
    handleQuery();
}

/** 点击行选中 */
function clickRow(row) {
    proxy.$refs.table.toggleRowSelection(row);
}

/** 多选框选中数据 */
function handleSelectionChange(selection) {
    ids.value = selection.map(item => item.userId);
    single.value = selection.length !== 1;
    multiple.value = !selection.length;
}

/** 用户状态修改 */
function handleStatusChange(row) {
    let text = row.status === "正常" ? "启用" : "停用";
    proxy.$modal.confirm('确认要"' + text + '""' + row.username + '"用户吗?').then(function() {
        return changeUserStatus(row.userId, row.status);
    }).then(() => {
        proxy.$modal.msgSuccess(text + "成功");
    }).catch(function() {
        row.status = row.status === "正常" ? "禁用" : "正常";
    });
}

/** 重置密码按钮操作 */
function handleResetPwd(row) {
    proxy.$modal.confirm('是否确认重置"' + row.username + '"的密码为123456?').then(function() {
        return resetUserPwd(row.userId);
    }).then(() => {
        proxy.$modal.msgSuccess("重置成功");
    }).catch(() => {});
}

/** 删除按钮操作 */
function handleDelete(row) {
    const userIds = row.userId || ids.value;
    proxy.$modal.confirm('是否确认删除用户编号为"' + userIds + '"的数据项?').then(function() {
        return delAppUser(userIds);
    }).then(() => {
        getList();
        proxy.$modal.msgSuccess("删除成功");
    }).catch(() => {});
}

/** 导出按钮操作 */
function handleExport() {
    proxy.download('housekeeping/appuser/export', {
        ...queryParams.value
    }, `appuser_${new Date().getTime()}.xlsx`);
}

/** 序号 */
function indexMethod(index) {
    return index + 1 + (queryParams.value.pageNum - 1) * queryParams.value.pageSize;
}

getList();
</script>
