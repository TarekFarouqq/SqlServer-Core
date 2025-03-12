use ITI
-- (1)
SELECT COUNT(*) AS NumberOfStudentsWithAge
FROM Student
WHERE St_Age IS NOT NULL;

--(2)
SELECT DISTINCT Ins_Name
FROM Instructor;


--(3)
SELECT St_id, ISNULL(st_fname, '') +' '+ ISNULL(st_lname, '') AS FullName,  ISNULL(dept_name, '') AS DepartmentName
FROM Student s JOIN Department d
ON  s.Dept_Id = d.Dept_Id;

--(4)

SELECT Ins_Name, ISNULL(dept_name, '') AS DepartmentName
FROM Instructor i LEFT JOIN Department d
ON  i.Dept_Id = d.Dept_Id;

--(5)
select  s.st_fname  +' '+ s.st_lname AS FullName , c.crs_name ,grade
FROM Student s join Stud_Course sc on sc.st_id = s.St_Id 
join  Course C ON SC.Crs_id = C.Crs_id 
WHERE SC.Grade IS NOT NULL;

--(6)

SELECT T.Top_Name, COUNT(C.Crs_ID) AS NumberOfCourses
FROM Topic T
JOIN Course C ON T.Top_ID = C.Top_ID
GROUP BY T.Top_Name;

--(7)
SELECT  MAX(Salary) AS MaxSalary,  MIN(Salary) AS MinSalary
FROM Instructor;

--(8)

SELECT Ins_Name, Salary
FROM Instructor
WHERE Salary < (SELECT AVG(Salary) FROM Instructor);


--(9)

SELECT Dept_Name
FROM Department D
JOIN Instructor I ON D.Dept_ID = I.Dept_ID
WHERE Salary = (SELECT MIN(Salary) FROM Instructor);


--(10)
SELECT TOP(2) Salary
FROM Instructor
ORDER BY Salary DESC;

--(11)

SELECT 
    Ins_Name, 
    COALESCE(cast (Salary as varchar), 'Bonus') AS SalaryOrBonus
FROM Instructor;

--(12)

SELECT AVG(Salary) AS AverageSalary
FROM Instructor;

--(13)
SELECT  S.St_Fname AS StudentName , * 
FROM Student S  JOIN Student super ON S.St_super = super.st_id;

-- (14)
SELECT *
From (select dept_id ,ins_name, salary , ROW_number() over (partition by dept_id order by salary desc ) as r  from instructor ) as rankedSalary 
where r <= 2 ; 

--(15)
select * from (select  St_Id, St_Fname,  Dept_Id, 

Row_number() over (partition by Dept_Id order by NEWID() desc) as RowNum from Student) as RankedSalaries
where RowNum = 1;

