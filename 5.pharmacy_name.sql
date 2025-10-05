SELECT pharmacy_name,
       COUNT(DISTINCT customer_id) AS unique_customers
FROM pharma_orders
GROUP BY pharmacy_name
ORDER BY unique_customers DESC;