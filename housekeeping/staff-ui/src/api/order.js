import request from '@/utils/request'

// 查询待接订单列表
export function listPendingOrders(query) {
  return request({
    url: '/staff/order/pending',
    method: 'get',
    params: query
  })
}

// 查询进行中订单列表
export function listOngoingOrders(query) {
  return request({
    url: '/staff/order/ongoing',
    method: 'get',
    params: query
  })
}

// 查询历史订单列表
export function listHistoryOrders(query) {
  return request({
    url: '/staff/order/history',
    method: 'get',
    params: query
  })
}

// 获取订单详情
export function getOrderDetail(reservationId) {
  return request({
    url: '/staff/order/' + reservationId,
    method: 'get'
  })
}

// 确认接单
export function acceptOrder(reservationId) {
  return request({
    url: '/staff/order/accept/' + reservationId,
    method: 'put'
  })
}

// 拒绝订单
export function rejectOrder(reservationId, reason) {
  return request({
    url: '/staff/order/reject/' + reservationId,
    method: 'put',
    params: { reason }
  })
}

// 完成订单
export function completeOrder(reservationId) {
  return request({
    url: '/staff/order/complete/' + reservationId,
    method: 'put'
  })
}

// 查询订单评价
export function getOrderAssess(reservationId) {
  return request({
    url: '/staff/order/assess/' + reservationId,
    method: 'get'
  })
}

// 查询我的所有评价列表
export function listMyAssess(query) {
  return request({
    url: '/staff/order/myAssess',
    method: 'get',
    params: query
  })
}

// 获取已完成订单数量
export function getCompletedCount() {
  return request({
    url: '/staff/order/completedCount',
    method: 'get'
  })
}
