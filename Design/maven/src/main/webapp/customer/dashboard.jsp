<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>用户中心</title>
</head>
<body>
    <h2>欢迎，${customer.nickname}！</h2>
    
    <div>
        <h3>个人信息</h3>
        <p>姓名：${customer.name}</p>
        <p>联系方式：${customer.contactInfo}</p>
        <p>收货地址：${customer.shippingAddress}</p>
    </div>
    
    <div>
        <h3>快捷操作</h3>
        <ul>
            <li><a href="${pageContext.request.contextPath}/products">浏览商品</a></li>
            <li><a href="${pageContext.request.contextPath}/customer/orders">查看订单</a></li>
            <li><a href="${pageContext.request.contextPath}/customer/returns">查看退货</a></li>
            <li><a href="${pageContext.request.contextPath}/customer/profile">编辑资料</a></li>
        </ul>
    </div>
    
    <div>
        <a href="${pageContext.request.contextPath}/customer/logout">退出登录</a>
    </div>
</body>
</html> 