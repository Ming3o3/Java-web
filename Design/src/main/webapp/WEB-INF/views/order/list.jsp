<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的订单</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            background: #f5f7fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        header {
            background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        header h1 {
            margin: 0;
            font-size: 2em;
            font-weight: 600;
        }

        nav {
            margin-top: 15px;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        nav a {
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 20px;
            background: rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        nav a:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }

        .order-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .order-card {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            margin-bottom: 20px;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .order-card:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transform: translateY(-2px);
        }

        .order-header {
            background: #f8f9fa;
            padding: 15px 20px;
            border-bottom: 1px solid #e0e0e0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .order-info {
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .order-number {
            font-weight: 600;
            color: #333;
        }

        .order-date {
            color: #666;
        }

        .order-status {
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 0.9em;
            font-weight: 500;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-shipped {
            background: #cce5ff;
            color: #004085;
        }

        .status-completed {
            background: #d4edda;
            color: #155724;
        }

        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
        }

        .order-items {
            padding: 20px;
        }

        .order-item {
            display: grid;
            grid-template-columns: 80px 2fr 1fr 1fr;
            gap: 20px;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #f0f0f0;
        }

        .order-item:last-child {
            border-bottom: none;
        }

        .item-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 6px;
        }

        .item-info h4 {
            margin: 0 0 5px 0;
            color: #333;
        }

        .item-price {
            color: #e44d26;
            font-weight: 500;
        }

        .item-quantity {
            color: #666;
        }

        .order-footer {
            background: #f8f9fa;
            padding: 15px 20px;
            border-top: 1px solid #e0e0e0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .order-total {
            font-size: 1.2em;
            font-weight: 600;
            color: #e44d26;
        }

        .order-actions {
            display: flex;
            gap: 10px;
        }

        .action-button {
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .confirm-button {
            background: #28a745;
            color: white;
        }

        .confirm-button:hover {
            background: #218838;
        }

        .cancel-button {
            background: #dc3545;
            color: white;
        }

        .cancel-button:hover {
            background: #c82333;
        }

        .return-button {
            background: #17a2b8;
            color: white;
        }

        .return-button:hover {
            background: #138496;
        }

        .empty-orders {
            text-align: center;
            padding: 40px;
            color: #666;
        }

        .empty-orders i {
            font-size: 3em;
            color: #ccc;
            margin-bottom: 20px;
        }

        .empty-orders p {
            font-size: 1.2em;
            margin-bottom: 20px;
        }

        .continue-shopping {
            display: inline-block;
            padding: 10px 20px;
            background: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        .continue-shopping:hover {
            background: #45a049;
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {
            .order-item {
                grid-template-columns: 60px 1fr;
                gap: 10px;
            }

            .item-image {
                width: 60px;
                height: 60px;
            }

            .item-info {
                grid-column: 2;
            }

            .item-price, .item-quantity {
                grid-column: 2;
            }

            .order-header {
                flex-direction: column;
                gap: 10px;
            }

            .order-info {
                flex-direction: column;
                align-items: flex-start;
            }

            .order-footer {
                flex-direction: column;
                gap: 15px;
            }

            .order-actions {
                width: 100%;
                justify-content: center;
            }

            nav {
                justify-content: center;
            }
        }
        .shipping-address {
            margin-top: 15px;
            padding: 10px;
            background: #f0f8ff;
            border-radius: 6px;
            border-left: 4px solid #4CAF50;
        }

        .shipping-address-label {
            font-weight: 600;
            color: #333;
            margin-right: 10px;
        }

        .shipping-address-value {
            color: #555;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
<div class="container">
    <header>
        <h1>我的订单</h1>
        <nav>
            <a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-home"></i> 返回首页</a>
            <a href="${pageContext.request.contextPath}/products"><i class="fas fa-shopping-bag"></i> 继续购物</a>
            <a href="${pageContext.request.contextPath}/cart"><i class="fas fa-shopping-cart"></i> 购物车</a>
            <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> 退出登录</a>
        </nav>
    </header>

    <main>
        <div class="order-container">
            <c:if test="${empty orders}">
                <div class="empty-orders">
                    <i class="fas fa-clipboard-list"></i>
                    <p>您还没有任何订单</p>
                    <a href="${pageContext.request.contextPath}/products" class="continue-shopping">
                        <i class="fas fa-shopping-bag"></i> 去购物
                    </a>
                </div>
            </c:if>

            <c:forEach items="${orders}" var="order">
                <div class="order-card">
                    <div class="order-header">
                        <div class="order-info">
                            <span class="order-number">订单号：${order.orderId}</span>
                            <span class="order-date">
                                    <i class="far fa-calendar-alt"></i>
                                    <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm"/>
                                </span>
                        </div>
                        <span class="order-status status-${order.status.toLowerCase()}">${order.status}</span>
                    </div>
                    <div class="shipping-address">
                        <span class="shipping-address-label"><i class="fas fa-map-marker-alt"></i> 收货地址：</span>
                        <span class="shipping-address-value">${order.shippingAddress}</span>
                    </div>
                    <div class="order-items">
                        <c:forEach items="${order.orderItems}" var="item">
                            <div class="order-item">
                                    <%-- <img src="${item.product.image}" alt="${item.product.category}" class="item-image"> --%>
                                <div class="item-info">
                                    <h4>${item.product.category}</h4>
                                </div>

                                <div class="item-price">￥${item.unitPrice}</div>
                                <div class="item-quantity">x ${item.quantity}</div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="order-footer">
                        <div class="order-total">
                            总计：￥${order.totalAmount}
                        </div>

                        <div class="order-actions">
                            <c:if test="${order.status == '待发货'}">
                                <form action="${pageContext.request.contextPath}/order/cancel" method="post" style="display: inline;">
                                    <input type="hidden" name="orderId" value="${order.orderId}">
                                    <button type="submit" class="action-button cancel-button">
                                        <i class="fas fa-times"></i> 取消订单
                                    </button>
                                </form>
                            </c:if>
                            <c:if test="${order.status == '已发货'}">
                                <form action="${pageContext.request.contextPath}/order/confirm-receipt" method="post" style="display: inline;">
                                    <input type="hidden" name="orderId" value="${order.orderId}">
                                    <button type="submit" class="action-button confirm-button">
                                        <i class="fas fa-check"></i> 确认收货
                                    </button>
                                </form>
                                <form action="${pageContext.request.contextPath}/return/apply" method="post" style="display: inline;">
                                    <input type="hidden" name="orderId" value="${order.orderId}">
                                    <input type="hidden" name="returnReason" value="商品质量问题">
                                    <button type="submit" class="action-button return-button">
                                        <i class="fas fa-undo"></i> 申请退货
                                    </button>
                                </form>
                            </c:if>
                            <c:if test="${order.status == '同意退货'}">
                                <form action="${pageContext.request.contextPath}/return/confirm" method="post" style="display: inline;">
                                    <input type="hidden" name="orderId" value="${order.orderId}">
                                    <input type="hidden" name="action" value="confirm">
                                    <button type="submit" class="action-button confirm-button">
                                        <i class="fas fa-check"></i> 确认退货
                                    </button>
                                </form>
                            </c:if>
                            <c:if test="${order.status == '拒绝退货'}">
                                <form action="${pageContext.request.contextPath}/return/confirm" method="post" style="display: inline;">
                                    <input type="hidden" name="orderId" value="${order.orderId}">
                                    <input type="hidden" name="action" value="reject">
                                    <button type="submit" class="action-button cancel-button">
                                        <i class="fas fa-times"></i> 确认拒绝
                                    </button>
                                </form>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </main>
</div>
</body>
</html> 