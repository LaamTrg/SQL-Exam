CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    ClassID INT,
    BirthDate DATE,
    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
);

CREATE TABLE Classes (
    ClassID INT PRIMARY KEY,
    ClassName VARCHAR(50),
    TeacherID INT,
    FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID)
);

CREATE TABLE Teachers (
    TeacherID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Subject VARCHAR(50)
);


INSERT INTO Teachers (TeacherID, FirstName, LastName, Subject) 
VALUES (1, 'John', 'Smith', 'Math'),
       (2, 'Alice', 'Johnson', 'English'),
       (3, 'Michael', 'Williams', 'Science');

INSERT INTO Classes (ClassID, ClassName, TeacherID) 
VALUES (1, 'Mathematics', 1),
       (2, 'English Literature', 2),
       (3, 'Physics', 3),
       (4, 'History', 2),
       (5, 'Biology', 3);

INSERT INTO Students (StudentID, FirstName, LastName, ClassID, BirthDate) 
VALUES (1, 'Emma', 'Johnson', 1, '2003-05-10'),
       (2, 'Liam', 'Brown', 2, '2002-08-15'),
       (3, 'Olivia', 'Davis', 3, '2001-02-20'),
       (4, 'Noah', 'Garcia', 1, '2004-11-30'),
       (5, 'Ava', 'Martinez', 2, '2003-04-25'),
       (6, 'William', 'Clark', 4, '2002-10-05'),
       (7, 'Isabella', 'Rodriguez', 5, '2000-07-12'),
       (8, 'James', 'Wilson', 3, '2005-01-18'),
       (9, 'Sophia', 'Anderson', 4, '2001-09-22'),
       (10, 'Alexander', 'Taylor', 5, '2003-12-08');


SELECT s.FirstName, s.LastName, c.ClassName, t.FirstName AS TeacherFirstName, t.LastName AS TeacherLastName
FROM Students s
JOIN Classes c ON s.ClassID = c.ClassID
JOIN Teachers t ON c.TeacherID = t.TeacherID;


SELECT * FROM Students WHERE YEAR(BirthDate) >= 2000;


SELECT s.FirstName, s.LastName, c.ClassName, t.FirstName AS TeacherFirstName, t.LastName AS TeacherLastName
FROM Students s
JOIN Classes c ON s.ClassID = c.ClassID
JOIN Teachers t ON c.TeacherID = t.TeacherID
ORDER BY s.FirstName, s.LastName;


UPDATE Students SET FirstName = 'John', LastName = 'Doe' WHERE StudentID = 3;


DELETE FROM Students WHERE StudentID = 7;


DELIMITER //
CREATE PROCEDURE GetStudentsByClassAndSubject (IN ClassIDParam INT, IN SubjectParam VARCHAR(50))
BEGIN
    SELECT s.FirstName, s.LastName
    FROM Students s
    JOIN Classes c ON s.ClassID = c.ClassID
    JOIN Teachers t ON c.TeacherID = t.TeacherID
    WHERE c.ClassID = ClassIDParam AND t.Subject = SubjectParam;
END //
DELIMITER ;


CREATE VIEW StudentsWithClassAndTeacher AS
SELECT s.FirstName, s.LastName, c.ClassName, t.FirstName AS TeacherFirstName, t.LastName AS TeacherLastName
FROM Students s
JOIN Classes c ON s.ClassID = c.ClassID
JOIN Teachers t ON c.TeacherID = t.TeacherID;
