
--(1)
create view successStudentData(FULLNAME,CourseName) as 

	select s.st_fname +' '+ s.st_lname  , c.Crs_Name 
	from student s join Stud_Course sc 
	on  s.st_id = sc.St_Id join Course c on c.Crs_Id = sc.Crs_Id
	where Grade > 50 

--test--

select * from successStudentData


--(2)
create view managerTopic (MangerName,Topic) 
with encryption
as
select I.Ins_Name , T.Top_Name  
from  Department D join  Instructor I
on I.Ins_Id = D.Dept_Manager
join Ins_Course IC 
on I.Ins_Id= IC.Ins_Id 
join Course C on C.Crs_Id = IC.Crs_Id 
join Topic T on T.Top_Id = C.Top_Id;

-- test -- 

select * from managerTopic

--(3)--
create view deptInstructor(Name,Dept)
as
select I.Ins_Name ,d.Dept_Name 
from  Department D join  Instructor I
on d.Dept_Id = i.Dept_Id
where Dept_Name in ('SD','Java');

--test --

select * from deptInstructor


--(4)--
create view V1 as 
select *  
from student
where st_address in ('Alex','Cairo')
with check option;

--test--

update V1 set st_address = 'Tanta'
where st_address = 'Alex';


--(5)--
use Company_SD
create view VEmployeeWorkOnProjects(EmployeeName,ProjectName)
as 
select E.Fname + ' ' + E.Lname , P.Pname 
from Employee E , Works_for W , Project P
where E.SSN = W.ESSn and W.Pno = P.Pnumber

--test 
select * from VEmployeeWorkOnProjects

--(6)

--a
create schema CompanySchema

alter schema CompanySchema transfer dbo.Departments

--b 
create schema HumanResourceSchema

alter schema HumanResourceSchema transfer dbo.Employee

--(7)--
use ITI
create index i1 on Department(Manager_hiredate)

--> will excute 


--(8)
create unique index i2 on Student(St_Age)

-->The CREATE UNIQUE INDEX statement terminated
--because a duplicate key was found for the object name 'dbo.Student' and the index name 'i2'. 
--The duplicate key value is (21).

--(9)--
use Company_SD

declare c1 cursor for select salary from HumanResourceSchema.Employee
for update ;
declare @sal int 
open c1 
fetch c1 into @sal;
while @@FETCH_STATUS = 0 
	begin 
	if @sal <3000 
		update HumanResourceSchema.Employee 
		set Salary = @sal * 1.10 
		where current of c1;
	else if @sal >= 3000
		update HumanResourceSchema.Employee
		set Salary = @sal * 1.20
		where current of c1
		fetch next from c1 into @sal;
	end 
close c1 
deallocate c1

--(10)--
use ITI
DECLARE @DeptName VARCHAR(50), @ManagerName VARCHAR(50) , @managerAndDept VARCHAR (200);

declare c2 cursor for select d.Dept_Name , I.Ins_Name from instructor I join department d on d.Dept_Id = I.Dept_Id
open c2 ;

fetch next from c2 into @DeptName , @ManagerName ;

while @@FETCH_STATUS = 0 

begin 

	set @managerAndDept = CONCAT(@managerAndDept, @DeptName, ' ', @ManagerName, '; ');
	fetch next from c2 into @DeptName , @ManagerName ;

end ;

select @managerAndDept;
close c2 ;

deallocate c2 ;


--(11)--



DECLARE @Name VARCHAR(50), @allNames VARCHAR (200);

declare c3 cursor for select Ins_Name from instructor 
open c3 ;

fetch next from c3 into @Name  ;

while @@FETCH_STATUS = 0 

begin 

	set @allNames = CONCAT(@allNames,',',@Name);
	fetch next from c3 into @Name;

end ;

select @allNames;
close c3 ;

deallocate c3 ;


--(12)