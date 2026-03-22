<%-- 
    Document   : service-assign
    Gán dịch vụ cho phòng
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gán Dịch vụ cho Phòng | Dormitory Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            body { font-family: 'Inter', sans-serif; background-color: #f8f9fc; }
            .card { border: none; border-radius: 15px; }
            .card-header { background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%); color: white; border-radius: 15px 15px 0 0 !important; }
            .service-item { border: 1px solid #dee2e6; border-radius: 10px; padding: 12px 16px; margin-bottom: 8px; display: flex; justify-content: space-between; align-items: center; }
            .service-item.assigned { background-color: #d1e7dd; border-color: #badbcc; }
            .btn-sm-round { width: 32px; height: 32px; padding: 0; border-radius: 8px; display: inline-flex; align-items: center; justify-content: center; }
            .btn-primary-custom { background-color: #e67e22; border: none; }
            .btn-primary-custom:hover { background-color: #d35400; color: white; }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <%@ include file="topnav.jsp" %>

        <div class="container py-5">
            <div class="row mb-4">
                <div class="col">
                    <a href="RoomController" class="btn btn-outline-secondary btn-sm"><i class="bi bi-arrow-left me-1"></i> Quay lại phòng</a>
                </div>
            </div>

            <div class="card shadow-sm mb-4">
                <div class="card-header py-3">
                    <h5 class="mb-0"><i class="bi bi-door-open me-2"></i>Phòng ${room.roomNumber}</h5>
                    <p class="mb-0 small opacity-75">Gán dịch vụ cho phòng (tích hợp thanh toán)</p>
                </div>
                <div class="card-body">
                    <p class="text-muted small mb-3">
                        <strong class="text-success">Tiền phòng:</strong> <fmt:formatNumber value="${room.price}" type="number"/> ₫ 
                        + <strong class="text-primary">Dịch vụ</strong> (tùy chọn bên dưới) = <strong>Tổng thanh toán hàng tháng</strong>
                    </p>

                    <h6 class="fw-bold mt-4 mb-2">Dịch vụ đã gán</h6>
                    <c:forEach items="${roomServices}" var="s">
                        <div class="service-item assigned">
                            <span>${s.name} - <fmt:formatNumber value="${s.price}" type="number"/> ₫/${s.unit}</span>
                            <form action="ServiceController" method="post" class="d-inline">
                                <input type="hidden" name="action" value="unassign"/>
                                <input type="hidden" name="roomId" value="${room.id}"/>
                                <input type="hidden" name="serviceId" value="${s.id}"/>
                                <button type="submit" class="btn btn-danger btn-sm-round" title="Gỡ dịch vụ"><i class="bi bi-dash-lg"></i></button>
                            </form>
                        </div>
                    </c:forEach>
                    <c:if test="${empty roomServices}">
                        <p class="text-muted small">Chưa gán dịch vụ nào.</p>
                    </c:if>

                    <h6 class="fw-bold mt-4 mb-2">Thêm dịch vụ</h6>
                    <c:forEach items="${allServices}" var="s">
                        <c:set var="isAssigned" value="false"/>
                        <c:forEach items="${roomServices}" var="rs">
                            <c:if test="${rs.id == s.id}"><c:set var="isAssigned" value="true"/></c:if>
                        </c:forEach>
                        <c:if test="${!isAssigned}">
                            <div class="service-item">
                                <span>${s.name} - <fmt:formatNumber value="${s.price}" type="number"/> ₫/${s.unit}</span>
                                <form action="ServiceController" method="post" class="d-inline">
                                    <input type="hidden" name="action" value="assign"/>
                                    <input type="hidden" name="roomId" value="${room.id}"/>
                                    <input type="hidden" name="serviceId" value="${s.id}"/>
                                    <button type="submit" class="btn btn-primary-custom btn-primary btn-sm-round" title="Gán dịch vụ"><i class="bi bi-plus-lg"></i></button>
                                </form>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>

        <%@ include file="footer.jsp" %>
    </body>
</html>
