
--Creating a Table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    BirthDate DATE,
    Gender CHAR(1)
);

--Inserting Data into a Table
INSERT INTO Students (StudentID, FirstName, LastName, BirthDate, Gender)
VALUES (1, 'John', 'Doe', '2005-09-15', 'M');

INSERT INTO Students (StudentID, FirstName, LastName, BirthDate, Gender)
VALUES (2, 'Jane', 'Smith', '2006-05-20', 'F');

--Selecting Data from a Table
SELECT * FROM Students;

--Filtering Data
SELECT * FROM Students
WHERE Gender = 'F';

--Updating Data
UPDATE Students
SET LastName = 'Johnson'
WHERE StudentID = 1;

--Deleting Data
DELETE FROM Students
WHERE StudentID = 2;

--Adding a New Column
ALTER TABLE Students
ADD Email NVARCHAR(100);

--Using Aggregate Functions
SELECT COUNT(*) AS TotalStudents FROM Students;

--Joining Tables
CREATE TABLE Classes (
    ClassID INT PRIMARY KEY,
    ClassName NVARCHAR(50)
);

-- Adding data to Classes table
INSERT INTO Classes (ClassID, ClassName) VALUES (1, 'Math'), (2, 'Science');

-- Creating a StudentClasses table to link students with classes
CREATE TABLE StudentClasses (
    StudentID INT,
    ClassID INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
);

-- Adding data to StudentClasses table
INSERT INTO StudentClasses (StudentID, ClassID) VALUES (1, 1), (2, 2);

-- Joining Students with Classes
SELECT s.FirstName, s.LastName, c.ClassName
FROM Students s
JOIN StudentClasses sc ON s.StudentID = sc.StudentID
JOIN Classes c ON sc.ClassID = c.ClassID;

