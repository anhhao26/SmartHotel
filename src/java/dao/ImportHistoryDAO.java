package com.smarthotel.dao;

import com.smarthotel.model.ImportHistory;
import com.smarthotel.util.JPAUtil;
import jakarta.persistence.EntityManager;
import java.util.List;

public class ImportHistoryDAO {

    public List<ImportHistory> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT i FROM ImportHistory i ORDER BY i.importDate DESC", ImportHistory.class).getResultList();
        } finally {
            em.close();
        }
    }

    public List<Object[]> getTopImportedProducts(int month, int year) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT i.inventory, SUM(i.importQuantity) " +
                          "FROM ImportHistory i " +
                          "WHERE FUNCTION('MONTH', i.importDate) = :month " +
                          "AND FUNCTION('YEAR', i.importDate) = :year " +
                          "GROUP BY i.inventory " +
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