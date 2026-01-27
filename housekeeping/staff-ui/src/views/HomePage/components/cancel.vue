<template>
    <vxe-modal title="取消预约" v-model="open" width="500px" show-maximize showFooter resize>
        <el-form ref="cancelRef" :model="form" :rules="rules" label-width="80px">
            <el-form-item label="取消原因" prop="reason">
                <el-select v-model="form.reason" placeholder="请选择取消原因">
                    <el-option
                            v-for="dict in cancel_reason"
                            :key="dict.value"
                            :label="dict.label"
                            :value="dict.value"
                    ></el-option>
                </el-select>
            </el-form-item>
            <el-form-item label="备注" prop="notes">
                <el-input v-model="form.notes" type="textarea" placeholder="请输入内容"/>
            </el-form-item>
        </el-form>
        <template #footer>
            <div class="dialog-footer">
                <el-button type="primary" @click="submitForm">确 定</el-button>
                <el-button @click="open = false">取 消</el-button>
            </div>
        </template>
    </vxe-modal>
</template>

<script setup>
import {addCancel} from "@/api/housekeeping/cancel.js";
import {updateReservation} from "@/api/housekeeping/reservation.js";

//当前组件的实例
const {proxy} = getCurrentInstance()

//字典数据
const {cancel_reason} = proxy.useDict('cancel_reason')

const data = reactive({
    form: {},
    rules: {
        reason: [
            {required: true, message: "取消原因不能为空", trigger: "change"}
        ],
    },
})

const {form, rules} = toRefs(data)

const emit = defineEmits(['ok'])

//确定取消预约
const submitForm = () => {
    proxy.$refs["cancelRef"].validate(valid => {
        if (valid) {
            //新增一条取消预约记录
            addCancel(form.value).then(response => {
                //将预约单的状态修改为已取消
                const item = {
                    reservationId: reservationId.value,
                    status: '已取消'
                }
                updateReservation(item).then(res => {
                    proxy.$modal.msgSuccess("取消预约成功")
                    open.value = false
                    emit('ok')
                })
            })


        }
    })
}

// 表单重置
const reset = () => {
    form.value = {
        cancelId: null,
        reservationId: reservationId.value,
        reason: null,
        notes: null,
        createTime: null
    }
    proxy.resetForm("cancelRef")
}

//弹窗是否打开
const open = ref(false)

//预约ID
const reservationId = ref('')

//父组件调用方法
const handleOpen = (id) => {
    reservationId.value = id
    reset()
    open.value = true
}

//必须暴露方法, 父组件才能调用
defineExpose({
    handleOpen
})
</script>

<style scoped>

</style>
