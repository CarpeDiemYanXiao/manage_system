import { login, logout, getInfo } from '@/api/login'
import { getToken, setToken, removeToken } from '@/utils/auth'
import { isHttp, isEmpty } from "@/utils/validate"
import defAva from '@/assets/images/profile.png'

const useUserStore = defineStore(
  'user',
  {
    state: () => ({
      token: getToken(),
      staffId: '',
      name: '',
      username: '',
      avatar: '',
      photo: '',  // 个人照片（原始路径）
      phone: '',
      staffType: '',
      skills: '',
      introduction: '',
      status: '',
      accountStatus: '',
      roles: [],  // 初始为空，登录后设置
      permissions: []
    }),
    actions: {
      // 登录
      login(userInfo) {
        const username = userInfo.username.trim()
        const password = userInfo.password
        return new Promise((resolve, reject) => {
          login(username, password).then(res => {
            setToken(res.token)
            this.token = res.token
            resolve()
          }).catch(error => {
            reject(error)
          })
        })
      },
      // 获取用户信息
      getInfo() {
        return new Promise((resolve, reject) => {
          getInfo().then(res => {
            const staff = res.staff
            let avatar = staff.photo || ""
            this.photo = staff.photo || ""  // 保存原始路径
            if (!isHttp(avatar)) {
              avatar = (isEmpty(avatar)) ? defAva : import.meta.env.VITE_APP_BASE_API + avatar
            }
            this.staffId = staff.staffId
            this.name = staff.name
            this.username = staff.username
            this.avatar = avatar
            this.phone = staff.phone
            this.staffType = staff.staffType
            this.skills = staff.skills
            this.introduction = staff.introduction
            this.status = staff.status
            this.accountStatus = staff.accountStatus
            this.roles = ['staff']
            this.permissions = ['*:*:*']
            resolve(res)
          }).catch(error => {
            reject(error)
          })
        })
      },
      // 退出系统
      logOut() {
        return new Promise((resolve) => {
          this.token = ''
          this.roles = []
          this.permissions = []
          removeToken()
          logout().then(() => {
            resolve()
          }).catch(() => {
            resolve() // 即使后端退出失败，前端也视为成功
          })
        })
      }
    }
  })

export default useUserStore
