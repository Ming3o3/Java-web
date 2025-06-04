<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商家后台管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    

</head>
<body>
    <div class="container">
        <header class="header">
            <h1>商家后台管理</h1>
            <div class="user-info">
                欢迎，${merchant.storeName}
                <a href="${pageContext.request.contextPath}/merchant/logout" class="btn btn-link">退出</a>
            </div>
        </header>

        <nav class="nav">
            <ul>
                <li><a href="${pageContext.request.contextPath}/merchant/products">商品管理</a></li>
                <li><a href="${pageContext.request.contextPath}/merchant/orders">订单管理</a></li>
                <li><a href="${pageContext.request.contextPath}/merchant/returns">退货管理</a></li>
                <li><a href="${pageContext.request.contextPath}/merchant/profile">店铺信息</a></li>
            </ul>
        </nav>

        <main class="main">
            <div class="dashboard-stats">
                <div class="stat-card">
                    <h3>商品总数</h3>
                    <p>${productCount}</p>
                </div>
                <div class="stat-card">
                    <h3>待处理订单</h3>
                    <p>${pendingOrderCount}</p>
                </div>
                <div class="stat-card">
                    <h3>待处理退货</h3>
                    <p>${pendingReturnCount}</p>
                </div>
            </div>

            <div class="recent-orders">
                <h2>最近订单</h2>
                <table class="table">
                    <thead>
                        <tr>
                            <th>订单号</th>
                            <th>客户</th>
                            <th>金额</th>
                            <th>状态</th>
<%--                            <th>操作</th>--%>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${recentOrders}" var="order">
                            <tr>
                                <td>${order.orderId}</td>
                                <td>${order.customerId}</td>
                                <td>￥${order.totalAmount}</td>
                                <td>${order.status}</td>
                                <td>
<%--                                    <a href="${pageContext.request.contextPath}/merchant/order/detail?id=${order.orderId}" class="btn btn-small">查看</a>--%>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</body>
</html>