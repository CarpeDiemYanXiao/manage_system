import request from '@/utils/request'

// 查询评价列表
export function listAssess(query) {
  return request({
    url: '/housekeeping/assess/list',
    method: 'get',
    params: query
  })
}

// 查询评价详细
export function getAssess(assessId) {
  return request({
    url: '/housekeeping/assess/' + assessId,
    method: 'get'
  })
}

// 新增评价
export function addAssess(data) {
  return request({
    url: '/housekeeping/assess',
    method: 'post',
    data: data
  })
}

// 修改评价
export function updateAssess(data) {
  return request({
    url: '/housekeeping/assess',
    method: 'put',
    data: data
  })
}

// 删除评价
export function delAssess(assessId) {
  return request({
    url: '/housekeeping/assess/' + assessId,
    method: 'delete'
  })
}
