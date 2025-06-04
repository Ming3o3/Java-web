<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>编辑个人资料</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .profile-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <h2 class="mb-4">编辑个人资料</h2>
        
        <c:if test="${not empty message}">
            <div class="alert alert-${messageType}">${message}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/customer/update" method="post">
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" class="form-control" id="username" name="username" 
                       value="${sessionScope.customer.username}" required>
            </div>

            <div class="form-group">
                <label for="email">电子邮箱</label>
                <input type="email" class="form-control" id="email" name="email" 
                       value="${sessionScope.customer.email}" required>
            </div>

            <div class="form-group">
                <label for="phone">手机号码</label>
                <input type="tel" class="form-control" id="phone" name="phone" 
                       value="${sessionScope.customer.phone}" required>
            </div>

            <div class="form-group">
                <label for="address">收货地址</label>
                <textarea class="form-control" id="address" name="address" rows="3" 
                          required>${sessionScope.customer.address}</textarea>
            </div>

            <div class="form-group">
                <label for="currentPassword">当前密码</label>
                <input type="password" class="form-control" id="currentPassword" 
                       name="currentPassword" required>
            </div>

            <div class="form-group">
                <label for="newPassword">新密码（如不修改请留空）</label>
                <input type="password" class="form-control" id="newPassword" 
                       name="newPassword">
            </div>

            <div class="form-group">
                <label for="confirmPassword">确认新密码</label>
                <input type="password" class="form-control" id="confirmPassword" 
                       name="confirmPassword">
            </div>

            <div class="form-group">
                <button type="submit" class="btn btn-primary">保存修改</button>
                <a href="${pageContext.request.contextPath}/dashboard" 
                   class="btn btn-secondary">返回</a>
            </div>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html> 