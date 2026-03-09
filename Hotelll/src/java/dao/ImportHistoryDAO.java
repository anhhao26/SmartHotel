/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author ntpho
 */
import com.smarthotel.model.ImportHistory;
import com.smarthotel.util.JPAUtil;
import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class ImportHistoryDAO {

   
    public List<ImportHistory> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT i FROM ImportHistory i ORDER BY i.importDate DESC", ImportHistory.class).getResultList();
        } finally {
            em.close();
        }
    }

    // Lấy thống kê: Sản phẩm nào nhập nhiều nhất trong THÁNG / NĂM
    // Trả về List<Object[]>: Object[0] là Entity Product, Object[1] là Tổng số lượng (Long)
    public List<Object[]> getTopImportedProducts(int month, int year) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            //Gom nhóm theo Sản phẩm, Tính tổng số lượng, Lọc theo Tháng/Năm, Sắp xếp giảm dần
            String jpql = "SELECT i.product, SUM(i.importQuantity) " +
                          "FROM ImportHistory i " +
                          "WHERE FUNCTION('MONTH', i.importDate) = :month " +
                          "AND FUNCTION('YEAR', i.importDate) = :year " +
                          "GROUP BY i.product " +
                          "ORDER BY SUM(i.importQuantity) DESC";
            
            return em.createQuery(jpql, Object[].class)
                     .setParameter("month", month)
                     .setParameter("year", year)
                     .getResultList();
        } finally {
            em.close();
        }
    }
}