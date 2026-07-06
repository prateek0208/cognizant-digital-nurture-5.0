-- ============================================================================
-- File: 07_exercise6_cursors.sql
-- Description: Exercise 6 - Cursors
--              Demonstrates explicit cursor usage with OPEN, FETCH, CLOSE,
--              FOR UPDATE, and WHERE CURRENT OF for various banking operations.
-- Author: Prateek
-- ============================================================================

SET SERVEROUTPUT ON;

-- ============================================================================
-- SCENARIO 1: Generate Monthly Statements for All Customers
-- 
-- Business Rule: Generate monthly statements showing all transactions for
--                the current month for each customer.
-- Approach: Use an explicit cursor to join Transactions, Accounts, and
--           Customers tables. Print a formatted statement per transaction.
-- ============================================================================

DECLARE
    -- Explicit cursor: Fetch all transactions for the current month
    -- Joins with Accounts and Customers for complete information
    CURSOR c_monthly_statements IS
        SELECT c.CustomerID, c.Name AS CustomerName,
               a.AccountID, a.AccountType,
               t.TransactionID, t.TransactionDate, t.Amount, t.TransactionType
        FROM Transactions t
        JOIN Accounts a ON t.AccountID = a.AccountID
        JOIN Customers c ON a.CustomerID = c.CustomerID
        WHERE EXTRACT(MONTH FROM t.TransactionDate) = EXTRACT(MONTH FROM SYSDATE)
          AND EXTRACT(YEAR FROM t.TransactionDate) = EXTRACT(YEAR FROM SYSDATE)
        ORDER BY c.CustomerID, t.TransactionDate;
    
    -- Record variable to hold fetched data
    v_customer_id      Customers.CustomerID%TYPE;
    v_customer_name    Customers.Name%TYPE;
    v_account_id       Accounts.AccountID%TYPE;
    v_account_type     Accounts.AccountType%TYPE;
    v_txn_id           Transactions.TransactionID%TYPE;
    v_txn_date         Transactions.TransactionDate%TYPE;
    v_amount           Transactions.Amount%TYPE;
    v_txn_type         Transactions.TransactionType%TYPE;
    
    v_prev_customer_id NUMBER := -1;  -- Track customer changes for grouping
    v_txn_count        NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('  MONTHLY STATEMENT - ' || TO_CHAR(SYSDATE, 'MONTH YYYY'));
    DBMS_OUTPUT.PUT_LINE('============================================');
    
    -- Open the cursor
    OPEN c_monthly_statements;
    
    -- Fetch loop
    LOOP
        FETCH c_monthly_statements INTO v_customer_id, v_customer_name,
              v_account_id, v_account_type, v_txn_id, v_txn_date, v_amount, v_txn_type;
        EXIT WHEN c_monthly_statements%NOTFOUND;
        
        -- Print customer header when customer changes
        IF v_customer_id != v_prev_customer_id THEN
            IF v_prev_customer_id != -1 THEN
                DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
            END IF;
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('Customer: ' || v_customer_name || 
                                 ' (ID: ' || v_customer_id || ')');
            DBMS_OUTPUT.PUT_LINE('  Date        | Account      | Type       | Amount');
            DBMS_OUTPUT.PUT_LINE('  ------------|--------------|------------|--------');
            v_prev_customer_id := v_customer_id;
        END IF;
        
        -- Print transaction details
        DBMS_OUTPUT.PUT_LINE('  ' || TO_CHAR(v_txn_date, 'DD-MON-YYYY') || 
                             ' | ' || RPAD(v_account_type, 12) || 
                             ' | ' || RPAD(v_txn_type, 10) || 
                             ' | $' || v_amount);
        v_txn_count := v_txn_count + 1;
    END LOOP;
    
    -- Close the cursor
    CLOSE c_monthly_statements;
    
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('Total transactions this month: ' || v_txn_count);
    
    IF v_txn_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No transactions found for the current month.');
    END IF;
END;
/


-- ============================================================================
-- SCENARIO 2: Apply Annual Maintenance Fee to All Accounts
-- 
-- Business Rule: Deduct an annual maintenance fee of $50 from the balance
--                of all accounts.
-- Approach: Use an explicit cursor with FOR UPDATE clause to lock rows
--           during processing, and WHERE CURRENT OF for targeted updates.
-- ============================================================================

SET SERVEROUTPUT ON;

DECLARE
    -- Explicit cursor with FOR UPDATE to lock rows for update
    CURSOR c_accounts IS
        SELECT AccountID, CustomerID, AccountType, Balance
        FROM Accounts
        FOR UPDATE OF Balance;
    
    -- Variables for fetched data
    v_account_id    Accounts.AccountID%TYPE;
    v_customer_id   Accounts.CustomerID%TYPE;
    v_account_type  Accounts.AccountType%TYPE;
    v_balance       Accounts.Balance%TYPE;
    
    -- Constants
    c_annual_fee    CONSTANT NUMBER := 50;  -- $50 annual fee
    v_account_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('SCENARIO 2: Apply Annual Maintenance Fee');
    DBMS_OUTPUT.PUT_LINE('Annual Fee: $' || c_annual_fee);
    DBMS_OUTPUT.PUT_LINE('============================================');
    
    -- Open the cursor
    OPEN c_accounts;
    
    -- Fetch and process each account
    LOOP
        FETCH c_accounts INTO v_account_id, v_customer_id, v_account_type, v_balance;
        EXIT WHEN c_accounts%NOTFOUND;
        
        -- Deduct annual fee using WHERE CURRENT OF
        UPDATE Accounts
        SET Balance = Balance - c_annual_fee,
            LastModified = SYSDATE
        WHERE CURRENT OF c_accounts;
        
        v_account_count := v_account_count + 1;
        
        -- Print account details
        DBMS_OUTPUT.PUT_LINE('Account ' || v_account_id || 
                             ' (' || v_account_type || ')' ||
                             ' | Old Balance: $' || v_balance || 
                             ' | Fee: -$' || c_annual_fee || 
                             ' | New Balance: $' || (v_balance - c_annual_fee));
    END LOOP;
    
    -- Close the cursor
    CLOSE c_accounts;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Annual fee applied to ' || v_account_count || ' account(s).');
END;
/


-- ============================================================================
-- SCENARIO 3: Update Loan Interest Rates Based on New Policy
-- 
-- Business Rule: Update loan interest rates based on a new policy:
--   - Loans > $10,000: Reduce rate by 0.5%
--   - Loans > $5,000 (but <= $10,000): Reduce rate by 0.25%
--   - Loans <= $5,000: No change
-- Approach: Use an explicit cursor with FOR UPDATE and FETCH/CLOSE.
-- ============================================================================

SET SERVEROUTPUT ON;

DECLARE
    -- Explicit cursor with FOR UPDATE to lock loan rows
    CURSOR c_loans IS
        SELECT LoanID, CustomerID, LoanAmount, InterestRate
        FROM Loans
        FOR UPDATE OF InterestRate;
    
    -- Variables for fetched data
    v_loan_id       Loans.LoanID%TYPE;
    v_customer_id   Loans.CustomerID%TYPE;
    v_loan_amount   Loans.LoanAmount%TYPE;
    v_interest_rate Loans.InterestRate%TYPE;
    v_new_rate      NUMBER;
    v_discount      NUMBER;
    v_updated_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('SCENARIO 3: Update Loan Interest Rates');
    DBMS_OUTPUT.PUT_LINE('New Policy:');
    DBMS_OUTPUT.PUT_LINE('  > $10,000: -0.5% rate reduction');
    DBMS_OUTPUT.PUT_LINE('  > $5,000 : -0.25% rate reduction');
    DBMS_OUTPUT.PUT_LINE('  <= $5,000: No change');
    DBMS_OUTPUT.PUT_LINE('============================================');
    
    -- Open the cursor
    OPEN c_loans;
    
    -- Fetch and process each loan
    LOOP
        FETCH c_loans INTO v_loan_id, v_customer_id, v_loan_amount, v_interest_rate;
        EXIT WHEN c_loans%NOTFOUND;
        
        -- Apply policy-based rate adjustment
        IF v_loan_amount > 10000 THEN
            v_discount := 0.5;
            v_new_rate := v_interest_rate - v_discount;
            
            -- Update using WHERE CURRENT OF
            UPDATE Loans
            SET InterestRate = v_new_rate
            WHERE CURRENT OF c_loans;
            
            v_updated_count := v_updated_count + 1;
            
            DBMS_OUTPUT.PUT_LINE('Loan ' || v_loan_id || 
                                 ' | Amount: $' || v_loan_amount || 
                                 ' | Old Rate: ' || v_interest_rate || '%' ||
                                 ' | Discount: -' || v_discount || '%' ||
                                 ' | New Rate: ' || v_new_rate || '%');
                                 
        ELSIF v_loan_amount > 5000 THEN
            v_discount := 0.25;
            v_new_rate := v_interest_rate - v_discount;
            
            -- Update using WHERE CURRENT OF
            UPDATE Loans
            SET InterestRate = v_new_rate
            WHERE CURRENT OF c_loans;
            
            v_updated_count := v_updated_count + 1;
            
            DBMS_OUTPUT.PUT_LINE('Loan ' || v_loan_id || 
                                 ' | Amount: $' || v_loan_amount || 
                                 ' | Old Rate: ' || v_interest_rate || '%' ||
                                 ' | Discount: -' || v_discount || '%' ||
                                 ' | New Rate: ' || v_new_rate || '%');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Loan ' || v_loan_id || 
                                 ' | Amount: $' || v_loan_amount || 
                                 ' | Rate: ' || v_interest_rate || '%' ||
                                 ' | No change (amount <= $5,000)');
        END IF;
    END LOOP;
    
    -- Close the cursor
    CLOSE c_loans;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Total loans updated: ' || v_updated_count);
END;
/
