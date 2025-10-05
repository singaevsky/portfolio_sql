SELECT pharmacy_name,
       total_sales,
       SUM(total_sales) OVER (
                              ORDER BY total_sales DESC ROWS UNBOUNDED PRECEDING) AS cumulative_sales
FROM
  (SELECT pharmacy_name,
          SUM(price * COUNT) AS total_sales
   FROM pharma_orders
   GROUP BY pharmacy_name) AS pharmacy_totals
ORDER BY total_sales DESC;