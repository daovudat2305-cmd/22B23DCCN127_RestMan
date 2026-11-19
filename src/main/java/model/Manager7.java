package model;

/**
 * Manager7 là alias của Staff7 dùng cho role MANAGER.
 * Không có bảng riêng trong DB — dữ liệu lưu tại tblMember7 + tblStaff7.
 */
public class Manager7 extends Staff7 {
    private static final long serialVersionUID = 1L;

    public Manager7() {
        super();
    }
}