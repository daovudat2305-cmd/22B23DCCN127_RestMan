package model;

import java.io.Serializable;
import java.math.BigDecimal;

public class MenuItem7 implements Serializable {
    private static final long serialVersionUID = 1L;
    private int id;
    private String itemCode;
    private String name;
    private BigDecimal price;
    private String imageUrl;
    private String description;
    private MenuItemCategory7 menuItemCategory;

    public MenuItem7() {
    }

    public MenuItem7(int id, String itemCode, String name, BigDecimal price, String imageUrl, String description, MenuItemCategory7 menuItemCategory) {
        this.id = id;
        this.itemCode = itemCode;
        this.name = name;
        this.price = price;
        this.imageUrl = imageUrl;
        this.description = description;
        this.menuItemCategory = menuItemCategory;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getItemCode() { return itemCode; }
    public void setItemCode(String itemCode) { this.itemCode = itemCode; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public void setPrice(float price) { this.price = BigDecimal.valueOf(price); }
    public void setPrice(double price) { this.price = BigDecimal.valueOf(price); }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public MenuItemCategory7 getMenuItemCategory() { return menuItemCategory; }
    public void setMenuItemCategory(MenuItemCategory7 menuItemCategory) { this.menuItemCategory = menuItemCategory; }

    // Backward compatibility aliases
    public MenuItemCategory7 getCategory() { return menuItemCategory; }
    public void setCategory(MenuItemCategory7 category) { this.menuItemCategory = category; }
}
