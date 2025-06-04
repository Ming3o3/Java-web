package com.ecommerce.servlet;// package com.ecommerce.servlet;

// import com.ecommerce.dao.OrderDAO;
// import com.ecommerce.dao.impl.OrderDAOImpl;
// import com.ecommerce.model.Customer;
// import com.ecommerce.model.Order;

// import javax.servlet.ServletException;
// import javax.servlet.annotation.WebServlet;
// import javax.servlet.http.HttpServlet;
// import javax.servlet.http.HttpServletRequest;
// import javax.servlet.http.HttpServletResponse;
// import javax.servlet.http.HttpSession;
// import java.io.IOException;

// @WebServlet("/order/confirm")
// public class OrderConfirmServlet extends HttpServlet {
//     private OrderDAO orderDAO;

//     @Override
//     public void init() throws ServletException {
//         orderDAO = new OrderDAOImpl();
//     }

//     @Override
//     protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//         HttpSession session = request.getSession();
//         Customer customer = (Customer) session.getAttribute("customer");
        
//         if (customer == null) {
//             response.sendRedirect(request.getContextPath() + "/login");
//             return;
//         }

//         try {
//             int orderId = Integer.parseInt(request.getParameter("orderId"));
//             Order order = orderDAO.findById(orderId);
            
//             if (order == null || order.getCustomerId() != customer.getCustomerId()) {
//                 request.setAttribute("error", "订单不存在或无权操作");
//                 request.getRequestDispatcher("/WEB-INF/views/order/detail.jsp").forward(request, response);
//                 return;
//             }

//             if (!"已发货".equals(order.getStatus())) {
//                 request.setAttribute("error", "订单状态不正确");
//                 request.getRequestDispatcher("/WEB-INF/views/order/detail.jsp").forward(request, response);
//                 return;
//             }

//             order.setStatus("已完成");
//             orderDAO.update(order);
            
//             response.sendRedirect(request.getContextPath() + "/order/detail?id=" + orderId);
//         } catch (NumberFormatException e) {
//             request.setAttribute("error", "无效的订单ID");
//             request.getRequestDispatcher("/WEB-INF/views/order/detail.jsp").forward(request, response);
//         }
//     }
// } 