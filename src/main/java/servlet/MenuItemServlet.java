package servlet;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.ComboDAO;
import dao.FoodDAO;
import dao.MenuItemCategoryDAO;
import dao.MenuItemDAO;
import model.Combo7;
import model.Food7;
import model.MenuItem7;
import model.MenuItemCategory7;

@WebServlet("/MenuItemServlet")
public class MenuItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MenuItemDAO menuItemDAO;
    private MenuItemCategoryDAO menuItemCategoryDAO;
    private FoodDAO foodDAO;
    private ComboDAO comboDAO;

    @Override
    public void init() {
        menuItemDAO = new MenuItemDAO();
        menuItemCategoryDAO = new MenuItemCategoryDAO();
        foodDAO = new FoodDAO();
        comboDAO = new ComboDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            action = "showSearchForm";
        }

        switch (action) {
            case "searchMenuItem":
                searchMenuItem(request, response);
                break;
            case "viewFoodDetail":
                viewFoodDetail(request, response);
                break;
            case "viewComboDetail":
                viewComboDetail(request, response);
                break;
            case "showSearchForm":
            default:
                showSearchForm(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void showSearchForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<MenuItemCategory7> listCategory = menuItemCategoryDAO.getAllCategories();
        request.setAttribute("listCategory", listCategory);
        request.getRequestDispatcher("/customer/SearchMenuItemUI.jsp").forward(request, response);
    }

    private void searchMenuItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String kw = request.getParameter("inKeyword");
        String catParam = request.getParameter("inoutCategory");
        int catId = 0;
        if (catParam != null && !catParam.trim().isEmpty()) {
            try {
                catId = Integer.parseInt(catParam);
            } catch (NumberFormatException e) {
                catId = 0;
            }
        }

        ArrayList<MenuItemCategory7> listCategory = menuItemCategoryDAO.getAllCategories();
        ArrayList<MenuItem7> listResult = menuItemDAO.searchMenuItem(kw, catId);

        request.setAttribute("listCategory", listCategory);
        request.setAttribute("listResult", listResult);
        request.setAttribute("inKeyword", kw);
        request.setAttribute("selectedCategory", catId);
        request.getRequestDispatcher("/customer/SearchMenuItemUI.jsp").forward(request, response);
    }

    private void viewFoodDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int foodId = Integer.parseInt(request.getParameter("foodId"));
        Food7 foodItem = foodDAO.getFoodById(foodId);
        request.setAttribute("foodItem", foodItem);
        request.getRequestDispatcher("/customer/FoodDetailUI.jsp").forward(request, response);
    }

    private void viewComboDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int comboId = Integer.parseInt(request.getParameter("comboId"));
        Combo7 comboItem = comboDAO.getComboById(comboId);
        request.setAttribute("comboItem", comboItem);
        request.getRequestDispatcher("/customer/ComboDetailUI.jsp").forward(request, response);
    }
}