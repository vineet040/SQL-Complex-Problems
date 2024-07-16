-- human traffic of stadium, 3 or more consecutive days with more than 100 people everyday
with cte as(
SELECT *,
lag(no_of_people,1,0) over(order by visit_date) as prev_1,
lag(no_of_people,2,0) over(order by visit_date) as prev_2,
lead(no_of_people,1,0) over(order by visit_date) as next_1,
lead(no_of_people,2,0) over(order by visit_date) as next_2
FROM complexqueries.29stadium)

select id,visit_date, no_of_people
from cte
where (no_of_people>99 and prev_1>99 and prev_2>99) or (no_of_people>99 and prev_1>99 and next_1>99) or (no_of_people>99 and next_1>99 and next_2>99);

-- ------------------------------------------------------------------------------------------------------------------------

with cte2 as(
select *, row_number() over(order by visit_date) as 'rn', id-row_number() over(order by visit_date) as 'grp'
from 29stadium
where no_of_people>99)

select * from cte2 where grp in (select grp from cte2 group by grp having count(1)>=3)