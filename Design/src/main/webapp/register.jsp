<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户注册 - 商城平台</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/fontawesome/css/all.min.css">
    <style>
        :root {
            --primary-color: #4CAF50;
            --secondary-color: #388E3C;
            --neutral-light: #F8F9FA;
            --neutral-dark: #212529;
            --error-color: #DC3545;
            --success-color: #198754;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', system-ui, sans-serif;
        }

        /* 新增背景图样式 */
        body {
            background: url('./images/Ming.jpg'); /* 替换为实际图片路径 */
            background-size: cover; /* 覆盖整个屏幕 */
            background-position: center; /* 居中显示 */
            background-attachment: fixed; /* 背景固定 */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
            margin: 0;
            min-width: 320px;
        }

        /* 背景半透明遮罩 */
        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255,255,255,0.8); /* 白色半透明遮罩（透明度0.8） */
        }

        .register-container {
            background: transparent; /* 容器背景透明 */
            border-radius: 20px;
            box-shadow: 0 12px 40px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 600px;
            padding: 2.5rem;
            position: relative;
            z-index: 1; /* 确保容器在遮罩上方 */
        }

        .logo-area {
            text-align: center;
            margin-bottom: 2rem;
        }

        .logo-area h1 {
            color: var(--neutral-dark);
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .logo-area p {
            color: var(--secondary-color);
            font-size: 1.1rem;
            font-weight: 500;
        }

        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
            gap: 1rem;
        }

        .form-label {
            flex: 0 0 120px;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 0.95rem;
            font-weight: 500;
            color: var(--neutral-dark);
        }

        .form-label i {
            color: var(--primary-color);
            font-size: 1.1rem;
            width: 20px;
            text-align: center;
        }

        .input-wrapper {
            flex: 1;
            position: relative;
        }

        .form-control {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            font-size: 1rem;
            color: var(--neutral-dark);
            transition: all 0.3s ease;
            background: white; /* 输入框白色背景 */
            padding-left: 42px;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(76,175,80,0.15);
            outline: none;
        }

        .input-icon {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
            font-size: 1.1rem;
        }

        .error-message {
            display: none;
            font-size: 0.85rem;
            color: var(--error-color);
            margin-top: 0.5rem;
            padding-left: 42px;
        }

        .submit-btn {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.05rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 1.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .submit-btn:hover {
            opacity: 0.95;
            box-shadow: 0 4px 15px rgba(76,175,80,0.25);
        }

        .login-link {
            text-align: center;
            margin-top: 1.5rem;
            font-size: 0.95rem;
            color: var(--neutral-dark);
        }

        .login-link a {
            color: var(--primary-color);
            font-weight: 600;
            text-decoration: none;
            position: relative;
        }

        .login-link a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--primary-color);
            transition: width 0.3s ease;
        }

        .login-link a:hover::after {
            width: 100%;
        }

        .alert {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .alert-error {
            background: #f8d7da;
            color: var(--error-color);
            border-left: 4px solid var(--error-color);
        }

        @media (max-width: 576px) {
            .form-group {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }

            .form-label {
                flex: 0 0 auto;
                width: 100%;
                padding-left: 10px;
            }

            .input-wrapper {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<!-- 背景遮罩通过CSS伪元素实现，无需修改HTML结构 -->
<div class="register-container">
    <div class="logo-area">
        <h1>用户注册</h1>
        <p>开启您的购物新体验</p>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-error show-error">
            <i class="fas fa-exclamation-triangle"></i>
                ${error}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post">
        <!-- 昵称输入 -->
        <div class="form-group">
            <label class="form-label" for="nickname">
                <i class="fas fa-user-tag"></i>
                昵称
            </label>
            <div class="input-wrapper">
                <i class="fas fa-pencil-alt input-icon"></i>
                <input type="text" id="nickname" name="nickname"
                       class="form-control" placeholder="请输入昵称" required>
            </div>
            <small class="error-message">昵称已被占用</small>
        </div>

        <!-- 用户名输入 -->
        <div class="form-group">
            <label class="form-label" for="name">
                <i class="fas fa-user"></i>
                用户名
            </label>
            <div class="input-wrapper">
                <i class="fas fa-signature input-icon"></i>
                <input type="text" id="name" name="name"
                       class="form-control" placeholder="请输入真实姓名" required>
            </div>
            <small class="error-message">请输入真实姓名</small>
        </div>

        <!-- 联系方式 -->
        <div class="form-group">
            <label class="form-label" for="contactInfo">
                <i class="fas fa-phone"></i>
                联系方式
            </label>
            <div class="input-wrapper">
                <i class="fas fa-mobile-alt input-icon"></i>
                <input type="text" id="contactInfo" name="contactInfo"
                       class="form-control" placeholder="请输入手机号码" required>
            </div>
            <small class="error-message">请输入有效联系方式</small>
        </div>

        <!-- 收货地址 -->
        <div class="form-group">
            <label class="form-label" for="shippingAddress">
                <i class="fas fa-map"></i>
                收货地址
            </label>
            <div class="input-wrapper">
                <i class="fas fa-map-marker-alt input-icon"></i>
                <input type="text" id="shippingAddress" name="shippingAddress"
                       class="form-control" placeholder="请输入详细地址" required>
            </div>
            <small class="error-message">请输入详细收货地址</small>
        </div>

        <!-- 密码输入 -->
        <div class="form-group">
            <label class="form-label" for="password">
                <i class="fas fa-lock"></i>
                密码
            </label>
            <div class="input-wrapper">
                <i class="fas fa-key input-icon"></i>
                <input type="password" id="password" name="password"
                       class="form-control" placeholder="至少6位字符" required>
            </div>
            <small class="error-message">密码长度至少6位</small>
        </div>

        <!-- 确认密码 -->
        <div class="form-group">
            <label class="form-label" for="confirmPassword">
                <i class="fas fa-lock"></i>
                确认密码
            </label>
            <div class="input-wrapper">
                <i class="fas fa-key input-icon"></i>
                <input type="password" id="confirmPassword" name="confirmPassword"
                       class="form-control" placeholder="再次输入密码" required>
            </div>
            <small class="error-message">两次密码输入不一致</small>
        </div>

        <button type="submit" class="submit-btn">
            <i class="fas fa-user-plus"></i>
            立即注册
        </button>

        <div class="login-link">
            已有账号？ <a href="${pageContext.request.contextPath}/login">立即登录</a>
        </div>
    </form>
</div>

<script>
    document.querySelector('form').addEventListener('submit', function(e) {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

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