package controller;

import dao.AccountDAO;
import dao.CustomerDAO;
import model.Account;
import model.Customer;
import util.FacebookLoginUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login/facebook")
public class FacebookLoginServlet extends HttpServlet {

    private final AccountDAO accountDAO = new AccountDAO();
    private final CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        String error = request.getParameter("error");

        if (error != null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?err=Facebook Login Denied.");
            return;
        }

        if (code == null || code.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?err=Facebook Login Failed.");
            return;
        }

        try {
            String accessToken = FacebookLoginUtil.getToken(code);
            if (accessToken == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp?err=Failed to retrieve access token.");
                return;
            }

            FacebookLoginUtil.FacebookAccount fbAcc = FacebookLoginUtil.getUserInfo(accessToken);

            if (fbAcc != null && fbAcc.email != null) {
                // Check if account already exists
                Account acc = accountDAO.findByUsername(fbAcc.email);

                if (acc == null) {
                    // Create new Customer
                    Customer newCust = new Customer();
                    newCust.setFullName(fbAcc.name != null ? fbAcc.name : "Facebook User");
                    newCust.setEmail(fbAcc.email);
                    customerDAO.create(newCust);

                    Customer savedCust = customerDAO.findByEmail(fbAcc.email);

                    // Create new Account linked to Customer
                    acc = new Account();
                    acc.setUsername(fbAcc.email);
                    acc.setRole("GUEST");
                    if (savedCust != null) {
                        acc.setCustomerID(savedCust.getCustomerID());
                    }
                    accountDAO.create(acc, fbAcc.id); // use FB ID as placeholder password
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
                response.sendRedirect(request.getContextPath()
                        + "/login.jsp?err=Could not retrieve Facebook profile (make sure your FB account has an email).");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp?err=Error configuring Facebook Login: " + e.getMessage());
        }
    }
}
