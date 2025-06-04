<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户登录</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* 新增背景图片样式 */
        body {
            background: url('./images/Ming.jpg'); /* 替换为你的图片URL */
            background-size: cover; /* 覆盖整个屏幕 */
            background-position: center; /* 居中显示 */
            background-attachment: fixed; /* 背景固定 */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
            margin: 0;
        }

        .container {
            background: rgba(255, 255, 255, 0.8); /* 白色半透明背景 */
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.12);
            width: 100%;
            max-width: 400px;
            text-align: center;
            position: relative;
            z-index: 1; /* 确保容器在背景上方 */
        }

        .container::before,
        .container::after {
            display: none; /* 隐藏原有装饰元素 */
        }

        h1 {
            color: #333;
            margin-bottom: 30px;
            font-size: 2.2em;
        }

        .form-group {
            margin-bottom: 25px;
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 10px;
            color: #555;
            font-weight: 500;
        }

        input {
            width: 100%;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s ease;
            box-sizing: border-box;
            outline: none;
        }

        input:focus {
            border-color: #4CAF50;
            box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.2);
        }

        button {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #4CAF50, #45a049);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
            font-weight: 500;
            letter-spacing: 0.5px;
        }

        button:hover {
            background: linear-gradient(135deg, #45a049, #4CAF50);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(76, 175, 80, 0.3);
        }

        .error {
            color: #dc3545;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        a {
            color: #4CAF50;
            text-decoration: none;
            display: block;
            margin-top: 20px;
            font-weight: 500;
        }

        a:hover {
            text-decoration: underline;
        }

        .login-icon {
            font-size: 3rem;
            color: #4CAF50;
            margin-bottom: 20px;
        }
        .btn-link {
            color: #4CAF50;
            text-decoration: none;
            display: block;
            margin-top: 15px;
            font-weight: 500;
            padding: 12px;
            border: 2px solid #4CAF50;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .btn-link:hover {
            background: rgba(76, 175, 80, 0.1);
            text-decoration: none;
            transform: translateY(-2px);
            box-shadow: 0 2px 8px rgba(76, 175, 80, 0.2);
        }

        a:hover {
            text-decoration: underline;
        }

        .login-icon {
            font-size: 3rem;
            color: #4CAF50;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <i class="fas fa-user-circle login-icon"></i>
    <h1>用户登录</h1>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-group">
            <label for="nickname">昵称：</label>
            <input type="text" id="nickname" name="nickname" required placeholder="请输入您的昵称">
        </div>

        <div class="form-group">
            <label for="password">密码：</label>
            <input type="password" id="password" name="password" required placeholder="请输入您的密码">
        </div>

        <div class="form-group">
            <button type="submit">登录</button>
        </div>

        <div class="form-group">
            <a href="${pageContext.request.contextPath}/register">还没有账号？立即注册</a>
        </div>

        <!-- 新增返回首页按钮 -->
        <div class="form-group">
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn-link">
                <i class="fas fa-home"></i>
                返回首页
            </a>
        </div>
    </form>
</div>
</body>
</html>