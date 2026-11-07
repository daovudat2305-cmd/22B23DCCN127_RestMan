# BÁO CÁO BÀI TẬP LỚN
### HỌC VIỆN CÔNG NGHỆ BƯU CHÍNH VIỄN THÔNG
**Khoa Công nghệ Thông tin 1**

---

## THÔNG TIN CHUNG

* **Môn học:** Phân tích và thiết kế hệ thống thông tin
* **Nhóm môn học:** 09
* **Giảng viên hướng dẫn:** TS. Đỗ Thị Bích Ngọc
* **Sinh viên thực hiện:** Đào Vũ Đạt
* **Mã sinh viên:** B23DCCN127
* **Năm thực hiện:** 2026

---

## ĐỀ BÀI (ĐỀ SỐ 22)
### **Đề tài: Hệ thống quản lý nhà hàng RestMan**

Hệ thống quản lý nhà hàng (**RestMan**) cho phép nhân viên quản lý, nhân viên bán hàng và khách hàng sử dụng. Bài tập lớn tập trung phân tích, thiết kế và hiện thực hóa 2 module nghiệp vụ chính:

* **Module 1: Tìm kiếm thông tin món ăn (Khách hàng)**
  * Khách hàng truy cập chức năng tìm kiếm thông tin thực đơn.
  * Nhập từ khóa tên món ăn hoặc chọn lọc theo thể loại (Khai vị, Món chính, Đồ uống, Tráng miệng, Combo...).
  * Hệ thống hiển thị danh sách món ăn/combo thỏa mãn điều kiện.
  * Khách hàng bấm xem chi tiết:
    * *Nếu là món ăn lẻ:* Hiển thị tên món, đơn giá niêm yết, đơn vị tính, hình ảnh và mô tả chi tiết.
    * *Nếu là combo:* Hiển thị tên combo, giá ưu đãi trọn gói, hình ảnh, mô tả và bảng danh sách các món ăn thành phần bên trong kèm số lượng suất.

* **Module 2: Lên menu combo (Nhân viên quản lý)**
  * Nhân viên quản lý đăng nhập hệ thống, chọn chức năng **Quản lý combo** $\rightarrow$ **Thêm combo mới**.
  * Lặp chọn món vào combo:
    * Tìm kiếm món ăn lẻ theo từ khóa hoặc thể loại.
    * Chọn món từ kết quả tìm kiếm và nhập số lượng suất cho vào combo.
    * Hệ thống tự động cập nhật bảng món thành phần và tính tổng giá gốc tạm tính.
  * Quản lý nhập thông tin chung của combo: Tên combo, giá combo ưu đãi, tải ảnh minh họa, nhập mô tả.
  * Bấm **Xác nhận lưu combo** $\rightarrow$ Hệ thống thực thi giao dịch (Database Transaction ACID) lưu thông tin vào cơ sở dữ liệu và thông báo thành công.

---

## CẤU TRÚC THƯ MỤC DỰ ÁN

```text
RestMan/
├── src/main/java/
│   ├── dao/                         # Tầng truy xuất dữ liệu (Data Access Object)
│   │   ├── DAO.java                 # Kết nối CSDL MySQL (JDBC Connection)
│   │   ├── MemberDAO.java           # Xác thực đăng nhập & lấy thông tin thành viên
│   │   ├── MenuItemCategoryDAO.java # Lấy danh mục thể loại món ăn
│   │   ├── MenuItemDAO.java         # Tìm kiếm thực đơn (món lẻ & combo)
│   │   ├── FoodDAO.java             # Tìm kiếm & lấy chi tiết món ăn đơn lẻ
│   │   └── ComboDAO.java            # Lấy danh sách combo & lưu combo mới (Transaction)
│   ├── model/                       # Tầng thực thể dữ liệu (JavaBeans)
│   │   ├── Member7.java             # Lớp cơ sở thành viên
│   │   ├── Customer7.java           # Khách hàng (kế thừa Member7)
│   │   ├── Staff7.java              # Nhân viên (kế thừa Member7)
│   │   ├── Manager7.java            # Quản lý (kế thừa Staff7)
│   │   ├── MenuItemCategory7.java   # Thể loại thực đơn
│   │   ├── MenuItem7.java           # Mục thực đơn chung
│   │   ├── Food7.java               # Món ăn lẻ (kế thừa MenuItem7)
│   │   ├── Combo7.java              # Gói combo (kế thừa MenuItem7)
│   │   └── ComboItem7.java          # Món thành phần trong combo
│   └── servlet/                     # Tầng điều khiển (Controller)
│       ├── LoginServlet.java        # Xử lý đăng nhập / đăng xuất & phân quyền
│       ├── MenuItemServlet.java     # Điều phối tìm kiếm & xem chi tiết món/combo
│       └── ComboServlet.java        # Điều phối quản lý & tạo mới combo thực đơn
├── src/main/webapp/                 # Tầng giao diện người dùng (View - JSP)
│   ├── header.jsp                   # Header & nạp thư viện Bootstrap 5, Font Awesome
│   ├── LoginUI.jsp                  # Giao diện đăng nhập hệ thống
│   ├── customer/                    # Phân hệ Khách hàng (Module 1)
│   │   ├── CustomerMainUI.jsp       # Màn hình chính của khách hàng
│   │   ├── SearchMenuItemUI.jsp     # Giao diện tìm kiếm món ăn / combo
│   │   ├── FoodDetailUI.jsp         # Giao diện xem chi tiết món ăn lẻ
│   │   └── ComboDetailUI.jsp        # Giao diện xem chi tiết gói combo
│   ├── manager/                     # Phân hệ Quản lý (Module 2)
│   │   ├── ManagerMainUI.jsp        # Màn hình chính của nhân viên quản lý
│   │   ├── ComboManagementUI.jsp    # Giao diện danh sách quản lý các combo
│   │   └── AddComboUI.jsp           # Giao diện lên menu combo mới
│   └── WEB-INF/
│       ├── web.xml                  # Cấu hình Web Application
│       └── lib/
│           └── mysql-connector-j-9.4.0.jar # Driver kết nối CSDL MySQL
├── database/
│   └── restman.sql                  # Script tạo CSDL và dữ liệu khởi tạo mẫu
└── README.md                        # Tài liệu hướng dẫn dự án
```

---

## 🛠 CÔNG NGHỆ SỬ DỤNG

* **Ngôn ngữ:** Java (JDK 17)
* **Mô hình kiến trúc:** MVC (Model - View - Controller) kết hợp DAO Pattern
* **Web Server:** Apache Tomcat 9.0+ (Servlet 4.0, JSP)
* **Cơ sở dữ liệu:** MySQL 8.x (Port `3306`)
* **Giao diện:** JSP, HTML5, CSS3, Bootstrap 5, Font Awesome 6
* **Môi trường phát triển:** Eclipse IDE for Enterprise Java and Web Developers

