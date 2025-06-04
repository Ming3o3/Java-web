<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>添加新商品</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        :root {
            --primary: #4CAF50;
            --primary-dark: #45a049;
            --accent: #FFC107;
            --text: #2d3748;
            --text-light: #718096;
        }

        body {
            background: linear-gradient(135deg, #f8fff9 0%, #f0fdf4 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
        }

        .form-container {
            max-width: 800px;
            width: 90%;
            padding: 3rem;
            background: rgba(255,255,255,0.95);
            border-radius: 16px;
            box-shadow: 0 12px 40px rgba(76,175,80,0.15);
            margin: 2rem auto;
            backdrop-filter: blur(8px);
            border: 1px solid rgba(76,175,80,0.1);
            position: relative;
            overflow: hidden;
        }

        .form-container::before {
            content: "";
            position: absolute;
            top: -50px;
            right: -50px;
            width: 150px;
            height: 150px;
            background: rgba(76,175,80,0.08);
            border-radius: 50%;
        }

        h2 {
            text-align: center;
            color: var(--text);
            margin-bottom: 2.5rem;
            font-size: 2.2rem;
            font-weight: 700;
            position: relative;
            letter-spacing: -0.5px;
        }

        h2::after {
            content: "";
            position: absolute;
            bottom: -12px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: linear-gradient(90deg, var(--primary), var(--primary-dark));
            border-radius: 2px;
        }

        .form-group {
            margin-bottom: 2rem;
            position: relative;
        }

        .form-group label {
            display: flex;
            align-items: center;
            gap: 12px;
            color: var(--text);
            font-weight: 600;
            margin-bottom: 1rem;
            font-size: 1.05rem;
            padding-left: 8px;
        }

        .form-group label::before {
            content: "•";
            color: var(--primary);
            font-size: 1.8rem;
            line-height: 1;
        }

        .form-group input {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid #e5f7e7;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background: #f8fff9;
        }

        .form-group input:focus {
            border-color: var(--primary);
            box-shadow: 0 4px 12px rgba(76,175,80,0.15);
            background: white;
        }

        .btn-submit {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            padding: 16px;
            width: 100%;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            margin-top: 1.5rem;
        }

        .btn-submit::before {
            content: "";
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                    120deg,
                    transparent,
                    rgba(255,255,255,0.3),
                    transparent
            );
            transition: all 0.6s ease;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(76,175,80,0.3);
        }

        .btn-submit:hover::before {
            left: 100%;
        }

        .error-message {
            background: #fff0f0;
            color: #dc2626;
            padding: 1.2rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            border-left: 4px solid #dc2626;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: slideIn 0.3s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .form-container {
                padding: 2rem 1.5rem;
            }

            h2 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>添加新商品</h2>
    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>
    <form action="${pageContext.request.contextPath}/merchant/product/add" method="post">
        <div class="form-group">
            <label for="price">价格</label>
            <input type="number" id="price" name="price" step="0.01" required>
        </div>
        <div class="form-group">
            <label for="quantity">库存数量</label>
            <input type="number" id="quantity" name="quantity" required>
        </div>
        <div class="form-group">
            <label for="category">商品名称</label>
            <input type="text" id="category" name="category" required>
        </div>
        <div class="form-group">
            <label for="image">商品图片URL</label>
            <input type="text" id="image" name="image" required>
        </div>
        <button type="submit" class="btn-submit">添加商品</button>
    </form>
</div>
</body>
</html>