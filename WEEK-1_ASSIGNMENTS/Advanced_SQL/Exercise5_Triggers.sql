-- ============================================================================
-- File: 06_exercise5_triggers.sql
-- Description: Exercise 5 - Triggers
--              Demonstrates BEFORE UPDATE, AFTER INSERT, and BEFORE INSERT
--              triggers for automatic updates, audit logging, and business
--              rule enforcement.
-- Author: Prateek
-- ============================================================================

SET SERVEROUTPUT ON;

-- ============================================================================
-- SCENARIO 1: Auto-Update LastModified Date on Customer Record Update
-- 
-- Business Rule: Automatically update the LastModified column to the current
--                date whenever a customer's record is updated.
-- Trigger Type: BEFORE UPDATE (row-level)
-- ============================================================================

CREATE OR REPLACE TRIGGER UpdateCustomerLastModified
BEFORE UPDATE ON Customers
FOR EACH ROW
BEGIN
    -- Automatically set LastModified to current timestamp on any update
    :NEW.LastModified := SYSDATE;
    
    -- Optional: Log the update for debugging purposes
    DBMS_OUTPUT.PUT_LINE('TRIGGER: UpdateCustomerLastModified fired for Customer ID ' || 
                         :OLD.CustomerID || '. LastModified updated to ' || 
                         TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS'));
END;
/

-- Test: Update a customer record and verify LastModified is updated
DECLARE
    v_last_modified DATE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('TEST: UpdateCustomerLastModified Trigger');
    DBMS_OUTPUT.PUT_LINE('============================================');
    
    -- Show current LastModified date
    SELECT LastModified INTO v_last_modified
    FROM Customers WHERE CustomerID = 1;
    DBMS_OUTPUT.PUT_LINE('Before Update - LastModified: ' || 
                         TO_CHAR(v_last_modified, 'DD-MON-YYYY HH24:MI:SS'));
    
    -- Update the customer's name (trigger should fire)
    UPDATE Customers
    SET Name = 'John Doe'
    WHERE CustomerID = 1;
    
    -- Verify LastModified was automatically updated
    SELECT LastModified INTO v_last_modified
    FROM Customers WHERE CustomerID = 1;
    DBMS_OUTPUT.PUT_LINE('After Update  - LastModified: ' || 
                         TO_CHAR(v_last_modified, 'DD-MON-YYYY HH24:MI:SS'));
    
    COMMIT;
END;
/


-- ============================================================================
-- SCENARIO 2: Audit Log for Transactions
-- 
-- Business Rule: Maintain an audit log for all transactions. Every time a
--                new transaction is inserted, automatically create a log entry.
-- Trigger Type: AFTER INSERT (row-level)
-- Note: Uses audit_log_seq sequence for generating unique LogID values.
-- ============================================================================

CREATE OR REPLACE TRIGGER LogTransaction
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    -- Insert audit record with transaction details
    INSERT INTO AuditLog (
        LogID,
        TransactionID,
        AccountID,
        Amount,
        TransactionType,
        TransactionDate,
        LogTimestamp
    ) VALUES (
        audit_log_seq.NEXTVAL,      -- Auto-generated unique log ID
        :NEW.TransactionID,          -- Transaction ID from the new record
        :NEW.AccountID,              -- Account ID from the new record
        :NEW.Amount,                 -- Transaction amount
        :NEW.TransactionType,        -- Type: 'Deposit' or 'Withdrawal'
        :NEW.TransactionDate,        -- Date of the transaction
        SYSDATE                      -- Current timestamp for the log entry
    );
    
    DBMS_OUTPUT.PUT_LINE('TRIGGER: LogTransaction fired. Transaction ' || 
                         :NEW.TransactionID || ' logged to AuditLog.');
END;
/

-- Test: Insert a transaction and verify it appears in AuditLog
DECLARE
    v_log_count NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('TEST: LogTransaction Trigger');
    DBMS_OUTPUT.PUT_LINE('============================================');
    
    -- Check current audit log count
    SELECT COUNT(*) INTO v_log_count FROM AuditLog;
    DBMS_OUTPUT.PUT_LINE('AuditLog entries before insert: ' || v_log_count);
    
    -- Insert a new transaction (trigger should fire automatically)
    INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
    VALUES (3, 1, SYSDATE, 500, 'Deposit');
    
    -- Verify audit log entry was created
    SELECT COUNT(*) INTO v_log_count FROM AuditLog;
    DBMS_OUTPUT.PUT_LINE('AuditLog entries after insert: ' || v_log_count);
    
    -- Display the audit log entries
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Audit Log Contents:');
    FOR rec IN (SELECT * FROM AuditLog ORDER BY LogID) LOOP
        DBMS_OUTPUT.PUT_LINE('  LogID: ' || rec.LogID || 
                             ' | TxnID: ' || rec.TransactionID || 
                             ' | Account: ' || rec.AccountID || 
                             ' | Amount: $' || rec.Amount || 
                             ' | Type: ' || rec.TransactionType);
    END LOOP;
    
    COMMIT;
END;
/


-- ============================================================================
-- SCENARIO 3: Enforce Business Rules on Deposits and Withdrawals
-- 
-- Business Rule: 
--   - Withdrawals must not exceed the account balance
--   - Deposits must be positive amounts
-- Trigger Type: BEFORE INSERT (row-level)
-- Uses RAISE_APPLICATION_ERROR to prevent invalid transactions.
-- ============================================================================

CREATE OR REPLACE TRIGGER CheckTransactionRules
BEFORE INSERT ON Transactions
FOR EACH ROW
DECLARE
    v_current_balance NUMBER;
BEGIN
    -- Rule 1: For withdrawals, check that account has sufficient balance
    IF :NEW.TransactionType = 'Withdrawal' THEN
        -- Get the current balance of the account
        SELECT Balance INTO v_current_balance
        FROM Accounts
        WHERE AccountID = :NEW.AccountID;
        
        -- Check if withdrawal amount exceeds balance
        IF :NEW.Amount > v_current_balance THEN
            RAISE_APPLICATION_ERROR(-20003, 
                'Withdrawal rejected: Insufficient balance. ' ||
                'Account ' || :NEW.AccountID || 
                ' has $' || v_current_balance || 
                ' but withdrawal of $' || :NEW.Amount || ' was attempted.');
        END IF;
        
        DBMS_OUTPUT.PUT_LINE('TRIGGER: CheckTransactionRules - Withdrawal of $' || 
                             :NEW.Amount || ' approved for Account ' || :NEW.AccountID);
    
    -- Rule 2: For deposits, ensure amount is positive
    ELSIF :NEW.TransactionType = 'Deposit' THEN
        IF :NEW.Amount <= 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 
                'Deposit rejected: Amount must be positive. ' ||
                'Attempted deposit of $' || :NEW.Amount || '.');
        END IF;
        
        DBMS_OUTPUT.PUT_LINE('TRIGGER: CheckTransactionRules - Deposit of $' || 
                             :NEW.Amount || ' approved for Account ' || :NEW.AccountID);
    END IF;
END;
/

-- Test Cases for CheckTransactionRules
-- Test 1: Valid deposit (should succeed)
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('TEST 1: Valid Deposit ($100)');
    DBMS_OUTPUT.PUT_LINE('============================================');
    
    INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
    VALUES (4, 1, SYSDATE, 100, 'Deposit');
    
    DBMS_OUTPUT.PUT_LINE('Transaction inserted successfully.');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

-- Test 2: Withdrawal exceeding balance (should fail)
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('TEST 2: Withdrawal Exceeding Balance ($999,999)');
    DBMS_OUTPUT.PUT_LINE('============================================');
    
    INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
    VALUES (5, 1, SYSDATE, 999999, 'Withdrawal');
    
    DBMS_OUTPUT.PUT_LINE('Transaction inserted successfully.');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Correctly rejected: ' || SQLERRM);
        ROLLBACK;
END;
/

-- Test 3: Negative deposit (should fail)
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('TEST 3: Negative Deposit (-50)');
    DBMS_OUTPUT.PUT_LINE('============================================');
    
    INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
    VALUES (6, 1, SYSDATE, -50, 'Deposit');
    
    DBMS_OUTPUT.PUT_LINE('Transaction inserted successfully.');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Correctly rejected: ' || SQLERRM);
        ROLLBACK;
END;
/
