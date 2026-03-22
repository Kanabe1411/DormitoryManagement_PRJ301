<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Thanh toán | Dormitory Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

        <style>
            body { font-family: 'Inter', sans-serif; background-color: #f8f9fc; color: #333; }
            .card { border: none; border-radius: 15px; box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1); }
            .card-header { background-color: #ffffff; border-bottom: 1px solid #e3e6f0; font-weight: 700; color: #4e73df; }
            .btn-primary { background-color: #e67e22; border: none; font-weight: 600; }
            .btn-primary:hover { background-color: #d35400; }
            .table thead { background-color: #4e73df; color: white; }
            .status-paid { background-color: #d1e7dd; color: #0f5132; font-weight: 600; padding: 5px 12px; border-radius: 20px; font-size: 0.8rem; }
            .status-unpaid { background-color: #f8d7da; color: #842029; font-weight: 600; padding: 5px 12px; border-radius: 20px; font-size: 0.8rem; }
            .currency { font-weight: 700; color: #2c3e50; }
            .input-group-text { background-color: #f8f9fc; color: #e67e22; }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <%@ include file="topnav.jsp" %>

        <div class="container py-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold"><i class="bi bi-wallet2 text-warning me-2"></i>Quản lý Thanh toán</h2>
                <div class="text-muted small">Hôm nay: <span class="fw-bold"><%= new java.util.Date() %></span></div>
            </div>

            <c:if test="${canAdd}">
            <div class="card mb-4">
                <div class="card-header py-3">
                    <i class="bi bi-plus-circle me-1"></i> Ghi nhận Giao dịch Mới
                </div>
                <div class="card-body bg-light-subtle">
                    <form action="PaymentController" method="POST" class="row g-3 align-items-end">
                        <div class="col-md-2">
                            <label class="form-label small fw-bold">Hợp đồng</label>
                            <select name="contractId" class="form-select" required>
                                <option value="">-- Chọn HĐ --</option>
                                <c:forEach items="${contracts}" var="c">
                                    <option value="${c.id}">HĐ #${c.id}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label small fw-bold">Loại thanh toán</label>
                            <select name="paymentType" class="form-select">
                                <option value="Tiền trọ">Tiền trọ</option>
                                <option value="Tiền điện nước">Tiền điện nước</option>
                                <option value="Tiền dịch vụ">Tiền dịch vụ</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label small fw-bold">Ngày thu</label>
                            <input type="date" name="date" class="form-control" required>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label small fw-bold">Số tiền (VNĐ)</label>
                            <div class="input-group">
                                <input type="number" name="amount" class="form-control" placeholder="0" required>
                                <span class="input-group-text">₫</span>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label small fw-bold">Trạng thái</label>
                            <select name="status" class="form-select">
                                <option value="Đã thu">Đã thu</option>
                                <option value="Chưa thu">Chưa thu</option>
                            </select>
                        </div>
                        <div class="col-md-1">
                            <button type="submit" class="btn btn-primary w-100"><i class="bi bi-save"></i></button>
                        </div>
                    </form>
                </div>
            </div>
            </c:if>

            <div class="card">
                <div class="card-header py-3 d-flex justify-content-between align-items-center bg-white">
                    <span><i class="bi bi-list-ul me-1"></i> Lịch sử Giao dịch</span>
                    <c:if test="${canAdd}"><a href="PaymentController?action=export" class="btn btn-sm btn-outline-secondary"><i class="bi bi-download me-1"></i> Xuất báo cáo</a></c:if>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4">ID</th>
                                    <th>Hợp đồng</th>
                                    <th>Loại</th>
                                    <th>Ngày Giao dịch</th>
                                    <th>Số tiền</th>
                                    <th>Trạng thái</th>
                                    <c:if test="${canAdd}"><th class="text-center">Thao tác</th></c:if>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${list}" var="p">
                                    <tr>
                                        <td class="ps-4 text-muted">#${p.id}</td>
                                        <td><span class="badge bg-info-subtle text-info border border-info-subtle">HĐ ${p.contractIdStr}</span></td>
                                        <td><small>${p.paymentType != null ? p.paymentType : 'Tiền trọ'}</small></td>
                                        <td><i class="bi bi-calendar3 me-1 text-muted"></i> ${p.date}</td>
                                        <td>
                                            <span class="currency">
                                                <fmt:formatNumber value="${p.amount}" type="number" />
                                            </span> 
                                            <small class="text-muted">₫</small>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${p.status == 'Đã thu' || p.status == '1'}">
                                                    <span class="status-paid"><i class="bi bi-check-circle-fill me-1"></i> Đã thu</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-unpaid"><i class="bi bi-clock-history me-1"></i> Chưa thu</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <c:if test="${canAdd}">
                                        <td class="text-center">
                                            <a href="PaymentController?action=delete&id=${p.id}" 
                                               class="btn btn-sm btn-outline-danger border-0" 
                                               onclick="return confirm('Xóa lịch sử thanh toán này?');">
                                                <i class="bi bi-trash"></i>
                                            </a>
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
                <div class="text-center py-5">
                    <i class="bi bi-cash-stack display-1 text-light"></i>
                    <p class="text-muted">Chưa có dữ liệu thanh toán nào được ghi nhận.</p>
                </div>
            </c:if>
        </div>

        <%@ include file="footer.jsp" %>
    </body>
</html>