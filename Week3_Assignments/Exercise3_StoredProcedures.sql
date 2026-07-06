-- ============================================================================
-- File: 04_exercise3_stored_procedures.sql
-- Description: Exercise 3 - Stored Procedures
--              Demonstrates creating and using stored procedures for
--              banking operations including interest processing, bonuses,
--              and fund transfers.
-- Author: Prateek
-- ============================================================================

SET SERVEROUTPUT ON;

-- ============================================================================
-- SCENARIO 1: Process Monthly Interest for Savings Accounts
-- 
-- Business Rule: The bank needs to process monthly interest for all savings
--                accounts by applying an interest rate of 1% to the balance.
-- Approach: Use a cursor to iterate through savings accounts, calculate
--           interest, and update balances.
-- ============================================================================

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest
AS
    -- Cursor to fetch all savings accounts
    CURSOR c_savings IS
        SELECT AccountID, CustomerID, Balance
        FROM Accounts
        WHERE AccountType = 'Savings';
    
    v_new_balance   NUMBER;
    v_interest      NUMBER;
    v_account_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('Processing Monthly Interest for Savings Accounts');
    DBMS_OUTPUT.PUT_LINE('Interest Rate: 1%');
    DBMS_OUTPUT.PUT_LINE('============================================');
    
    FOR rec IN c_savings LOOP
        -- Calculate 1% interest on current balance
        v_interest := rec.Balance * 0.01;
        v_new_balance := rec.Balance + v_interest;
        
        -- Update the account balance
        UPDATE Accounts
        SET Balance = v_new_balance,
            LastModified = SYSDATE
        WHERE AccountID = rec.AccountID;
        
        v_account_count := v_account_count + 1;
        
        -- Print details
        DBMS_OUTPUT.PUT_LINE('Account ID: ' || rec.AccountID || 
                             ' | Old Balance: $' || rec.Balance || 
                             ' | Interest: $' || ROUND(v_interest, 2) || 
                             ' | New Balance: $' || ROUND(v_new_balance, 2));
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Total accounts processed: ' || v_account_count);
    DBMS_OUTPUT.PUT_LINE('Monthly interest processing complete.');
END ProcessMonthlyInterest;
/

-- Test: Execute ProcessMonthlyInterest
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== TEST: Process Monthly Interest ===');
    ProcessMonthlyInterest;
END;
/


-- ============================================================================
-- SCENARIO 2: Update Employee Bonus by Department
-- 
-- Business Rule: The bank wants to implement a bonus scheme for employees
--                based on their performance. Bonus is applied by department.
-- Approach: Accept department name and bonus percentage as parameters,
--           then update salaries for all employees in that department.
-- ============================================================================

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    p_department IN VARCHAR2,   -- Department to apply bonus to
    p_bonus_pct  IN NUMBER      -- Bonus percentage
)
AS
    -- Cursor to fetch employees in the specified department
    CURSOR c_employees IS
        SELECT EmployeeID, Name, Salary
        FROM Employees
        WHERE Department = p_department;
    
    v_new_salary    NUMBER;
    v_bonus_amount  NUMBER;
    v_emp_count     NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('Applying Bonus to Department: ' || p_department);
    DBMS_OUTPUT.PUT_LINE('Bonus Percentage: ' || p_bonus_pct || '%');
    DBMS_OUTPUT.PUT_LINE('============================================');
    
    FOR rec IN c_employees LOOP
        -- Calculate bonus amount and new salary
        v_bonus_amount := rec.Salary * (p_bonus_pct / 100);
        v_new_salary := rec.Salary + v_bonus_amount;
        
        -- Update employee salary
        UPDATE Employees
        SET Salary = v_new_salary
        WHERE EmployeeID = rec.EmployeeID;
        
        v_emp_count := v_emp_count + 1;
        
        -- Print details
        DBMS_OUTPUT.PUT_LINE('Employee: ' || rec.Name || 
                             ' | Old Salary: $' || rec.Salary || 
                             ' | Bonus: $' || ROUND(v_bonus_amount, 2) || 
                             ' | New Salary: $' || ROUND(v_new_salary, 2));
    END LOOP;
    
    IF v_emp_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No employees found in department: ' || p_department);
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('Total employees updated: ' || v_emp_count);
    END IF;
END UpdateEmployeeBonus;
/

-- Test: Apply 5% bonus to HR department
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== TEST: Apply 5% bonus to HR ===');
    UpdateEmployeeBonus('HR', 5);
END;
/

-- Test: Apply 10% bonus to IT department
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== TEST: Apply 10% bonus to IT ===');
    UpdateEmployeeBonus('IT', 10);
END;
/


-- ============================================================================
-- SCENARIO 3: Transfer Funds Between Accounts
-- 
-- Business Rule: Customers should be able to transfer funds between their
--                accounts. The source account must have sufficient balance.
-- Approach: Verify sufficient balance, debit source, credit destination.
--           Use proper transaction management with COMMIT on success.
-- ============================================================================

CREATE OR REPLACE PROCEDURE TransferFunds (
    p_from_account IN NUMBER,   -- Source account ID
    p_to_account   IN NUMBER,   -- Destination account ID
    p_amount       IN NUMBER    -- Transfer amount
)
AS
    v_source_balance  NUMBER;
    v_dest_balance    NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('Fund Transfer Request');
    DBMS_OUTPUT.PUT_LINE('From Account: ' || p_from_account);
    DBMS_OUTPUT.PUT_LINE('To Account  : ' || p_to_account);
    DBMS_OUTPUT.PUT_LINE('Amount      : $' || p_amount);
    DBMS_OUTPUT.PUT_LINE('============================================');
    
    -- Get source account balance
    SELECT Balance INTO v_source_balance
    FROM Accounts
    WHERE AccountID = p_from_account;
    
    -- Check if source account has sufficient balance
    IF v_source_balance < p_amount THEN
        DBMS_OUTPUT.PUT_LINE('FAILED: Insufficient balance in source account.');
        DBMS_OUTPUT.PUT_LINE('Available: $' || v_source_balance || 
                             ' | Requested: $' || p_amount);
        RETURN;
    END IF;
    
    -- Debit the source account
    UPDATE Accounts
    SET Balance = Balance - p_amount,
        LastModified = SYSDATE
    WHERE AccountID = p_from_account;
    
    -- Credit the destination account
    UPDATE Accounts
    SET Balance = Balance + p_amount,
        LastModified = SYSDATE
    WHERE AccountID = p_to_account;
    
    -- Get updated balances for confirmation
    SELECT Balance INTO v_source_balance
    FROM Accounts WHERE AccountID = p_from_account;
    
    SELECT Balance INTO v_dest_balance
    FROM Accounts WHERE AccountID = p_to_account;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('SUCCESS: Transfer completed.');
    DBMS_OUTPUT.PUT_LINE('Source Account (' || p_from_account || 
                         ') New Balance: $' || v_source_balance);
    DBMS_OUTPUT.PUT_LINE('Dest Account (' || p_to_account || 
                         ') New Balance: $' || v_dest_balance);
END TransferFunds;
/

-- Test: Transfer $300 from Account 3 to Account 1
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== TEST: Transfer $300 from Account 3 to Account 1 ===');
    TransferFunds(3, 1, 300);
END;
/
