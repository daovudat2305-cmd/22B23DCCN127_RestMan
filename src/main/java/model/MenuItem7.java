package model;

import java.io.Serializable;

public class MenuItem7 implements Serializable {
    private static final long serialVersionUID = 1L;
    private int id;
    private String itemCode;
    private String name;
    private float price;
    private String imageUrl;
    private String description;
    private MenuItemCategory7 category;

    public MenuItem7() {
    }

    public MenuItem7(int id, String itemCode, String name, float price, String imageUrl, String description, MenuItemCategory7 category) {
        this.id = id;
        this.itemCode = itemCode;
        this.name = name;
        this.price = price;
        this.imageUrl = imageUrl;
        this.description = description;
        this.category = category;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getItemCode() { return itemCode; }
    public void setItemCode(String itemCode) { this.itemCode = itemCode; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public float getPrice() { return price; }
    public void setPrice(float price) { this.price = price; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public MenuItemCategory7 getCategory() { return category; }
    public void setCategory(MenuItemCategory7 category) { this.category = category; }
}