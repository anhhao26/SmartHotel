package controller;

import model.Inventory;
import model.Supplier;
import service.InventoryService;
import service.SupplierService;
import service.ImportHistoryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.time.LocalDate;

@WebServlet(name = "InventoryServlet", urlPatterns = {"/products"})
public class InventoryServlet extends HttpServlet {

    private final InventoryService inventoryService = new InventoryService();
    private final SupplierService supplierService = new SupplierService();
    private final ImportHistoryService historyService = new ImportHistoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "new": showNewForm(request, response); break;
                case "edit": showEditForm(request, response); break;
                case "import": showImportForm(request, response); break;
                case "listSuppliers": listSuppliers(request, response); break;
                case "newSupplier": showSupplierForm(request, response); break;
                case "editSupplier": showEditSupplierForm(request, response); break;
                case "deleteSupplier": deleteSupplier(request, response); break;
                case "history": showImportHistory(request, response); break; 
                default: listProducts(request, response); break;
            }
        } catch (Exception ex) { throw new ServletException(ex); }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "insert": insertProduct(request, response); break;
                case "update": updateProduct(request, response); break;
                case "saveImport": saveImport(request, response); break;
                case "softDelete": softDeleteProduct(request, response); break;
                case "restore": restoreProduct(request, response); break;
                case "hardDelete": hardDeleteProduct(request, response); break;
                case "saveSupplier": saveSupplier(request, response); break;
                default: response.sendRedirect("products"); break;
            }
        } catch (Exception ex) { throw new ServletException(ex); }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String showHidden = request.getParameter("showHidden");
        List<Inventory> listProducts;
        if ("true".equals(showHidden)) {
            listProducts = inventoryService.findAll();
        } else {
            listProducts = inventoryService.findActiveOnly();
        }
        request.setAttribute("listProducts", listProducts);
        request.setAttribute("isShowHidden", "true".equals(showHidden));
        request.getRequestDispatcher("WEB-INF/Product/product-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("listSuppliers", supplierService.findAll());
        request.getRequestDispatcher("WEB-INF/Product/product-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = parseIdSafe(request.getParameter("id"));
        if (id == -1) { response.sendRedirect("products"); return; }
        request.setAttribute("product", inventoryService.findById(id));
        request.setAttribute("listSuppliers", supplierService.findAll());
        request.getRequestDispatcher("WEB-INF/Product/product-form.jsp").forward(request, response);
    }

    private void showImportForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = parseIdSafe(request.getParameter("id"));
        if (id == -1) { response.sendRedirect("products"); return; }
        request.setAttribute("product", inventoryService.findById(id));
        request.getRequestDispatcher("WEB-INF/Product/import-form.jsp").forward(request, response);
    }

    private void listSuppliers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("listSuppliers", supplierService.findAll());
        request.getRequestDispatcher("WEB-INF/Product/supplier-list.jsp").forward(request, response);
    }

    private void showSupplierForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/Product/supplier-form.jsp").forward(request, response);
    }

    private void showEditSupplierForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = parseIdSafe(request.getParameter("id"));
        if (id == -1) { response.sendRedirect("products?action=listSuppliers"); return; }
        request.setAttribute("supplier", supplierService.findById(id));
        request.getRequestDispatcher("WEB-INF/Product/supplier-form.jsp").forward(request, response);
    }

    private void showImportHistory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String monthStr = request.getParameter("monthPicker");
        int month, year;

        if (monthStr != null && !monthStr.isEmpty()) {
            String[] parts = monthStr.split("-");
            year = Integer.parseInt(parts[0]);
            month = Integer.parseInt(parts[1]);
        } else {
            LocalDate now = LocalDate.now();
            year = now.getYear();
            month = now.getMonthValue();
            monthStr = String.format("%04d-%02d", year, month); 
        }

        List<Object[]> stats = historyService.getTopImportedProducts(month, year);
        request.setAttribute("importStats", stats);
        request.setAttribute("selectedMonth", monthStr);
        request.getRequestDispatcher("WEB-INF/Product/import-history.jsp").forward(request, response);
    }

    private void saveSupplier(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idStr = request.getParameter("id");
        Supplier s = new Supplier();
        if (idStr != null && !idStr.isEmpty()) s.setSupplierID(Integer.parseInt(idStr));
        s.setSupplierName(request.getParameter("name"));
        s.setContactPhone(request.getParameter("phone"));
        s.setAddress(request.getParameter("address"));
        supplierService.save(s);
        response.sendRedirect("products?action=listSuppliers");
    }

    private void deleteSupplier(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = parseIdSafe(request.getParameter("id"));
            if (id != -1) supplierService.delete(id);
            response.sendRedirect("products?action=listSuppliers");
        } catch (Exception e) {
            response.sendRedirect("products?action=listSuppliers&error=CannotDelete");
        }
    }

    private void insertProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Inventory newProduct = new Inventory();
        newProduct.setItemName(request.getParameter("name"));
        newProduct.setUnit(request.getParameter("unit"));
        newProduct.setQuantity(Integer.parseInt(request.getParameter("quantity")));
        newProduct.setCostPrice(Double.parseDouble(request.getParameter("costPrice")));
        
        boolean isTradeNew = "1".equals(request.getParameter("isTradeGood"));
        newProduct.setIsTradeGood(isTradeNew);
        newProduct.setSellingPrice(isTradeNew ? Double.parseDouble(request.getParameter("sellingPrice")) : 0.0);
        newProduct.setIsActive(true);

        Supplier sNew = new Supplier();
        sNew.setSupplierID(Integer.parseInt(request.getParameter("supplierID")));
        newProduct.setSupplier(sNew);
        
        inventoryService.createNewInventory(newProduct);
        response.sendRedirect("products");
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = parseIdSafe(request.getParameter("id"));
        if (id == -1) { response.sendRedirect("products"); return; }
        
        Inventory updateProduct = new Inventory();
        updateProduct.setItemID(id);
        updateProduct.setItemName(request.getParameter("name"));
        updateProduct.setUnit(request.getParameter("unit"));
        
        boolean isTradeUpdate = "1".equals(request.getParameter("isTradeGood"));
        updateProduct.setIsTradeGood(isTradeUpdate);
        updateProduct.setSellingPrice(isTradeUpdate ? Double.parseDouble(request.getParameter("sellingPrice")) : 0.0);
        
        Supplier sUpdate = new Supplier();
        sUpdate.setSupplierID(Integer.parseInt(request.getParameter("supplierID")));
        updateProduct.setSupplier(sUpdate);
        
        inventoryService.updateInventoryInfo(updateProduct);
        response.sendRedirect("products");
    }

    private void saveImport(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int idImport = parseIdSafe(request.getParameter("id"));
        if (idImport == -1) { response.sendRedirect("products"); return; }
        int qtyToAdd = Integer.parseInt(request.getParameter("quantityToAdd"));
        double newCost = Double.parseDouble(request.getParameter("newCostPrice"));
        inventoryService.importStock(idImport, qtyToAdd, newCost);
        response.sendRedirect("products");
    }

    private void softDeleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = parseIdSafe(request.getParameter("id"));
        if (id != -1) inventoryService.softDelete(id);
        response.sendRedirect("products");
    }

    private void restoreProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = parseIdSafe(request.getParameter("id"));
        if (id != -1) inventoryService.restore(id);
        response.sendRedirect("products?showHidden=true");
    }

    private void hardDeleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = parseIdSafe(request.getParameter("id"));
        if (id != -1) inventoryService.hardDelete(id);
        response.sendRedirect("products");
    }

    private int parseIdSafe(String idStr) {
        if (idStr == null || idStr.trim().isEmpty()) return -1;
        try { return Integer.parseInt(idStr); } 
        catch (NumberFormatException e) { return -1; }
    }
}