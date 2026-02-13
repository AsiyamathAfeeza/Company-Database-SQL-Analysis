#SUB QUERYS
create database company;
use company;
create table department (department_id int primary key,
					department_name varchar (100) not null,
                    location varchar(100),
                    budget decimal(12,2) );
 desc department;
 show tables in company;
  create table project (project_id int primary key,
						project_name varchar(100) not null,
                        department_id int,
                        foreign key(department_id) references department(department_id) );
  desc project;
                       
  create table employee(employee_id int primary key,
						e_name varchar(100) not null,
                        salary decimal(10,2)not null,
                        hire_date date not null,
                        department_id int,
                        project_id int,
                        foreign key(department_id) references department(department_id),
                        foreign key(project_id) references project(project_id) );
describe employee;  
show tables in company;
insert into department(department_id,department_name,location,budget) values (101,"data analysis","mangalore",45000),
															(102,"data science","bolar",56000),
                                                            (103,"web development","kerala",36000),
                                                            (104,"data analyis","udupi",45000),
                                                            (105,"web design","goa",67000);
insert into project (project_id,project_name,department_id) values (31,"diabetes analysis",101),
													(32,"car sales",102),
                                                    (33,"future robots",103),
                                                    (34,"pants sales",104),
                                                    (35,"nyka",105);
insert into employee (employee_id,e_name,salary,hire_date,department_id,project_id) values (51,"afeeza",23000,"2025-09-04",101,31),
																(52,"afree",23000,"2024-09-06",102,32),
                                                                (53,"sana",22000,"2024-09-08",103,33),
                                                                (54,"kubra",34000,"2023-09-05",104,34),
															    (55,"naima",21000,"2022-06-02",105,35);
 show tables;    
 select * from department;
 select * from project;
  select * from employee;
 delete from project where department_id is null;   #deleting null values from table project ccolumn name department_id
 delete from employee where department_id is null;   
 delete from employee where project_id is null;
 alter table employee add column job varchar(100)not null; 
update employee set job="data analist" where employee_id=51;  #empty column job updated
update employee set job="tech" where employee_id=52;
update employee set job="developer" where employee_id=53;
update employee set job="analyser" where employee_id=54;
update employee set job="developer" where employee_id=55;
#get the keyborad i=engeer ,slaray >avg salary
select avg(salary) from employee;
select e_name,salary from employee where job like "developer" and salary<(select avg(salary) from employee);
#display the names of employees who have the  same hire date as the employees with the name 'priya'
select e_name,hire_date from employee where year(hire_date)=(select year (hire_date) from employee where e_name like "sana");
#.dispaly the names of the emp who are in the same department as the mehaza and earn more than her.
select * from employee where department_id=(select salary from employee where e_name="afeeza") and salary >(select salary from employee where e_name="afeeza");
#3.find the second and third highest salary
 select max(salary) from employee where salary=(select salary from employee order by salary desc limit 2 offset 2 );      #for doing asending or disending (order by),
select salary from employee order by salary desc limit 2 offset 2;
select max(salary) from employee where salary<(select max(salary) from employee);
#4.display the all employees who  belong to the department that have fewer than 3 employees
select count(department_id) from employee group by department_id having count(department_id)<3;
select e_name,department_id from employee group by department_id;
select * from employee where department_id in (select department_id from employee group by department_id having count(*)<3);
#5.display the names of the employees who where hired last and have the highest salary.
select e_name,hire_date,salary from employee where hire_date=(select min(hire_date) from employee)and (select max(salary) from employee);
# FIND THE JOB WHICH PAYIMG HIGHEST SALARY
 select job,salary from employee order by salary desc limit 1;
 #display name of employee with lowest salary in department 101
 select * from employee;
 select e_name,salary from employee where department_id=101 order by salary asc limit 1;
 #1.List all employees along with their department names.
select e.e_name,d.department_name from department d inner join employee e on d.department_id=e.department_id;
#2.	Show all employees with their project name and department.
select e_name,d.department_name,p.project_name FROM employee e inner join department d on e.department_id = d.department_id inner join project p on e.project_id = p.project_id;
#3.	Display all projects and their associated departments.
select p.project_name,d.department_name from project p inner join department d on p.department_id=d.department_id;
#4.	Find employees who are working in the “IT” department.
select e.e_name,d.department_name from employee e inner join department d on e.department_id=d.department_id where department_name="data analysis";
#5.	Display employees along with their department budget.
select e_name,d.budget from employee e inner join department d on d.department_id=e.department_id;
#6.	List all employees and their projects — include employees even if no project assigned.
select e.e_name,p.project_name from employee e left join project p on p.project_id=p.project_id;
#7.	List all projects even if no employee is assigned.
select e_name,p.project_name from project p left join employee e on p.project_id=e.project_id;
#8.	Find departments that currently have no employees.
select d.department_name from employee e left join department d on d.department_id=e.department_id;
#9.	Display employees hired after 2023 and their project names.
select e_name,p.project_name,year(e.hire_date) from employee e inner join project p on p.project_id=e.project_id where year(e.hire_date)>2023;
#10.Show total salary spent per department.
select d.department_name,sum(salary) from employee e right join department d on d.department_id=e.department_id group by d.department_name;

select count(*),d.department_name from employee e inner join department d on d.department_id=e.department_id group by d.department_name;

