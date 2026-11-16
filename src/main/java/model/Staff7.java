package model;

import java.math.BigDecimal;
import java.time.LocalDate;

public class Staff7 extends Member7 {
    private static final long serialVersionUID = 1L;
    private String staffCode;
    private String position;
    private LocalDate hireDate;
    private BigDecimal salary;

    public Staff7() {
        super();
    }

    public Staff7(int id, String username, String password, String fullName, LocalDate dob, String address,
                  String email, String phone, String role, String note, String staffCode, String position,
                  LocalDate hireDate, BigDecimal salary) {
        super(id, username, password, fullName, dob, address, email, phone, role, note);
        this.staffCode = staffCode;
        this.position = position;
        this.hireDate = hireDate;
        this.salary = salary;
    }

    public String getStaffCode() { return staffCode; }
    public void setStaffCode(String staffCode) { this.staffCode = staffCode; }

    public String getPosition() { return position; }
    public void setPosition(String position) { this.position = position; }

    public LocalDate getHireDate() { return hireDate; }
    public void setHireDate(LocalDate hireDate) { this.hireDate = hireDate; }
    public void setHireDate(java.sql.Date hireDate) { this.hireDate = (hireDate != null) ? hireDate.toLocalDate() : null; }

    public BigDecimal getSalary() { return salary; }
    public void setSalary(BigDecimal salary) { this.salary = salary; }
    public void setSalary(float salary) { this.salary = BigDecimal.valueOf(salary); }
    public void setSalary(double salary) { this.salary = BigDecimal.valueOf(salary); }
}
