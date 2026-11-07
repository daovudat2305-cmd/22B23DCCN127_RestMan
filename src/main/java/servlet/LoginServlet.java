package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.MemberDAO;
import model.Customer7;
import model.Manager7;
import model.Member7;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MemberDAO memberDAO;

    @Override
    public void init() {
        memberDAO = new MemberDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("logout".equalsIgnoreCase(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/LoginUI.jsp");
            return;
        }
        request.getRequestDispatcher("/LoginUI.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Member7 member = new Member7();
        member.setUsername(username);
        member.setPassword(password);

        boolean ok = memberDAO.checkLogin(member);
        HttpSession session = request.getSession();

        if (ok) {
            if ("CUSTOMER".equalsIgnoreCase(member.getRole())) {
                Customer7 customer = memberDAO.getCustomerById(member.getId());
                session.setAttribute("customer", customer);
                response.sendRedirect(request.getContextPath() + "/customer/CustomerMainUI.jsp");
            } else if ("MANAGER".equalsIgnoreCase(member.getRole())) {
                Manager7 manager = memberDAO.getManagerById(member.getId());
                session.setAttribute("manager", manager);
                response.sendRedirect(request.getContextPath() + "/manager/ManagerMainUI.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/LoginUI.jsp?err=role");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/LoginUI.jsp?err=fail");
        }
    }
}