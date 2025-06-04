package com.ecommerce.servlet;

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
import java.util.List;

@WebServlet(name = "ReturnConfirmServlet", urlPatterns = {"/return/confirm"})
public class ReturnConfirmServlet extends HttpServlet {
    private OrderDAO orderDAO;
    private ReturnGoodsDAO returnGoodsDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAOImpl();
        returnGoodsDAO = new ReturnGoodsDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String action = request.getParameter("action");
            
            Order order = orderDAO.findById(orderId);
            
            if (order == null || order.getCustomerId() != customer.getCustomerId()) {
                request.setAttribute("error", "订单不存在或无权操作");
                request.getRequestDispatcher("/WEB-INF/views/order/list.jsp").forward(request, response);
                return;
            }

            if ("confirm".equals(action) && "同意退货".equals(order.getStatus())) {
                // 更新订单状态为"已退货"
                order.setStatus("已退货");
                orderDAO.update(order);
                
                // 更新退货记录状态
                List<ReturnGoods> returns = returnGoodsDAO.findByOrderId(orderId);
                for (ReturnGoods returnGoods : returns) {
                    returnGoods.setStatus("已完成");
                    returnGoodsDAO.update(returnGoods);
                }
            } else if ("reject".equals(action) && "拒绝退货".equals(order.getStatus())) {
                // 更新订单状态为"已完成"
                order.setStatus("已完成");
                orderDAO.update(order);
                
                // 更新退货记录状态
                List<ReturnGoods> returns = returnGoodsDAO.findByOrderId(orderId);
                for (ReturnGoods returnGoods : returns) {
                    returnGoods.setStatus("已拒绝");
                    returnGoodsDAO.update(returnGoods);
                }
            } else {
                request.setAttribute("error", "订单状态不正确");
                request.getRequestDispatcher("/WEB-INF/views/order/list.jsp").forward(request, response);
                return;
            }
            
            response.sendRedirect(request.getContextPath() + "/order/list");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "无效的订单ID");
            request.getRequestDispatcher("/WEB-INF/views/order/list.jsp").forward(request, response);
        }
    }
} 