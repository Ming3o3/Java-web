<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品列表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            background: #f5f7fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        header {
            background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        header h1 {
            margin: 0;
            font-size: 2em;
            font-weight: 600;
        }

        nav {
            margin-top: 15px;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        nav a {
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 20px;
            background: rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        nav a:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }

        .search-sort-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .search-form {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .search-input {
            flex: 1;
            padding: 12px 16px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: #4CAF50;
        }

        .search-button {
            padding: 12px 24px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .search-button:hover {
            background: #45a049;
            transform: translateY(-2px);
        }

        .sort-options {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .sort-label {
            font-weight: 500;
            color: #333;
        }

        .sort-select {
            padding: 8px 16px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            background-color: white;
            cursor: pointer;
            transition: border-color 0.3s ease;
        }

        .sort-select:focus {
            outline: none;
            border-color: #4CAF50;
        }

        .products {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
            padding: 20px 0;
        }

        .product-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .product-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-bottom: 1px solid #f0f0f0;
        }

        .product-info {
            padding: 20px;
        }

        .product-card h3 {
            margin: 0 0 10px 0;
            color: #333;
            font-size: 1.2em;
            font-weight: 600;
        }

        .price {
            color: #e44d26;
            font-weight: bold;
            font-size: 1.3em;
            margin: 10px 0;
        }

        .stock {
            color: #666;
            margin: 5px 0;
            font-size: 0.9em;
        }

        .add-to-cart-form {
            margin-top: 15px;
        }

        .quantity-input {
            width: 60px;
            padding: 8px;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            margin-right: 10px;
            text-align: center;
        }

        .quantity-input:focus {
            outline: none;
            border-color: #4CAF50;
        }

        .btn-add {
            width: 100%;
            padding: 12px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
            margin-top: 10px;
        }

        .btn-add:hover {
            background: #45a049;
            transform: translateY(-2px);
        }

        .no-products {
            text-align: center;
            padding: 40px;
            color: #666;
            font-style: italic;
            background: white;
            border-radius: 10px;
            margin: 20px 0;
        }

        @media (max-width: 768px) {
            .search-form {
                flex-direction: column;
            }

            .search-button {
                width: 100%;
            }

            .products {
                grid-template-columns: 1fr;
            }

            nav {
                justify-content: center;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>商品列表</h1>
            <nav>
                <a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-home"></i> 返回首页</a>
                <a href="${pageContext.request.contextPath}/cart"><i class="fas fa-shopping-cart"></i> 购物车</a>
                <a href="${pageContext.request.contextPath}/order/list"><i class="fas fa-clipboard-list"></i> 我的订单</a>
                <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> 退出登录</a>
            </nav>
        </header>

        <main>
            <div class="search-sort-container">
                <form action="${pageContext.request.contextPath}/products" method="get" class="search-form" id="searchForm">
                    <input type="text" name="keyword" value="${param.keyword}" placeholder="搜索商品..." class="search-input">
                    <button type="submit" class="search-button"><i class="fas fa-search"></i> 搜索</button>
                    <div class="sort-options">
                        <span class="sort-label">排序方式：</span>
                        <select name="sort" class="sort-select" onchange="document.getElementById('searchForm').submit()">
                            <option value="default" ${param.sort == 'default' ? 'selected' : ''}>默认排序</option>
                            <option value="price_asc" ${param.sort == 'price_asc' ? 'selected' : ''}>价格从低到高</option>
                            <option value="price_desc" ${param.sort == 'price_desc' ? 'selected' : ''}>价格从高到低</option>
                            <option value="name_asc" ${param.sort == 'name_asc' ? 'selected' : ''}>名称 A-Z</option>
                            <option value="name_desc" ${param.sort == 'name_desc' ? 'selected' : ''}>名称 Z-A</option>
                        </select>
                    </div>
                </form>
            </div>

            <div class="products">
                <c:if test="${empty products}">
                    <div class="no-products">
                        <i class="fas fa-search" style="font-size: 2em; margin-bottom: 10px;"></i>
                        <p>没有找到相关商品</p>
                    </div>
                </c:if>
                <c:forEach items="${products}" var="product">
                    <div class="product-card">
                        <img src="${pageContext.request.contextPath}${product.image}" alt="${product.category}" class="product-image">
                        <div class="product-info">
                            <h3>${product.category}</h3>
                            <p class="price">￥${product.price}</p>
                            <p class="stock">库存: ${product.quantity}</p>
                            <form action="${pageContext.request.contextPath}/cart" method="post" class="add-to-cart-form">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productId" value="${product.productId}">
                                <input type="number" name="quantity" value="1" min="1" max="${product.quantity}" class="quantity-input">
                                <button type="submit" class="btn-add"><i class="fas fa-cart-plus"></i> 加入购物车</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </main>
    </div>
</body>
</html> 