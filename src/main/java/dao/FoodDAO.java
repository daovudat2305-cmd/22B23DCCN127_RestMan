package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Food7;
import model.MenuItemCategory7;

public class FoodDAO extends DAO {

    public FoodDAO() {
        super();
    }

    /**
     * Lấy thông tin chi tiết của một món ăn đơn lẻ theo id
     * @param foodId mã id của món ăn
     * @return đối tượng Food7
     */
    public Food7 getFoodById(int foodId) {
        Food7 food = null;
        String sql = "SELECT m.*, f.unit, c.categoryCode, c.name AS catName, c.description AS catDesc " +
                     "FROM tblFood7 f " +
                     "JOIN tblMenuItem7 m ON f.tblMenuItem7id = m.id " +
                     "JOIN tblMenuItemCategory7 c ON m.tblMenuItemCategory7id = c.id " +
                     "WHERE m.id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, foodId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                food = new Food7();
                food.setId(rs.getInt("id"));
                food.setItemCode(rs.getString("itemCode"));
                food.setName(rs.getString("name"));
                food.setPrice(rs.getFloat("price"));
                food.setImageUrl(rs.getString("imageUrl"));
                food.setDescription(rs.getString("description"));
                food.setUnit(rs.getString("unit"));

                MenuItemCategory7 cat = new MenuItemCategory7(
                    rs.getInt("tblMenuItemCategory7id"),
                    rs.getString("categoryCode"),
                    rs.getString("catName"),
                    rs.getString("catDesc")
                );
                food.setCategory(cat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return food;
    }

    /**
     * Tìm kiếm món ăn đơn lẻ theo từ khóa và mã thể loại (phục vụ chức năng Lên menu combo)
     * @param keyword từ khóa tên món ăn
     * @param catId mã thể loại (0 nếu chọn tất cả thể loại món ăn)
     * @return ArrayList<Food7> danh sách món ăn đơn lẻ
     */
    public ArrayList<Food7> searchFood(String keyword, int catId) {
        ArrayList<Food7> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT m.*, f.unit, c.categoryCode, c.name AS catName, c.description AS catDesc " +
            "FROM tblFood7 f " +
            "JOIN tblMenuItem7 m ON f.tblMenuItem7id = m.id " +
            "JOIN tblMenuItemCategory7 c ON m.tblMenuItemCategory7id = c.id " +
            "WHERE 1=1 "
        );

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND LOWER(m.name) LIKE ? ");
        }
        if (catId > 0) {
            sql.append("AND m.tblMenuItemCategory7id = ? ");
        }
        sql.append("ORDER BY m.id ASC");

        try {
            PreparedStatement ps = con.prepareStatement(sql.toString());
            int idx = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(idx++, "%" + keyword.trim().toLowerCase() + "%");
            }
            if (catId > 0) {
                ps.setInt(idx++, catId);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Food7 food = new Food7();
                food.setId(rs.getInt("id"));
                food.setItemCode(rs.getString("itemCode"));
                food.setName(rs.getString("name"));
                food.setPrice(rs.getFloat("price"));
                food.setImageUrl(rs.getString("imageUrl"));
                food.setDescription(rs.getString("description"));
                food.setUnit(rs.getString("unit"));

                MenuItemCategory7 cat = new MenuItemCategory7(
                    rs.getInt("tblMenuItemCategory7id"),
                    rs.getString("categoryCode"),
                    rs.getString("catName"),
                    rs.getString("catDesc")
                );
                food.setCategory(cat);
                list.add(food);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}