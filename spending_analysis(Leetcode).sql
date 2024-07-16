/* User purchase platform.
-- The table logs the spendings history of users that make purchases from an online shopping website which has a desktop 
and a mobile application.
-- Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only 
and both mobile and desktop together for each date.
*/

SELECT spend_date, count(distinct user_id) as total_users,
sum(amount) as 'total_spent_both',
sum(if(platform='mobile',amount,0)) as 'total_spent_mobile', 
sum(if(platform='desktop',amount,0)) as 'total_spent_desktop'
FROM 11spending
group by spend_date