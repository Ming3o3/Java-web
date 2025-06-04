<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>个人信息</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>个人信息</h1>
            <nav>
                <a href="${pageContext.request.contextPath}/dashboard">返回首页</a>
                <a href="${pageContext.request.contextPath}/order">我的订单</a>
                <a href="${pageContext.request.contextPath}/cart">购物车</a>
                <a href="${pageContext.request.contextPath}/logout">退出登录</a>
            </nav>
        </header>

        <main>
            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>
            
            <c:if test="${not empty success}">
                <div class="success">${success}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/profile" method="post">
                <div class="form-group">
                    <label for="nickname">昵称：</label>
                    <input type="text" id="nickname" name="nickname" value="${customer.nickname}" required>
                </div>

                <div class="form-group">
                    <label for="name">用户名：</label>
                    <input type="text" id="name" name="name" value="${customer.name}" required>
                </div>

                <div class="form-group">
                    <label for="contactInfo">联系方式：</label>
                    <input type="text" id="contactInfo" name="contactInfo" value="${customer.contactInfo}" required>
                </div>

                <div class="form-group">
                    <label for="shippingAddress">收货地址：</label>
                    <input type="text" id="shippingAddress" name="shippingAddress" value="${customer.shippingAddress}" required>
                </div>

                <div class="form-group">
                    <label for="currentPassword">当前密码：</label>
                    <input type="password" id="currentPassword" name="currentPassword">
                    <small>如果要修改密码，请填写当前密码</small>
                </div>

                <div class="form-group">
                    <label for="newPassword">新密码：</label>
                    <input type="password" id="newPassword" name="newPassword">
                    <small>如果要修改密码，请填写新密码</small>
                </div>

                <div class="form-group">
                    <button type="submit">保存修改</button>
                </div>
            </form>
        </main>
    </div>
</body>
</html> 