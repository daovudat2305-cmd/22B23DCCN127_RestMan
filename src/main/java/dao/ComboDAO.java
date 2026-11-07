package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import model.Combo7;
import model.ComboItem7;
import model.Food7;
import model.MenuItemCategory7;

public class ComboDAO extends DAO {

    public ComboDAO() {
        super();
    }

    /**
     * Lấy thông tin chi tiết của một gói Combo kèm danh sách món thành phần
     * @param comboId mã id của gói combo
     * @return đối tượng Combo7
     */
    public Combo7 getComboById(int comboId) {
        Combo7 combo = null;
        String sqlCombo = "SELECT m.*, c.categoryCode, c.name AS catName, c.description AS catDesc " +
                          "FROM tblCombo7 cb " +
                          "JOIN tblMenuItem7 m ON cb.tblMenuItem7id = m.id " +
                          "JOIN tblMenuItemCategory7 c ON m.tblMenuItemCategory7id = c.id " +
                          "WHERE m.id = ?";

        String sqlItems = "SELECT ci.id AS ciId, ci.quantity, ci.note, " +
                          "m.id AS foodId, m.itemCode, m.name, m.price, m.imageUrl, m.description, f.unit, " +
                          "c.id AS catId, c.categoryCode, c.name AS catName, c.description AS catDesc " +
                          "FROM tblComboItem7 ci " +
                          "JOIN tblFood7 f ON ci.tblFood7id = f.tblMenuItem7id " +
                          "JOIN tblMenuItem7 m ON f.tblMenuItem7id = m.id " +
                          "JOIN tblMenuItemCategory7 c ON m.tblMenuItemCategory7id = c.id " +
                          "WHERE ci.tblCombo7id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sqlCombo);
            ps.setInt(1, comboId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                combo = new Combo7();
                combo.setId(rs.getInt("id"));
                combo.setItemCode(rs.getString("itemCode"));
                combo.setName(rs.getString("name"));
                combo.setPrice(rs.getFloat("price"));
                combo.setImageUrl(rs.getString("imageUrl"));
                combo.setDescription(rs.getString("description"));

                MenuItemCategory7 cat = new MenuItemCategory7(
                    rs.getInt("tblMenuItemCategory7id"),
                    rs.getString("categoryCode"),
                    rs.getString("catName"),
                    rs.getString("catDesc")
                );
                combo.setCategory(cat);

                PreparedStatement psItems = con.prepareStatement(sqlItems);
                psItems.setInt(1, comboId);
                ResultSet rsItems = psItems.executeQuery();
                ArrayList<ComboItem7> items = new ArrayList<>();
                while (rsItems.next()) {
                    Food7 food = new Food7();
                    food.setId(rsItems.getInt("foodId"));
                    food.setItemCode(rsItems.getString("itemCode"));
                    food.setName(rsItems.getString("name"));
                    food.setPrice(rsItems.getFloat("price"));
                    food.setImageUrl(rsItems.getString("imageUrl"));
                    food.setDescription(rsItems.getString("description"));
                    food.setUnit(rsItems.getString("unit"));
                    food.setCategory(new MenuItemCategory7(
                        rsItems.getInt("catId"),
                        rsItems.getString("categoryCode"),
                        rsItems.getString("catName"),
                        rsItems.getString("catDesc")
                    ));

                    ComboItem7 ci = new ComboItem7();
                    ci.setId(rsItems.getInt("ciId"));
                    ci.setQuantity(rsItems.getInt("quantity"));
                    ci.setNote(rsItems.getString("note"));
                    ci.setFood(food);
                    items.add(ci);
                }
                combo.setComboItems(items);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return combo;
    }

    /**
     * Lấy danh sách tất cả các gói Combo hiện có trong thực đơn
     * @return ArrayList<Combo7>
     */
    public ArrayList<Combo7> getAllCombo() {
        ArrayList<Combo7> list = new ArrayList<>();
        String sql = "SELECT m.id FROM tblCombo7 cb JOIN tblMenuItem7 m ON cb.tblMenuItem7id = m.id ORDER BY m.id DESC";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Combo7 cb = getComboById(rs.getInt("id"));
                if (cb != null) {
                    list.add(cb);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lưu gói Combo mới cùng danh sách món thành phần vào CSDL (sử dụng Transaction chuẩn Chương 5)
     * @param combo đối tượng Combo7 chứa thông tin chung và danh sách ComboItem7
     * @return true nếu lưu thành công, false nếu có lỗi
     */
    public boolean saveCombo(Combo7 combo) {
        if (combo == null || combo.getComboItems() == null || combo.getComboItems().isEmpty()) {
            return false;
        }
        boolean kq = false;
        String sqlFindComboCat = "SELECT id FROM tblMenuItemCategory7 WHERE LOWER(name) = 'combo' LIMIT 1";
        String sqlInsertMenuItem = "INSERT INTO tblMenuItem7(itemCode, name, price, imageUrl, description, tblMenuItemCategory7id) VALUES(?, ?, ?, ?, ?, ?)";
        String sqlInsertCombo = "INSERT INTO tblCombo7(tblMenuItem7id) VALUES(?)";
        String sqlInsertComboItem = "INSERT INTO tblComboItem7(quantity, note, tblCombo7id, tblFood7id) VALUES(?, ?, ?, ?)";

        try {
            con.setAutoCommit(false);

            // 1. Lấy id của thể loại Combo (mặc định là 5 nếu chưa có)
            int comboCatId = 5;
            PreparedStatement psCat = con.prepareStatement(sqlFindComboCat);
            ResultSet rsCat = psCat.executeQuery();
            if (rsCat.next()) {
                comboCatId = rsCat.getInt("id");
            }

            // 2. Tự động sinh mã itemCode nếu chưa truyền
            String itemCode = combo.getItemCode();
            if (itemCode == null || itemCode.trim().isEmpty()) {
                itemCode = "CB" + (System.currentTimeMillis() % 10000);
                combo.setItemCode(itemCode);
            }

            // 3. Thêm bản ghi vào tblMenuItem7
            PreparedStatement psMenu = con.prepareStatement(sqlInsertMenuItem, Statement.RETURN_GENERATED_KEYS);
            psMenu.setString(1, combo.getItemCode());
            psMenu.setString(2, combo.getName());
            psMenu.setFloat(3, combo.getPrice());
            psMenu.setString(4, combo.getImageUrl());
            psMenu.setString(5, combo.getDescription());
            psMenu.setInt(6, comboCatId);
            psMenu.executeUpdate();

            ResultSet rsKey = psMenu.getGeneratedKeys();
            int newComboId = 0;
            if (rsKey.next()) {
                newComboId = rsKey.getInt(1);
                combo.setId(newComboId);
            }

            // 4. Thêm bản ghi vào tblCombo7
            PreparedStatement psCombo = con.prepareStatement(sqlInsertCombo);
            psCombo.setInt(1, newComboId);
            psCombo.executeUpdate();

            // 5. Thêm danh sách món thành phần vào tblComboItem7
            for (ComboItem7 item : combo.getComboItems()) {
                PreparedStatement psItem = con.prepareStatement(sqlInsertComboItem);
                psItem.setInt(1, item.getQuantity());
                psItem.setString(2, item.getNote() != null ? item.getNote() : "");
                psItem.setInt(3, newComboId);
                psItem.setInt(4, item.getFood().getId());
                psItem.executeUpdate();
            }

            con.commit();
            kq = true;
        } catch (Exception e) {
            try {
                con.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            kq = false;
        } finally {
            try {
                con.setAutoCommit(true);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return kq;
    }
}