package com.ecommerce.servlet;

import com.ecommerce.dao.OrderDAO;
import com.ecommerce.dao.ProductDAO;
import com.ecommerce.dao.ReturnGoodsDAO;
import com.ecommerce.dao.impl.OrderDAOImpl;
import com.ecommerce.dao.impl.ProductDAOImpl;
import com.ecommerce.dao.impl.ReturnGoodsDAOImpl;
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

@WebServlet("/merchant/dashboard")
public class MerchantDashboardServlet extends HttpServlet {
    private ProductDAO productDAO;
    private OrderDAO orderDAO;
    private ReturnGoodsDAO returnGoodsDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAOImpl();
        orderDAO = new OrderDAOImpl();
        returnGoodsDAO = new ReturnGoodsDAOImpl();
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
            // 获取商品总数
            int productCount = productDAO.countByMerchantId(merchant.getMerchantId());
            request.setAttribute("productCount", productCount);
            
            // 获取待处理订单数
            int pendingOrderCount = orderDAO.countPendingOrdersByMerchantId(merchant.getMerchantId());
            request.setAttribute("pendingOrderCount", pendingOrderCount);
            
            // 获取待处理退货数
            int pendingReturnCount = returnGoodsDAO.countPendingReturnsByMerchantId(merchant.getMerchantId());
            request.setAttribute("pendingReturnCount", pendingReturnCount);
            
            // 获取最近订单
            List<Order> recentOrders = orderDAO.findRecentOrdersByMerchantId(merchant.getMerchantId(), 5);
            request.setAttribute("recentOrders", recentOrders);
            
            request.getRequestDispatcher("/WEB-INF/views/merchant/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "加载数据失败：" + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/merchant/dashboard.jsp").forward(request, response);
        }
    }
} 