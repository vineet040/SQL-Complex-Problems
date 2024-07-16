-- find 3rd highest salary employee in each department 
-- if less than 3 then return lowest salary in dept

select *
from (
SELECT *, dense_rank() over(partition by dep_id order by salary desc) as 'rnk', count(1) over(partition by dep_id) as 'cnt' FROM complexqueries.28emp) a
where rnk=3 or (cnt<3 and cnt=rnk)