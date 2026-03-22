<%-- 
    Document   : electricity-water-room
    Chỉ số điện nước theo phòng (cho sinh viên)
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chỉ số Điện Nước - ${room.roomNumber} | Dormitory Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            body { font-family: 'Inter', sans-serif; background-color: #f8f9fc; }
            .card { border: none; border-radius: 15px; }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <%@ include file="topnav.jsp" %>

        <div class="container py-5">
            <div class="mb-4">
                <a href="ElectricityWaterController" class="btn btn-outline-secondary btn-sm"><i class="bi bi-arrow-left me-1"></i> Quay lại</a>
            </div>
            <h2 class="fw-bold mb-3"><i class="bi bi-door-open me-2"></i>Phòng ${room.roomNumber}</h2>

            <div class="card shadow-sm">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th>Tháng/Năm</th>
                                    <th>Điện (kWh)</th>
                                    <th>Nước (m³)</th>
                                    <th>Tiền điện</th>
                                    <th>Tiền nước</th>
                                    <th>Tổng</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${list}" var="ew">
                                    <tr>
                                        <td>${ew.month}/${ew.year}</td>
                                        <td>${ew.electricPrevious} → ${ew.electricCurrent}</td>
                                        <td>${ew.waterPrevious} → ${ew.waterCurrent}</td>
                                        <td><fmt:formatNumber value="${ew.electricCost}" type="number"/> ₫</td>
                                        <td><fmt:formatNumber value="${ew.waterCost}" type="number"/> ₫</td>
                                        <td class="fw-bold"><fmt:formatNumber value="${ew.totalCost}" type="number"/> ₫</td>
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
                    <p class="text-muted mt-3">Chưa có chỉ số nào cho phòng này.</p>
                </div>
            </c:if>
        </div>

        <%@ include file="footer.jsp" %>
    </body>
</html>
