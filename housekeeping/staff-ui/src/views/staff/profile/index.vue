<template>
  <div class="profile-container">
    <el-row :gutter="20">
      <!-- 左侧个人信息卡片 -->
      <el-col :span="8">
        <el-card>
          <template #header>
            <div class="card-header">个人信息</div>
          </template>
          <div class="profile-info">
            <div class="avatar-section">
              <el-avatar :size="100" :src="userStore.avatar">
                {{ userStore.name?.charAt(0) }}
              </el-avatar>
              <el-upload
                class="avatar-uploader"
                :action="uploadUrl"
                :headers="headers"
                :show-file-list="false"
                :on-success="handleAvatarSuccess"
              >
                <el-button size="small" type="primary">更换头像</el-button>
              </el-upload>
            </div>
            <el-descriptions :column="1" border>
              <el-descriptions-item label="账号">{{ userStore.username }}</el-descriptions-item>
              <el-descriptions-item label="姓名">{{ userStore.name }}</el-descriptions-item>
              <el-descriptions-item label="手机号">{{ userStore.phone }}</el-descriptions-item>
              <el-descriptions-item label="服务类型">
                <el-tag>{{ userStore.staffType }}</el-tag>
              </el-descriptions-item>
              <el-descriptions-item label="工作状态">
                <el-tag :type="userStore.status === '空闲' ? 'success' : 'warning'">
                  {{ userStore.status }}
                </el-tag>
              </el-descriptions-item>
              <el-descriptions-item label="账号状态">
                <el-tag :type="userStore.accountStatus === '正常' ? 'success' : 'danger'">
                  {{ userStore.accountStatus }}
                </el-tag>
              </el-descriptions-item>
            </el-descriptions>
          </div>
        </el-card>
      </el-col>

      <!-- 右侧编辑区域 -->
      <el-col :span="16">
        <el-card>
          <el-tabs v-model="activeTab">
            <!-- 基本信息 -->
            <el-tab-pane label="基本信息" name="info">
              <el-form ref="infoFormRef" :model="infoForm" :rules="infoRules" label-width="100px">
                <el-form-item label="个人照片">
                  <div class="photo-upload-container">
                    <el-image 
                      v-if="infoForm.photo" 
                      :src="getPhotoUrl(infoForm.photo)" 
                      :preview-src-list="[getPhotoUrl(infoForm.photo)]"
                      fit="cover"
                      style="width: 150px; height: 150px; border-radius: 8px;"
                    />
                    <div v-else class="photo-placeholder">
                      <el-icon :size="40"><Picture /></el-icon>
                      <span>暂无照片</span>
                    </div>
                    <el-upload
                      class="photo-uploader"
                      :action="uploadUrl"
                      :headers="headers"
                      :show-file-list="false"
                      :on-success="handlePhotoSuccess"
                      accept="image/*"
                    >
                      <el-button size="small" type="primary">上传个人照片</el-button>
                    </el-upload>
                    <div class="photo-tip">此照片将展示给用户，请上传清晰的个人形象照</div>
                  </div>
                </el-form-item>
                <el-form-item label="姓名" prop="name">
                  <el-input v-model="infoForm.name" placeholder="请输入姓名" />
                </el-form-item>
                <el-form-item label="手机号" prop="phone">
                  <el-input v-model="infoForm.phone" placeholder="请输入手机号" />
                </el-form-item>
                <el-form-item label="性别" prop="gender">
                  <el-radio-group v-model="infoForm.gender">
                    <el-radio label="男">男</el-radio>
                    <el-radio label="女">女</el-radio>
                  </el-radio-group>
                </el-form-item>
                <el-form-item label="服务技能" prop="skills">
                  <el-input 
                    v-model="infoForm.skills" 
                    type="textarea" 
                    :rows="3" 
                    placeholder="请输入您的服务技能，如：擅长深度清洁、家电维护等" 
                  />
                </el-form-item>
                <el-form-item label="个人简介" prop="introduction">
                  <el-input 
                    v-model="infoForm.introduction" 
                    type="textarea" 
                    :rows="4" 
                    placeholder="请简单介绍一下自己的从业经历和特长" 
                  />
                </el-form-item>
                <el-form-item>
                  <el-button type="primary" @click="submitInfoForm" :loading="loading">保存修改</el-button>
                </el-form-item>
              </el-form>
            </el-tab-pane>

            <!-- 修改密码 -->
            <el-tab-pane label="修改密码" name="password">
              <el-form ref="pwdFormRef" :model="pwdForm" :rules="pwdRules" label-width="100px">
                <el-form-item label="旧密码" prop="oldPassword">
                  <el-input v-model="pwdForm.oldPassword" type="password" placeholder="请输入旧密码" show-password />
                </el-form-item>
                <el-form-item label="新密码" prop="newPassword">
                  <el-input v-model="pwdForm.newPassword" type="password" placeholder="请输入新密码" show-password />
                </el-form-item>
                <el-form-item label="确认密码" prop="confirmPassword">
                  <el-input v-model="pwdForm.confirmPassword" type="password" placeholder="请确认新密码" show-password />
                </el-form-item>
                <el-form-item>
                  <el-button type="primary" @click="submitPwdForm" :loading="pwdLoading">修改密码</el-button>
                  <el-button @click="resetPwdForm">重置</el-button>
                </el-form-item>
              </el-form>
            </el-tab-pane>
          </el-tabs>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { updateInfo, updatePwd } from '@/api/login'
import useUserStore from '@/store/modules/user'
import { ElMessage } from 'element-plus'
import { getToken } from '@/utils/auth'
import { Picture } from '@element-plus/icons-vue'

const userStore = useUserStore()

const activeTab = ref('info')
const loading = ref(false)
const pwdLoading = ref(false)

const uploadUrl = import.meta.env.VITE_APP_BASE_API + '/common/upload'
const headers = {
  Authorization: 'Bearer ' + getToken()
}

const infoFormRef = ref(null)
const pwdFormRef = ref(null)

const infoForm = reactive({
  name: '',
  phone: '',
  gender: '',
  skills: '',
  introduction: '',
  photo: ''
})

// 获取照片完整URL
const getPhotoUrl = (photo) => {
  if (!photo) return ''
  if (photo.startsWith('http')) return photo
  return import.meta.env.VITE_APP_BASE_API + photo
}

// 照片上传成功
const handlePhotoSuccess = (response) => {
  if (response.code === 200) {
    infoForm.photo = response.fileName
    // 立即保存照片
    updateInfo({ photo: response.fileName }).then(() => {
      ElMessage.success('照片上传成功')
      userStore.getInfo()
    })
  } else {
    ElMessage.error('照片上传失败')
  }
}

const pwdForm = reactive({
  oldPassword: '',
  newPassword: '',
  confirmPassword: ''
})

const equalToNewPassword = (rule, value, callback) => {
  if (pwdForm.newPassword !== value) {
    callback(new Error('两次输入的密码不一致'))
  } else {
    callback()
  }
}

const infoRules = {
  name: [{ required: true, message: '请输入姓名', trigger: 'blur' }],
  phone: [
    { required: true, message: '请输入手机号', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号', trigger: 'blur' }
  ]
}

const pwdRules = {
  oldPassword: [{ required: true, message: '请输入旧密码', trigger: 'blur' }],
  newPassword: [
    { required: true, message: '请输入新密码', trigger: 'blur' },
    { min: 5, max: 20, message: '密码长度必须介于 5 和 20 之间', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '请确认新密码', trigger: 'blur' },
    { validator: equalToNewPassword, trigger: 'blur' }
  ]
}

onMounted(() => {
  // 初始化表单数据
  infoForm.name = userStore.name
  infoForm.phone = userStore.phone
  infoForm.skills = userStore.skills
  infoForm.introduction = userStore.introduction
  infoForm.photo = userStore.photo || ''
})

const handleAvatarSuccess = (response) => {
  if (response.code === 200) {
    // 更新头像
    updateInfo({ photo: response.fileName }).then(() => {
      ElMessage.success('头像更新成功')
      userStore.getInfo()
    })
  }
}

const submitInfoForm = () => {
  infoFormRef.value.validate(valid => {
    if (valid) {
      loading.value = true
      updateInfo(infoForm).then(() => {
        ElMessage.success('修改成功')
        userStore.getInfo()
      }).finally(() => {
        loading.value = false
      })
    }
  })
}

const submitPwdForm = () => {
  pwdFormRef.value.validate(valid => {
    if (valid) {
      pwdLoading.value = true
      updatePwd(pwdForm.oldPassword, pwdForm.newPassword).then(() => {
        ElMessage.success('密码修改成功')
        resetPwdForm()
      }).finally(() => {
        pwdLoading.value = false
      })
    }
  })
}

const resetPwdForm = () => {
  pwdFormRef.value?.resetFields()
}
</script>

<style scoped>
.profile-container {
  padding: 20px;
}

.card-header {
  font-weight: bold;
}

.profile-info {
  text-align: center;
}

.avatar-section {
  margin-bottom: 20px;
}

.avatar-section .el-avatar {
  margin-bottom: 10px;
}

.avatar-uploader {
  margin-top: 10px;
}

.photo-upload-container {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  gap: 10px;
}

.photo-placeholder {
  width: 150px;
  height: 150px;
  border: 2px dashed #dcdfe6;
  border-radius: 8px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  color: #909399;
}

.photo-placeholder span {
  margin-top: 8px;
  font-size: 14px;
}

.photo-tip {
  font-size: 12px;
  color: #909399;
}
</style>
