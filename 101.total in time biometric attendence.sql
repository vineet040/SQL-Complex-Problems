select emp_id, sum(timestampdiff(minute, time, out_time)) as 'total_in_time' from 
	(select *, lead(time,1,0) over(partition by emp_id order by time) as 'out_time' from 101biometric
	order by emp_id) a
where action='in' and out_time!=0
group by emp_id;
-- Output
-- 1	115
-- 2	15
-- 3	75

-- DDL

CREATE TABLE 101biometric (
    emp_id INT,
    action VARCHAR(10),
    time DATETIME
);

INSERT INTO 101biometric (emp_id, action, time) VALUES
(1, 'in', '2019-12-22 09:00:00'), 
(1, 'out', '2019-12-22 09:15:00'), 
(2, 'in', '2019-12-22 09:00:00'), 
(2, 'out', '2019-12-22 09:15:00'), 
(2, 'in', '2019-12-22 09:30:00'), 
(3, 'out', '2019-12-22 09:00:00'), 
(3, 'in', '2019-12-22 09:15:00'), 
(3, 'out', '2019-12-22 09:30:00'), 
(3, 'in', '2019-12-22 09:45:00'), 
(3, 'out', '2019-12-22 10:45:00'),
(4, 'in', '2019-12-22 09:45:00'), 
(1, 'in', '2019-12-22 10:00:00'),
(1, 'out', '2019-12-22 11:40:00'),
(5, 'out', '2019-12-22 09:40:00');



