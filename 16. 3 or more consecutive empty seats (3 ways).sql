-- Understand the Problem - 3 or more consecutive empty seats
-- Lead/Lag ----- Advance Aggregation ----------- Using ROW_NUMBER

-- Method 1 : Lead/Lag
select seat_no from (
select *,
lag(is_empty,1) over(order by seat_no) as 'prev1',
lag(is_empty,2) over(order by seat_no) as 'prev2',
lead(is_empty,1) over(order by seat_no) as 'next1',
lead(is_empty,2) over(order by seat_no) as 'next2'
from 16bms) t
where (is_empty='Y' and prev1='Y' and prev2='Y') or (is_empty='Y' and prev1='Y' and next1='Y') or (is_empty='Y' and next1='Y' and next2='Y')
order by seat_no;

-- Method 2 : Advance Aggregation
select seat_no from(
select * ,
sum(case when is_empty='Y' then 1 else 0 end) over(order by seat_no rows between 2 preceding and current row) as 'prev_2',
sum(case when is_empty='Y' then 1 else 0 end) over(order by seat_no rows between 1 preceding and 1 following) as 'prev_next_2',
sum(case when is_empty='Y' then 1 else 0 end) over(order by seat_no rows between current row and 2 following) as 'next_2'
from 16bms) t
where prev_2=3 or prev_next_2=3 or next_2=3;

-- Method 3: Using ROW_NUMBER
with cte as (
select *, row_number() over(order by seat_no) as 'rn', seat_no-row_number() over(order by seat_no) as 'diff' from 16bms
where is_empty='Y')
, cte2 as (
select diff from cte
group by diff
having count(1)>=3)

select * from cte where diff in (select diff from cte2)

