# Cognizant Digital Nurture 5.0

This repository contains my assignments for the **Cognizant Digital Nurture 5.0** training program.

## Week 1 - Design Patterns

This section contains solutions covering various Design Patterns.

### Exercises Overview

1. **Singleton Pattern**: Implemented a logging utility class (`Logger`) that ensures only one instance is created throughout the application lifecycle to maintain consistent logging.
2. **Factory Method Pattern**: Developed a document management system to create different types of documents (Word, PDF, Excel) using a unified factory interface.
3. **Builder Pattern**: Created a system to construct complex `Computer` objects with multiple optional parts (CPU, RAM, Storage, Graphics Card, etc.) systematically.
4. **Adapter Pattern**: Built a payment processing system that integrates seamlessly with multiple third-party payment gateways (PayPal, Stripe, Square) despite them having different interfaces.
5. **Decorator Pattern**: Implemented a notification system where additional messaging channels (SMS, Slack) can be stacked and added dynamically to a base Email notifier.
6. **Proxy Pattern**: Developed an image viewer application that uses a proxy to add lazy initialization and caching when loading high-resolution images from a remote server.
7. **Observer Pattern**: Created a stock market monitoring application where multiple client displays (Mobile App, Web App) are automatically notified whenever stock prices change.
8. **Strategy Pattern**: Built a flexible payment system where different payment algorithms (Credit Card, PayPal) can be selected and swapped out at runtime.
9. **Command Pattern**: Implemented a home automation system where requests (like turning a Light on or off) are encapsulated as objects, allowing them to be triggered via a generic Remote Control invoker.
10. **MVC (Model-View-Controller) Pattern**: Designed the architecture for a simple student records application separating the data (Student), presentation (StudentView), and logic (StudentController).
11. **Dependency Injection**: Developed a customer management service that relies on a repository interface, where the concrete repository implementation is injected via the constructor, decoupling the components.

## Week 2 - Data Structures and Algorithms in Java

| Exercise | Topic | Concepts Covered |
|----------|-------|-----------------|
| Exercise 1 | Inventory Management System | HashMap, CRUD operations, O(1) lookups |
| Exercise 2 | E-commerce Platform Search | Linear Search, Binary Search, Big O Notation |
| Exercise 3 | Sorting Customer Orders | Bubble Sort, Quick Sort, Time Complexity |
| Exercise 4 | Employee Management System | Arrays, Memory Representation, CRUD with Arrays |
| Exercise 5 | Task Management System | Singly Linked List, Dynamic Data Structures |
| Exercise 6 | Library Management System | Search Algorithms on Strings (Book Titles) |
| Exercise 7 | Financial Forecasting | Recursion, Iterative Optimization |

## How to Run

1. Make sure you have **Java JDK** installed
2. Open terminal in the exercise folder
3. Compile and run:
```bash
javac Exercise1_InventoryManagementSystem.java
java Exercise1_InventoryManagementSystem
```

## Tech Stack
- Java
- Data Structures & Algorithms
- Design Patterns
