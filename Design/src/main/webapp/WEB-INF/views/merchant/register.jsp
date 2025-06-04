<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>商家注册 | 平台管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#4CAF50',
                        secondary: '#388E3C',
                        neutral: {
                            100: '#F5F7FA',
                            200: '#E4E7EB',
                            300: '#CBD2D9',
                            700: '#4A5568',
                            900: '#1F2933'
                        }
                    },
                    fontFamily: {
                        inter: ['Inter', 'system-ui', 'sans-serif'],
                    },
                }
            }
        }
    </script>
    <style type="text/tailwindcss">
        @layer utilities {
            .content-auto {
                content-visibility: auto;
            }
            .form-input-focus {
                @apply focus:ring-2 focus:ring-primary/50 focus:border-primary focus:outline-none transition duration-200;
            }
            .btn-primary {
                @apply bg-primary hover:bg-secondary text-white font-medium py-3 px-4 rounded-lg transition-all duration-300 shadow-md hover:shadow-lg transform hover:-translate-y-0.5;
            }
            .card-shadow {
                @apply shadow-lg hover:shadow-xl transition-shadow duration-300;
            }
        }
    </style>
</head>
<body class="bg-gradient-to-br from-neutral-100 to-neutral-200 min-h-screen font-inter">
<div class="flex flex-col items-center justify-center min-h-screen px-4 py-12">
    <!-- 品牌标识 -->
    <div class="mb-8 text-center">
        <h1 class="text-[clamp(1.8rem,4vw,2.5rem)] font-bold text-neutral-900 flex items-center justify-center">
            <i class="fa fa-shopping-bag text-primary mr-3"></i>
            <span>商家入驻平台</span>
        </h1>
        <p class="text-neutral-700 mt-2">开启您的电商之旅，共创美好未来</p>
    </div>

    <!-- 注册卡片 -->
    <div class="w-full max-w-md bg-white rounded-2xl card-shadow overflow-hidden">
        <!-- 卡片头部 -->
        <div class="bg-primary p-6 text-white">
            <h2 class="text-2xl font-bold mb-1">商家注册</h2>
            <p class="opacity-90">填写以下信息完成注册</p>
        </div>

        <!-- 错误提示 -->
        <c:if test="${not empty error}">
            <div class="bg-red-50 border-l-4 border-red-400 p-4 mx-6 my-4">
                <div class="flex">
                    <div class="flex-shrink-0">
                        <i class="fa fa-exclamation-triangle text-red-500"></i>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm text-red-700">${error}</p>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- 注册表单 -->
        <form action="${pageContext.request.contextPath}/merchant/register" method="post" class="p-6 space-y-5">
            <div class="space-y-2">
                <label for="storeName" class="block text-sm font-medium text-neutral-700">
                    <i class="fa fa-store mr-1"></i> 店铺名称
                </label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fa fa-building text-neutral-400"></i>
                    </div>
                    <input type="text" id="storeName" name="storeName" required
                           class="pl-10 block w-full rounded-lg border border-neutral-300 py-3 text-neutral-900 form-input-focus"
                           placeholder="请输入您的店铺名称">
                </div>
            </div>

            <div class="space-y-2">
                <label for="name" class="block text-sm font-medium text-neutral-700">
                    <i class="fa fa-user mr-1"></i> 负责人姓名
                </label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fa fa-user text-neutral-400"></i>
                    </div>
                    <input type="text" id="name" name="name" required
                           class="pl-10 block w-full rounded-lg border border-neutral-300 py-3 text-neutral-900 form-input-focus"
                           placeholder="请输入负责人姓名">
                </div>
            </div>

            <div class="space-y-2">
                <label for="contactInfo" class="block text-sm font-medium text-neutral-700">
                    <i class="fa fa-phone mr-1"></i> 联系方式
                </label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fa fa-phone text-neutral-400"></i>
                    </div>
                    <input type="text" id="contactInfo" name="contactInfo" required
                           class="pl-10 block w-full rounded-lg border border-neutral-300 py-3 text-neutral-900 form-input-focus"
                           placeholder="请输入手机号码">
                </div>
            </div>

            <div class="space-y-2">
                <label for="address" class="block text-sm font-medium text-neutral-700">
                    <i class="fa fa-map-marker mr-1"></i> 店铺地址
                </label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fa fa-map-marker text-neutral-400"></i>
                    </div>
                    <input type="text" id="address" name="address" required
                           class="pl-10 block w-full rounded-lg border border-neutral-300 py-3 text-neutral-900 form-input-focus"
                           placeholder="请输入店铺详细地址">
                </div>
            </div>

            <div class="space-y-2">
                <label for="password" class="block text-sm font-medium text-neutral-700">
                    <i class="fa fa-lock mr-1"></i> 登录密码
                </label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fa fa-lock text-neutral-400"></i>
                    </div>
                    <input type="password" id="password" name="password" required
                           class="pl-10 block w-full rounded-lg border border-neutral-300 py-3 text-neutral-900 form-input-focus"
                           placeholder="请设置登录密码">
                </div>
            </div>

            <div class="space-y-2">
                <label for="confirmPassword" class="block text-sm font-medium text-neutral-700">
                    <i class="fa fa-lock mr-1"></i> 确认密码
                </label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fa fa-lock text-neutral-400"></i>
                    </div>
                    <input type="password" id="confirmPassword" name="confirmPassword" required
                           class="pl-10 block w-full rounded-lg border border-neutral-300 py-3 text-neutral-900 form-input-focus"
                           placeholder="请再次输入密码">
                </div>
            </div>

            <!-- 提交按钮 -->
            <button type="submit" class="btn-primary w-full flex items-center justify-center">
                <i class="fa fa-check-circle mr-2"></i> 立即注册
            </button>

            <!-- 登录链接 -->
            <div class="text-center text-sm text-neutral-700">
                已有账号？<a href="${pageContext.request.contextPath}/merchant/login"
                            class="text-primary hover:text-secondary font-medium transition-colors duration-200">
                立即登录
            </a>
            </div>
        </form>
    </div>

    <!-- 页脚信息 -->
    <div class="mt-8 text-center text-sm text-neutral-500">
        <p>© 2025 商家入驻平台. 摆烂小组🥰保留所有权利.</p>
    </div>
</div>

<!-- 背景装饰元素 -->
<div class="fixed inset-0 overflow-hidden pointer-events-none -z-10">
    <div class="absolute top-[10%] left-[5%] w-40 h-40 bg-primary/10 rounded-full blur-3xl"></div>
    <div class="absolute bottom-[20%] right-[10%] w-60 h-60 bg-secondary/10 rounded-full blur-3xl"></div>
</div>
</body>
</html>