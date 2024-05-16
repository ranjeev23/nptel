use nptel_management;

show full processlist;

DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS teacher;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS register_course;
DROP TABLE IF EXISTS certificate;
DROP TABLE IF EXISTS NPTEL_MARKS;
DROP TABLE IF EXISTS Ad_min;
DROP TABLE IF EXISTS set_course;
DROP TABLE IF EXISTS rejected;

create table STUDENT(
dig_id TEXT,
regno BIGINT primary key,
st_name TEXT,
dob DATE,
gender TEXT,
dept TEXT,
section TEXT,
email_id VARCHAR(100),
sem VARCHAR(10),
acc_year VARCHAR(15),
pass_word TEXT
);

create table TEACHER(
staffname TEXT,
email_id VARCHAR(100) Primary key,
pass_word Text
);

create table Course(
c_code VARCHAR(15) PRIMARY KEY,
c_name TEXT,
weeks INTEGER,
nptel_link varchar(255),
if_yes VARCHAR(5)
);

create table REGISTER_COURSE(
regno BIGINT,
c_code varchar(25),
PRIMARY KEY (regno,C_CODE)
);

create table certificate(
regno BIGINT,
c_code Varchar(25),
marks INTEGER,
certificate_link varchar(255),
verified varchar(10),
qr_code_url varchar(255),
upload_date datetime,
PRIMARY KEY (regno,C_CODE)
);

create table NPTEL_MARKS(
regno BIGINT,
c_code varchar(20),
verified_marks integer,
ssn_marks integer,
verified_date datetime,
sem VARCHAR(10),
acc_year varchar(15),
sem_type varchar(15),
PRIMARY KEY (regno,C_CODE)
);

create table Ad_min(
email_id varchar(255) PRIMARY KEY
);

create Table set_course(
c_no INTEGER PRIMARY KEY AUTO_INCREMENT,
SEM VARCHAR(10),
DEPT VARCHAR(10),
C_CODE VARCHAR(10),
ACC_YEAR varchar(15)
);

create table rejected(
regno varchar(255),
C_CODE VARCHAR(10),
teacher_email_id varchar(255),
issue varchar(255),
rejected_date datetime
);



Insert into STUDENT values ('2210197', 3122225002088, 'Nitish', '2004-03-12', 'Male', 'Information Technology', 'B', 'nitish2210197@ssn.edu.in', '4', '2022-2023', 'nitish123');
Insert into STUDENT values ('2210215', 3122225003103, 'Ranjeev', '2004-02-28', 'Male', 'Information Technology', 'B', 'ranjeev2210215@ssn.edu.in', '4', '2022-2023', 'ranjeev123');





Insert into TEACHER values ('Dr.K.S.Gayathri', 'gayathri@ssn.edu.in', 'teacher123');
Insert into TEACHER values ('Dr.P.Vasuki', 'vasuki@ssn.edu.in', 'teacher123');



Insert into Ad_min values ('admin@ssn.edu.in');





Insert into set_course (SEM, DEPT, C_CODE, ACC_YEAR) values ('4', 'IT', 'noc24-cs47', '2023-2024');
Insert into set_course (SEM, DEPT, C_CODE, ACC_YEAR) values ('4', 'IT', 'noc24-cs01', '2023-2024');
Insert into set_course (SEM, DEPT, C_CODE, ACC_YEAR) values ('4', 'IT', 'noc24-cs04', '2023-2024');
Insert into set_course (SEM, DEPT, C_CODE, ACC_YEAR) values ('4', 'IT', 'noc24-cs07', '2023-2024');
Insert into set_course (SEM, DEPT, C_CODE, ACC_YEAR) values ('4', 'IT', 'noc24-cs15', '2023-2024');
Insert into set_course (SEM, DEPT, C_CODE, ACC_YEAR) values ('4', 'IT', 'noc24-cs27', '2023-2024');
Insert into set_course (SEM, DEPT, C_CODE, ACC_YEAR) values ('4', 'IT', 'noc24-cs31', '2023-2024');
Insert into set_course (SEM, DEPT, C_CODE, ACC_YEAR) values ('4', 'IT', 'noc24-cs48', '2023-2024');




Insert into Course values ('noc24-cs47', 'Software Testing', 4, 'https://nptel.ac.in/courses/106105150', 'Yes');
Insert into Course values ('noc24-cs01', 'Foundations of Cryptography', 12, 'https://nptel.ac.in/courses/106106221', 'Yes');
Insert into Course values ('noc24-cs04', 'Privacy and Security in Online Social Media', 12, 'https://nptel.ac.in/courses/106106146', 'Yes');
Insert into Course values ('noc24-cs07', 'Secure Computation: Part I', 12, 'https://nptel.ac.in/courses/106108229', 'Yes');
Insert into Course values ('noc24-cs15', 'Blockchain and its Applications', 12, 'https://nptel.ac.in/courses/106105235', 'Yes');
Insert into Course values ('noc24-cs27', 'Foundations of Cyber Physical Systems', 12, 'https://nptel.ac.in/courses/106105241', 'Yes');
Insert into Course values ('noc24-cs31', 'Information Security - 5 - Secure Systems Engineering', 8, 'https://nptel.ac.in/courses/106106199', 'Yes');
Insert into Course values ('noc24-cs48', 'Systems and Usable Security', 4, 'https://nptel.ac.in/courses/106106234', 'Yes');

-- Course 1 - noc24-cs47 - Software Testing
-- 5 students with random verified marks (out of 100)
Insert into NPTEL_MARKS (email_id, c_code, verified_marks, ssn_marks, verified_date, sem, acc_year) values 
('nitish2210197@ssn.edu.in', 'noc24-cs47', 85, 78, '2024-05-01', '4', '2023-2024'),
('ranjeev2210215@ssn.edu.in', 'noc24-cs47', 92, 85, '2024-05-02', '4', '2023-2024'),
('student3@example.com', 'noc24-cs47', 78, 72, '2024-05-03', '4', '2023-2024'),
('student4@example.com', 'noc24-cs47', 65, 59, '2024-05-04', '4', '2023-2024'),
('student5@example.com', 'noc24-cs47', 70, 64, '2024-05-05', '4', '2023-2024');

-- Course 2 - noc24-cs01 - Foundations of Cryptography
-- 5 students with random verified marks (out of 100)
Insert into NPTEL_MARKS (email_id, c_code, verified_marks, ssn_marks, verified_date, sem, acc_year) values 
('nitish2210197@ssn.edu.in', 'noc24-cs01', 88, 81, '2024-05-06', '4', '2023-2024'),
('ranjeev2210215@ssn.edu.in', 'noc24-cs01', 94, 87, '2024-05-07', '4', '2023-2024'),
('student3@example.com', 'noc24-cs01', 76, 69, '2024-05-08', '4', '2023-2024'),
('student4@example.com', 'noc24-cs01', 82, 75, '2024-05-09', '4', '2023-2024'),
('student5@example.com', 'noc24-cs01', 90, 83, '2024-05-10', '4', '2023-2024');

-- Course 3 - noc24-cs04 - Privacy and Security in Online Social Media
-- 5 students with random verified marks (out of 100)
Insert into NPTEL_MARKS (email_id, c_code, verified_marks, ssn_marks, verified_date, sem, acc_year) values 
('nitish2210197@ssn.edu.in', 'noc24-cs04', 85, 78, '2024-05-11', '4', '2023-2024'),
('ranjeev2210215@ssn.edu.in', 'noc24-cs04', 92, 85, '2024-05-12', '4', '2023-2024'),
('student3@example.com', 'noc24-cs04', 78, 72, '2024-05-13', '4', '2023-2024'),
('student4@example.com', 'noc24-cs04', 65, 59, '2024-05-14', '4', '2023-2024'),
('student5@example.com', 'noc24-cs04', 70, 64, '2024-05-15', '4', '2023-2024');

-- Course 4 - noc24-cs07 - Secure Computation: Part I
-- 5 students with random verified marks (out of 100)
Insert into NPTEL_MARKS (email_id, c_code, verified_marks, ssn_marks, verified_date, sem, acc_year) values 
('nitish2210197@ssn.edu.in', 'noc24-cs07', 88, 81, '2024-05-16', '4', '2023-2024'),
('ranjeev2210215@ssn.edu.in', 'noc24-cs07', 94, 87, '2024-05-17', '4', '2023-2024'),
('student3@example.com', 'noc24-cs07', 76, 69, '2024-05-18', '4', '2023-2024'),
('student4@example.com', 'noc24-cs07', 82, 75, '2024-05-19', '4', '2023-2024'),
('student5@example.com', 'noc24-cs07', 90, 83, '2024-05-20', '4', '2023-2024');

-- Course 5 - noc24-cs15 - Blockchain and its Applications
-- 5 students with random verified marks (out of 100)
Insert into NPTEL_MARKS (email_id, c_code, verified_marks, ssn_marks, verified_date, sem, acc_year) values 
('nitish2210197@ssn.edu.in', 'noc24-cs15', 85, 78, '2024-05-21', '4', '2023-2024'),
('ranjeev2210215@ssn.edu.in', 'noc24-cs15', 92, 85, '2024-05-22', '4', '2023-2024'),
('student3@example.com', 'noc24-cs15', 78, 72, '2024-05-23', '4', '2023-2024'),
('student4@example.com', 'noc24-cs15', 65, 59, '2024-05-24', '4', '2023-2024'),
('student5@example.com', 'noc24-cs15', 70, 64, '2024-05-25', '4', '2023-2024');

(select sem from student where email_id = 'rahul.sharma@ssn.edu.in');
select c.c_name from course c
join set_course s on c.c_code = s.c_code
where sem = (select sem from student where email_id = 'rahul.sharma@ssn.edu.in');


select c.c_code,c.c_name,weeks,nptel_link,dept,acc_year from course c
join set_course s on c.c_code = s.c_code
where c.c_name = 'Database Management Systems';

select s.st_name, s.sem, c.c_name, ce.marks from student s
join certificate ce on ce.email_id = s.email_id
join course c on c.c_code = ce.c_code;

select n.email_id,s.st_name, c.c_name, n.verified_marks 
from nptel_marks n
join student s on s.email_id = n.email_id
join course c on c.c_code = n.c_code;

select * from certificate;

select * from teacher;
