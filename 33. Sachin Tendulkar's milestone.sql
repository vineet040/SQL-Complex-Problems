-- Sachin Tendulkar's milestone matches ie: when he completed 100, 5000, 10000 runs
with cte as 
( 
select 'Milestone1' as 'milestones', 500 as 'run'
union all
select 'Milestone2' as 'milestones', 1000 as 'run'
union all
select 'Milestone3' as 'milestones', 5000 as 'run'
union all
select 'Milestone4' as 'milestones', 10000 as 'run'
union all
select 'Milestone5' as 'milestones', 15000 as 'run'
),
cte2 as (
select * from (
SELECT `Match`,Innings, runs, sum(runs) over(order by `Match` rows between unbounded preceding and current row) as 'cum_sum' FROM 33sachin_batting_scores) a
join cte
on cum_sum>=run)

select milestones, run,min(innings), min(`Match`), min(cum_sum) from cte2
group by milestones, run