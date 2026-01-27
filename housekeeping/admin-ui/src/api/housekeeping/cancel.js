import request from '@/utils/request'

// 查询取消记录列表
export function listCancel(query) {
  return request({
    url: '/housekeeping/cancel/list',
    method: 'get',
    params: query
  })
}

// 查询取消记录详细
export function getCancel(cancelId) {
  return request({
    url: '/housekeeping/cancel/' + cancelId,
    method: 'get'
  })
}

// 新增取消记录
export function addCancel(data) {
  return request({
    url: '/housekeeping/cancel',
    method: 'post',
    data: data
  })
}

// 修改取消记录
export function updateCancel(data) {
  return request({
    url: '/housekeeping/cancel',
    method: 'put',
    data: data
  })
}

// 删除取消记录
export function delCancel(cancelId) {
  return request({
    url: '/housekeeping/cancel/' + cancelId,
    method: 'delete'
  })
}
