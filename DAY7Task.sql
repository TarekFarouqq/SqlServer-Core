use ITI

--(1)
create function getMonthName (@date date)
returns varchar(50) as 
		begin
		return DATENAME(month, @date)

		end;

--calling 
select dbo.getMonthName(getdate())


--(2)--
create function valueBetween(@num1 int , @num2 int )
returns @t table (number int)
as 
begin 
 declare @counter int = @num1

 while @counter <= @num2
	begin 
		insert into @t (number) values (@counter)
		set @counter += 1
	end ;

return;
end ; 

--calling 

select * from valueBetween(7,13)


--(3)--

create function getStudentDeptName(@studentNum int)
returns table 
as 
return 
	select d.Dept_Name , concat(s.St_Fname,' ',s.St_Lname) as fullName
	from Department d join Student s on s.Dept_Id = d.Dept_Id
	where s.St_Id = @studentNum;

--calling
select * from getStudentDeptName(1)


--(4)--

create function nameDisplay(@studentNum int)
returns varchar(50) as 
	begin
	declare @first varchar(50), @last varchar(50), @Message varchar(100)

	
	select @first= St_Fname , @last= St_Lname from student where St_Id = @studentNum

		 if @first IS NULL AND @last IS NULL
				set @Message = 'First name and Last name are null';
			else if @first IS NULL
				set @Message = 'First name is null';
			else if @last IS NULL
				set @Message = 'Last name is null';
			else
				set @Message = 'First name and Last name are not null';

	return @Message
	end;


--Calling 
select dbo.nameDisplay(2)


--(5)

create function getmanagerData (@managerid int)
returns table
as
return
    select  i.Ins_Id , d.Dept_Name, i.Ins_Name as managername, d.Manager_hiredate
    from instructor i join department d on i.Dept_Id = d.Dept_Manager
    where i.Ins_Id = @managerid;

--  calling 
select * from getManagerData(1)

--(6)----

create function getStudentName (@input nvarchar(50))
returns @t table (result nvarchar(100))
as
begin
    if @input = 'first name'
        insert into @t (result) select isnull(St_Fname, 'unknown') from student;
    else if @input = 'last name'
        insert into @t (result) select isnull(St_Lname, 'unknown') from student;
    else if @input = 'full name'
        insert into @t (result) select concat(isnull(St_Fname, 'unknown'), ' ', isnull(St_Lname, 'unknown')) from student;

    return;
end;


--calling 
select * from getStudentName('first name')


--(7)--

select St_Id, substring(St_Fname, 1, len(St_Fname) - 1)
from student;

--(8)

delete sc
from Stud_Course sc
 join student s on sc.st_id = s.st_id
 join department d on s.Dept_Id = d.Dept_Id
where d.Dept_Name = 'sd';


--(9)

create table lastTransaction ( id int , amount int )
create table dailyTransaction ( id int , amount int )

insert into lastTransaction values(1,5000),(2,3000),(3,4000)
insert into dailyTransaction values(1,4500),(2,1500),(3,7000)

merge  into lastTransaction as T 
using dailyTransaction as S 

on T.id = S.id 

when Matched then
	update set T.amount = S.amount 

when  Not Matched then 
	insert 
	values(s.id , s.amount );




