package com.ecommerce.dao.impl;

import com.ecommerce.dao.ReturnDAO;
import com.ecommerce.model.Return;
import com.ecommerce.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReturnDAOImpl implements ReturnDAO {
    @Override
    public void save(Return returnRequest) {
        String sql = "INSERT INTO return_request (order_id, product_id, product_name, reason, status, create_time, update_time, merchant_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, returnRequest.getOrderId());
            stmt.setInt(2, returnRequest.getProductId());
            stmt.setString(3, returnRequest.getProductName());
            stmt.setString(4, returnRequest.getReason());
            stmt.setString(5, returnRequest.getStatus());
            stmt.setTimestamp(6, new Timestamp(returnRequest.getCreateTime().getTime()));
            stmt.setTimestamp(7, new Timestamp(returnRequest.getUpdateTime().getTime()));
            stmt.setInt(8, returnRequest.getMerchantId());
            
            stmt.executeUpdate();
            
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    returnRequest.setReturnId(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Return returnRequest) {
        String sql = "UPDATE return_request SET status = ?, update_time = ? WHERE return_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, returnRequest.getStatus());
            stmt.setTimestamp(2, new Timestamp(returnRequest.getUpdateTime().getTime()));
            stmt.setInt(3, returnRequest.getReturnId());
            
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Return findById(Integer returnId) {
        String sql = "SELECT * FROM return_request WHERE return_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, returnId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractReturn(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    @Override
    public List<Return> findByOrderId(Integer orderId) {
        List<Return> returns = new ArrayList<>();
        String sql = "SELECT * FROM return_request WHERE order_id = ? ORDER BY create_time DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                returns.add(extractReturn(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return returns;
    }

    @Override
    public List<Return> findByMerchantId(Integer merchantId) {
        List<Return> returns = new ArrayList<>();
        String sql = "SELECT * FROM return_request WHERE merchant_id = ? ORDER BY create_time DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, merchantId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                returns.add(extractReturn(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return returns;
    }

    @Override
    public List<Return> findByCustomerId(Integer customerId) {
        List<Return> returns = new ArrayList<>();
        String sql = "SELECT r.* FROM return_request r " +
                    "JOIN `order` o ON r.order_id = o.order_id " +
                    "WHERE o.customer_id = ? " +
                    "ORDER BY r.create_time DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                returns.add(extractReturn(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return returns;
    }

    @Override
    public List<Return> findAll() {
        List<Return> returns = new ArrayList<>();
        String sql = "SELECT * FROM return_request ORDER BY create_time DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                returns.add(extractReturn(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return returns;
    }

    @Override
    public boolean canTransitionStatus(String currentStatus, String newStatus) {
        // 定义状态转换规则
        if ("待处理".equals(currentStatus)) {
            return "已同意".equals(newStatus) || "已拒绝".equals(newStatus);
        }
        return false;
    }

    private Return extractReturn(ResultSet rs) throws SQLException {
        Return returnRequest = new Return();
        returnRequest.setReturnId(rs.getInt("return_id"));
        returnRequest.setOrderId(rs.getInt("order_id"));
        returnRequest.setProductId(rs.getInt("product_id"));
        returnRequest.setProductName(rs.getString("product_name"));
        returnRequest.setReason(rs.getString("reason"));
        returnRequest.setStatus(rs.getString("status"));
        returnRequest.setCreateTime(rs.getTimestamp("create_time"));
        returnRequest.setUpdateTime(rs.getTimestamp("update_time"));
        returnRequest.setMerchantId(rs.getInt("merchant_id"));
        return returnRequest;
    }
} 