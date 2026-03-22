<%-- 
    Document   : account
    Created on : Mar 22, 2026, 5:31:28 AM
    Author     : toanl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách Tài khoản | Money Flow</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

        <style>
            body {
                font-family: 'Inter', sans-serif;
                background-color: #f4f7f6;
                color: #333;
            }
            .page-title {
                font-weight: 700;
                color: #2c3e50;
                position: relative;
            }
            .card {
                border-radius: 15px;
                border: none;
                overflow: hidden;
            }
            .table thead {
                background-color: #2c3e50;
                color: #ffffff;
            }
            .table th {
                font-weight: 600;
                text-transform: uppercase;
                font-size: 0.8rem;
                letter-spacing: 0.5px;
                padding: 15px;
            }
            .table td {
                padding: 15px;
                font-size: 0.9rem;
            }
            .role-badge {
                padding: 5px 12px;
                border-radius: 20px;
                font-weight: 600;
                font-size: 0.75rem;
            }
            .btn-action {
                width: 32px;
                height: 32px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                border-radius: 8px;
                transition: all 0.2s;
            }
            .user-avatar {
                width: 35px;
                height: 35px;
                background: #e9ecef;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 10px;
                color: #6c757d;
            }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <%@ include file="topnav.jsp" %>

        <div class="container py-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2 class="page-title mb-0">Quản lý Tài khoản</h2>
                    <p class="text-muted small mb-0">Hiển thị danh sách tất cả người dùng trong hệ thống</p>
                </div>
                <c:if test="${sessionScope.role == 'ADMIN'}">
                    <a href="AccountController?action=add" class="btn btn-primary fw-bold shadow-sm px-4 py-2">
                        <i class="bi bi-person-plus-fill me-2"></i> Thêm mới
                    </a>
                </c:if>
            </div>

            <div class="card shadow-sm">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4">ID</th>
                                    <th>Thông tin người dùng</th>
                                    <th>Vai trò</th>
                                    <th>Liên hệ</th>
                                    <th>Địa chỉ</th>
                                    <c:if test="${sessionScope.role == 'ADMIN'}">
                                        <th class="text-center pe-4">Thao tác</th>
                                    </c:if>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="row" items="${list}">
                                    <tr>
                                        <td class="ps-4 text-muted fw-medium">#${row[0]}</td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="user-avatar">
                                                    <i class="bi bi-person-circle fs-5"></i>
                                                </div>
                                                <div>
                                                    <div class="fw-bold text-dark">${row[4]}</div>
                                                    <div class="text-muted small">@${row[1]}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${row[3] == 'ADMIN'}">
                                                    <span class="role-badge bg-danger-subtle text-danger border border-danger-subtle">ADMIN</span>
                                                </c:when>
                                                <c:when test="${row[3] == 'LANDLORD'}">
                                                    <span class="role-badge bg-warning-subtle text-warning-emphasis border border-warning-subtle">LANDLORD</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="role-badge bg-success-subtle text-success border border-success-subtle">STUDENT</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="small"><i class="bi bi-envelope me-1 text-muted"></i> ${row[6]}</div>
                                            <div class="small"><i class="bi bi-telephone me-1 text-muted"></i> ${row[5]}</div>
                                        </td>
                                        <td><span class="text-truncate d-inline-block" style="max-width: 150px;">${row[7]}</span></td>
                                        
                                        <c:if test="${sessionScope.role == 'ADMIN'}">
                                            <td class="text-center pe-4">
                                                <div class="btn-group">
                                                    <a href="AccountController?action=edit&id=${row[0]}" 
                                                       class="btn btn-action btn-outline-primary me-2" title="Chỉnh sửa">
                                                        <i class="bi bi-pencil"></i>
                                                    </a>
                                                    <a href="AccountController?action=delete&id=${row[0]}" 
                                                       class="btn btn-action btn-outline-danger" 
                                                       onclick="return confirm('Hành động này không thể hoàn tác. Bạn có chắc chắn muốn xóa tài khoản này?');" 
                                                       title="Xóa">
                                                        <i class="bi bi-trash"></i>
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
                    <i class="bi bi-inbox fs-1 text-muted opacity-25"></i>
                    <p class="mt-2 text-muted">Không tìm thấy tài khoản nào trong hệ thống.</p>
                </div>
            </c:if>
        </div>

        <%@ include file="footer.jsp" %>
    </body>
</html>