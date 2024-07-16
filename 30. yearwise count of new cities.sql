-- identify yearwise count of new cities where udaan started their operations

select bus_year, count(city_id) from(
SELECT city_id, min(year(business_date)) as 'bus_year' FROM complexqueries.30business_city
group by city_id) a
group by bus_year