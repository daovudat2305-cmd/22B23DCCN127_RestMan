package model;

import java.io.Serializable;

public class ComboItem7 implements Serializable {
    private static final long serialVersionUID = 1L;
    private int id;
    private int quantity;
    private String note;
    private Food7 food;

    public ComboItem7() {
    }

    public ComboItem7(int id, int quantity, String note, Food7 food) {
        this.id = id;
        this.quantity = quantity;
        this.note = note;
        this.food = food;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public Food7 getFood() { return food; }
    public void setFood(Food7 food) { this.food = food; }
}