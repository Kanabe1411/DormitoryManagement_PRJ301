<%-- 
    Document   : home
    Created on : Feb 24, 2026, 4:30:41 AM
    Author     : toanl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Trang Chủ | Money Flow</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

        <style>
            body {
                font-family: 'Inter', sans-serif;
                background-color: #f4f7f6;
                color: #333;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }
            .hero-section {
                background: linear-gradient(135deg, #0d6efd 0%, #0043a8 100%);
                color: white;
                padding: 60px 0;
                border-radius: 0 0 30px 30px;
                margin-bottom: 40px;
                shadow: 0 4px 15px rgba(0,0,0,0.1);
            }
            .welcome-msg {
                font-weight: 700;
                letter-spacing: -0.5px;
            }
            .action-card {
                border: none;
                border-radius: 15px;
                transition: all 0.3s ease;
                cursor: pointer;
                background: white;
            }
            .action-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important;
            }
            .icon-box {
                width: 60px;
                height: 60px;
                background: rgba(13, 110, 253, 0.1);
                color: #0d6efd;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
                margin-bottom: 1rem;
            }
            footer {
                margin-top: auto;
                padding: 20px 0;
                color: #6c757d;
                font-size: 0.9rem;
            }
        </style>
    </head>
    <body>

        <%@ include file="header.jsp" %>
        <%@ include file="topnav.jsp" %>

        <div class="hero-section shadow-sm">
            <div class="container text-center">
                <h1 class="display-5 welcome-msg mb-3">
                    <i class="bi bi-speedometer2 me-2"></i>
                    ${not empty message ? message : "Chào mừng bạn trở lại!"}
                </h1>
                <p class="lead opacity-75">Hệ thống quản lý tài chính và nhà trọ thông minh dành cho bạn.</p>
            </div>
        </div>

        <div class="container mb-5">
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card action-card shadow-sm h-100 p-4">
                        <div class="icon-box"><i class="bi bi-people-fill"></i></div>
                        <h5 class="fw-bold">Quản lý Tài khoản</h5>
                        <p class="text-muted small">Thêm mới, chỉnh sửa hoặc phân quyền người dùng trong hệ thống.</p>
                        <a href="AccountController" class="stretched-link"></a>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="card action-card shadow-sm h-100 p-4">
                        <div class="icon-box"><i class="bi bi-wallet2"></i></div>
                        <h5 class="fw-bold">Quản lý Thu chi</h5>
                        <p class="text-muted small">Theo dõi dòng tiền, doanh thu và các khoản chi phí phát sinh hàng tháng.</p>
                        <a href="PaymentController" class="stretched-link"></a>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card action-card shadow-sm h-100 p-4">
                        <div class="icon-box"><i class="bi bi-bar-chart-line"></i></div>
                        <h5 class="fw-bold">Báo cáo Thống kê</h5>
                        <p class="text-muted small">Gửi thông báo, phản hồi/khiếu nại, hỗ trợ người dùng.</p>
                        <a href="ReportController" class="stretched-link"></a>
                    </div>
                </div>
            </div>
        </div>

        <footer class="text-center bg-white border-top">
            <div class="container">
                &copy; 2026 <strong>Dormitory Management System</strong>. Thiết kế bởi Kana & Team.
            </div>
        </footer>

    </body>
</html>