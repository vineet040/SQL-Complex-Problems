-- Group continuous success and fails over date
-- When we have to group continuous dates together we can use continuous row number and subrtarct from the date
with cte as (
select *, 
	row_number() over(partition by state order by date_value asc) as 'rn',
	date_sub(date_value, INTERVAL row_number() over(partition by state order by date_value asc) day) as 'group_date'
from 10tasks
order by date_value)

select min(date_value) as 'start_date', max(date_value) as 'end_date', state
from cte
group by group_date