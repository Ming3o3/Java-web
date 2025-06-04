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

@WebServlet("/login")
public class CustomerLoginServlet extends HttpServlet {
    private CustomerDAO customerDAO;
    
    @Override
    public void init() throws ServletException {
        customerDAO = new CustomerDAOImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String nickname = request.getParameter("nickname");
        String password = request.getParameter("password");
        
        if (nickname == null || nickname.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "昵称和密码不能为空");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        Customer customer = customerDAO.login(nickname, password);
        
        if (customer != null) {
            HttpSession session = request.getSession();
            session.setAttribute("customer", customer);
            response.sendRedirect(request.getContextPath() + "/dashboard");
        } else {
            request.setAttribute("error", "昵称或密码错误");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
} 