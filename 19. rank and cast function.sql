-- we need to identify cities where covid cases increasing everyday.

with cte as 
(
SELECT *, 
cast(rank() over(partition by city order by cases asc) as signed) as 'rnk',  -- cast is used to convert the unsigned values to signed, bcx unsigned values can't be negative
cast(rank() over(partition by city order by days asc) as signed) as 'rn' 
FROM complexqueries.19covid),
cte2 as (
select *, rnk-rn as 'diff' from cte)

select city from cte2
group by city
having count(distinct diff)=1