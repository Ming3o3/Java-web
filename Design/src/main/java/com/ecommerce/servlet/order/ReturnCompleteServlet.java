package com.ecommerce.servlet.order;

import com.ecommerce.dao.OrderDAO;
import com.ecommerce.dao.ReturnGoodsDAO;
import com.ecommerce.dao.impl.OrderDAOImpl;
import com.ecommerce.dao.impl.ReturnGoodsDAOImpl;
import com.ecommerce.model.Customer;
import com.ecommerce.model.Order;
import com.ecommerce.model.ReturnGoods;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/order/return/complete")
public class ReturnCompleteServlet extends HttpServlet {
    private ReturnGoodsDAO returnGoodsDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        returnGoodsDAO = new ReturnGoodsDAOImpl();
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

        ReturnGoods returnGoods = null;
        try {
            Integer returnId = Integer.parseInt(request.getParameter("returnId"));
            returnGoods = returnGoodsDAO.findById(returnId);
            
            if (returnGoods != null && "已同意".equals(returnGoods.getStatus())) {
                // 更新退货状态
                returnGoods.setStatus("已完成");
                returnGoodsDAO.update(returnGoods);
                
                // 更新订单状态
                Order order = orderDAO.findById(returnGoods.getOrderId());
                if (order != null) {
                    order.setStatus("已退货");
                    orderDAO.update(order);
                }
                
                response.sendRedirect(request.getContextPath() + "/order/detail?id=" + returnGoods.getOrderId());
            } else {
                response.sendRedirect(request.getContextPath() + "/order/list");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/order/list");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/order/list");
        }
    }
} 