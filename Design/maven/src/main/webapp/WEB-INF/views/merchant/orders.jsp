<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>订单管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            background: #f5f7fa;
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

        /* 表格样式 */
        .order-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 12px rgba(0,0,0,0.1);
        }

        .order-table th {
            background: #4CAF50;
            color: white;
            padding: 1rem;
            font-weight: 600;
            border-bottom: 2px solid #388E3C;
        }

        .order-table td {
            padding: 1rem;
            border-bottom: 1px solid #e8f5e9;
            color: #2d3748;
            transition: all 0.2s;
        }

        .order-table tr:hover td {
            background: #ebfaee;
            transform: scale(1.02);
            box-shadow: 0 2px 8px rgba(76,175,80,0.1);
        }

        /* 状态标签 */
        .status-pending { color: #f44336; font-weight: 500; }
        .status-shipped { color: #2196F3; font-weight: 500; }
        .status-completed { color: #4CAF50; font-weight: 500; }

        /* 按钮样式 */
        .btn-ship {
            background: linear-gradient(135deg, #4CAF50, #45a049);
            color: white !important;
            padding: 8px 20px;
            border-radius: 20px;
            border: none;
            transition: all 0.3s;
        }
        .btn-ship:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(76,175,80,0.3);
        }

        /* 提示信息 */
        .error-message {
            background: #ffebee;
            border-left: 4px solid #f44336;
            color: #c62828;
            padding: 1rem;
            border-radius: 4px;
            margin: 1.5rem 0;
        }

        .success-message {
            background: #e8f5e9;
            border-left: 4px solid #4CAF50;
            color: #2E7D32;
            padding: 1rem;
            border-radius: 4px;
            margin: 1.5rem 0;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .order-table {
                display: block;
                overflow-x: auto;
            }
            .header {
                flex-direction: column;
                gap: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header class="header">
            <h1>订单管理</h1>
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

        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>

        <c:if test="${not empty success}">
            <div class="success-message">
                ${success}
            </div>
        </c:if>

        <div class="order-list">
            <table class="order-table">
                <thead>
                    <tr>
                        <th>订单号</th>
                        <th>客户</th>
                        <th>订单金额</th>
                        <th>订单状态</th>
                        <th>下单时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${orders}" var="order">
                        <tr>
                            <td>${order.orderId}</td>
                            <td>${order.customerId}</td>
                            <td>￥${order.totalAmount}</td>
                            <td class="status-${order.status.toLowerCase()}">${order.status}</td>
                            <td>${order.orderDate}</td>
                            <td>
                                <c:if test="${order.status == '待发货'}">
                                    <form action="${pageContext.request.contextPath}/merchant/order/ship" method="post" style="display: inline;">
                                        <input type="hidden" name="orderId" value="${order.orderId}">
                                        <button type="submit" class="btn btn-ship">发货</button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html> 