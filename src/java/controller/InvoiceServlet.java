package controller;

import model.Invoice;
import util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "InvoiceServlet", urlPatterns = {"/invoice"})
public class InvoiceServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingId = request.getParameter("bookingId");
        String invoiceId = request.getParameter("invoiceId");

        if ((bookingId == null || bookingId.isEmpty()) && (invoiceId == null || invoiceId.isEmpty())) {
            response.sendRedirect(request.getContextPath() + "/admin/bookings");
            return;
        }

        // If we only have bookingId, we try to find the invoice associated with it
        if (invoiceId == null || invoiceId.isEmpty()) {
            EntityManager em = JPAUtil.getEntityManager();
            try {
                // Try finding invoice first
                TypedQuery<Invoice> query = em.createQuery("SELECT i FROM Invoice i WHERE i.booking.bookingID = :bid", Invoice.class);
                query.setParameter("bid", Integer.parseInt(bookingId));
                List<Invoice> results = query.getResultList();
                if (!results.isEmpty()) {
                    request.setAttribute("foundInvoice", results.get(0));
                } else {
                    // Fallback: Find the booking itself to show details
                    model.Booking b = em.find(model.Booking.class, Integer.parseInt(bookingId));
                    if (b != null) {
                        request.setAttribute("foundBooking", b);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                em.close();
            }
        }

        request.getRequestDispatcher("/reception/invoice.jsp").forward(request, response);
    }
}
