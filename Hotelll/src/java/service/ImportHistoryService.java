package com.smarthotel.service;

import com.smarthotel.dao.ImportHistoryDAO;
import com.smarthotel.model.ImportHistory;
import java.util.List;

public class ImportHistoryService {
    private ImportHistoryDAO dao = new ImportHistoryDAO();

    public List<ImportHistory> findAll() { return dao.findAll(); }
    
    public List<Object[]> getTopImportedProducts(int month, int year) {
        return dao.getTopImportedProducts(month, year);
    }
}