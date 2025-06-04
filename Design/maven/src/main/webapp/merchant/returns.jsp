<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>退货管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .btn-home {
            background-color: #607D8B;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 4px;
        }
        .btn-home:hover {
            background-color: #455A64;
        }
        .returns-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .returns-table th, .returns-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .returns-table th {
            background-color: #f5f5f5;
            font-weight: bold;
        }
        .returns-table tr:hover {
            background-color: #f9f9f9;
        }
        .btn-action {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 5px;
        }
        .btn-approve {
            background-color: #4CAF50;
            color: white;
        }
        .btn-reject {
            background-color: #f44336;
            color: white;
        }
        .btn-action:hover {
            opacity: 0.8;
        }
        .error-message {
            color: #f44336;
            margin-bottom: 20px;
        }
        .success-message {
            color: #4CAF50;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>退货管理</h2>
            <a href="${pageContext.request.contextPath}/merchant/dashboard" class="btn-home">返回首页</a>
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
                                    <button type="submit" class="btn-action btn-approve">同意</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/merchant/return/reject" method="post" style="display: inline;">
                                    <input type="hidden" name="returnId" value="${returnItem.returnId}">
                                    <button type="submit" class="btn-action btn-reject">拒绝</button>
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