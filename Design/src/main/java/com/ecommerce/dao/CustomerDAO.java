package com.ecommerce.dao;

import com.ecommerce.model.Customer;
import java.util.List;

public interface CustomerDAO {
    void save(Customer customer);
    Customer findById(Integer customerId);
    Customer findByUsername(String username);
    List<Customer> findAll();
    void update(Customer customer);
    void delete(Integer customerId);
    Customer login(String username, String password);
} 