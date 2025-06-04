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
import java.util.List;

@WebServlet("/order/detail")
public class OrderDetailServlet extends HttpServlet {
    private OrderDAO orderDAO;
    private ReturnGoodsDAO returnGoodsDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAOImpl();
        returnGoodsDAO = new ReturnGoodsDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
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
            Integer orderId = Integer.parseInt(request.getParameter("id"));
            Order order = orderDAO.findById(orderId);
            
            if (order != null && order.getCustomerId().equals(customer.getCustomerId())) {
                // 加载退货信息
                List<ReturnGoods> returnGoodsList = returnGoodsDAO.findByOrderId(orderId);
                if (!returnGoodsList.isEmpty()) {
                    ReturnGoods returnGoods = returnGoodsList.get(0);
                    // 只有当退货记录存在且状态不为空时才显示
                    if (returnGoods != null && returnGoods.getStatus() != null && !returnGoods.getStatus().trim().isEmpty()) {
                        request.setAttribute("returnGoods", returnGoods);
                    } else {
                        request.removeAttribute("returnGoods");
                    }
                } else {
                    request.removeAttribute("returnGoods");
                }
                
                request.setAttribute("order", order);
                request.getRequestDispatcher("/order/detail.jsp").forward(request, response);
            } else {
                session.setAttribute("error", "订单不存在或无权访问");
                response.sendRedirect(request.getContextPath() + "/order/list");
            }
        } catch (Exception e) {
            session.setAttribute("error", "获取订单详情失败：" + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/order/list");
        }
    }
} 