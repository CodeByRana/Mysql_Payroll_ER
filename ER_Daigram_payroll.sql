-- UC 1 Create payroll service DB --

show databases;
create database payroll_services;
use payroll_services;

-- UC 2 Create a table employee payroll in payroll service db --
create table employee_payroll (
id int not null auto_increment,
name varchar(50) not null,
salary Double not null,
startDate Date not null,
primary key(id) 
);
show tables;
drop table employee_payroll;

-- UC 3 Insert employee payroll information details --

insert into employee_payroll(name, salary, startDate) values ('Deepak',500000.0,'2021-02-05');

insert into employee_payroll(name, salary, startDate) values
 ('Navneet',400000.0,'2022-02-02'),
 ('Manisha','38000.0','2022-02-03'); 

-- UC 4 list all employee payroll data from db --
select * from employee_payroll;
select * from employee_payroll where name='Deepak';

-- UC 5 retrieve salary data for a particular employee as well as all employees who have joined in a particular data range from the payroll service database-- 
select * from employee_payroll where startDate between  '2021-02-05' and Date(now());

-- UC 6 add Gender to Employee Payroll Table and Update the Rows to reflect the correct Employee Gender --
alter table employee_payroll add gender char(1);
update employee_payroll set gender = "M" where id IN(1,2);
update employee_payroll set gender = "F" where id=3;
update employee_payroll set name = "Adya" where id=3;

-- UC 7 find sum, average, min, max and number of male and female employees
select SUM(salary) from employee_payroll;
select gender, SUM(salary) from employee_payroll group by gender;

-- UC 8 extend employee_payroll data to store employee information --
alter table employee_payroll
add phone_number varchar(30),
add department varchar(30) not null,
add address varchar(250) default 'ABC';

select * from employee_payroll;

-- UC 9 extend employee_payroll table to have Basic Pay, Deductions, Taxable Pay, Income Tax, Net Pay --
alter table employee_payroll
rename column salary to basic_pay;

alter table employee_payroll
add duduction int,
add taxable_pay int,
add incom_tax int,
add net_pay int;

select * from employee_payroll;

-- UC 10 Ability to make Terissa as part of Sales and Marketing Department --
insert into employee_payroll(name, basic_pay, startDate,department) values ('Terrisa',400000.0,'2021-02-10','Sales');
insert into employee_payroll(name, basic_pay, startDate,phone_number,department,duduction,taxable_pay,incom_tax,net_pay) 
values ('Terrisa',400000.0,'2021-02-10',1234567,'Marketing',30000,200,300,2000);

-- UC 11 Implement the ER Diagram into Payroll Service DB -- 
create table employee (
id int not null auto_increment primary key,
name varchar(50) not null,
gender varchar(1),
phone varchar(30),
address varchar(250),
startDate Date not null
);
show tables;

create table payroll(
id int not null auto_increment primary key,
basic_pay int,
deduction int,
income_tax int,
taxable_pay int,
net_pay int,
emp_Id int ,
foreign key(emp_id) references employee(id)
);

create table department(
id int not null auto_increment primary key,
dept_name varchar(20) not null
);

create table employee_department(
employee_id int not null,
department_id int not null,
foreign key(employee_id) references employee(id),
foreign key(department_id) references department(id),
primary key(employee_id,department_id)
);

select * from employee_department;

-- UC 12 Ensure all retrieve queries done especially in UC 4, UC 5 and UC 7 are working with new table structure --
select * from employee_payroll;
select * from employee_payroll where name='Terrisa';

select * from employee_payroll where startDate between  '2021-02-05' and Date(now());

select SUM(basic_pay) from employee_payroll;

select gender, SUM(basic_pay) from employee_payroll group by gender;



 

