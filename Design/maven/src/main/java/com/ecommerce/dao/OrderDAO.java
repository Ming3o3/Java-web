package com.ecommerce.dao;

import com.ecommerce.model.Order;
import java.util.List;
import java.util.Map;
import java.util.Date;

public interface OrderDAO {
    void save(Order order);
    void update(Order order);
    void updateStatus(Integer orderId, String status);
    void delete(Integer orderId);
    Order findById(Integer orderId);
    List<Order> findByCustomerId(Integer customerId);
    List<Order> findAll();
    List<Order> searchOrders(Integer customerId, String keyword, String status, Date startDate, Date endDate);
    boolean canTransitionStatus(String currentStatus, String newStatus);
    Map<String, Object> getOrderStatistics(Integer customerId);
    int countPendingOrdersByMerchantId(Integer merchantId);
    List<Order> findRecentOrdersByMerchantId(Integer merchantId, int limit);
    /**
     * 根据商家ID查询所有订单
     * @param merchantId 商家ID
     * @return 订单列表
     */
    List<Order> findByMerchantId(Integer merchantId);
    Order getById(Integer orderId);
} 