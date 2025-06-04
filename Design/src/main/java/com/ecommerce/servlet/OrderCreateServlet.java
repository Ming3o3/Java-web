package com.ecommerce.servlet;

import com.ecommerce.dao.CartDAO;
import com.ecommerce.dao.OrderDAO;
import com.ecommerce.dao.impl.CartDAOImpl;
import com.ecommerce.dao.impl.OrderDAOImpl;
import com.ecommerce.model.CartItem;
import com.ecommerce.model.Customer;
import com.ecommerce.model.Order;
import com.ecommerce.model.OrderItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/order/create")
public class OrderCreateServlet extends HttpServlet {
    private OrderDAO orderDAO;
    private CartDAO cartDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAOImpl();
        cartDAO = new CartDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        List<CartItem> cartItems = cartDAO.getCustomerCart(customer.getCustomerId());
        if (cartItems.isEmpty()) {
            request.setAttribute("error", "购物车为空，无法创建订单");
            request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
            return;
        }
        
        request.setAttribute("cartItems", cartItems);
        request.getRequestDispatcher("/WEB-INF/views/order/create.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            List<CartItem> cartItems = cartDAO.getCustomerCart(customer.getCustomerId());
            if (cartItems.isEmpty()) {
                request.setAttribute("error", "购物车为空，无法创建订单");
                request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
                return;
            }
            
            // 创建订单
            Order order = new Order();
            order.setCustomerId(customer.getCustomerId());
            order.setOrderDate(new Date());
            order.setStatus("待发货");
            order.setShippingAddress(customer.getShippingAddress());
            
            // 计算总金额并创建订单项
            BigDecimal totalAmount = BigDecimal.ZERO;
            List<OrderItem> orderItems = new ArrayList<>();
            
            for (CartItem cartItem : cartItems) {
                OrderItem orderItem = new OrderItem();
                orderItem.setProductId(cartItem.getProductId());
                orderItem.setQuantity(cartItem.getQuantity());
                orderItem.setUnitPrice(cartItem.getProduct().getPrice());
                orderItem.setSubtotal(cartItem.getProduct().getPrice().multiply(new BigDecimal(cartItem.getQuantity())));
                orderItems.add(orderItem);
                
                totalAmount = totalAmount.add(cartItem.getProduct().getPrice().multiply(new BigDecimal(cartItem.getQuantity())));
            }
            
            order.setTotalAmount(totalAmount);
            order.setOrderItems(orderItems);
            
            // 保存订单
            orderDAO.save(order);
            
            // 清空购物车
            cartDAO.clearCart(customer.getCustomerId());
            
            response.sendRedirect(request.getContextPath() + "/order/list");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "创建订单失败：" + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
        }
    }
} 