import request from '@/utils/request'

// 查询服务列表
export function listServe(query) {
  return request({
    url: '/housekeeping/serve/list',
    method: 'get',
    params: query
  })
}

// 查询服务详细
export function getServe(serveId) {
  return request({
    url: '/housekeeping/serve/' + serveId,
    method: 'get'
  })
}

// 新增服务
export function addServe(data) {
  return request({
    url: '/housekeeping/serve',
    method: 'post',
    data: data
  })
}

// 修改服务
export function updateServe(data) {
  return request({
    url: '/housekeeping/serve',
    method: 'put',
    data: data
  })
}

// 删除服务
export function delServe(serveId) {
  return request({
    url: '/housekeeping/serve/' + serveId,
    method: 'delete'
  })
}
