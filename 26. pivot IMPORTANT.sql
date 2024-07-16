-- pivot the data from row to column

select * from 26players_location;

select
max(case when city='Bangalore' then name end) as 'Bangalore',
max(case when city='Delhi' then name end) as 'Delhi',
max(case when city='Mumbai' then name end) as 'Mumbai'
from
(SELECT *, row_number() over(partition by city order by name asc) as 'player_group'
FROM 26players_location) a
group by player_group;