import request from '@/utils/request'

// 查询App用户列表
export function listAppUser(query) {
    return request({
        url: '/housekeeping/appuser/list',
        method: 'get',
        params: query
    })
}

// 查询App用户详细
export function getAppUser(userId) {
    return request({
        url: '/housekeeping/appuser/' + userId,
        method: 'get'
    })
}

// 修改App用户状态（封禁/解封）
export function changeUserStatus(userId, status) {
    const data = {
        userId,
        status
    }
    return request({
        url: '/housekeeping/appuser/changeStatus',
        method: 'put',
        data: data
    })
}

// 删除App用户
export function delAppUser(userId) {
    return request({
        url: '/housekeeping/appuser/' + userId,
        method: 'delete'
    })
}

// 导出App用户
export function exportAppUser(query) {
    return request({
        url: '/housekeeping/appuser/export',
        method: 'post',
        params: query,
        responseType: 'blob'
    })
}

// 重置App用户密码
export function resetUserPwd(userId) {
    const data = {
        userId
    }
    return request({
        url: '/housekeeping/appuser/resetPwd',
        method: 'put',
        data: data
    })
}
