use nptel_management;

select * from teacher;
select * from certificate;


#1
select count(distinct(email_id)) from certificate;

#2
select distinct(c_code) from certificate;

#3
SELECT s.st_name, co.c_name, c.marks
FROM student s
JOIN certificate c ON s.email_id = c.email_id
JOIN set_course sc on sc.c_code = c.c_code
JOIN course co on co.c_code = sc.c_code
WHERE sc.sem = 4 and c.marks = (select max(marks) from certificate where c_code = c.c_code);

#4
SELECT DISTINCT(c.c_name) 
FROM course c 
join certificate ce on ce.c_code = c.c_code;

