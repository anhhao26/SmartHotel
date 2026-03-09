/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

/**
 *
 * @author ntpho
 */

import dao.ImportHistoryDAO;
import com.smarthotel.model.ImportHistory;
import java.util.List;

public class ImportHistoryServiceImpl implements ImportHistoryService {
    private ImportHistoryDAO dao;

    public ImportHistoryServiceImpl() {
        this.dao = new ImportHistoryDAO();
    }

    @Override
    public List<ImportHistory> findAll() {
        return dao.findAll();
    }

    @Override
    public List<Object[]> getTopImportedProducts(int month, int year) {
        return dao.getTopImportedProducts(month, year);
    }
}