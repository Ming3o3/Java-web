<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>订单详情</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        :root {
            --primary: #4CAF50;
            --primary-dark: #45a049;
            --text: #2d3748;
            --text-light: #718096;
            --error: #e74c3c;
        }

        body {
            background: linear-gradient(135deg, #f8fff9 0%, #f0fdf4 100%);
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* 头部样式 */
        .header {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            padding: 1.5rem 2rem;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(46, 204, 113, 0.2);
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h2 {
            margin: 0;
            font-size: 1.8rem;
            font-weight: 600;
            letter-spacing: -0.5px;
        }

        .btn-home {
            background: rgba(255,255,255,0.15);
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            text-decoration: none;
            transition: all 0.3s ease;
            border: 1px solid rgba(255,255,255,0.2);
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-home:hover {
            background: rgba(255,255,255,0.25);
            transform: translateY(-1px);
        }

        /* 订单信息卡片 */
        .order-info {
            background: rgba(255,255,255,0.95);
            border-radius: 12px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 8px 24px rgba(0,0,0,0.06);
            border: 1px solid rgba(76,175,80,0.1);
        }

        .order-info h3 {
            color: var(--text);
            margin-top: 0;
            margin-bottom: 1.5rem;
            font-size: 1.4rem;
            position: relative;
            padding-bottom: 0.5rem;
        }

        .order-info h3::after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 0;
            width: 40px;
            height: 3px;
            background: var(--primary);
        }

        .order-info p {
            margin: 1rem 0;
            display: grid;
            grid-template-columns: 120px 1fr;
            align-items: center;
        }

        .order-info strong {
            color: var(--text-light);
            font-weight: 500;
        }

        /* 订单表格 */
        .order-items {
            --table-padding: 1rem;
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 8px 24px rgba(0,0,0,0.06);
        }

        .order-items th,
        .order-items td {
            padding: var(--table-padding);
            border-bottom: 1px solid rgba(0,0,0,0.06);
        }

        .order-items th {
            background: var(--primary);
            color: white;
            font-weight: 600;
            position: sticky;
            top: 0;
        }

        .order-items tr:hover td {
            background: #f8fff9;
        }

        .order-items td:nth-child(3),
        .order-items td:nth-child(5) {
            color: var(--primary-dark);
            font-weight: 600;
        }

        /* 错误提示 */
        .error-message {
            background: #ffe3e6;
            color: var(--error);
            padding: 1.2rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            border-left: 4px solid var(--error);
            display: flex;
            align-items: center;
            gap: 12px;
            animation: slideIn 0.3s ease-out;
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .container {
                padding: 1.5rem;
            }

            .order-info p {
                grid-template-columns: 1fr;
                gap: 0.5rem;
            }

            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>订单详情</h2>
            <a href="${pageContext.request.contextPath}/merchant/dashboard" class="btn-home">返回首页</a>
        </div>
        
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>
        
        <div class="order-info">
            <h3>订单信息</h3>
            <p><strong>订单编号：</strong>${order.orderId}</p>
            <p><strong>订单状态：</strong>${order.status}</p>
            <p><strong>下单时间：</strong>${order.orderDate}</p>
            <p><strong>总金额：</strong>￥${order.totalAmount}</p>
            <p><strong>收货地址：</strong>${order.shippingAddress}</p>
        </div>
        
        <h3>订单商品</h3>
        <table class="order-items">
            <thead>
                <tr>
                    <th>商品ID</th>
                    <th>商品名称</th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>小计</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${order.orderItems}" var="item">
                    <tr>
                        <td>${item.productId}</td>
                        <td>${item.product.category}</td>
                        <td>￥${item.unitPrice}</td>
                        <td>${item.quantity}</td>
                        <td>￥${item.unitPrice * item.quantity}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>