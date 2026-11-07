<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giao diện chính Quản lý - RestMan</title>
    <%@ include file="../header.jsp" %>
</head>
<body>
<%
    // Thuộc tính ẩn -manager : Manager7 theo đúng sơ đồ lớp thiết kế 3.4.2
    Manager7 manager = (Manager7) session.getAttribute("manager");
    if (manager == null) {
        response.sendRedirect(request.getContextPath() + "/LoginUI.jsp?err=timeout");
        return;
    }
%>
    <nav class="navbar navbar-expand-lg navbar-dark restman-navbar py-3">
        <div class="container">
            <a class="navbar-brand fw-bold" href="<%=request.getContextPath()%>/manager/ManagerMainUI.jsp">
                <i class="fa-solid fa-user-tie me-2"></i>RESTMAN - QUẢN TRỊ NHÀ HÀNG
            </a>
            <div class="d-flex align-items-center text-white">
                <span class="me-3">
                    <i class="fa-solid fa-id-badge me-1"></i>
                    Quản lý: <strong><%=manager.getFullName()%></strong> (<%=manager.getStaffCode()%>)
                </span>
                <a href="<%=request.getContextPath()%>/LoginServlet?action=logout" class="btn btn-outline-light btn-sm">
                    <i class="fa-solid fa-right-from-bracket me-1"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <div class="container my-5">
        <div class="restman-card p-4 p-md-5 text-center mx-auto" style="max-width: 720px;">
            <span class="badge bg-warning text-dark px-3 py-2 rounded-pill mb-3 fw-semibold">
                Phân hệ Nhân viên Quản lý
            </span>
            <h2 class="fw-bold mb-3">Bảng điều khiển Quản lý Thực đơn</h2>
            <p class="text-muted mb-4">
                Quản lý danh mục các gói thực đơn Combo và thiết lập gói Combo ưu đãi mới cho nhà hàng.
            </p>

            <!-- Liên kết -linkManageCombo : link theo đúng sơ đồ lớp thiết kế 3.4.2 -->
            <div class="d-flex justify-content-center">
                <a id="linkManageCombo" name="linkManageCombo"
                   href="<%=request.getContextPath()%>/ComboServlet?action=listCombos"
                   class="btn btn-restman btn-lg px-4 py-3 shadow-sm">
                    <i class="fa-solid fa-layer-group me-2"></i> Quản lý combo (Create Combo Menu)
                </a>
            </div>
        </div>
    </div>
</body>
</html>