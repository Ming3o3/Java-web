package com.ecommerce.servlet.merchant;

import com.ecommerce.dao.ReturnGoodsDAO;
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
import java.util.List;

@WebServlet("/merchant/returns")
public class ReturnListServlet extends HttpServlet {
    private ReturnGoodsDAO returnGoodsDAO;

    @Override
    public void init() throws ServletException {
        returnGoodsDAO = new ReturnGoodsDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 设置请求和响应的字符编码
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Merchant merchant = (Merchant) session.getAttribute("merchant");
        
        if (merchant == null) {
            response.sendRedirect(request.getContextPath() + "/merchant/login");
            return;
        }

        try {
            // 获取该商家的所有退货申请
            List<ReturnGoods> returns = returnGoodsDAO.findByMerchantId(merchant.getMerchantId());
            request.setAttribute("returns", returns);
            request.getRequestDispatcher("/merchant/returns.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "获取退货列表失败：" + e.getMessage());
            request.getRequestDispatcher("/merchant/dashboard").forward(request, response);
        }
    }
} 