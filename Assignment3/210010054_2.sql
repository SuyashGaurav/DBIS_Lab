--Q1
select max(enrollments), min(enrollments) from 
( select count(ID) as enrollments from takes group by (course_id, sec_id, semester, year) ) 
as table_req;

--Q2
select course_id, sec_id, semester, year, count(*) as enroll_count from takes
group by course_id, sec_id, semester, year
order by count(*) desc
limit 1;

--Q3(i)
SELECT MAX(enrollment_count) AS max_enrollment
FROM (
    SELECT s.course_id, s.sec_id, COALESCE(COUNT(t.ID), 0) AS enrollment_count
    FROM section s
    LEFT JOIN takes t ON s.course_id = t.course_id AND s.sec_id = t.sec_id
    GROUP BY s.course_id, s.sec_id
) AS enrollment_counts;
SELECT MIN(enrollment_count) AS min_enrollment
FROM (
    SELECT s.course_id, s.sec_id, COALESCE(COUNT(t.ID), 0) AS enrollment_count
    FROM section s
    LEFT JOIN takes t ON s.course_id = t.course_id AND s.sec_id = t.sec_id
    GROUP BY s.course_id, s.sec_id
) AS enrollment_counts;


--Q3(ii)
select
  max(enrollment_count) as max_enrollment,
  min(enrollment_count) as min_enrollment
from
  (select s.course_id, s.sec_id, s.semester, s.year, count(t.ID) as enrollment_count from section s
  left join takes t
  on
    s.course_id = t.course_id
    and s.sec_id = t.sec_id
    and s.semester = t.semester
    and s.year = t.year
  group by
    s.course_id, s.sec_id, s.semester, s.year) as enrollment_summary;

--Q4
select * from course
where course_id like 'CS-1%';

--Q5(i) (Assumption: only cs101 and cs190 are required courses, so i'm listing instructors who teaches both these courses)
SELECT DISTINCT instructor.ID, instructor.name
FROM instructor
WHERE NOT EXISTS (
    SELECT course.course_id
    FROM course
    WHERE course.course_id LIKE 'CS-1%'
    EXCEPT
    SELECT teaches.course_id
    FROM teaches
    WHERE teaches.ID = instructor.ID
);

--Q5(ii)
SELECT i.ID, i.name
FROM instructor i
JOIN teaches t ON i.ID = t.ID
JOIN course c ON t.course_id = c.course_id
WHERE c.course_id LIKE 'CS-1%'
GROUP BY i.ID, i.name
HAVING COUNT(DISTINCT c.course_id) = (
    SELECT COUNT(*)
    FROM course
    WHERE course_id LIKE 'CS-1%'
);



--Q6 (Assumption: if student.id = instructor.id for some id, pass)
INSERT INTO student (ID, name, dept_name, tot_cred)
SELECT I.ID, I.name, I.dept_name, 0
FROM instructor I
WHERE I.ID NOT IN (SELECT ID FROM student);


--Q7
DELETE FROM student
WHERE tot_cred = 0
AND ID IN (
    SELECT ID
    FROM instructor
);

--Q8
UPDATE instructor
SET salary = 10000 * (
    SELECT COUNT(*)
    FROM teaches
    WHERE teaches.ID = instructor.ID
)WHERE EXISTS (
    SELECT *
    FROM teaches
    WHERE teaches.ID = instructor.ID
);

--Q9
CREATE VIEW F_grade_viewer AS
SELECT * FROM takes
WHERE grade = 'F';

--Q10
SELECT ID FROM F_grade_viewer
GROUP BY ID
HAVING COUNT(*) >= 2;

--Q11
CREATE TABLE grade_table (
    grade VARCHAR(1) PRIMARY KEY,
    grade_point INT
);
INSERT INTO grade_table(grade, grade_point)
VALUES ('A', 10), ('B', 8), ('C', 6), ('D', 4), ('F', 0);

--Q12 (Assumption: conider -A as A as grade_table doesn't consist -A)
SELECT
    t.ID AS student_id, ROUND(SUM(grade_table.grade_point) / COUNT(t.course_id), 2) AS cgpa
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN grade_table ON t.grade = grade_table.grade
GROUP BY t.ID
ORDER BY t.ID;

--Q13
SELECT c.building, c.room_number, s1.semester, s1.year, s1.time_slot_id, s1.course_id, s1.sec_id
FROM section s1
JOIN classroom c ON s1.building = c.building AND s1.room_number = c.room_number
WHERE (s1.semester, s1.year, s1.time_slot_id) IN (
    SELECT s2.semester, s2.year, s2.time_slot_id
    FROM section s2
    GROUP BY s2.semester, s2.year, s2.time_slot_id
    HAVING COUNT(*) > 1
)
ORDER BY c.building, c.room_number, s1.semester, s1.year, s1.time_slot_id, s1.course_id, s1.sec_id;

--Q14
CREATE VIEW faculty AS
SELECT ID, name, dept_name
FROM instructor;
SELECT * FROM faculty;

--Q15
CREATE VIEW CSinstructors AS
SELECT *
FROM instructor
WHERE dept_name = 'Comp. Sci.';
SELECT * FROM CSinstructors;

--Q16
insert into faculty(id, name, dept_name) values(64754, 'suyash', 'Physics');
insert into CSinstructors(id, name, dept_name, salary) values(76765, 'gaurav', 'Finance', 100000.0);

--upon inserting further tuple
-- insert into faculty(id, name, dept_name) values(112, 'yash', 'IS');
-- insert into CSinstructors(id, name, dept_name, salary) values(223, 'ravi', 'Physics', 400);

-- ERROR:  Key (dept_name)=(IS) is not present in table "department".insert or update on table "instructor" violates foreign key constraint "instructor_dept_name_fkey" 

-- ERROR:  insert or update on table "instructor" violates foreign key constraint "instructor_dept_name_fkey"
-- SQL state: 23503
-- Detail: Key (dept_name)=(IS) is not present in table "department".
--The attempts to insert data into these views will likely result in an error because views are typically read-only and do not support direct insertion.

--Q17
CREATE USER univ_teacher WITH PASSWORD 'pass@123';
GRANT SELECT ON TABLE student TO univ_teacher;
--open terminal
--
--psql -U univ_teacher -d universitydb
--
--enter password as pass@123


