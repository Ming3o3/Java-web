package com.ecommerce.servlet;

import com.ecommerce.dao.MerchantDAO;
import com.ecommerce.dao.impl.MerchantDAOImpl;
import com.ecommerce.model.Merchant;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/merchant/register")
public class MerchantRegisterServlet extends HttpServlet {
    private MerchantDAO merchantDAO;

    @Override
    public void init() throws ServletException {
        merchantDAO = new MerchantDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/merchant/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String storeName = request.getParameter("storeName");
        String name = request.getParameter("name");
        String contactInfo = request.getParameter("contactInfo");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // 验证密码
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "两次输入的密码不一致");
            request.getRequestDispatcher("/WEB-INF/views/merchant/register.jsp").forward(request, response);
            return;
        }

        // 检查店铺名称是否已存在
        if (merchantDAO.findByStoreName(storeName) != null) {
            request.setAttribute("error", "店铺名称已存在");
            request.getRequestDispatcher("/WEB-INF/views/merchant/register.jsp").forward(request, response);
            return;
        }

        try {
            // 创建商家对象
            Merchant merchant = new Merchant();
            merchant.setStoreName(storeName);
            merchant.setName(name);
            merchant.setContactInfo(contactInfo);
            merchant.setAddress(address);
            merchant.setPassword(password);

            // 保存商家信息
            merchantDAO.save(merchant);

            // 注册成功，重定向到登录页面
            response.sendRedirect(request.getContextPath() + "/merchant/login");
        } catch (Exception e) {
            request.setAttribute("error", "注册失败：" + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/merchant/register.jsp").forward(request, response);
        }
    }
} 