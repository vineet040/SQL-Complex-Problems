select * from 25event_status;

with cte as (
select *, sum(case when status='on' and prev_stat='off' then 1 else 0 end) over(order by event_time asc) as 'groups1' from (
SELECT *, lag(status,1,status) over(order by event_time asc) as 'prev_stat' FROM complexqueries.25event_status) a)

select min(event_time) as 'starting time', max(event_time) as 'leaving time', sum(case when status='on' then 1 else 0 end) as 'total' from cte
group by groups1;