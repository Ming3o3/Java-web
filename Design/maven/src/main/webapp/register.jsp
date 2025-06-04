<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户注册</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }

        .container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
            font-size: 2em;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }

        input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            transition: border-color 0.3s ease;
            box-sizing: border-box;
        }

        input:focus {
            border-color: #4CAF50;
            outline: none;
        }

        button {
            width: 100%;
            padding: 12px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background: #45a049;
        }

        .error {
            color: #dc3545;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
        }

        small {
            display: block;
            color: #666;
            margin-top: 5px;
            font-size: 0.9em;
        }

        a {
            color: #4CAF50;
            text-decoration: none;
            display: block;
            text-align: center;
            margin-top: 15px;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>用户注册</h1>
        
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="form-group">
                <label for="nickname">昵称：</label>
                <input type="text" id="nickname" name="nickname" required>
                <small>昵称将作为您的登录名，请确保唯一性</small>
            </div>
            
            <div class="form-group">
                <label for="name">用户名：</label>
                <input type="text" id="name" name="name" required>
                <small>请输入您的真实姓名</small>
            </div>
            
            <div class="form-group">
                <label for="contactInfo">联系方式：</label>
                <input type="text" id="contactInfo" name="contactInfo" required>
                <small>请输入您的手机号码或电子邮箱</small>
            </div>
            
            <div class="form-group">
                <label for="shippingAddress">收货地址：</label>
                <input type="text" id="shippingAddress" name="shippingAddress" required>
                <small>请输入您的详细收货地址</small>
            </div>
            
            <div class="form-group">
                <label for="password">密码：</label>
                <input type="password" id="password" name="password" required>
                <small>密码长度至少6位</small>
            </div>
            
            <div class="form-group">
                <label for="confirmPassword">确认密码：</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
                <small>请再次输入密码</small>
            </div>
            
            <div class="form-group">
                <button type="submit">注册</button>
            </div>
            
            <div class="form-group">
                <a href="${pageContext.request.contextPath}/login">已有账号？立即登录</a>
            </div>
        </form>
    </div>
    
    <script>
        document.querySelector('form').addEventListener('submit', function(e) {
            var password = document.getElementById('password').value;
            var confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('两次输入的密码不一致');
            }
            
            if (password.length < 6) {
                e.preventDefault();
                alert('密码长度至少6位');
            }
        });
    </script>
</body>
</html> 