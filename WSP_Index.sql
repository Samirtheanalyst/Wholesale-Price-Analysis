
use wholesale_price_analysis;

-- Q1. Retrieve the top 5 crops with the highest wholesale_price_Index in December 2024?
SELECT Commodity, `Dec-24`
FROM wholesale_price
ORDER BY `Dec-24` DESC
LIMIT 5;

-- Q2. Find the average wholesale_price_Index for each crop in the last 5 years (from Dec-20 to Dec-24)?
SELECT Commodity, 
       ROUND(( `Dec-20` + `Dec-21` + `Dec-22` + `Dec-23` + `Dec-24` ) / 5, 2) AS avg_wpi_last_5_years
FROM wholesale_price;

-- Q3. Find the crop with the highest percentage increase in wholesale_price_Index from Dec-20 to Dec-24?
SELECT Commodity, 
       ROUND(((`Dec-24` - `Dec-20`) / `Dec-20`) * 100, 2) AS percentage_increase
FROM wholesale_price
ORDER BY percentage_increase DESC
LIMIT 1;

-- Q4. Calculate the yearly average wholesale_price_Index across all crops for December from 2013 to 2024?
SELECT 'Dec-13' AS Year, ROUND(AVG(`Dec-13`), 2) AS Avg_WPI FROM wholesale_price
UNION ALL
SELECT 'Dec-14', ROUND(AVG(`Dec-14`), 2) FROM wholesale_price
UNION ALL
SELECT 'Dec-15', ROUND(AVG(`Dec-15`), 2) FROM wholesale_price
UNION ALL
SELECT 'Dec-16', ROUND(AVG(`Dec-16`), 2) FROM wholesale_price
UNION ALL
SELECT 'Dec-17', ROUND(AVG(`Dec-17`), 2) FROM wholesale_price
UNION ALL
SELECT 'Dec-18', ROUND(AVG(`Dec-18`), 2) FROM wholesale_price
UNION ALL
SELECT 'Dec-19', ROUND(AVG(`Dec-19`), 2) FROM wholesale_price
UNION ALL
SELECT 'Dec-20', ROUND(AVG(`Dec-20`), 2) FROM wholesale_price
UNION ALL
SELECT 'Dec-21', ROUND(AVG(`Dec-21`), 2) FROM wholesale_price
UNION ALL
SELECT 'Dec-22', ROUND(AVG(`Dec-22`), 2) FROM wholesale_price
UNION ALL
SELECT 'Dec-23', ROUND(AVG(`Dec-23`), 2) FROM wholesale_price
UNION ALL
SELECT 'Dec-24', ROUND(AVG(`Dec-24`), 2) FROM wholesale_price;

-- Q5. Find crops whose wholesale_price_Index remained stable (less than 5% change) between Dec-23 and Dec-24?
SELECT Commodity, `Dec-23`, `Dec-24`,
       ROUND(ABS((`Dec-24` - `Dec-23`) / `Dec-23`) * 100, 2) AS percentage_change
FROM wholesale_price
WHERE ROUND(ABS((`Dec-24` - `Dec-23`) / `Dec-23`) * 100, 2) <= 5;

-- Q6.5. Rank crops based on their wholesale_price_Index value in Dec-24.?
SELECT Commodity, `Dec-24`,
       RANK() OVER (ORDER BY `Dec-24` DESC) AS rank_position
FROM wholesale_price;

-- Q7. Find the crops with a wholesale_price_Index drop in Dec-24 compared to Dec-23.?
SELECT Commodity, `Dec-23`, `Dec-24`
FROM wholesale_price
WHERE `Dec-24` < `Dec-23`;

-- Q8. Retrieve the wholesale_price_Index trend for a specific crop (e.g., "Bajra") over the years.?
SELECT Commodity, `Dec-13`, `Dec-14`, `Dec-15`, `Dec-16`, `Dec-17`, 
             `Dec-18`, `Dec-19`, `Dec-20`, `Dec-21`, `Dec-22`, `Dec-23`, `Dec-24`
FROM wholesale_price
WHERE Commodity = 'Bajra';

-- Q9.Identify crops whose wholesale_price_Index has increased continuously from Dec-20 to Dec-24.?
SELECT Commodity 
FROM wholesale_price
WHERE `Dec-20` < `Dec-21` 
  AND `Dec-21` < `Dec-22` 
  AND `Dec-22` < `Dec-23` 
  AND `Dec-23` < `Dec-24`;















