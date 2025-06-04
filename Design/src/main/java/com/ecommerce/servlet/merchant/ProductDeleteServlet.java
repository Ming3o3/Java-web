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

@WebServlet("/merchant/product/delete")
public class ProductDeleteServlet extends HttpServlet {
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

        try {
            // 获取商品ID
            String productIdStr = request.getParameter("id");
            if (productIdStr == null || productIdStr.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/merchant/products");
                return;
            }

            int productId = Integer.parseInt(productIdStr);
            
            // 获取商品信息
            Product product = productDAO.getById(productId);
            if (product == null || !product.getMerchantId().equals(merchant.getMerchantId())) {
                response.sendRedirect(request.getContextPath() + "/merchant/products");
                return;
            }

            // 删除商品
            productDAO.delete(productId);

            // 重定向到商品列表页面
            response.sendRedirect(request.getContextPath() + "/merchant/products");
        } catch (Exception e) {
            request.setAttribute("error", "删除商品失败：" + e.getMessage());
            request.getRequestDispatcher("/merchant/products").forward(request, response);
        }
    }
} 