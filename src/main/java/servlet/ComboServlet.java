package servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import dao.ComboDAO;
import dao.FoodDAO;
import dao.MenuItemCategoryDAO;
import model.Combo7;
import model.ComboItem7;
import model.Food7;
import model.MenuItemCategory7;

@WebServlet(value = "/ComboServlet", loadOnStartup = 1)
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class ComboServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ComboDAO comboDAO;
    private FoodDAO foodDAO;
    private MenuItemCategoryDAO menuItemCategoryDAO;

    @Override
    public void init() {
        comboDAO = new ComboDAO();
        foodDAO = new FoodDAO();
        menuItemCategoryDAO = new MenuItemCategoryDAO();
        syncUploadsToDeployDirectory();
    }

    /**
     * Tự động đồng bộ các file ảnh từ thư mục source src/main/webapp/uploads sang
     * thư mục deploy wtpwebapps/RestMan/uploads khi Tomcat khởi động hoặc servlet nạp
     */
    private void syncUploadsToDeployDirectory() {
        try {
            String deployUploadDirPath = getServletContext().getRealPath("/uploads");
            if (deployUploadDirPath != null) {
                File deployDir = new File(deployUploadDirPath);
                if (!deployDir.exists()) {
                    deployDir.mkdirs();
                }
                File sourceDir = new File("G:/RestMan/src/main/webapp/uploads");
                if (sourceDir.exists() && sourceDir.isDirectory()) {
                    File[] files = sourceDir.listFiles();
                    if (files != null) {
                        for (File f : files) {
                            if (f.isFile()) {
                                File dest = new File(deployDir, f.getName());
                                if (!dest.exists() || dest.length() != f.length()) {
                                    Files.copy(f.toPath(), dest.toPath(), StandardCopyOption.REPLACE_EXISTING);
                                }
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            action = "listCombos";
        }

        switch (action) {
            case "showAddForm":
                showAddForm(request, response);
                break;
            case "searchFood":
                searchFood(request, response);
                break;
            case "removeFoodFromCombo":
                removeFoodFromCombo(request, response);
                break;
            case "listCombos":
            default:
                listCombos(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            doGet(request, response);
            return;
        }

        switch (action) {
            case "addFoodToCombo":
                addFoodToCombo(request, response);
                break;
            case "removeFoodFromCombo":
                removeFoodFromCombo(request, response);
                break;
            case "uploadDraftImage":
                uploadDraftImage(request, response);
                break;
            case "saveCombo":
                saveCombo(request, response);
                break;
            case "searchFood":
                searchFood(request, response);
                break;
            default:
                doGet(request, response);
                break;
        }
    }

    private void listCombos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<Combo7> listCombo = comboDAO.getAllCombo();
        request.setAttribute("listCombo", listCombo);
        request.getRequestDispatcher("/manager/ComboManagementUI.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        ArrayList<MenuItemCategory7> listFoodCategories = menuItemCategoryDAO.getAllFoodCategories();
        ArrayList<ComboItem7> listComboItems = new ArrayList<>();

        session.setAttribute("listFoodCategories", listFoodCategories);
        session.setAttribute("listComboItems", listComboItems);
        session.removeAttribute("listSearchedFood");
        session.removeAttribute("draftComboName");
        session.removeAttribute("draftComboPrice");
        session.removeAttribute("draftComboImage");
        session.removeAttribute("draftComboDescription");
        session.setAttribute("totalOriginalPrice", 0f);

        request.setAttribute("listFoodCategories", listFoodCategories);
        request.setAttribute("listComboItems", listComboItems);
        request.setAttribute("totalOriginalPrice", 0f);
        request.getRequestDispatcher("/manager/AddComboUI.jsp").forward(request, response);
    }

    @SuppressWarnings("unchecked")
    private void searchFood(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        preserveDraftComboFields(request, session);

        String keyword = request.getParameter("inFoodKeyword");
        String catParam = request.getParameter("inFoodCategory");
        int catId = 0;
        if (catParam != null && !catParam.trim().isEmpty()) {
            try {
                catId = Integer.parseInt(catParam);
            } catch (NumberFormatException e) {
                catId = 0;
            }
        }

        ArrayList<MenuItemCategory7> listFoodCategories = menuItemCategoryDAO.getAllFoodCategories();
        ArrayList<Food7> listSearchedFood = foodDAO.searchFood(keyword, catId);
        ArrayList<ComboItem7> listComboItems = (ArrayList<ComboItem7>) session.getAttribute("listComboItems");
        if (listComboItems == null) {
            listComboItems = new ArrayList<>();
        }

        float totalOriginalPrice = calculateTotalOriginalPrice(listComboItems);

        session.setAttribute("listFoodCategories", listFoodCategories);
        session.setAttribute("listSearchedFood", listSearchedFood);
        session.setAttribute("listComboItems", listComboItems);
        session.setAttribute("totalOriginalPrice", totalOriginalPrice);

        request.setAttribute("listFoodCategories", listFoodCategories);
        request.setAttribute("listSearchedFood", listSearchedFood);
        request.setAttribute("listComboItems", listComboItems);
        request.setAttribute("totalOriginalPrice", totalOriginalPrice);
        request.setAttribute("inFoodKeyword", keyword);
        request.setAttribute("selectedFoodCategory", catId);

        request.getRequestDispatcher("/manager/AddComboUI.jsp").forward(request, response);
    }

    @SuppressWarnings("unchecked")
    private void addFoodToCombo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        preserveDraftComboFields(request, session);

        int foodId = Integer.parseInt(request.getParameter("foodId"));
        int quantity = 1;
        try {
            quantity = Integer.parseInt(request.getParameter("inQuantity"));
            if (quantity < 1) quantity = 1;
        } catch (Exception e) {
            quantity = 1;
        }

        ArrayList<ComboItem7> listComboItems = (ArrayList<ComboItem7>) session.getAttribute("listComboItems");
        if (listComboItems == null) {
            listComboItems = new ArrayList<>();
        }

        boolean exists = false;
        for (ComboItem7 ci : listComboItems) {
            if (ci.getFood().getId() == foodId) {
                exists = true;
                break;
            }
        }

        if (exists) {
            request.setAttribute("errorMsg", "Món ăn đã có trong combo!");
        } else {
            Food7 food = foodDAO.getFoodById(foodId);
            if (food != null) {
                ComboItem7 newItem = new ComboItem7();
                newItem.setFood(food);
                newItem.setQuantity(quantity);
                listComboItems.add(newItem);
            }
        }

        float totalOriginalPrice = calculateTotalOriginalPrice(listComboItems);
        ArrayList<MenuItemCategory7> listFoodCategories = (ArrayList<MenuItemCategory7>) session.getAttribute("listFoodCategories");
        if (listFoodCategories == null) {
            listFoodCategories = menuItemCategoryDAO.getAllFoodCategories();
        }
        ArrayList<Food7> listSearchedFood = (ArrayList<Food7>) session.getAttribute("listSearchedFood");

        session.setAttribute("listComboItems", listComboItems);
        session.setAttribute("totalOriginalPrice", totalOriginalPrice);

        request.setAttribute("listFoodCategories", listFoodCategories);
        request.setAttribute("listSearchedFood", listSearchedFood);
        request.setAttribute("listComboItems", listComboItems);
        request.setAttribute("totalOriginalPrice", totalOriginalPrice);

        request.getRequestDispatcher("/manager/AddComboUI.jsp").forward(request, response);
    }

    @SuppressWarnings("unchecked")
    private void removeFoodFromCombo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        preserveDraftComboFields(request, session);

        int foodId = Integer.parseInt(request.getParameter("foodId"));
        ArrayList<ComboItem7> listComboItems = (ArrayList<ComboItem7>) session.getAttribute("listComboItems");
        if (listComboItems != null) {
            listComboItems.removeIf(ci -> ci.getFood().getId() == foodId);
        } else {
            listComboItems = new ArrayList<>();
        }

        float totalOriginalPrice = calculateTotalOriginalPrice(listComboItems);
        ArrayList<MenuItemCategory7> listFoodCategories = (ArrayList<MenuItemCategory7>) session.getAttribute("listFoodCategories");
        if (listFoodCategories == null) {
            listFoodCategories = menuItemCategoryDAO.getAllFoodCategories();
        }
        ArrayList<Food7> listSearchedFood = (ArrayList<Food7>) session.getAttribute("listSearchedFood");

        session.setAttribute("listComboItems", listComboItems);
        session.setAttribute("totalOriginalPrice", totalOriginalPrice);

        request.setAttribute("listFoodCategories", listFoodCategories);
        request.setAttribute("listSearchedFood", listSearchedFood);
        request.setAttribute("listComboItems", listComboItems);
        request.setAttribute("totalOriginalPrice", totalOriginalPrice);

        request.getRequestDispatcher("/manager/AddComboUI.jsp").forward(request, response);
    }

    @SuppressWarnings("unchecked")
    private void saveCombo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String name = request.getParameter("inComboName");
        String priceStr = request.getParameter("inComboPrice");
        String description = request.getParameter("inComboDescription");

        // Xử lý lưu file ảnh tải lên từ máy tính (nếu có)
        String uploadedUrl = saveUploadedFile(request);
        if (uploadedUrl == null || uploadedUrl.isEmpty()) {
            uploadedUrl = (String) session.getAttribute("draftComboImage");
        }
        if (uploadedUrl != null && !uploadedUrl.isEmpty()) {
            session.setAttribute("draftComboImage", uploadedUrl);
        }

        ArrayList<ComboItem7> listComboItems = (ArrayList<ComboItem7>) session.getAttribute("listComboItems");
        ArrayList<MenuItemCategory7> listFoodCategories = (ArrayList<MenuItemCategory7>) session.getAttribute("listFoodCategories");
        if (listFoodCategories == null) {
            listFoodCategories = menuItemCategoryDAO.getAllFoodCategories();
        }
        ArrayList<Food7> listSearchedFood = (ArrayList<Food7>) session.getAttribute("listSearchedFood");

        if (name == null || name.trim().isEmpty() || priceStr == null || priceStr.trim().isEmpty() ||
            listComboItems == null || listComboItems.isEmpty()) {
            preserveDraftComboFields(request, session);
            request.setAttribute("errorMsg", "Vui lòng nhập đầy đủ các trường thông tin bắt buộc và chọn ít nhất 1 món ăn!");
            request.setAttribute("listFoodCategories", listFoodCategories);
            request.setAttribute("listSearchedFood", listSearchedFood);
            request.setAttribute("listComboItems", listComboItems);
            request.setAttribute("totalOriginalPrice", calculateTotalOriginalPrice(listComboItems));
            request.getRequestDispatcher("/manager/AddComboUI.jsp").forward(request, response);
            return;
        }

        float price = 0;
        try {
            price = Float.parseFloat(priceStr.replace(".", "").replace(",", "").trim());
        } catch (NumberFormatException e) {
            price = 0;
        }

        if (uploadedUrl == null || uploadedUrl.trim().isEmpty()) {
            uploadedUrl = "https://images.unsplash.com/photo-1544025162-d76694265947?w=600";
        }

        Combo7 combo = new Combo7();
        combo.setName(name.trim());
        combo.setPrice(price);
        combo.setImageUrl(uploadedUrl);
        combo.setDescription(description != null ? description.trim() : "");
        combo.setComboItems(listComboItems);

        boolean ok = comboDAO.saveCombo(combo);
        if (ok) {
            session.removeAttribute("listComboItems");
            session.removeAttribute("listSearchedFood");
            session.removeAttribute("draftComboName");
            session.removeAttribute("draftComboPrice");
            session.removeAttribute("draftComboImage");
            session.removeAttribute("draftComboDescription");
            request.setAttribute("successMsg", "Tạo combo menu thành công");
            listCombos(request, response);
        } else {
            request.setAttribute("errorMsg", "Đã xảy ra lỗi khi lưu combo vào cơ sở dữ liệu!");
            request.setAttribute("listFoodCategories", listFoodCategories);
            request.setAttribute("listSearchedFood", listSearchedFood);
            request.setAttribute("listComboItems", listComboItems);
            request.setAttribute("totalOriginalPrice", calculateTotalOriginalPrice(listComboItems));
            request.getRequestDispatcher("/manager/AddComboUI.jsp").forward(request, response);
        }
    }

    /**
     * Hỗ trợ lưu tạm ảnh ngay khi người dùng chọn file (để không bị mất ảnh khi bấm Tìm món / Chọn món)
     */
    private void uploadDraftImage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uploadedUrl = saveUploadedFile(request);
        response.setContentType("text/plain;charset=UTF-8");
        if (uploadedUrl != null && !uploadedUrl.isEmpty()) {
            request.getSession().setAttribute("draftComboImage", uploadedUrl);
            response.getWriter().write(uploadedUrl);
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    /**
     * Lưu file từ thẻ <input type="file" name="inComboImage"> vào thư mục /uploads của ứng dụng
     */
    private String saveUploadedFile(HttpServletRequest request) {
        try {
            String contentType = request.getContentType();
            if (contentType == null || !contentType.toLowerCase().startsWith("multipart/")) {
                return null;
            }
            Part filePart = request.getPart("inComboImage");
            if (filePart == null || filePart.getSize() == 0) {
                return null;
            }
            String submittedFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            if (submittedFileName == null || submittedFileName.trim().isEmpty()) {
                return null;
            }

            // Làm sạch tên file và gắn nhãn thời gian tránh trùng lặp
            String safeName = submittedFileName.replaceAll("[^a-zA-Z0-9._-]", "_");
            String fileName = "combo_" + System.currentTimeMillis() + "_" + safeName;

            // 1. Luôn lưu vào thư mục source code của project trước (bền vững, không bị Eclipse xóa)
            File sourceUploadDir = new File("G:/RestMan/src/main/webapp/uploads");
            if (!sourceUploadDir.exists()) {
                sourceUploadDir.mkdirs();
            }
            File sourceDestFile = new File(sourceUploadDir, fileName);
            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, sourceDestFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }

            // 2. Đồng thời copy sang thư mục runtime wtpwebapps (nếu có) để phục vụ ngay
            try {
                String uploadDirPath = getServletContext().getRealPath("/uploads");
                if (uploadDirPath != null) {
                    File uploadDir = new File(uploadDirPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    File destFile = new File(uploadDir, fileName);
                    Files.copy(sourceDestFile.toPath(), destFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                }
            } catch (Exception ex) {
                // Không sao nếu wtpwebapps chưa sẵn sàng vì ImageServlet sẽ phục vụ từ source
            }

            return request.getContextPath() + "/uploads/" + fileName;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private float calculateTotalOriginalPrice(ArrayList<ComboItem7> listComboItems) {
        if (listComboItems == null) return 0f;
        float total = 0f;
        for (ComboItem7 ci : listComboItems) {
            total += ci.getFood().getPrice() * ci.getQuantity();
        }
        return total;
    }

    private void preserveDraftComboFields(HttpServletRequest request, HttpSession session) {
        if (request.getParameter("inComboName") != null) {
            session.setAttribute("draftComboName", request.getParameter("inComboName"));
        }
        if (request.getParameter("inComboPrice") != null) {
            session.setAttribute("draftComboPrice", request.getParameter("inComboPrice"));
        }
        if (request.getParameter("inComboImage") != null && !request.getParameter("inComboImage").isEmpty()) {
            session.setAttribute("draftComboImage", request.getParameter("inComboImage"));
        }
        if (request.getParameter("inComboDescription") != null) {
            session.setAttribute("draftComboDescription", request.getParameter("inComboDescription"));
        }
    }
}