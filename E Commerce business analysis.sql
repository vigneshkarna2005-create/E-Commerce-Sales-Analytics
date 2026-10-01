USE data_analytics_project;

-- 1. Sales by Category
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM `cleaned dataset 2`
GROUP BY Category
ORDER BY total_sales DESC;


-- 2. Profit Margin by Category
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS profit_margin_percentage
FROM `cleaned dataset 2`
GROUP BY Category
ORDER BY profit_margin_percentage DESC;


-- 3. Top 10 Products by Sales
SELECT
    Product_Name,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM `cleaned dataset 2`
GROUP BY Product_Name
ORDER BY total_sales DESC
LIMIT 10;


-- 4. Top 10 Products by Profit
SELECT
    Product_Name,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Sales), 2) AS total_sales
FROM `cleaned dataset 2`
GROUP BY Product_Name
ORDER BY total_profit DESC
LIMIT 10;


-- 5. Bottom 10 Products by Profit
SELECT
    Product_Name,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Sales), 2) AS total_sales
FROM `cleaned dataset 2`
GROUP BY Product_Name
ORDER BY total_profit ASC
LIMIT 10;


-- 6. Monthly Sales and Profit
SELECT
    DATE_FORMAT(Order_Date, '%Y-%m') AS month,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM `cleaned dataset 2`
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY month;


-- 7. Top 10 Customers by Sales
SELECT
    Customer_ID,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM `cleaned dataset 2`
GROUP BY Customer_ID
ORDER BY total_sales DESC
LIMIT 10;


-- 8. Top 10 Customers by Profit
SELECT
    Customer_ID,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Sales), 2) AS total_sales
FROM `cleaned dataset 2`
GROUP BY Customer_ID
ORDER BY total_profit DESC
LIMIT 10;


-- 9. Category-wise Quantity Sold
SELECT
    Category,
    SUM(Quantity) AS total_quantity_sold
FROM `cleaned dataset 2`
GROUP BY Category
ORDER BY total_quantity_sold DESC;


-- 10. Loss-Making Products
SELECT
    Product_Name,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM `cleaned dataset 2`
GROUP BY Product_Name
HAVING SUM(Profit) < 0
ORDER BY total_profit ASC;


-- 11. Sales and Profit by Year
SELECT
    YEAR(Order_Date) AS year,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM `cleaned dataset 2`
GROUP BY YEAR(Order_Date)
ORDER BY year;


-- 12. Average Order Value by Month
SELECT
    DATE_FORMAT(Order_Date, '%Y-%m') AS month,
    ROUND(
        SUM(Sales) / COUNT(DISTINCT Order_ID),
        2
    ) AS average_order_value
FROM `cleaned dataset 2`
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY month;