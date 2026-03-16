package controller;

import dao.BookingDAO;
import model.Booking;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet xử lý danh sách đặt phòng và thông báo cho Admin.
 * URL: /admin/bookings
 */
@WebServlet(name = "AdminBookingServlet", urlPatterns = {"/admin/bookings"})
public class AdminBookingServlet extends HttpServlet {
    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("edit".equals(action)) {
            String idStr = req.getParameter("id");
            if (idStr != null) {
                try {
                    int id = Integer.parseInt(idStr);
                    Booking b = bookingDAO.find(id);
                    if (b != null) {
                        req.setAttribute("booking", b);
                        req.getRequestDispatcher("/admin/editBooking.jsp").forward(req, resp);
                        return;
                    }
                } catch (Exception e) {}
            }
        }

        // Fetch bookings (filtered if search param is present)
        String search = req.getParameter("search");
        List<Booking> bookings;
        if (search != null && !search.trim().isEmpty()) {
            bookings = bookingDAO.searchBookings(search.trim());
        } else {
            bookings = bookingDAO.getRecentNotifications(50);
        }
        
        req.setAttribute("bookings", bookings);
        req.setAttribute("active", "bookings"); // Pass to sidebar via neural_shell_top
        
        req.getRequestDispatcher("/admin/manageBookings.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String bookingIdStr = req.getParameter("bookingId");
        
        if (action != null && bookingIdStr != null) {
            try {
                int bookingId = Integer.parseInt(bookingIdStr);
                boolean success = false;
                
                switch (action) {
                    case "update":
                        Booking b = bookingDAO.find(bookingId);
                        if (b != null) {
                            try {
                                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                b.setCheckInDate(sdf.parse(req.getParameter("checkIn")));
                                b.setCheckOutDate(sdf.parse(req.getParameter("checkOut")));
                                b.setStatus(req.getParameter("status"));
                                success = bookingDAO.update(b);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                        break;
                    case "confirm":
                        success = bookingDAO.confirm(bookingId);
                        break;
                    case "cancel":
                        success = bookingDAO.updateBookingAndRoomStatus(bookingId, "Cancelled", "Available");
                        break;
                    case "checkin":
                        success = bookingDAO.updateBookingAndRoomStatus(bookingId, "Checked-in", "Occupied");
                        break;
                    case "checkout":
                        success = bookingDAO.updateBookingAndRoomStatus(bookingId, "Completed", "Available");
                        break;
                    default:
                        System.out.println("Unknown action: " + action);
                }
                
                if (success) {
                    String msgKey = action.substring(0, 1).toUpperCase() + action.substring(1).toLowerCase() + "Success";
                    resp.sendRedirect(req.getContextPath() + "/admin/bookings?msg=" + msgKey);
                    return;
                }
            } catch (NumberFormatException e) {
                System.err.println("Invalid bookingIdStr: " + bookingIdStr);
            } catch (Exception e) {
                System.out.println("[AdminBookingServlet] Error performing action: " + action);
                e.printStackTrace();
            }
        }
        
        String errKey = (action != null ? action.substring(0, 1).toUpperCase() + action.substring(1).toLowerCase() : "Action") + "Failed";
        resp.sendRedirect(req.getContextPath() + "/admin/bookings?err=" + errKey);
    }
}
