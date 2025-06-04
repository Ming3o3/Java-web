<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>店铺信息管理</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        /* 基础样式 */
        body {
            background: #f8f9fa;
            font-family: 'Segoe UI', system-ui, sans-serif;
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        /* 头部样式 */
        .header {
            background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
            color: white;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-top: 0;
        }

        .header h1 {
            margin: 0;
            font-size: 1.8rem;
        }

        .welcome-text {
            font-size: 1.1rem;
            letter-spacing: 0.5px;
            padding: 0 8px;
        }

        /* 按钮通用样式 */
        .btn-link, .btn-home {
            color: #fff !important;
            padding: 8px 20px;
            border-radius: 25px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid rgba(255,255,255,0.3);
            text-decoration: none;
            font-weight: 500;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .btn-link {
            background: linear-gradient(135deg, rgba(255,255,255,0.2), rgba(255,255,255,0.15));
        }

        .btn-home {
            background: linear-gradient(135deg, rgba(255,255,255,0.1), rgba(255,255,255,0.05));
        }

        .btn-link:hover, .btn-home:hover {
            background: linear-gradient(135deg, rgba(255,255,255,0.3), rgba(255,255,255,0.25));
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }

        /* 表单样式 */
        .profile-form {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            padding: 2rem;
            max-width: 700px; /* 限制表单最大宽度 */
            margin: 0 auto; /* 居中显示 */
        }

        /* 标签图标组合 */
        .label-icon {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 0.5rem;
        }

        .label-icon i {
            color: #4CAF50;
            font-size: 1rem;
            width: 20px;
            text-align: center;
        }

        /* 输入框样式 */
        .form-group {
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center; /* 垂直居中对齐 */
            gap: 1rem; /* 标签和输入框之间的间距 */
        }

        .form-group label {
            min-width: 120px; /* 标签最小宽度 */
            color: #64748b;
            font-weight: 500;
            text-align: right; /* 标签文字右对齐 */
        }

        .form-group input {
            flex: 1; /* 输入框占满剩余空间 */
            padding: 12px 16px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            transition: all 0.2s;
            font-size: 1rem;
        }

        .form-group input:focus {
            border-color: #4CAF50;
            box-shadow: 0 0 0 3px rgba(76,175,80,0.1);
            outline: none;
        }

        /* 密码区域 */
        .password-info {
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid #e2e8f0; /* 添加分隔线 */
        }

        .password-info h3 {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #1e293b;
            margin: 0 0 1.5rem;
        }

        /* 按钮样式 */
        .submit-btn {
            width: 100%;
            max-width: 300px;
            background: linear-gradient(135deg, #4CAF50, #45a049);
            color: white;
            padding: 14px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            margin-top: 2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin-left: auto;
            margin-right: auto;
        }

        /* 消息提示 */
        .error-message, .success-message {
            margin: 0 0 1.5rem;
        }

        /* 响应式调整 */
        @media (max-width: 600px) {
            .form-group {
                flex-direction: column;
                align-items: flex-start;
            }

            .form-group label {
                text-align: left;
                margin-bottom: 0.5rem;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <header class="header">
        <h1>店铺信息管理</h1>
        <div class="user-info">
            <span class="welcome-text">欢迎，${merchant.storeName}</span>
            <a href="${pageContext.request.contextPath}/merchant/dashboard" class="btn-home">返回首页</a>
            <a href="${pageContext.request.contextPath}/merchant/logout" class="btn-link">退出</a>
        </div>
    </header>

    <div class="profile-form">
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="success-message">${success}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/merchant/profile" method="post">
            <!-- 基本信息 -->
            <div class="basic-info">
                <h3>
                    <i class="fas fa-info-circle"></i>
                    <span>基本信息</span>
                </h3>

                <div class="form-group">
                    <label for="storeName" class="label-icon">
                        <i class="fas fa-store"></i>
                        <span>店铺名称</span>
                    </label>
                    <input type="text" id="storeName" value="${merchant.storeName}" readonly>
                </div>

                <div class="form-group">
                    <label for="name" class="label-icon">
                        <i class="fas fa-user-tie"></i>
                        <span>负责人</span>
                    </label>
                    <input type="text" id="name" name="name" value="${merchant.name}" required>
                </div>

                <div class="form-group">
                    <label for="contactInfo" class="label-icon">
                        <i class="fas fa-phone"></i>
                        <span>联系方式</span>
                    </label>
                    <input type="text" id="contactInfo" name="contactInfo" value="${merchant.contactInfo}" required>
                </div>

                <div class="form-group">
                    <label for="address" class="label-icon">
                        <i class="fas fa-map-marked-alt"></i>
                        <span>店铺地址</span>
                    </label>
                    <input type="text" id="address" name="address" value="${merchant.address}" required>
                </div>
            </div>

            <!-- 密码修改 -->
            <div class="password-info">
                <h3>
                    <i class="fas fa-lock"></i>
                    <span>安全设置</span>
                </h3>

                <div class="form-group">
                    <label for="currentPassword" class="label-icon">
                        <i class="fas fa-key"></i>
                        <span>当前密码</span>
                    </label>
                    <input type="password" id="currentPassword" name="currentPassword">
                </div>

                <div class="form-group">
                    <label for="newPassword" class="label-icon">
                        <i class="fas fa-key"></i>
                        <span>新密码</span>
                    </label>
                    <input type="password" id="newPassword" name="newPassword">
                </div>

                <div class="form-group">
                    <label for="confirmPassword" class="label-icon">
                        <i class="fas fa-key"></i>
                        <span>确认密码</span>
                    </label>
                    <input type="password" id="confirmPassword" name="confirmPassword">
                </div>
            </div>

            <button type="submit" class="submit-btn">
                <i class="fas fa-save"></i>
                保存变更
            </button>
        </form>
    </div>
</div>
</body>
</html>