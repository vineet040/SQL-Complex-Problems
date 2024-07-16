-- write SQL query to find total number of people present inside the hospital
select emp_id from (
SELECT *, row_number() over(partition by emp_id order by time desc) as rn FROM 100hospital) a
where rn=1 and action='in';

select * from 100hospital;

-- -------------------------------------------
-- DDL
-- Create the 100hospital table
CREATE TABLE 100hospital (
    emp_id INT,
    action VARCHAR(10),
    time DATETIME
);

-- Insert the data into the 100hospital table
INSERT INTO 100hospital (emp_id, action, time) VALUES
(1, 'in', '2019-12-22 09:00:00'), 
(1, 'out', '2019-12-22 09:15:00'), 
(2, 'in', '2019-12-22 09:00:00'), 
(2, 'out', '2019-12-22 09:15:00'), 
(2, 'in', '2019-12-22 09:30:00'), 
(3, 'out', '2019-12-22 09:00:00'), 
(3, 'in', '2019-12-22 09:15:00'), 
(3, 'out', '2019-12-22 09:30:00'), 
(3, 'in', '2019-12-22 09:45:00'), 
(4, 'in', '2019-12-22 09:45:00'), 
(5, 'out', '2019-12-22 09:40:00');
