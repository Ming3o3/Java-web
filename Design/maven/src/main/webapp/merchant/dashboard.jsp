                    <td>
                        <c:if test="${order.status == '已发货'}">
                            <form action="${pageContext.request.contextPath}/merchant/return/approve" method="post" style="display: inline;">
                                <input type="hidden" name="orderId" value="${order.orderId}">
                                <button type="submit" class="btn-approve">同意退货</button>
                            </form>
                            <form action="${pageContext.request.contextPath}/merchant/return/reject" method="post" style="display: inline;">
                                <input type="hidden" name="orderId" value="${order.orderId}">
                                <button type="submit" class="btn-reject">拒绝退货</button>
                            </form>
                        </c:if>
                        <c:if test="${order.status != '已发货'}">
                            <a href="${pageContext.request.contextPath}/merchant/order/detail?id=${order.orderId}" class="btn-view">查看详情</a>
                        </c:if>
                    </td>


<%--                    <%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--                    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--                    <!DOCTYPE html>--%>
<%--                    <html>--%>
<%--                    <head>--%>
<%--                        <title>商家仪表盘</title>--%>
<%--                        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">--%>
<%--                    </head>--%>
<%--                    <body>--%>
<%--                    <div class="merchant-container">--%>
<%--                        <h1 class="merchant-title">订单管理</h1>--%>
<%--                        <table class="order-table">--%>
<%--                            <!-- 表格头部 -->--%>
<%--                            <tr>--%>
<%--                                <th>订单号</th>--%>
<%--                                <th>状态</th>--%>
<%--                                <th>操作</th>--%>
<%--                            </tr>--%>

<%--                            <!-- 表格内容 -->--%>
<%--                            <c:forEach items="${orders}" var="order">--%>
<%--                                <tr>--%>
<%--                                    <td>${order.orderId}</td>--%>
<%--                                    <td>${order.status}</td>--%>
<%--                                    <td>--%>
<%--                                        // ... existing code ...--%>
<%--                                        <c:if test="${order.status == '已发货'}">--%>
<%--                                            <form action="${pageContext.request.contextPath}/merchant/return/approve" method="post" style="display: inline;">--%>
<%--                                                <input type="hidden" name="orderId" value="${order.orderId}">--%>
<%--                                                <button type="submit" class="btn-approve">同意退货</button>--%>
<%--                                            </form>--%>
<%--                                            <form action="${pageContext.request.contextPath}/merchant/return/reject" method="post" style="display: inline;">--%>
<%--                                                <input type="hidden" name="orderId" value="${order.orderId}">--%>
<%--                                                <button type="submit" class="btn-reject">拒绝退货</button>--%>
<%--                                            </form>--%>
<%--                                        </c:if>--%>
<%--                                        <c:if test="${order.status != '已发货'}">--%>
<%--                                            <a href="${pageContext.request.contextPath}/merchant/order/detail?id=${order.orderId}" class="btn-view">查看详情</a>--%>
<%--                                        </c:if>--%>
<%--                                    </td>--%>
<%--                                </tr>--%>
<%--                            </c:forEach>--%>
<%--                        </table>--%>
<%--                    </div>--%>
<%--                    </body>--%>
<%--                    </html>--%>