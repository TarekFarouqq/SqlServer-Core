use Company_SD

/*(1)*/

SELECT d.Dependent_name, d.Sex
FROM Dependent d
JOIN Employee e ON   d.ESSN = e.SSN
WHERE e.Sex = 'F' and d.Sex = 'F'
UNION
SELECT d.Dependent_name, d.Sex
  FROM Dependent d
JOIN Employee e ON d.ESSN = e.SSN
WHERE  e.Sex = 'M';

/*(2)*/

SELECT p.Pname AS Project_Name, SUM(w.Hours) AS Total_Hours
FROM Project p
JOIN Works_For w ON p.Pnumber = w.Pno
GROUP BY p.Pname;


/*(3)*/

SELECT d.*
FROM Departments d
WHERE d.Dnum = ( SELECT TOP 1 e.Dno FROM Employee e ORDER BY e.SSN ASC);

/*(4)*/

SELECT d.Dname AS Department_Name,  MAX(e.Salary) AS Max_Salary, MIN(e.Salary) AS Min_Salary, AVG(e.Salary) AS Avg_Salary
FROM Departments d JOIN Employee e 
ON d.Dnum = e.Dno
GROUP BY d.Dname;


/*(5)*/
SELECT e.Fname AS Manager_Name
FROM Employee e
WHERE e.SSN IN (SELECT d.MGRSSN FROM Departments d) AND e.SSN NOT IN (SELECT dep.ESSN FROM Dependent dep);



/*(6)*/

SELECT d.Dnum AS Department_Number, d.Dname AS Department_Name,  COUNT(e.SSN) AS Number_of_Employees
FROM Departments d JOIN Employee e
ON d.Dnum = e.Dno
GROUP BY d.Dnum, d.Dname
HAVING AVG(e.Salary) < (SELECT AVG(emp.Salary) FROM Employee emp);


/*(7)*/

SELECT e.Fname +' '+ e.Lname AS Employee_Name, p.Pname AS Project_Name
FROM Employee e JOIN Works_For w 
ON e.SSN = w.ESSn JOIN Project p 
ON w.Pno = p.Pnumber
ORDER BY e.Dno, e.Lname, e.Fname;


/*(8)*/
SELECT MAX(Salary) AS Salary
FROM Employee
UNION
SELECT MAX(Salary) AS Salary
FROM Employee
WHERE Salary < (SELECT MAX(Salary) FROM Employee);

/*(9)*/

SELECT e.Fname +' '+ e.Lname AS Employee_Name
FROM Employee e
WHERE e.Fname +' '+ e.Lname IN (SELECT d.Dependent_name FROM Dependent d);


/*(10)*/

SELECT e.SSN , e.Fname +' '+ e.Lname AS Employee_Name
FROM Employee e
WHERE EXISTS ( SELECT 1 FROM Dependent d WHERE d.ESSN = e.SSN);


/*(11)*/

INSERT INTO Departments (Dname, Dnum, MGRSSN, [MGRStart Date])
VALUES ('DEPT IT', 100, 112233, '2006-11-01 ');

/*(12)*/
/*(a)*/

UPDATE Departments 
SET Departments.MGRSSN = 968574
WHERE Departments.Dnum = 100;

/*(b)*/
UPDATE Departments 
SET Departments.MGRSSN = 102672
WHERE Departments.Dnum = 20;

/*(c)*/
UPDATE Employee
SET Superssn = 102672
WHERE SSN = 102660;


/*(13)*/
/*(a)*/
DELETE FROM Dependent WHERE ESSN = 223344;

/*(b)*/
UPDATE Departments SET MGRSSN = 102672 WHERE MGRSSN = 223344;

/*(c)*/
UPDATE Employee SET Superssn = 102672 WHERE Superssn = 223344;

/*(d)*/
DELETE FROM Works_For WHERE ESSn = 223344;

/*(e)*/
DELETE FROM Employee WHERE SSN = 223344;

/*(14)*/
UPDATE Employee 
SET Employee.Salary = Employee.Salary * 1.3
WHERE Employee.SSN IN 
(SELECT w.ESSn 
FROM Works_For w JOIN Project p
ON w.Pno = p.Pnumber
WHERE p.Pname = 'Al Rabwah'
);
