create table if not exists public.employees(
emp_id int not null primary key,
emp_name varchar(50),
email varchar(40),
phone_number real,
job_id varchar(10),
salary real,
department_id varchar(40)
);

select * from employees;
select distinct job_id from employees;

select * from employees where email is null;
update employees
set email = 'matthewgmail'
where email is null;

select * from employees order by salary desc;

--rename a column
alter table employees
rename column job_id to job_category;

select * from employees
where salary < 8000 and job_category = 'FI_ACCOUNT';  --or

select * from employees order by salary desc limit 3;
select * from employees order by salary desc fetch first 3 row only;

select * from employees order by salary desc limit 5 offset 3;  --skit first 3 then print 5
select * from employees order by salary desc fetch first 5 row only offset 3;

--like
select emp_name from employees where emp_name like 'A%';
select emp_name from employees where emp_name like '%d';
select emp_name from employees where emp_name like '%ia%';
select emp_name from employees where emp_name like '_a%';  --second letter


select sum(salary) as total_salary from employees;
select avg(salary) as avg_salary from employees;
select max(salary) as max_salary from employees;
select min(salary) as min_salary from employees;
select count(distinct department_id) as total_department from employees;

--group by
select job_category, avg(salary) as average_salary from employees
group by job_category order by average_salary desc;

select department_id, max(salary) as max_salary from employees
group by department_id;

select job_category, count(emp_id) as count_category from employees
group by job_category;


--having (to use in aggregate fn like sum , avg, etc.)
select job_category, avg(salary) as average_salary from employees
group by job_category having avg(salary) > 12000;

select job_category, count(emp_id) as count_id from employees
group by job_category having count(emp_id) > 10;


--Case Expression
select emp_name, job_category, salary,
case
when salary < 5000
then 'Low Salary'
when salary > 5000 and salary < 8000
then 'Medium Salary'
when salary >= 8000
then 'High Salary'
end as salary_name 
from employees
order by salary desc

--Nested Queries
--Q. Employees higher than average salary
select emp_name, department_id, salary from employees
where salary > (select avg(salary) from employees);

/* sql function */
select abs(-100);

select greatest(2, 3,223, 12, 23.4, 323.42, 32.24, 232, 32.32);
select least(2, 3,223, 12, 23.4, 323.42, 32.24, 232, 32.32) as least_number;

select mod(34, 10);
select power(4, 3);
select sqrt(100);
select sin(45);
select ceil(3.32);
select floor(2.32);

--String functions
select char_length('India is a democracy');
select concat('Postgresql ', 'is ', 'interesting');
select left('India is a country', 5);  --right
select repeat('India ', 5);
select reverse('India is a democracy');


--user defined fn
create or replace function
count_emails()
returns integer as $total_emails$
declare
	total_emails integer;
begin
	select count(email) into total_emails from employees;
	return total_emails;
end;
$total_emails$ language plpgsql;

select count_emails();


--join (two or more table)
select * from movies
select * from employees

