package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import dao.BookingDAO;

@WebServlet(name = "AdminServlet", urlPatterns = {"/admin"})
public class AdminServlet extends HttpServlet {
    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Mọi request vào đây đã được AuthorizationFilter kiểm tra role.
        // Bạn có thể lấy dữ liệu thống kê từ database để truyền ra Dashboard tại đây.
        
        // Fetch dashboard statistics
        double monthlyRevenue = bookingDAO.getTotalRevenueThisMonth();
        double occupancyRate = bookingDAO.getOccupancyRate();
        long serviceRequests = bookingDAO.getActiveServiceRequestsCount();
        List<model.Booking> notifications = bookingDAO.getRecentNotifications(5);
        
        req.setAttribute("monthlyRevenue", monthlyRevenue);
        req.setAttribute("occupancyRate", occupancyRate);
        req.setAttribute("serviceRequests", serviceRequests);
        req.setAttribute("notifications", notifications);
        
        req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
    }
}