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

@WebServlet("/order")
public class OrderServlet extends HttpServlet {
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
        // 重定向到订单列表页面
        response.sendRedirect(request.getContextPath() + "/order/list");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void showOrderDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String orderId = request.getParameter("id");
        
        if (orderId == null || orderId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "订单ID不能为空");
            return;
        }

        try {
            Order order = orderDAO.findById(Integer.parseInt(orderId));
            
            if (order == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "订单不存在");
                return;
            }

            request.setAttribute("order", order);
            request.getRequestDispatcher("/WEB-INF/views/order/detail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "无效的订单ID");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "获取订单详情失败：" + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/order/detail.jsp").forward(request, response);
        }
    }

    private void cancelOrder(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String orderId = request.getParameter("orderId");
        
        if (orderId == null || orderId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "订单ID不能为空");
            return;
        }

        try {
            Order order = orderDAO.findById(Integer.parseInt(orderId));
            
            if (order == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "订单不存在");
                return;
            }

            if (!order.getStatus().equals("待发货")) {
                request.setAttribute("error", "只能取消待发货的订单");
                request.getRequestDispatcher("/WEB-INF/views/order/list.jsp").forward(request, response);
                return;
            }

            order.setStatus("已取消");
            orderDAO.update(order);
            
            response.sendRedirect(request.getContextPath() + "/order/list");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "无效的订单ID");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "取消订单失败：" + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/order/list.jsp").forward(request, response);
        }
    }
} 