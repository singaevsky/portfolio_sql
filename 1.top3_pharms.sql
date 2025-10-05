SELECT pharmacy_name,
       SUM(price * COUNT) AS total_sales
FROM pharma_orders
GROUP BY pharmacy_name
ORDER BY total_sales DESC
LIMIT 3;