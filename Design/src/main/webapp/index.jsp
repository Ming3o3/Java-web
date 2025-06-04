<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>在线商城首页</title>
    <style>
        :root {
            --primary: #4CAF50;
            --primary-dark: #45a049;
            --accent: #FFC107;
            --text: #2d3748;
        }

        body {
            background: linear-gradient(135deg, #f8fff9 0%, #e3f2fd 100%);
            min-height: 100vh;
            margin: 0;
            font-family: 'Poppins', sans-serif;
            overflow: hidden;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* 动态背景元素 */
        .deco-circle {
            position: absolute;
            background: rgba(76,175,80,0.08);
            border-radius: 50%;
            animation: float 6s infinite ease-in-out;
            z-index: 0; /* 确保在容器下方 */
        }

        .deco-circle:nth-child(1) {
            width: 300px;
            height: 300px;
            top: -150px;
            right: -150px;
            animation-delay: 0s;
        }

        .deco-circle:nth-child(2) {
            width: 200px;
            height: 200px;
            bottom: -100px;
            left: -100px;
            animation-delay: 2s;
        }

        @keyframes float {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            25% { transform: translate(10px, 10px) rotate(5deg); }
            50% { transform: translate(-10px, -5px) rotate(-5deg); }
            75% { transform: translate(5px, -10px) rotate(3deg); }
        }

        .container {
            position: relative;
            z-index: 1;
            text-align: center;
            padding: 3rem 2rem;
            background: rgba(255,255,255,0.95);
            border-radius: 24px;
            box-shadow: 0 16px 40px rgba(0,0,0,0.12);
            max-width: 600px;
            width: 90%;
            margin: 0 auto;
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255,255,255,0.3);
        }

        h1 {
            color: var(--text);
            margin: 0 0 2rem 0;
            font-size: 2.8rem;
            line-height: 1.2;
            background: linear-gradient(135deg, var(--primary), var(--text));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .hero-text {
            color: #718096;
            margin-bottom: 3rem;
            font-size: 1.1rem;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
        }

        .button-group {
            display: grid;
            gap: 1.5rem;
            margin-top: 2rem;
        }

        .login-btn {
            padding: 1.4rem 2rem;
            border-radius: 16px;
            font-size: 1.1rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
            position: relative;
            overflow: hidden;
            border: none;
        }

        .login-btn::before {
            content: '';
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

        .merchant-btn {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            box-shadow: 0 8px 24px rgba(76,175,80,0.2);
        }

        .user-btn {
            background: linear-gradient(135deg, #2196F3, #1976D2);
            color: white;
            box-shadow: 0 8px 24px rgba(33,150,243,0.2);
        }

        .login-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 32px rgba(0,0,0,0.15);
        }

        .login-btn:hover::before {
            left: 100%;
        }

        .login-btn i {
            font-size: 1.6rem;
            transition: transform 0.3s ease;
        }

        .login-btn:hover i {
            transform: scale(1.1);
        }

        .branding {
            margin-bottom: 3rem;
        }

        .brand-logo {
            width: 80px;
            height: 80px;
            margin-bottom: 1.5rem;
            filter: drop-shadow(0 4px 12px rgba(0,0,0,0.1));
        }

        @media (max-width: 768px) {
            h1 {
                font-size: 2.2rem;
            }

            .login-btn {
                padding: 1.2rem;
                font-size: 1rem;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 2rem 1.5rem;
            }

            h1 {
                font-size: 1.8rem;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500;600;700&display=swap" rel="stylesheet">
</head>
<body>
<div class="deco-circle"></div>
<div class="deco-circle"></div>

<div class="container">
    <div class="branding">
        <img src="https://cdn-icons-png.flaticon.com/512/891/891419.png" alt="商城Logo" class="brand-logo">
        <h1>欢迎来到摆烂小组的商城</h1>
        <p class="hero-text">发现新奇好物，定义你的潮流生活</p>
    </div>

    <div class="button-group">
        <a href="${pageContext.request.contextPath}/merchant/login" class="login-btn merchant-btn">
            <i class="fas fa-store"></i>
            商家管理中心
        </a>

        <a href="${pageContext.request.contextPath}/login" class="login-btn user-btn">
            <i class="fas fa-shopping-basket"></i>
            用户购物入口
        </a>
    </div>

    <p style="margin-top: 2rem; color: #718096; font-size: 0.9rem;">
        © 2025 摆烂小组🥰 保留所有权利.
    </p>
</div>
</body>
</html>