<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>编辑商品</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input[type="text"],
        .form-group input[type="number"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .btn-submit {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-submit:hover {
            background-color: #45a049;
        }
        .error-message {
            color: #f44336;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>编辑商品</h2>
        
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/merchant/product/edit" method="post">
            <input type="hidden" name="productId" value="${product.productId}">
            
            <div class="form-group">
                <label for="category">商品名称</label>
                <input type="text" id="category" name="category" value="${product.category}" required>
            </div>
            
            <div class="form-group">
                <label for="price">价格</label>
                <input type="number" id="price" name="price" value="${product.price}" step="0.01" required>
            </div>
            
            <div class="form-group">
                <label for="quantity">库存</label>
                <input type="number" id="quantity" name="quantity" value="${product.quantity}" required>
            </div>
            
            <div class="form-group">
                <label for="image">图片URL</label>
                <input type="text" id="image" name="image" value="${product.image}" required>
            </div>
            
            <button type="submit" class="btn-submit">保存修改</button>
        </form>
    </div>
</body>
</html> 