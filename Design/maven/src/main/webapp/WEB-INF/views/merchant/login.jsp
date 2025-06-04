<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商家登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <h1>商家登录</h1>
        
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/merchant/login" method="post" class="login-form">
            <div class="form-group">
                <label for="storeName">店铺名称：</label>
                <input type="text" id="storeName" name="storeName" required>
            </div>
            
            <div class="form-group">
                <label for="password">密码：</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div class="form-group">
                <button type="submit" class="btn btn-primary">登录</button>
            </div>
            
            <div class="form-group">
                <a href="${pageContext.request.contextPath}/merchant/register" class="btn btn-link">注册新店铺</a>
            </div>
        </form>
    </div>
</body>
</html> 