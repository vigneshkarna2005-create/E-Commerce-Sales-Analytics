USE data_analytics_project;

-- 1. Total Sales
SELECT
    SUM(Sales) AS total_sales
FROM `cleaned dataset 2`;


-- 2. Total Profit
SELECT
    SUM(Profit) AS total_profit
FROM `cleaned dataset 2`;


-- 3. Total Orders
SELECT
    COUNT(DISTINCT Order_ID) AS total_orders
FROM `cleaned dataset 2`;


-- 4. Total Customers
SELECT
    COUNT(DISTINCT Customer_ID) AS total_customers
FROM `cleaned dataset 2`;


-- 5. Total Products
SELECT
    COUNT(DISTINCT Product_ID) AS total_products
FROM `cleaned dataset 2`;


-- 6. Total Quantity Sold
SELECT
    SUM(Quantity) AS total_quantity_sold
FROM `cleaned dataset 2`;


-- 7. Average Order Value
SELECT
    ROUND(
        SUM(Sales) / COUNT(DISTINCT Order_ID),
        2
    ) AS average_order_value
FROM `cleaned dataset 2`;


-- 8. Profit Margin
SELECT
    ROUND(
        (SUM(Profit) / SUM(Sales)) * 100,
        2
    ) AS profit_margin_percentage
FROM `cleaned dataset 2`;


-- 9. Average Sales per Customer
SELECT
    ROUND(
        SUM(Sales) / COUNT(DISTINCT Customer_ID),
        2
    ) AS average_sales_per_customer
FROM `cleaned dataset 2`;


-- 10. Average Profit per Order
SELECT
    ROUND(
        SUM(Profit) / COUNT(DISTINCT Order_ID),
        2
    ) AS average_profit_per_order
FROM `cleaned dataset 2`;


-- 11. Sales by Category
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales
FROM `cleaned dataset 2`
GROUP BY Category
ORDER BY total_sales DESC;


-- 12. Profit by Category
SELECT
    Category,
    ROUND(SUM(Profit), 2) AS total_profit
FROM `cleaned dataset 2`
GROUP BY Category
ORDER BY total_profit DESC;


-- 13. Monthly Sales
SELECT
    DATE_FORMAT(Order_Date, '%Y-%m') AS month,
    ROUND(SUM(Sales), 2) AS total_sales
FROM `cleaned dataset 2`
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY month;


-- 14. Monthly Profit
SELECT
    DATE_FORMAT(Order_Date, '%Y-%m') AS month,
    ROUND(SUM(Profit), 2) AS total_profit
FROM `cleaned dataset 2`
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY month;


-- 15. Top 10 Products by Sales
SELECT
    Product_Name,
    ROUND(SUM(Sales), 2) AS total_sales
FROM `cleaned dataset 2`
GROUP BY Product_Name
ORDER BY total_sales DESC
LIMIT 10;


-- 16. Top 10 Products by Profit
SELECT
    Product_Name,
    ROUND(SUM(Profit), 2) AS total_profit
FROM `cleaned dataset 2`
GROUP BY Product_Name
ORDER BY total_profit DESC
LIMIT 10;