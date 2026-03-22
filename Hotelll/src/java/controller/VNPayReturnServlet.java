package controller;

import dao.BookingDAO;
import dao.AccountDAO;
import model.Booking;
import util.EmailUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/vnpay_return")
public class VNPayReturnServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        response.getWriter().println("RETURN OK");
    }
}