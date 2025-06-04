<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户中心</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>欢迎回来，${customer.nickname}</h1>
            <nav>
                <a href="${pageContext.request.contextPath}/profile">个人信息</a>
                <a href="${pageContext.request.contextPath}/order">我的订单</a>
                <a href="${pageContext.request.contextPath}/cart">购物车</a>
                <a href="${pageContext.request.contextPath}/logout">退出登录</a>
            </nav>
        </header>

        <main>
            <section class="user-info">
                <h2>个人信息</h2>
                <p>昵称：${customer.nickname}</p>
                <p>姓名：${customer.name}</p>
                <p>联系方式：${customer.contactInfo}</p>
                <p>收货地址：${customer.shippingAddress}</p>
            </section>

            <section class="recent-orders">
                <h2>最近订单</h2>
                <c:if test="${empty recentOrders}">
                    <p>暂无订单记录</p>
                </c:if>
                <c:if test="${not empty recentOrders}">
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
                            <c:forEach items="${recentOrders}" var="order">
                                <tr>
                                    <td>${order.orderId}</td>
                                    <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    <td>${order.status}</td>
                                    <td>￥${order.totalAmount}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/order/detail?orderId=${order.orderId}">查看详情</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </section>
        </main>
    </div>
</body>
</html> 