-- ============================================================================
-- File: 03_exercise2_error_handling.sql
-- Description: Exercise 2 - Error Handling
--              Demonstrates exception handling, custom exceptions, SAVEPOINT,
--              and ROLLBACK in PL/SQL stored procedures.
-- Author: Prateek
-- ============================================================================

SET SERVEROUTPUT ON;

-- ============================================================================
-- SCENARIO 1: Safe Fund Transfer with Error Handling
-- 
-- Business Rule: Handle exceptions during fund transfers between accounts.
--                If any error occurs (e.g., insufficient funds), log the error
--                and roll back the transaction.
-- Approach: Use SAVEPOINT before transfer, custom exception for insufficient
--           funds, and ROLLBACK TO SAVEPOINT on any error.
-- ============================================================================

CREATE OR REPLACE PROCEDURE SafeTransferFunds (
    p_from_account IN NUMBER,   -- Source account ID
    p_to_account   IN NUMBER,   -- Destination account ID
    p_amount       IN NUMBER    -- Amount to transfer
)
AS
    -- Custom exception for insufficient funds
    e_insufficient_funds EXCEPTION;
    
    -- Variable to hold the current balance of source account
    v_source_balance NUMBER;
    v_from_exists    NUMBER;
    v_to_exists      NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- SafeTransferFunds: Transferring $' || p_amount || 
                         ' from Account ' || p_from_account || 
                         ' to Account ' || p_to_account || ' ---');
    
    -- Set a savepoint before starting the transfer
    SAVEPOINT before_transfer;
    
    -- Verify source account exists
    SELECT COUNT(*) INTO v_from_exists
    FROM Accounts WHERE AccountID = p_from_account;
    
    IF v_from_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Source account ' || p_from_account || ' does not exist.');
    END IF;
    
    -- Verify destination account exists
    SELECT COUNT(*) INTO v_to_exists
    FROM Accounts WHERE AccountID = p_to_account;
    
    IF v_to_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Destination account ' || p_to_account || ' does not exist.');
    END IF;
    
    -- Get current balance of source account
    SELECT Balance INTO v_source_balance
    FROM Accounts
    WHERE AccountID = p_from_account;
    
    -- Check for sufficient funds
    IF v_source_balance < p_amount THEN
        RAISE e_insufficient_funds;
    END IF;
    
    -- Deduct amount from source account
    UPDATE Accounts
    SET Balance = Balance - p_amount
    WHERE AccountID = p_from_account;
    
    -- Add amount to destination account
    UPDATE Accounts
    SET Balance = Balance + p_amount
    WHERE AccountID = p_to_account;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('SUCCESS: Transfer of $' || p_amount || ' completed successfully.');
    DBMS_OUTPUT.PUT_LINE('Source account new balance: $' || (v_source_balance - p_amount));

EXCEPTION
    WHEN e_insufficient_funds THEN
        -- Roll back to the savepoint on insufficient funds
        ROLLBACK TO before_transfer;
        DBMS_OUTPUT.PUT_LINE('ERROR: Insufficient funds in Account ' || p_from_account || 
                             '. Current balance: $' || v_source_balance || 
                             ', Requested: $' || p_amount);
    WHEN OTHERS THEN
        -- Roll back to savepoint on any other error
        ROLLBACK TO before_transfer;
        DBMS_OUTPUT.PUT_LINE('ERROR: Transfer failed - ' || SQLERRM);
END SafeTransferFunds;
/

-- Test Cases for SafeTransferFunds
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== TEST 1: Valid transfer ===');
    SafeTransferFunds(1, 2, 200);
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('=== TEST 2: Insufficient funds ===');
    SafeTransferFunds(1, 2, 999999);
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('=== TEST 3: Non-existent account ===');
    SafeTransferFunds(1, 999, 100);
END;
/


-- ============================================================================
-- SCENARIO 2: Update Employee Salary with Error Handling
-- 
-- Business Rule: Manage errors when updating employee salaries.
--                If the employee ID does not exist, handle the exception
--                and log an appropriate error message.
-- Approach: Use NO_DATA_FOUND exception to handle missing employee IDs.
-- ============================================================================

CREATE OR REPLACE PROCEDURE UpdateSalary (
    p_employee_id IN NUMBER,    -- Employee ID to update
    p_percentage  IN NUMBER     -- Percentage increase
)
AS
    -- Variables to store employee details
    v_emp_name   Employees.Name%TYPE;
    v_old_salary Employees.Salary%TYPE;
    v_new_salary NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- UpdateSalary: Employee ' || p_employee_id || 
                         ', Increase: ' || p_percentage || '% ---');
    
    -- Fetch current employee details (will raise NO_DATA_FOUND if not found)
    SELECT Name, Salary
    INTO v_emp_name, v_old_salary
    FROM Employees
    WHERE EmployeeID = p_employee_id;
    
    -- Calculate new salary
    v_new_salary := v_old_salary * (1 + p_percentage / 100);
    
    -- Update the salary
    UPDATE Employees
    SET Salary = v_new_salary
    WHERE EmployeeID = p_employee_id;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('SUCCESS: ' || v_emp_name || '''s salary updated.');
    DBMS_OUTPUT.PUT_LINE('  Old Salary: $' || v_old_salary);
    DBMS_OUTPUT.PUT_LINE('  New Salary: $' || ROUND(v_new_salary, 2));

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Handle case where employee ID does not exist
        DBMS_OUTPUT.PUT_LINE('ERROR: Employee with ID ' || p_employee_id || 
                             ' does not exist in the database.');
    WHEN OTHERS THEN
        -- Handle any other unexpected errors
        DBMS_OUTPUT.PUT_LINE('ERROR: Failed to update salary - ' || SQLERRM);
END UpdateSalary;
/

-- Test Cases for UpdateSalary
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== TEST 1: Valid salary update (10% increase) ===');
    UpdateSalary(1, 10);
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('=== TEST 2: Non-existent employee ===');
    UpdateSalary(999, 10);
END;
/


-- ============================================================================
-- SCENARIO 3: Add New Customer with Duplicate Handling
-- 
-- Business Rule: Ensure data integrity when adding a new customer.
--                If a customer with the same ID already exists, handle
--                the exception by logging an error and preventing insertion.
-- Approach: Use DUP_VAL_ON_INDEX exception to catch primary key violations.
-- ============================================================================

CREATE OR REPLACE PROCEDURE AddNewCustomer (
    p_id      IN NUMBER,        -- Customer ID
    p_name    IN VARCHAR2,      -- Customer name
    p_dob     IN DATE,          -- Date of birth
    p_balance IN NUMBER         -- Initial balance
)
AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- AddNewCustomer: Attempting to add ' || p_name || 
                         ' (ID: ' || p_id || ') ---');
    
    -- Attempt to insert the new customer
    INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
    VALUES (p_id, p_name, p_dob, p_balance, SYSDATE);
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('SUCCESS: Customer ' || p_name || 
                         ' added successfully with ID ' || p_id || '.');
    DBMS_OUTPUT.PUT_LINE('  Balance: $' || p_balance);

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        -- Handle duplicate customer ID
        DBMS_OUTPUT.PUT_LINE('ERROR: Customer with ID ' || p_id || 
                             ' already exists. Insertion prevented.');
        DBMS_OUTPUT.PUT_LINE('  Please use a unique Customer ID.');
    WHEN OTHERS THEN
        -- Handle any other unexpected errors
        DBMS_OUTPUT.PUT_LINE('ERROR: Failed to add customer - ' || SQLERRM);
END AddNewCustomer;
/

-- Test Cases for AddNewCustomer
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== TEST 1: Add new customer ===');
    AddNewCustomer(4, 'Sarah Connor', TO_DATE('1988-11-25', 'YYYY-MM-DD'), 5000);
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('=== TEST 2: Duplicate customer ID ===');
    AddNewCustomer(1, 'Duplicate John', TO_DATE('1995-01-01', 'YYYY-MM-DD'), 2000);
END;
/
