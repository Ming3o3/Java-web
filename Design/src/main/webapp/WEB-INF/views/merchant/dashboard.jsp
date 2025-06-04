<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商家后台管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            background-color: #f5f7fa;
            font-family: 'Segoe UI', system-ui, sans-serif;
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

        /* 退出按钮样式 */
        .btn-link {
            color: #fff !important;
            padding: 8px 20px;
            border-radius: 25px;
            background: linear-gradient(135deg, rgba(255,255,255,0.2), rgba(255,255,255,0.15));
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid rgba(255,255,255,0.3);
            margin-left: 15px;
            text-decoration: none;
            font-weight: 500;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .btn-link:hover {
            background: linear-gradient(135deg, rgba(255,255,255,0.3), rgba(255,255,255,0.25));
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }

        /* 导航菜单样式 */
        .nav {
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        .nav ul {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
        }
        .nav li {
            flex: 1;
            position: relative;
        }
        .nav a {
            display: block;
            padding: 1.2rem;
            color: #2d3748;
            text-decoration: none;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-weight: 600;
            text-align: center;
            border-bottom: 3px solid transparent;
        }
        .nav a:hover {
            background: #4CAF50 !important;
            color: white !important;
            transform: scale(1.05);
            border-bottom-color: #388E3C;
            box-shadow: 0 4px 12px rgba(76,175,80,0.3);
        }

        /* 统计卡片样式 */
        .dashboard-stats {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
            transition: transform 0.2s;
        }
        .stat-card:hover {
            transform: translateY(-2px);
        }
        .stat-card h3 {
            color: #718096;
            font-size: 1rem;
            margin: 0 0 0.5rem 0;
        }
        .stat-card p {
            font-size: 1.8rem;
            font-weight: bold;
            color: #2d3748;
            margin: 0;
        }

        /* 表格样式 - 优化表头与内容对齐 */
        .recent-orders {
            background: white;
            border-radius: 8px;
            padding: 1.5rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .table {
            width: 100%;
            border-collapse: collapse;
            box-sizing: border-box; /* 确保边框和内边距不撑大表格宽度 */
        }
        .table th,
        .table td {
            padding: 1rem;
            border-bottom: 1px solid #e0f2e4;
            color: #2d3748;
            transition: all 0.2s;
            box-sizing: border-box; /* 确保边框和内边距不撑大单元格 */
        }
        .table th {
            background: #4CAF50;
            color: white;
            font-weight: 600;
            border-bottom: 2px solid #388E3C;
            text-align: left; /* 保持与<td>一致的左对齐 */
        }
        .table tr:hover td {
            background: #e8f5e9 !important;
            transform: scale(1.02);
            box-shadow: 0 2px 8px rgba(76,175,80,0.1);
        }
    </style>
</head>
<body>
<div class="container">
    <header class="header">
        <h1>商家后台管理</h1>
        <div class="user-info">
            欢迎，${merchant.storeName}
            <a href="${pageContext.request.contextPath}/merchant/logout" class="btn btn-link">退出</a>
        </div>
    </header>

    <nav class="nav">
        <ul>
            <li><a href="${pageContext.request.contextPath}/merchant/products">商品管理</a></li>
            <li><a href="${pageContext.request.contextPath}/merchant/orders">订单管理</a></li>
            <li><a href="${pageContext.request.contextPath}/merchant/returns">退货管理</a></li>
            <li><a href="${pageContext.request.contextPath}/merchant/profile">店铺信息</a></li>
        </ul>
    </nav>

    <main class="main">
        <div class="dashboard-stats">
            <div class="stat-card">
                <h3>商品总数</h3>
                <p>${productCount}</p>
            </div>
            <div class="stat-card">
                <h3>待处理订单</h3>
                <p>${pendingOrderCount}</p>
            </div>
            <div class="stat-card">
                <h3>待处理退货</h3>
                <p>${pendingReturnCount}</p>
            </div>
        </div>

        <div class="recent-orders">
            <h2>最近订单</h2>
            <table class="table">
                <thead>
                <tr>
                    <th>订单号</th>
                    <th>客户</th>
                    <th>金额</th>
                    <th>状态</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${recentOrders}" var="order">
                    <tr>
                        <td>${order.orderId}</td>
                        <td>${order.customerId}</td>
                        <td>￥${order.totalAmount}</td>
                        <td>${order.status}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </main>
</div>
</body>
</html>

<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <title>商家后台管理</title>--%>
<%--    <style>--%>
<%--        :root {--%>
<%--            --primary: #2ecc71;--%>
<%--            --primary-dark: #27ae60;--%>
<%--            --secondary: #3498db;--%>
<%--            --text: #2c3e50;--%>
<%--            --text-light: #7f8c8d;--%>
<%--            --background: #f8f9fa;--%>
<%--            --success: #2ecc71;--%>
<%--            --warning: #f1c40f;--%>
<%--            --danger: #e74c3c;--%>
<%--        }--%>

<%--        body {--%>
<%--            background: var(--background);--%>
<%--            font-family: 'Inter', system-ui, -apple-system, sans-serif;--%>
<%--            line-height: 1.6;--%>
<%--        }--%>

<%--        .container {--%>
<%--            max-width: 1400px;--%>
<%--            margin: 0 auto;--%>
<%--            padding: 2rem;--%>
<%--        }--%>

<%--        /* 头部样式 */--%>
<%--        .header {--%>
<%--            background: linear-gradient(135deg, var(--primary), var(--primary-dark));--%>
<%--            color: white;--%>
<%--            padding: 1.5rem 2rem;--%>
<%--            border-radius: 12px;--%>
<%--            box-shadow: 0 8px 24px rgba(46, 204, 113, 0.2);--%>
<%--            margin-bottom: 2.5rem;--%>
<%--            display: flex;--%>
<%--            justify-content: space-between;--%>
<%--            align-items: center;--%>
<%--            backdrop-filter: blur(6px);--%>
<%--            border: 1px solid rgba(255,255,255,0.15);--%>
<%--        }--%>

<%--        .user-info {--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            gap: 1.5rem;--%>
<%--            font-size: 1.05rem;--%>
<%--            position: relative;--%>
<%--        }--%>

<%--        .header h1 {--%>
<%--            margin: 0;--%>
<%--            font-size: 2rem;--%>
<%--            font-weight: 700;--%>
<%--            letter-spacing: -0.5px;--%>
<%--        }--%>

<%--        /* 退出按钮 */--%>
<%--        .btn-link {--%>
<%--            display: inline-flex;--%>
<%--            align-items: center;--%>
<%--            gap: 0.5rem;--%>
<%--            padding: 0.75rem 1.5rem;--%>
<%--            border-radius: 30px;--%>
<%--            background: rgba(255,255,255,0.12);--%>
<%--            backdrop-filter: blur(4px);--%>
<%--            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);--%>
<%--            border: 1px solid rgba(255,255,255,0.2);--%>
<%--            text-decoration: none;--%>
<%--            font-weight: 500;--%>
<%--        }--%>

<%--        .btn-link:hover {--%>
<%--            background: rgba(255,255,255,0.2);--%>
<%--            transform: translateY(-1px);--%>
<%--            box-shadow: 0 4px 12px rgba(0,0,0,0.15);--%>
<%--        }--%>

<%--        /* 导航菜单 */--%>
<%--        .nav {--%>
<%--            background: rgba(255,255,255,0.95);--%>
<%--            border-radius: 12px;--%>
<%--            box-shadow: 0 8px 24px rgba(0,0,0,0.06);--%>
<%--            margin-bottom: 2.5rem;--%>
<%--            backdrop-filter: blur(6px);--%>
<%--            border: 1px solid rgba(0,0,0,0.05);--%>
<%--        }--%>

<%--        .nav ul {--%>
<%--            display: grid;--%>
<%--            grid-template-columns: repeat(4, 1fr);--%>
<%--            gap: 1px;--%>
<%--            background: rgba(0,0,0,0.05);--%>
<%--        }--%>

<%--        .nav li {--%>
<%--            position: relative;--%>
<%--        }--%>

<%--        .nav a {--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            justify-content: center;--%>
<%--            height: 60px;--%>
<%--            background: white;--%>
<%--            color: var(--text);--%>
<%--            padding: 0 2rem;--%>
<%--            transition: all 0.3s ease;--%>
<%--            font-weight: 600;--%>
<%--            position: relative;--%>
<%--            gap: 0.75rem;--%>
<%--        }--%>

<%--        .nav a:hover {--%>
<%--            background: var(--primary) !important;--%>
<%--            color: white !important;--%>
<%--            transform: none;--%>
<%--            box-shadow: none;--%>
<%--        }--%>

<%--        .nav a::before {--%>
<%--            content: '';--%>
<%--            position: absolute;--%>
<%--            bottom: 0;--%>
<%--            left: 0;--%>
<%--            width: 100%;--%>
<%--            height: 3px;--%>
<%--            background: var(--primary);--%>
<%--            transform: scaleX(0);--%>
<%--            transition: transform 0.3s ease;--%>
<%--        }--%>

<%--        .nav a:hover::before {--%>
<%--            transform: scaleX(1);--%>
<%--        }--%>

<%--        /* 统计卡片 */--%>
<%--        .dashboard-stats {--%>
<%--            display: grid;--%>
<%--            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));--%>
<%--            gap: 2rem;--%>
<%--            margin-bottom: 3rem;--%>
<%--        }--%>

<%--        .stat-card {--%>
<%--            background: linear-gradient(135deg, white, #f8f9fa);--%>
<%--            padding: 2rem;--%>
<%--            border-radius: 12px;--%>
<%--            box-shadow: 0 6px 18px rgba(0,0,0,0.04);--%>
<%--            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);--%>
<%--            border: 1px solid rgba(0,0,0,0.04);--%>
<%--            position: relative;--%>
<%--            overflow: hidden;--%>
<%--        }--%>

<%--        .stat-card:hover {--%>
<%--            transform: translateY(-5px);--%>
<%--            box-shadow: 0 12px 24px rgba(0,0,0,0.08);--%>
<%--        }--%>

<%--        .stat-card::after {--%>
<%--            content: '';--%>
<%--            position: absolute;--%>
<%--            top: 0;--%>
<%--            left: 0;--%>
<%--            width: 4px;--%>
<%--            height: 100%;--%>
<%--            background: var(--primary);--%>
<%--            transition: width 0.3s ease;--%>
<%--        }--%>

<%--        .stat-card:hover::after {--%>
<%--            width: 6px;--%>
<%--        }--%>

<%--        .stat-card h3 {--%>
<%--            color: var(--text-light);--%>
<%--            font-size: 1rem;--%>
<%--            margin: 0 0 1rem 0;--%>
<%--            font-weight: 500;--%>
<%--        }--%>

<%--        .stat-card p {--%>
<%--            font-size: 2.2rem;--%>
<%--            font-weight: 700;--%>
<%--            color: var(--text);--%>
<%--            margin: 0;--%>
<%--        }--%>

<%--        /* 表格样式 */--%>
<%--        .recent-orders {--%>
<%--            background: white;--%>
<%--            border-radius: 12px;--%>
<%--            padding: 2rem;--%>
<%--            box-shadow: 0 8px 24px rgba(0,0,0,0.06);--%>
<%--            overflow: hidden;--%>
<%--        }--%>

<%--        .recent-orders h2 {--%>
<%--            margin-top: 0;--%>
<%--            margin-bottom: 1.5rem;--%>
<%--            color: var(--text);--%>
<%--            font-size: 1.4rem;--%>
<%--        }--%>

<%--        .table {--%>
<%--            --table-padding: 1.25rem;--%>
<%--            width: 100%;--%>
<%--            border-collapse: separate;--%>
<%--            border-spacing: 0;--%>
<%--        }--%>

<%--        .table th {--%>
<%--            background: var(--primary);--%>
<%--            color: white;--%>
<%--            padding: var(--table-padding);--%>
<%--            font-weight: 600;--%>
<%--            position: sticky;--%>
<%--            top: 0;--%>
<%--        }--%>

<%--        .table td {--%>
<%--            padding: var(--table-padding);--%>
<%--            background: white;--%>
<%--            border-bottom: 1px solid rgba(0,0,0,0.06);--%>
<%--        }--%>

<%--        .table tr:last-child td {--%>
<%--            border-bottom: none;--%>
<%--        }--%>

<%--        .table tr:hover td {--%>
<%--            background: #f8fff9 !important;--%>
<%--            transform: none;--%>
<%--            box-shadow: none;--%>
<%--        }--%>

<%--        .table td:nth-child(3) {--%>
<%--            font-weight: 600;--%>
<%--            color: var(--primary-dark);--%>
<%--        }--%>

<%--        /* 响应式设计 */--%>
<%--        @media (max-width: 1024px) {--%>
<%--            .nav ul {--%>
<%--                grid-template-columns: 1fr;--%>
<%--            }--%>

<%--            .nav a {--%>
<%--                justify-content: flex-start;--%>
<%--                padding-left: 2.5rem;--%>
<%--            }--%>
<%--        }--%>

<%--        @media (max-width: 768px) {--%>
<%--            .container {--%>
<%--                padding: 1.5rem;--%>
<%--            }--%>

<%--            .header {--%>
<%--                flex-direction: column;--%>
<%--                align-items: flex-start;--%>
<%--                gap: 1rem;--%>
<%--            }--%>

<%--            .stat-card p {--%>
<%--                font-size: 1.8rem;--%>
<%--            }--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container">--%>
<%--    <header class="header">--%>
<%--        <h1>商家后台管理</h1>--%>
<%--        <div class="user-info">--%>
<%--            欢迎，${merchant.storeName}--%>
<%--            <a href="${pageContext.request.contextPath}/merchant/logout" class="btn btn-link">退出</a>--%>
<%--        </div>--%>
<%--    </header>--%>

<%--    <nav class="nav">--%>
<%--        <ul>--%>
<%--            <li><a href="${pageContext.request.contextPath}/merchant/products">商品管理</a></li>--%>
<%--            <li><a href="${pageContext.request.contextPath}/merchant/orders">订单管理</a></li>--%>
<%--            <li><a href="${pageContext.request.contextPath}/merchant/returns">退货管理</a></li>--%>
<%--            <li><a href="${pageContext.request.contextPath}/merchant/profile">店铺信息</a></li>--%>
<%--        </ul>--%>
<%--    </nav>--%>

<%--    <main class="main">--%>
<%--        <div class="dashboard-stats">--%>
<%--            <div class="stat-card">--%>
<%--                <h3>商品总数</h3>--%>
<%--                <p>${productCount}</p>--%>
<%--            </div>--%>
<%--            <div class="stat-card">--%>
<%--                <h3>待处理订单</h3>--%>
<%--                <p>${pendingOrderCount}</p>--%>
<%--            </div>--%>
<%--            <div class="stat-card">--%>
<%--                <h3>待处理退货</h3>--%>
<%--                <p>${pendingReturnCount}</p>--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <div class="recent-orders">--%>
<%--            <h2>最近订单</h2>--%>
<%--            <table class="table">--%>
<%--                <thead>--%>
<%--                <tr>--%>
<%--                    <th>订单号</th>--%>
<%--                    <th>客户</th>--%>
<%--                    <th>金额</th>--%>
<%--                    <th>状态</th>--%>
<%--                </tr>--%>
<%--                </thead>--%>
<%--                <tbody>--%>
<%--                <c:forEach items="${recentOrders}" var="order">--%>
<%--                    <tr>--%>
<%--                        <td>${order.orderId}</td>--%>
<%--                        <td>${order.customerId}</td>--%>
<%--                        <td>￥${order.totalAmount}</td>--%>
<%--                        <td>${order.status}</td>--%>
<%--                    </tr>--%>
<%--                </c:forEach>--%>
<%--                </tbody>--%>
<%--            </table>--%>
<%--        </div>--%>
<%--    </main>--%>
<%--</div>--%>
<%--</body>--%>
<%--</html>--%>