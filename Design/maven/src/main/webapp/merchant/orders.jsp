<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>最近订单</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>最近订单</h1>
            <nav>
                <a href="${pageContext.request.contextPath}/merchant/dashboard">返回首页</a>
                <a href="${pageContext.request.contextPath}/merchant/products">商品管理</a>
                <a href="${pageContext.request.contextPath}/logout">退出登录</a>
            </nav>
        </header>

        <main>
            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>
            
            <c:if test="${empty orders}">
                <div class="empty-orders">
                    <p>暂无订单</p>
                </div>
            </c:if>

            <c:if test="${not empty orders}">
                <table class="table">
                    <thead>
                        <tr>
                            <th>订单号</th>
                            <th>顾客</th>
                            <th>商品</th>
                            <th>数量</th>
                            <th>总价</th>
                            <th>状态</th>
                            <!-- <th>操作</th> -->
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orders}" var="order">
                            <tr>
                                <td>${order.orderId}</td>
                                <td>${order.customerName}</td>
                                <td>${order.productName}</td>
                                <td>${order.quantity}</td>
                                <td>￥${order.totalPrice}</td>
                                <td>${order.status}</td>
                                <!-- <td>
                                    <c:if test="${order.status == '待发货'}">
                                        <form action="${pageContext.request.contextPath}/merchant/order/ship" method="post" style="display: inline;">
                                            <input type="hidden" name="orderId" value="${order.orderId}">
                                            <button type="submit" class="btn-ship">发货</button>
                                        </form>
                                    </c:if>
                                    <c:if test="${order.status == '已发货'}">
                                        <form action="${pageContext.request.contextPath}/merchant/order/return" method="post" style="display: inline;">
                                            <input type="hidden" name="orderId" value="${order.orderId}">
                                            <button type="submit" class="btn-return">同意退货</button>
                                        </form>
                                    </c:if>
                                </td> -->
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </main>
    </div>
</body>
</html>