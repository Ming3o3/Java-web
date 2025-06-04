package com.ecommerce.dao.impl;

import com.ecommerce.dao.ReturnGoodsDAO;
import com.ecommerce.model.ReturnGoods;
import com.ecommerce.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReturnGoodsDAOImpl implements ReturnGoodsDAO {
    @Override
    public void save(ReturnGoods returnGoods) {
        String sql = "INSERT INTO return_goods (customer_id, product_id, order_id, return_time, status, reason) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, returnGoods.getCustomerId());
            stmt.setInt(2, returnGoods.getProductId());
            stmt.setInt(3, returnGoods.getOrderId());
            stmt.setTimestamp(4, new Timestamp(returnGoods.getReturnTime().getTime()));
            stmt.setString(5, returnGoods.getStatus());
            stmt.setString(6, returnGoods.getReason());
            
            stmt.executeUpdate();
            
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    returnGoods.setReturnId(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(ReturnGoods returnGoods) {
        String sql = "UPDATE return_goods SET status = ?, reason = ? WHERE return_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, returnGoods.getStatus());
            stmt.setString(2, returnGoods.getReason());
            stmt.setInt(3, returnGoods.getReturnId());
            
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(Integer returnId) {
        String sql = "DELETE FROM return_goods WHERE return_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, returnId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public ReturnGoods findById(Integer returnId) {
        String sql = "SELECT * FROM return_goods WHERE return_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, returnId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractReturnGoods(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    @Override
    public List<ReturnGoods> findByCustomerId(Integer customerId) {
        List<ReturnGoods> returns = new ArrayList<>();
        String sql = "SELECT * FROM return_goods WHERE customer_id = ? ORDER BY return_time DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                returns.add(extractReturnGoods(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return returns;
    }

    @Override
    public List<ReturnGoods> findByMerchantId(Integer merchantId) {
        List<ReturnGoods> returns = new ArrayList<>();
        String sql = "SELECT rg.* FROM return_goods rg " +
                    "JOIN product p ON rg.product_id = p.product_id " +
                    "WHERE p.merchant_id = ? " +
                    "ORDER BY rg.return_time DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, merchantId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                ReturnGoods returnGoods = new ReturnGoods();
                returnGoods.setReturnId(rs.getInt("return_id"));
                returnGoods.setCustomerId(rs.getInt("customer_id"));
                returnGoods.setProductId(rs.getInt("product_id"));
                returnGoods.setOrderId(rs.getInt("order_id"));
                returnGoods.setReturnTime(rs.getTimestamp("return_time"));
                returnGoods.setStatus(rs.getString("status"));
                returnGoods.setReason(rs.getString("reason"));
                returns.add(returnGoods);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return returns;
    }

    @Override
    public List<ReturnGoods> findAll() {
        List<ReturnGoods> returns = new ArrayList<>();
        String sql = "SELECT * FROM return_goods ORDER BY return_time DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                returns.add(extractReturnGoods(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return returns;
    }

    @Override
    public int countPendingReturnsByMerchantId(Integer merchantId) {
        String sql = "SELECT COUNT(*) FROM return_goods rg " +
                    "JOIN product p ON rg.product_id = p.product_id " +
                    "WHERE p.merchant_id = ? AND rg.status = '待处理'";
        
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
    public List<ReturnGoods> findByStatus(String status) {
        List<ReturnGoods> returns = new ArrayList<>();
        String sql = "SELECT * FROM return_goods WHERE status = ? ORDER BY return_time DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                returns.add(extractReturnGoods(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return returns;
    }

    @Override
    public List<ReturnGoods> findByProductId(Integer productId) {
        List<ReturnGoods> returns = new ArrayList<>();
        String sql = "SELECT * FROM return_goods WHERE product_id = ? ORDER BY return_time DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                returns.add(extractReturnGoods(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return returns;
    }

    @Override
    public List<ReturnGoods> findByOrderId(Integer orderId) {
        List<ReturnGoods> returns = new ArrayList<>();
        String sql = "SELECT * FROM return_goods WHERE order_id = ? ORDER BY return_time DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                returns.add(extractReturnGoods(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return returns;
    }

    private ReturnGoods extractReturnGoods(ResultSet rs) throws SQLException {
        ReturnGoods returnGoods = new ReturnGoods();
        returnGoods.setReturnId(rs.getInt("return_id"));
        returnGoods.setCustomerId(rs.getInt("customer_id"));
        returnGoods.setProductId(rs.getInt("product_id"));
        returnGoods.setOrderId(rs.getInt("order_id"));
        returnGoods.setReturnTime(rs.getTimestamp("return_time"));
        returnGoods.setStatus(rs.getString("status"));
        returnGoods.setReason(rs.getString("reason"));
        return returnGoods;
    }
} 