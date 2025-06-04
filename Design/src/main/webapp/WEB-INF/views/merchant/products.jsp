<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>

        /* 全局样式 */
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
        }

        /* 头部样式 */
        header {
            background-color: #fff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        header h1 {
            margin: 0;
            color: #333;
        }

        nav {
            margin-top: 15px;
        }

        nav a {
            color: #666;
            text-decoration: none;
            margin-right: 20px;
            padding: 5px 10px;
            border-radius: 3px;
        }

        nav a:hover {
            background-color: #f0f0f0;
        }

        /* 主要内容区域 */
        main {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        section {
            margin-bottom: 30px;
        }

        section h2 {
            color: #333;
            border-bottom: 2px solid #eee;
            padding-bottom: 10px;
        }

        /* 表单样式 */
        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #666;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }

        /* 表格样式 */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f8f8f8;
        }

        /* 错误消息样式 */
        .error {
            color: #dc3545;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
        }

        /* 成功消息样式 */
        .success {
            color: #28a745;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
        }

        /* 用户信息样式 */
        .user-info p {
            margin: 5px 0;
            color: #666;
        }

        /* 链接样式 */
        a {
            color: #007bff;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        /* 取消订单按钮样式 */
        .btn-cancel {
            background-color: #dc3545;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 10px;
        }

        .btn-cancel:hover {
            background-color: #c82333;
        }

        /* 购物车样式 */
        .empty-cart {
            text-align: center;
            padding: 40px;
            background-color: #f8f9fa;
            border-radius: 8px;
            margin: 20px 0;
        }

        .empty-cart p {
            margin-bottom: 20px;
            color: #666;
        }

        .quantity-form {
            display: inline-block;
        }

        .quantity-form input[type="number"] {
            width: 60px;
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .btn-remove {
            background-color: #dc3545;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-remove:hover {
            background-color: #c82333;
        }

        .btn-clear {
            background-color: #6c757d;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }

        .btn-clear:hover {
            background-color: #5a6268;
        }

        .btn-checkout {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-checkout:hover {
            background-color: #218838;
        }

        .cart-actions {
            margin-top: 20px;
            text-align: right;
        }

        .text-right {
            text-align: right;
        }

        /* 订单列表样式 */
        .empty-orders {
            text-align: center;
            padding: 40px;
            background-color: #f8f9fa;
            border-radius: 8px;
            margin: 20px 0;
        }

        .empty-orders p {
            margin-bottom: 20px;
            color: #666;
        }

        .btn-view {
            background-color: #17a2b8;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            display: inline-block;
            margin-right: 10px;
        }

        .btn-view:hover {
            background-color: #138496;
            text-decoration: none;
        }

        .order-list {
            margin-top: 20px;
        }

        /* 订单列表页面样式 */
        .order-card {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            padding: 20px;
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .order-info {
            display: flex;
            gap: 20px;
        }

        .order-info span {
            color: #666;
        }

        .order-status {
            color: #e74c3c !important;
            font-weight: bold;
        }

        .order-actions {
            display: flex;
            gap: 10px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin: 15px 0;
        }

        .table th,
        .table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        .table th {
            background-color: #f8f9fa;
            font-weight: 600;
        }

        .order-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }

        .order-total {
            font-size: 1.2em;
            font-weight: bold;
        }

        .price {
            color: #e74c3c;
        }

        .shipping-address {
            color: #666;
        }

        .btn {
            display: inline-block;
            padding: 8px 16px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }

        .btn:hover {
            background-color: #2980b9;
        }

        .btn-danger {
            background-color: #e74c3c;
        }

        .btn-danger:hover {
            background-color: #c0392b;
        }

        .empty-message {
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 1.2em;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
            border: 1px solid #f5c6cb;
        }

        /* 登录和注册页面特定样式 */
        body.login-page,
        body.register-page {
            background: #f5f7fa;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }

        .login-page .container,
        .register-page .container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        .login-page h1,
        .register-page h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
            font-size: 2em;
        }

        .login-page .form-group,
        .register-page .form-group {
            margin-bottom: 20px;
        }

        .login-page label,
        .register-page label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }

        .login-page input,
        .register-page input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }

        .login-page input:focus,
        .register-page input:focus {
            border-color: #4CAF50;
            outline: none;
        }

        .login-page button,
        .register-page button {
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

        .login-page button:hover,
        .register-page button:hover {
            background: #45a049;
        }

        .login-page .error,
        .register-page .error {
            color: #dc3545;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
        }

        .login-page small,
        .register-page small {
            display: block;
            color: #666;
            margin-top: 5px;
            font-size: 0.9em;
        }

        .product-list {
            margin: 20px 0;
        }
        .product-table {
            width: 100%;
            border-collapse: collapse;
        }
        .product-table th, .product-table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        .product-table th {
            background-color: #f5f5f5;
        }
        .action-buttons {
            display: flex;
            gap: 10px;
        }
        .btn {
            padding: 5px 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary {
            background-color: #4CAF50;
            color: white;
        }
        .btn-edit {
            background-color: #2196F3;
            color: white;
        }
        .btn-delete {
            background-color: #f44336;
            color: white;
        }
        .add-product {
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <header class="header">
            <h1>商品管理</h1>
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

        <div class="add-product">
            <a href="${pageContext.request.contextPath}/merchant/product/add" class="btn btn-primary">添加新商品</a>
        </div>

        <div class="product-list">
            <table class="product-table">
                <thead>
                    <tr>
                        <th>商品ID</th>
                        <th>商品名称</th>
                        <th>价格</th>
                        <th>库存</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${products}" var="product">
                        <tr>
                            <td>${product.productId}</td>
                            <td>${product.name}</td>
                            <td>￥${product.price}</td>
                            <td>${product.stock}</td>
                            <td>${product.status}</td>
                            <td class="action-buttons">
                                <a href="${pageContext.request.contextPath}/merchant/product/edit?id=${product.productId}"
                                   class="btn btn-edit">编辑</a>
                                <a href="${pageContext.request.contextPath}/merchant/product/delete?id=${product.productId}"
                                   class="btn btn-delete"
                                   onclick="return confirm('确定要删除这个商品吗？')">删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>