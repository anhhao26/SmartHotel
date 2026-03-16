package service;

import dao.InventoryDAO;
import model.Inventory;
import java.util.List;

public class InventoryService {
    private final InventoryDAO inventoryDAO = new InventoryDAO();

    public List<Inventory> findAll() { return inventoryDAO.findAll(); }
    public List<Inventory> findActiveOnly() { return inventoryDAO.findActiveOnly(); }
    public Inventory findById(int id) { return inventoryDAO.find(id); }

    public void createNewInventory(Inventory p) {
        if (p.getIsTradeGood() != null && !p.getIsTradeGood()) {
            p.setSellingPrice(0.0);
        }
        inventoryDAO.createNewInventory(p);
    }

    public void updateInventoryInfo(Inventory p) {
        if (p.getIsTradeGood() != null && !p.getIsTradeGood()) {
            p.setSellingPrice(0.0);
        }
        inventoryDAO.updateInventoryInfo(p);
    }

    public void importStock(int itemId, int quantityToAdd, double newCostPrice) {
        if (quantityToAdd <= 0 || newCostPrice < 0) return;
        inventoryDAO.importStock(itemId, quantityToAdd, newCostPrice);
    }

    public void softDelete(int id) { inventoryDAO.softDelete(id); }
    public void hardDelete(int id) { inventoryDAO.hardDelete(id); }
    public void restore(int id) { inventoryDAO.restore(id); }
}