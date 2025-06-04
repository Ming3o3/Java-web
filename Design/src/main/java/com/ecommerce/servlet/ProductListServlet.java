package com.ecommerce.servlet;

import com.ecommerce.dao.ProductDAO;
import com.ecommerce.dao.impl.ProductDAOImpl;
import com.ecommerce.model.Customer;
import com.ecommerce.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductListServlet extends HttpServlet {
    private ProductDAO productDAO;
    
    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAOImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 检查用户是否登录
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String keyword = request.getParameter("keyword");
        String sortType = request.getParameter("sort");
        List<Product> products;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            products = productDAO.searchAndSort(keyword, sortType);
        } else {
            products = productDAO.getSortedProducts(sortType);
        }
        
        request.setAttribute("products", products);
        request.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(request, response);
    }
} 