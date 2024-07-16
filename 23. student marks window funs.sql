-- list of students who got more than avg marks in each subject

-- percent of students who got more than 90 in any subject among all students

-- for each student and test, identify if their marks decreased or increased from the previous test
-- -----------------------------------------------
with cte as(
SELECT *, avg(marks) over(partition by subject) as 'sub_avg',
case when marks> avg(marks) over(partition by subject) then 1 else 0 end as 'check1'
  FROM complexqueries.23students
order by studentid)

select studentid, studentname from cte
group by studentid, studentname
having count(subject)=sum(check1);
-- -----------------------------------------------------------------------------

select count(distinct studentid)*100/(select count(distinct studentid) from 23students) from 23students
where marks>90
order by studentid;

-- -------------------------------------------------------------------------------
select *,
case when marks < lag(marks) over(partition by studentid order by testdate,testid) then 'Inc'
 when marks > lag(marks) over(partition by studentid order by testdate,testid) then 'Dec'
 else 'NULL'
 end as 'status'
from 23students
order by studentid;




