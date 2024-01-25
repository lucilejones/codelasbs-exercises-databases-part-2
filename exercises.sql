-- Exercise 1: insert data into a Customers table
CREATE TABLE Customers (
    CustomerID INTEGER,
    Name TEXT,
    Email TEXT
);

INSERT INTO Customers (CustomerID, Name, Email)
VALUES (1, 'Alice Johnson', 'alice.johnson@email.com'),
    (2, 'Bob Smith', 'bob.smith@email.com'),
    (3, 'Charlie Brown', 'charlie.brown@email.com');


-- Exercise 2: update the email address of a specific customer
UPDATE Customers
SET Email = 'bob.smith@newdomain.com'
WHERE CustomerID = 2;


-- Exercise 3: delete a customer from the Customers table
DELETE FROM Customers
WHERE CustomerID = 3;


-- Exercise 4: retrieve detailed order information
-- tables - customers, orders, books
-- display the customer name, book title, and quantity for all orders
CREATE TABLE Customers (
    CustomerID INTEGER,
    Name TEXT,
    Email TEXT,
    Address TEXT
);

CREATE TABLE Books (
    BookID INTEGER,
    Title TEXT,
    Author TEXT
);

CREATE TABLE Orders (
    OrderID INTEGER,
    CustomerID INTEGER,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderItems (
    BookID INTEGER,
    OrderID INTEGER,
    Quantity INTEGER,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

INSERT INTO Customers (CustomerID, Name, Email, Address)
VALUES (10, 'Ruby Johnson', 'ruby.johnson@email.com', '123 Strawberry Lane, Placetown, UT 54982'),
        (20, 'Samuel Arnold', 'samtheman@email.com', '483 Rewind Road, Here, TN 84922');

INSERT INTO Books (BookID, Title, Author)
VALUES (111, 'Carry On', 'Rainbow Rowell'),
        (222, 'Everything is Illuminated', 'Jonathan Safran Foer'),
        (333, 'Pride and Prejudice', 'Jane Austen');

INSERT INTO Orders (OrderID, CustomerID)
VALUES (1, 10), (2, 10), (3, 20);

INSERT INTO OrderItems (BookID, OrderID, Quantity)
VALUES (111, 1, 12), (222, 1, 4), (333, 2, 1), (111, 3, 2);

SELECT Orders.OrderID, Customers.Name AS CustomerName, Books.Title AS BookTitle, OrderItems.Quantity AS Quantity
FROM Orders INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
INNER JOIN OrderItems ON Orders.OrderID = OrderItems.OrderID
INNER JOIN Books ON OrderItems.BookID = Books.BookID;


-- Exercise 5: normalize a denormalized table
-- start with table StudentGrades - StudentID, Name, Subject, Grade
-- split into two tables: Students - StudentID, Name and Grades - StudentID, Subject, Grade

CREATE TABLE Students (
    StudentID INTEGER,
    Name TEXT
);

CREATE TABLE Grades (
    StudentID INTEGER,
    Subject TEXT,
    Grade FLOAT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

INSERT INTO Students (StudentID, Name)
VALUES (87463, 'Emerson Riley'), (98327, 'Yolanda Weeks'), (12765, 'Ryanne Mane');

INSERT INTO Grades (StudentID, Subject, Grade)
VALUES (87463, 'Intro to Computer Programming', 87.5),
        (87463, 'Biology 101', 92.9),
        (98327, 'Psycholinguistics', 98.0),
        (12765, 'Intermediate Swimming', 89.4),
        (12765, 'Intro to Guitar', 100);

SELECT Students.Name AS StudentName, Grades.Subject AS Subject, Grades.Grade AS Grade
FROM Students INNER JOIN Grades ON Students.StudentID = Grades.StudentID;
