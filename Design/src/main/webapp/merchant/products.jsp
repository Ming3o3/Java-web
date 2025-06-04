<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>商品管理</title>
    <style>
        :root {
            --primary: #4CAF50;  /* 主色改为与首页一致的绿色 */
            --primary-dark: #45a049;  /* 深色调整 */
            --secondary: #3498db;
            --text: #2c3e50;
            --text-light: #7f8c8d;
            --background: #f8f9fa;
            --error: #e74c3c;
        }

        body {
            background: var(--background);
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            line-height: 1.6;
        }

        .container {
            max-width: 1400px;
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
            margin-bottom: 2.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h2 {
            margin: 0;
            font-size: 1.8rem;
            font-weight: 600;
        }

        /* 按钮组 */
        .btn-group {
            display: flex;
            gap: 1rem;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            text-decoration: none;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        .btn-home {
            background: rgba(255,255,255,0.15);
            color: white;
            border: 1px solid rgba(255,255,255,0.2);
        }

        .btn-home:hover {
            background: rgba(255,255,255,0.25);
            transform: translateY(-1px);
        }

        .btn-add {
            background: linear-gradient(135deg, #fff, #f8f9fa);
            color: var(--primary-dark);
            font-weight: 600;
        }

        .btn-add:hover {
            box-shadow: 0 4px 12px rgba(76,175,80,0.2);
            transform: translateY(-1px);
        }

        /* 表格优化 */
        .product-table {
            --table-padding: 1rem;
            width: 100%;
            border-collapse: collapse; /* 合并边框，避免间距问题 */
            border-spacing: 0;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 8px 24px rgba(0,0,0,0.06);
            table-layout: fixed; /* 固定列宽，确保表头与内容对齐 */
        }

        .product-table th,
        .product-table td {
            padding: var(--table-padding);
            border-bottom: 1px solid rgba(0,0,0,0.06);
            text-align: left; /* 统一左对齐（可根据需求改为居中） */
            white-space: nowrap; /* 防止内容换行导致列宽变化 */
            overflow: hidden; /* 超出内容隐藏 */
            text-overflow: ellipsis; /* 超出显示省略号 */
            box-sizing: border-box; /* 内边距和边框计入宽度 */
        }

        .product-table th {
            background: var(--primary);
            color: white;
            font-weight: 600;
            position: sticky;
            top: 0;
            /* 强制列宽与内容区一致 */
            width: auto; /* 自动分配宽度，需配合table-layout: fixed */
        }

        /* 针对不同列设置固定宽度（示例：共6列，可根据实际调整） */
        .product-table th:nth-child(1),
        .product-table td:nth-child(1) { width: 10%; } /* 商品ID */
        .product-table th:nth-child(2),
        .product-table td:nth-child(2) { width: 15%; } /* 图片 */
        .product-table th:nth-child(3),
        .product-table td:nth-child(3) { width: 25%; } /* 名称 */
        .product-table th:nth-child(4),
        .product-table td:nth-child(4) { width: 10%; } /* 价格 */
        .product-table th:nth-child(5),
        .product-table td:nth-child(5) { width: 10%; } /* 库存 */
        .product-table th:nth-child(6),
        .product-table td:nth-child(6) { width: 20%; } /* 操作 */

        .product-table tr:last-child td {
            border-bottom: none;
        }

        .product-table tr:hover td {
            background: #f8fff9;
        }

        /* 操作按钮 */
        .btn-edit, .btn-delete {
            display: inline-flex;
            align-items: center;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            font-size: 0.9rem;
            transition: all 0.2s ease;
        }

        .btn-edit {
            background: rgba(33,150,243,0.1);
            color: #2196F3;
            border: 1px solid rgba(33,150,243,0.2);
        }

        .btn-edit:hover {
            background: rgba(33,150,243,0.2);
        }

        .btn-delete {
            background: rgba(244,67,54,0.1);
            color: #f44336;
            border: 1px solid rgba(244,67,54,0.2);
        }

        .btn-delete:hover {
            background: rgba(244,67,54,0.2);
        }

        /* 商品图片 */
        .product-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
            transition: transform 0.3s ease;
            border: 1px solid rgba(0,0,0,0.06);
        }

        .product-image:hover {
            transform: scale(1.8);
            z-index: 1;
            box-shadow: 0 8px 24px rgba(0,0,0,0.1);
        }

        /* 错误提示 */
        .error-message {
            background: #ffe3e6;
            color: var(--error);
            padding: 1rem;
            margin-bottom: 2rem;
            border-radius: 8px;
            border-left: 4px solid var(--error);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .container {
                padding: 1.5rem;
            }

            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }

            .btn-group {
                width: 100%;
                flex-direction: column;
            }

            .btn {
                justify-content: center;
            }

            /* 响应式表格列宽调整 */
            .product-table th:nth-child(3),
            .product-table td:nth-child(3) { width: 30%; }
            .product-table th:nth-child(6),
            .product-table td:nth-child(6) { width: 25%; }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h2>商品管理</h2>
        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/merchant/dashboard" class="btn btn-home">返回首页</a>
            <a href="${pageContext.request.contextPath}/merchant/product/add" class="btn btn-add">添加新商品</a>
        </div>
    </div>

    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>

    <table class="product-table">
        <thead>
        <tr>
            <th>商品ID</th>
            <th>商品名称</th>
            <th>价格</th>
            <th>库存</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${products}" var="product">
            <tr>
                <td>${product.productId}</td>
                <td>${product.category}</td> <!-- 假设此处应为product.name，可能是数据绑定错误 -->
                <td>￥${product.price}</td>
                <td>${product.quantity}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/merchant/product/edit?id=${product.productId}"
                       class="btn-edit">编辑</a>
                    <a href="${pageContext.request.contextPath}/merchant/product/delete?id=${product.productId}"
                       class="btn-delete"
                       onclick="return confirm('确定要删除这个商品吗？')">删除</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>