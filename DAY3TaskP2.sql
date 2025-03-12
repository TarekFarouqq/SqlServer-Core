USE DAY3P2
CREATE TABLE Instructor (
iid int,
fname varchar(20),
lname varchar(20),
hire_date date default getdate() ,
addr varchar(50),
bd date,
overtime int unique,
salary int default 3000,
age as year(getdate())-year(bd),
nsalary as salary + overtime ,
constraint c1 primary key (iid),
constraint c8 check(addr in ('cairo','alex')),
constraint c9 check(salary between 1000 and 5000),

)

CREATE TABLE Course(
cid int,
cname varchar(20),
duration int unique,
constraint c2 primary key (cid),

)

CREATE TABLE Teach(

iid int,
cid int,
constraint c3 primary key (iid,cid),
constraint c4 foreign key (iid) references Instructor(iid) on delete cascade on update cascade,
constraint c5 foreign key (cid) references Course(cid) on delete cascade on update cascade
)

CREATE TABLE Lab(
lid int,
loc varchar(50),
capacity int ,
cid int ,
constraint c6 primary key (lid,cid),
constraint c7 foreign key (cid) references Course(cid) on delete cascade on update cascade,
constraint c10 check(capacity between 0 and 20),
)

