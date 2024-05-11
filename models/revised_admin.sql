--FOR COURSE STATS PAGE

--gets all the courses set for all the years
SELECT DISTINCT(c.c_name),c.c_code
FROM course c 
join set_course ce on ce.c_code = c.c_code;


--gets the entire details of the course
select * from course
where c_code = 'noc24-cs47';

--gives the number of people attended the course average of their score and the highest mark
SELECT COUNT(email_id),AVG(verified_marks),MAX(verified_marks) AS total_students
FROM NPTEL_MARKS
WHERE c_code = 'noc24-cs47';

--gives the topper of the courses given the sem and the course code
SELECT s.st_name, nm.verified_marks,nm.ssn_marks ,nm.acc_year, nm.sem
FROM NPTEL_MARKS nm
JOIN STUDENT s ON nm.email_id = s.email_id
WHERE nm.c_code = 'noc24-cs47' -- Replace 'noc24-cs47' with your desired course code
AND nm.sem = '4' -- Replace '4' with your desired semester
ORDER BY nm.verified_marks DESC
LIMIT 10;

(for now use this code)

SELECT nm.email_id, nm.verified_marks,nm.ssn_marks ,nm.acc_year, nm.sem
FROM NPTEL_MARKS nm
WHERE nm.c_code = 'noc24-cs47' -- Replace 'noc24-cs47' with your desired course code
AND nm.sem = '4' -- Replace '4' with your desired semester
ORDER BY nm.verified_marks DESC
LIMIT 10;


--gives the year and number of students enrolled graph
--bar graph
SELECT acc_year, COUNT(DISTINCT email_id) AS num_students_enrolled
FROM NPTEL_MARKS
GROUP BY acc_year;

--gives the sem and the number of students enrolled graph
--pie chart
SELECT sem, COUNT(DISTINCT email_id) AS num_students_enrolled
FROM NPTEL_MARKS
GROUP BY sem;

--gives the year and got the marks between 0-50,50-80,80-100 
--slacked bar graph
SELECT 
    acc_year,
    SUM(CASE WHEN verified_marks >= 0 AND verified_marks < 50 THEN 1 ELSE 0 END) / COUNT(*) * 100 AS percentage_0_to_50,
    SUM(CASE WHEN verified_marks >= 50 AND verified_marks < 80 THEN 1 ELSE 0 END) / COUNT(*) * 100 AS percentage_50_to_80,
    SUM(CASE WHEN verified_marks >= 80 AND verified_marks <= 100 THEN 1 ELSE 0 END) / COUNT(*) * 100 AS percentage_80_to_100
FROM NPTEL_MARKS
WHERE c_code = 'noc24-cs47'
GROUP BY acc_year;

--gets the average mark of the sem for each year
--multiple line charts
SELECT
    acc_year,
    sem,
    AVG(verified_marks) AS average_mark
FROM NPTEL_MARKS
GROUP BY acc_year, sem;