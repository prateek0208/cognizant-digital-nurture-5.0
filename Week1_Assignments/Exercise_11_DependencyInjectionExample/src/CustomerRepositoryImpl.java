import java.util.HashMap;
import java.util.Map;

// HashMap-backed implementation of the repository
public class CustomerRepositoryImpl implements CustomerRepository {
    private Map<Integer, String> customers;

    public CustomerRepositoryImpl() {
        customers = new HashMap<>();
        // Some sample data
        customers.put(1, "Alice");
        customers.put(2, "Bob");
        customers.put(3, "Charlie");
    }

    @Override
    public String findCustomerById(int id) {
        return customers.getOrDefault(id, "Customer not found");
    }
}
