
SELECT * FROM export_of_ores_and_minerals.export_of_ores_and_minerals;

use export_of_ores_and_minerals;

-- Q1️. Get Total Export Value for Each Mineral Over Three Years?
SELECT `Ores & Minerals`, 
       CASE 
           WHEN SUM(`Value - 2015-16` + `Value - 2016-17` + `Value - 2017-18`) >= 10000000 
           THEN CONCAT(ROUND(SUM(`Value - 2015-16` + `Value - 2016-17` + `Value - 2017-18`)/10000000, 2), ' Cr') 
           WHEN SUM(`Value - 2015-16` + `Value - 2016-17` + `Value - 2017-18`) >= 100000 
           THEN CONCAT(ROUND(SUM(`Value - 2015-16` + `Value - 2016-17` + `Value - 2017-18`)/100000, 2), ' Lakh') 
           ELSE SUM(`Value - 2015-16` + `Value - 2016-17` + `Value - 2017-18`) 
       END AS total_export_value
FROM export_of_ores_and_minerals
GROUP BY `Ores & Minerals`
ORDER BY total_export_value DESC;

-- Q2.  Calculate the Percentage Contribution of Each Mineral in 2017-18?
SELECT `Ores & Minerals`,  
       CASE 
           WHEN `Value - 2017-18` >= 10000000 
           THEN CONCAT(ROUND(`Value - 2017-18` / 10000000, 2), ' Cr') 
           WHEN `Value - 2017-18` >= 100000 
           THEN CONCAT(ROUND(`Value - 2017-18` / 100000, 2), ' Lakh') 
           ELSE `Value - 2017-18` 
       END AS export_value_2017_18,  
       ROUND((`Value - 2017-18` / (SELECT SUM(`Value - 2017-18`) FROM export_of_ores_and_minerals)) * 100, 2) AS percentage_contribution  
FROM export_of_ores_and_minerals  
ORDER BY `Value - 2017-18` DESC;

-- Q3. Identify the Mineral with the Highest Growth in Export Value (2016-17 to 2017-18)?
SELECT `Ores & Minerals`,  
       ROUND((`Value - 2017-18` - `Value - 2016-17`) / 10000000, 2) AS value_growth_cr  
FROM export_of_ores_and_minerals  
ORDER BY value_growth_cr DESC  
LIMIT 1;

-- Q4. Rank Minerals by Export Value in 2017-18.?
SELECT `Ores & Minerals`,  
       CASE  
           WHEN `Value - 2017-18` >= 10000000  
           THEN CONCAT(ROUND(`Value - 2017-18` / 10000000, 2), ' Cr')  
           WHEN `Value - 2017-18` >= 100000  
           THEN CONCAT(ROUND(`Value - 2017-18` / 100000, 2), ' Lakh')  
           ELSE `Value - 2017-18`  
       END AS formatted_value_2017_18,  
       RANK() OVER (ORDER BY `Value - 2017-18` DESC) AS rank_value  
FROM export_of_ores_and_minerals;

-- Q5. Get the Year with the Highest Export Value for Each Mineral?
SELECT `Ores & Minerals`, 
       CASE 
           WHEN `Value - 2015-16` >= GREATEST(`Value - 2015-16`, `Value - 2016-17`, `Value - 2017-18`) THEN '2015-16'
           WHEN `Value - 2016-17` >= GREATEST(`Value - 2015-16`, `Value - 2016-17`, `Value - 2017-18`) THEN '2016-17'
           ELSE '2017-18'
       END AS best_export_year
FROM export_of_ores_and_minerals;

-- Q6.  Get the Total Export Value for All Minerals Per Year?
SELECT 
    CONCAT(ROUND(SUM(`Value - 2015-16`)/10000000, 2), ' Cr') AS total_value_2015_16,
    CONCAT(ROUND(SUM(`Value - 2016-17`)/10000000, 2), ' Cr') AS total_value_2016_17,
    CONCAT(ROUND(SUM(`Value - 2017-18`)/10000000, 2), ' Cr') AS total_value_2017_18
FROM export_of_ores_and_minerals;

-- Q7. Compare Export Growth Between 2015-16 and 2017-18 for Each Mineral?
SELECT `Ores & Minerals`,  
       CASE  
           WHEN `Value - 2015-16` >= 10000000 THEN CONCAT(ROUND(`Value - 2015-16` / 10000000, 2), ' Cr')  
           WHEN `Value - 2015-16` >= 100000 THEN CONCAT(ROUND(`Value - 2015-16` / 100000, 2), ' Lakh')  
           WHEN `Value - 2015-16` >= 1000 THEN CONCAT(ROUND(`Value - 2015-16` / 1000, 2), ' K')  
           ELSE `Value - 2015-16`  
       END AS formatted_value_2015_16,  
       
       CASE  
           WHEN `Value - 2016-17` >= 10000000 THEN CONCAT(ROUND(`Value - 2016-17` / 10000000, 2), ' Cr')  
           WHEN `Value - 2016-17` >= 100000 THEN CONCAT(ROUND(`Value - 2016-17` / 100000, 2), ' Lakh')  
           WHEN `Value - 2016-17` >= 1000 THEN CONCAT(ROUND(`Value - 2016-17` / 1000, 2), ' K')  
           ELSE `Value - 2016-17`  
       END AS formatted_value_2016_17,  
       
       CASE  
           WHEN `Value - 2017-18` >= 10000000 THEN CONCAT(ROUND(`Value - 2017-18` / 10000000, 2), ' Cr')  
           WHEN `Value - 2017-18` >= 100000 THEN CONCAT(ROUND(`Value - 2017-18` / 100000, 2), ' Lakh')  
           WHEN `Value - 2017-18` >= 1000 THEN CONCAT(ROUND(`Value - 2017-18` / 1000, 2), ' K')  
           ELSE `Value - 2017-18`  
       END AS formatted_value_2017_18,  
       
       CASE  
           WHEN (`Value - 2017-18` - `Value - 2016-17`) >= 10000000 THEN CONCAT(ROUND((`Value - 2017-18` - `Value - 2016-17`) / 10000000, 2), ' Cr')  
           WHEN (`Value - 2017-18` - `Value - 2016-17`) >= 100000 THEN CONCAT(ROUND((`Value - 2017-18` - `Value - 2016-17`) / 100000, 2), ' Lakh')  
           WHEN (`Value - 2017-18` - `Value - 2016-17`) >= 1000 THEN CONCAT(ROUND((`Value - 2017-18` - `Value - 2016-17`) / 1000, 2), ' K')  
           ELSE (`Value - 2017-18` - `Value - 2016-17`)  
       END AS formatted_growth_value  
       
FROM export_of_ores_and_minerals  
ORDER BY `Value - 2017-18` DESC;











