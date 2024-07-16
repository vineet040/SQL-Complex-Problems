-- Deadly Combination of Group By and Having Clause
-- find student with same marks in physics and chemistry

SELECT student_id FROM complexqueries.18exams
where subject in ('Chemistry','Physics')
group by student_id
having count(subject)=2 and count(distinct marks)=1