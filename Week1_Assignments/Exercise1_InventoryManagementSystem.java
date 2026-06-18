import java.util.HashMap;

// Exercise 1 - Inventory Management System
// Using HashMap to store products because it gives O(1) for add, update, delete operations
// ArrayList would give O(n) for search/delete so HashMap is better here

public class Exercise1_InventoryManagementSystem {

    // Product class
    static class Product {
        int productId;
        String productName;
        int quantity;
        double price;

        Product(int productId, String productName, int quantity, double price) {
            this.productId = productId;
            this.productName = productName;
            this.quantity = quantity;
            this.price = price;
        }

        public String toString() {
            return "ID: " + productId + ", Name: " + productName + ", Qty: " + quantity + ", Price: " + price;
        }
    }

    // using HashMap - key is productId, value is Product object
    private HashMap<Integer, Product> inventory = new HashMap<>();

    // add product - O(1) average time
    public void addProduct(Product p) {
        if (inventory.containsKey(p.productId)) {
            System.out.println("Product already exists with ID: " + p.productId);
            return;
        }
        inventory.put(p.productId, p);
        System.out.println("Added: " + p);
    }

    // update product - O(1) average time
    public void updateProduct(int id, String name, int qty, double price) {
        Product p = inventory.get(id);
        if (p == null) {
            System.out.println("Product not found with ID: " + id);
            return;
        }
        p.productName = name;
        p.quantity = qty;
        p.price = price;
        System.out.println("Updated: " + p);
    }

    // delete product - O(1) average time
    public void deleteProduct(int id) {
        if (inventory.remove(id) != null) {
            System.out.println("Deleted product with ID: " + id);
        } else {
            System.out.println("Product not found with ID: " + id);
        }
    }

    // display all
    public void displayAll() {
        System.out.println("\n--- Inventory ---");
        for (Product p : inventory.values()) {
            System.out.println(p);
        }
        System.out.println("-----------------\n");
    }

    public static void main(String[] args) {
        Exercise1_InventoryManagementSystem sys = new Exercise1_InventoryManagementSystem();

        sys.addProduct(new Product(101, "Laptop", 50, 899.99));
        sys.addProduct(new Product(102, "Mouse", 200, 19.99));
        sys.addProduct(new Product(103, "Keyboard", 150, 49.99));

        sys.displayAll();

        sys.updateProduct(102, "Wireless Mouse", 180, 29.99);
        sys.deleteProduct(103);

        sys.displayAll();

        // trying duplicate
        sys.addProduct(new Product(101, "Laptop Pro", 30, 1299.99));
    }
}

/*
 Analysis:
 - We used HashMap because all operations (add, update, delete) are O(1) on average.
 - Worst case can be O(n) if there are too many hash collisions, but this is rare.
 - ArrayList would need O(n) to search for a product before updating or deleting.
 - To optimize further, we can set initial capacity of HashMap to reduce rehashing.
*/
