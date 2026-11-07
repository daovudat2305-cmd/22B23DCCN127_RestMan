package model;

import java.io.Serializable;
import java.sql.Date;

public class Member7 implements Serializable {
    private static final long serialVersionUID = 1L;
    private int id;
    private String username;
    private String password;
    private String fullName;
    private Date dob;
    private String address;
    private String email;
    private String phone;
    private String role;
    private String note;

    public Member7() {
    }

    public Member7(int id, String username, String password, String fullName, Date dob, String address, String email, String phone, String role, String note) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.dob = dob;
        this.address = address;
        this.email = email;
        this.phone = phone;
        this.role = role;
        this.note = note;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public Date getDob() { return dob; }
    public void setDob(Date dob) { this.dob = dob; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
}