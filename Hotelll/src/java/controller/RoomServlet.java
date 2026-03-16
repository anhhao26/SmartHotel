package controller;

import model.Room;
import model.RoomType;
import service.RoomService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@WebServlet(name = "RoomServlet", urlPatterns = {"/RoomServlet"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB 
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class RoomServlet extends HttpServlet {

    private final RoomService roomService = new RoomService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        List<RoomType> typeList = roomService.getAllRoomTypes(); 
        request.setAttribute("typeList", typeList);

        String statusFilter = request.getParameter("status");
        String search = request.getParameter("search");
        List<Room> list;
        
        if (search != null && !search.trim().isEmpty()) {
            list = roomService.searchRooms(search.trim());
        } else if (statusFilter != null && !statusFilter.isEmpty() && !"All".equals(statusFilter)) {
            list = roomService.getRoomsByStatus(statusFilter);
        } else {
            list = roomService.getRoomBoard(); 
        }

        request.setAttribute("roomList", list);
        request.getRequestDispatcher("/WEB-INF/Room.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("changeStatus".equals(action)) {
            String roomId = request.getParameter("roomId");
            String newStatus = request.getParameter("newStatus"); 
            if (roomId != null && newStatus != null) {
                String result = roomService.changeRoomStatus(roomId, newStatus);
                if ("OK".equals(result)) request.setAttribute("successMessage", "Đã cập nhật trạng thái phòng " + roomId + " thành " + newStatus);
                else request.setAttribute("errorMessage", result); 
            }
        } 
        else if ("addRoom".equals(action)) {
            String roomId = request.getParameter("roomId"); // Lưu ý: parameter trên jsp gửi roomId nhưng nó là roomNumber
            int typeId = Integer.parseInt(request.getParameter("typeId"));
            int floor = Integer.parseInt(request.getParameter("floor"));
            double price = Double.parseDouble(request.getParameter("price"));
            boolean success = roomService.addNewRoom(roomId, typeId, floor, price);
            if (success) request.setAttribute("successMessage", "Đã tạo phòng " + roomId + " thành công!");
            else request.setAttribute("errorMessage", "Lỗi: Không thể tạo phòng (Kiểm tra lại mã phòng).");
        }
        else if ("updatePrice".equals(action)) {
            String roomId = request.getParameter("roomId"); 
            double newPrice = Double.parseDouble(request.getParameter("newPrice"));
            boolean success = roomService.updateRoomPrice(roomId, newPrice);
            if (success) request.setAttribute("successMessage", "Đã cập nhật giá mới cho phòng " + roomId);
            else request.setAttribute("errorMessage", "Lỗi: Không tìm thấy phòng hoặc giá không hợp lệ.");
        }
        else if ("deleteRoom".equals(action)) {
            String roomId = request.getParameter("roomId");
            if (roomService.deleteRoom(roomId)) request.setAttribute("successMessage", "Đã xóa phòng thành công!");
            else request.setAttribute("errorMessage", "Lỗi: Chỉ được xóa phòng Trống!");
        }
        else if ("updateRoomInfo".equals(action)) {
            String roomId = request.getParameter("roomId");
            int typeId = Integer.parseInt(request.getParameter("typeId"));
            double price = Double.parseDouble(request.getParameter("price"));
            
            if (roomService.updateRoomInfo(roomId, typeId, price)) request.setAttribute("successMessage", "Cập nhật thành công!");
            else request.setAttribute("errorMessage", "Cập nhật thất bại.");
        }
        else if ("deleteImage".equals(action)) {
            int imageId = Integer.parseInt(request.getParameter("imageId"));
            if (roomService.deleteRoomImage(imageId)) request.setAttribute("successMessage", "Đã xóa bức ảnh khỏi hệ thống.");
            else request.setAttribute("errorMessage", "Lỗi: Không thể xóa ảnh này.");
        }
        else if ("uploadRoomImage".equals(action)) {
            try {
                String roomId = request.getParameter("roomId");
                Part filePart = request.getPart("file"); 
                
                if (filePart != null && filePart.getSize() > 0) {
                    String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String uniqueFileName = java.util.UUID.randomUUID().toString() + "_" + originalFileName;

                    // Lưu file vào thư mục assets/images trong project của bạn
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "images";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdirs();

                    filePart.write(uploadPath + File.separator + uniqueFileName);
                    
                    String imageUrlForDatabase = "assets/images/" + uniqueFileName;
                    roomService.addRoomImage(roomId, imageUrlForDatabase, false); 
                    
                    request.setAttribute("successMessage", "Đã tải ảnh thành công!");
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Lỗi tải ảnh: " + e.getMessage());
            }
            response.sendRedirect("RoomServlet");
            return;
        }
        else if ("setPrimaryImage".equals(action)) {
            String roomId = request.getParameter("roomId");
            String imageUrl = request.getParameter("imageUrl");
            roomService.setPrimaryImage(roomId, imageUrl);
            response.sendRedirect("RoomServlet"); 
            return;
        }

        doGet(request, response);
    }
}