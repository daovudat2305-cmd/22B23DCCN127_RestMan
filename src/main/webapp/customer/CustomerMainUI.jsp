<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giao diện chính Khách hàng - RestMan</title>
    <%@ include file="../header.jsp" %>
</head>
<body>
<%
    // Thuộc tính ẩn -customer : Customer7
    Customer7 customer = (Customer7) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/LoginUI.jsp?err=timeout");
        return;
    }
%>
    <nav class="navbar navbar-expand-lg navbar-dark restman-navbar py-3">
        <div class="container">
            <a class="navbar-brand fw-bold" href="<%=request.getContextPath()%>/customer/CustomerMainUI.jsp">
                RESTMAN - KHÁCH HÀNG TRỰC TUYẾN
            </a>
            <div class="d-flex align-items-center text-white">
                <span class="me-3">
                    Xin chào, <strong><%=customer.getFullName()%></strong> (<%=customer.getCustomerCode()%>)
                </span>
                <a href="<%=request.getContextPath()%>/LoginServlet?action=logout" class="btn btn-outline-light btn-sm">
                    Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <div class="container my-5">
        <div class="restman-card p-4 p-md-5 text-center mx-auto" style="max-width: 720px;">
            <!-- Thuộc tính ẩn customer -->
            <input type="hidden" id="customerId" name="customerId" value="<%=customer.getId()%>" />

            <span class="badge bg-danger bg-opacity-10 text-danger px-3 py-2 rounded-pill mb-3 fw-semibold">
                Cổng Dịch Vụ Khách Hàng Trực Tuyến
            </span>
            <h2 class="fw-bold mb-3">Chào mừng quý khách đến với Nhà hàng RestMan</h2>
            <p class="text-muted mb-4">
                Tra cứu thực đơn món ăn đơn lẻ và các gói Combo ưu đãi đặc biệt của nhà hàng.
            </p>

            <!-- Liên kết -linkSearchMenuItem : link theo đúng sơ đồ lớp thiết kế -->
            <div class="d-flex justify-content-center gap-3">
                <a id="linkSearchMenuItem" name="linkSearchMenuItem"
                   href="<%=request.getContextPath()%>/MenuItemServlet?action=showSearchForm"
                   class="btn btn-restman btn-lg px-4 py-3">
                    Tìm kiếm món ăn
                </a>
            </div>
        </div>
    </div>
</body>
</html>