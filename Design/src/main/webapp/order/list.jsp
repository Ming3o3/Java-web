<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的订单</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>我的订单</h1>
            <nav>
                <a href="${pageContext.request.contextPath}/dashboard">返回首页</a>
                <a href="${pageContext.request.contextPath}/profile">个人信息</a>
                <a href="${pageContext.request.contextPath}/cart">购物车</a>
                <a href="${pageContext.request.contextPath}/logout">退出登录</a>
            </nav>
        </header>

        <main>
            <c:if test="${empty orders}">
                <div class="empty-orders">
                    <p>暂无订单记录</p>
                    <a href="${pageContext.request.contextPath}/products" class="btn">去购物</a>
                </div>
            </c:if>

            <c:if test="${not empty orders}">
                <div class="order-list">
                    <table>
                        <thead>
                            <tr>
                                <th>订单号</th>
                                <th>下单时间</th>
                                <th>订单状态</th>
                                <th>总金额</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${orders}" var="order">
                                <tr>
                                    <td>${order.orderId}</td>
                                    <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    <td>${order.status}</td>
                                    <td>￥${order.totalAmount}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/order/detail?id=${order.orderId}" class="btn-view">查看详情</a>
                                        <c:if test="${order.status eq '待发货'}">
                                            <form action="${pageContext.request.contextPath}/order/cancel" method="post" style="display: inline;">
                                                <input type="hidden" name="orderId" value="${order.orderId}">
                                                <button type="submit" class="btn-cancel">取消订单</button>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </main>
    </div>
</body>
</html> 