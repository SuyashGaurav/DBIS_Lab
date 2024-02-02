--PART 1
--Q1
select pname from professor
natural join department
where department.numphds < 50;

--Q2
select sname from student
where student.gpa = (select max(gpa) from student);

--Q3
select cno, avg(gpa) as avg_gpa from course
natural join enroll
natural join student
where dname = 'Computer Sciences'
group by cno;

--Q4
select student.sname, student.sid, count(enroll.sid) from student
natural join enroll
group by student.sname, student.sid
having count(enroll.sid) = (
	select max(course_count) from (
		select count(sid) as course_count from enroll
		group by sid
	) as course_counts
);

--Q5
select department.dname, count(professor.dname) from department
natural join professor
group by department.dname
having count(professor.dname) = (
	select max(dep_count) from (
		select count(dname) as dep_count from professor
		group by dname
	) as dep_counts
);

--Q6
select student.sname, department.dname as major
from student, major, enroll, course, department
where student.sid = major.sid
and student.sid = enroll.sid
and enroll.cno = course.cno AND enroll.dname = course.dname
and major.dname = department.dname
and course.cname = 'Thermodynamics';


--Q7
SELECT DISTINCT department.dname
FROM department
WHERE NOT EXISTS (
    SELECT *
    FROM student
    JOIN major ON student.sid = major.sid AND major.dname = department.dname
    JOIN enroll ON student.sid = enroll.sid
    JOIN course ON enroll.dname = course.dname AND enroll.cno = course.cno
    WHERE course.cname = 'Compiler Construction'
);


--Q8
select distinct(sname) from student 
natural join enroll 
where sid in (
	select sid from enroll
	group by sid, dname 
	having count(*) >=1 
	and dname='Civil Engineering'
	)
	and sid in (
		select sid from enroll 
		group by sid, dname 
		having count(*) <=2 
		and dname='Mathematics');


--Q9
SELECT department.dname, AVG(student.gpa) AS avg_gpa
FROM department
JOIN major ON department.dname = major.dname
JOIN student ON major.sid = student.sid
JOIN enroll ON student.sid = enroll.sid
WHERE enroll.grade < 1.5
GROUP BY department.dname;

--Q10
select enroll.sid, student.sname, enroll.grade from enroll
natural join student
where enroll.dname = 'Civil Engineering';


--PART 2
--Q1 (Run on Terminal)
-- create database salesdb

--Q2 (Run on Terminal)
-- \i tableSales.sql

--Q3 (Run on Terminal)
-- \i dataSales.sql


--Q4
select cust_name from customer
where grade = 2;

--Q5
select ord_num, ord_date, ord_description from orders
order by ord_date;

--Q6
select ord_num, ord_date, ord_amount from orders 
where ord_amount>=800 
order by ord_amount desc;

--Q7
select * from customer
order by working_area, cust_name desc;

--Q8
select cust_name from customer
where cust_name like 'S%';

--Q9
select ord_num from orders
where extract(month from ord_date) = 3 and extract(year from ord_date) = 2008;

--Q10
select ord_amount*1.1 as new_amount from orders;

--Q11
select ord_num, ord_amount-advance_amount as balance_amount from orders
where ord_amount between 2000 and 4000;

--Q12
select ord_num, cust_code, ord_amount from orders
where ord_amount in (
	select ord_amount from orders
	where cust_code = 'C00022'
);

--Q13
select agent_name, agent_code from agents
where commission > all (
	select commission from agents
	where working_area = 'Bangalore'
)

--Q14
select agent_name from agents
where commission > some(
	select commission from agents
	where working_area = 'Bangalore'
);

--Q15
select agent_code from agents
where agent_code in (
	select agent_code from orders
)

--Q16
select cust_name from customer
where cust_code not in (
	select cust_code from orders
)

--Q17
select agent_code from agents
natural join orders
where ord_amount >= 800

--Q18
select distinct(agent_code) from agents
natural join orders
where ord_amount >= 800

--Q19
select cust_name, cust_code from customer
where cust_city = 'Paris'
or cust_city = 'New York'
or cust_city = 'Bangalore';

--Q20 (Assumption: I have taken agent who have ordered total amount more than 1000)
select agent_name, sum(ord_amount) as total from agents
natural join orders 
group by agent_name, agent_code
having sum(ord_amount)>=1000;

--Q21
select sum(ord_amount) as sum_amount, avg(ord_amount) as avg_amount, max(ord_amount) as max_amount, min(ord_amount) as min_amount from orders

--Q22
select count(*) as req_count from customer
group by cust_city
having cust_city = 'New York';

--Q23
select count(distinct ord_amount) as different_amounts from orders;

--Q24
select agent_name, agent_code from agents
natural join orders
group by agent_code
having count(*) > 1;

--Q25
select working_area, count(*) as count_each_working_area from agents
group by working_area;

--Q26
select agent_name from agents
natural join orders
group by agent_code
having count(ord_num) >= 2;

--Q27
select agent_name, avg(ord_amount) from agents
natural join orders
group by agent_name, agent_code;

--Q28
delete from customer where agent_code in (
	select agent_code from agents where working_area='Bangalore'
)
delete from orders where agent_code in (
	select agent_code from agents where working_area='Bangalore'
)
delete from agents where working_area='Bangalore';

--Q29
alter table customer
add Address varchar(50) default null;
update customer
set address = 'Patna'
where cust_code = 'C00013';

--Q30
alter table agents
drop country;

--Q31
truncate table orders;
--delete from orders;

--Q32
drop table customer cascade;