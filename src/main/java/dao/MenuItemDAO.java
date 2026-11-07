package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Combo7;
import model.Food7;
import model.MenuItem7;
import model.MenuItemCategory7;

public class MenuItemDAO extends DAO {

    public MenuItemDAO() {
        super();
    }

    /**
     * Tìm kiếm mục thực đơn (bao gồm cả món ăn lẻ Food7 và gói Combo7) theo từ khóa và mã thể loại
     * @param kw từ khóa tên món ăn/combo
     * @param catId mã thể loại (0 nếu chọn Tất cả)
     * @return ArrayList<MenuItem7> danh sách thực đơn thỏa mãn
     */
    public ArrayList<MenuItem7> searchMenuItem(String kw, int catId) {
        ArrayList<MenuItem7> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT m.*, c.categoryCode, c.name AS catName, c.description AS catDesc, " +
            "f.unit, cb.tblMenuItem7id AS comboId " +
            "FROM tblMenuItem7 m " +
            "JOIN tblMenuItemCategory7 c ON m.tblMenuItemCategory7id = c.id " +
            "LEFT JOIN tblFood7 f ON m.id = f.tblMenuItem7id " +
            "LEFT JOIN tblCombo7 cb ON m.id = cb.tblMenuItem7id " +
            "WHERE 1=1 "
        );

        if (kw != null && !kw.trim().isEmpty()) {
            sql.append("AND LOWER(m.name) LIKE ? ");
        }
        if (catId > 0) {
            sql.append("AND m.tblMenuItemCategory7id = ? ");
        }
        sql.append("ORDER BY m.id ASC");

        try {
            PreparedStatement ps = con.prepareStatement(sql.toString());
            int idx = 1;
            if (kw != null && !kw.trim().isEmpty()) {
                ps.setString(idx++, "%" + kw.trim().toLowerCase() + "%");
            }
            if (catId > 0) {
                ps.setInt(idx++, catId);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                MenuItemCategory7 cat = new MenuItemCategory7(
                    rs.getInt("tblMenuItemCategory7id"),
                    rs.getString("categoryCode"),
                    rs.getString("catName"),
                    rs.getString("catDesc")
                );

                MenuItem7 item;
                if (rs.getObject("comboId") != null) {
                    Combo7 combo = new Combo7();
                    item = combo;
                } else {
                    Food7 food = new Food7();
                    food.setUnit(rs.getString("unit"));
                    item = food;
                }

                item.setId(rs.getInt("id"));
                item.setItemCode(rs.getString("itemCode"));
                item.setName(rs.getString("name"));
                item.setPrice(rs.getFloat("price"));
                item.setImageUrl(rs.getString("imageUrl"));
                item.setDescription(rs.getString("description"));
                item.setCategory(cat);

                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}