<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>商家注册</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .register-form {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
            background: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .error-message {
            color: red;
            margin-bottom: 15px;
        }
        .submit-btn {
            background: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }
        .submit-btn:hover {
            background: #45a049;
        }
        .login-link {
            text-align: center;
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <div class="register-form">
        <h2>商家注册</h2>
        
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/merchant/register" method="post">
            <div class="form-group">
                <label for="storeName">店铺名称：</label>
                <input type="text" id="storeName" name="storeName" required>
            </div>

            <div class="form-group">
                <label for="name">负责人姓名：</label>
                <input type="text" id="name" name="name" required>
            </div>

            <div class="form-group">
                <label for="contactInfo">联系方式：</label>
                <input type="text" id="contactInfo" name="contactInfo" required>
            </div>

            <div class="form-group">
                <label for="address">店铺地址：</label>
                <input type="text" id="address" name="address" required>
            </div>

            <div class="form-group">
                <label for="password">密码：</label>
                <input type="password" id="password" name="password" required>
            </div>

            <div class="form-group">
                <label for="confirmPassword">确认密码：</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>

            <button type="submit" class="submit-btn">注册</button>
        </form>

        <div class="login-link">
            已有账号？<a href="${pageContext.request.contextPath}/merchant/login">立即登录</a>
        </div>
    </div>
</body>
</html> 