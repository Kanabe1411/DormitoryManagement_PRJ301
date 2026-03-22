<%-- 
    Document   : header
    Created on : Feb 24, 2026, 4:30:54 AM
    Author     : toanl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
    .main-footer {
        background-color: #ffffff;
        border-top: 1px solid #dee2e6;
        padding: 2.5rem 0 1.5rem 0;
        margin-top: auto;
        color: #495057;
    }
    .footer-brand {
        font-weight: 800;
        color: #2c3e50;
        letter-spacing: -0.5px;
    }
    .footer-brand i {
        color: #e67e22; /* Màu cam đặc trưng của dự án Quản lý trọ */
    }
    .footer-link {
        color: #6c757d;
        text-decoration: none;
        font-size: 0.9rem;
        transition: all 0.2s;
    }
    .footer-link:hover {
        color: #e67e22;
        padding-left: 5px;
    }
    .status-indicator {
        width: 8px;
        height: 8px;
        background: #2ecc71;
        border-radius: 50%;
        display: inline-block;
        margin-right: 5px;
    }
</style>

<footer class="main-footer">
    <div class="container">
        <div class="row">
            <div class="col-lg-5 mb-4 mb-lg-0">
                <div class="footer-brand mb-3">
                    <i class="bi bi-house-heart-fill me-2"></i>DORMITORY MANAGEMENT
                </div>
                <p class="small text-muted mb-3" style="line-height: 1.6;">
                    Giải pháp tối ưu cho việc quản lý phòng trọ, căn hộ dịch vụ và ký túc xá. 
                    Hệ thống giúp tự động hóa quy trình hợp đồng, tính hóa đơn và quản lý người thuê hiệu quả.
                </p>
                <div class="small">
                    <span class="status-indicator"></span> 
                    <span class="text-muted">Hệ thống đang hoạt động ổn định (v2.6.0)</span>
                </div>
            </div>

            <div class="col-lg-3 col-md-6 mb-4 mb-md-0">
                <h6 class="fw-bold text-uppercase small mb-3">Tính năng chính</h6>
                <ul class="list-unstyled">
                    <li><a href="RoomController" class="footer-link"><i class="bi bi-chevron-right small"></i> Quản lý phòng</a></li>
                    <li><a href="ServiceController" class="footer-link"><i class="bi bi-chevron-right small"></i> Dịch vụ</a></li>
                    <li><a href="ContractController" class="footer-link"><i class="bi bi-chevron-right small"></i> Hợp đồng thuê</a></li>
                    <li><a href="ElectricityWaterController" class="footer-link"><i class="bi bi-chevron-right small"></i> Chỉ số điện nước</a></li>
                    <li><a href="ReportController" class="footer-link"><i class="bi bi-chevron-right small"></i> Báo cáo</a></li>
                </ul>
            </div>

            <div class="col-lg-4 col-md-6">
                <h6 class="fw-bold text-uppercase small mb-3">Thông tin dự án</h6>
                <div class="d-flex mb-2">
                    <i class="bi bi-geo-alt-fill text-muted me-2"></i>
                    <span class="small text-muted">Dự án môn học PRJ301 - Quản lý trọ</span>
                </div>
                <div class="d-flex mb-2">
                    <i class="bi bi-person-badge-fill text-muted me-2"></i>
                    <span class="small text-muted">Phát triển bởi: <strong>Kana</strong></span>
                </div>
                <div class="mt-3">
                    <a href="#" class="btn btn-sm btn-outline-secondary me-2"><i class="bi bi-github"></i> Source</a>
                    <a href="#" class="btn btn-sm btn-outline-secondary"><i class="bi bi-bug"></i> Báo lỗi</a>
                </div>
            </div>
        </div>

        <hr class="my-4 opacity-10">

        <div class="row align-items-center">
            <div class="col-md-12 text-center">
                <p class="mb-0 small text-muted">
                    &copy; 2026 <strong>Dormitory Management System</strong>. Thiết kế chuyên nghiệp cho nền tảng Java Web.
                </p>
            </div>
        </div>
    </div>
</footer>
