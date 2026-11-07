<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.text.DecimalFormat, model.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thông tin chi tiết món ăn - RestMan</title>
    <%@ include file="../header.jsp" %>
</head>
<body>
<%
    Customer7 customer = (Customer7) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/LoginUI.jsp?err=timeout");
        return;
    }

    // Thuộc tính đối tượng -foodItem : Food7 theo đúng sơ đồ lớp thiết kế 3.3.2
    Food7 foodItem = (Food7) request.getAttribute("foodItem");
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
        <div class="restman-card p-4 p-md-5 mx-auto" style="max-width: 850px;">
            <h4 class="fw-bold border-bottom pb-3 mb-4">
                <i class="fa-solid fa-bowl-food text-danger me-2"></i>Thông tin chi tiết món ăn
            </h4>

            <% if (foodItem != null) { %>
                <div id="outFoodDetail" class="row g-4 align-items-center">
                    <div class="col-md-5 text-center">
                        <a href="<%=foodItem.getImageUrl()%>" target="_blank" title="Bấm vào để xem ảnh kích thước lớn">
                            <img src="<%=foodItem.getImageUrl()%>" alt="<%=foodItem.getName()%>"
                                 class="img-fluid rounded-3 shadow-sm" style="max-height: 280px; object-fit: cover; width: 100%;" />
                        </a>
                        <small class="text-muted d-block mt-2"><i class="fa-solid fa-magnifying-glass-plus me-1"></i>Bấm vào ảnh để xem kích thước lớn</small>
                    </div>
                    <div class="col-md-7">
                        <table class="table table-bordered mb-0">
                            <tbody>
                                <tr>
                                    <th class="bg-light" style="width: 38%;">Mã món ăn</th>
                                    <td><code><%=foodItem.getItemCode()%></code></td>
                                </tr>
                                <tr>
                                    <th class="bg-light">Tên món ăn</th>
                                    <td class="fw-bold fs-5"><%=foodItem.getName()%></td>
                                </tr>
                                <tr>
                                    <th class="bg-light">Thể loại món</th>
                                    <td><span class="badge bg-primary"><%=foodItem.getCategory() != null ? foodItem.getCategory().getName() : ""%></span></td>
                                </tr>
                                <tr>
                                    <th class="bg-light">Đơn giá niêm yết</th>
                                    <td class="fw-bold text-danger fs-5"><%=df.format(foodItem.getPrice())%> VNĐ</td>
                                </tr>
                                <tr>
                                    <th class="bg-light">Đơn vị tính</th>
                                    <td><%=foodItem.getUnit()%></td>
                                </tr>
                                <tr>
                                    <th class="bg-light">Mô tả chi tiết</th>
                                    <td><%=foodItem.getDescription()%></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            <% } else { %>
                <div class="alert alert-warning">Không tìm thấy thông tin món ăn!</div>
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