
-- Calculate the total count of properties for sale
SELECT COUNT(*) AS total_properties_for_sale
FROM RePortProject.dbo.realestatedta
WHERE status = 'for_sale';

-- Calculate the average price of properties for sale
SELECT AVG(price) AS average_price
FROM RePortProject.dbo.realestatedta
WHERE status = 'for_sale';

-- Find the maximum and minimum number of beds and baths available in properties for sale
SELECT MAX(bed) AS max_beds, MIN(bed) AS min_beds, MAX(bath) AS max_baths, MIN(bath) AS min_baths
FROM RePortProject.dbo.realestatedta
WHERE status = 'for_sale';

-- Using a subquery to filter results
SELECT *
FROM RePortProject.dbo.realestatedta
WHERE full_address IN (
    SELECT full_address
    FROM RePortProject.dbo.realestatedta
    WHERE price > 100000 AND status = 'for_sale'
);

-- Using a subquery to find properties with above-average house size
SELECT *
FROM RePortProject.dbo.realestatedta
WHERE house_size > (
    SELECT AVG(house_size)
    FROM RePortProject.dbo.realestatedta
    WHERE status = 'for_sale'
);

-- Remove properties that are too small (less than 1000 sq. ft) for sale
DELETE FROM RePortProject.dbo.realestatedta
WHERE house_size < 1000 AND status = 'for_sale';

-- Grouping data and calculating average price by city for properties for sale
SELECT city, AVG(price) AS avg_price
FROM RePortProject.dbo.realestatedta
WHERE status = 'for_sale'
GROUP BY city
ORDER BY avg_price DESC;


-- (Using CTE) Calculate the average price per city for properties that are for sale
-- and then filter out the cities where the average price is above the overall average price for properties for sale.
WITH AvgPrice_CTE AS (
  SELECT city, AVG(price) AS avg_price
  FROM RePortProject.dbo.realestatedta
  WHERE status = 'for_sale'
  GROUP BY city
)
SELECT city, avg_price
FROM AvgPrice_CTE
WHERE avg_price > (
  SELECT AVG(price)
  FROM RePortProject.dbo.realestatedta
  WHERE status = 'for_sale'
);


-- (Using Subquery) Calculate the average price per city for properties that are for sale
-- and then filter out the cities where the average price is above the overall average price for properties for sale.
SELECT city, avg_price
FROM (
  SELECT city, AVG(price) AS avg_price
  FROM RePortProject.dbo.realestatedta
  WHERE status = 'for_sale'
  GROUP BY city
) AS AvgPriceSubquery
WHERE avg_price > (
  SELECT AVG(price)
  FROM RePortProject.dbo.realestatedta
  WHERE status = 'for_sale'
);


