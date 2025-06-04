<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>退货管理</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4CAF50;
            --primary-dark: #45a049;
            --error: #f44336;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* 头部样式 */
        .header {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            padding: 1.5rem;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(76,175,80,0.2);
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h2 {
            color: white;
            margin: 0;
            font-size: 1.8rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .header-icons {
            display: flex;
            gap: 15px;
            color: white;
        }

        /* 表格优化 */
        .returns-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 8px 24px rgba(0,0,0,0.06);
            table-layout: fixed; /* 固定列宽 */
        }

        /* 精确调整列宽比例 */
        .returns-table th:nth-child(1),
        .returns-table td:nth-child(1) { width: 8%; }  /* 退货ID */
        .returns-table th:nth-child(2),
        .returns-table td:nth-child(2) { width: 10%; } /* 订单ID */
        .returns-table th:nth-child(3),
        .returns-table td:nth-child(3) { width: 8%; }  /* 商品ID */
        .returns-table th:nth-child(4),
        .returns-table td:nth-child(4) { width: 30%; } /* 退货原因 */
        .returns-table th:nth-child(5),
        .returns-table td:nth-child(5) { width: 15%; } /* 申请时间 */
        .returns-table th:nth-child(6),
        .returns-table td:nth-child(6) { width: 10%; } /* 状态 */
        .returns-table th:nth-child(7),
        .returns-table td:nth-child(7) { width: 19%; } /* 操作 */

        /* 统一对齐方式 */
        .returns-table th,
        .returns-table td {
            padding: 1rem 1.2rem;
            vertical-align: middle;
            text-align: center;
            font-size: 0.95rem;
            white-space: normal;
            word-break: break-word;
        }

        /* 操作按钮间距调整 */
        .btn-approve, .btn-reject {
            margin: 0 3px;
            padding: 0.5rem 0.8rem;
        }
        .returns-table th {
            background: var(--primary);
            color: white;
            font-weight: 600;
            padding: 1.2rem;
        }

        .returns-table td {
            padding: 1rem;
            border-bottom: 1px solid rgba(0,0,0,0.06);
        }

        .returns-table tr:hover td {
            background: #f8fff9;
            transform: translateX(8px);
            transition: all 0.3s ease;
        }

        /* 按钮样式 */
        .btn-home {
            background: rgba(255,255,255,0.15);
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            border: 1px solid rgba(255,255,255,0.2);
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-home:hover {
            background: rgba(255,255,255,0.25);
            transform: translateY(-2px);
        }

        /* 操作按钮 */
        .btn-approve {
            background: linear-gradient(135deg, #4CAF50, #45a049);
            padding: 0.5rem 1rem;
            border-radius: 6px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-reject {
            background: linear-gradient(135deg, #f44336, #d32f2f);
            padding: 0.5rem 1rem;
            border-radius: 6px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        /* 消息提示 */
        .error-message {
            background: #ffebee;
            border-left: 4px solid var(--error);
            color: #c62828;
            padding: 1rem;
            border-radius: 6px;
        }

        .success-message {
            background: #e8f5e9;
            border-left: 4px solid var(--primary);
            color: #2E7D32;
            padding: 1rem;
            border-radius: 6px;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 1rem;
            }

            .returns-table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <div class="header-left">
            <h2>
                <i class="fas fa-arrow-rotate-left"></i>
                退货管理
                <i class="fas fa-box-open"></i>
            </h2>
            <div class="header-icons">
                <i class="fas fa-search"></i>
                <i class="fas fa-bell"></i>
                <i class="fas fa-cog"></i>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/merchant/dashboard" class="btn-home">
            <i class="fas fa-home"></i>
            返回首页
        </a>
    </div>

    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>

    <c:if test="${not empty success}">
        <div class="success-message">${success}</div>
    </c:if>

    <table class="returns-table">
        <thead>
        <tr>
            <th>退货ID</th>
            <th>订单ID</th>
            <th>商品ID</th>
            <th>退货原因</th>
            <th>申请时间</th>
            <th>状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${returns}" var="returnItem">
            <tr>
                <td>${returnItem.returnId}</td>
                <td>${returnItem.orderId}</td>
                <td>${returnItem.productId}</td>
                <td>${returnItem.reason}</td>
                <td>${returnItem.returnTime}</td>
                <td>${returnItem.status}</td>
                <td>
                    <c:if test="${returnItem.status eq '待处理'}">
                        <form action="${pageContext.request.contextPath}/merchant/return/approve" method="post" style="display: inline;">
                            <input type="hidden" name="returnId" value="${returnItem.returnId}">
                            <button type="submit" class="btn-approve">
                                <i class="fas fa-check"></i> 同意
                            </button>
                        </form>
                        <form action="${pageContext.request.contextPath}/merchant/return/reject" method="post" style="display: inline;">
                            <input type="hidden" name="returnId" value="${returnItem.returnId}">
                            <button type="submit" class="btn-reject">
                                <i class="fas fa-times"></i> 拒绝
                            </button>
                        </form>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>