<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - Hệ thống nhà hàng RestMan</title>
    <%@ include file="header.jsp" %>
</head>
<body class="d-flex align-items-center justify-content-center" style="min-height: 100vh;">
    <div class="container" style="max-width: 440px;">
        <div class="restman-card p-4 p-md-5">
            <div class="text-center mb-4">
                <h3 class="fw-bold mb-1">RESTMAN</h3>
                <p class="text-muted small mb-0">Hệ thống Quản lý Nhà hàng (Đề 22)</p>
            </div>

            <%
                String err = request.getParameter("err");
                if ("timeout".equalsIgnoreCase(err)) {
            %>
                <div class="alert alert-warning py-2 small">
                    Hết phiên làm việc. Vui lòng đăng nhập lại!
                </div>
            <%
                } else if ("fail".equalsIgnoreCase(err)) {
            %>
                <div class="alert alert-danger py-2 small">
                    Sai tên đăng nhập hoặc mật khẩu!
                </div>
            <%
                }
            %>

            <form name="dangnhap" action="<%=request.getContextPath()%>/LoginServlet" method="post">
                <div class="mb-3">
                    <label for="username" class="form-label fw-semibold">Tên đăng nhập</label>
                    <input type="text" name="username" id="username" class="form-control" placeholder="Nhập username..." required />
                </div>
                <div class="mb-4">
                    <label for="password" class="form-label fw-semibold">Mật khẩu</label>
                    <input type="password" name="password" id="password" class="form-control" placeholder="Nhập mật khẩu..." required />
                </div>
                <button type="submit" id="btnLogin" name="btnLogin" class="btn btn-restman w-100 py-2">
                    Đăng nhập
                </button>
            </form>
        </div>
    </div>
</body>
</html>