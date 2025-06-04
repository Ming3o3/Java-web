package com.ecommerce.dao;

import com.ecommerce.model.Return;
import java.util.List;

public interface ReturnDAO {
    void save(Return returnRequest);
    void update(Return returnRequest);
    Return findById(Integer returnId);
    List<Return> findByOrderId(Integer orderId);
    List<Return> findByMerchantId(Integer merchantId);
    List<Return> findByCustomerId(Integer customerId);
    List<Return> findAll();
    boolean canTransitionStatus(String currentStatus, String newStatus);
} 