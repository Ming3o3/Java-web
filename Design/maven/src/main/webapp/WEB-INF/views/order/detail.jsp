<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>订单详情</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>订单详情</h1>
            <nav>
                <a href="${pageContext.request.contextPath}/order/list">返回订单列表</a>
            </nav>
        </header>

        <main>
            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>

            <div class="order-detail">
                <div class="order-info">
                    <p>订单编号：${order.orderId}</p>
                    <p>下单时间：${order.orderDate}</p>
                    <p>订单状态：${order.status}</p>
                    <p>收货地址：${order.shippingAddress}</p>
                </div>

                <section class="order-items">
                    <h2>订单商品</h2>
                    <c:if test="${empty order.orderItems}">
                        <p>暂无商品信息</p>
                    </c:if>
                    <c:if test="${not empty order.orderItems}">
                        <table>
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
                                        <td>￥${item.subtotal}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </section>

                <div class="order-total">
                    <p>订单总额：￥${order.totalAmount}</p>
                </div>

                <div class="order-actions">
                    <c:if test="${order.status eq '待发货'}">
                        <form action="${pageContext.request.contextPath}/order/cancel" method="post">
                            <input type="hidden" name="orderId" value="${order.orderId}">
                            <button type="submit" class="btn-cancel">取消订单</button>
                        </form>
                    </c:if>
                    <c:if test="${order.status eq '已发货'}">
                        <form action="${pageContext.request.contextPath}/return/apply" method="post" style="display: inline-block; margin-right: 10px;">
                            <input type="hidden" name="orderId" value="${order.orderId}">
                            <div class="form-group">
                                <label for="returnReason">退货原因：</label>
                                <textarea id="returnReason" name="returnReason" required rows="3" style="width: 100%; margin-bottom: 10px;"></textarea>
                            </div>
                            <button type="submit" class="btn-return">申请退货</button>
                        </form>
                        <form action="${pageContext.request.contextPath}/order/confirm" method="post" style="display: inline-block;">
                            <input type="hidden" name="orderId" value="${order.orderId}">
                            <button type="submit" class="btn-confirm">确认收货</button>
                        </form>
                    </c:if>
                </div>
            </div>
        </main>
    </div>
</body>
</html> 