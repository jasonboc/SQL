use db_university_basic;
show tables;
select *  from course;
select * from takes;
select * from student;
select * from teaches;
select * from instructor;
select * from department;
select * from section;
select * from classroom;

#Q1
select course_id,title from course where dept_name REGEXP 'Comp' and credits=3;

#Q2
DROP  TABLE IF EXISTS new_tbl;
CREATE TEMPORARY TABLE new_tbl
select teaches.ID as InstucID, takes.ID as StuID from teaches inner join takes on teaches.course_id=takes.course_id;
select name from student where ID=(select StuID from new_tbl where InstucID= (select ID from instructor where name='Einstein'));

#Q3
select instructor.name,instructor.dept_name,department.building from instructor inner join department on instructor.dept_name=department.dept_name order by instructor.salary desc;

#Q4
select instructor.name, teaches.course_id from instructor inner join teaches on instructor.ID=teaches.ID;

#Q5
select name from instructor where salary between 90000 and 1000000;

#Q6
select distinct title from course inner join (select course_id from teaches where semester='fall' and year='2009') as A on course.course_id=A.course_id;

#Q7
select distinct title from course inner join (select course_id from teaches where semester='spring' and year='2010') as A on course.course_id=A.course_id;

#Q8
select distinct title from course inner join (select course_id from teaches where (semester='fall' and year='2009') or (semester='spring' and year='2010')) as A on course.course_id=A.course_id;

#Q9
select title from course inner join (select A.course_id from (select course_id from teaches where semester='fall' and year='2009')as A inner join (select course_id from teaches where semester='spring' and year='2010') as B on A.course_id=B.course_id)as C on course.course_id=C.course_id;

#Q10
select distinct name,salary,dept_name from instructor inner join (select ID from teaches where year='2009') as A on instructor.ID=A.ID;

#Q11
select avg(salary) from instructor where dept_name regexp 'Comp';

#Q12
select dept_name,B.capacity from department inner join (select capacity,A.building from classroom inner join (select course_id, building from section where semester='Fall' and year='2009')as A on classroom.building=A.building)as B on department.building=B.building;

#Q13
select student.ID, name,dept_name,tot_cred,B.title from student inner join (select title, A.ID from course inner join (select ID,course_id from takes) as A on course.course_id=A.course_id)as B on student.ID=B.ID;

#Q14
select A.name, B.course_id,B.sec_id from (select ID,name from student where dept_name regexp 'Comp') as A inner join (select ID,course_id, sec_id from takes where semester_id='Spring' and year='2009')as B on A.ID=B.ID;