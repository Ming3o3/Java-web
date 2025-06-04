<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>申请退货</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            background: #f5f7fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333;
            margin-bottom: 30px;
            text-align: center;
        }

        .order-info {
            margin-bottom: 30px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .info-item {
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }

        .info-label {
            width: 100px;
            color: #666;
            font-weight: 500;
        }

        .info-value {
            color: #333;
            flex: 1;
        }

        .order-items {
            margin-bottom: 30px;
        }

        .order-item {
            display: grid;
            grid-template-columns: 80px 2fr 1fr 1fr;
            gap: 20px;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #f0f0f0;
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

        .return-form {
            margin-top: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }

        textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            min-height: 100px;
            resize: vertical;
        }

        textarea:focus {
            border-color: #4CAF50;
            outline: none;
        }

        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            text-decoration: none;
            text-align: center;
        }

        .btn-primary {
            background: #4CAF50;
            color: white;
        }

        .btn-primary:hover {
            background: #45a049;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        .error {
            color: #dc3545;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>申请退货</h1>
        
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        
        <div class="order-info">
            <div class="info-item">
                <span class="info-label">订单编号：</span>
                <span class="info-value">${order.orderId}</span>
            </div>
            <div class="info-item">
                <span class="info-label">下单时间：</span>
                <span class="info-value"><fmt:formatDate value="${order.orderTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
            </div>
            <div class="info-item">
                <span class="info-label">订单状态：</span>
                <span class="info-value">${order.status}</span>
            </div>
            <div class="info-item">
                <span class="info-label">收货地址：</span>
                <span class="info-value">${order.shippingAddress}</span>
            </div>
        </div>
        
        <div class="order-items">
            <h3>订单商品</h3>
            <c:forEach items="${order.orderItems}" var="item">
                <div class="order-item">
                    <img src="${item.product.image}" alt="${item.product.category}" class="item-image">
                    <div class="item-info">
                        <h4>${item.product.category}</h4>
                    </div>
                    <div class="item-price">￥${item.unitPrice}</div>
                    <div class="item-quantity">x ${item.quantity}</div>
                </div>
            </c:forEach>
        </div>
        
        <div class="order-info">
            <div class="info-item">
                <span class="info-label">订单总额：</span>
                <span class="info-value price">￥${order.totalAmount}</span>
            </div>
        </div>
        
        <form action="${pageContext.request.contextPath}/return/apply" method="post" class="return-form">
            <input type="hidden" name="orderId" value="${order.orderId}">
            
            <div class="form-group">
                <label for="returnReason">请填写退货原因：</label>
                <textarea id="returnReason" name="returnReason" required></textarea>
            </div>
            
            <div class="button-group">
                <button type="submit" class="btn btn-primary">提交退货申请</button>
                <a href="${pageContext.request.contextPath}/order/list" class="btn btn-secondary">返回订单列表</a>
            </div>
        </form>
    </div>
</body>
</html> 