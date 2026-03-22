<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .navbar-custom {
        background-color: #2c3e50; /* Màu tối sang trọng */
        padding: 0.8rem 1rem;
        border-bottom: 3px solid #e67e22; /* Đường kẻ cam đặc trưng của dự án Trọ */
    }
    .navbar-brand-custom {
        font-weight: 800;
        letter-spacing: -0.5px;
        color: #e67e22 !important;
    }
    .nav-link-custom {
        color: rgba(255,255,255,0.85) !important;
        font-weight: 500;
        padding: 0.5rem 1rem !important;
        border-radius: 8px;
        transition: all 0.3s ease;
    }
    .nav-link-custom:hover {
        color: #fff !important;
        background-color: rgba(230, 126, 34, 0.15);
    }
    .nav-link-custom.active {
        background-color: #e67e22 !important;
        color: white !important;
    }
    .btn-logout {
        background-color: transparent;
        border: 2px solid #ff4757;
        color: #ff4757;
        font-weight: 700;
        border-radius: 8px;
        padding: 0.4rem 1.2rem;
        transition: all 0.3s;
    }
    .btn-logout:hover {
        background-color: #ff4757;
        color: white;
        box-shadow: 0 4px 12px rgba(255, 71, 87, 0.3);
    }
    .user-badge {
        background: rgba(255,255,255,0.1);
        padding: 0.4rem 1rem;
        border-radius: 20px;
        color: #ecf0f1;
        font-size: 0.85rem;
        margin-right: 15px;
        border: 1px solid rgba(255,255,255,0.1);
    }
</style>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom shadow mb-4">
    <div class="container">
        <a class="navbar-brand navbar-brand-custom me-4" href="Home">
            <i class="bi bi-house-heart-fill me-1"></i> DORM-MS
        </a>

        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 gap-1">
                <li class="nav-item">
                    <a class="nav-link nav-link-custom active" href="Home">
                        <i class="bi bi-speedometer2 me-1"></i> Dashboard
                    </a>
                </li>

                <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'LANDLORD'}">
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom" href="AccountController">
                            <i class="bi bi-people me-1"></i> Tài khoản
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom" href="RoomController">
                            <i class="bi bi-door-open me-1"></i> Quản lý Phòng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom" href="ContractController">
                            <i class="bi bi-file-earmark-medical me-1"></i> Hợp đồng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom" href="PaymentController">
                            <i class="bi bi-cash-stack me-1"></i> Tài chính
                        </a>
                    </li>
                </c:if>

                <c:if test="${sessionScope.role == 'STUDENT'}">
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom" href="AccountController">
                            <i class="bi bi-person-badge me-1"></i> Hồ sơ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom" href="RoomController?action=view">
                            <i class="bi bi-search me-1"></i> Tìm phòng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom" href="ContractController">
                            <i class="bi bi-file-earmark-text me-1"></i> Hợp đồng của tôi
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom" href="PaymentController?action=view">
                            <i class="bi bi-receipt me-1"></i> Hóa đơn
                        </a>
                    </li>
                </c:if>
            </ul>

            <div class="d-flex align-items-center">
                <div class="user-badge d-none d-lg-block">
                    <i class="bi bi-person-circle me-1 text-warning"></i>
                    <span class="small fw-bold text-uppercase">${sessionScope.role}</span>
                </div>
                <a href="Logout" class="btn btn-logout shadow-sm">
                    <i class="bi bi-box-arrow-right me-1"></i> Thoát
                </a>
            </div>
        </div>
    </div>
</nav>
