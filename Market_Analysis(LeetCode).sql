SELECT * FROM complexqueries.users1;
select * from items1;

with cte as(
select *, rank() over(partition by seller_id order by order_date) as 'rnk'
from orders1
)

select u1.user_id, case 
					when favorite_brand=item_brand then 'Yes'
                    else 'No'
                    end as '2nd sold item fav'
from users1 u1
left join cte c1						-- We have to left join to get all the users
on c1.seller_id=u1.user_id and c1.rnk=2
left join items1 i1						-- We have to left join to keep the data of all users
on c1.item_id=i1.item_id

