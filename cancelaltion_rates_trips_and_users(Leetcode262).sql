-- Trips and Users(Leetcode)
select request_at as 'day', round(sum(if(status<>'completed',1,0))/count(1),2) as 'cancellation_rate'
from trips t
join users u
on t.client_id=u.users_id
join users u1
on t.driver_id=u1.users_id
where u.banned='No' and u1.banned='No' and request_at between "2013-10-01" and "2013-10-03"
group by request_at