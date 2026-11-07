package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.MenuItemCategory7;

public class MenuItemCategoryDAO extends DAO {

    public MenuItemCategoryDAO() {
        super();
    }

    /**
     * Lấy danh sách tất cả thể loại thực đơn (gồm cả thể loại món lẻ và Combo)
     * @return ArrayList<MenuItemCategory7>
     */
    public ArrayList<MenuItemCategory7> getAllCategories() {
        ArrayList<MenuItemCategory7> list = new ArrayList<>();
        String sql = "SELECT * FROM tblMenuItemCategory7 ORDER BY id ASC";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                MenuItemCategory7 cat = new MenuItemCategory7();
                cat.setId(rs.getInt("id"));
                cat.setCategoryCode(rs.getString("categoryCode"));
                cat.setName(rs.getString("name"));
                cat.setDescription(rs.getString("description"));
                list.add(cat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy danh sách các thể loại món ăn đơn lẻ (phục vụ tìm món khi lên menu combo)
     * @return ArrayList<MenuItemCategory7>
     */
    public ArrayList<MenuItemCategory7> getAllFoodCategories() {
        ArrayList<MenuItemCategory7> list = new ArrayList<>();
        String sql = "SELECT * FROM tblMenuItemCategory7 WHERE LOWER(name) <> 'combo' ORDER BY id ASC";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                MenuItemCategory7 cat = new MenuItemCategory7();
                cat.setId(rs.getInt("id"));
                cat.setCategoryCode(rs.getString("categoryCode"));
                cat.setName(rs.getString("name"));
                cat.setDescription(rs.getString("description"));
                list.add(cat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}