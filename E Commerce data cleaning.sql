USE data_analytics_project;

-- 1. Check total number of rows
SELECT COUNT(*) AS total_rows
FROM `cleaned dataset 2`;


-- 2. View sample data
SELECT *
FROM `cleaned dataset 2`
LIMIT 10;


-- 3. Check column names and data types
DESCRIBE `cleaned dataset 2`;


-- 4. Check duplicate Order IDs
SELECT
    Order_ID,
    COUNT(*) AS duplicate_count
FROM `cleaned dataset 2`
GROUP BY Order_ID
HAVING COUNT(*) > 1;


-- 5. Check missing Order IDs
SELECT COUNT(*) AS missing_order_id
FROM `cleaned dataset 2`
WHERE Order_ID IS NULL;


-- 6. Check missing Customer IDs
SELECT COUNT(*) AS missing_customer_id
FROM `cleaned dataset 2`
WHERE Customer_ID IS NULL;


-- 7. Check missing Product IDs
SELECT COUNT(*) AS missing_product_id
FROM `cleaned dataset 2`
WHERE Product_ID IS NULL;


-- 8. Check missing Product Names
SELECT COUNT(*) AS missing_product_name
FROM `cleaned dataset 2`
WHERE Product_Name IS NULL;


-- 9. Check missing Categories
SELECT COUNT(*) AS missing_category
FROM `cleaned dataset 2`
WHERE Category IS NULL;


-- 10. Check missing Quantity
SELECT COUNT(*) AS missing_quantity
FROM `cleaned dataset 2`
WHERE Quantity IS NULL;


-- 11. Check missing Sales
SELECT COUNT(*) AS missing_sales
FROM `cleaned dataset 2`
WHERE Sales IS NULL;


-- 12. Check missing Profit
SELECT COUNT(*) AS missing_profit
FROM `cleaned dataset 2`
WHERE Profit IS NULL;


-- 13