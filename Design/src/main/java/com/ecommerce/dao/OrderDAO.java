package com.ecommerce.dao;

import com.ecommerce.model.Order;

import java.sql.Connection;
import java.sql.SQLException;
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
    /**
     * 减少订单中商品的库存
     * @param orderId 订单ID
     * @param conn 数据库连接（用于事务）
     * @throws SQLException 数据库操作异常
     */

    /**
     * 增加退货商品的库存
     * @param orderId 订单ID
     * @param conn 数据库连接（用于事务）
     * @throws SQLException 数据库操作异常
     */
    /**
     * 更新订单状态（带连接参数，用于事务）
     * @param orderId 订单ID
     * @param status 新状态
     * @param conn 数据库连接
     * @throws SQLException
     */
    void updateStatus(Integer orderId, String status, Connection conn) throws SQLException;
    void increaseProductStock(Integer orderId, Connection conn) throws SQLException;
    void reduceProductStock(Integer orderId, Connection conn) throws SQLException;

    List<Order> findByMerchantId(Integer merchantId);
    Order getById(Integer orderId);
}