DROP DATABASE IF EXISTS bookflow_db;
CREATE DATABASE bookflow_db;
USE bookflow_db;
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    published_year INT CHECK (published_year < 2027)
);

INSERT INTO Books (book_id, title, isbn, published_year) VALUES
(11, 'Harry Potter and the Sorcerer''s Stone', '9780590353427', 1997),
(12, 'The Lord of the Rings', '9780544003415', 1954),
(13, 'The Catcher in the Rye', '9780316769488', 1951);

SELECT * FROM Books;
CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);

INSERT INTO Members (member_id, full_name, email) VALUES
(101, 'Aarav Sharma', 'aarav.sharma@email.com'),
(102, 'Priya Patel', 'priya.patel@email.com'),
(103, 'Daniel Thomas', 'daniel.thomas@email.com');

SELECT * FROM Members;
CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    member_id INT,
    book_id INT,
    loan_date DATE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

INSERT INTO Loans (loan_id, member_id, book_id, loan_date) VALUES
(21, 101, 12, '2025-01-03'),
(22, 102, 11, '2025-01-07'),
(23, 103, 13, '2025-01-12'),
(24, 101, 13, '2025-02-04'),
(25, 102, 12, '2025-02-09'),
(26, 103, 11, '2025-02-15'),
(27, 101, 11, '2025-03-02'),
(28, 102, 13, '2025-03-11'),
(29, 103, 12, '2025-03-18'),
(30, 102, 11, '2025-04-05');

SELECT * FROM Loans;
SELECT 
    m.full_name AS Member_Name,
    b.title AS Book_Title
FROM Loans l
INNER JOIN Members m
    ON l.member_id = m.member_id
INNER JOIN Books b
    ON l.book_id = b.book_id;
SELECT 
    published_year,
    COUNT(book_id) AS Total_Books
FROM Books
GROUP BY published_year
ORDER BY published_year;
CREATE TABLE Donation_History (
    donation_id INT PRIMARY KEY,
    book_id INT,
    donor_name VARCHAR(100),
    donation_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

START TRANSACTION;
INSERT INTO Books (
    book_id,
    title,
    isbn,
    published_year
)
VALUES (
    14,
    'The Da Vinci Code',
    '9780307474278',
    2003
);

INSERT INTO Donation_History (
    donation_id,
    book_id,
    donor_name,
    donation_date
)
VALUES (
    51,
    14,
    'Neha Verma',
    CURDATE()
);
COMMIT;
CREATE INDEX idx_books_isbn
ON Books(isbn);
SELECT *
FROM Books
WHERE isbn = '9780590353427';