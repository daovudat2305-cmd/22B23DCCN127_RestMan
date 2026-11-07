<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.util.ArrayList, java.text.DecimalFormat, model.*, dao.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Combo - RestMan</title>
    <%@ include file="../header.jsp" %>
</head>
<body>
<%
    Manager7 manager = (Manager7) session.getAttribute("manager");
    if (manager == null) {
        response.sendRedirect(request.getContextPath() + "/LoginUI.jsp?err=timeout");
        return;
    }

    // Thuộc tính ẩn -listCombo : ArrayList<Combo7> theo đúng sơ đồ lớp thiết kế 3.4.2
    @SuppressWarnings("unchecked")
    ArrayList<Combo7> listCombo = (ArrayList<Combo7>) request.getAttribute("listCombo");
    if (listCombo == null) {
        listCombo = (new ComboDAO()).getAllCombo();
    }

    String successMsg = (String) request.getAttribute("successMsg");
    DecimalFormat df = new DecimalFormat("#,###");
%>
    <nav class="navbar navbar-expand-lg navbar-dark restman-navbar py-3">
        <div class="container">
            <a class="navbar-brand fw-bold" href="<%=request.getContextPath()%>/manager/ManagerMainUI.jsp">
                <i class="fa-solid fa-user-tie me-2"></i>RESTMAN - QUẢN LÝ COMBO
            </a>
            <div class="text-white small">
                Quản lý: <strong><%=manager.getFullName()%></strong>
            </div>
        </div>
    </nav>

    <div class="container my-4">
        <% if (successMsg != null && !successMsg.isEmpty()) { %>
            <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                <i class="fa-solid fa-circle-check me-2"></i><strong><%=successMsg%>!</strong>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <script>
                alert("<%=successMsg%>");
            </script>
        <% } %>

        <div class="restman-card p-4">
            <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                <div>
                    <h4 class="fw-bold mb-0"><i class="fa-solid fa-list-check text-danger me-2"></i>Danh sách thực đơn Combo</h4>
                    <small class="text-muted">Các gói combo hiện có trên hệ thống thực đơn bán hàng</small>
                </div>
                <div class="d-flex gap-2">
                    <!-- Nút -btnAddCombo : button -->
                    <button type="button" id="btnAddCombo" name="btnAddCombo" class="btn btn-restman"
                            onclick="openPage('<%=request.getContextPath()%>/ComboServlet?action=showAddForm')">
                        <i class="fa-solid fa-plus me-1"></i> Thêm combo mới
                    </button>

                    <!-- Nút -btnBack : button -->
                    <button type="button" id="btnBack" name="btnBack" class="btn btn-outline-secondary"
                            onclick="openPage('<%=request.getContextPath()%>/manager/ManagerMainUI.jsp')">
                        <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
                    </button>
                </div>
            </div>

            <!-- Bảng -tblComboList : Table -->
            <div class="table-responsive">
                <table id="tblComboList" class="table table-bordered table-hover align-middle table-restman mb-0">
                    <thead>
                        <tr class="text-center">
                            <th style="width: 60px;">TT</th>
                            <th style="width: 110px;">Mã Combo</th>
                            <th style="width: 220px;">Tên Combo</th>
                            <th style="width: 150px;">Đơn giá (VNĐ)</th>
                            <th>Các món thành phần</th>
                            <th style="width: 220px;">Mô tả</th>
                            <th style="width: 100px;">Hình ảnh</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        if (listCombo != null && !listCombo.isEmpty()) {
                            for (int i = 0; i < listCombo.size(); i++) {
                                Combo7 cb = listCombo.get(i);
                    %>
                        <tr>
                            <td class="text-center fw-semibold"><%=(i + 1)%></td>
                            <td class="text-center"><code><%=cb.getItemCode()%></code></td>
                            <td class="fw-bold"><%=cb.getName()%></td>
                            <td class="text-end fw-bold text-danger"><%=df.format(cb.getPrice())%></td>
                            <td>
                                <ul class="mb-0 ps-3 small">
                                <%
                                    if (cb.getComboItems() != null) {
                                        for (ComboItem7 ci : cb.getComboItems()) {
                                %>
                                    <li><strong><%=ci.getFood().getName()%></strong> (x<%=ci.getQuantity()%> <%=ci.getFood().getUnit()%>)</li>
                                <%
                                        }
                                    }
                                %>
                                </ul>
                            </td>
                            <td class="small text-muted"><%=cb.getDescription()%></td>
                            <td class="text-center">
                                <img src="<%=cb.getImageUrl()%>" alt="<%=cb.getName()%>" class="food-thumb" />
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="7" class="text-center text-muted py-4">Chưa có gói Combo nào trong hệ thống.</td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>