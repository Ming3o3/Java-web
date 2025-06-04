package com.ecommerce.dao;

import com.ecommerce.model.CartItem;
import java.util.List;

public interface CartDAO {
    void addItem(CartItem item);
    void updateQuantity(Integer cartItemId, Integer quantity);
    void removeItem(Integer cartItemId);
    List<CartItem> getCustomerCart(Integer customerId);
    CartItem getItem(Integer cartItemId);
    void clearCart(Integer customerId);
} 