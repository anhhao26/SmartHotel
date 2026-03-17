package filter;

import dao.BookingDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;

@WebFilter(filterName = "AdminNotificationFilter", urlPatterns = {
    "/admin/*", 
    "/RoomServlet", 
    "/reception/*", 
    "/products", 
    "/predict-revenue"
})
public class AdminNotificationFilter implements Filter {

    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        
        // Fetch recent notifications (top 5 bookings)
        try {
            request.setAttribute("notifications", bookingDAO.getRecentNotifications(5));
        } catch (Exception e) {
            e.printStackTrace();
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
