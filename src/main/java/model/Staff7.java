package model;

import java.sql.Date;

public class Staff7 extends Member7 {
    private static final long serialVersionUID = 1L;
    private String staffCode;
    private String position;
    private Date hireDate;
    private float salary;

    public Staff7() {
        super();
    }

    public String getStaffCode() { return staffCode; }
    public void setStaffCode(String staffCode) { this.staffCode = staffCode; }

    public String getPosition() { return position; }
    public void setPosition(String position) { this.position = position; }

    public Date getHireDate() { return hireDate; }
    public void setHireDate(Date hireDate) { this.hireDate = hireDate; }

    public float getSalary() { return salary; }
    public void setSalary(float salary) { this.salary = salary; }
}