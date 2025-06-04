package com.ecommerce.servlet;

import com.ecommerce.dao.MerchantDAO;
import com.ecommerce.dao.impl.MerchantDAOImpl;
import com.ecommerce.model.Merchant;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/merchant/login")
public class MerchantLoginServlet extends HttpServlet {
    private MerchantDAO merchantDAO;

    @Override
    public void init() throws ServletException {
        merchantDAO = new MerchantDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/merchant/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String storeName = request.getParameter("storeName");
        String password = request.getParameter("password");
        
        try {
            Merchant merchant = merchantDAO.findByStoreName(storeName);
            
            if (merchant != null && password.equals(merchant.getPassword())) {
                HttpSession session = request.getSession();
                session.setAttribute("merchant", merchant);
                response.sendRedirect(request.getContextPath() + "/merchant/dashboard");
            } else {
                request.setAttribute("error", "店铺名称或密码错误");
                request.getRequestDispatcher("/WEB-INF/views/merchant/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "登录失败：" + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/merchant/login.jsp").forward(request, response);
        }
    }
} 