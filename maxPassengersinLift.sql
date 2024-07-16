-- list of passengers allowed to enter the lift based on the maximum capacity of the lift.

with cte as
(
SELECT * , sum(weight_kg) over(partition by lift_id order by weight_kg rows between unbounded preceding and current row) as 'cum_sum'
FROM practicedb.lift_passengers
)

select passenger_name, id from cte c
join lifts l
on c.lift_id=l.id and c.cum_sum<=l.capacity_kg