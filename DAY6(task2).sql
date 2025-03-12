use AdventureWorks2012

--(1)

SELECT SalesOrderID, ShipDate FROM Sales.SalesOrderHeader
WHERE ShipDate BETWEEN '2002-07-28' AND '2014-07-29';

--(2)

SELECT ProductID, Name
FROM Production.Product
WHERE StandardCost < 110.00;

--(3)

SELECT ProductID, Name
FROM Production.Product
WHERE Weight IS NULL;

--(4)

SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color IN ('Silver', 'Black', 'Red');

--(5)

SELECT ProductID, Name
FROM Production.Product
WHERE Name LIKE 'B%';

--(6)

UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3;

SELECT ProductDescriptionID, Description
FROM Production.ProductDescription
WHERE Description LIKE '%[_]%';

--(7)

SELECT OrderDate, SUM(TotalDue) 
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2001-07-01' AND '2014-07-31'
GROUP BY OrderDate;

--(8)

SELECT DISTINCT HireDate FROM HumanResources.Employee;

--(9)
SELECT AVG(DISTINCT ListPrice) FROM Production.Product;

--(10)

SELECT  'The ' + Name + ' is only! ' + CAST(ListPrice AS NVARCHAR) AS ProductInfo FROM Production.Product
WHERE ListPrice BETWEEN 100 AND 120
ORDER BY ListPrice;

--(11)


--a

SELECT rowguid, Name, SalesPersonID, Demographics
INTO Sales.store_Archive1234565
FROM Sales.Store;

--b

SELECT rowguid, Name, SalesPersonID, Demographics
INTO Sales.store_Archive1234
FROM Sales.Store
where 1=2;

--(12)

SELECT CONVERT(VARCHAR, GETDATE(),103) 
UNION
SELECT FORMAT(GETDATE(), 'MMMM dd, yyyy') 
UNION
SELECT FORMAT(GETDATE(), 'yyyy-MM-dd') 


