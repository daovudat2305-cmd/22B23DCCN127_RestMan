<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.util.ArrayList, java.text.DecimalFormat, model.*"%>
<%!
    /**
     * Hàm tính tổng giá gốc từ danh sách món ăn thành phần trong Combo.
     */
    public float calculateTotalOriginalPrice(ArrayList<ComboItem7> items) {
        if (items == null || items.isEmpty()) {
            return 0f;
        }
        float total = 0f;
        for (ComboItem7 ci : items) {
            if (ci != null && ci.getFood() != null) {
                total += ci.getFood().getPrice() * ci.getQuantity();
            }
        }
        return total;
    }
%>
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
%>
    <nav class="navbar navbar-expand-lg navbar-dark restman-navbar py-3">
        <div class="container">
            <a class="navbar-brand fw-bold" href="<%=request.getContextPath()%>/customer/CustomerMainUI.jsp">
                RESTMAN
            </a>
            <div class="text-white small">
                Khách hàng: <strong><%=customer.getFullName()%></strong>
            </div>
        </div>
    </nav>

    <div class="container my-5">
        <!-- Thuộc tính ẩn customer -->
        <input type="hidden" id="customerId" name="customerId" value="<%=customer.getId()%>" />

        <div class="restman-card p-4 p-md-5 mx-auto" style="max-width: 900px;">
            <h4 class="fw-bold border-bottom pb-3 mb-4">
                Thông tin chi tiết thực đơn Combo
            </h4>

            <% if (comboItem != null) { %>
                <input type="hidden" id="comboId" name="comboId" value="<%=comboItem.getId()%>" />
                <div id="outComboDetail" class="row g-4 align-items-center mb-4">
                    <div class="col-md-5 text-center">
                        <%
                            String comboImg = comboItem.getImageUrl();
                            if (comboImg == null || comboImg.trim().isEmpty()) {
                                comboImg = request.getContextPath() + "/uploads/default-food.jpg";
                            } else if (!comboImg.startsWith("http://") && !comboImg.startsWith("https://")) {
                                if (!comboImg.startsWith(request.getContextPath())) {
                                    comboImg = request.getContextPath() + (comboImg.startsWith("/") ? "" : "/") + comboImg;
                                }
                            }
                        %>
                        <a href="<%=comboImg%>" target="_blank" title="Bấm vào để xem ảnh kích thước lớn">
                            <img id="comboImage" src="<%=comboImg%>" alt="<%=comboItem.getName()%>"
                                 class="img-fluid rounded-3" style="max-height: 260px; object-fit: cover; width: 100%;"
                                 onerror="this.onerror=null; this.src='<%=request.getContextPath()%>/uploads/default-food.jpg';" />
                        </a>
                        <small class="text-muted d-block mt-2">Bấm vào ảnh để xem kích thước lớn</small>
                    </div>
                    <div class="col-md-7">
                        <table class="table table-bordered mb-0">
                            <tbody>
                                <tr>
                                    <th class="bg-light" style="width: 38%;">Mã Combo</th>
                                    <td id="comboCode"><code><%=comboItem.getItemCode()%></code></td>
                                </tr>
                                <tr>
                                    <th class="bg-light">Tên gói Combo</th>
                                    <td id="comboName" class="fw-bold fs-5"><%=comboItem.getName()%></td>
                                </tr>
                                <tr>
                                    <th class="bg-light">Giá trọn gói ưu đãi</th>
                                    <td id="comboPrice" class="fw-bold text-danger fs-5"><%=new DecimalFormat("#,###").format(comboItem.getPrice())%> VNĐ</td>
                                </tr>
                                <tr>
                                    <th class="bg-light">Mô tả chi tiết</th>
                                    <td id="comboDescription"><%=comboItem.getDescription()%></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Bảng danh sách món thành phần -tblComboItems : Table -->
                <h5 class="fw-bold mb-3">Danh sách các món ăn thành phần trong Combo</h5>
                <div class="table-responsive">
                    <table id="tblComboItems" name="tblComboItems" class="table table-bordered align-middle table-restman">
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
                                <td class="text-end"><%=new DecimalFormat("#,###").format(f.getPrice())%></td>
                            </tr>
                        <%
                                }
                            }
                        %>
                        </tbody>
                    </table>
                </div>

                <%
                    float totalOriginalPrice = calculateTotalOriginalPrice(items);
                %>
                <!-- Dòng hiển thị tổng giá gốc bên dưới bảng (nằm sát cạnh nhau, căn lề phải) -->
                <div class="text-end bg-light p-3 rounded border mt-3">
                    <span class="fw-bold">Tổng giá gốc:</span>
                    <span id="totalOriginalPrice" name="totalOriginalPrice" class="fw-bold text-danger fs-5 ms-2">
                        <%=new DecimalFormat("#,###").format(totalOriginalPrice)%> VNĐ
                    </span>
                </div>
            <% } else { %>
                <div class="alert alert-warning">Không tìm thấy thông tin gói Combo!</div>
            <% } %>

            <div class="mt-4 pt-3 border-top text-end">
                <!-- Nút -btnBack : button -->
                <button type="button" id="btnBack" name="btnBack" class="btn btn-secondary px-4"
                        onclick="history.back()">
                    Quay lại
                </button>
            </div>
        </div>
    </div>
</body>
</html>