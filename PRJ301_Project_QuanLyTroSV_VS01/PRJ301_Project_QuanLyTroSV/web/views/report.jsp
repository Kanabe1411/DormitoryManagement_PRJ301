<%-- 
    Document   : report - Báo cáo thống kê
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Báo cáo Thống kê | Dormitory Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            body { font-family: 'Inter', sans-serif; background-color: #f8f9fc; }
            .action-card { border: none; border-radius: 15px; transition: all 0.3s; cursor: pointer; background: white; }
            .action-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
            .icon-box { width: 60px; height: 60px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; margin-bottom: 1rem; }
            .btn-primary-custom { background-color: #e67e22; border: none; }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <%@ include file="topnav.jsp" %>

        <div class="container py-5">
            <h2 class="fw-bold mb-4"><i class="bi bi-bar-chart-line me-2"></i>Báo cáo Thống kê</h2>

            <div class="row g-4">
                <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'LANDLORD'}">
                    <div class="col-md-4">
                        <a href="ReportController?action=notify" class="text-decoration-none">
                            <div class="card action-card shadow-sm h-100 p-4">
                                <div class="icon-box bg-primary bg-opacity-10 text-primary">
                                    <i class="bi bi-bell-fill"></i>
                                </div>
                                <h5 class="fw-bold">Gửi thông báo</h5>
                                <p class="text-muted small">Gửi thông báo tới cư dân hoặc toàn bộ hệ thống.</p>
                            </div>
                        </a>
                    </div>
                    <div class="col-md-4">
                        <a href="ReportController?action=feedback" class="text-decoration-none">
                            <div class="card action-card shadow-sm h-100 p-4">
                                <div class="icon-box bg-warning bg-opacity-10 text-warning">
                                    <i class="bi bi-chat-left-text-fill"></i>
                                </div>
                                <h5 class="fw-bold">Phản hồi / Khiếu nại</h5>
                                <p class="text-muted small">Xem và xử lý phản hồi, khiếu nại từ cư dân.</p>
                            </div>
                        </a>
                    </div>
                </c:if>
                <div class="col-md-4">
                    <a href="ReportController?action=support" class="text-decoration-none">
                        <div class="card action-card shadow-sm h-100 p-4">
                            <div class="icon-box bg-success bg-opacity-10 text-success">
                                <i class="bi bi-headset"></i>
                            </div>
                            <h5 class="fw-bold">Hỗ trợ người dùng</h5>
                            <p class="text-muted small">Gửi yêu cầu hỗ trợ, phản hồi hoặc khiếu nại.</p>
                        </div>
                    </a>
                </div>
                <div class="col-md-4">
                    <a href="ReportController?action=notifications" class="text-decoration-none">
                        <div class="card action-card shadow-sm h-100 p-4">
                            <div class="icon-box bg-info bg-opacity-10 text-info">
                                <i class="bi bi-envelope-fill"></i>
                            </div>
                            <h5 class="fw-bold">Thông báo của tôi</h5>
                            <p class="text-muted small">Xem tất cả thông báo đã nhận.</p>
                        </div>
                    </a>
                </div>
            </div>
        </div>

        <%@ include file="footer.jsp" %>
    </body>
</html>
