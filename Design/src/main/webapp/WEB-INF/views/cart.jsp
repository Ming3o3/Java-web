<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>购物车</title>
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

        .cart-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .cart-items {
            margin-bottom: 20px;
        }

        .cart-item {
            display: grid;
            grid-template-columns: 100px 2fr 1fr 1fr 1fr auto;
            gap: 20px;
            align-items: center;
            padding: 20px;
            border-bottom: 1px solid #f0f0f0;
            transition: background-color 0.3s ease;
        }

        .cart-item:hover {
            background-color: #f8f9fa;
        }

        .cart-item:last-child {
            border-bottom: none;
        }

        .item-image {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
        }

        .item-info h3 {
            margin: 0 0 5px 0;
            color: #333;
            font-size: 1.2em;
        }

        .item-price {
            color: #e44d26;
            font-weight: bold;
            font-size: 1.1em;
        }

        .quantity-input {
            width: 80px;
            padding: 8px;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            text-align: center;
            transition: border-color 0.3s ease;
        }

        .quantity-input:focus {
            outline: none;
            border-color: #4CAF50;
        }

        .item-total {
            font-weight: bold;
            color: #333;
        }

        .remove-btn {
            padding: 8px 16px;
            background: #ff4444;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .remove-btn:hover {
            background: #cc0000;
            transform: translateY(-2px);
        }

        .cart-summary {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-top: 20px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 1.1em;
        }

        .summary-row.total {
            font-size: 1.3em;
            font-weight: bold;
            color: #e44d26;
            border-top: 2px solid #e0e0e0;
            padding-top: 10px;
            margin-top: 10px;
        }

        .checkout-btn {
            display: block;
            width: 100%;
            padding: 15px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.2em;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 20px;
            text-align: center;
            text-decoration: none;
        }

        .checkout-btn:hover {
            background: #45a049;
            transform: translateY(-2px);
        }

        .empty-cart {
            text-align: center;
            padding: 40px;
            color: #666;
        }

        .empty-cart i {
            font-size: 3em;
            color: #ccc;
            margin-bottom: 20px;
        }

        .empty-cart p {
            font-size: 1.2em;
            margin-bottom: 20px;
        }

        .continue-shopping {
            display: inline-block;
            padding: 10px 20px;
            background: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        .continue-shopping:hover {
            background: #45a049;
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {
            .cart-item {
                grid-template-columns: 80px 1fr;
                gap: 10px;
                padding: 15px;
            }

            .item-image {
                width: 80px;
                height: 80px;
            }

            .item-info {
                grid-column: 2;
            }

            .item-price, .quantity-input, .item-total {
                grid-column: 2;
            }

            .remove-btn {
                grid-column: 2;
                justify-self: start;
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
            <h1>购物车</h1>
            <nav>
                <a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-home"></i> 返回首页</a>
                <a href="${pageContext.request.contextPath}/products"><i class="fas fa-shopping-bag"></i> 继续购物</a>
                <a href="${pageContext.request.contextPath}/order/list"><i class="fas fa-clipboard-list"></i> 我的订单</a>
                <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> 退出登录</a>
            </nav>
        </header>

        <main>
            <div class="cart-container">
                <c:if test="${empty cartItems}">
                    <div class="empty-cart">
                        <i class="fas fa-shopping-cart"></i>
                        <p>您的购物车是空的</p>
                        <a href="${pageContext.request.contextPath}/products" class="continue-shopping">
                            <i class="fas fa-shopping-bag"></i> 去购物
                        </a>
                    </div>
                </c:if>

                <c:if test="${not empty cartItems}">
                    <div class="cart-items">
                        <c:forEach items="${cartItems}" var="item">
                            <div class="cart-item">
<%--                                <img src="${item.product.image}" alt="${item.product.category}" class="item-image">--%>
                                <div class="item-info">
                                    <h3>${item.product.category}</h3>
                                    <p class="item-price">￥${item.product.price}</p>
                                </div>
                                <div class="quantity-control">
                                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="cartItemId" value="${item.cartItemId}">
                                        <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.product.quantity}" 
                                               class="quantity-input" onchange="this.form.submit()">
                                    </form>
                                </div>
                                <div class="item-total">
                                    ￥${item.product.price * item.quantity}
                                </div>
                                <form action="${pageContext.request.contextPath}/cart" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="cartItemId" value="${item.cartItemId}">
                                    <button type="submit" class="remove-btn">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </form>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="cart-summary">
                        <div class="summary-row">
                            <span>商品总数：</span>
                            <span>${totalItems} 件</span>
                        </div>
                        <div class="summary-row total">
                            <span>总计：</span>
                            <span>￥${totalAmount}</span>
                        </div>
                        <form action="${pageContext.request.contextPath}/order/create" method="post" style="margin-top: 20px;">
                            <button type="submit" class="checkout-btn">
                                <i class="fas fa-credit-card"></i> 去结算
                            </button>
                        </form>
                    </div>
                </c:if>
            </div>
        </main>
    </div>
</body>
</html> 