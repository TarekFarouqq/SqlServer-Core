use ITI


--(1)--
alter procedure deptSudents
as
begin
    select 
        department.dept_name, 
        count(student.st_id) as number_of_students
    from 
        department
     join 
        student on department.dept_id = student.dept_id
    group by 
        department.dept_name;
end;

--test--
deptSudents


--(2)--

use Company_SD

alter procedure numOfEmployee
as
begin
    declare @employee_count int;

    select 
        @employee_count = count(essn)
    from 
        works_for
    where 
        pno = 100;

    if @employee_count >= 3
    begin
        select 'the number of employees in the project is 3 or more';
    end
    else
    begin
        select 'the following employees work for the project:';
        select 
            fname, lname
        from 
            employee e
         join 
            works_for w on e.ssn = w.essn
        where 
            w.pno = 100;
    end;
end;


--test--

numOfEmployee


--(3)--


create procedure replaceEmployee
    @oldEmp int,
    @newEmp int,
    @projectNum int
as
begin
   
    delete from works_for
    where essn = @oldEmp and pno = @projectNum;

    
    insert into works_for (essn, pno)
    values (@newEmp, @projectNum); 

  
end;

--test--
replaceEmployee 1,2,100


--(4)--

create table AuditTable (
projectNo int ,
userName varchar(50),
modifiedDate date,
budgetOld int ,
budgetNew int 
)

create trigger tr4
on project
after update
as
begin
    
    if update(budget)
    begin
        insert into AuditTable (projectNo, userName, modifiedDate, budgetOld, budgetNew)
        select  i.pnumber , suser_name(),getdate(), d.budget , i.budget 
        from  inserted i  join  deleted d 
        on  i.pnumber = d.pnumber;
    end
end;

--test--
update Project  
set budget = 283873 where Pnumber= 100

--(5)--
use ITI

create trigger preventInsert
on department
instead of insert
as
begin
    print 'you cannot insert a new record into the department table.';
end;


--test --

insert into Department 
values (80,'DB','Unix','Cairo',NULL,GETDATE())

--(6)--
use Company_SD

create trigger preventMarchInsert
on employee
after insert
as
begin
   
    if month(getdate()) = 3
    begin
       
        select 'Insertions are not allowed in the Employee table during March.';
        delete from employee
        where ssn in (select ssn from inserted); 
    end;
end;

--(7)--

use ITI 

create table StudentAudit (
ServeruserName varchar(200),
insertData date,
note varchar(100)
)



create Trigger trStudentAudit
On Student
After Insert
As
begin
Declare @key Varchar(200) =(Select St_Id From inserted)
Insert Into StudentAudit
Values(SUser_Name()+' Has Inserted the New Student',GETDATE(),
       SUSER_NAME() +' Insert New Row with Key '+@key+' in table Student ')
end

--test--
Insert Into Student
Values(500,'Tarek','Farouq','Manoura',36,10,6)

--(8)--


create  trigger InsteadOfDelete 
on Student
instead Of Delete
as
declare @key Varchar(max) =(Select St_Id From deleted)
insert Into StudentAudit
values(SUser_Name()+' Has Inserted the New Student',GETDATE(),
       SUSER_NAME() +' try to delete Row with id = '+ @key)

--test--

delete from Student
where St_Id=500

