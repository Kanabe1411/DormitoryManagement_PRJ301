<%-- 
    Document   : account-edit
    Created on : Mar 22, 2026, 5:51:10 AM
    Author     : toanl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sửa Tài Khoản | Money Flow</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

        <style>
            body {
                font-family: 'Inter', sans-serif;
                background-color: #f4f7f6;
            }
            .card {
                border-radius: 15px;
                border: none;
            }
            .card-header {
                background: linear-gradient(135deg, #198754 0%, #11613d 100%); /* Màu xanh lá đại diện cho Update/Edit */
            }
            .form-label {
                font-size: 0.9rem;
                font-weight: 600;
                color: #495057;
            }
            .form-control:focus, .form-select:focus {
                border-color: #198754;
                box-shadow: 0 0 0 0.25rem rgba(25, 135, 84, 0.15);
            }
            .btn-update {
                background-color: #198754;
                color: white;
                padding: 0.7rem 2rem;
                border-radius: 8px;
                border: none;
                transition: all 0.2s;
            }
            .btn-update:hover {
                background-color: #146c43;
                transform: translateY(-2px);
                color: white;
            }
            .badge-id {
                background: rgba(255, 255, 255, 0.2);
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 0.8rem;
            }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <%@ include file="topnav.jsp" %>

        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card shadow-lg">
                        <div class="card-header text-white text-center py-4">
                            <i class="bi bi-pencil-square fs-1 mb-2"></i>
                            <h3 class="mb-1 fw-bold">Chỉnh Sửa Tài Khoản</h3>
                            <span class="badge-id text-uppercase">ID người dùng: ${acc.id}</span>
                        </div>
                        
                        <div class="card-body p-4 p-md-5">
                            <form action="AccountController" method="post" class="row g-4">
                                <input type="hidden" name="action" value="edit"/>
                                <input type="hidden" name="id" value="${acc.id}"/>

                                <div class="col-md-6">
                                    <label class="form-label">Tên đăng nhập</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light"><i class="bi bi-person"></i></span>
                                        <input type="text" name="username" class="form-control" value="${acc.username}" required/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Mật khẩu mới</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light"><i class="bi bi-shield-lock"></i></span>
                                        <input type="password" name="password" class="form-control" value="${acc.password}" required/>
                                    </div>
                                </div>

                                <div class="col-12"><hr class="my-2 opacity-25"></div>

                                <div class="col-md-12">
                                    <label class="form-label">Họ và tên</label>
                                    <input type="text" name="fullname" class="form-control" value="${info.fullName}"/>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Số điện thoại</label>
                                    <input type="tel" name="phone" class="form-control" value="${info.phone}"/>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Email</label>
                                    <input type="email" name="email" class="form-control" value="${info.email}"/>
                                </div>

                                <div class="col-md-8">
                                    <label class="form-label">Địa chỉ hiện tại</label>
                                    <input type="text" name="address" class="form-control" value="${info.address}"/>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Vai trò (Role)</label>
                                    <select name="role" class="form-select">
                                        <option value="ADMIN" ${acc.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
                                        <option value="LANDLORD" ${acc.role == 'LANDLORD' ? 'selected' : ''}>LANDLORD</option>
                                        <option value="STUDENT" ${acc.role == 'STUDENT' ? 'selected' : ''}>STUDENT</option>
                                    </select>
                                </div>

                                <div class="col-12 text-center mt-5">
                                    <button type="submit" class="btn btn-update fw-bold shadow-sm me-2">
                                        <i class="bi bi-save me-1"></i> Lưu thay đổi
                                    </button>
                                    <a href="AccountController" class="btn btn-outline-secondary px-4">Quay lại</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="footer.jsp" %>
    </body>
</html>