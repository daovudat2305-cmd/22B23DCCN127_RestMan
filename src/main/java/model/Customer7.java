package model;

import java.sql.Date;

public class Customer7 extends Member7 {
    private static final long serialVersionUID = 1L;
    private String customerCode;
    private Date registrationDate;

    public Customer7() {
        super();
    }

    public String getCustomerCode() { return customerCode; }
    public void setCustomerCode(String customerCode) { this.customerCode = customerCode; }

    public Date getRegistrationDate() { return registrationDate; }
    public void setRegistrationDate(Date registrationDate) { this.registrationDate = registrationDate; }
}