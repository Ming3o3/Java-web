<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>订单详情</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .btn-home {
            background-color: #607D8B;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 4px;
        }
        .btn-home:hover {
            background-color: #455A64;
        }
        .order-info {
            background-color: #f5f5f5;
            padding: 20px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        .order-info p {
            margin: 10px 0;
        }
        .order-items {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .order-items th, .order-items td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .order-items th {
            background-color: #f5f5f5;
            font-weight: bold;
        }
        .order-items tr:hover {
            background-color: #f9f9f9;
        }
        .error-message {
            color: #f44336;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>订单详情</h2>
            <a href="${pageContext.request.contextPath}/merchant/dashboard" class="btn-home">返回首页</a>
        </div>
        
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>
        
        <div class="order-info">
            <h3>订单信息</h3>
            <p><strong>订单编号：</strong>${order.orderId}</p>
            <p><strong>订单状态：</strong>${order.status}</p>
            <p><strong>下单时间：</strong>${order.orderDate}</p>
            <p><strong>总金额：</strong>￥${order.totalAmount}</p>
            <p><strong>收货地址：</strong>${order.shippingAddress}</p>
        </div>
        
        <h3>订单商品</h3>
        <table class="order-items">
            <thead>
                <tr>
                    <th>商品ID</th>
                    <th>商品名称</th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>小计</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${order.orderItems}" var="item">
                    <tr>
                        <td>${item.productId}</td>
                        <td>${item.product.category}</td>
                        <td>￥${item.unitPrice}</td>
                        <td>${item.quantity}</td>
                        <td>￥${item.unitPrice * item.quantity}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>