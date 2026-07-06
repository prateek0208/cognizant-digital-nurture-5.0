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

## PL/SQL Exercise

This section contains PL/SQL exercises for a **Banking Management System** covering 7 core PL/SQL concepts through practical banking scenarios.

### Database Schema

The banking system uses the following tables:
- **Customers** (CustomerID, Name, DOB, Balance, LastModified, IsVIP)
- **Accounts** (AccountID, CustomerID, AccountType, Balance, LastModified)
- **Transactions** (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
- **Loans** (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
- **Employees** (EmployeeID, Name, Position, Salary, Department, HireDate)
- **AuditLog** (LogID, TransactionID, AccountID, Amount, TransactionType, TransactionDate, LogTimestamp)

### Exercises Overview

| Exercise | Topic | Concepts Covered |
|----------|-------|-----------------|
| Exercise 1 | Control Structures | IF/ELSE, CURSOR FOR loops, WHILE loops, Age-based discount, VIP assignment, Loan reminders |
| Exercise 2 | Error Handling | Custom exceptions, SAVEPOINT, ROLLBACK, NO_DATA_FOUND, DUP_VAL_ON_INDEX, Safe fund transfers |
| Exercise 3 | Stored Procedures | CREATE OR REPLACE PROCEDURE, Monthly interest processing, Employee bonus, Fund transfers |
| Exercise 4 | Functions | CREATE OR REPLACE FUNCTION, Age calculation, EMI formula, Boolean return type, Balance check |
| Exercise 5 | Triggers | BEFORE UPDATE, AFTER INSERT, BEFORE INSERT, Auto-update timestamps, Audit logging, Business rules |
| Exercise 6 | Cursors | Explicit cursors, OPEN/FETCH/CLOSE, FOR UPDATE, WHERE CURRENT OF, Monthly statements, Annual fees |
| Exercise 7 | Packages | Package spec & body, CustomerManagement, EmployeeManagement, AccountOperations, Modular PL/SQL |

### Scenarios Covered

- **Exercise 1 - Control Structures:**
  1. Apply 1% interest discount for senior citizens (age > 60)
  2. Set VIP status for customers with balance > $10,000
  3. Send loan due reminders for loans maturing within 30 days

- **Exercise 2 - Error Handling:**
  1. `SafeTransferFunds` - Safe fund transfers with SAVEPOINT/ROLLBACK
  2. `UpdateSalary` - Employee salary update with NO_DATA_FOUND handling
  3. `AddNewCustomer` - New customer insertion with duplicate ID handling

- **Exercise 3 - Stored Procedures:**
  1. `ProcessMonthlyInterest` - Apply 1% interest to all savings accounts
  2. `UpdateEmployeeBonus` - Department-wise employee bonus scheme
  3. `TransferFunds` - Inter-account fund transfer with balance check

- **Exercise 4 - Functions:**
  1. `CalculateAge` - Calculate customer age from date of birth
  2. `CalculateMonthlyInstallment` - Compute loan EMI using standard formula
  3. `HasSufficientBalance` - Check account balance before transactions

- **Exercise 5 - Triggers:**
  1. `UpdateCustomerLastModified` - Auto-update timestamp on customer changes
  2. `LogTransaction` - Automatic audit log for every transaction
  3. `CheckTransactionRules` - Enforce withdrawal/deposit business rules

- **Exercise 6 - Cursors:**
  1. `GenerateMonthlyStatements` - Monthly statement generation with explicit cursors
  2. `ApplyAnnualFee` - Apply $50 annual fee using FOR UPDATE/WHERE CURRENT OF
  3. `UpdateLoanInterestRates` - Policy-based loan interest rate updates

- **Exercise 7 - Packages:**
  1. `CustomerManagement` - AddCustomer, UpdateCustomerDetails, GetCustomerBalance
  2. `EmployeeManagement` - HireEmployee, UpdateEmployeeDetails, CalculateAnnualSalary
  3. `AccountOperations` - OpenAccount, CloseAccount, GetTotalBalance

---

## How to Run

### Week 1 & 2 (Java)
1. Make sure you have **Java JDK** installed
2. Open terminal in the exercise folder
3. Compile and run:
```bash
javac Exercise1_InventoryManagementSystem.java
java Exercise1_InventoryManagementSystem
```

### PL/SQL Exercise
1. Make sure you have **Oracle Database** (11g or later) or **Oracle XE** installed
2. Open **SQL*Plus** or **Oracle SQL Developer**
3. Run the schema setup first, then exercises in order:
```sql
-- Step 1: Create schema and insert sample data
@Schema_Setup.sql

-- Step 2: Run exercises in order
@Exercise1_ControlStructures.sql
@Exercise2_ErrorHandling.sql
@Exercise3_StoredProcedures.sql
@Exercise4_Functions.sql
@Exercise5_Triggers.sql
@Exercise6_Cursors.sql
@Exercise7_Packages.sql
```
> **Note:** Enable `SET SERVEROUTPUT ON` in SQL*Plus to see DBMS_OUTPUT messages.

## Tech Stack
- Java
- Data Structures & Algorithms
- Design Patterns
- PL/SQL (Oracle Database)
