use nptel_management;

select * from student;
select * from course;
select * from nptel_marks;

select * from nptel_marks where c_code = 'UCSOL73';
select count(*) from nptel_marks where c_code = 'UCSOL73';