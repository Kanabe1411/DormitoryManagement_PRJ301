<%-- 
    Document   : electricity-water
    Chỉ số điện nước
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chỉ số Điện Nước | Dormitory Management</title>
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
            .btn-primary-custom { background-color: #e67e22; border: none; font-weight: 600; }
            .btn-primary-custom:hover { background-color: #d35400; color: white; }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <%@ include file="topnav.jsp" %>

        <div class="container py-5">
            <div class="row align-items-center mb-4">
                <div class="col-md-6">
                    <h2 class="page-title mb-1"><i class="bi bi-lightning-charge me-2"></i>Chỉ số Điện Nước</h2>
                    <p class="text-muted small">Cập nhật và theo dõi chỉ số điện, nước theo từng phòng.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'LANDLORD'}">
                        <a href="ElectricityWaterController?action=add" class="btn btn-primary-custom btn-primary shadow-sm px-4 py-2">
                            <i class="bi bi-plus-square-fill me-2"></i>Thêm chỉ số
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
                                    <th class="ps-4">Phòng</th>
                                    <th>Tháng/Năm</th>
                                    <th>Điện (kWh)</th>
                                    <th>Nước (m³)</th>
                                    <th>Tiền điện</th>
                                    <th>Tiền nước</th>
                                    <th>Tổng</th>
                                    <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'LANDLORD'}">
                                        <th class="text-center pe-4">Thao tác</th>
                                    </c:if>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${list}" var="ew">
                                    <tr>
                                        <td class="ps-4 fw-semibold">${ew.roomNumber}</td>
                                        <td>${ew.month}/${ew.year}</td>
                                        <td>${ew.electricPrevious} → ${ew.electricCurrent}</td>
                                        <td>${ew.waterPrevious} → ${ew.waterCurrent}</td>
                                        <td><fmt:formatNumber value="${ew.electricCost}" type="number"/> ₫</td>
                                        <td><fmt:formatNumber value="${ew.waterCost}" type="number"/> ₫</td>
                                        <td class="fw-bold text-primary"><fmt:formatNumber value="${ew.totalCost}" type="number"/> ₫</td>
                                        <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'LANDLORD'}">
                                            <td class="text-center pe-4">
                                                <a href="ElectricityWaterController?action=edit&id=${ew.id}" class="btn btn-sm btn-outline-primary me-1">Sửa</a>
                                                <a href="ElectricityWaterController?action=delete&id=${ew.id}" class="btn btn-sm btn-outline-danger" 
                                                   onclick="return confirm('Xóa bản ghi này?');">Xóa</a>
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
                    <i class="bi bi-droplet display-1 text-light"></i>
                    <p class="text-muted mt-3">Chưa có chỉ số nào.</p>
                </div>
            </c:if>
        </div>

        <%@ include file="footer.jsp" %>
    </body>
</html>
