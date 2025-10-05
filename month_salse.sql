-- Продажи препаратов с "аква" по месяцам (с названиями месяцев)
SELECT
    EXTRACT(MONTH FROM report_date::DATE) AS month_num,
    CASE EXTRACT(MONTH FROM report_date::DATE)
        WHEN 1 THEN 'Январь'
        WHEN 2 THEN 'Февраль'
        WHEN 3 THEN 'Март'
        WHEN 4 THEN 'Апрель'
        WHEN 5 THEN 'Май'
        WHEN 6 THEN 'Июнь'
        WHEN 7 THEN 'Июль'
        WHEN 8 THEN 'Август'
        WHEN 9 THEN 'Сентябрь'
        WHEN 10 THEN 'Октябрь'
        WHEN 11 THEN 'Ноябрь'
        WHEN 12 THEN 'Декабрь'
    END AS month_name,
    SUM(price * count) AS sales_akva
FROM pharma_orders
WHERE LOWER(drug) LIKE '%аква%'
GROUP BY month_num
ORDER BY month_num;