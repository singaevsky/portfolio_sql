-- Лучшие клиенты (топ-10 по общей сумме заказов)
WITH customer_totals AS
  (SELECT c.customer_id,
          c.first_name,
          c.last_name,
          c.second_name,
          SUM(p.price * p.count) AS total_spent
   FROM pharma_orders p
   JOIN customers c ON p.customer_id = c.customer_id
   GROUP BY c.customer_id,
            c.first_name,
            c.last_name,
            c.second_name),
     ranked_customers AS
  (SELECT *,
          ROW_NUMBER() OVER (
                             ORDER BY total_spent DESC) AS rn
   FROM customer_totals)
SELECT customer_id,
       first_name,
       last_name,
       second_name,
       total_spent
FROM ranked_customers
WHERE rn <= 10
ORDER BY total_spent DESC;
