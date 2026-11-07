<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.util.ArrayList, java.text.DecimalFormat, model.*, dao.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tìm kiếm thông tin món ăn - RestMan</title>
    <%@ include file="../header.jsp" %>
</head>
<body>
<%
    Customer7 customer = (Customer7) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/LoginUI.jsp?err=timeout");
        return;
    }

    // Các thuộc tính ẩn theo đúng sơ đồ lớp thiết kế 3.3.2:
    // -listCategory : ArrayList<MenuItemCategory7>
    // -listResult : ArrayList<MenuItem7>
    @SuppressWarnings("unchecked")
    ArrayList<MenuItemCategory7> listCategory = (ArrayList<MenuItemCategory7>) request.getAttribute("listCategory");
    if (listCategory == null) {
        listCategory = (new MenuItemCategoryDAO()).getAllCategories();
    }

    @SuppressWarnings("unchecked")
    ArrayList<MenuItem7> listResult = (ArrayList<MenuItem7>) request.getAttribute("listResult");

    String inKeywordVal = (String) request.getAttribute("inKeyword");
    if (inKeywordVal == null) inKeywordVal = "";

    Integer selectedCatObj = (Integer) request.getAttribute("selectedCategory");
    int selectedCategory = (selectedCatObj != null) ? selectedCatObj : 0;

    DecimalFormat df = new DecimalFormat("#,###");
%>
    <nav class="navbar navbar-expand-lg navbar-dark restman-navbar py-3">
        <div class="container">
            <a class="navbar-brand fw-bold" href="<%=request.getContextPath()%>/customer/CustomerMainUI.jsp">
                <i class="fa-solid fa-utensils me-2"></i>RESTMAN
            </a>
            <div class="text-white small">
                Khách hàng: <strong><%=customer.getFullName()%></strong>
            </div>
        </div>
    </nav>

    <div class="container my-4">
        <div class="restman-card p-4 mb-4">
            <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-3">
                <div>
                    <h4 class="fw-bold mb-0"><i class="fa-solid fa-magnifying-glass text-danger me-2"></i>Tìm kiếm thông tin món ăn</h4>
                    <small class="text-muted">Nhập từ khóa tên món ăn hoặc lọc theo thể loại thực đơn</small>
                </div>
                <!-- Nút -btnBack : button -->
                <button type="button" id="btnBack" name="btnBack" class="btn btn-outline-secondary"
                        onclick="openPage('<%=request.getContextPath()%>/customer/CustomerMainUI.jsp')">
                    <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
                </button>
            </div>

            <form action="<%=request.getContextPath()%>/MenuItemServlet" method="get" class="row g-3 align-items-end">
                <input type="hidden" name="action" value="searchMenuItem" />

                <!-- Ô nhập từ khóa -inKeyword : text -->
                <div class="col-md-6">
                    <label for="inKeyword" class="form-label fw-semibold">Từ khóa tên món ăn / combo:</label>
                    <input type="text" id="inKeyword" name="inKeyword" class="form-control"
                           value="<%=inKeywordVal%>" placeholder="Ví dụ: Bò, Salad, Combo..." />
                </div>

                <!-- Dropdown chọn thể loại -inoutCategory : dropdown -->
                <div class="col-md-4">
                    <label for="inoutCategory" class="form-label fw-semibold">Thể loại thực đơn:</label>
                    <select id="inoutCategory" name="inoutCategory" class="form-select">
                        <option value="0" <%= (selectedCategory == 0) ? "selected" : "" %>>-- Tất cả --</option>
                        <%
                            for (MenuItemCategory7 cat : listCategory) {
                        %>
                            <option value="<%=cat.getId()%>" <%= (selectedCategory == cat.getId()) ? "selected" : "" %>>
                                <%=cat.getName()%>
                            </option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <!-- Nút -btnSearch : button -->
                <div class="col-md-2">
                    <button type="submit" id="btnSearch" name="btnSearch" class="btn btn-restman w-100">
                        <i class="fa-solid fa-search me-1"></i> Tìm kiếm
                    </button>
                </div>
            </form>
        </div>

        <!-- Khu vực hiển thị kết quả tìm kiếm: Bảng -tblMenuItem : Table -->
        <div class="restman-card p-4">
            <h5 class="fw-bold mb-3">Danh sách kết quả tìm kiếm</h5>
            <%
                if (listResult == null) {
            %>
                <div class="text-center text-muted py-4">
                    <i class="fa-solid fa-book-open fa-2x mb-2 d-block"></i>
                    Vui lòng nhập từ khóa tên món ăn và bấm <strong>"Tìm kiếm"</strong> để tra cứu thực đơn.
                </div>
            <%
                } else if (listResult.isEmpty()) {
            %>
                <!-- Ngoại lệ 4.1: Không tìm thấy kết quả phù hợp -->
                <div class="alert alert-warning text-center mb-0">
                    <i class="fa-solid fa-circle-info me-1"></i> Không tìm thấy kết quả phù hợp
                </div>
            <%
                } else {
            %>
                <div class="table-responsive">
                    <table id="tblMenuItem" class="table table-hover align-middle table-bordered table-restman mb-0">
                        <thead>
                            <tr class="text-center">
                                <th style="width: 60px;">TT</th>
                                <th style="width: 110px;">Mã món</th>
                                <th>Tên món ăn</th>
                                <th style="width: 120px;">Loại</th>
                                <th style="width: 140px;">Thể loại</th>
                                <th style="width: 150px;">Đơn giá (VNĐ)</th>
                                <th style="width: 110px;">Hình ảnh</th>
                                <th style="width: 110px;">Chi tiết</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            for (int i = 0; i < listResult.size(); i++) {
                                MenuItem7 item = listResult.get(i);
                                boolean isCombo = (item instanceof Combo7);
                        %>
                            <tr>
                                <td class="text-center fw-semibold"><%=(i + 1)%></td>
                                <td class="text-center"><code><%=item.getItemCode()%></code></td>
                                <td class="fw-semibold"><%=item.getName()%></td>
                                <td class="text-center">
                                    <% if (isCombo) { %>
                                        <span class="badge badge-combo">Combo</span>
                                    <% } else { %>
                                        <span class="badge badge-food">Món lẻ</span>
                                    <% } %>
                                </td>
                                <td class="text-center"><%=item.getCategory() != null ? item.getCategory().getName() : ""%></td>
                                <td class="text-end fw-bold text-danger"><%=df.format(item.getPrice())%></td>
                                <td class="text-center">
                                    <img src="<%=item.getImageUrl()%>" alt="<%=item.getName()%>" class="food-thumb" />
                                </td>
                                <td class="text-center">
                                    <% if (isCombo) { %>
                                        <a href="<%=request.getContextPath()%>/MenuItemServlet?action=viewComboDetail&comboId=<%=item.getId()%>"
                                           class="btn btn-sm btn-outline-danger fw-semibold">
                                            Xem
                                        </a>
                                    <% } else { %>
                                        <a href="<%=request.getContextPath()%>/MenuItemServlet?action=viewFoodDetail&foodId=<%=item.getId()%>"
                                           class="btn btn-sm btn-outline-primary fw-semibold">
                                            Xem
                                        </a>
                                    <% } %>
                                </td>
                            </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>