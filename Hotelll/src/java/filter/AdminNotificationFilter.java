package filter;

import dao.BookingDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "AdminNotificationFilter", urlPatterns = {
    "/admin/*", 
    "/RoomServlet",
    "/VoucherServlet",
    "/reception/*", 
    "/products", 
    "/predict-revenue"
})
public class AdminNotificationFilter implements Filter {

    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    private static final long CACHE_TTL_MS = 30_000; // 30 giây

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = httpRequest.getSession(false);

        // Chỉ tải thông báo khi đã đăng nhập (tránh DB call vô ích cho guest)
        if (session != null && session.getAttribute("ROLE") != null) {
            try {
                // Cache notifications vào session 30 giây — tránh query DB mỗi lần chuyển trang
                Long lastFetch = (Long) session.getAttribute("notif_last_fetch");
                long now = System.currentTimeMillis();

                if (lastFetch == null || (now - lastFetch) > CACHE_TTL_MS) {
                    java.util.List<?> fresh = bookingDAO.getRecentNotifications(5);
                    session.setAttribute("notif_cache", fresh);
                    session.setAttribute("notif_last_fetch", now);
                }

                request.setAttribute("notifications", session.getAttribute("notif_cache"));
            } catch (Exception e) {
                // Không để lỗi DB phá vỡ toàn bộ request
                e.printStackTrace();
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
