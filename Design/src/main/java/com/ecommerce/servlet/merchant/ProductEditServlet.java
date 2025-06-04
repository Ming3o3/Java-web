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

@WebServlet("/merchant/product/edit")
public class ProductEditServlet extends HttpServlet {
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

            // 将商品信息设置到请求属性中
            request.setAttribute("product", product);
            
            // 转发到编辑页面
            request.getRequestDispatcher("/merchant/product/edit.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "获取商品信息失败：" + e.getMessage());
            request.getRequestDispatcher("/merchant/products").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 检查商家是否已登录
        HttpSession session = request.getSession();
        Merchant merchant = (Merchant) session.getAttribute("merchant");
        if (merchant == null) {
            response.sendRedirect(request.getContextPath() + "/merchant/login");
            return;
        }

        try {
            // 获取表单数据
            String productIdStr = request.getParameter("productId");
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

            // 更新商品信息
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String category = request.getParameter("category");
            String image = request.getParameter("image");

            product.setPrice(price);
            product.setQuantity(quantity);
            product.setCategory(category);
            product.setImage(image);

            // 保存更新
            productDAO.update(product);

            // 重定向到商品列表页面
            response.sendRedirect(request.getContextPath() + "/merchant/products");
        } catch (Exception e) {
            request.setAttribute("error", "更新商品失败：" + e.getMessage());
            request.getRequestDispatcher("/merchant/product/edit.jsp").forward(request, response);
        }
    }
} 