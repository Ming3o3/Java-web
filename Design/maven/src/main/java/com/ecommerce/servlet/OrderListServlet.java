package com.ecommerce.servlet;

import com.ecommerce.dao.OrderDAO;
import com.ecommerce.dao.impl.OrderDAOImpl;
import com.ecommerce.model.Customer;
import com.ecommerce.model.Order;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/order/list")
public class OrderListServlet extends HttpServlet {
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 获取当前登录用户
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            // 如果用户未登录，重定向到登录页面
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // 获取用户的订单列表
            List<Order> orders = orderDAO.findByCustomerId(customer.getCustomerId());
            
            // 将订单列表设置到请求属性中
            request.setAttribute("orders", orders);
            
            // 转发到订单列表页面
            request.getRequestDispatcher("/WEB-INF/views/order/list.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "加载订单列表失败：" + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/order/list.jsp").forward(request, response);
        }
    }
} 