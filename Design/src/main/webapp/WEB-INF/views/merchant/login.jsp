<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商家登录</title>
    <style>
        /* 基础样式 */
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e7eb 100%);
            font-family: 'Segoe UI', system-ui, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            padding: 20px;
        }

        .container {
            background: white;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 450px;
            position: relative;
            overflow: hidden;
        }

        /* 装饰性元素 */
        .container::before {
            content: "";
            position: absolute;
            top: -20px;
            right: -20px;
            width: 100px;
            height: 100px;
            background: rgba(76, 175, 80, 0.1);
            border-radius: 50%;
            z-index: 0;
        }

        .container::after {
            content: "";
            position: absolute;
            bottom: -30px;
            left: -30px;
            width: 150px;
            height: 150px;
            background: rgba(76, 175, 80, 0.15);
            border-radius: 50%;
            z-index: 0;
        }

        h1 {
            text-align: center;
            color: #2d3748;
            margin-bottom: 25px;
            font-size: 2rem;
            position: relative;
            z-index: 1;
            font-weight: 600;
        }

        .error {
            background: #ffebee;
            color: #c62828;
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            position: relative;
            z-index: 1;
            border-left: 4px solid #f44336;
        }

        .error i {
            font-size: 1.2rem;
            margin-right: 8px;
        }

        .login-form {
            display: flex;
            flex-direction: column;
            gap: 20px;
            position: relative;
            z-index: 1;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        label {
            color: #4a5568;
            font-weight: 500;
            margin-bottom: 5px;
        }

        input {
            padding: 12px 15px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.25s ease;
            box-sizing: border-box;
        }

        input:focus {
            border-color: #4CAF50;
            box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.15);
            outline: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, #4CAF50, #45a049);
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #45a049, #4CAF50);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(76, 175, 80, 0.3);
        }

        .btn-link {
            background: none;
            color: #4CAF50;
            text-align: center;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
        }

        .btn-link:hover {
            color: #3d8b40;
            text-decoration: underline;
        }

        /* 图标样式 */
        .icon-container {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
            position: relative;
            z-index: 1;
        }

        .icon {
            font-size: 2.5rem;
            color: #4CAF50;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0px); }
        }

        /* 响应式设计 */
        @media (max-width: 480px) {
            .container {
                padding: 20px 15px;
            }
            h1 {
                font-size: 1.5rem;
            }
            .icon {
                font-size: 2rem;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<div class="container">
    <div class="icon-container">
        <i class="fas fa-store icon"></i>
    </div>
    <h1>商家登录</h1>

    <c:if test="${not empty error}">
        <div class="error">
            <i class="fas fa-exclamation-circle"></i>
                ${error}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/merchant/login" method="post" class="login-form">
        <div class="form-group">
            <label for="storeName">店铺名称：</label>
            <input type="text" id="storeName" name="storeName" required placeholder="请输入店铺名称">
        </div>

        <div class="form-group">
            <label for="password">密码：</label>
            <input type="password" id="password" name="password" required placeholder="请输入密码">
        </div>

        <div class="form-group">
            <button type="submit" class="btn-primary">
                <i class="fas fa-sign-in-alt"></i>
                登录
            </button>
        </div>

        <div class="form-group">
            <a href="${pageContext.request.contextPath}/merchant/register" class="btn-link">
                <i class="fas fa-user-plus"></i>
                注册新店铺
            </a>
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