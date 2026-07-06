-- ============================================================================
-- File: 08_exercise7_packages.sql
-- Description: Exercise 7 - Packages
--              Demonstrates PL/SQL packages by grouping related procedures
--              and functions into logical units for Customer Management,
--              Employee Management, and Account Operations.
-- Author: Prateek
-- ============================================================================

SET SERVEROUTPUT ON;

-- ============================================================================
-- SCENARIO 1: CustomerManagement Package
-- 
-- Purpose: Groups all customer-related procedures and functions into a
--          single package for modular and organized code.
-- Components:
--   - AddCustomer: Inserts a new customer record
--   - UpdateCustomerDetails: Updates customer name and balance
--   - GetCustomerBalance: Returns the balance of a customer
-- ============================================================================

-- ---- Package Specification ----
CREATE OR REPLACE PACKAGE CustomerManagement
AS
    -- Procedure to add a new customer
    PROCEDURE AddCustomer (
        p_id      IN NUMBER,
        p_name    IN VARCHAR2,
        p_dob     IN DATE,
        p_balance IN NUMBER
    );
    
    -- Procedure to update customer details (name and balance)
    PROCEDURE UpdateCustomerDetails (
        p_id      IN NUMBER,
        p_name    IN VARCHAR2,
        p_balance IN NUMBER
    );
    
    -- Function to get a customer's balance
    FUNCTION GetCustomerBalance (
        p_id IN NUMBER
    ) RETURN NUMBER;
END CustomerManagement;
/

-- ---- Package Body ----
CREATE OR REPLACE PACKAGE BODY CustomerManagement
AS
    -- ========================================================================
    -- Procedure: AddCustomer
    -- Description: Inserts a new customer record into the Customers table
    -- ========================================================================
    PROCEDURE AddCustomer (
        p_id      IN NUMBER,
        p_name    IN VARCHAR2,
        p_dob     IN DATE,
        p_balance IN NUMBER
    )
    AS
    BEGIN
        INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
        VALUES (p_id, p_name, p_dob, p_balance, SYSDATE);
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('CustomerManagement.AddCustomer: ' || p_name || 
                             ' added successfully (ID: ' || p_id || ')');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: Customer ID ' || p_id || ' already exists.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
    END AddCustomer;
    
    -- ========================================================================
    -- Procedure: UpdateCustomerDetails
    -- Description: Updates the name and balance of an existing customer
    -- ========================================================================
    PROCEDURE UpdateCustomerDetails (
        p_id      IN NUMBER,
        p_name    IN VARCHAR2,
        p_balance IN NUMBER
    )
    AS
        v_rows_updated NUMBER;
    BEGIN
        UPDATE Customers
        SET Name = p_name,
            Balance = p_balance,
            LastModified = SYSDATE
        WHERE CustomerID = p_id;
        
        v_rows_updated := SQL%ROWCOUNT;
        
        IF v_rows_updated > 0 THEN
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('CustomerManagement.UpdateCustomerDetails: ' ||
                                 'Customer ' || p_id || ' updated. ' ||
                                 'Name: ' || p_name || ', Balance: $' || p_balance);
        ELSE
            DBMS_OUTPUT.PUT_LINE('ERROR: Customer ID ' || p_id || ' not found.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
    END UpdateCustomerDetails;
    
    -- ========================================================================
    -- Function: GetCustomerBalance
    -- Description: Returns the balance of a specified customer
    -- ========================================================================
    FUNCTION GetCustomerBalance (
        p_id IN NUMBER
    ) RETURN NUMBER
    AS
        v_balance NUMBER;
    BEGIN
        SELECT Balance INTO v_balance
        FROM Customers
        WHERE CustomerID = p_id;
        
        RETURN v_balance;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: Customer ID ' || p_id || ' not found.');
            RETURN -1;
    END GetCustomerBalance;
    
END CustomerManagement;
/

-- Test Cases for CustomerManagement Package
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('TEST: CustomerManagement Package');
    DBMS_OUTPUT.PUT_LINE('============================================');
    
    -- Test AddCustomer
    DBMS_OUTPUT.PUT_LINE('--- Test AddCustomer ---');
    CustomerManagement.AddCustomer(5, 'Emily Davis', TO_DATE('1992-08-15', 'YYYY-MM-DD'), 7500);
    
    -- Test GetCustomerBalance
    DBMS_OUTPUT.PUT_LINE('--- Test GetCustomerBalance ---');
    DBMS_OUTPUT.PUT_LINE('Customer 5 Balance: $' || CustomerManagement.GetCustomerBalance(5));
    DBMS_OUTPUT.PUT_LINE('Customer 999 Balance: $' || CustomerManagement.GetCustomerBalance(999));
    
    -- Test UpdateCustomerDetails
    DBMS_OUTPUT.PUT_LINE('--- Test UpdateCustomerDetails ---');
    CustomerManagement.UpdateCustomerDetails(5, 'Emily D. Davis', 8000);
    DBMS_OUTPUT.PUT_LINE('Updated Balance: $' || CustomerManagement.GetCustomerBalance(5));
END;
/


-- ============================================================================
-- SCENARIO 2: EmployeeManagement Package
-- 
-- Purpose: Groups all employee-related operations into a single package.
-- Components:
--   - HireEmployee: Inserts a new employee record
--   - UpdateEmployeeDetails: Updates employee name, position, and salary
--   - CalculateAnnualSalary: Returns the annual salary (monthly * 12)
-- ============================================================================

-- ---- Package Specification ----
CREATE OR REPLACE PACKAGE EmployeeManagement
AS
    -- Procedure to hire a new employee
    PROCEDURE HireEmployee (
        p_id         IN NUMBER,
        p_name       IN VARCHAR2,
        p_position   IN VARCHAR2,
        p_salary     IN NUMBER,
        p_department IN VARCHAR2
    );
    
    -- Procedure to update employee details
    PROCEDURE UpdateEmployeeDetails (
        p_id       IN NUMBER,
        p_name     IN VARCHAR2,
        p_position IN VARCHAR2,
        p_salary   IN NUMBER
    );
    
    -- Function to calculate annual salary
    FUNCTION CalculateAnnualSalary (
        p_id IN NUMBER
    ) RETURN NUMBER;
END EmployeeManagement;
/

-- ---- Package Body ----
CREATE OR REPLACE PACKAGE BODY EmployeeManagement
AS
    -- ========================================================================
    -- Procedure: HireEmployee
    -- Description: Inserts a new employee record with hire date as current date
    -- ========================================================================
    PROCEDURE HireEmployee (
        p_id         IN NUMBER,
        p_name       IN VARCHAR2,
        p_position   IN VARCHAR2,
        p_salary     IN NUMBER,
        p_department IN VARCHAR2
    )
    AS
    BEGIN
        INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
        VALUES (p_id, p_name, p_position, p_salary, p_department, SYSDATE);
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('EmployeeManagement.HireEmployee: ' || p_name || 
                             ' hired as ' || p_position || 
                             ' in ' || p_department || ' department.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: Employee ID ' || p_id || ' already exists.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
    END HireEmployee;
    
    -- ========================================================================
    -- Procedure: UpdateEmployeeDetails
    -- Description: Updates the name, position, and salary of an employee
    -- ========================================================================
    PROCEDURE UpdateEmployeeDetails (
        p_id       IN NUMBER,
        p_name     IN VARCHAR2,
        p_position IN VARCHAR2,
        p_salary   IN NUMBER
    )
    AS
        v_rows_updated NUMBER;
    BEGIN
        UPDATE Employees
        SET Name = p_name,
            Position = p_position,
            Salary = p_salary
        WHERE EmployeeID = p_id;
        
        v_rows_updated := SQL%ROWCOUNT;
        
        IF v_rows_updated > 0 THEN
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('EmployeeManagement.UpdateEmployeeDetails: ' ||
                                 'Employee ' || p_id || ' updated. ' ||
                                 'Name: ' || p_name || 
                                 ', Position: ' || p_position || 
                                 ', Salary: $' || p_salary);
        ELSE
            DBMS_OUTPUT.PUT_LINE('ERROR: Employee ID ' || p_id || ' not found.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
    END UpdateEmployeeDetails;
    
    -- ========================================================================
    -- Function: CalculateAnnualSalary
    -- Description: Returns the annual salary (monthly salary * 12)
    -- ========================================================================
    FUNCTION CalculateAnnualSalary (
        p_id IN NUMBER
    ) RETURN NUMBER
    AS
        v_monthly_salary NUMBER;
    BEGIN
        SELECT Salary INTO v_monthly_salary
        FROM Employees
        WHERE EmployeeID = p_id;
        
        -- Annual salary = monthly salary * 12
        RETURN v_monthly_salary * 12;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: Employee ID ' || p_id || ' not found.');
            RETURN -1;
    END CalculateAnnualSalary;
    
END EmployeeManagement;
/

-- Test Cases for EmployeeManagement Package
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('TEST: EmployeeManagement Package');
    DBMS_OUTPUT.PUT_LINE('============================================');
    
    -- Test HireEmployee
    DBMS_OUTPUT.PUT_LINE('--- Test HireEmployee ---');
    EmployeeManagement.HireEmployee(3, 'Charlie Wilson', 'Analyst', 55000, 'Finance');
    
    -- Test CalculateAnnualSalary
    DBMS_OUTPUT.PUT_LINE('--- Test CalculateAnnualSalary ---');
    DBMS_OUTPUT.PUT_LINE('Employee 1 Annual Salary: $' || 
                         EmployeeManagement.CalculateAnnualSalary(1));
    DBMS_OUTPUT.PUT_LINE('Employee 3 Annual Salary: $' || 
                         EmployeeManagement.CalculateAnnualSalary(3));
    
    -- Test UpdateEmployeeDetails
    DBMS_OUTPUT.PUT_LINE('--- Test UpdateEmployeeDetails ---');
    EmployeeManagement.UpdateEmployeeDetails(3, 'Charlie Wilson', 'Senior Analyst', 65000);
    DBMS_OUTPUT.PUT_LINE('Updated Annual Salary: $' || 
                         EmployeeManagement.CalculateAnnualSalary(3));
END;
/


-- ============================================================================
-- SCENARIO 3: AccountOperations Package
-- 
-- Purpose: Groups all account-related operations into a single package.
-- Components:
--   - OpenAccount: Opens a new bank account
--   - CloseAccount: Closes (deletes) an existing account
--   - GetTotalBalance: Returns total balance across all customer accounts
-- ============================================================================

-- ---- Package Specification ----
CREATE OR REPLACE PACKAGE AccountOperations
AS
    -- Procedure to open a new account
    PROCEDURE OpenAccount (
        p_acc_id  IN NUMBER,
        p_cust_id IN NUMBER,
        p_type    IN VARCHAR2,
        p_balance IN NUMBER
    );
    
    -- Procedure to close an account
    PROCEDURE CloseAccount (
        p_acc_id IN NUMBER
    );
    
    -- Function to get total balance across all accounts for a customer
    FUNCTION GetTotalBalance (
        p_cust_id IN NUMBER
    ) RETURN NUMBER;
END AccountOperations;
/

-- ---- Package Body ----
CREATE OR REPLACE PACKAGE BODY AccountOperations
AS
    -- ========================================================================
    -- Procedure: OpenAccount
    -- Description: Opens a new bank account for a customer
    -- ========================================================================
    PROCEDURE OpenAccount (
        p_acc_id  IN NUMBER,
        p_cust_id IN NUMBER,
        p_type    IN VARCHAR2,
        p_balance IN NUMBER
    )
    AS
    BEGIN
        -- Verify customer exists before creating account
        DECLARE
            v_cust_exists NUMBER;
        BEGIN
            SELECT COUNT(*) INTO v_cust_exists
            FROM Customers WHERE CustomerID = p_cust_id;
            
            IF v_cust_exists = 0 THEN
                DBMS_OUTPUT.PUT_LINE('ERROR: Customer ID ' || p_cust_id || ' does not exist.');
                RETURN;
            END IF;
        END;
        
        INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
        VALUES (p_acc_id, p_cust_id, p_type, p_balance, SYSDATE);
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('AccountOperations.OpenAccount: Account ' || p_acc_id || 
                             ' opened for Customer ' || p_cust_id ||
                             ' | Type: ' || p_type || 
                             ' | Initial Balance: $' || p_balance);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: Account ID ' || p_acc_id || ' already exists.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
    END OpenAccount;
    
    -- ========================================================================
    -- Procedure: CloseAccount
    -- Description: Closes an account by deleting it from the Accounts table.
    --              First removes related transactions to maintain referential integrity.
    -- ========================================================================
    PROCEDURE CloseAccount (
        p_acc_id IN NUMBER
    )
    AS
        v_balance  NUMBER;
        v_rows     NUMBER;
    BEGIN
        -- Check if account exists and get its balance
        BEGIN
            SELECT Balance INTO v_balance
            FROM Accounts WHERE AccountID = p_acc_id;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('ERROR: Account ID ' || p_acc_id || ' not found.');
                RETURN;
        END;
        
        -- Warn if account still has balance
        IF v_balance > 0 THEN
            DBMS_OUTPUT.PUT_LINE('WARNING: Account ' || p_acc_id || 
                                 ' has remaining balance of $' || v_balance);
        END IF;
        
        -- Delete related transactions first (referential integrity)
        DELETE FROM Transactions WHERE AccountID = p_acc_id;
        
        -- Delete the account
        DELETE FROM Accounts WHERE AccountID = p_acc_id;
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('AccountOperations.CloseAccount: Account ' || p_acc_id || 
                             ' has been closed successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
    END CloseAccount;
    
    -- ========================================================================
    -- Function: GetTotalBalance
    -- Description: Returns the total balance across all accounts for a customer
    -- ========================================================================
    FUNCTION GetTotalBalance (
        p_cust_id IN NUMBER
    ) RETURN NUMBER
    AS
        v_total_balance NUMBER;
    BEGIN
        SELECT NVL(SUM(Balance), 0) INTO v_total_balance
        FROM Accounts
        WHERE CustomerID = p_cust_id;
        
        RETURN v_total_balance;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
            RETURN -1;
    END GetTotalBalance;
    
END AccountOperations;
/

-- Test Cases for AccountOperations Package
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('TEST: AccountOperations Package');
    DBMS_OUTPUT.PUT_LINE('============================================');
    
    -- Test OpenAccount
    DBMS_OUTPUT.PUT_LINE('--- Test OpenAccount ---');
    AccountOperations.OpenAccount(4, 1, 'Checking', 3000);
    
    -- Test GetTotalBalance
    DBMS_OUTPUT.PUT_LINE('--- Test GetTotalBalance ---');
    DBMS_OUTPUT.PUT_LINE('Customer 1 Total Balance: $' || 
                         AccountOperations.GetTotalBalance(1));
    DBMS_OUTPUT.PUT_LINE('Customer 3 Total Balance: $' || 
                         AccountOperations.GetTotalBalance(3));
    
    -- Test CloseAccount
    DBMS_OUTPUT.PUT_LINE('--- Test CloseAccount ---');
    AccountOperations.CloseAccount(4);
    DBMS_OUTPUT.PUT_LINE('Customer 1 Total Balance after close: $' || 
                         AccountOperations.GetTotalBalance(1));
END;
/
