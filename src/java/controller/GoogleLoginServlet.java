package controller;

import dao.AccountDAO;
import dao.CustomerDAO;
import model.Account;
import model.Customer;
import util.GoogleLoginUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login/google")
public class GoogleLoginServlet extends HttpServlet {

    private final AccountDAO accountDAO = new AccountDAO();
    private final CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        String error = request.getParameter("error");

        if (error != null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?err=Google Login Denied.");
            return;
        }

        if (code == null || code.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?err=Google Login Failed.");
            return;
        }

        try {
            String accessToken = GoogleLoginUtil.getToken(code);
            GoogleLoginUtil.GoogleAccount googleAcc = GoogleLoginUtil.getUserInfo(accessToken);

            if (googleAcc != null && googleAcc.email != null) {
                // Check if account already exists
                Account acc = accountDAO.findByUsername(googleAcc.email);

                if (acc == null) {
                    // Create new Customer
                    Customer newCust = new Customer();
                    newCust.setFullName(googleAcc.name != null ? googleAcc.name : "Google User");
                    newCust.setEmail(googleAcc.email);
                    customerDAO.create(newCust); // Assuming create returns void but generates ID

                    // Actually, to get the saved Customer ID, we need to fetch it or rely on DAO
                    // Temporary workaround if we can't get ID easily:
                    Customer savedCust = customerDAO.findByEmail(googleAcc.email);

                    // Create new Account linked to Customer
                    acc = new Account();
                    acc.setUsername(googleAcc.email);
                    acc.setRole("GUEST");
                    if (savedCust != null) {
                        acc.setCustomerID(savedCust.getCustomerID());
                    }
                    accountDAO.create(acc, googleAcc.id); // use Google ID as a placeholder dummy password
                }

                // Log the user in
                HttpSession session = request.getSession(true);
                session.setAttribute("acc", acc);
                session.setAttribute("ROLE", acc.getRole());
                session.setAttribute("USERNAME", acc.getUsername());
                if (acc.getCustomerID() != null) {
                    session.setAttribute("CUST_ID", acc.getCustomerID());
                }

                response.sendRedirect(request.getContextPath() + "/index.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/login.jsp?err=Could not retrieve Google profile.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp?err=Error configuring Google Login: " + e.getMessage());
        }
    }
}
