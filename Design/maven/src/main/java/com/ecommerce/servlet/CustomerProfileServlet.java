package com.ecommerce.servlet;

import com.ecommerce.dao.CustomerDAO;
import com.ecommerce.dao.impl.CustomerDAOImpl;
import com.ecommerce.model.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/profile/*")
public class CustomerProfileServlet extends HttpServlet {
    private CustomerDAO customerDAO;
    
    @Override
    public void init() throws ServletException {
        customerDAO = new CustomerDAOImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String nickname = request.getParameter("nickname");
        String name = request.getParameter("name");
        String contactInfo = request.getParameter("contactInfo");
        String shippingAddress = request.getParameter("shippingAddress");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        
        // 验证当前密码
        if (currentPassword != null && !currentPassword.isEmpty()) {
            if (!currentPassword.equals(customer.getPassword())) {
                request.setAttribute("error", "当前密码错误");
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/profile.jsp").forward(request, response);
                return;
            }
            
            if (newPassword != null && !newPassword.isEmpty()) {
                customer.setPassword(newPassword);
            }
        }
        
        // 检查昵称是否已被其他用户使用
        if (!nickname.equals(customer.getNickname())) {
            Customer existingCustomer = customerDAO.findByUsername(nickname);
            if (existingCustomer != null && !existingCustomer.getCustomerId().equals(customer.getCustomerId())) {
                request.setAttribute("error", "该昵称已被使用");
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/profile.jsp").forward(request, response);
                return;
            }
        }
        
        customer.setNickname(nickname);
        customer.setName(name);
        customer.setContactInfo(contactInfo);
        customer.setShippingAddress(shippingAddress);
        
        try {
            customerDAO.update(customer);
            session.setAttribute("customer", customer);
            request.setAttribute("success", "个人信息更新成功");
        } catch (Exception e) {
            request.setAttribute("error", "更新失败：" + e.getMessage());
        }
        
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }
} 