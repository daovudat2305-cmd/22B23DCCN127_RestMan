package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Customer7;
import model.Manager7;
import model.Member7;

public class MemberDAO extends DAO {

    public MemberDAO() {
        super();
    }

    /**
     * Kiểm tra thông tin đăng nhập của thành viên (chuẩn Chương 5 giáo trình)
     * @param member đối tượng Member7 chứa username và password
     * @return true nếu đăng nhập thành công, false nếu thất bại
     */
    public boolean checkLogin(Member7 member) {
        boolean kq = false;
        if (member.getUsername() == null || member.getPassword() == null) return false;
        if (member.getUsername().contains("true") || member.getUsername().contains("=") ||
            member.getPassword().contains("true") || member.getPassword().contains("=")) {
            return false;
        }
        String sql = "SELECT * FROM tblMember7 WHERE username = ? AND password = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, member.getUsername());
            ps.setString(2, member.getPassword());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                member.setId(rs.getInt("id"));
                member.setFullName(rs.getString("fullName"));
                member.setDob(rs.getDate("dob"));
                member.setAddress(rs.getString("address"));
                member.setEmail(rs.getString("email"));
                member.setPhone(rs.getString("phone"));
                member.setRole(rs.getString("role"));
                member.setNote(rs.getString("note"));
                kq = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            kq = false;
        }
        return kq;
    }

    public Customer7 getCustomerById(int memberId) {
        Customer7 customer = new Customer7();
        String sql = "SELECT m.*, c.customerCode, c.registrationDate " +
                     "FROM tblMember7 m LEFT JOIN tblCustomer7 c ON m.id = c.tblMember7id " +
                     "WHERE m.id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, memberId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                customer.setId(rs.getInt("id"));
                customer.setUsername(rs.getString("username"));
                customer.setFullName(rs.getString("fullName"));
                customer.setEmail(rs.getString("email"));
                customer.setPhone(rs.getString("phone"));
                customer.setAddress(rs.getString("address"));
                customer.setRole(rs.getString("role"));
                customer.setCustomerCode(rs.getString("customerCode") != null ? rs.getString("customerCode") : "KH00" + memberId);
                customer.setRegistrationDate(rs.getDate("registrationDate"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return customer;
    }

    public Manager7 getManagerById(int memberId) {
        Manager7 manager = new Manager7();
        String sql = "SELECT m.*, s.staffCode, s.position, s.hireDate, s.salary " +
                     "FROM tblMember7 m LEFT JOIN tblStaff7 s ON m.id = s.tblMember7id " +
                     "WHERE m.id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, memberId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                manager.setId(rs.getInt("id"));
                manager.setUsername(rs.getString("username"));
                manager.setFullName(rs.getString("fullName"));
                manager.setEmail(rs.getString("email"));
                manager.setPhone(rs.getString("phone"));
                manager.setRole(rs.getString("role"));
                manager.setStaffCode(rs.getString("staffCode") != null ? rs.getString("staffCode") : "QL00" + memberId);
                manager.setPosition(rs.getString("position") != null ? rs.getString("position") : "Quản lý");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return manager;
    }
}