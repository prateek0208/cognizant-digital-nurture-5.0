// Testing Dependency Injection
public class DependencyInjectionTest {
    public static void main(String[] args) {
        // Create the repository
        CustomerRepository repo = new CustomerRepositoryImpl();

        // Inject it into the service
        CustomerService service = new CustomerService(repo);

        // Query some customers
        System.out.println("Customer 1: " + service.getCustomer(1));
        System.out.println("Customer 2: " + service.getCustomer(2));
        System.out.println("Customer 3: " + service.getCustomer(3));
        System.out.println("Customer 5: " + service.getCustomer(5));
    }
}
