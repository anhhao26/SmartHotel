package service;

import dao.CustomerDAO;
import model.Customer;
import java.util.List;

public class CustomerService {
    private final CustomerDAO dao = new CustomerDAO();

    public Customer getById(int id) { 
        return dao.findById(id); 
    }

    public List<Customer> findAll() {
        return dao.findAll();
    }

    public List<Customer> searchCustomers(String query) {
        return dao.searchCustomers(query);
    }

    public Customer create(Customer c) { 
        return dao.create(c); 
    }

    public boolean update(Customer c) { 
        return dao.update(c); 
    }

    public boolean existsUnique(String cccd, String phone, String email) { 
        return dao.existsByUniqueFields(cccd, phone, email); 
    }
}