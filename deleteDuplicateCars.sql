-- From the given CARS table, delete the records where car details are duplicated 

SELECT * FROM practicedb.cars;

-- solution 1
delete c1 from cars c1,cars c2
where c1.model_name=c2.model_name and c1.brand=c2.brand and c1.model_id>c2.model_id;

-- solution 2
-- Using group by, checking the multiple entries and using where clause with IN operator to delete the multiple entries

delete from cars
where model_id not in (select min(model_id)
					  from cars
					  group by model_name, brand);


