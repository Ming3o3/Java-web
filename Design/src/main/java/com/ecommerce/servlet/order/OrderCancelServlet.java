package com.ecommerce.servlet.order;

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

@WebServlet("/order/cancel")
public class OrderCancelServlet extends HttpServlet {
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAOImpl();
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
            Integer orderId = Integer.parseInt(request.getParameter("orderId"));
            Order order = orderDAO.findById(orderId);
            
            if (order != null && order.getCustomerId().equals(customer.getCustomerId())) {
                if (!"待发货".equals(order.getStatus())) {
                    session.setAttribute("error", "只能取消待发货的订单");
                    response.sendRedirect(request.getContextPath() + "/order/list");
                    return;
                }

                order.setStatus("已取消");
                orderDAO.update(order);
                
                response.sendRedirect(request.getContextPath() + "/order/list");
            } else {
                session.setAttribute("error", "订单不存在或无权操作");
                response.sendRedirect(request.getContextPath() + "/order/list");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "无效的订单ID");
            response.sendRedirect(request.getContextPath() + "/order/list");
        } catch (Exception e) {
            session.setAttribute("error", "取消订单失败：" + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/order/list");
        }
    }
} 