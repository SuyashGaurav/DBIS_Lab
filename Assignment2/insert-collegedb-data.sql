\copy student FROM 'C:\Users\suyas\OneDrive\Documents\PostGreSQL\Assignment2\studentData.csv' DELIMITER ',';
\copy department FROM 'C:\Users\suyas\OneDrive\Documents\PostGreSQL\Assignment2\departmentData.csv' DELIMITER ',';
\copy professor FROM 'C:\Users\suyas\OneDrive\Documents\PostGreSQL\Assignment2\professorData.csv' DELIMITER ',';
\copy course FROM 'C:\Users\suyas\OneDrive\Documents\PostGreSQL\Assignment2\courseData.csv' DELIMITER ',';
\copy major FROM 'C:\Users\suyas\OneDrive\Documents\PostGreSQL\Assignment2\majorData.csv' DELIMITER ',';
\copy enroll FROM 'C:\Users\suyas\OneDrive\Documents\PostGreSQL\Assignment2\enrollData.csv' DELIMITER ',';

--ALTER TABLE course ALTER COLUMN cname TYPE VARCHAR(60);
