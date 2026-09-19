-- JOIN

-- Q1
SELECT 
	o.order_id,
	c.first_name + ' ' + c.last_name AS full_name,
	s.store_name, 
	stf.first_name + ' ' + stf.last_name AS staff_name
FROM 
sales.orders o
INNER JOIN sales.customers c
ON o.customer_id = c.customer_id 
RIGHT JOIN sales.stores as s 
ON s.store_id = o.store_id 
RIGHT JOIN sales.staffs as stf 
ON stf.staff_id = o.staff_id 


-- Q2
SELECT * from production.products as p
FULL OUTER JOIN production.brands b 
ON p.brand_id = b.brand_id 
FULL OUTER JOIN production.categories c 
ON p.category_id = c.category_id 


-- Q3
SELECT 
	c.first_name + ' ' + c.last_name AS name,
	c.city,
	c.email 
FROM sales.customers c 
WHERE NOT EXISTS (
    SELECT 1
    FROM sales.orders o
    WHERE o.customer_id = c.customer_id
)

-- Q4
SELECT 
	(oi.quantity * oi.list_price * (1 - oi.discount)) as revenue
FROM sales.orders o
INNER JOIN sales.order_items oi
ON oi.order_id = o.order_id
LEFT JOIN sales.stores s 
ON s.store_id = o.store_id
order by revenue desc

-- Q5
SELECT 
	COUNT(p.product_id),
	AVG(p.list_price),
	MAX(p.list_price)
	FROM production.brands b 
	INNER JOIN production.products p 
	ON b.brand_id = p.brand_id
	GROUP BY p.brand_id
	
-- Q6
SELECT 
    MONTH(o.order_date) AS order_month,
    COUNT(*) AS total_items_ordered,
    (oi.quantity * oi.list_price * (1 - oi.discount)) as total_revenue
FROM sales.orders o 
INNER JOIN sales.order_items oi ON o.order_id = oi.order_id 
WHERE YEAR(o.order_date) = 2017
GROUP BY MONTH(o.order_date)
ORDER BY order_month

