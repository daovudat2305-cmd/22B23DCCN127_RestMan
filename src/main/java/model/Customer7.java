package model;

import java.time.LocalDate;

public class Customer7 extends Member7 {
    private static final long serialVersionUID = 1L;
    private String customerCode;
    private LocalDate registrationDate;

    public Customer7() {
        super();
    }

    public Customer7(int id, String username, String password, String fullName, LocalDate dob, String address,
                     String email, String phone, String role, String note, String customerCode, LocalDate registrationDate) {
        super(id, username, password, fullName, dob, address, email, phone, role, note);
        this.customerCode = customerCode;
        this.registrationDate = registrationDate;
    }

    public String getCustomerCode() { return customerCode; }
    public void setCustomerCode(String customerCode) { this.customerCode = customerCode; }

    public LocalDate getRegistrationDate() { return registrationDate; }
    public void setRegistrationDate(LocalDate registrationDate) { this.registrationDate = registrationDate; }
    public void setRegistrationDate(java.sql.Date registrationDate) { this.registrationDate = (registrationDate != null) ? registrationDate.toLocalDate() : null; }
}
