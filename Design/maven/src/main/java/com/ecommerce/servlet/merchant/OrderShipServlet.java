package com.ecommerce.servlet.merchant;

import com.ecommerce.dao.OrderDAO;
import com.ecommerce.dao.impl.OrderDAOImpl;
import com.ecommerce.model.Merchant;
import com.ecommerce.model.Order;
import com.ecommerce.model.OrderItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/merchant/order/ship")
public class OrderShipServlet extends HttpServlet {
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Merchant merchant = (Merchant) session.getAttribute("merchant");
        
        if (merchant == null) {
            response.sendRedirect(request.getContextPath() + "/merchant/login");
            return;
        }

        try {
            // 获取订单ID
            String orderIdStr = request.getParameter("orderId");
            if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
                request.setAttribute("error", "订单ID不能为空");
                request.getRequestDispatcher("/WEB-INF/views/merchant/orders.jsp").forward(request, response);
                return;
            }

            int orderId = Integer.parseInt(orderIdStr);
            
            // 获取订单
            Order order = orderDAO.findById(orderId);
            if (order == null) {
                request.setAttribute("error", "订单不存在");
                request.getRequestDispatcher("/WEB-INF/views/merchant/orders.jsp").forward(request, response);
                return;
            }

            // 检查订单是否属于当前商家
            boolean isOrderBelongsToMerchant = false;
            if (order.getOrderItems() != null) {
                for (OrderItem item : order.getOrderItems()) {
                    if (item.getProduct() != null && 
                        item.getProduct().getMerchantId() != null && 
                        item.getProduct().getMerchantId().equals(merchant.getMerchantId())) {
                        isOrderBelongsToMerchant = true;
                        break;
                    }
                }
            }
            
            if (!isOrderBelongsToMerchant) {
                request.setAttribute("error", "无权操作此订单");
                request.getRequestDispatcher("/WEB-INF/views/merchant/orders.jsp").forward(request, response);
                return;
            }

            // 检查订单状态是否为待发货
            if (!"待发货".equals(order.getStatus())) {
                request.setAttribute("error", "订单状态不正确，无法发货");
                request.getRequestDispatcher("/WEB-INF/views/merchant/orders.jsp").forward(request, response);
                return;
            }

            // 更新订单状态为已发货
            order.setStatus("已发货");
            orderDAO.update(order);

            // 设置成功消息
            request.setAttribute("success", "订单已发货");
            
            // 重定向到订单列表页面
            response.sendRedirect(request.getContextPath() + "/merchant/orders");
        } catch (Exception e) {
            request.setAttribute("error", "发货失败：" + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/merchant/orders.jsp").forward(request, response);
        }
    }
} 