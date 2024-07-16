-- find companies who have atleast 2 users who speak eng and german both lang

select  company_id from (
SELECT company_id, user_id FROM complexqueries.20company_users
where language in ('German','English')
group by company_id, user_id
having count(language)=2) t
group by company_id
having count(*)>=2