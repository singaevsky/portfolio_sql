-- Накопленная сумма по клиентам (с ФИО как одно поле)

SELECT c.customer_id,
       CONCAT(c.last_name, ' ', c.first_name, ' ', c.second_name) AS full_name,
       p.report_date::DATE,
       p.price * p.count AS order_amount,
       SUM(p.price * p.count) OVER (PARTITION BY c.customer_id
                                    ORDER BY p.report_date::DATE ROWS UNBOUNDED PRECEDING) AS cumulative_spent
FROM pharma_orders p
JOIN customers c ON p.customer_id = c.customer_id
ORDER BY c.customer_id,
         p.report_date;
