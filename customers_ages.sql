WITH customers_ages AS
  (SELECT customer_id,
          gender,
          EXTRACT(YEAR
                  FROM AGE(CAST(date_of_birth AS DATE))) AS customers_age,
          CASE
              WHEN gender = 'муж'
                   AND EXTRACT(YEAR
                               FROM AGE(CAST(date_of_birth AS DATE))) < 30 THEN 'Мужчины младше 30'
              WHEN gender = 'муж'
                   AND EXTRACT(YEAR
                               FROM AGE(CAST(date_of_birth AS DATE))) BETWEEN 30 AND 45 THEN 'Мужчины 30-45'
              WHEN gender = 'муж'
                   AND EXTRACT(YEAR
                               FROM AGE(CAST(date_of_birth AS DATE))) > 45 THEN 'Мужчины старше 45'
              WHEN gender = 'жен'
                   AND EXTRACT(YEAR
                               FROM AGE(CAST(date_of_birth AS DATE))) < 30 THEN 'Женщины младше 30'
              WHEN gender = 'жен'
                   AND EXTRACT(YEAR
                               FROM AGE(CAST(date_of_birth AS DATE))) BETWEEN 30 AND 45 THEN 'Женщины 30-45'
              WHEN gender = 'жен'
                   AND EXTRACT(YEAR
                               FROM AGE(CAST(date_of_birth AS DATE))) > 45 THEN 'Женщины старше 45'
              ELSE 'Другая группа'
          END AS customers_group
   FROM customers),
     customer_groups AS
  (SELECT c_a.customers_group AS customer_group,
          COUNT(DISTINCT c_a.customer_id) AS cust_in_group_cnt,
          SUM(p_o.price * p_o.count) AS cust_group_amnt
   FROM customers_ages AS c_a
   INNER JOIN pharma_orders AS p_o USING (customer_id)
   GROUP BY c_a.customers_group),
     total_sales AS
  (SELECT SUM(price * COUNT) AS total_sales
   FROM pharma_orders)
SELECT cg.customer_group,
       cg.cust_in_group_cnt,
       cg.cust_group_amnt,
       ts.total_sales,
       ROUND((cg.cust_group_amnt::NUMERIC / ts.total_sales::NUMERIC) * 100, 1) AS cust_group_share_perc
FROM customer_groups cg
CROSS JOIN total_sales ts;