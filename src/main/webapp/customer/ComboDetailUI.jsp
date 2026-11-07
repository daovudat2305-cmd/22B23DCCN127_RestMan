<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.util.ArrayList, java.text.DecimalFormat, model.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thông tin chi tiết gói Combo - RestMan</title>
    <%@ include file="../header.jsp" %>
</head>
<body>
<%
    Customer7 customer = (Customer7) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/LoginUI.jsp?err=timeout");
        return;
    }

    // Thuộc tính đối tượng -comboItem : Combo7 theo đúng sơ đồ lớp thiết kế 3.3.2
    Combo7 comboItem = (Combo7) request.getAttribute("comboItem");
    DecimalFormat df = new DecimalFormat("#,###");
%>
    <nav class="navbar navbar-expand-lg navbar-dark restman-navbar py-3">
        <div class="container">
            <a class="navbar-brand fw-bold" href="<%=request.getContextPath()%>/customer/CustomerMainUI.jsp">
                <i class="fa-solid fa-utensils me-2"></i>RESTMAN
            </a>
        </div>
    </nav>

    <div class="container my-5">
        <div class="restman-card p-4 p-md-5 mx-auto" style="max-width: 900px;">
            <h4 class="fw-bold border-bottom pb-3 mb-4">
                <i class="fa-solid fa-layer-group text-danger me-2"></i>Thông tin chi tiết thực đơn Combo
            </h4>

            <% if (comboItem != null) { %>
                <div id="outComboDetail" class="row g-4 align-items-center mb-4">
                    <div class="col-md-5 text-center">
                        <a href="<%=comboItem.getImageUrl()%>" target="_blank">
                            <img src="<%=comboItem.getImageUrl()%>" alt="<%=comboItem.getName()%>"
                                 class="img-fluid rounded-3 shadow-sm" style="max-height: 260px; object-fit: cover; width: 100%;" />
                        </a>
                    </div>
                    <div class="col-md-7">
                        <table class="table table-bordered mb-0">
                            <tbody>
                                <tr>
                                    <th class="bg-light" style="width: 38%;">Mã Combo</th>
                                    <td><code><%=comboItem.getItemCode()%></code></td>
                                </tr>
                                <tr>
                                    <th class="bg-light">Tên gói Combo</th>
                                    <td class="fw-bold fs-5"><%=comboItem.getName()%></td>
                                </tr>
                                <tr>
                                    <th class="bg-light">Giá trọn gói ưu đãi</th>
                                    <td class="fw-bold text-danger fs-5"><%=df.format(comboItem.getPrice())%> VNĐ</td>
                                </tr>
                                <tr>
                                    <th class="bg-light">Mô tả chi tiết</th>
                                    <td><%=comboItem.getDescription()%></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Bảng danh sách món thành phần -tblComboItems : Table -->
                <h5 class="fw-bold mb-3">Danh sách các món ăn thành phần trong Combo</h5>
                <div class="table-responsive">
                    <table id="tblComboItems" class="table table-bordered table-hover align-middle table-restman">
                        <thead>
                            <tr class="text-center">
                                <th style="width: 60px;">TT</th>
                                <th style="width: 110px;">Mã món</th>
                                <th>Tên món ăn thành phần</th>
                                <th style="width: 140px;">Thể loại</th>
                                <th style="width: 110px;">Đơn vị tính</th>
                                <th style="width: 120px;">Số lượng suất</th>
                                <th style="width: 140px;">Đơn giá lẻ (VNĐ)</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            ArrayList<ComboItem7> items = comboItem.getComboItems();
                            if (items != null) {
                                for (int i = 0; i < items.size(); i++) {
                                    ComboItem7 ci = items.get(i);
                                    Food7 f = ci.getFood();
                        %>
                            <tr>
                                <td class="text-center"><%=(i + 1)%></td>
                                <td class="text-center"><code><%=f.getItemCode()%></code></td>
                                <td class="fw-semibold"><%=f.getName()%></td>
                                <td class="text-center"><%=f.getCategory() != null ? f.getCategory().getName() : ""%></td>
                                <td class="text-center"><%=f.getUnit()%></td>
                                <td class="text-center fw-bold"><%=ci.getQuantity()%></td>
                                <td class="text-end"><%=df.format(f.getPrice())%></td>
                            </tr>
                        <%
                                }
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            <% } else { %>
                <div class="alert alert-warning">Không tìm thấy thông tin gói Combo!</div>
            <% } %>

            <div class="mt-4 pt-3 border-top text-end">
                <!-- Nút -btnBack : button -->
                <button type="button" id="btnBack" name="btnBack" class="btn btn-secondary px-4"
                        onclick="history.back()">
                    <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
                </button>
            </div>
        </div>
    </div>
</body>
</html>