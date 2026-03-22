<%-- 
    Document   : account-add
    Created on : Mar 22, 2026, 5:43:16 AM
    Author     : toanl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thêm Tài Khoản | Quản lý Hệ thống</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

        <style>
            body {
                font-family: 'Inter', sans-serif;
                background-color: #f4f7f6;
                color: #333;
            }
            .card {
                border-radius: 15px;
                overflow: hidden;
            }
            .card-header {
                background: linear-gradient(135deg, #0d6efd 0%, #0043a8 100%);
            }
            .form-label {
                font-size: 0.9rem;
                margin-bottom: 0.4rem;
                color: #495057;
            }
            .form-control, .form-select {
                border-radius: 8px;
                padding: 0.6rem 1rem;
                border: 1px solid #ced4da;
                transition: all 0.2s ease-in-out;
            }
            .form-control:focus, .form-select:focus {
                border-color: #0d6efd;
                box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.15);
            }
            .btn-primary {
                background-color: #0d6efd;
                border: none;
                padding: 0.7rem 2rem;
                border-radius: 8px;
                transition: transform 0.2s;
            }
            .btn-primary:hover {
                transform: translateY(-2px);
                background-color: #0056b3;
            }
            .input-group-text {
                background-color: transparent;
                border-right: none;
            }
            .has-icon .form-control {
                border-left: none;
            }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <%@ include file="topnav.jsp" %>

        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-8 col-xl-7">
                    <div class="card shadow-sm border-0">
                        <div class="card-header text-white text-center py-4">
                            <i class="bi bi-person-plus-fill fs-1 mb-2"></i>
                            <h3 class="mb-0 fw-bold">Thêm Tài Khoản Mới</h3>
                            <p class="small opacity-75 mb-0">Vui lòng điền đầy đủ thông tin bên dưới</p>
                        </div>
                        
                        <div class="card-body p-4 p-md-5">
                            <form action="AccountController" method="post" class="row g-4">
                                <input type="hidden" name="action" value="add"/>

                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Tên đăng nhập <span class="text-danger">*</span></label>
                                    <div class="input-group has-icon">
                                        <span class="input-group-text"><i class="bi bi-person"></i></span>
                                        <input type="text" name="username" class="form-control" placeholder="Ví dụ: kana_dev" required/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Mật khẩu <span class="text-danger">*</span></label>
                                    <div class="input-group has-icon">
                                        <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                        <input type="password" name="password" class="form-control" placeholder="••••••••" required/>
                                    </div>
                                </div>

                                <hr class="my-4 text-muted opacity-25">

                                <div class="col-md-12">
                                    <label class="form-label fw-semibold">Họ và tên</label>
                                    <input type="text" name="fullname" class="form-control" placeholder="Nguyễn Văn A"/>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Số điện thoại</label>
                                    <input type="tel" name="phone" class="form-control" placeholder="0123 456 789"/>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Email</label>
                                    <input type="email" name="email" class="form-control" placeholder="name@example.com"/>
                                </div>

                                <div class="col-md-8">
                                    <label class="form-label fw-semibold">Địa chỉ</label>
                                    <input type="text" name="address" class="form-control" placeholder="Số nhà, tên đường, Quận/Huyện..."/>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label fw-semibold">Vai trò (Role)</label>
                                    <select name="role" class="form-select">
                                        <option value="ADMIN">ADMIN</option>
                                        <option value="LANDLORD">LANDLORD</option>
                                        <option value="STUDENT" selected>STUDENT</option>
                                    </select>
                                </div>

                                <div class="col-12 text-center mt-5">
                                    <button type="submit" class="btn btn-primary fw-bold shadow-sm me-2">
                                        <i class="bi bi-check-lg me-1"></i> Xác nhận thêm
                                    </button>
                                    <a href="AccountController" class="btn btn-outline-secondary px-4">Hủy bỏ</a>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <div class="text-center mt-4 text-muted small">
                        &copy; 2026 Money Flow Project - PRJ301 Management System
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>