import request from '@/utils/request'

// 查询服务人员列表
export function listStaff(query) {
  return request({
    url: '/housekeeping/staff/list',
    method: 'get',
    params: query
  })
}

// 查询服务人员详细
export function getStaff(staffId) {
  return request({
    url: '/housekeeping/staff/' + staffId,
    method: 'get'
  })
}

// 新增服务人员
export function addStaff(data) {
  return request({
    url: '/housekeeping/staff',
    method: 'post',
    data: data
  })
}

// 修改服务人员
export function updateStaff(data) {
  return request({
    url: '/housekeeping/staff',
    method: 'put',
    data: data
  })
}

// 删除服务人员
export function delStaff(staffId) {
  return request({
    url: '/housekeeping/staff/' + staffId,
    method: 'delete'
  })
}
