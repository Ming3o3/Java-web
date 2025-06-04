<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>

        body {
            background: #f5f7fa;
            font-family: 'Microsoft YaHei', '宋体', sans-serif;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        /* 统一头部样式 */
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

        /* 按钮样式统一 */
        .btn {
            padding: 8px 20px;
            border-radius: 25px;
            transition: all 0.3s;
            text-decoration: none;
            font-weight: 500;
        }

        .btn-primary {
            background: linear-gradient(135deg, #4CAF50, #45a049);
            color: white !important;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(76,175,80,0.3);
        }

        /* 表格样式优化 */
        .product-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 12px rgba(0,0,0,0.1);
        }

        .product-table th {
            background: #4CAF50;
            color: white;
            padding: 1rem;
            font-weight: 600;
            border-bottom: 2px solid #388E3C;
        }

        .product-table td {
            padding: 1rem;
            border-bottom: 1px solid #e8f5e9;
            color: #2d3748;
            transition: all 0.2s;
        }

        .product-table tr:hover td {
            background: #ebfaee;
            transform: scale(1.02);
            box-shadow: 0 2px 8px rgba(76,175,80,0.1);
        }

        /* 操作按钮 */
        .btn-edit {
            background: linear-gradient(135deg, #2196F3, #1976D2);
            color: white !important;
        }

        .btn-delete {
            background: linear-gradient(135deg, #f44336, #d32f2f);
            color: white !important;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
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
+                       <th>商品图片</th>
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
+                           <td>
+                               <c:if test="${not empty product.imageUrl}">
+                                   <img src="${pageContext.request.contextPath}${product.imageUrl}" 
+                                        style="max-width: 100px; max-height: 100px;">
+                               </c:if>
+                           </td>
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