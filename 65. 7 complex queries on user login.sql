-- DDL AT THE END OF THIS FILE
-- 1 users that didn't login in past 5 months
-- 2 how many users and how many sessions were at each quarter, order by quarter from newest to oldest ; Return first day of quarter, user_cnt and session cnt
-- 3 Display user_id that login in january 2024 and didn't login in November 2023
-- 4 add to the query from 2 the percentage change in sessions from last quarter. return : first day of the quarter, session cnt, session cnt prev, session precent change
-- 5 display the user that had the highest session score (max) from each day; REturn Date, username, score
-- 6 To identify our best users - return the users that had a session on every single day since their first login, Return user-id
-- 7 on what dates there were no login at all

select * from 65logins;
-- 1-----------------------------------------------------------------------------------

select distinct USER_ID from 65logins where user_id not in (
SELECT user_id  FROM complexqueries.65logins
where login_timestamp>date_add(now(),interval -5 month));

select user_id from 65logins
group by user_id
having max(LOGIN_TIMESTAMP) < date_add(now(),interval -5 month);

-- 2-----------------------------------------------------------------------------------

select quarter(login_timestamp) as 'Q', year(login_timestamp) as 'Y',min(LOGIN_TIMESTAMP), count(distinct user_id), count(session_id), 
concat(year(min(LOGIN_TIMESTAMP)),'-',LPAD((Quarter(min(LOGIN_TIMESTAMP))-1)*3+1,2,'0'),'-01') as 'first_day' 
from 65logins
group by quarter(login_timestamp),year(login_timestamp);

-- 3-----------------------------------------------------------------------------------

select distinct user_id from 65logins
where user_id not in (
select distinct user_id from 65logins
where month(LOGIN_TIMESTAMP)=11) and month(login_timestamp)=1;

-- 4-----------------------------------------------------------------------------------

with cte as (
select quarter(login_timestamp) as 'Q', year(login_timestamp) as 'Y', count(distinct user_id) as 'user', count(session_id) as 'session', 
concat(year(min(LOGIN_TIMESTAMP)),'-',LPAD((Quarter(min(LOGIN_TIMESTAMP))-1)*3+1,2,'0'),'-01') as 'first_day' 
from 65logins
group by quarter(login_timestamp),year(login_timestamp)
order by first_day)

select *, lag(session,1,session) over(order by first_day asc) as 'prev',
((session-lag(session,1,session) over(order by first_day asc))/lag(session,1,session) over(order by first_day asc))*100 as 'percent_change'  from cte;

-- 5-----------------------------------------------------------------------------------

select user_id, date(login_timestamp), sum(session_score) from 65logins
group by user_id, date(login_timestamp);

-- 6-----------------------------------------------------------------------------------

with cte as (
select *, cast(day(login_timestamp) as signed) - cast(row_number() over(partition by user_id order by LOGIN_TIMESTAMP asc) as signed) as rn from 65logins)
select user_id from cte 
group by user_id
having count(distinct rn)=1;

-- 7-----------------------------------------------------------------------------------

select min(date(LOGIN_TIMESTAMP)) as first_date, max(date(LOGIN_TIMESTAMP)) as last_date from 65logins;

with recursive cte as (
select min(date(LOGIN_TIMESTAMP)) as first_date, max(date(LOGIN_TIMESTAMP)) as last_date from 65logins
union all
select date_add(first_date, interval 1 day) as first_date, last_date from cte
where first_date<last_date)

select first_date from cte
where first_date not in (select distinct date(login_timestamp) from 65logins);

-- ---------------------------------------------------------------------------------------
-- DDL 
CREATE TABLE 65users (
    USER_ID INT PRIMARY KEY,
    USER_NAME VARCHAR(20) NOT NULL,
    USER_STATUS VARCHAR(20) NOT NULL
);

CREATE TABLE 65logins (
    USER_ID INT,
    LOGIN_TIMESTAMP DATETIME NOT NULL,
    SESSION_ID INT PRIMARY KEY,
    SESSION_SCORE INT,
    FOREIGN KEY (USER_ID) REFERENCES 65USERS(USER_ID)
);

-- Users Table
INSERT INTO 65USERS VALUES (1, 'Alice', 'Active');
INSERT INTO 65USERS VALUES (2, 'Bob', 'Inactive');
INSERT INTO 65USERS VALUES (3, 'Charlie', 'Active');
INSERT INTO 65USERS  VALUES (4, 'David', 'Active');
INSERT INTO 65USERS  VALUES (5, 'Eve', 'Inactive');
INSERT INTO 65USERS  VALUES (6, 'Frank', 'Active');
INSERT INTO 65USERS  VALUES (7, 'Grace', 'Inactive');
INSERT INTO 65USERS  VALUES (8, 'Heidi', 'Active');
INSERT INTO 65USERS VALUES (9, 'Ivan', 'Inactive');
INSERT INTO 65USERS VALUES (10, 'Judy', 'Active');

-- Logins Table 

INSERT INTO 65LOGINS  VALUES (1, '2023-07-15 09:30:00', 1001, 85);
INSERT INTO 65LOGINS VALUES (2, '2023-07-22 10:00:00', 1002, 90);
INSERT INTO 65LOGINS VALUES (3, '2023-08-10 11:15:00', 1003, 75);
INSERT INTO 65LOGINS VALUES (4, '2023-08-20 14:00:00', 1004, 88);
INSERT INTO 65LOGINS  VALUES (5, '2023-09-05 16:45:00', 1005, 82);

INSERT INTO 65LOGINS  VALUES (6, '2023-10-12 08:30:00', 1006, 77);
INSERT INTO 65LOGINS  VALUES (7, '2023-11-18 09:00:00', 1007, 81);
INSERT INTO 65LOGINS VALUES (8, '2023-12-01 10:30:00', 1008, 84);
INSERT INTO 65LOGINS  VALUES (9, '2023-12-15 13:15:00', 1009, 79);
INSERT INTO 65LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (1, '2024-01-10 07:45:00', 1011, 86);
INSERT INTO 65LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (2, '2024-01-25 09:30:00', 1012, 89);
INSERT INTO 65LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (3, '2024-02-05 11:00:00', 1013, 78);
INSERT INTO 65LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (4, '2024-03-01 14:30:00', 1014, 91);
INSERT INTO 65LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (5, '2024-03-15 16:00:00', 1015, 83);
INSERT INTO 65LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (6, '2024-04-12 08:00:00', 1016, 80);
INSERT INTO 65LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (7, '2024-05-18 09:15:00', 1017, 82);
INSERT INTO 65LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (8, '2024-05-28 10:45:00', 1018, 87);
INSERT INTO 65LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (9, '2024-06-15 13:30:00', 1019, 76);
INSERT INTO 65LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-25 15:00:00', 1010, 92);
INSERT INTO 65LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-26 15:45:00', 1020, 93);
INSERT INTO 65LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-27 15:00:00', 1021, 92);
INSERT INTO 65LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-28 15:45:00', 1022, 93);
INSERT INTO 65LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (1, '2024-01-10 07:45:00', 1101, 86);
INSERT INTO 65LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (3, '2024-01-25 09:30:00', 1102, 89);
INSERT INTO 65LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (5, '2024-01-15 11:00:00', 1103, 78);
INSERT INTO 65LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (2, '2023-11-10 07:45:00', 1201, 82);
INSERT INTO 65LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (4, '2023-11-25 09:30:00', 1202, 84);
INSERT INTO 65LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (6, '2023-11-15 11:00:00', 1203, 80);

