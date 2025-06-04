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
        .btn-action {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 5px;
        }
        .btn-complete {
            background-color: #4CAF50;
            color: white;
        }
        .btn-action:hover {
            opacity: 0.8;
        }
        .error-message {
            color: #f44336;
            margin-bottom: 20px;
        }
        .success-message {
            color: #4CAF50;
            margin-bottom: 20px;
        }
        .return-status {
            margin-top: 20px;
            padding: 15px;
            background-color: #fff3cd;
            border: 1px solid #ffeeba;
            border-radius: 4px;
        }
        .return-status h3 {
            margin-top: 0;
            color: #856404;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>订单详情</h2>
            <a href="${pageContext.request.contextPath}/order/list" class="btn-home">返回订单列表</a>
        </div>
        
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>
        
        <c:if test="${not empty success}">
            <div class="success-message">${success}</div>
        </c:if>
        
        <div class="order-info">
            <p><strong>订单编号：</strong>${order.orderId}</p>
            <p><strong>订单时间：</strong>${order.orderDate}</p>
            <p><strong>订单状态：</strong>${order.status}</p>
            <p><strong>总金额：</strong>￥${order.totalAmount}</p>
            <p><strong>收货地址：</strong>${order.shippingAddress}</p>
            
            <c:if test="${order.status eq '已发货'}">
                <form action="${pageContext.request.contextPath}/order/confirm-receipt" method="post" style="display: inline-block; margin-right: 10px;">
                    <input type="hidden" name="orderId" value="${order.orderId}">
                    <button type="submit" class="btn-action">确认收货</button>
                </form>
                <form action="${pageContext.request.contextPath}/order/return/apply" method="post" style="display: inline-block;">
                    <input type="hidden" name="orderId" value="${order.orderId}">
                    <button type="submit" class="btn-action">申请退货</button>
                </form>
            </c:if>
        </div>

        <c:if test="${not empty returnGoods}">
            <div class="return-status">
                <h3>退货信息</h3>
                <p><strong>退货原因：</strong>${returnGoods.reason}</p>
                <p><strong>申请时间：</strong>${returnGoods.returnTime}</p>
                <p><strong>退货状态：</strong>${returnGoods.status}</p>
                
                <c:if test="${returnGoods.status eq '已同意'}">
                    <form action="${pageContext.request.contextPath}/order/return/complete" method="post">
                        <input type="hidden" name="returnId" value="${returnGoods.returnId}">
                        <button type="submit" class="btn-action btn-complete">确认完成退货</button>
                    </form>
                </c:if>
            </div>
        </c:if>
        
        <table class="order-items">
            <thead>
                <tr>
                    <th>商品名称</th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>小计</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${order.orderItems}" var="item">
                    <tr>
                        <td>${item.productName}</td>
                        <td>￥${item.unitPrice}</td>
                        <td>${item.quantity}</td>
                        <td>￥${item.subtotal}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html> 