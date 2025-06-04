package com.ecommerce.dao.impl;

import com.ecommerce.dao.CartDAO;
import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.CartItem;
import com.ecommerce.model.Product;
import com.ecommerce.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAOImpl implements CartDAO {
    private ProductDAO productDAO;

    public CartDAOImpl() {
        this.productDAO = new ProductDAOImpl();
    }

    @Override
    public void addItem(CartItem item) {
        // 首先检查商品是否已在购物车中
        String checkSql = "SELECT * FROM shopping_cart WHERE customer_id = ? AND product_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            
            checkStmt.setInt(1, item.getCustomerId());
            checkStmt.setInt(2, item.getProductId());
            ResultSet rs = checkStmt.executeQuery();
            
            if (rs.next()) {
                // 商品已在购物车中，更新数量
                int currentQuantity = rs.getInt("quantity");
                int newQuantity = currentQuantity + item.getQuantity();
                updateQuantity(rs.getInt("cart_id"), newQuantity);
                item.setCartItemId(rs.getInt("cart_id"));
            } else {
                // 商品不在购物车中，添加新记录
                String insertSql = "INSERT INTO shopping_cart (customer_id, product_id, quantity) VALUES (?, ?, ?)";
                try (PreparedStatement insertStmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
                    insertStmt.setInt(1, item.getCustomerId());
                    insertStmt.setInt(2, item.getProductId());
                    insertStmt.setInt(3, item.getQuantity());
                    
                    insertStmt.executeUpdate();
                    
                    ResultSet generatedKeys = insertStmt.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        item.setCartItemId(generatedKeys.getInt(1));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("添加商品到购物车失败", e);
        }
    }

    @Override
    public void updateQuantity(Integer cartItemId, Integer quantity) {
        String sql = "UPDATE shopping_cart SET quantity = ? WHERE cart_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, quantity);
            stmt.setInt(2, cartItemId);
            
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void removeItem(Integer cartItemId) {
        String sql = "DELETE FROM shopping_cart WHERE cart_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, cartItemId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<CartItem> getCustomerCart(Integer customerId) {
        List<CartItem> items = new ArrayList<>();
        String sql = "SELECT * FROM shopping_cart WHERE customer_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                CartItem item = extractCartItem(rs);
                item.setProduct(productDAO.getById(item.getProductId()));
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    @Override
    public CartItem getItem(Integer cartItemId) {
        String sql = "SELECT * FROM shopping_cart WHERE cart_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, cartItemId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                CartItem item = extractCartItem(rs);
                item.setProduct(productDAO.getById(item.getProductId()));
                return item;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void clearCart(Integer customerId) {
        String sql = "DELETE FROM shopping_cart WHERE customer_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, customerId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private CartItem extractCartItem(ResultSet rs) throws SQLException {
        CartItem item = new CartItem();
        item.setCartItemId(rs.getInt("cart_id"));
        item.setCustomerId(rs.getInt("customer_id"));
        item.setProductId(rs.getInt("product_id"));
        item.setQuantity(rs.getInt("quantity"));
        // 从商品表中获取价格
        Product product = productDAO.getById(item.getProductId());
        if (product != null) {
            item.setPrice(product.getPrice());
        }
        return item;
    }
} 