-- How many stockout records occurred when actual lead time exceeded planned lead time?

SELECT COUNT(*) AS Total_Stockout_Records,
    SUM(CASE WHEN [Lead_time_actual_days]  > [Lead_time_planned_days] THEN 1 ELSE 0 END)
    AS Stockouts_With_Late_Lead_Time,
    CAST(100.0 * SUM(CASE
            WHEN [Lead_time_actual_days] > [Lead_time_planned_days] 
            THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0) AS DECIMAL(5,2)
    ) AS Percent_Of_Stockouts_With_Late_Lead_Time
FROM items_and_stock4
WHERE stockout_flag = 1;



-- top 20 items to stop reordering

SELECT Item_code, Description, Category,
       ROUND(SUM(Stock_value),0) AS stock_value,
       MAX(Days_since_last_sale_month_end) AS max_days_idle
FROM inventory7
WHERE Sales_status = 'Dead'
GROUP BY Item_code, Description, Category
ORDER BY stock_value DESC 


-- Items with frequent stockouts and highest lost_sales_value

SELECT Item_code, Description, Category, Supplier,
       COUNT(*) AS stockout_months,
       ROUND(SUM(Estimated_Lost_Sales_Value),0) AS lost_sales_value
FROM inventory7
WHERE Stockout_flag = 1
GROUP BY Item_code, Description, Category, Supplier
HAVING COUNT(*) >= 2
ORDER BY lost_sales_value DESC


-- Are stockouts more concentrated among products with low inventory cover?

SELECT CASE
        WHEN [Weeks_of_cover]  < 1 THEN 'Less than 1 week'
        WHEN [Weeks_of_cover] < 2 THEN '1 to 2 weeks'
        WHEN [Weeks_of_cover] < 4 THEN '2 to 4 weeks'
        ELSE '4+ weeks'
    END AS Stock_Cover_Group,
    COUNT(*) AS Total_Records,
    SUM(CAST(stockout_flag AS INT)) AS Stockout_Records,
    CAST(100.0 * SUM(CAST(stockout_flag AS INT))/ NULLIF(COUNT(*), 0) AS DECIMAL(5,2)) AS Stockout_Rate_Percent
FROM items_and_stock4
GROUP BY
    CASE WHEN [Weeks_of_cover] < 1 THEN 'Less than 1 week'
        WHEN [Weeks_of_cover] < 2 THEN '1 to 2 weeks'
        WHEN [Weeks_of_cover] < 4 THEN '2 to 4 weeks'
        ELSE '4+ weeks' END
ORDER BY Stockout_Rate_Percent DESC;




-- Which suppliers have the highest stockout rates among the products they supply?
SELECT
    Supplier,
    COUNT(*) AS Total_Records,
    SUM(CAST(stockout_flag AS INT)) AS Stockout_Records,
    CAST(
        100.0 * SUM(CAST(stockout_flag AS INT))
        / NULLIF(COUNT(*), 0)
        AS DECIMAL(5,2)
    ) AS Stockout_Rate_Percent,
    SUM([Estimated_Lost_Sales_Value]) AS Estimated_Lost_Sales
FROM items_and_stock4
GROUP BY Supplier
ORDER BY Stockout_Rate_Percent DESC;



-- Are stockouts more frequent in particular warehouses?
SELECT
    Warehouse,
    COUNT(*) AS Total_Records,
    SUM(CAST(stockout_flag AS INT)) AS Stockout_Records,
    CAST(
        100.0 * SUM(CAST(stockout_flag AS INT))
        / NULLIF(COUNT(*), 0)
        AS DECIMAL(5,2)
    ) AS Stockout_Rate_Percent,
    SUM([Estimated_Lost_Sales_Value]) AS Estimated_Lost_Sales
FROM items_and_stock4
GROUP BY Warehouse
ORDER BY Stockout_Rate_Percent DESC;



--create_view
CREATE VIEW stockout_features AS
WITH base AS (
  SELECT *,
    LAG(Weeks_of_cover)      OVER w AS prev_cover,
    LAG(Late_delivery_flag)  OVER w AS prev_late,
    LAG(Qty_received)        OVER w AS prev_recv,
    AVG(Units_sold) OVER (PARTITION BY Item_code ORDER BY Period ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING) AS avg_sales_prev3
  FROM inventory7
  WINDOW w AS (PARTITION BY Item_code ORDER BY Period))

SELECT *,
  CASE WHEN Qty_on_hand > 0 AND Qty_available <= 0 THEN 1 ELSE 0 END AS f_allocation,
  CASE WHEN Late_delivery_flag = 1 OR prev_late = 1 THEN 1 ELSE 0 END AS f_late,
  CASE WHEN prev_cover < Lead_time_actual_days / 7.0 THEN 1 ELSE 0 END AS f_thin_cover,
  CASE WHEN avg_sales_prev3 > 0 AND Units_sold > 1.5 * avg_sales_prev3 THEN 1 ELSE 0 END AS f_demand_spike,
  CASE WHEN prev_recv < avg_sales_prev3 THEN 1 ELSE 0 END AS f_underreplen,
  CASE WHEN Lead_time_actual_days > Lead_time_planned_days THEN 1 ELSE 0 END AS f_lt_slip
FROM base;


SELECT Category, factor,
  SUM(CASE WHEN flag = 1 THEN Stockout_flag ELSE 0 END) AS stockouts_with_factor,
  SUM(flag) AS rows_with_factor,
  ROUND(100.0 * AVG(CASE WHEN flag = 1 THEN 1.0 * Stockout_flag END), 2) AS rate_present,
  ROUND(100.0 * AVG(CASE WHEN flag = 0 THEN 1.0 * Stockout_flag END), 2) AS rate_absent,
  ROUND(AVG(CASE WHEN flag = 1 THEN 1.0 * Stockout_flag END)
      / NULLIF(AVG(CASE WHEN flag = 0 THEN 1.0 * Stockout_flag END), 0), 2) AS lift
FROM (
  SELECT Category, 'Late delivery' AS factor, f_late AS flag, Stockout_flag
    FROM stockout_features WHERE prev_cover IS NOT NULL
  UNION ALL SELECT Category, 'Cover < lead time', f_thin_cover, Stockout_flag
    FROM stockout_features WHERE prev_cover IS NOT NULL
  UNION ALL SELECT Category, 'Demand spike', f_demand_spike, Stockout_flag
    FROM stockout_features WHERE avg_sales_prev3 IS NOT NULL
  UNION ALL SELECT Category, 'Under-replenishment', f_underreplen, Stockout_flag
    FROM stockout_features WHERE avg_sales_prev3 IS NOT NULL
  UNION ALL SELECT Category, 'Lead time slipped', f_lt_slip, Stockout_flag
    FROM stockout_features
) t
GROUP BY Category, factor
ORDER BY Category, lift DESC;





-- which factor actually separates stockouts from non-stockouts (lift)

WITH s AS (
  SELECT *,
    CASE
      WHEN f_allocation = 1   THEN '1. Stock allocated to orders'
      WHEN f_late = 1         THEN '2. Late supplier delivery'
      WHEN f_thin_cover = 1   THEN '3. Cover below lead time (reorder point too low)'
      WHEN f_demand_spike = 1 THEN '4. Demand spike'
      WHEN f_underreplen = 1  THEN '5. Under-replenishment'
      ELSE '6. Unexplained / data gap'
    END AS primary_cause
  FROM stockout_features
  WHERE Stockout_flag = 1
)
SELECT primary_cause,
       COUNT(*) AS stockouts,
       ROUND(100.0*COUNT(*)/SUM(COUNT(*)) OVER (),1) AS pct_of_stockouts,
       ROUND(SUM(Estimated_Lost_Sales_Value),0) AS lost_sales_value,
       ROUND(100.0*SUM(Estimated_Lost_Sales_Value)/SUM(SUM(Estimated_Lost_Sales_Value)) OVER (),1) AS pct_of_lost_value
FROM s
GROUP BY primary_cause
ORDER BY lost_sales_value DESC;


