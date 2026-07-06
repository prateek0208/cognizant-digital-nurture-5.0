-- ============================================================================
-- File: Schema_Setup.sql
-- Description: Creates the complete database schema for the Banking System
--              PL/SQL Assignment. Run this script FIRST before any exercises.
-- Week: 3 - PL/SQL Programming
-- Author: Prateek
-- ============================================================================

-- ============================================================================
-- SECTION 1: CLEANUP - Drop existing objects in reverse dependency order
-- ============================================================================

DROP TABLE Transactions CASCADE CONSTRAINTS;
DROP TABLE Loans CASCADE CONSTRAINTS;
DROP TABLE Accounts CASCADE CONSTRAINTS;
DROP TABLE Customers CASCADE CONSTRAINTS;
DROP TABLE Employees CASCADE CONSTRAINTS;
DROP TABLE AuditLog CASCADE CONSTRAINTS;

DROP SEQUENCE audit_log_seq;

-- ============================================================================
-- SECTION 2: CREATE TABLES
-- ============================================================================

-- Customers Table: Stores customer personal and account information
CREATE TABLE Customers (
    CustomerID   NUMBER        PRIMARY KEY,
    Name         VARCHAR2(100),
    DOB          DATE,
    Balance      NUMBER,
    LastModified DATE,
    IsVIP        VARCHAR2(5)   DEFAULT 'FALSE'
);

-- Accounts Table: Stores individual bank accounts linked to customers
CREATE TABLE Accounts (
    AccountID    NUMBER        PRIMARY KEY,
    CustomerID   NUMBER,
    AccountType  VARCHAR2(20),
    Balance      NUMBER,
    LastModified DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Transactions Table: Records all financial transactions
CREATE TABLE Transactions (
    TransactionID   NUMBER        PRIMARY KEY,
    AccountID       NUMBER,
    TransactionDate DATE,
    Amount          NUMBER,
    TransactionType VARCHAR2(10),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

-- Loans Table: Stores loan information for customers
CREATE TABLE Loans (
    LoanID       NUMBER PRIMARY KEY,
    CustomerID   NUMBER,
    LoanAmount   NUMBER,
    InterestRate NUMBER,
    StartDate    DATE,
    EndDate      DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Employees Table: Stores bank employee information
CREATE TABLE Employees (
    EmployeeID NUMBER        PRIMARY KEY,
    Name       VARCHAR2(100),
    Position   VARCHAR2(50),
    Salary     NUMBER,
    Department VARCHAR2(50),
    HireDate   DATE
);

-- AuditLog Table: Maintains audit trail of all transactions (used by triggers)
CREATE TABLE AuditLog (
    LogID           NUMBER PRIMARY KEY,
    TransactionID   NUMBER,
    AccountID       NUMBER,
    Amount          NUMBER,
    TransactionType VARCHAR2(10),
    TransactionDate DATE,
    LogTimestamp    DATE
);

-- ============================================================================
-- SECTION 3: CREATE SEQUENCES
-- ============================================================================

CREATE SEQUENCE audit_log_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- ============================================================================
-- SECTION 4: INSERT SAMPLE DATA
-- ============================================================================

-- Customers
INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (1, 'John Doe', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 1000, SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (2, 'Jane Smith', TO_DATE('1990-07-20', 'YYYY-MM-DD'), 1500, SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (3, 'Robert Wilson', TO_DATE('1955-03-10', 'YYYY-MM-DD'), 15000, SYSDATE);

-- Accounts
INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (1, 1, 'Savings', 1000, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (2, 2, 'Checking', 1500, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (3, 3, 'Savings', 15000, SYSDATE);

-- Transactions
INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (1, 1, SYSDATE, 200, 'Deposit');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (2, 2, SYSDATE, 300, 'Withdrawal');

-- Loans
INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (1, 1, 5000, 5, SYSDATE, ADD_MONTHS(SYSDATE, 60));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (2, 3, 10000, 6, ADD_MONTHS(SYSDATE, -55), SYSDATE + 15);

-- Employees
INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (1, 'Alice Johnson', 'Manager', 70000, 'HR', TO_DATE('2015-06-15', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (2, 'Bob Brown', 'Developer', 60000, 'IT', TO_DATE('2017-03-20', 'YYYY-MM-DD'));

COMMIT;

-- ============================================================================
-- Schema setup and sample data insertion complete.
-- Run the Exercise files next.
-- ============================================================================
