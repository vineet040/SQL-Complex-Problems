-- finid total number of sms exchanged between each person per day

select sms_date, p1,p2, sum(sms_no) from 
	(SELECT sms_date,
	case when sender < receiver then sender else receiver end as p1,
	case when sender > receiver then sender else receiver end as p2,
	sms_no FROM complexqueries.22subscriber) a
group by sms_date, p1,p2