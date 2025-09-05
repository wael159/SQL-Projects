-- Solution for Q3
WITH required_brands AS (
    SELECT DISTINCT
        c.customer_id,
        c.first_name,
        c.last_name,
        p.brand_name
    FROM orders o
    LEFT JOIN customers c ON o.customer_id = c.customer_id
    LEFT JOIN products  p ON o.product_id  = p.product_id
    WHERE p.brand_name IN ('brand_1','brand_2')
)
SELECT customer_id, first_name, last_name
FROM required_brands
GROUP BY customer_id, first_name, last_name
HAVING COUNT(DISTINCT brand_name) = 2
ORDER BY first_name, last_name;
