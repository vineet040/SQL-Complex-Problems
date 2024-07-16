-- supplier id, product_id and starting date of record for which stock quantity is less than 50 for 2 or more consecutive days

with cte as (
select *, day(record_date)-rn as 'grp' from (
SELECT *, row_number() over(partition by supplier_id, product_id order by record_date) as 'rn' FROM 60stock
where stock_quantity<50) t)

select supplier_id, product_id, count(1), min(record_date) from cte
group by supplier_id, product_id, grp
having count(1)>=2

-- -------------------------------------------
-- DDL
-- --------------------------
CREATE TABLE 60stock (
    supplier_id INT,
    product_id INT,
    stock_quantity INT,
    record_date DATE
);

delete from 60stock;
INSERT INTO 60stock (supplier_id, product_id, stock_quantity, record_date)
VALUES
    (1, 1, 60, '2022-01-01'),
    (1, 1, 40, '2022-01-02'),
    (1, 1, 35, '2022-01-03'),
    (1, 1, 45, '2022-01-04'),
 (1, 1, 51, '2022-01-06'),
 (1, 1, 55, '2022-01-09'),
 (1, 1, 25, '2022-01-10'),
    (1, 1, 48, '2022-01-11'),
 (1, 1, 45, '2022-01-15'),
    (1, 1, 38, '2022-01-16'),
    (1, 2, 45, '2022-01-08'),
    (1, 2, 40, '2022-01-09'),
    (2, 1, 45, '2022-01-06'),
    (2, 1, 55, '2022-01-07'),
    (2, 2, 45, '2022-01-08'),
 (2, 2, 48, '2022-01-09'),
    (2, 2, 35, '2022-01-10'),
 (2, 2, 52, '2022-01-15'),
    (2, 2, 23, '2022-01-16');
