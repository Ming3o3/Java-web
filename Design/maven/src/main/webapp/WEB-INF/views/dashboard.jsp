<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户中心</title>
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
        }

        nav a {
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 20px;
            background: rgba(255, 255, 255, 0.2);
            margin-right: 10px;
            transition: all 0.3s ease;
        }

        nav a:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .dashboard-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .card-icon {
            width: 40px;
            height: 40px;
            background: #e8f5e9;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
        }

        .card-icon i {
            color: #4CAF50;
            font-size: 20px;
        }

        .card-title {
            font-size: 1.2em;
            font-weight: 600;
            color: #333;
            margin: 0;
        }

        .card-content {
            color: #666;
            line-height: 1.6;
        }

        .action-button {
            display: inline-block;
            padding: 10px 20px;
            background: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background 0.3s ease;
            border: none;
            cursor: pointer;
            font-size: 1em;
            margin-top: 10px;
        }

        .action-button:hover {
            background: #45a049;
        }

        .welcome-message {
            background: white;
            border-radius: 10px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .welcome-message h2 {
            color: #333;
            margin-top: 0;
            font-size: 1.8em;
            margin-bottom: 15px;
        }

        .welcome-message p {
            color: #666;
            line-height: 1.6;
            margin: 0;
        }

        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .stat-number {
            font-size: 2em;
            font-weight: bold;
            color: #4CAF50;
            margin: 10px 0;
        }

        .stat-label {
            color: #666;
            font-size: 0.9em;
        }

        @media (max-width: 768px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
            }

            .stats-container {
                grid-template-columns: 1fr;
            }

            nav {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
            }

            nav a {
                margin-right: 0;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>用户中心</h1>
            <nav>
                <a href="${pageContext.request.contextPath}/products">商品列表</a>
                <a href="${pageContext.request.contextPath}/cart">购物车</a>
                <a href="${pageContext.request.contextPath}/order/list">我的订单</a>
                <a href="${pageContext.request.contextPath}/logout">退出登录</a>
            </nav>
        </header>

        <div class="welcome-message">
            <h2>欢迎回来，${customer.nickname}！</h2>
            <p>在这里您可以浏览商品、管理购物车、查看订单，享受便捷的购物体验。</p>
        </div>

        <!-- <div class="stats-container">
            <div class="stat-card">
                <i class="fas fa-shopping-cart"></i>
                <div class="stat-number">${cartCount}</div>
                <div class="stat-label">购物车商品</div>
            </div>
            <div class="stat-card">
                <i class="fas fa-box"></i>
                <div class="stat-number">${orderCount}</div>
                <div class="stat-label">待处理订单</div>
            </div>
            <div class="stat-card">
                <i class="fas fa-star"></i>
                <div class="stat-number">${favoriteCount}</div>
                <div class="stat-label">收藏商品</div>
            </div>
        </div> -->

        <div class="dashboard-grid">
            <div class="dashboard-card">
                <div class="card-header">
                    <div class="card-icon">
                        <i class="fas fa-shopping-bag"></i>
                    </div>
                    <h3 class="card-title">开始购物</h3>
                </div>
                <div class="card-content">
                    <p>浏览我们精选的商品，发现更多优质好物。</p>
                    <a href="${pageContext.request.contextPath}/products" class="action-button">去购物</a>
                </div>
            </div>

            <div class="dashboard-card">
                <div class="card-header">
                    <div class="card-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <h3 class="card-title">购物车</h3>
                </div>
                <div class="card-content">
                    <p>查看购物车中的商品，准备结算。</p>
                    <a href="${pageContext.request.contextPath}/cart" class="action-button">查看购物车</a>
                </div>
            </div>

            <div class="dashboard-card">
                <div class="card-header">
                    <div class="card-icon">
                        <i class="fas fa-clipboard-list"></i>
                    </div>
                    <h3 class="card-title">我的订单</h3>
                </div>
                <div class="card-content">
                    <p>查看订单历史，跟踪物流信息。</p>
                    <a href="${pageContext.request.contextPath}/order/list" class="action-button">查看订单</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html> 