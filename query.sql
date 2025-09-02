-- This SQL query addresses the requirement to use GROUPING SETS
-- to perform aggregations across multiple levels.
--
-- The query calculates the sum of sales (`total_sales`) for different
-- grouping levels based on `country` and `category`.
--
-- The GROUPING SETS specified are:
--   1. (country, category): Calculates total sales for each combination of country and category.
--   2. (country): Calculates total sales for each country (subtotal).
--   3. (category): Calculates total sales for each category (subtotal).
--   4. (): Calculates the grand total sales across all data.
--
-- NULL values in the 'country' or 'category' columns in the output indicate
-- that the 'total_sales' on that row is an aggregation across that dimension.
-- For example, a row with a country and a NULL category represents the subtotal for that country.

SELECT
    country,
    category,
    SUM(total_sales) AS total_sales
FROM
    sales_data
GROUP BY
    GROUPING SETS ((country, category), (country), (category), ());
