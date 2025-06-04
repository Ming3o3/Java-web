package com.ecommerce.servlet.merchant;

import com.ecommerce.dao.ProductDAO;
import com.ecommerce.dao.impl.ProductDAOImpl;
import com.ecommerce.model.Product;
import com.ecommerce.model.Merchant;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/merchant/product/add")
public class ProductAddServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 检查商家是否已登录
        HttpSession session = request.getSession();
        Merchant merchant = (Merchant) session.getAttribute("merchant");
        if (merchant == null) {
            response.sendRedirect(request.getContextPath() + "/merchant/login");
            return;
        }

        // 显示添加商品表单
        request.getRequestDispatcher("/merchant/product/add.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 检查商家是否已登录
        HttpSession session = request.getSession();
        Merchant merchant = (Merchant) session.getAttribute("merchant");
        if (merchant == null) {
            response.sendRedirect(request.getContextPath() + "/merchant/login");
            return;
        }

        try {
            // 获取表单数据
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String category = request.getParameter("category");
            String image = request.getParameter("image");

            // 创建新商品对象
            Product product = new Product();
            product.setMerchantId(merchant.getMerchantId());
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setCategory(category);
            product.setImage(image);

            // 保存商品
            productDAO.save(product);

            // 重定向到商品列表页面
            response.sendRedirect(request.getContextPath() + "/merchant/products");
        } catch (Exception e) {
            // 如果发生错误，设置错误信息并返回表单页面
            request.setAttribute("error", "添加商品失败：" + e.getMessage());
            request.getRequestDispatcher("/merchant/product/add.jsp").forward(request, response);
        }
    }
} 