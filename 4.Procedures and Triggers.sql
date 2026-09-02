CREATE DATABASE PracticalDB;
USE PracticalDB;

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Phone VARCHAR(15),
    City VARCHAR(30)
);

CREATE TABLE Account (
    AccountNo INT PRIMARY KEY,
    CustomerID INT,
    AccountType VARCHAR(20),
    Balance DECIMAL(10,2)
);

CREATE TABLE Bank_Transaction (
    TransactionID INT PRIMARY KEY,
    AccountNo INT,
    TransactionType VARCHAR(20),
    Amount DECIMAL(10,2)
);

CREATE TABLE Loan (
    LoanID INT PRIMARY KEY,
    CustomerID INT,
    LoanType VARCHAR(30),
    Amount DECIMAL(10,2)
);

INSERT INTO Customer VALUES
(101,'Rahul','9876543210','Hyderabad'),
(102,'Priya','9876543211','Bangalore'),
(103,'Kiran','9876543212','Chennai'),
(104,'Sneha','9876543213','Mumbai');

INSERT INTO Account VALUES
(1001,101,'Savings',25000.00),
(1002,102,'Current',40000.00),
(1003,103,'Savings',18000.00),
(1004,104,'Savings',32000.00);

INSERT INTO Bank_Transaction VALUES
(1,1001,'Deposit',5000.00),
(2,1002,'Withdrawal',3000.00),
(3,1003,'Deposit',7000.00),
(4,1004,'Withdrawal',2000.00);

INSERT INTO Loan VALUES
(201,101,'Home Loan',500000.00),
(202,102,'Car Loan',300000.00),
(203,103,'Education Loan',200000.00);

DELIMITER //

CREATE PROCEDURE GetAllCustomers()
BEGIN
    SELECT *
    FROM Customer;
END //

DELIMITER ;

CALL GetAllCustomers();

DELIMITER //

CREATE PROCEDURE GetCustomerByID(IN p_customerid INT)
BEGIN
    SELECT *
    FROM Customer
    WHERE CustomerID = p_customerid;
END //

DELIMITER ;

CALL GetCustomerByID(102);

DELIMITER //

CREATE PROCEDURE GetAccountBalance(IN p_accountno INT, OUT p_balance DECIMAL(10,2))
BEGIN
    SELECT Balance
    INTO p_balance
    FROM Account
    WHERE AccountNo = p_accountno;
END //

DELIMITER ;

CALL GetAccountBalance(1001,@balance);

SELECT @balance;

CREATE TABLE Transaction_Audit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    TransactionID INT,
    AccountNo INT,
    TransactionType VARCHAR(20),
    Amount DECIMAL(10,2),
    ActionDate DATETIME
);

DELIMITER //

CREATE TRIGGER trg_transaction_insert
AFTER INSERT ON Bank_Transaction
FOR EACH ROW
BEGIN
    INSERT INTO Transaction_Audit
    (TransactionID,AccountNo,TransactionType,Amount,ActionDate)
    VALUES
    (NEW.TransactionID,NEW.AccountNo,NEW.TransactionType,NEW.Amount,NOW());
END //

DELIMITER ;

INSERT INTO Bank_Transaction VALUES
(5,1001,'Deposit',6000.00);

SELECT *
FROM Transaction_Audit;

DELIMITER //

CREATE TRIGGER trg_check_transaction
BEFORE INSERT ON Bank_Transaction
FOR EACH ROW
BEGIN
    IF NEW.Amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaction amount must be greater than zero';
    END IF;
END //

DELIMITER ;

SHOW PROCEDURE STATUS
WHERE Db = 'PracticalDB';

SHOW TRIGGERS;