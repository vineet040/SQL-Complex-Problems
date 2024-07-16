select p1.name as p1 ,p2.name as p2, count(1) from 13orders o1
join 13orders o2
on o1.order_id=o2.order_id
join 13products p1
on o1.product_id= p1.id
join 13products p2
on o2.product_id= p2.id
where o1.product_id<o2.product_id
group by 
p1.name,p2.name