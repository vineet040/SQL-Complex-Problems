-- Tournament Winners
select * from matches;
select * from players;
with cte as(
select first_player as 'player', first_score as 'score' from matches
union all
select second_player as 'player', second_score as 'score' from matches
)

select group_id, max(score) from players p1
join (select player, sum(score) as 'score' from cte
		group by player) as p2
on p1.player_id=p2.player
group by group_id

