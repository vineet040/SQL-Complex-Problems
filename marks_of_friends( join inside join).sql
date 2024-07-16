SELECT * FROM complexqueries.person;
select * from friend;

select name,p2.* from person p1
join (select f.PersonID, sum(p.score) as 'friend_score', count(1) as 'no. of friends' from friend f
		join person p
		On f.FriendID=p.PersonID
		group by f.PersonID
		having SUM(p.Score)>100) as p2
ON p2.PersonID=p1.Personid

