SELECT pharmacy_name,
       SUM(price * COUNT) AS total_sales
FROM pharma_orders
GROUP BY pharmacy_name
HAVING SUM(price * COUNT) > 1800000
ORDER BY total_sales DESC;