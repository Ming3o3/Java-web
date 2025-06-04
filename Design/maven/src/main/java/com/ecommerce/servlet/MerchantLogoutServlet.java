package com.ecommerce.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/merchant/logout")
public class MerchantLogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 获取当前会话
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // 清除商家相关的会话属性
            session.removeAttribute("merchant");
            // 使会话失效
            session.invalidate();
        }
        
        // 重定向到登录页面
        response.sendRedirect(request.getContextPath() + "/merchant/login");
    }
} 