package com.ecommerce.dao;

import com.ecommerce.model.Product;
import java.util.List;

public interface ProductDAO {
    Product getById(Integer productId);
    List<Product> getAll();
    List<Product> getByCategory(String category);
    List<Product> getByMerchant(Integer merchantId);
    void save(Product product);
    void update(Product product);
    void delete(Integer productId);
    List<Product> search(String keyword);
    List<Product> getAllProducts();
    void updateStock(int productId, int quantity);
    int countByMerchantId(Integer merchantId);
    /**
     * 根据商家ID查询所有商品
     * @param merchantId 商家ID
     * @return 商品列表
     */
    List<Product> findByMerchantId(Integer merchantId);
    
    /**
     * 根据排序方式获取商品列表
     * @param sortType 排序方式（price_asc, price_desc, name_asc, name_desc）
     * @return 排序后的商品列表
     */
    List<Product> getSortedProducts(String sortType);
    
    /**
     * 搜索并排序商品
     * @param keyword 搜索关键词
     * @param sortType 排序方式
     * @return 搜索并排序后的商品列表
     */
    List<Product> searchAndSort(String keyword, String sortType);
} 