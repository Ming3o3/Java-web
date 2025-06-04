package com.ecommerce.dao;

import com.ecommerce.model.ReturnGoods;
import java.util.List;

public interface ReturnGoodsDAO {
    void save(ReturnGoods returnGoods);
    void update(ReturnGoods returnGoods);
    void delete(Integer returnId);
    ReturnGoods findById(Integer returnId);
    List<ReturnGoods> findAll();
    List<ReturnGoods> findByCustomerId(Integer customerId);
    List<ReturnGoods> findByOrderId(Integer orderId);
    List<ReturnGoods> findByProductId(Integer productId);
    List<ReturnGoods> findByStatus(String status);
    /**
     * 根据商家ID查询所有退货申请
     * @param merchantId 商家ID
     * @return 退货申请列表
     */
    List<ReturnGoods> findByMerchantId(Integer merchantId);
    int countPendingReturnsByMerchantId(Integer merchantId);
} 