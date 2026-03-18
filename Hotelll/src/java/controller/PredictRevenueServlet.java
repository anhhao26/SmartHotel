/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

/**
 *
 * @author ntpho
 */
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "PredictRevenueServlet", urlPatterns = {"/predict-revenue"})
public class PredictRevenueServlet extends HttpServlet {

    // Hàm phụ kết nối API Python
    private String fetchApiData(String apiUrl) {
        StringBuilder jsonResult = new StringBuilder();
        try {
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Accept", "application/json");

            if (conn.getResponseCode() == 200) {
                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
                String line;
                while ((line = br.readLine()) != null) {
                    jsonResult.append(line);
                }
                br.close();
            } else {
                // Đọc Error Stream của Python để lấy được câu thông báo lỗi
                if (conn.getErrorStream() != null) {
                    BufferedReader br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "utf-8"));
                    String line;
                    while ((line = br.readLine()) != null) {
                        jsonResult.append(line);
                    }
                    br.close();
                } else {
                    jsonResult.append("{\"status\":\"error\", \"message\":\"Lỗi không xác định từ Server AI\"}");
                }
            }
            conn.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
            jsonResult.append("{\"status\":\"error\", \"message\":\"Không thể kết nối đến AI Server (" + e.getMessage() + ")\"}");
        }
        return jsonResult.toString();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        
        // [CẤU HÌNH DEPLOY] Lấy Base URL của AI API từ Biến môi trường (Environment Variable)
        // Nếu không có biến môi trường (Chạy local), mặc định sẽ sử dụng http://127.0.0.1:5000
        String aiApiBaseUrl = System.getenv("AI_API_BASE_URL");
        if (aiApiBaseUrl == null || aiApiBaseUrl.trim().isEmpty()) {
            aiApiBaseUrl = "https://smarthotel-ai-api.onrender.com";
        }
        
        // 1. Gọi API Doanh thu
        String revenueData = fetchApiData(aiApiBaseUrl + "/api/predict-revenue"); 
        // 2. Gọi API Số lượng phòng
        String bookingData = fetchApiData(aiApiBaseUrl + "/api/predict-bookings");

        // Đẩy 2 cục JSON sang thư mục JSP
        request.setAttribute("revenueData", revenueData);
        request.setAttribute("bookingData", bookingData);
        
        request.getRequestDispatcher("AI/predict-revenue.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
