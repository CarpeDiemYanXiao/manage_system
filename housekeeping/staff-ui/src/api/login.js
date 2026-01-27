import request from '@/utils/request'

// 员工登录方法
export function login(username, password) {
  const data = {
    username,
    password
  }
  return request({
    url: '/staff/login',
    headers: {
      isToken: false,
      repeatSubmit: false
    },
    method: 'post',
    data: data
  })
}

// 员工注册方法
export function register(data) {
  return request({
    url: '/staff/register',
    headers: {
      isToken: false
    },
    method: 'post',
    data: data
  })
}

// 获取员工详细信息
export function getInfo() {
  return request({
    url: '/staff/getInfo',
    method: 'get'
  })
}

// 更新员工个人信息
export function updateInfo(data) {
  return request({
    url: '/staff/updateInfo',
    method: 'put',
    data: data
  })
}

// 修改密码
export function updatePwd(oldPassword, newPassword) {
  return request({
    url: '/staff/updatePwd',
    method: 'put',
    params: {
      oldPassword,
      newPassword
    }
  })
}

// 退出方法 (前端清除token即可)
export function logout() {
  return Promise.resolve()
}

// 获取验证码（员工端不需要验证码，但保留接口兼容）
export function getCodeImg() {
  return Promise.resolve({ captchaEnabled: false })
}
