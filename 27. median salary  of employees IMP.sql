-- find median salary of employees for each company. 
with cte as(
select *, total_cnt/2 as 'temp1', total_cnt/2 +1 as 'temp2'
 from ( SELECT *, row_number() over(partition by company order by salary asc) as 'rn', count(1) over(partition by company) as 'total_cnt' FROM 27employee) a)
 
 select company,avg(salary) from cte
 where rn between temp1 and temp2
 group by company