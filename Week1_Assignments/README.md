# Week 1 Assignments: Design Patterns

This directory contains the solutions for the Week 1 assignments covering various Design Patterns as part of the Cognizant Digital Nurture 5.0 program.

## Exercises Overview

### 1. Singleton Pattern
Implemented a logging utility class (`Logger`) that ensures only one instance is created throughout the application lifecycle to maintain consistent logging.

### 2. Factory Method Pattern
Developed a document management system to create different types of documents (Word, PDF, Excel) using a unified factory interface.

### 3. Builder Pattern
Created a system to construct complex `Computer` objects with multiple optional parts (CPU, RAM, Storage, Graphics Card, etc.) systematically.

### 4. Adapter Pattern
Built a payment processing system that integrates seamlessly with multiple third-party payment gateways (PayPal, Stripe, Square) despite them having different interfaces.

### 5. Decorator Pattern
Implemented a notification system where additional messaging channels (SMS, Slack) can be stacked and added dynamically to a base Email notifier.

### 6. Proxy Pattern
Developed an image viewer application that uses a proxy to add lazy initialization and caching when loading high-resolution images from a remote server.

### 7. Observer Pattern
Created a stock market monitoring application where multiple client displays (Mobile App, Web App) are automatically notified whenever stock prices change.

### 8. Strategy Pattern
Built a flexible payment system where different payment algorithms (Credit Card, PayPal) can be selected and swapped out at runtime.

### 9. Command Pattern
Implemented a home automation system where requests (like turning a Light on or off) are encapsulated as objects, allowing them to be triggered via a generic Remote Control invoker.

### 10. MVC (Model-View-Controller) Pattern
Designed the architecture for a simple student records application separating the data (Student), presentation (StudentView), and logic (StudentController).

### 11. Dependency Injection
Developed a customer management service that relies on a repository interface, where the concrete repository implementation is injected via the constructor, decoupling the components.

## How to Run
Each exercise is packaged in its own directory with a `src` folder. To run any exercise, navigate into its `src` folder, compile the `.java` files, and run the respective test class.

Example for Exercise 1:
```bash
cd Exercise_1_SingletonPatternExample/src
javac *.java
java SingletonTest
```
