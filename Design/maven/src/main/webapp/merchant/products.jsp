<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品管理</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* 基础样式 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: #f5f7fa;
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
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .header h1 {
            margin: 0;
            font-size: 1.8rem;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        /* 导航栏样式 */
        .nav ul {
            list-style: none;
            display: flex;
            gap: 20px;
            margin: 0;
            padding: 0;
        }

        .nav a {
            color: #4a5568;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 20px;
            background: rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav a:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }

        /* 主要内容区域 */
        main {
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        /* 按钮样式 */
        .btn {
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #4CAF50, #45a049);
            color: white;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #45a049, #4CAF50);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(76, 175, 80, 0.3);
        }

        .btn-edit {
            background: linear-gradient(135deg, #2196F3, #1976D2);
            color: white;
        }

        .btn-edit:hover {
            background: linear-gradient(135deg, #1976D2, #2196F3);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(33, 150, 243, 0.3);
        }

        .btn-delete {
            background: linear-gradient(135deg, #f44336, #d32f2f);
            color: white;
        }

        .btn-delete:hover {
            background: linear-gradient(135deg, #d32f2f, #f44336);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(244, 67, 54, 0.3);
        }

        /* 表格样式 */
        .product-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .product-table th,
        .product-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eaeaea;
        }

        .product-table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #4a5568;
        }

        .product-table tr:hover {
            background-color: #f8f9fa;
        }

        .product-table tr:last-child td {
            border-bottom: none;
        }

        /* 操作按钮区域 */
        .action-buttons {
            display: flex;
            gap: 10px;
        }

        /* 添加商品按钮 */
        .add-product {
            margin-bottom: 20px;
        }

        .add-product .btn-primary {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 15px;
            }

            .nav ul {
                flex-wrap: wrap;
            }

            .product-table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <header class="header">
        <h1>商品管理</h1>
        <div class="user-info">
            <span>欢迎，${merchant.storeName}</span>
            <a href="${pageContext.request.contextPath}/merchant/logout" class="btn btn-link">
                <i class="fas fa-sign-out-alt"></i>
                退出
            </a>
        </div>
    </header>

    <nav class="nav">
        <ul>
            <li>
                <a href="${pageContext.request.contextPath}/merchant/dashboard">
                    <i class="fas fa-home"></i>
                    返回首页
                </a>
            </li>
        </ul>
    </nav>

    <main>
        <div class="add-product">
            <a href="${pageContext.request.contextPath}/merchant/product/add" class="btn btn-primary">
                <i class="fas fa-plus"></i>
                添加新商品
            </a>
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
                            <a href="${pageContext.request.contextPath}/merchant/product/edit?id=${product.productId}" class="btn btn-edit">
                                <i class="fas fa-edit"></i>
                                编辑
                            </a>
                            <a href="${pageContext.request.contextPath}/merchant/product/delete?id=${product.productId}" class="btn btn-delete" onclick="return confirm('确定要删除这个商品吗？')">
                                <i class="fas fa-trash"></i>
                                删除
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </main>
</div>
</body>
</html>