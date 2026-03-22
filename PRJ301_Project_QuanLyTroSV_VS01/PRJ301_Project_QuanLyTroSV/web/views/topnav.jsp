<%-- 
    Document   : topnav
    Created on : Feb 24, 2026, 4:31:02 AM
    Author     : toanl
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm mb-4">
    <div class="container">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto gap-2">
                <li class="nav-item"><a class="nav-link active fw-semibold" href="Home">🏠 Trang chủ</a></li>

                <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'LANDLORD'}">
                    <li class="nav-item"><a class="nav-link text-white" href="AccountController">👤 Tài khoản</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="RoomController">🏠 Quản lý Phòng</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="ServiceController">📶 Dịch vụ</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="ContractController">📄 Hợp đồng</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="ElectricityWaterController">⚡ Điện nước</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="PaymentController">💰 Doanh thu</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="ReportController">📊 Báo cáo</a></li>
                </c:if>

                <c:if test="${sessionScope.role == 'STUDENT'}">
                    <li class="nav-item"><a class="nav-link text-white" href="AccountController">👤 Hồ sơ</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="RoomController">🏠 Xem phòng</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="ContractController">📄 Hợp đồng của tôi</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="ElectricityWaterController">⚡ Điện nước</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="PaymentController">💳 Hóa đơn</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="ReportController">📋 Phản hồi</a></li>
                </c:if>
            </ul>
            <div class="d-flex">
                <a href="Logout" class="btn btn-danger btn-sm fw-bold px-3">🚪 Đăng xuất</a>
            </div>
        </div>
    </div>
</nav>