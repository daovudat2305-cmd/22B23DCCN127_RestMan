<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.util.ArrayList, java.text.DecimalFormat, java.math.BigDecimal, model.*, dao.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Combo mới - RestMan</title>
    <%@ include file="../header.jsp" %>
</head>
<body>
<%
	// 4 Thuộc tính ẩn
	// -manager: Manager7
    // -listFoodCategories : ArrayList<MenuItemCategory7>
    // -listSearchedFood : ArrayList<Food7>
    // -listComboItems : ArrayList<ComboItem7>
    Manager7 manager = (Manager7) session.getAttribute("manager");
    if (manager == null) {
        response.sendRedirect(request.getContextPath() + "/LoginUI.jsp?err=timeout");
        return;
    }

    @SuppressWarnings("unchecked")
    ArrayList<MenuItemCategory7> listFoodCategories = (ArrayList<MenuItemCategory7>) request.getAttribute("listFoodCategories");
    if (listFoodCategories == null) {
        listFoodCategories = (ArrayList<MenuItemCategory7>) session.getAttribute("listFoodCategories");
    }
    if (listFoodCategories == null) {
        listFoodCategories = (new MenuItemCategoryDAO()).getAllFoodCategories();
    }

    @SuppressWarnings("unchecked")
    ArrayList<Food7> listSearchedFood = (ArrayList<Food7>) request.getAttribute("listSearchedFood");
    if (listSearchedFood == null) {
        listSearchedFood = (ArrayList<Food7>) session.getAttribute("listSearchedFood");
    }

    @SuppressWarnings("unchecked")
    ArrayList<ComboItem7> listComboItems = (ArrayList<ComboItem7>) request.getAttribute("listComboItems");
    if (listComboItems == null) {
        listComboItems = (ArrayList<ComboItem7>) session.getAttribute("listComboItems");
    }
    if (listComboItems == null) {
        listComboItems = new ArrayList<>();
    }
%>
    <nav class="navbar navbar-expand-lg navbar-dark restman-navbar py-2">
        <div class="container">
            <a class="navbar-brand fw-bold" href="<%=request.getContextPath()%>/manager/ManagerMainUI.jsp">
                RESTMAN - LÊN MENU COMBO
            </a>
            <div class="text-white small">
                Quản lý: <strong><%=manager.getFullName()%></strong>
            </div>
        </div>
    </nav>

    <div class="container my-4">
        <!-- Thuộc tính ẩn manager -->
        <input type="hidden" id="managerId" name="managerId" value="<%=manager.getId()%>" />

        <% if (request.getAttribute("errorMsg") != null && !((String) request.getAttribute("errorMsg")).isEmpty()) { %>
            <div class="alert alert-danger">
                ${errorMsg}
            </div>
        <% } %>

        <div class="row g-4">
            <!-- CỘT TRÁI: TÌM KIẾM MÓN ĂN ĐƯA VÀO COMBO -->
            <div class="col-lg-6">
                <div class="restman-card p-4 h-100">
                    <h5 class="fw-bold border-bottom pb-2 mb-3">
                        1. Tìm kiếm món ăn đưa vào Combo
                    </h5>

                    <form id="searchFoodForm" action="<%=request.getContextPath()%>/ComboServlet" method="get" class="row g-2 align-items-end mb-3">
                        <input type="hidden" id="searchFoodAction" name="action" value="searchFood" />
                        <input type="hidden" name="inComboName" value="${draftComboName}" />
                        <input type="hidden" name="inComboPrice" value="${draftComboPrice}" />
                        <input type="hidden" name="inComboImage" value="${draftComboImage}" />
                        <input type="hidden" name="inComboDescription" value="${draftComboDescription}" />

                        <!-- Ô từ khóa tên món -inFoodKeyword : text -->
                        <div class="col-md-5">
                            <label for="inFoodKeyword" class="form-label small fw-semibold">Tên món ăn:</label>
                            <input type="text" id="inFoodKeyword" name="inFoodKeyword" class="form-control form-control-sm"
                                   value="${inFoodKeyword}" placeholder="Nhập tên món..." />
                        </div>

                        <!-- Dropdown chọn thể loại -inFoodCategory : dropdown -->
                        <div class="col-md-4">
                            <label for="inFoodCategory" class="form-label small fw-semibold">Thể loại:</label>
                            <select id="inFoodCategory" name="inFoodCategory" class="form-select form-select-sm">
                                <option value="0" ${empty selectedFoodCategory || selectedFoodCategory == 0 ? "selected" : ""}>-- Tất cả --</option>
                                <% 
                                    Integer selCat = (Integer) request.getAttribute("selectedFoodCategory");
                                    for (MenuItemCategory7 cat : listFoodCategories) { 
                                %>
                                    <option value="<%=cat.getId()%>" <%= (selCat != null && selCat == cat.getId()) ? "selected" : "" %>>
                                        <%=cat.getName()%>
                                    </option>
                                <% } %>
                            </select>
                        </div>

                        <!-- Nút tìm kiếm món -btnSearchFood : button -->
                        <div class="col-md-3">
                            <button type="submit" id="btnSearchFood" name="btnSearchFood" class="btn btn-restman btn-sm w-100"
                                    onclick="syncDraftToForm('searchFoodForm')">
                                Tìm món
                            </button>
                        </div>
                    </form>

                    <!-- Bảng danh sách món ăn tìm được -tblSearchedFood : Table -->
                    <div class="table-responsive">
                        <table id="tblSearchedFood" name="tblSearchedFood" class="table table-bordered align-middle table-restman small mb-0">
                            <thead>
                                <tr class="text-center">
                                    <th>TT</th>
                                    <th>Mã món</th>
                                    <th>Tên món ăn</th>
                                    <th>Thể loại</th>
                                    <th>Đơn giá lẻ</th>
                                    <th style="width: 155px;">Số lượng & Chọn</th>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                if (listSearchedFood == null) {
                            %>
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-3">
                                        Chọn thể loại hoặc nhập tên món và bấm <strong>"Tìm món"</strong>.
                                    </td>
                                </tr>
                            <%
                                } else if (listSearchedFood.isEmpty()) {
                            %>
                                <tr>
                                    <td colspan="6" class="text-center text-danger py-3">
                                        Không tìm thấy món ăn phù hợp
                                    </td>
                                </tr>
                            <%
                                } else {
                                    for (int i = 0; i < listSearchedFood.size(); i++) {
                                        Food7 f = listSearchedFood.get(i);
                            %>
                                <tr>
                                    <td class="text-center"><%=(i + 1)%></td>
                                    <td class="text-center"><code><%=f.getItemCode()%></code></td>
                                    <td class="fw-semibold"><%=f.getName()%></td>
                                    <td class="text-center"><%=f.getMenuItemCategory() != null ? f.getMenuItemCategory().getName() : ""%></td>
                                    <td class="text-end fw-semibold"><%=new DecimalFormat("#,###").format(f.getPrice())%></td>
                                    <td>
                                        <form id="selectForm_<%=f.getId()%>" action="<%=request.getContextPath()%>/ComboServlet" method="post" class="d-flex gap-1">
                                            <input type="hidden" name="action" value="addFoodToCombo" />
                                            <input type="hidden" name="foodId" value="<%=f.getId()%>" />
                                            <input type="hidden" name="inComboName" value="" />
                                            <input type="hidden" name="inComboPrice" value="" />
                                            <input type="hidden" name="inComboImage" value="" />
                                            <input type="hidden" name="inComboDescription" value="" />

                                            <!-- Ô nhập số lượng suất -inQuantity : text -->
                                            <input type="number" id="inQuantity_<%=f.getId()%>" name="inQuantity" value="1" min="1" max="50"
                                                   class="form-control form-control-sm text-center" style="width: 58px;" required />

                                            <!-- Nút chọn món -btnSelectFood : button -->
                                            <button type="submit" id="btnSelectFood_<%=f.getId()%>" name="btnSelectFood"
                                                    class="btn btn-sm btn-outline-success fw-semibold"
                                                    onclick="syncDraftToForm('selectForm_<%=f.getId()%>')">
                                                Chọn
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            <%
                                    }
                                }
                            %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- CỘT PHẢI: CÁC MÓN TRONG COMBO & THÔNG TIN CHUNG COMBO -->
            <div class="col-lg-6">
                <div class="restman-card p-4 h-100">
                    <h5 class="fw-bold border-bottom pb-2 mb-3">
                        2. Các món trong Combo
                    </h5>

                    <!-- Bảng các món trong combo -tblComboItems : Table -->
                    <div class="table-responsive mb-3">
                        <table id="tblComboItems" name="tblComboItems" class="table table-bordered align-middle table-restman small mb-0">
                            <thead>
                                <tr class="text-center">
                                    <th>TT</th>
                                    <th>Mã món</th>
                                    <th>Tên món ăn</th>
                                    <th>Thể loại</th>
                                    <th>Số lượng</th>
                                    <th>Đơn giá lẻ</th>
                                    <th>Thành tiền lẻ</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                if (listComboItems.isEmpty()) {
                            %>
                                <tr>
                                    <td colspan="8" class="text-center text-muted py-3">
                                        Danh sách món ăn trong combo đang rỗng.
                                    </td>
                                </tr>
                            <%
                                } else {
                                    for (int i = 0; i < listComboItems.size(); i++) {
                                        ComboItem7 ci = listComboItems.get(i);
                                        Food7 f = ci.getFood();
                                        BigDecimal subTotal = (f.getPrice() != null) ? f.getPrice().multiply(BigDecimal.valueOf(ci.getQuantity())) : BigDecimal.ZERO;
                            %>
                                <tr>
                                    <td class="text-center"><%=(i + 1)%></td>
                                    <td class="text-center"><code><%=f.getItemCode()%></code></td>
                                    <td class="fw-semibold"><%=f.getName()%></td>
                                    <td class="text-center"><%=f.getMenuItemCategory() != null ? f.getMenuItemCategory().getName() : ""%></td>
                                    <td class="text-center fw-bold"><%=ci.getQuantity()%></td>
                                    <td class="text-end"><%=new DecimalFormat("#,###").format(f.getPrice())%></td>
                                    <td class="text-end fw-bold"><%=new DecimalFormat("#,###").format(subTotal)%></td>
                                    <td class="text-center">
                                        <form id="removeForm_<%=f.getId()%>" action="<%=request.getContextPath()%>/ComboServlet" method="post" class="d-inline">
                                            <input type="hidden" name="action" value="removeFoodFromCombo" />
                                            <input type="hidden" name="foodId" value="<%=f.getId()%>" />
                                            <input type="hidden" name="inComboName" value="" />
                                            <input type="hidden" name="inComboPrice" value="" />
                                            <input type="hidden" name="inComboImage" value="" />
                                            <input type="hidden" name="inComboDescription" value="" />
                                            <!-- Nút xóa món khỏi combo -btnRemoveFood : button -->
                                            <button type="submit" id="btnRemoveFood_<%=f.getId()%>" name="btnRemoveFood"
                                                    class="btn btn-sm btn-outline-danger"
                                                    onclick="syncDraftToForm('removeForm_<%=f.getId()%>')">
                                                Xóa
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            <%
                                    }
                                }
                            %>
                            </tbody>
                        </table>
                    </div>

                    <!-- Dòng tổng tiền gốc tạm tính -totalOriginalPrice : text -->
                    <div class="d-flex justify-content-between align-items-center bg-light p-2 rounded border mb-4">
                        <span class="fw-semibold">Tổng tiền giá lẻ gốc tạm tính:</span>
                        <%
                            BigDecimal totalOrig = (BigDecimal) request.getAttribute("totalOriginalPrice");
                            if (totalOrig == null) {
                                totalOrig = (BigDecimal) session.getAttribute("totalOriginalPrice");
                            }
                            BigDecimal totalOriginalPrice = (totalOrig != null) ? totalOrig : BigDecimal.ZERO;
                        %>
                        <input type="text" id="totalOriginalPrice" name="totalOriginalPrice"
                                class="form-control form-control-sm text-end fw-bold text-danger border-0 bg-transparent"
                                style="width: 180px; font-size: 1rem;"
                                value="<%=new DecimalFormat("#,###").format(totalOriginalPrice)%> VNĐ" readonly />
                    </div>

                    <h5 class="fw-bold border-bottom pb-2 mb-3">
                        3. Thông tin chung của Combo
                    </h5>

                    <!-- Form lưu Combo có enctype="multipart/form-data" để gửi file ảnh -->
                    <form id="saveComboForm" action="<%=request.getContextPath()%>/ComboServlet" method="post" enctype="multipart/form-data">
                        <input type="hidden" id="saveComboAction" name="action" value="saveCombo" />
                        <input type="hidden" id="savedDraftImage" value="${draftComboImage}" />

                        <div class="row g-3">
                            <!-- Ô nhập tên combo -inComboName : text -->
                            <div class="col-md-7">
                                <label for="inComboName" class="form-label small fw-semibold">Tên Combo <span class="text-danger">*</span></label>
                                <input type="text" id="inComboName" name="inComboName" class="form-control form-control-sm"
                                       value="${draftComboName}" placeholder="Ví dụ: Combo bữa tối" required />
                            </div>

                            <!-- Ô nhập đơn giá combo -inComboPrice : text -->
                            <div class="col-md-5">
                                <label for="inComboPrice" class="form-label small fw-semibold">Đơn giá Combo (VNĐ) <span class="text-danger">*</span></label>
                                <input type="number" id="inComboPrice" name="inComboPrice" class="form-control form-control-sm"
                                       value="${draftComboPrice}" placeholder="Ví dụ: 349000" min="1000" required />
                            </div>

                            <!-- Ô chọn file hình ảnh minh họa -inComboImage : select (file) -->
                            <div class="col-12">
                                <label for="inComboImage" class="form-label small fw-semibold">
                                    Hình ảnh minh họa (Tải ảnh từ máy tính)
                                </label>
                                <input type="file" id="inComboImage" name="inComboImage"
                                       class="form-control form-control-sm" accept="image/*"
                                       onchange="handleFileSelect(this)" />
                                <div id="imagePreviewContainer" class="mt-2 ${empty draftComboImage ? 'd-none' : ''}">
                                    <span class="small text-muted d-block mb-1">Ảnh minh họa đã chọn:</span>
                                    <img id="comboImagePreview" src="${draftComboImage}" alt="Preview"
                                         class="rounded border" style="max-height: 110px; object-fit: cover;"
                                         onerror="this.onerror=null; this.src='<%=request.getContextPath()%>/uploads/default-food.jpg';" />
                                </div>
                            </div>

                            <!-- Ô nhập mô tả -inComboDescription : text -->
                            <div class="col-12">
                                <label for="inComboDescription" class="form-label small fw-semibold">Mô tả Combo</label>
                                <textarea id="inComboDescription" name="inComboDescription" rows="2"
                                          class="form-control form-control-sm"
                                          placeholder="Ví dụ: Combo siêu tiết kiệm">${draftComboDescription}</textarea>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end gap-2 mt-4 pt-3 border-top">
                            <!-- Nút hủy bỏ -btnCancel : button -->
                            <button type="button" id="btnCancel" name="btnCancel" class="btn btn-outline-secondary"
                                    onclick="openPage('<%=request.getContextPath()%>/ComboServlet?action=listCombos')">
                                Hủy bỏ
                            </button>

                            <!-- Nút xác nhận lưu combo -btnConfirmSave : button (chỉ active khi có >= 1 món) -->
                            <button type="submit" id="btnConfirmSave" name="btnConfirmSave"
                                    class="btn btn-restman px-4"
                                    <%= listComboItems.isEmpty() ? "disabled" : "" %>>
                                Xác nhận lưu combo
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        // Hiển thị ảnh xem trước và lưu tạm lên server ngay khi người dùng chọn file
        function handleFileSelect(fileInput) {
            if (!fileInput.files || !fileInput.files[0]) return;
            var file = fileInput.files[0];

            // 1. Hiển thị preview ngay lập tức
            var reader = new FileReader();
            reader.onload = function(e) {
                var previewImg = document.getElementById("comboImagePreview");
                var container = document.getElementById("imagePreviewContainer");
                previewImg.src = e.target.result;
                container.classList.remove("d-none");
            };
            reader.readAsDataURL(file);

            // 2. Tải ngầm lên ComboServlet để giữ lại ảnh nếu người dùng bấm Tìm món / Chọn món
            var formData = new FormData();
            formData.append("action", "uploadDraftImage");
            formData.append("inComboImage", file);

            fetch("<%=request.getContextPath()%>/ComboServlet", {
                method: "POST",
                body: formData
            })
            .then(function(res) { return res.ok ? res.text() : ""; })
            .then(function(uploadedPath) {
                if (uploadedPath) {
                    document.getElementById("savedDraftImage").value = uploadedPath;
                }
            })
            .catch(function(err) { console.error(err); });
        }

        function syncDraftToForm(formId) {
            var form = document.getElementById(formId);
            if (!form) return;
            var nameEl = document.getElementById("inComboName");
            var priceEl = document.getElementById("inComboPrice");
            var savedImgEl = document.getElementById("savedDraftImage");
            var descEl = document.getElementById("inComboDescription");

            if (form.elements["inComboName"] && nameEl) form.elements["inComboName"].value = nameEl.value;
            if (form.elements["inComboPrice"] && priceEl) form.elements["inComboPrice"].value = priceEl.value;
            if (form.elements["inComboImage"] && savedImgEl) form.elements["inComboImage"].value = savedImgEl.value;
            if (form.elements["inComboDescription"] && descEl) form.elements["inComboDescription"].value = descEl.value;
        }
    </script>
</body>
</html>