-- find the largest order by value for each sales person and display order details
-- with out cte, windowfun
select * from 24int_orders;

SELECT a.order_number,a.order_date, a.cust_id,a.salesperson_id, a.amount FROM 24int_orders a
left join 24int_orders b
on a.salesperson_id=b.salesperson_id
group by a.order_number,a.order_date, a.cust_id,a.salesperson_id, a.amount
having a.amount>=max(b.amount)