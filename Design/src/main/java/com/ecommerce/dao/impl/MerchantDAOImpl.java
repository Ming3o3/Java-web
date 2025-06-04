package com.ecommerce.dao.impl;

import com.ecommerce.dao.MerchantDAO;
import com.ecommerce.model.Merchant;
import com.ecommerce.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MerchantDAOImpl implements MerchantDAO {
    @Override
    public void save(Merchant merchant) {
        String sql = "INSERT INTO merchant (store_name, contact_info, address, password, name) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, merchant.getStoreName());
            stmt.setString(2, merchant.getContactInfo());
            stmt.setString(3, merchant.getAddress());
            stmt.setString(4, merchant.getPassword());
            stmt.setString(5, merchant.getName());
            
            stmt.executeUpdate();
            
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    merchant.setMerchantId(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Merchant merchant) {
        String sql = "UPDATE merchant SET store_name = ?, contact_info = ?, address = ?, password = ?, name = ? WHERE merchant_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, merchant.getStoreName());
            stmt.setString(2, merchant.getContactInfo());
            stmt.setString(3, merchant.getAddress());
            stmt.setString(4, merchant.getPassword());
            stmt.setString(5, merchant.getName());
            stmt.setInt(6, merchant.getMerchantId());
            
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(Integer merchantId) {
        String sql = "DELETE FROM merchant WHERE merchant_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, merchantId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Merchant findById(Integer merchantId) {
        String sql = "SELECT * FROM merchant WHERE merchant_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, merchantId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractMerchant(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    @Override
    public Merchant findByStoreName(String storeName) {
        String sql = "SELECT * FROM merchant WHERE store_name = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, storeName);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractMerchant(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    @Override
    public List<Merchant> findAll() {
        List<Merchant> merchants = new ArrayList<>();
        String sql = "SELECT * FROM merchant";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                merchants.add(extractMerchant(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return merchants;
    }

    @Override
    public List<Merchant> search(String keyword) {
        List<Merchant> merchants = new ArrayList<>();
        String sql = "SELECT * FROM merchant WHERE store_name LIKE ? OR contact_info LIKE ? OR address LIKE ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String pattern = "%" + keyword + "%";
            stmt.setString(1, pattern);
            stmt.setString(2, pattern);
            stmt.setString(3, pattern);
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                merchants.add(extractMerchant(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return merchants;
    }

    private Merchant extractMerchant(ResultSet rs) throws SQLException {
        Merchant merchant = new Merchant();
        merchant.setMerchantId(rs.getInt("merchant_id"));
        merchant.setStoreName(rs.getString("store_name"));
        merchant.setContactInfo(rs.getString("contact_info"));
        merchant.setAddress(rs.getString("address"));
        merchant.setPassword(rs.getString("password"));
        merchant.setName(rs.getString("name"));
        return merchant;
    }
} 