package com.ecommerce.servlet.merchant;

import com.ecommerce.dao.OrderDAO;
import com.ecommerce.dao.ReturnGoodsDAO;
import com.ecommerce.dao.impl.OrderDAOImpl;
import com.ecommerce.dao.impl.ReturnGoodsDAOImpl;
import com.ecommerce.model.Merchant;
import com.ecommerce.model.ReturnGoods;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/merchant/return/reject")
public class ReturnRejectServlet extends HttpServlet {
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
        Merchant merchant = (Merchant) session.getAttribute("merchant");
        
        if (merchant == null) {
            response.sendRedirect(request.getContextPath() + "/merchant/login");
            return;
        }

        try {
            Integer returnId = Integer.parseInt(request.getParameter("returnId"));
            ReturnGoods returnGoods = returnGoodsDAO.findById(returnId);
            
            if (returnGoods != null) {
                returnGoods.setStatus("已拒绝");
                returnGoodsDAO.update(returnGoods);
                
                orderDAO.updateStatus(returnGoods.getOrderId(), "拒绝退货");
            }
            
            response.sendRedirect(request.getContextPath() + "/merchant/returns");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/merchant/returns");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/merchant/returns");
        }
    }
} 