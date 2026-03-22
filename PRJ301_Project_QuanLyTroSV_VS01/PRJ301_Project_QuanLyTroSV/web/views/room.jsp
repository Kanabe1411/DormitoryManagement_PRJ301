<%-- 
    Document   : room
    Created on : Mar 22, 2026, 8:43:42 AM
    Author     : toanl
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Danh sách Phòng | Dormitory Management</title>
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
            
            /* Status Badges */
            .badge-available { background-color: #d1e7dd; color: #0f5132; border: 1px solid #badbcc; }
            .badge-occupied { background-color: #f8d7da; color: #842029; border: 1px solid #f5c2c7; }
            
            .room-number { font-weight: 700; color: #e67e22; font-size: 1.1rem; }
            .price-text { font-weight: 600; color: #2c3e50; }
            .btn-action { width: 35px; height: 35px; display: inline-flex; align-items: center; justify-content: center; border-radius: 8px; transition: all 0.2s; }
            .description-cell { max-width: 250px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: #6c757d; font-size: 0.9rem; }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <%@ include file="topnav.jsp" %>

        <div class="container py-5">
            <div class="row align-items-center mb-4">
                <div class="col-md-6">
                    <h2 class="page-title mb-1">Hệ thống Quản lý Phòng</h2>
                    <p class="text-muted small">Quản lý trạng thái, giá thuê và thông tin chi tiết từng phòng trọ.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.account.role == 'LANDLORD'}">
                        <a href="RoomController?action=add" class="btn btn-primary fw-bold shadow-sm px-4 py-2" style="background-color: #e67e22; border: none;">
                            <i class="bi bi-plus-square-fill me-2"></i>Thêm phòng mới
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
                                    <th>Số Phòng</th>
                                    <th>Giá Thuê / Tháng</th>
                                    <th>Trạng Thái</th>
                                    <th>Mô Tả</th>
                                    <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.account.role == 'LANDLORD'}">
                                        <th class="text-center pe-4">Thao tác</th>
                                    </c:if>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${list}" var="r">
                                    <tr>
                                        <td class="ps-4 text-muted small">#${r.id}</td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <i class="bi bi-door-closed-fill text-secondary me-2 fs-5"></i>
                                                <span class="room-number">${r.roomNumber}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="price-text">
                                                <fmt:formatNumber value="${r.price}" type="number"/>
                                            </span>
                                            <small class="text-muted">₫</small>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${r.status == 'Chưa thuê'}">
                                                    <span class="badge badge-available px-3 py-2 rounded-pill small">
                                                        <i class="bi bi-check-circle-fill me-1"></i> Trống
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-occupied px-3 py-2 rounded-pill small">
                                                        <i class="bi bi-person-fill me-1"></i> Đã thuê
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="description-cell" title="${r.description}">
                                                ${not empty r.description ? r.description : '—'}
                                            </div>
                                        </td>
                                        <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.account.role == 'LANDLORD'}">
                                            <td class="text-center pe-4">
                                                <div class="btn-group">
                                                    <a href="ServiceController?action=assign&roomId=${r.id}" 
                                                       class="btn btn-action btn-outline-success me-2" title="Gán dịch vụ">
                                                        <i class="bi bi-wifi"></i>
                                                    </a>
                                                    <a href="RoomController?action=edit&id=${r.id}" 
                                                       class="btn btn-action btn-outline-primary me-2" title="Sửa thông tin">
                                                        <i class="bi bi-pencil-fill"></i>
                                                    </a>
                                                    <a href="RoomController?action=delete&id=${r.id}" 
                                                       class="btn btn-action btn-outline-danger" 
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa phòng này? Thao tác này có thể ảnh hưởng đến các hợp đồng liên quan.');"
                                                       title="Xóa phòng">
                                                        <i class="bi bi-trash3-fill"></i>
                                                    </a>
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
                <div class="text-center py-5 bg-white rounded-bottom shadow-sm">
                    <i class="bi bi-house-exclamation display-1 text-light"></i>
                    <p class="text-muted mt-3">Hiện chưa có phòng nào trong danh sách quản lý.</p>
                </div>
            </c:if>
        </div>

        <%@ include file="footer.jsp" %>
    </body>
</html>