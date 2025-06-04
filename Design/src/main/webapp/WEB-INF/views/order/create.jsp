<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>创建订单</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <h1>创建订单</h1>
        
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/order/create" method="post">
            <table class="order-table">
                <thead>
                    <tr>
                        <th>商品名称</th>
                        <th>单价</th>
                        <th>数量</th>
                        <th>小计</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${cartItems}" var="item">
                        <tr>
                            <td>${item.product.name}</td>
                            <td>￥${item.product.price}</td>
                            <td>${item.quantity}</td>
                            <td>￥${item.product.price * item.quantity}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <div class="order-total">
                总计：￥
                <c:set var="total" value="0" />
                <c:forEach items="${cartItems}" var="item">
                    <c:set var="total" value="${total + item.product.price * item.quantity}" />
                </c:forEach>
                ${total}
            </div>
            
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">确认下单</button>
                <a href="${pageContext.request.contextPath}/cart" class="btn">返回购物车</a>
            </div>
        </form>
    </div>
</body>
</html> 