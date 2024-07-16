-- how many products falls into customer budget along with list of products
-- group_concat(product_id) - takes all expressions from rows and concatenates them into a single string

with cte as (
SELECT *, sum(cost) over(order by product_id ) as 'cum_sum' FROM complexqueries.21products)

select customer_id, max(budget), count(1), group_concat(product_id) from 21customer_budget b
join cte c
on c.cum_sum<=b.budget
group by customer_id
order by customer_id;

