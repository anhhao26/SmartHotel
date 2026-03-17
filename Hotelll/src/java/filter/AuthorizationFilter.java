package filter;

import model.Account;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Filter đơn giản phân quyền dựa trên session attribute "acc" and its role.
 * - /admin/* -> only ADMIN / MANAGER / SUPERADMIN
 * - /reception/* -> only RECEPTIONIST / STAFF / ADMIN (admin nên có quyền xem)
 */
public class AuthorizationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String contextPath = req.getContextPath();
        String uri = req.getRequestURI();
        String path = uri.substring(contextPath.length());

        Account acc = null;
        if (session != null) {
            Object o = session.getAttribute("acc");
            if (o instanceof Account) {
                acc = (Account) o;
            }
        }

        if (path.startsWith("/admin")) {
            if (acc == null) {
                resp.sendRedirect(contextPath + "/login");
                return;
            }
            String r = acc.getRole() != null ? acc.getRole().trim().toUpperCase() : "";
            if (!(r.equals("ADMIN") || r.equals("MANAGER") || r.equals("SUPERADMIN"))) {
                resp.sendRedirect(contextPath + "/403.jsp");
                return;
            }
        } else if (path.startsWith("/reception")) {
            if (acc == null) {
                resp.sendRedirect(contextPath + "/login");
                return;
            }
            String r = acc.getRole() != null ? acc.getRole().trim().toUpperCase() : "";
            // reception accessible by receptionist/staff and admin
            if (!(r.equals("RECEPTIONIST") || r.equals("STAFF") || r.equals("ADMIN") || r.equals("MANAGER") || r.equals("SUPERADMIN"))) {
                resp.sendRedirect(contextPath + "/403.jsp");
                return;
            }
        }

        chain.doFilter(request, response);
    }
}