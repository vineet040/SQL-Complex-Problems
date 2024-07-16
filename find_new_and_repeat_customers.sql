-- Q.find new and repeat customers
-- Approach - We will find the first order date of each customer, then it will be easy to cal if the customer is new or repeater on a particular date
with cte as
(
select *, min(order_date) over(partition by customer_id order by order_date) as 'first_order' from customer_orders
)

 select order_date, sum(if(order_date=first_order,1,0)) as 'new', sum(if(order_date<>first_order,1,0)) as 'repeat', sum(if(order_date=first_order,order_amount,0)) as 'new_amount',
 sum(if(order_date<>first_order,order_amount,0)) as 'repeat_amount'
 from cte
 group by order_date;

 
 
