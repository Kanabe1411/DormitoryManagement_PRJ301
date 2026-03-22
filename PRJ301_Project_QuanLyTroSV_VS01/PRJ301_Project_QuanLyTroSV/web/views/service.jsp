<%-- 
    Document   : service
    Quản lý dịch vụ
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Dịch vụ | Dormitory Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            body { font-family: 'Inter', sans-serif; background-color: #f8f9fc; color: #333; }
            .page-title { font-weight: 700; color: #2c3e50; }
            .card { border: none; border-radius: 15px; overflow: hidden; }
            .table thead { background-color: #2c3e50; color: white; }
            .table th { font-size: 0.8rem; text-transform: uppercase; letter-spacing: 0.5px; padding: 15px; }
            .table td { padding: 15px; vertical-align: middle; }
            .btn-action { width: 35px; height: 35px; display: inline-flex; align-items: center; justify-content: center; border-radius: 8px; transition: all 0.2s; }
            .btn-primary-custom { background-color: #e67e22; border: none; font-weight: 600; }
            .btn-primary-custom:hover { background-color: #d35400; color: white; }
            .price-text { font-weight: 600; color: #2c3e50; }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <%@ include file="topnav.jsp" %>

        <div class="container py-5">
            <div class="row align-items-center mb-4">
                <div class="col-md-6">
                    <h2 class="page-title mb-1"><i class="bi bi-wifi me-2"></i>Quản lý Dịch vụ</h2>
                    <p class="text-muted small">Thêm dịch vụ (Wifi, gửi xe...), cập nhật giá, gán dịch vụ cho phòng.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'LANDLORD'}">
                        <a href="ServiceController?action=add" class="btn btn-primary-custom btn-primary shadow-sm px-4 py-2">
                            <i class="bi bi-plus-square-fill me-2"></i>Thêm dịch vụ
                        </a>
                    </c:if>
                </div>
            </div>

            <div class="card shadow-sm">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4">ID</th>
                                    <th>Tên dịch vụ</th>
                                    <th>Giá (VNĐ)</th>
                                    <th>Đơn vị</th>
                                    <th>Mô tả</th>
                                    <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'LANDLORD'}">
                                        <th class="text-center pe-4">Thao tác</th>
                                    </c:if>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${list}" var="s">
                                    <tr>
                                        <td class="ps-4 text-muted small">#${s.id}</td>
                                        <td><span class="fw-semibold">${s.name}</span></td>
                                        <td>
                                            <span class="price-text"><fmt:formatNumber value="${s.price}" type="number"/></span>
                                            <small class="text-muted">₫</small>
                                        </td>
                                        <td>${s.unit}</td>
                                        <td class="text-muted small">${not empty s.description ? s.description : '—'}</td>
                                        <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'LANDLORD'}">
                                            <td class="text-center pe-4">
                                                <a href="ServiceController?action=edit&id=${s.id}" class="btn btn-action btn-outline-primary me-2" title="Sửa giá"><i class="bi bi-pencil-fill"></i></a>
                                                <a href="ServiceController?action=delete&id=${s.id}" class="btn btn-action btn-outline-danger" 
                                                   onclick="return confirm('Xóa dịch vụ này? Các phòng đang dùng sẽ bị gỡ.');" title="Xóa"><i class="bi bi-trash3-fill"></i></a>
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
                <div class="text-center py-5 bg-white rounded shadow-sm">
                    <i class="bi bi-wifi display-1 text-light"></i>
                    <p class="text-muted mt-3">Chưa có dịch vụ nào.</p>
                </div>
            </c:if>
        </div>

        <%@ include file="footer.jsp" %>
    </body>
</html>
