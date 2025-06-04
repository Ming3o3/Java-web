package com.ecommerce.dao;

import com.ecommerce.model.Merchant;
import java.util.List;

public interface MerchantDAO {
    void save(Merchant merchant);
    void update(Merchant merchant);
    void delete(Integer merchantId);
    Merchant findById(Integer merchantId);
    Merchant findByStoreName(String storeName);
    List<Merchant> findAll();
    List<Merchant> search(String keyword);
} 