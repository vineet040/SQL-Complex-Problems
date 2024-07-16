-- there are 3 rows in a movie hall with 10 seats in each row
-- write SQL to find 4 consecutive empy seats
with cte as (SELECT *, left(seat,1) as 'row_id', cast(substr(seat, 2,2) as signed) as 'seat_id' from 31movie), 
cte2 as (select * from (
	SELECT *, left(seat,1) as 'row_id', cast(substr(seat, 2,2) as signed) as 'seat_id', 
	sum(occupancy) over(partition by left(seat,1) order by cast(substr(seat, 2,2) as signed) rows between current row and 3 following ) as 'chk'
	FROM 31movie) a
where chk=0 and seat_id<8)

select cte.seat from cte
join cte2
on cte.row_id=cte2.row_id and cte.seat_id between cte2.seat_id and cte2.seat_id+3