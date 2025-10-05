-- Выявление "оттоковых" клиентов (не покупали более 60 дней)
SELECT
    c.customer_id,
    CONCAT(c.last_name, ' ', c.first_name) AS name,
    MAX(p.report_date::DATE) AS last_purchase,
    CURRENT_DATE - MAX(p.report_date::DATE) AS days_since_last
FROM pharma_orders p
JOIN customers c ON p.customer_id = c.customer_id
GROUP BY c.customer_id, c.last_name, c.first_name
HAVING CURRENT_DATE - MAX(p.report_date::DATE) > 60
ORDER BY days_since_last DESC;