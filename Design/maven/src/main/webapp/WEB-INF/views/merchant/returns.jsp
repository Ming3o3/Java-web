<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>退货管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .return-list {
            margin: 20px 0;
        }
        .return-table {
            width: 100%;
            border-collapse: collapse;
        }
        .return-table th, .return-table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        .return-table th {
            background-color: #f5f5f5;
        }
        .btn {
            padding: 5px 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-approve {
            background-color: #4CAF50;
            color: white;
        }
        .btn-reject {
            background-color: #f44336;
            color: white;
        }
        .status-pending {
            color: #f44336;
        }
        .status-approved {
            color: #4CAF50;
        }
        .status-rejected {
            color: #9e9e9e;
        }
        .error-message {
            color: #f44336;
            margin: 10px 0;
            padding: 10px;
            background-color: #ffebee;
            border-radius: 4px;
        }
        .success-message {
            color: #4CAF50;
            margin: 10px 0;
            padding: 10px;
            background-color: #e8f5e9;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="container">
        <header class="header">
            <h1>退货管理</h1>
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

        <div class="return-list">
            <table class="return-table">
                <thead>
                    <tr>
                        <th>退货单号</th>
                        <th>订单号</th>
                        <th>商品</th>
                        <th>退货原因</th>
                        <th>申请时间</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${returns}" var="return">
                        <tr>
                            <td>${return.returnId}</td>
                            <td>${return.orderId}</td>
                            <td>${return.productName}</td>
                            <td>${return.reason}</td>
                            <td>${return.createTime}</td>
                            <td class="status-${return.status.toLowerCase()}">${return.status}</td>
                            <td>
                                <c:if test="${return.status == '待处理'}">
                                    <form action="${pageContext.request.contextPath}/merchant/return/approve" method="post" style="display: inline;">
                                        <input type="hidden" name="returnId" value="${return.returnId}">
                                        <button type="submit" class="btn btn-approve">同意</button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/merchant/return/reject" method="post" style="display: inline;">
                                        <input type="hidden" name="returnId" value="${return.returnId}">
                                        <button type="submit" class="btn btn-reject">拒绝</button>
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