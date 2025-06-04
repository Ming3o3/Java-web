package com.ecommerce.dao.impl;

import com.ecommerce.dao.OrderDAO;
import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.Order;
import com.ecommerce.model.OrderItem;
import com.ecommerce.model.Product;
import com.ecommerce.util.DBUtil;

import java.sql.*;
import java.util.*;
import java.util.Date;
import java.util.Arrays;
import java.math.BigDecimal;

public class OrderDAOImpl implements OrderDAO {
    private ProductDAO productDAO;
    private static final Map<String, Set<String>> STATUS_TRANSITIONS = new HashMap<>();

    static {
        // 定义订单状态流转规则
        Set<String> pendingTransitions = new HashSet<>(Arrays.asList("PAID", "CANCELLED"));
        Set<String> paidTransitions = new HashSet<>(Arrays.asList("SHIPPED", "CANCELLED"));
        Set<String> shippedTransitions = new HashSet<>(Arrays.asList("DELIVERED"));
        Set<String> deliveredTransitions = new HashSet<>(Arrays.asList("COMPLETED"));
        Set<String> cancelledTransitions = new HashSet<>(); // 取消状态是终态

        STATUS_TRANSITIONS.put("PENDING", pendingTransitions);
        STATUS_TRANSITIONS.put("PAID", paidTransitions);
        STATUS_TRANSITIONS.put("SHIPPED", shippedTransitions);
        STATUS_TRANSITIONS.put("DELIVERED", deliveredTransitions);
        STATUS_TRANSITIONS.put("CANCELLED", cancelledTransitions);
    }

    public OrderDAOImpl() {
        this.productDAO = new ProductDAOImpl();
    }

    @Override
    public void save(Order order) {
        String orderSql = "INSERT INTO `order` (customer_id, order_date, status, total_amount, shipping_address) VALUES (?, ?, ?, ?, ?)";
        String orderItemSql = "INSERT INTO order_item (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false);
            try {
                // 保存订单
                try (PreparedStatement stmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                    stmt.setInt(1, order.getCustomerId());
                    stmt.setTimestamp(2, new Timestamp(order.getOrderDate().getTime()));
                    stmt.setString(3, order.getStatus());
                    stmt.setBigDecimal(4, order.getTotalAmount());
                    stmt.setString(5, order.getShippingAddress());
                    
                    stmt.executeUpdate();
                    
                    try (ResultSet rs = stmt.getGeneratedKeys()) {
                        if (rs.next()) {
                            order.setOrderId(rs.getInt(1));
                        }
                    }
                }
                
                // 保存订单项
                if (order.getOrderItems() != null) {
                    try (PreparedStatement stmt = conn.prepareStatement(orderItemSql)) {
                        for (OrderItem item : order.getOrderItems()) {
                            stmt.setInt(1, order.getOrderId());
                            stmt.setInt(2, item.getProductId());
                            stmt.setInt(3, item.getQuantity());
                            stmt.setBigDecimal(4, item.getUnitPrice());
                            stmt.addBatch();
                        }
                        stmt.executeBatch();
                    }
                }
                
                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Order order) {
        String sql = "UPDATE `order` SET status = ?, total_amount = ?, shipping_address = ? WHERE order_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, order.getStatus());
            stmt.setBigDecimal(2, order.getTotalAmount());
            stmt.setString(3, order.getShippingAddress());
            stmt.setInt(4, order.getOrderId());
            
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(Integer orderId) {
        String sql = "DELETE FROM `order` WHERE order_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Order findById(Integer orderId) {
        String sql = "SELECT * FROM `order` WHERE order_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Order order = extractOrder(rs);
                loadOrderItems(order);
                return order;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    @Override
    public List<Order> findByCustomerId(Integer customerId) {
        String sql = "SELECT * FROM `order` WHERE customer_id = ? ORDER BY order_date DESC";
        List<Order> orders = new ArrayList<>();
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Order order = extractOrder(rs);
                loadOrderItems(order);
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return orders;
    }

    @Override
    public List<Order> findAll() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM `order` ORDER BY order_date DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Order order = extractOrder(rs);
                loadOrderItems(order);
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return orders;
    }

    @Override
    public boolean canTransitionStatus(String currentStatus, String newStatus) {
        // 定义状态转换规则
        Map<String, List<String>> validTransitions = new HashMap<>();
        validTransitions.put("待发货", Arrays.asList("已发货", "已取消"));
        validTransitions.put("已发货", Arrays.asList("已完成"));
        validTransitions.put("已完成", Arrays.asList());
        validTransitions.put("已取消", Arrays.asList());
        
        List<String> allowedTransitions = validTransitions.get(currentStatus);
        return allowedTransitions != null && allowedTransitions.contains(newStatus);
    }

    @Override
    public Map<String, Object> getOrderStatistics(Integer customerId) {
        Map<String, Object> statistics = new HashMap<>();
        String sql = "SELECT status, COUNT(*) as count, SUM(total_amount) as total FROM orders WHERE customer_id = ? GROUP BY status";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                String status = rs.getString("status");
                int count = rs.getInt("count");
                double total = rs.getDouble("total");
                
                statistics.put(status + "_count", count);
                statistics.put(status + "_total", total);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return statistics;
    }

    @Override
    public List<Order> searchOrders(Integer customerId, String keyword, String status, Date startDate, Date endDate) {
        List<Order> orders = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM orders WHERE 1=1");
        List<Object> params = new ArrayList<>();
        
        if (customerId != null) {
            sql.append(" AND customer_id = ?");
            params.add(customerId);
        }
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (shipping_address LIKE ? OR status LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND status = ?");
            params.add(status);
        }
        
        if (startDate != null) {
            sql.append(" AND order_date >= ?");
            params.add(new Timestamp(startDate.getTime()));
        }
        
        if (endDate != null) {
            sql.append(" AND order_date <= ?");
            params.add(new Timestamp(endDate.getTime()));
        }
        
        sql.append(" ORDER BY order_date DESC");
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Order order = extractOrder(rs);
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return orders;
    }

    @Override
    public int countPendingOrdersByMerchantId(Integer merchantId) {
        String sql = "SELECT COUNT(*) FROM `order` o " +
                    "JOIN order_item oi ON o.order_id = oi.order_id " +
                    "JOIN product p ON oi.product_id = p.product_id " +
                    "WHERE p.merchant_id = ? AND o.status = '待发货'";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, merchantId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }

    @Override
    public List<Order> findRecentOrdersByMerchantId(Integer merchantId, int limit) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT DISTINCT o.* FROM `order` o " +
                    "JOIN order_item oi ON o.order_id = oi.order_id " +
                    "JOIN product p ON oi.product_id = p.product_id " +
                    "WHERE p.merchant_id = ? " +
                    "ORDER BY o.order_date DESC LIMIT ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, merchantId);
            stmt.setInt(2, limit);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Order order = extractOrder(rs);
                loadOrderItems(order);
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return orders;
    }

    @Override
    public List<Order> findByMerchantId(Integer merchantId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.* FROM `order` o " +
                    "JOIN order_item oi ON o.order_id = oi.order_id " +
                    "JOIN product p ON oi.product_id = p.product_id " +
                    "WHERE p.merchant_id = ? " +
                    "GROUP BY o.order_id " +
                    "ORDER BY o.order_date DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, merchantId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Order order = extractOrder(rs);
                loadOrderItems(order);
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return orders;
    }

    @Override
    public Order getById(Integer orderId) {
        String sql = "SELECT * FROM `order` WHERE order_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setCustomerId(rs.getInt("customer_id"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setStatus(rs.getString("status"));
                order.setTotalAmount(rs.getBigDecimal("total_amount"));
                order.setShippingAddress(rs.getString("shipping_address"));
                
                // 获取订单项
                String itemsSql = "SELECT oi.*, p.name as product_name FROM order_item oi " +
                                "JOIN product p ON oi.product_id = p.product_id " +
                                "WHERE oi.order_id = ?";
                try (PreparedStatement itemsStmt = conn.prepareStatement(itemsSql)) {
                    itemsStmt.setInt(1, orderId);
                    ResultSet itemsRs = itemsStmt.executeQuery();
                    
                    List<OrderItem> items = new ArrayList<>();
                    while (itemsRs.next()) {
                        OrderItem item = new OrderItem();
                        item.setOrderId(orderId);
                        item.setProductId(itemsRs.getInt("product_id"));
                        item.setProductName(itemsRs.getString("product_name"));
                        item.setUnitPrice(itemsRs.getBigDecimal("price"));
                        item.setQuantity(itemsRs.getInt("quantity"));
                        items.add(item);
                    }
                    order.setOrderItems(items);
                }
                
                return order;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void updateStatus(Integer orderId, String status) {
        String sql = "UPDATE `order` SET status = ? WHERE order_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Order extractOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("order_id"));
        order.setCustomerId(rs.getInt("customer_id"));
        order.setOrderDate(rs.getTimestamp("order_date"));
        order.setStatus(rs.getString("status"));
        order.setTotalAmount(rs.getBigDecimal("total_amount"));
        order.setShippingAddress(rs.getString("shipping_address"));
        order.setOrderItems(new ArrayList<>()); // 初始化订单项列表
        return order;
    }

    private void loadOrderItems(Order order) {
        String sql = "SELECT oi.*, p.category as product_name, p.price as unit_price, p.merchant_id " +
                    "FROM order_item oi " +
                    "JOIN product p ON oi.product_id = p.product_id " +
                    "WHERE oi.order_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, order.getOrderId());
            ResultSet rs = stmt.executeQuery();
            
            List<OrderItem> orderItems = new ArrayList<>();
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setOrderItemId(rs.getInt("order_item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setUnitPrice(rs.getBigDecimal("price"));
                item.setProductName(rs.getString("product_name"));
                
                // 设置商品对象
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setCategory(rs.getString("product_name"));
                product.setPrice(rs.getBigDecimal("unit_price"));
                product.setMerchantId(rs.getInt("merchant_id"));
                item.setProduct(product);
                
                // Set the product image
                // product.setImage(rs.getString("image")); // Commented out image setting
                
                // 设置小计
                BigDecimal subtotal = item.getUnitPrice().multiply(new BigDecimal(item.getQuantity()));
                item.setSubtotal(subtotal);
                
                orderItems.add(item);
            }
            order.setOrderItems(orderItems);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
} 