package com.ecommerce.servlet;

import com.ecommerce.dao.OrderDAO;
import com.ecommerce.dao.impl.OrderDAOImpl;
import com.ecommerce.model.Merchant;
import com.ecommerce.model.Order;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/merchant/orders")
public class MerchantOrderServlet extends HttpServlet {
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Merchant merchant = (Merchant) session.getAttribute("merchant");
        
        if (merchant == null) {
            response.sendRedirect(request.getContextPath() + "/merchant/login");
            return;
        }

        try {
            // 获取商家的所有订单
            List<Order> orders = orderDAO.findByMerchantId(merchant.getMerchantId());
            request.setAttribute("orders", orders);
            
            // 转发到订单列表页面
            request.getRequestDispatcher("/WEB-INF/views/merchant/orders.jsp").forward(request, response);
        } catch (Exception e) {
            // 如果发生错误，设置错误信息
            request.setAttribute("error", "获取订单列表失败：" + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/merchant/orders.jsp").forward(request, response);
        }
    }
} 