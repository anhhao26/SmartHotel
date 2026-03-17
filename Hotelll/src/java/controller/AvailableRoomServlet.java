package controller;

import dao.RoomDAO;
import model.Room;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name="AvailableRoomServlet", urlPatterns = {"/rooms"})
public class AvailableRoomServlet extends HttpServlet {

    private final RoomDAO dao = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String search = req.getParameter("search");
        List<Room> rooms;
        
        if (search != null && !search.trim().isEmpty()) {
            rooms = dao.searchRooms(search.trim());
        } else {
            rooms = dao.findAllRooms();
        }

        req.setAttribute("rooms", rooms);
        req.getRequestDispatcher("/WEB-INF/rooms.jsp").forward(req, resp);
    }
}