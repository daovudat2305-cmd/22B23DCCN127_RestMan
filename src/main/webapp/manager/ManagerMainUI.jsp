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
    // Thuộc tính ẩn -manager : Manager7
    Manager7 manager = (Manager7) session.getAttribute("manager");
    if (manager == null) {
        response.sendRedirect(request.getContextPath() + "/LoginUI.jsp?err=timeout");
        return;
    }
%>
    <nav class="navbar navbar-expand-lg navbar-dark restman-navbar py-2">
        <div class="container">
            <a class="navbar-brand fw-bold" href="<%=request.getContextPath()%>/manager/ManagerMainUI.jsp">
                RESTMAN - QUẢN TRỊ NHÀ HÀNG
            </a>
            <div class="d-flex align-items-center text-white">
                <span class="me-3">
                    Quản lý: <strong><%=manager.getFullName()%></strong> (<%=manager.getStaffCode()%>)
                </span>
                <button type="button" id="btnLogout" name="btnLogout" class="btn btn-outline-light btn-sm"
                        onclick="openPage('<%=request.getContextPath()%>/LoginServlet?action=logout')">
                    Đăng xuất
                </button>
            </div>
        </div>
    </nav>

    <div class="container my-5">
        <div class="restman-card p-4 p-md-5 text-center mx-auto" style="max-width: 680px;">
            <!-- Thuộc tính ẩn manager -->
            <input type="hidden" id="managerId" name="managerId" value="<%=manager.getId()%>" />

            <span class="badge bg-light text-secondary border px-3 py-2 rounded-pill mb-3 fw-semibold">
                Phân hệ Nhân viên Quản lý
            </span>

            <!-- -linkManageCombo : link theo đúng sơ đồ lớp thiết kế 3.4.2 -->
            <div class="d-flex justify-content-center">
                <a id="linkManageCombo" name="linkManageCombo"
                   href="<%=request.getContextPath()%>/ComboServlet?action=listCombos"
                   class="btn btn-restman px-4 py-2">
                    Quản lý combo
                </a>
            </div>
        </div>
    </div>
</body>
</html>