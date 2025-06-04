package com.ecommerce.servlet;

import com.ecommerce.dao.OrderDAO;
import com.ecommerce.dao.ReturnGoodsDAO;
import com.ecommerce.dao.impl.OrderDAOImpl;
import com.ecommerce.dao.impl.ReturnGoodsDAOImpl;
import com.ecommerce.model.Customer;
import com.ecommerce.model.Order;
import com.ecommerce.model.OrderItem;
import com.ecommerce.model.ReturnGoods;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet(name = "ReturnApplyServlet", urlPatterns = {"/return/apply"})
public class ReturnApplyServlet extends HttpServlet {
    private OrderDAO orderDAO;
    private ReturnGoodsDAO returnGoodsDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAOImpl();
        returnGoodsDAO = new ReturnGoodsDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            Order order = orderDAO.findById(orderId);
            
            if (order == null || order.getCustomerId() != customer.getCustomerId()) {
                request.setAttribute("error", "订单不存在或无权操作");
                request.getRequestDispatcher("/WEB-INF/views/order/list.jsp").forward(request, response);
                return;
            }

            if (!"已发货".equals(order.getStatus())) {
                request.setAttribute("error", "只有已发货的订单才能申请退货");
                request.getRequestDispatcher("/WEB-INF/views/order/list.jsp").forward(request, response);
                return;
            }

            // 检查是否已经申请过退货
            List<ReturnGoods> existingReturns = returnGoodsDAO.findByCustomerId(customer.getCustomerId());
            for (ReturnGoods existingReturn : existingReturns) {
                if (existingReturn.getOrderId().equals(orderId)) {
                    request.setAttribute("error", "该订单已经申请过退货");
                    request.getRequestDispatcher("/WEB-INF/views/order/list.jsp").forward(request, response);
                    return;
                }
            }

            request.setAttribute("order", order);
            request.getRequestDispatcher("/WEB-INF/views/return/apply.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "无效的订单ID");
            request.getRequestDispatcher("/WEB-INF/views/order/list.jsp").forward(request, response);
        }
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
            String returnReason = request.getParameter("returnReason");
            
            if (returnReason == null || returnReason.trim().isEmpty()) {
                request.setAttribute("error", "请填写退货原因");
                Order order = orderDAO.findById(orderId);
                request.setAttribute("order", order);
                request.getRequestDispatcher("/WEB-INF/views/return/apply.jsp").forward(request, response);
                return;
            }

            Order order = orderDAO.findById(orderId);
            
            if (order == null || order.getCustomerId() != customer.getCustomerId()) {
                request.setAttribute("error", "订单不存在或无权操作");
                request.getRequestDispatcher("/WEB-INF/views/order/list.jsp").forward(request, response);
                return;
            }

            if (!"已发货".equals(order.getStatus())) {
                request.setAttribute("error", "订单状态不正确");
                request.getRequestDispatcher("/WEB-INF/views/order/list.jsp").forward(request, response);
                return;
            }

            // 检查是否已经申请过退货
            List<ReturnGoods> existingReturns = returnGoodsDAO.findByCustomerId(customer.getCustomerId());
            for (ReturnGoods existingReturn : existingReturns) {
                if (existingReturn.getOrderId().equals(orderId)) {
                    request.setAttribute("error", "该订单已经申请过退货");
                    request.getRequestDispatcher("/WEB-INF/views/order/list.jsp").forward(request, response);
                    return;
                }
            }

            // 为订单中的每个商品创建退货申请
            for (OrderItem item : order.getOrderItems()) {
                ReturnGoods returnGoods = new ReturnGoods();
                returnGoods.setCustomerId(customer.getCustomerId());
                returnGoods.setOrderId(orderId);
                returnGoods.setProductId(item.getProductId());
                returnGoods.setReturnTime(new Date());
                returnGoods.setStatus("待处理");
                returnGoods.setReason(returnReason);
                returnGoodsDAO.save(returnGoods);
            }

            // 更新订单状态为"退货中"
            order.setStatus("退货中");
            orderDAO.update(order);
            
            response.sendRedirect(request.getContextPath() + "/order/list");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "无效的订单ID");
            request.getRequestDispatcher("/WEB-INF/views/order/list.jsp").forward(request, response);
        }
    }
} 