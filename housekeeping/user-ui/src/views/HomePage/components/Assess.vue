<template>
    <vxe-modal title="服务评价" v-model="open" width="500px" show-maximize showFooter resize>
        <el-form ref="assessRef" :model="form" :rules="rules" label-width="80px">
            <el-form-item label="服务评分" prop="score">
                <el-rate v-model="form.score" allow-half/>
            </el-form-item>
            <el-form-item label="评价内容" prop="content">
                <el-input :rows="5" v-model="form.content" type="textarea" placeholder="请输入内容"/>
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
import {addAssess} from "@/api/housekeeping/assess.js";

//当前组件的实例
const {proxy} = getCurrentInstance()

const data = reactive({
    form: {},
    rules: {
        score: [
            {required: true, message: "服务评分不能为空", trigger: "blur"}
        ]
    },
})

const {form, rules} = toRefs(data)

//提交评价
const submitForm = () => {
    proxy.$refs["assessRef"].validate(valid => {
        if (valid) {
            //新增一条评价信息
            addAssess(form.value).then(response => {
                proxy.$modal.msgSuccess("评价成功!")
                open.value = false
            })
        }
    })
}

// 表单重置
const reset = () => {
    form.value = {
        assessId: null,
        reservationId: reservationId.value,
        score: null,
        content: null,
        createTime: null,
        goIndex: null
    }
    proxy.resetForm("assessRef")
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
