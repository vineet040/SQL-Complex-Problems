--  Understand the problem statement
--  Daily active users
		-- 2022-01-01	3
		-- 2022-01-02	1
		-- 2022-01-03	3
		-- 2022-01-04	1

--  Weekly active users
		-- 1	3
		-- 2	5

--  same day install and purchase
		-- 4	2022-01-03	India
		-- 5	2022-01-03	SL
		-- 6	2022-01-04	Pakistan
		-- select user_id,event_date,country from 15activity a
		-- where event_name='app-installed' and 
		-- 		event_date = (select event_date from 15activity b where event_name='app-purchase' and b.event_date=a.event_date and a.user_id=b.user_id )

-- datewise total number of users who made purchase same day they installed

		-- 2022-01-01	0
		-- 2022-01-02	0
		-- 2022-01-03	2
		-- 2022-01-04	1

		-- select event_date, count(new_user) from (
		-- select user_id,event_date, case when count(distinct event_name)=2 then user_id else null end as 'new_user' from 15activity
		-- group by user_id,event_date) a
		-- group by event_date

--  country wise paid users percentage
		-- India	40.0000
		-- USA	20.0000
		-- others	40.0000
        
		-- select case when country in ('India','USA') then country else 'others' end as 'newcountry'
		-- ,count(1)*100/(select count(1) from 15activity where event_name='app-purchase') as'percent'
		-- from 15activity
		-- where event_name='app-purchase'
		-- group by case when country in ('India','USA') then country else 'others' end
        
--  Last question and assignment 

select b.user_id,b.event_date from 15activity a
join 15activity b
on a.user_id=b.user_id
where a.event_name='app-installed' and b.event_name='app-purchase' and datediff(b.event_date,a.event_date)=1;

select * from 15activity;

