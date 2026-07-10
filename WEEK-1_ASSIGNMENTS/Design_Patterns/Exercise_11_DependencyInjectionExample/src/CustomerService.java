// Service that depends on a repository (injected via constructor)
public class CustomerService {
    private CustomerRepository repo;

    // Constructor injection
    public CustomerService(CustomerRepository repo) {
        this.repo = repo;
    }

    public String getCustomer(int id) {
        return repo.findCustomerById(id);
    }
}
