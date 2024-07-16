-- Q.Floor Visits
with 
cte as(
select name, floor, count(1) as 'floor_visits', rank() over(partition by name order by count(1)) as rn
from entries
group by name,floor), 
cte2 as
(
	select name, count(1) as 'total_visits', group_concat(distinct resources separator ', ') as 'resources'
    from entries
    group by name
)

select cte.name,cte.floor as 'most_visited',total_visits,resources from cte
join cte2
ON cte.name=cte2.name
where cte.rn=1;