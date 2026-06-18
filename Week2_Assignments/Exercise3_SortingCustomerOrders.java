// Exercise 3 - Sorting Customer Orders
// Implementing Bubble Sort and Quick Sort to sort orders by totalPrice

public class Exercise3_SortingCustomerOrders {

    static class Order {
        int orderId;
        String customerName;
        double totalPrice;

        Order(int orderId, String customerName, double totalPrice) {
            this.orderId = orderId;
            this.customerName = customerName;
            this.totalPrice = totalPrice;
        }

        public String toString() {
            return "OrderID: " + orderId + ", Customer: " + customerName + ", Total: $" + totalPrice;
        }
    }

    // Bubble Sort - compare adjacent elements and swap if needed
    // Time: O(n^2) average and worst case
    public static void bubbleSort(Order[] orders) {
        int n = orders.length;

        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - 1 - i; j++) {
                if (orders[j].totalPrice > orders[j + 1].totalPrice) {
                    // swap
                    Order temp = orders[j];
                    orders[j] = orders[j + 1];
                    orders[j + 1] = temp;
                }
            }
        }
    }

    // Quick Sort - pick pivot, partition, sort left and right
    // Time: O(n log n) average, O(n^2) worst case
    public static void quickSort(Order[] orders, int low, int high) {
        if (low < high) {
            int pi = partition(orders, low, high);
            quickSort(orders, low, pi - 1);
            quickSort(orders, pi + 1, high);
        }
    }

    private static int partition(Order[] orders, int low, int high) {
        double pivot = orders[high].totalPrice;
        int i = low - 1;

        for (int j = low; j < high; j++) {
            if (orders[j].totalPrice <= pivot) {
                i++;
                Order temp = orders[i];
                orders[i] = orders[j];
                orders[j] = temp;
            }
        }

        // put pivot in correct position
        Order temp = orders[i + 1];
        orders[i + 1] = orders[high];
        orders[high] = temp;
        return i + 1;
    }

    // helper to print orders
    static void printOrders(Order[] orders) {
        for (Order o : orders) {
            System.out.println("  " + o);
        }
    }

    public static void main(String[] args) {
        Order[] orders = {
            new Order(1, "Alice", 250.00),
            new Order(2, "Bob", 45.50),
            new Order(3, "Charlie", 120.75),
            new Order(4, "Diana", 520.00),
            new Order(5, "Eve", 89.99)
        };

        System.out.println("Original Orders:");
        printOrders(orders);

        // making a copy for bubble sort
        Order[] bubbleCopy = orders.clone();
        bubbleSort(bubbleCopy);
        System.out.println("\nAfter Bubble Sort:");
        printOrders(bubbleCopy);

        // making a copy for quick sort
        Order[] quickCopy = orders.clone();
        quickSort(quickCopy, 0, quickCopy.length - 1);
        System.out.println("\nAfter Quick Sort:");
        printOrders(quickCopy);
    }
}

/*
 Analysis:
 - Bubble Sort: O(n^2) - slow, compares every pair, lots of swaps
 - Quick Sort: O(n log n) average - much faster for large data
 - Quick Sort is preferred because:
   1. It divides the problem into smaller parts (divide and conquer)
   2. Average case is O(n log n) which is way better than O(n^2)
   3. It sorts in-place so no extra memory needed
   4. Worst case O(n^2) is rare and can be avoided with random pivot
 
 Other sorting algorithms:
 - Insertion Sort: O(n^2) - good for small/nearly sorted data
 - Merge Sort: O(n log n) always - but needs extra space
*/
