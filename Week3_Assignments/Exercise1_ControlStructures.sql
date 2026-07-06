-- ============================================================================
-- File: 02_exercise1_control_structures.sql
-- Description: Exercise 1 - Control Structures
--              Demonstrates IF/ELSE, loops, and cursor FOR loops in PL/SQL
-- Author: Prateek
-- ============================================================================

-- ============================================================================
-- SCENARIO 1: Apply 1% discount to loan interest rates for customers above 60
-- 
-- Business Rule: The bank wants to apply a discount to loan interest rates
--                for senior customers (age > 60 years).
-- Approach: Use a CURSOR FOR loop to iterate through all customers,
--           calculate their age, and update loan interest rates if eligible.
-- ============================================================================

SET SERVEROUTPUT ON;

DECLARE
    -- Variable to store calculated age
    v_age NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('SCENARIO 1: Senior Citizen Interest Discount');
    DBMS_OUTPUT.PUT_LINE('============================================');
    
    -- Cursor FOR loop automatically handles OPEN, FETCH, and CLOSE
    FOR rec IN (SELECT CustomerID, Name, DOB FROM Customers) LOOP
        -- Calculate age using MONTHS_BETWEEN and dividing by 12
        v_age := TRUNC(MONTHS_BETWEEN(SYSDATE, rec.DOB) / 12);
        
        -- Check if customer is above 60 years old
        IF v_age > 60 THEN
            -- Apply 1% discount to all loans belonging to this customer
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE CustomerID = rec.CustomerID
              AND InterestRate > 1;  -- Ensure rate doesn't go below 1%
            
            DBMS_OUTPUT.PUT_LINE('Customer: ' || rec.Name || 
                                 ' | Age: ' || v_age || 
                                 ' | Discount Applied: 1% off loan interest rate');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Customer: ' || rec.Name || 
                                 ' | Age: ' || v_age || 
                                 ' | Not eligible for senior discount');
        END IF;
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Senior discount processing complete.');
END;
/


-- ============================================================================
-- SCENARIO 2: Set VIP status for customers with balance over $10,000
-- 
-- Business Rule: A customer can be promoted to VIP status based on their
--                balance. Customers with balance > $10,000 get VIP flag.
-- Approach: Use a cursor loop to iterate through all customers and update
--           the IsVIP column for qualifying customers.
-- ============================================================================

SET SERVEROUTPUT ON;

DECLARE
    -- Declare an explicit cursor for all customers
    CURSOR c_customers IS
        SELECT CustomerID, Name, Balance
        FROM Customers;
    
    -- Variables to hold fetched data
    v_customer_id   Customers.CustomerID%TYPE;
    v_name          Customers.Name%TYPE;
    v_balance       Customers.Balance%TYPE;
    v_vip_count     NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('SCENARIO 2: VIP Status Assignment');
    DBMS_OUTPUT.PUT_LINE('============================================');
    
    -- Open the cursor
    OPEN c_customers;
    
    -- Loop through all customer records
    LOOP
        FETCH c_customers INTO v_customer_id, v_name, v_balance;
        EXIT WHEN c_customers%NOTFOUND;
        
        -- Check if balance exceeds $10,000
        IF v_balance > 10000 THEN
            -- Promote customer to VIP
            UPDATE Customers
            SET IsVIP = 'TRUE'
            WHERE CustomerID = v_customer_id;
            
            v_vip_count := v_vip_count + 1;
            
            DBMS_OUTPUT.PUT_LINE('Customer: ' || v_name || 
                                 ' | Balance: $' || v_balance || 
                                 ' | Status: PROMOTED TO VIP');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Customer: ' || v_name || 
                                 ' | Balance: $' || v_balance || 
                                 ' | Status: Regular');
        END IF;
    END LOOP;
    
    -- Close the cursor
    CLOSE c_customers;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Total customers promoted to VIP: ' || v_vip_count);
END;
/


-- ============================================================================
-- SCENARIO 3: Loan Due Reminders (loans due within 30 days)
-- 
-- Business Rule: The bank wants to send reminders to customers whose loans
--                are due within the next 30 days.
-- Approach: Fetch all loans with EndDate within the next 30 days and print
--           a reminder message for each customer.
-- ============================================================================

SET SERVEROUTPUT ON;

DECLARE
    -- Cursor to fetch loans due within 30 days along with customer info
    CURSOR c_due_loans IS
        SELECT l.LoanID, l.LoanAmount, l.InterestRate, l.EndDate,
               c.CustomerID, c.Name
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30
        ORDER BY l.EndDate;
    
    -- Variables for cursor data
    v_loan_id       Loans.LoanID%TYPE;
    v_loan_amount   Loans.LoanAmount%TYPE;
    v_interest_rate Loans.InterestRate%TYPE;
    v_end_date      Loans.EndDate%TYPE;
    v_customer_id   Customers.CustomerID%TYPE;
    v_customer_name Customers.Name%TYPE;
    v_days_left     NUMBER;
    v_reminder_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('SCENARIO 3: Loan Due Reminders');
    DBMS_OUTPUT.PUT_LINE('============================================');
    
    -- Open cursor and iterate through due loans
    OPEN c_due_loans;
    
    LOOP
        FETCH c_due_loans INTO v_loan_id, v_loan_amount, v_interest_rate,
                                v_end_date, v_customer_id, v_customer_name;
        EXIT WHEN c_due_loans%NOTFOUND;
        
        -- Calculate days remaining until loan is due
        v_days_left := TRUNC(v_end_date - SYSDATE);
        v_reminder_count := v_reminder_count + 1;
        
        -- Print reminder message
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('REMINDER #' || v_reminder_count);
        DBMS_OUTPUT.PUT_LINE('Dear ' || v_customer_name || ',');
        DBMS_OUTPUT.PUT_LINE('Your loan (ID: ' || v_loan_id || ') is due in ' || 
                             v_days_left || ' day(s).');
        DBMS_OUTPUT.PUT_LINE('  Loan Amount  : $' || v_loan_amount);
        DBMS_OUTPUT.PUT_LINE('  Interest Rate: ' || v_interest_rate || '%');
        DBMS_OUTPUT.PUT_LINE('  Due Date     : ' || TO_CHAR(v_end_date, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE('Please ensure timely repayment to avoid penalties.');
    END LOOP;
    
    CLOSE c_due_loans;
    
    -- Summary
    DBMS_OUTPUT.PUT_LINE('============================================');
    IF v_reminder_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No loans are due within the next 30 days.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total reminders sent: ' || v_reminder_count);
    END IF;
END;
/
