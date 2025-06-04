package com.ecommerce.servlet;

import com.ecommerce.dao.CustomerDAO;
import com.ecommerce.dao.impl.CustomerDAOImpl;
import com.ecommerce.model.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

@WebServlet("/register")
public class CustomerRegisterServlet extends HttpServlet {
    private CustomerDAO customerDAO;
    
    @Override
    public void init() throws ServletException {
        customerDAO = new CustomerDAOImpl();
        createTestAccount();
    }
    
    private void createTestAccount() {
        try {
            if (customerDAO.findByUsername("test") == null) {
                Customer testCustomer = new Customer();
                testCustomer.setNickname("test");
                testCustomer.setPassword("123456");
                testCustomer.setName("测试用户");
                testCustomer.setContactInfo("13800138000");
                testCustomer.setShippingAddress("测试地址");
                customerDAO.save(testCustomer);
                System.out.println("Test account created successfully");
            }
        } catch (Exception e) {
            System.err.println("Error creating test account: " + e.getMessage());
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String nickname = request.getParameter("nickname");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String contactInfo = request.getParameter("contactInfo");
        String shippingAddress = request.getParameter("shippingAddress");
        
        if (nickname == null || nickname.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "昵称和密码不能为空");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        if (customerDAO.findByUsername(nickname) != null) {
            request.setAttribute("error", "该昵称已被使用");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        Customer customer = new Customer();
        customer.setNickname(nickname);
        customer.setPassword(password);
        customer.setName(name);
        customer.setContactInfo(contactInfo);
        customer.setShippingAddress(shippingAddress);
        
        try {
            customerDAO.save(customer);
            response.sendRedirect(request.getContextPath() + "/login");
        } catch (Exception e) {
            request.setAttribute("error", "注册失败：" + e.getMessage());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
} 