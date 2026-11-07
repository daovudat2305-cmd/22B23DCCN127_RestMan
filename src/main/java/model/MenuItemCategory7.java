package model;

import java.io.Serializable;

public class MenuItemCategory7 implements Serializable {
    private static final long serialVersionUID = 1L;
    private int id;
    private String categoryCode;
    private String name;
    private String description;

    public MenuItemCategory7() {
    }

    public MenuItemCategory7(int id, String categoryCode, String name, String description) {
        this.id = id;
        this.categoryCode = categoryCode;
        this.name = name;
        this.description = description;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getCategoryCode() { return categoryCode; }
    public void setCategoryCode(String categoryCode) { this.categoryCode = categoryCode; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}