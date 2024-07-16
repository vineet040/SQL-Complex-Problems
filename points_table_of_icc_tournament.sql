-- Derive points table for icc tournament 
with cte as 
(select Team_1 as team, case when winner=Team_1 then 1 else 0 end as 'win_flag'
from icc_world_cup
union all
select Team_2 as team, case when winner=Team_2 then 1 else 0 end as 'win_flag'
from icc_world_cup )

select team, count(1) as 'total_match', sum(win_flag) as 'matches_won', count(1)-sum(win_flag) as 'matches_lost'  from cte
group by team;