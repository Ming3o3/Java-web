<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品列表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .search-sort-container {
            margin: 20px 0;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .search-form {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
        }
        .search-input {
            flex: 1;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        .search-button {
            padding: 8px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .search-button:hover {
            background-color: #45a049;
        }
        .sort-options {
            display: flex;
            gap: 15px;
            align-items: center;
        }
        .sort-label {
            font-weight: bold;
            color: #333;
        }
        .sort-select {
            padding: 6px 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: white;
            cursor: pointer;
        }
        .products {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            padding: 20px 0;
        }
        .product-card {
            background: white;
            border-radius: 8px;
            padding: 15px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        .product-card:hover {
            transform: translateY(-5px);
        }
        .product-card h3 {
            margin: 0 0 10px 0;
            color: #333;
        }
        .price {
            color: #e44d26;
            font-weight: bold;
            font-size: 1.2em;
            margin: 10px 0;
        }
        .stock {
            color: #666;
            margin: 5px 0;
        }
        .btn-add {
            width: 100%;
            padding: 8px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn-add:hover {
            background-color: #45a049;
        }
        .no-products {
            text-align: center;
            padding: 20px;
            color: #666;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>商品列表</h1>
            <nav>
                <a href="${pageContext.request.contextPath}/dashboard">返回首页</a>
                <a href="${pageContext.request.contextPath}/cart">购物车</a>
                <a href="${pageContext.request.contextPath}/logout">退出登录</a>
            </nav>
        </header>

        <main>
            <div class="search-sort-container">
                <form action="${pageContext.request.contextPath}/products" method="get" class="search-form">
                    <input type="text" name="keyword" value="${param.keyword}" placeholder="搜索商品..." class="search-input">
                    <button type="submit" class="search-button">搜索</button>
                </form>
                <div class="sort-options">
                    <span class="sort-label">排序方式：</span>
                    <select name="sort" class="sort-select" onchange="this.form.submit()">
                        <option value="default" ${param.sort == 'default' ? 'selected' : ''}>默认排序</option>
                        <option value="price_asc" ${param.sort == 'price_asc' ? 'selected' : ''}>价格从低到高</option>
                        <option value="price_desc" ${param.sort == 'price_desc' ? 'selected' : ''}>价格从高到低</option>
                        <option value="name_asc" ${param.sort == 'name_asc' ? 'selected' : ''}>名称 A-Z</option>
                        <option value="name_desc" ${param.sort == 'name_desc' ? 'selected' : ''}>名称 Z-A</option>
                    </select>
                </div>
            </div>

            <div class="products">
                <c:if test="${empty products}">
                    <div class="no-products">
                        没有找到相关商品
                    </div>
                </c:if>
                <c:forEach items="${products}" var="product">
                    <div class="product-card">
                        <h3>${product.name}</h3>
                        <p class="price">￥${product.price}</p>
                        <p class="stock">库存: ${product.stock}</p>
                        <form action="${pageContext.request.contextPath}/cart" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="${product.productId}">
                            <input type="number" name="quantity" value="1" min="1" max="${product.stock}">
                            <button type="submit" class="btn-add">加入购物车</button>
                        </form>
                    </div>
                </c:forEach>
            </div>
        </main>
    </div>
</body>
</html> 