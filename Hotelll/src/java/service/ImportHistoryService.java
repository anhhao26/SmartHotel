/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

/**
 *
 * @author ntpho
 */
import com.smarthotel.model.ImportHistory;
import java.util.List;

public interface ImportHistoryService {
    List<ImportHistory> findAll();
    // Hàm thống kê lấy Object mảng (Sản phẩm, Tổng số lượng)
    List<Object[]> getTopImportedProducts(int month, int year);
}