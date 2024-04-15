CREATE DATABASE Library;

USE Library;

CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(300),
    Contact_no VARCHAR(20)
);

CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(50),
    Position VARCHAR(40),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(50),
    Customer_address VARCHAR(300),
    Reg_date DATE
);

CREATE TABLE Books (
    ISBN VARCHAR(50) PRIMARY KEY,
    Book_title VARCHAR(200),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10, 2),
    Status ENUM('yes', 'no'),
    Author VARCHAR(50),
    Publisher VARCHAR(50)
);

CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(200),
    Issue_date DATE,
    Isbn_book VARCHAR(50),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(200),
    Return_date DATE,
    Isbn_book2 VARCHAR(50),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES
(1, 101, 'Attingal, Trivandrum', '9995988709'),
(2, 102, 'Varkala, Trivandrum', '7789546125'),
(3, 103, 'Edappally, Ernakulam', '95000958783'),
(4, 104, 'Thalassery, Kozhikode', '8745632585'),
(5, 105, 'Kodungallur, Thrissur','8564334560');

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES
(201, 'Arun', 'Librarian', 50000, 1),
(202, 'Arjun', 'Clerk', 30000, 1),
(203, 'Amal', 'Librarian', 35000, 2),
(204, 'Abraham', 'Clerk', 50000, 2),
(205, 'Nithya', 'Librarian', 53000.00, 2),
(206, 'Arun', 'Clerk', 50000.00, 1),
(207, 'Krishna', 'Librarian', 40000.00, 1),
(208, 'Deepak', 'Clerk', 50000.00, 2),
(209, 'Rebecca', 'Librarian', 45000.00, 2),
(210, 'Nithin', 'Librarian', 58000.00, 1);
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES
(301, 'Harris', 'Neyyattinkara, Trivandrum', '2022-05-11'),
(302, 'Robert', 'Nemom , Trivandrum', '2021-03-10'),
(303, 'Xavier', 'Kochi, Ernakulam', '2021-01-21'),
(304, 'Doney', 'Tirur , Malappuram', '2022-10-08'),
(305, 'Alan', 'Tanur , Malappuram', '2022-05-30');

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES
('7894561236977', 'The Lottery', 'Fiction', 9.99, 'yes', 'Shirley', 'DC Books'),
('5874693214577', 'Snow White', 'Fiction', 8.49, 'no', 'Jacob', 'DC Books'),
('4786951236687', 'Girl', 'short story', 5.99, 'no', 'Jamaica', 'DC Books'),
('9895741236526', 'The student', 'short story', 15.89, 'yes', 'Anton', 'DC Books'),
('9780061120179', 'The India', 'History', 7.49, 'yes', 'Guy de', 'DC Books');


INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES
(401, 301, 'The Lottery', '2023-04-10', '7894561236977'),
(402, 302, 'Snow White', '2023-01-15', '5874693214577'),
(403, 303, 'Girl', '2023-05-18', '4786951236687'),
(404, 304, 'The student', '2023-09-24', '9895741236526'),
(405, 305, 'The India', '2023-08-11', '9780061120179');

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES
(501, 301, 'The Lottery', '2023-09-10', '7894561236977'),
(502, 302, 'Girl', '2023-08-18', '4786951236687'),
(503, 304, 'The India', '2023-12-12', '9780061120179');

# 1. Retrieve the book title, category, and rental price of all available books.

SELECT Book_title,Category, Rental_Price FROM Books Where Status = 'yes';

# 2. List the employee names and their respective salaries in descending order of salary.

SELECT Emp_name, Salary FROM Employee ORDER BY Salary DESC;

# 3. Retrieve the book titles and the corresponding customers who have issued those books.

SELECT Books.Book_title, Customer.Customer_name FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;

# 4. Display the total count of books in each category.

SELECT Category, COUNT(Category) AS Total_Count FROM Books GROUP BY Category;

# 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.

SELECT Emp_name, Position FROM Employee WHERE Salary > 50000;

# 6. List the customer names who registered before 2022-01-01 and have not issued any books yet.

SELECT Customer_name FROM Customer WHERE Reg_date < '2022-01-01' AND Customer_Id NOT IN ( SELECT Issued_cust FROM IssueStatus);

# 7. Display the branch numbers and the total count of employees in each branch.

SELECT Branch_no, count(Emp_name) AS Total_Count_Of_Employees FROM Employee GROUP BY Branch_no;

# 8. Display the names of customers who have issued books in the month of June 2023.

SELECT DISTINCT Customer.Customer_name FROM Customer JOIN IssueStatus ON Customer.Customer_Id = IssueStatus.Issued_cust
WHERE MONTH(IssueStatus.Issue_date) = 6 AND YEAR(IssueStatus.Issue_date) = 2023;

# 9. Retrieve book_title from book table containing history.

SELECT Book_title FROM Books WHERE Category = 'History';

# 10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.

SELECT Branch_no, Count(*) AS Count_Of_Employees From Employee GROUP BY Branch_no HAVING Count(*) > 5;




