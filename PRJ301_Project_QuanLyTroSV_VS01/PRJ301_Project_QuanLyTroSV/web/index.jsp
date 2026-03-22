<%-- 
    Document   : index
    Created on : Feb 10, 2026, 3:49:37 AM
    Author     : toanl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hệ Thống Quản Lý Trọ Sinh Viên</title>
        <style>
            /* Reset CSS */
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            /* Container chứa slideshow nền */
            .background-slider {
                position: fixed;
                top: 0;
                left: 0;
                width: 100vw;
                height: 100vh;
                z-index: -1;
                background-color: #222; /* Màu nền đen dự phòng, loại bỏ chớp trắng */
            }

            /* Cấu hình chung cho từng tấm ảnh */
            .slide {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-size: cover;
                background-position: center;
                opacity: 0; /* Bắt đầu với độ trong suốt = 0 */
                /* Lớp phủ đen mờ để làm nổi form đăng nhập */
                box-shadow: inset 0 0 0 2000px rgba(0, 0, 0, 0.4); 
                animation: fadeAnimation 15s infinite;
            }

            /* Tấm ảnh 1 - Hiện ngay lập tức */
            .slide-1 {
                background-image: url('https://images.unsplash.com/photo-1555854877-bab0e564b8d5?q=80&w=1920&auto=format&fit=crop');
                animation-delay: 0s;
            }
            
            /* Tấm ảnh 2 - Chờ 5 giây rồi mới hiện */
            .slide-2 {
                background-image: url('https://images.unsplash.com/photo-1522771731478-446370ba35ae?q=80&w=1920&auto=format&fit=crop');
                animation-delay: 5s;
            }
            
            /* Tấm ảnh 3 - Chờ 10 giây rồi mới hiện */
            .slide-3 {
                background-image: url('https://images.unsplash.com/photo-1540518614846-7eded433c457?q=80&w=1920&auto=format&fit=crop');
                animation-delay: 10s;
            }

            /* Hiệu ứng mờ dần (Cross-fade) cực kỳ mượt mà */
            @keyframes fadeAnimation {
                0%   { opacity: 0; }
                10%  { opacity: 1; }
                33%  { opacity: 1; }
                43%  { opacity: 0; }
                100% { opacity: 0; }
            }

            /* Bố cục Form */
            body {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                overflow: hidden;
            }
            .login-box {
                background: rgba(255, 255, 255, 0.85);
                backdrop-filter: blur(10px);
                padding: 40px;
                border-radius: 12px;
                box-shadow: 0 15px 25px rgba(0,0,0,0.2);
                width: 100%;
                max-width: 400px;
                text-align: center;
            }

            .login-box h2 {
                color: #333;
                margin-bottom: 30px;
                font-size: 24px;
                font-weight: 600;
            }

            .input-group {
                margin-bottom: 20px;
                text-align: left;
            }

            .input-group label {
                display: block;
                margin-bottom: 8px;
                color: #555;
                font-weight: 500;
                font-size: 14px;
            }

            .input-group input {
                width: 100%;
                padding: 12px 15px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 15px;
                outline: none;
                transition: border-color 0.3s;
            }

            .input-group input:focus {
                border-color: #007bff;
                box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
            }

            .button-group {
                display: flex;
                flex-direction: column;
                gap: 12px;
                margin-top: 25px;
            }

            .btn {
                width: 100%;
                padding: 12px;
                border: none;
                border-radius: 6px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: background-color 0.3s, transform 0.1s;
            }

            .btn:active {
                transform: scale(0.98);
            }

            .btn-login {
                background-color: #007bff;
                color: white;
            }

            .btn-login:hover {
                background-color: #0056b3;
            }

            .btn-register {
                background-color: transparent;
                color: #007bff;
                border: 2px solid #007bff;
            }

            .btn-register:hover {
                background-color: #f0f8ff;
            }

            .error-message {
                color: #dc3545;
                margin-top: 15px;
                font-size: 14px;
                font-weight: 500;
                min-height: 20px;
            }
        </style>
    </head>
    <body>
        <div class="background-slider">
            <div class="slide slide-1"></div>
            <div class="slide slide-2"></div>
            <div class="slide slide-3"></div>
        </div>

        <div class="login-box">
            <h2>Hệ Thống Quản Lý Trọ Sinh Viên</h2>
            
            <form action="Login" method="post">
                <div class="input-group">
                    <label for="username">Tên đăng nhập</label>
                    <input type="text" id="username" name="username" placeholder="Nhập tên đăng nhập" required autocomplete="off"/>
                </div>
                
                <div class="input-group">
                    <label for="password">Mật khẩu</label>
                    <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" required />
                </div>
                
                <div class="button-group">
                    <button type="submit" class="btn btn-login">Đăng nhập</button>
                    <button type="button" class="btn btn-register" onclick="window.location.href = 'Register'">Tạo tài khoản mới</button>
                </div>
            </form>
            
            <div class="error-message">
                ${error}
            </div>
        </div>
    </body>
</html>