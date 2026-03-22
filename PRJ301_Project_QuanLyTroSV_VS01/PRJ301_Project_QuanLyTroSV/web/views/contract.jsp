<%-- 
    Document   : contract
    Created on : Mar 22, 2026, 11:55:22 AM
    Author     : toanl
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Hợp Đồng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

        <style>
            body {
                font-family: 'Inter', sans-serif;
                background-color: #f4f7f6;
                color: #333;
            }
            .page-header {
                background: white;
                padding: 2rem 0;
                margin-bottom: 2rem;
                border-bottom: 1px solid #e3e6f0;
            }
            .card {
                border-radius: 15px;
                border: none;
            }
            .table thead {
                background-color: #4e73df;
                color: white;
            }
            .table th {
                font-weight: 600;
                font-size: 0.8rem;
                text-transform: uppercase;
                padding: 1rem;
            }
            .status-badge {
                padding: 6px 12px;
                border-radius: 20px;
                font-weight: 600;
                font-size: 0.75rem;
            }
            /* Style cho form gia hạn gọn gàng */
            .extend-form {
                display: flex;
                gap: 5px;
                align-items: center;
            }
            .input-mini {
                width: 130px !important;
                font-size: 0.8rem;
                padding: 4px 8px;
            }
            .btn-action-sm {
                padding: 4px 10px;
                font-size: 0.75rem;
                font-weight: 600;
                border-radius: 6px;
            }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <%@ include file="topnav.jsp" %>

        <div class="page-header shadow-sm">
            <div class="container">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h2 class="fw-bold mb-1"><i class="bi bi-file-earmark-text-fill text-primary me-2"></i>Danh sách Hợp đồng</h2>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item"><a href="home.jsp" class="text-decoration-none">Trang chủ</a></li>
                                <li class="breadcrumb-item active">Hợp đồng</li>
                            </ol>
                        </nav>
                    </div>
                    <a href="ContractController?action=create" class="btn btn-primary shadow-sm px-4 fw-bold">
                        <i class="bi bi-plus-circle me-1"></i> Tạo hợp đồng mới
                    </a>
                </div>
            </div>
        </div>

        <div class="container mb-5">
            <div class="card shadow-sm">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4">Mã HĐ</th>
                                    <th>Khách hàng</th>
                                    <th>Phòng</th>
                                    <th>Thời gian thuê</th>
                                    <th>Trạng thái</th>
                                    <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'LANDLORD'}">
                                        <th class="text-center">Hành động quản lý</th>
                                    </c:if>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="c" items="${list}">
                                    <tr>
                                        <td class="ps-4 fw-bold text-primary">#${c.id}</td>
                                        <td><i class="bi bi-person me-1"></i> ID: ${c.userId}</td>
                                        <td><span class="badge bg-light text-dark border"><i class="bi bi-door-closed me-1"></i>P.${c.roomId}</span></td>
                                        <td>
                                            <div class="small">Từ: <span class="fw-medium">${c.startDate}</span></div>
                                            <div class="small text-danger">Đến: <span class="fw-medium">${c.endDate}</span></div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${c.status == 'ACTIVE'}">
                                                    <span class="status-badge bg-success-subtle text-success border border-success-subtle">Đang hiệu lực</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge bg-secondary-subtle text-secondary border border-secondary-subtle">${c.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'LANDLORD'}">
                                            <td class="pe-4">
                                                <div class="d-flex flex-column gap-2 py-2">
                                                    <form action="ContractController" method="post" class="extend-form">
                                                        <input type="hidden" name="action" value="extend">
                                                        <input type="hidden" name="id" value="${c.id}">
                                                        <input type="date" name="endDate" class="form-control input-mini" required title="Chọn ngày kết thúc mới">
                                                        <button type="submit" class="btn btn-action-sm btn-outline-primary">Gia hạn</button>
                                                    </form>
                                                    
                                                    <form action="ContractController" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn thanh lý hợp đồng này?');">
                                                        <input type="hidden" name="action" value="cancel">
                                                        <input type="hidden" name="id" value="${c.id}">
                                                        <button type="submit" class="btn btn-action-sm btn-danger w-100">
                                                            <i class="bi bi-file-earmark-x me-1"></i> Thanh lý
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </c:if>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            
            <c:if test="${empty list}">
                <div class="text-center py-5 bg-white rounded-bottom shadow-sm mt-1">
                    <img src="https://cdn-icons-png.flaticon.com/512/7486/7486744.png" width="100" class="opacity-25 mb-3">
                    <p class="text-muted">Chưa có hợp đồng nào được tạo.</p>
                </div>
            </c:if>
        </div>

        <%@ include file="footer.jsp" %>
    </body>
</html>