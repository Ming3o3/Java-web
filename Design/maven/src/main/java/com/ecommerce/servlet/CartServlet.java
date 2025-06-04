package com.ecommerce.servlet;

import com.ecommerce.dao.CartDAO;
import com.ecommerce.dao.ProductDAO;
import com.ecommerce.dao.impl.CartDAOImpl;
import com.ecommerce.dao.impl.ProductDAOImpl;
import com.ecommerce.model.CartItem;
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

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private CartDAO cartDAO;
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        cartDAO = new CartDAOImpl();
        productDAO = new ProductDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            showCart(request, response);
            return;
        }
        
        switch (action) {
            case "add":
                addToCart(request, response);
                break;
            case "update":
                updateCartItem(request, response);
                break;
            case "remove":
                removeCartItem(request, response);
                break;
            default:
                showCart(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void showCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        List<CartItem> cartItems = cartDAO.getCustomerCart(customer.getCustomerId());
        request.setAttribute("cartItems", cartItems);
        
        // 计算商品总数和总金额
        int totalItems = 0;
        double totalAmount = 0.0;
        
        for (CartItem item : cartItems) {
            totalItems += item.getQuantity();
            totalAmount += item.getProduct().getPrice().doubleValue() * item.getQuantity();
        }
        
        request.setAttribute("totalItems", totalItems);
        request.setAttribute("totalAmount", totalAmount);
        
        request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            // 使用已初始化的productDAO实例
            Product product = productDAO.getById(productId);
            
            if (product == null) {
                request.setAttribute("error", "商品不存在");
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
                return;
            }
            
            if (product.getQuantity() < quantity) {
                request.setAttribute("error", "商品库存不足");
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
                return;
            }
            
            CartItem item = new CartItem();
            item.setCustomerId(customer.getCustomerId());
            item.setProductId(productId);
            item.setQuantity(quantity);
            
            // 使用已初始化的cartDAO实例
            cartDAO.addItem(item);
            
            response.sendRedirect(request.getContextPath() + "/cart");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "无效的商品数量");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "添加商品到购物车失败: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    private void updateCartItem(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            Integer cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
            Integer quantity = Integer.parseInt(request.getParameter("quantity"));
            
            CartItem cartItem = cartDAO.getItem(cartItemId);
            if (cartItem == null || !cartItem.getCustomerId().equals(customer.getCustomerId())) {
                throw new IllegalArgumentException("购物车项不存在");
            }
            
            cartDAO.updateQuantity(cartItemId, quantity);
            
            response.sendRedirect(request.getContextPath() + "/cart");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "无效的购物车项ID或数量");
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        }
    }

    private void removeCartItem(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            Integer cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
            
            CartItem cartItem = cartDAO.getItem(cartItemId);
            if (cartItem == null || !cartItem.getCustomerId().equals(customer.getCustomerId())) {
                throw new IllegalArgumentException("购物车项不存在");
            }
            
            cartDAO.removeItem(cartItemId);
            
            response.sendRedirect(request.getContextPath() + "/cart");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "无效的购物车项ID");
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        }
    }
} 