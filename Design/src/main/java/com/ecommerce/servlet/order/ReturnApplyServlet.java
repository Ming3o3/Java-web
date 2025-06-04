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
import java.util.Date;

@WebServlet("/order/return/apply")
public class ReturnApplyServlet extends HttpServlet {
    private OrderDAO orderDAO;
    private ReturnGoodsDAO returnGoodsDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAOImpl();
        returnGoodsDAO = new ReturnGoodsDAOImpl();
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
                if (!"已发货".equals(order.getStatus())) {
                    session.setAttribute("error", "只能对已发货的订单申请退货");
                    response.sendRedirect(request.getContextPath() + "/order/detail?id=" + orderId);
                    return;
                }

                // 检查是否已经申请过退货
                if (returnGoodsDAO.findByOrderId(orderId).size() > 0) {
                    response.sendRedirect(request.getContextPath() + "/order/detail?id=" + orderId);
                    return;
                }

                // 创建退货申请
                ReturnGoods returnGoods = new ReturnGoods();
                returnGoods.setCustomerId(customer.getCustomerId());
                returnGoods.setOrderId(orderId);
                returnGoods.setProductId(order.getOrderItems().get(0).getProductId()); // 假设一个订单只有一个商品
                returnGoods.setReturnTime(new Date());
                returnGoods.setStatus("待处理");
                returnGoods.setReason("商品质量问题"); // 默认原因，实际应用中应该让用户填写

                returnGoodsDAO.save(returnGoods);
                
                response.sendRedirect(request.getContextPath() + "/order/detail?id=" + orderId);
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