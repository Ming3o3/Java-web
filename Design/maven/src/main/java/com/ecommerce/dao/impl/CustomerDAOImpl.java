package com.ecommerce.dao.impl;

import com.ecommerce.dao.CustomerDAO;
import com.ecommerce.model.Customer;
import com.ecommerce.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAOImpl implements CustomerDAO {
    
    @Override
    public Customer findById(Integer customerId) {
        String sql = "SELECT * FROM customer WHERE customer_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractCustomer(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    @Override
    public List<Customer> findAll() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customer";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                customers.add(extractCustomer(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }
    
    @Override
    public void save(Customer customer) {
        String sql = "INSERT INTO customer (nickname, contact_info, shipping_address, password, name) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, customer.getNickname());
            stmt.setString(2, customer.getContactInfo());
            stmt.setString(3, customer.getShippingAddress());
            stmt.setString(4, customer.getPassword());
            stmt.setString(5, customer.getName());
            
            stmt.executeUpdate();
            
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                customer.setCustomerId(rs.getInt(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error saving customer", e);
        }
    }
    
    @Override
    public void update(Customer customer) {
        String sql = "UPDATE customer SET nickname = ?, contact_info = ?, shipping_address = ?, password = ?, name = ? WHERE customer_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, customer.getNickname());
            stmt.setString(2, customer.getContactInfo());
            stmt.setString(3, customer.getShippingAddress());
            stmt.setString(4, customer.getPassword());
            stmt.setString(5, customer.getName());
            stmt.setInt(6, customer.getCustomerId());
            
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error updating customer", e);
        }
    }
    
    @Override
    public void delete(Integer customerId) {
        String sql = "DELETE FROM customer WHERE customer_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, customerId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error deleting customer", e);
        }
    }
    
    @Override
    public Customer findByUsername(String username) {
        String sql = "SELECT * FROM customer WHERE nickname = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractCustomer(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Customer login(String username, String password) {
        String sql = "SELECT * FROM customer WHERE nickname = ? AND password = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractCustomer(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    private Customer extractCustomer(ResultSet rs) throws SQLException {
        Customer customer = new Customer();
        customer.setCustomerId(rs.getInt("customer_id"));
        customer.setNickname(rs.getString("nickname"));
        customer.setContactInfo(rs.getString("contact_info"));
        customer.setShippingAddress(rs.getString("shipping_address"));
        customer.setPassword(rs.getString("password"));
        customer.setName(rs.getString("name"));
        return customer;
    }
} 