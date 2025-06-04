package com.ecommerce.dao.impl;

import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.Product;
import com.ecommerce.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Comparator;

public class ProductDAOImpl implements ProductDAO {
    
    @Override
    public Product getById(Integer productId) {
        String sql = "SELECT * FROM product WHERE product_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractProduct(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    @Override
    public List<Product> getAll() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM product";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                products.add(extractProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    @Override
    public List<Product> getByCategory(String category) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM product WHERE category = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, category);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                products.add(extractProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    @Override
    public List<Product> getByMerchant(Integer merchantId) {
        return findByMerchantId(merchantId);
    }
    
    @Override
    public void save(Product product) {
        String sql = "INSERT INTO product (merchant_id, price, quantity, category, image) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, product.getMerchantId());
            stmt.setBigDecimal(2, product.getPrice());
            stmt.setInt(3, product.getQuantity());
            stmt.setString(4, product.getCategory());
            stmt.setString(5, product.getImage());
            
            stmt.executeUpdate();
            
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                product.setProductId(rs.getInt(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    @Override
    public void update(Product product) {
        String sql = "UPDATE product SET merchant_id = ?, price = ?, quantity = ?, category = ?, image = ? WHERE product_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, product.getMerchantId());
            stmt.setBigDecimal(2, product.getPrice());
            stmt.setInt(3, product.getQuantity());
            stmt.setString(4, product.getCategory());
            stmt.setString(5, product.getImage());
            stmt.setInt(6, product.getProductId());
            
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    @Override
    public void delete(Integer productId) {
        String sql = "DELETE FROM product WHERE product_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, productId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    @Override
    public List<Product> search(String keyword) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM product WHERE category LIKE ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    products.add(extractProduct(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return products;
    }
    
    @Override
    public List<Product> getAllProducts() {
        return getAll();
    }
    
    @Override
    public void updateStock(int productId, int quantity) {
        String sql = "UPDATE product SET quantity = quantity - ? WHERE product_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, quantity);
            stmt.setInt(2, productId);
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    @Override
    public int countByMerchantId(Integer merchantId) {
        String sql = "SELECT COUNT(*) FROM product WHERE merchant_id = ?";
        
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
    public List<Product> findByMerchantId(Integer merchantId) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM product WHERE merchant_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, merchantId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                products.add(extractProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return products;
    }
    
    @Override
    public List<Product> getSortedProducts(String sortType) {
        List<Product> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM product");
        
        if (sortType != null && !sortType.equals("default")) {
            sql.append(" ORDER BY ");
            switch (sortType) {
                case "price_asc":
                    sql.append("price ASC");
                    break;
                case "price_desc":
                    sql.append("price DESC");
                    break;
                case "name_asc":
                    sql.append("category ASC");
                    break;
                case "name_desc":
                    sql.append("category DESC");
                    break;
            }
        }
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql.toString())) {
            
            while (rs.next()) {
                products.add(extractProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    @Override
    public List<Product> searchAndSort(String keyword, String sortType) {
        List<Product> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM product WHERE category LIKE ?");
        
        if (sortType != null && !sortType.equals("default")) {
            sql.append(" ORDER BY ");
            switch (sortType) {
                case "price_asc":
                    sql.append("price ASC");
                    break;
                case "price_desc":
                    sql.append("price DESC");
                    break;
                case "name_asc":
                    sql.append("category ASC");
                    break;
                case "name_desc":
                    sql.append("category DESC");
                    break;
            }
        }
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            
            stmt.setString(1, "%" + keyword + "%");
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                products.add(extractProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    private Product extractProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setProductId(rs.getInt("product_id"));
        product.setMerchantId(rs.getInt("merchant_id"));
        product.setPrice(rs.getBigDecimal("price"));
        product.setQuantity(rs.getInt("quantity"));
        product.setCategory(rs.getString("category"));
        product.setImage(rs.getString("image"));
        return product;
    }
} 