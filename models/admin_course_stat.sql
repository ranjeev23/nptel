use nptel_management;

select * from certificate;
select * from course;
select * from student;
select * from set_course;

#1
SELECT DISTINCT(c.c_name) 
FROM course c 
join certificate ce on ce.c_code = c.c_code;

#2
select c_name,c_code,weeks,nptel_link
from course;

#course statistics
select count(distinct(email_id))
from certificate ce
join course c on c.c_code = ce.c_code
where c_name = 'Software Testing';