package model;

import java.util.ArrayList;

public class Combo7 extends MenuItem7 {
    private static final long serialVersionUID = 1L;
    private ArrayList<ComboItem7> comboItems;

    public Combo7() {
        super();
        this.comboItems = new ArrayList<>();
    }

    public ArrayList<ComboItem7> getComboItems() { return comboItems; }
    public void setComboItems(ArrayList<ComboItem7> comboItems) { this.comboItems = comboItems; }

    public ComboItem7[] getComboItem() {
        if (comboItems == null) return new ComboItem7[0];
        return comboItems.toArray(new ComboItem7[0]);
    }
}