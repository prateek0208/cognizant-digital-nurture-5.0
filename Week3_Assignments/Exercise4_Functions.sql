-- ============================================================================
-- File: 05_exercise4_functions.sql
-- Description: Exercise 4 - Functions
--              Demonstrates creating and using PL/SQL functions for
--              age calculation, EMI computation, and balance checking.
-- Author: Prateek
-- ============================================================================

SET SERVEROUTPUT ON;

-- ============================================================================
-- SCENARIO 1: Calculate Customer Age
-- 
-- Business Rule: Calculate the age of customers for eligibility checks.
-- Approach: Use MONTHS_BETWEEN to calculate the difference between SYSDATE
--           and DOB, then divide by 12 and floor the result.
-- ============================================================================

CREATE OR REPLACE FUNCTION CalculateAge (
    p_dob IN DATE   -- Customer's date of birth
)
RETURN NUMBER
AS
    v_age NUMBER;
BEGIN
    -- Calculate age by finding months between current date and DOB
    -- Divide by 12 to get years, and use FLOOR to get complete years
    v_age := FLOOR(MONTHS_BETWEEN(SYSDATE, p_dob) / 12);
    
    RETURN v_age;
END CalculateAge;
/

-- Test Cases for CalculateAge
DECLARE
    v_age NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('TEST: CalculateAge Function');
    DBMS_OUTPUT.PUT_LINE('============================================');
    
    -- Test with different dates of birth
    v_age := CalculateAge(TO_DATE('1985-05-15', 'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('DOB: 1985-05-15 | Age: ' || v_age || ' years');
    
    v_age := CalculateAge(TO_DATE('1990-07-20', 'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('DOB: 1990-07-20 | Age: ' || v_age || ' years');
    
    v_age := CalculateAge(TO_DATE('1955-03-10', 'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('DOB: 1955-03-10 | Age: ' || v_age || ' years');
    
    -- Test using customer data from the table
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Customer Ages from Database:');
    FOR rec IN (SELECT Name, DOB FROM Customers) LOOP
        DBMS_OUTPUT.PUT_LINE('  ' || rec.Name || ': ' || 
                             CalculateAge(rec.DOB) || ' years old');
    END LOOP;
END;
/


-- ============================================================================
-- SCENARIO 2: Calculate Monthly Installment (EMI)
-- 
-- Business Rule: The bank needs to compute the monthly installment for a loan.
-- Formula: EMI = P * r * (1+r)^n / ((1+r)^n - 1)
--   where:
--     P = Loan principal amount
--     r = Monthly interest rate (annual rate / 12 / 100)
--     n = Total number of monthly installments (years * 12)
-- ============================================================================

CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment (
    p_loan_amount   IN NUMBER,  -- Principal loan amount (P)
    p_interest_rate IN NUMBER,  -- Annual interest rate in percentage
    p_years         IN NUMBER   -- Loan duration in years
)
RETURN NUMBER
AS
    v_monthly_rate  NUMBER;     -- Monthly interest rate (r)
    v_num_months    NUMBER;     -- Total number of months (n)
    v_emi           NUMBER;     -- Calculated EMI
    v_power_factor  NUMBER;     -- (1+r)^n - pre-calculated for efficiency
BEGIN
    -- Calculate monthly interest rate: annual rate / 12 / 100
    v_monthly_rate := p_interest_rate / 12 / 100;
    
    -- Calculate total number of monthly installments
    v_num_months := p_years * 12;
    
    -- Handle edge case: zero interest rate (simple division)
    IF v_monthly_rate = 0 THEN
        v_emi := p_loan_amount / v_num_months;
        RETURN ROUND(v_emi, 2);
    END IF;
    
    -- Calculate (1 + r)^n using POWER function
    v_power_factor := POWER(1 + v_monthly_rate, v_num_months);
    
    -- Apply EMI formula: P * r * (1+r)^n / ((1+r)^n - 1)
    v_emi := p_loan_amount * v_monthly_rate * v_power_factor / (v_power_factor - 1);
    
    -- Return EMI rounded to 2 decimal places
    RETURN ROUND(v_emi, 2);
END CalculateMonthlyInstallment;
/

-- Test Cases for CalculateMonthlyInstallment
DECLARE
    v_emi NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('TEST: CalculateMonthlyInstallment Function');
    DBMS_OUTPUT.PUT_LINE('============================================');
    
    -- Test 1: $5,000 loan at 5% for 5 years
    v_emi := CalculateMonthlyInstallment(5000, 5, 5);
    DBMS_OUTPUT.PUT_LINE('Loan: $5,000 | Rate: 5% | Duration: 5 years');
    DBMS_OUTPUT.PUT_LINE('Monthly EMI: $' || v_emi);
    
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    
    -- Test 2: $10,000 loan at 6% for ~5 years
    v_emi := CalculateMonthlyInstallment(10000, 6, 5);
    DBMS_OUTPUT.PUT_LINE('Loan: $10,000 | Rate: 6% | Duration: 5 years');
    DBMS_OUTPUT.PUT_LINE('Monthly EMI: $' || v_emi);
    
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    
    -- Test 3: Calculate EMI for loans in the database
    DBMS_OUTPUT.PUT_LINE('EMI Calculations for Existing Loans:');
    FOR rec IN (SELECT l.LoanID, l.LoanAmount, l.InterestRate, 
                       ROUND(MONTHS_BETWEEN(l.EndDate, l.StartDate) / 12, 1) AS Years,
                       c.Name
                FROM Loans l 
                JOIN Customers c ON l.CustomerID = c.CustomerID) LOOP
        v_emi := CalculateMonthlyInstallment(rec.LoanAmount, rec.InterestRate, rec.Years);
        DBMS_OUTPUT.PUT_LINE('  Loan ' || rec.LoanID || ' (' || rec.Name || '): $' || 
                             rec.LoanAmount || ' at ' || rec.InterestRate || 
                             '% for ' || rec.Years || ' yrs = $' || v_emi || '/month');
    END LOOP;
END;
/


-- ============================================================================
-- SCENARIO 3: Check Sufficient Balance
-- 
-- Business Rule: Check if a customer has sufficient balance before making
--                a transaction. Returns TRUE if balance >= amount.
-- Approach: Query the account balance and compare with the requested amount.
--           Handle NO_DATA_FOUND for invalid account IDs.
-- Note: Since BOOLEAN cannot be used in SQL SELECT statements, we use a
--       PL/SQL block to demonstrate the function.
-- ============================================================================

CREATE OR REPLACE FUNCTION HasSufficientBalance (
    p_account_id IN NUMBER,     -- Account ID to check
    p_amount     IN NUMBER      -- Amount to verify against
)
RETURN BOOLEAN
AS
    v_balance NUMBER;
BEGIN
    -- Fetch the current balance of the specified account
    SELECT Balance INTO v_balance
    FROM Accounts
    WHERE AccountID = p_account_id;
    
    -- Return TRUE if balance is sufficient, FALSE otherwise
    IF v_balance >= p_amount THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Account does not exist - return FALSE
        RETURN FALSE;
END HasSufficientBalance;
/

-- Test Cases for HasSufficientBalance
DECLARE
    v_result BOOLEAN;
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('TEST: HasSufficientBalance Function');
    DBMS_OUTPUT.PUT_LINE('============================================');
    
    -- Test 1: Account 1 with $500 (should have sufficient balance)
    v_result := HasSufficientBalance(1, 500);
    IF v_result THEN
        DBMS_OUTPUT.PUT_LINE('Account 1, Amount $500: TRUE (Sufficient)');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Account 1, Amount $500: FALSE (Insufficient)');
    END IF;
    
    -- Test 2: Account 1 with $999999 (should NOT have sufficient balance)
    v_result := HasSufficientBalance(1, 999999);
    IF v_result THEN
        DBMS_OUTPUT.PUT_LINE('Account 1, Amount $999,999: TRUE (Sufficient)');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Account 1, Amount $999,999: FALSE (Insufficient)');
    END IF;
    
    -- Test 3: Account 3 with $10000 (high balance account)
    v_result := HasSufficientBalance(3, 10000);
    IF v_result THEN
        DBMS_OUTPUT.PUT_LINE('Account 3, Amount $10,000: TRUE (Sufficient)');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Account 3, Amount $10,000: FALSE (Insufficient)');
    END IF;
    
    -- Test 4: Non-existent account (should return FALSE)
    v_result := HasSufficientBalance(999, 100);
    IF v_result THEN
        DBMS_OUTPUT.PUT_LINE('Account 999, Amount $100: TRUE (Sufficient)');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Account 999, Amount $100: FALSE (Account not found)');
    END IF;
END;
/
