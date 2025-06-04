package com.ecommerce.servlet.merchant;

import com.ecommerce.dao.OrderDAO;
import com.ecommerce.dao.ReturnGoodsDAO;
import com.ecommerce.dao.impl.OrderDAOImpl;
import com.ecommerce.dao.impl.ReturnGoodsDAOImpl;
import com.ecommerce.model.Merchant;
import com.ecommerce.model.ReturnGoods;
import com.ecommerce.util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/merchant/return/approve")
public class ReturnApproveServlet extends HttpServlet {
    private ReturnGoodsDAO returnGoodsDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        returnGoodsDAO = new ReturnGoodsDAOImpl();
        orderDAO = new OrderDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Merchant merchant = (Merchant) session.getAttribute("merchant");

        if (merchant == null) {
            response.sendRedirect(request.getContextPath() + "/merchant/login");
            return;
        }

        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false);
            try {
                Integer returnId = Integer.parseInt(request.getParameter("returnId"));
                ReturnGoods returnGoods = returnGoodsDAO.findById(returnId);

                if (returnGoods != null) {
                    // 检查退货单状态，防止重复处理
                    if (!"已同意".equals(returnGoods.getStatus())) {
                        returnGoods.setStatus("已同意");
                        returnGoodsDAO.update(returnGoods); // 传入连接，使用同一事务

                        // 更新订单状态
                        orderDAO.updateStatus(returnGoods.getOrderId(), "同意退货", conn);

                        // 增加库存
                        orderDAO.increaseProductStock(returnGoods.getOrderId(), conn);
                    }
                }

                conn.commit();
                response.sendRedirect(request.getContextPath() + "/merchant/returns?success=1");
            } catch (Exception e) {
                conn.rollback();
                e.printStackTrace(); // 记录详细错误日志
                response.sendRedirect(request.getContextPath() + "/merchant/returns?error=1");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/merchant/returns?error=1");
        }
    }
}