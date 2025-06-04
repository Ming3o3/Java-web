<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>店铺信息</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .profile-form {
            max-width: 600px;
            margin: 20px auto;
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
        .success-message {
            color: green;
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
        .password-section {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <div class="container">
        <header class="header">
            <h1>店铺信息</h1>
            <div class="user-info">
                欢迎，${merchant.storeName}
                <a href="${pageContext.request.contextPath}/merchant/logout" class="btn btn-link">退出</a>
            </div>
        </header>

        <nav class="nav">
            <ul>
                <li><a href="${pageContext.request.contextPath}/merchant/dashboard">返回首页</a></li>
            </ul>
        </nav>

        <div class="profile-form">
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>
            
            <c:if test="${not empty success}">
                <div class="success-message">${success}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/merchant/profile" method="post">
                <div class="form-group">
                    <label for="storeName">店铺名称：</label>
                    <input type="text" id="storeName" value="${merchant.storeName}" readonly>
                </div>

                <div class="form-group">
                    <label for="name">负责人姓名：</label>
                    <input type="text" id="name" name="name" value="${merchant.name}" required>
                </div>

                <div class="form-group">
                    <label for="contactInfo">联系方式：</label>
                    <input type="text" id="contactInfo" name="contactInfo" value="${merchant.contactInfo}" required>
                </div>

                <div class="form-group">
                    <label for="address">店铺地址：</label>
                    <input type="text" id="address" name="address" value="${merchant.address}" required>
                </div>

                <div class="password-section">
                    <h3>修改密码</h3>
                    <div class="form-group">
                        <label for="currentPassword">当前密码：</label>
                        <input type="password" id="currentPassword" name="currentPassword">
                    </div>

                    <div class="form-group">
                        <label for="newPassword">新密码：</label>
                        <input type="password" id="newPassword" name="newPassword">
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword">确认新密码：</label>
                        <input type="password" id="confirmPassword" name="confirmPassword">
                    </div>
                </div>

                <button type="submit" class="submit-btn">保存修改</button>
            </form>
        </div>
    </div>
</body>
</html> 