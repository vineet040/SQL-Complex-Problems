-- Understand the problem
-- 01:19 Method 1 Aggregation
-- 03:53 Method 2 Recursive CTE
-- 08:56 Method 3 Cross Join ------- get all the combinations using corss join and then check which one is not present in the given table

select * from 17stores;

SELECT store, concat('Q',10-sum(cast(substr(quarter,2) as UNSIGNED))) FROM complexqueries.17stores
group by store;