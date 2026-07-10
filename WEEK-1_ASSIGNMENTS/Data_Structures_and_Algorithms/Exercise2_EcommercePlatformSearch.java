import java.util.Arrays;
import java.util.Comparator;

// Exercise 2 - E-commerce Platform Search Function
// Implementing linear search and binary search and comparing them

public class Exercise2_EcommercePlatformSearch {

    static class Product {
        int productId;
        String productName;
        String category;

        Product(int productId, String productName, String category) {
            this.productId = productId;
            this.productName = productName;
            this.category = category;
        }

        public String toString() {
            return "ID: " + productId + ", Name: " + productName + ", Category: " + category;
        }
    }

    // Linear Search - just go through each element one by one
    // Time: Best O(1), Average O(n), Worst O(n)
    public static Product linearSearch(Product[] products, int targetId) {
        for (int i = 0; i < products.length; i++) {
            if (products[i].productId == targetId) {
                return products[i];
            }
        }
        return null;
    }

    // Binary Search - array must be sorted by productId first
    // Time: Best O(1), Average O(log n), Worst O(log n)
    public static Product binarySearch(Product[] products, int targetId) {
        int low = 0, high = products.length - 1;

        while (low <= high) {
            int mid = (low + high) / 2;

            if (products[mid].productId == targetId) {
                return products[mid];
            } else if (products[mid].productId < targetId) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return null;
    }

    public static void main(String[] args) {
        Product[] products = {
            new Product(105, "Smartphone", "Electronics"),
            new Product(203, "Running Shoes", "Footwear"),
            new Product(102, "Laptop", "Electronics"),
            new Product(310, "Desk Lamp", "Home"),
            new Product(150, "Headphones", "Electronics")
        };

        // Linear search works on unsorted array
        System.out.println("--- Linear Search ---");
        Product result = linearSearch(products, 150);
        System.out.println("Search ID 150: " + (result != null ? result : "Not Found"));

        result = linearSearch(products, 999);
        System.out.println("Search ID 999: " + (result != null ? result : "Not Found"));

        // For binary search, we need to sort first
        Arrays.sort(products, Comparator.comparingInt(p -> p.productId));

        System.out.println("\n--- Binary Search (sorted array) ---");
        result = binarySearch(products, 203);
        System.out.println("Search ID 203: " + (result != null ? result : "Not Found"));

        result = binarySearch(products, 500);
        System.out.println("Search ID 500: " + (result != null ? result : "Not Found"));
    }
}

/*
 Analysis:
 - Linear search is O(n) - checks every element, works on unsorted data
 - Binary search is O(log n) - much faster but needs sorted data
 - For e-commerce with lakhs of products, binary search is better
 - Example: 1 million products -> linear takes 1000000 comparisons, binary takes only ~20
 - But we need to maintain sorted order which costs O(n log n) when adding new products
 
 Big O Notation: It describes the upper bound of time/space complexity as input grows.
 It helps us compare algorithms without running them on actual hardware.
*/
