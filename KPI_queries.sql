
-- KPI 1

SELECT round(sum(payment_value),2) as total_value,
case
when dayofweek(order_purchase_timestamp) IN (1,7)
THEN "WEEKDAY" 
ELSE
"WEEKEND"
END AS DAY_OF_WEEK FROM orders as o
join payments as p
on
p.order_id=o.order_id
group by DAY_OF_WEEK;


-- KPI 2

select count(p.order_id) as NO_OF_ORDERS, r.review_score from payments as p
join reviews as r
on
p.order_id=r.order_id
where p.payment_type ="credit_card" and r.review_score=5
group by 2;



-- KPI 3

select p.product_category_name,avg(datediff(order_delivered_customer_date,order_purchase_timestamp)) as deliver_days from orders as o
join order_items as ot
on ot.order_id=o.order_id
join products as p
on p.product_id=ot.product_id
where p.product_category_name="pet_shop";




-- KPI 4

with cte as
 (select avg(ot.price) as avgp from order_items as ot
join orders as o
on
o.order_id=ot.order_id
join customers as c
on
o.customer_id=c.customer_id
where c.customer_city="sao paulo"
)

select (select round(avgp,2) from cte) as average_price, round(avg(p.payment_value),2) as avg_pay from payments as p
join orders as o
on
p.order_id=o.order_id
join customers as c
on
o.customer_id=c.customer_id
where c.customer_city="sao paulo";


-- KPI 5

select r.review_score,avg(datediff(order_delivered_customer_date,order_purchase_timestamp)) as deliver_days from orders as o
join reviews as r
on r.order_id=o.order_id
group by 1 
order by 1 desc;














 







