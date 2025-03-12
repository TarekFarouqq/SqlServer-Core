/*(1)*/
SELECT Dnum AS Department_ID, Dname AS Department_Name, MGRSSN AS Manager_SSN, e.Fname AS Manager_Name
FROM Departments d JOIN Employee e
ON d.MGRSSN = e.SSN;

/*(2)*/
SELECT  d.Dname AS Department_Name, p.Pname AS Project_Name
FROM Departments d JOIN Project p
ON d.Dnum = p.Dnum;

/*(3)*/
SELECT d.*, e.Fname AS Employee_Name
FROM Dependent d JOIN Employee e
ON d.ESSN = e.SSN;
/*(4)*/

SELECT Pnumber AS Project_ID, Pname AS Project_Name, City AS Project_Location 
FROM Project
WHERE City IN ('Cairo', 'Alex');

/*(5)*/
SELECT * FROM Project WHERE Pname LIKE 'A%';

/*(6)*/
SELECT * FROM Employee WHERE Dno = 30 AND Salary BETWEEN 1000 AND 2000;

/*(7)*/
SELECT e.Fname AS Employee_Name
FROM  Employee e JOIN  Works_For w 
ON e.SSN = w.ESSn 
JOIN  Project p 
ON  p.Pnumber = w.Pno
WHERE e.Dno = 10 AND w.Hours >= 10 AND p.Pname = 'AL Rabwah';

/*(8)*/
SELECT  e1.Fname AS Employee_Name
FROM Employee e1 JOIN Employee e2 
ON e1.Superssn = e2.SSN
WHERE e2.Fname+' '+ e2.Lname = 'Kamel Mohamed';

/*(9)*/
SELECT e.Fname AS Employee_Name, p.Pname AS Project_Name
FROM Employee e JOIN Works_For w 
ON e.SSN = w.ESSn JOIN  Project p
ON p.Pnumber = w.Pno
ORDER BY p.Pname;

/*(10)*/
SELECT p.Pnumber AS Project_Number, d.Dname AS Department_Name,
e.Lname AS Manager_Last_Name,  e.Address AS Manager_Address, 
e.Bdate AS Manager_Birthdate
FROM Project p JOIN Departments d
ON d.Dnum = p.Dnum 
JOIN Employee e
ON e.SSN = d.MGRSSN  
WHERE p.City = 'Cairo';

/*(11)*/
SELECT DISTINCT e.*
FROM Employee e JOIN Departments d
ON e.SSN = d.MGRSSN;

/*(12)*/
SELECT e.*, d.*
FROM Employee e LEFT JOIN Dependent d
ON e.SSN = d.ESSN;

/*(13)*/
INSERT INTO Employee (Fname, Lname, SSN, Bdate, Address, Sex, Salary, Superssn, Dno)
VALUES ('Tarek', 'Farouq', 102672, '2000-01-01', 'masoura', 'M', 3000, 112233, 30);

/*(14)*/
INSERT INTO Employee (Fname, Lname, SSN, Dno)
VALUES ('Shady', 'Mostafa', 102660, 30);

/*(15)*/
UPDATE Employee
SET Salary = Salary * 1.2
WHERE SSN = 102672;














