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

@WebServlet("/merchant/profile")
public class MerchantProfileServlet extends HttpServlet {
    private MerchantDAO merchantDAO;

    @Override
    public void init() throws ServletException {
        merchantDAO = new MerchantDAOImpl();
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

        // 获取最新的商家信息
        merchant = merchantDAO.findById(merchant.getMerchantId());
        request.setAttribute("merchant", merchant);
        
        request.getRequestDispatcher("/WEB-INF/views/merchant/profile.jsp").forward(request, response);
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

        // 获取表单数据
        String name = request.getParameter("name");
        String contactInfo = request.getParameter("contactInfo");
        String address = request.getParameter("address");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        try {
            // 更新基本信息
            merchant.setName(name);
            merchant.setContactInfo(contactInfo);
            merchant.setAddress(address);

            // 如果提供了密码，则更新密码
            if (currentPassword != null && !currentPassword.isEmpty()) {
                if (!merchant.getPassword().equals(currentPassword)) {
                    request.setAttribute("error", "当前密码不正确");
                    doGet(request, response);
                    return;
                }
                
                if (!newPassword.equals(confirmPassword)) {
                    request.setAttribute("error", "两次输入的新密码不一致");
                    doGet(request, response);
                    return;
                }
                
                merchant.setPassword(newPassword);
            }

            // 保存更新
            merchantDAO.update(merchant);
            
            // 更新session中的商家信息
            session.setAttribute("merchant", merchant);
            
            request.setAttribute("success", "店铺信息更新成功");
        } catch (Exception e) {
            request.setAttribute("error", "更新失败：" + e.getMessage());
        }
        
        doGet(request, response);
    }
} 