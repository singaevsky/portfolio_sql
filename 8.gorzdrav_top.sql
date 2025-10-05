--  Самые частые клиенты аптек "Горздрав" и "Здравсити"
WITH gorzdrav_top AS
  (SELECT c.customer_id,
          CONCAT(c.last_name, ' ', c.first_name, ' ', c.second_name) AS full_name,
          COUNT(*) AS order_count,
          'Горздрав' AS pharmacy
   FROM pharma_orders p
   JOIN customers c ON p.customer_id = c.customer_id
   WHERE p.pharmacy_name = 'Горздрав'
   GROUP BY c.customer_id,
            c.last_name,
            c.first_name,
            c.second_name
   ORDER BY order_count DESC
   LIMIT 10),
     zdorov_top AS
  (SELECT c.customer_id,
          CONCAT(c.last_name, ' ', c.first_name, ' ', c.second_name) AS full_name,
          COUNT(*) AS order_count,
          'Здравсити' AS pharmacy
   FROM pharma_orders p
   JOIN customers c ON p.customer_id = c.customer_id
   WHERE p.pharmacy_name = 'Здравсити'
   GROUP BY c.customer_id,
            c.last_name,
            c.first_name,
            c.second_name
   ORDER BY order_count DESC
   LIMIT 10)
SELECT *
FROM gorzdrav_top
UNION ALL
SELECT *
FROM zdorov_top
ORDER BY pharmacy,
         order_count DESC;