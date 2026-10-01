USE data_analytics_project;


-- =====================================================
-- 1. PRODUCT RANKING BY SALES
-- =====================================================

SELECT
    Product_Name,
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS sales_rank
FROM `cleaned dataset 2`
GROUP BY Product_Name, Category
ORDER BY sales_rank;


-- =====================================================
-- 2. PRODUCT RANKING WITHIN EACH CATEGORY
-- =====================================================

SELECT
    Category,
    Product_Name,
    ROUND(SUM(Sales), 2) AS total_sales,
    RANK() OVER (
        PARTITION BY Category
        ORDER BY SUM(Sales) DESC
    ) AS category_rank
FROM `cleaned dataset 2`
GROUP BY Category, Product_Name
ORDER BY Category, category_rank;


-- =====================================================
-- 3. TOP 3 PRODUCTS IN EACH CATEGORY
-- =====================================================

WITH product_ranking AS (
    SELECT
        Category,
        Product_Name,
        ROUND(SUM(Sales), 2) AS total_sales,
        RANK() OVER (
            PARTITION BY Category
            ORDER BY SUM(Sales) DESC
        ) AS product_rank
    FROM `cleaned dataset 2`
    GROUP BY Category, Product_Name
)
SELECT
    Category,
    Product_Name,
    total_sales,
    product_rank
FROM product_ranking
WHERE product_rank <= 3
ORDER BY Category, product_rank;


-- =====================================================
-- 4. RUNNING TOTAL OF MONTHLY SALES
-- =====================================================

WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS month,
        ROUND(SUM(Sales), 2) AS total_sales
    FROM `cleaned dataset 2`
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
)
SELECT
    month,
    total_sales,
    ROUND(
        SUM(total_sales) OVER (ORDER BY month),
        2
    ) AS cumulative_sales
FROM monthly_sales
ORDER BY month;


-- =====================================================
-- 5. RUNNING TOTAL OF MONTHLY PROFIT
-- =====================================================

WITH monthly_profit AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS month,
        ROUND(SUM(Profit), 2) AS total_profit
    FROM `cleaned dataset 2`
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
)
SELECT
    month,
    total_profit,
    ROUND(
        SUM(total_profit) OVER (ORDER BY month),
        2
    ) AS cumulative_profit
FROM monthly_profit
ORDER BY month;


-- =====================================================
-- 6. MONTH-OVER-MONTH SALES GROWTH
-- =====================================================

WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS month,
        SUM(Sales) AS total_sales
    FROM `cleaned dataset 2`
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
),
previous_month AS (
    SELECT
        month,
        total_sales,
        LAG(total_sales) OVER (ORDER BY month) AS previous_sales
    FROM monthly_sales
)
SELECT
    month,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(previous_sales, 2) AS previous_month_sales,
    ROUND(
        ((total_sales - previous_sales) / previous_sales) * 100,
        2
    ) AS sales_growth_percentage
FROM previous_month
ORDER BY month;


-- =====================================================
-- 7. MONTH-OVER-MONTH PROFIT GROWTH
-- =====================================================

WITH monthly_profit AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS month,
        SUM(Profit) AS total_profit
    FROM `cleaned dataset 2`
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
),
previous_month AS (
    SELECT
        month,
        total_profit,
        LAG(total_profit) OVER (ORDER BY month) AS previous_profit
    FROM monthly_profit
)
SELECT
    month,
    ROUND(total_profit, 2) AS total_profit,
    ROUND(previous_profit, 2) AS previous_month_profit,
    ROUND(
        ((total_profit - previous_profit) / previous_profit) * 100,
        2
    ) AS profit_growth_percentage
FROM previous_month
ORDER BY month;


-- =====================================================
-- 8. CATEGORY PROFIT CONTRIBUTION
-- =====================================================

SELECT
    Category,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        (SUM(Profit) / (SELECT SUM(Profit)
                        FROM `cleaned dataset 2`)) * 100,
        2
    ) AS profit_contribution_percentage
FROM `cleaned dataset 2`
GROUP BY Category
ORDER BY profit_contribution_percentage DESC;


-- =====================================================
-- 9. PRODUCT PROFIT CONTRIBUTION
-- =====================================================

SELECT
    Product_Name,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        (SUM(Profit) / (SELECT SUM(Profit)
                        FROM `cleaned dataset 2`)) * 100,
        2
    ) AS profit_contribution_percentage
FROM `cleaned dataset 2`
GROUP BY Product_Name
ORDER BY total_profit DESC;


-- =====================================================
-- 10. CUSTOMER VALUE SEGMENTATION
-- =====================================================

WITH customer_sales AS (
    SELECT
        Customer_ID,
        SUM(Sales) AS total_sales
    FROM `cleaned dataset 2`
    GROUP BY Customer_ID
)
SELECT
    Customer_ID,
    ROUND(total_sales, 2) AS total_sales,
    CASE
        WHEN total_sales >= 10000 THEN 'High Value'
        WHEN total_sales >= 5000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM customer_sales
ORDER BY total_sales DESC;


-- =====================================================
-- 11. REPEAT CUSTOMERS
-- =====================================================

SELECT
    Customer_ID,
    COUNT(DISTINCT Order_ID) AS number_of_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM `cleaned dataset 2`
GROUP BY Customer_ID
HAVING COUNT(DISTINCT Order_ID) > 1
ORDER BY number_of_orders DESC;


-- =====================================================
-- 12. CUSTOMER RANKING BY SALES
-- =====================================================

SELECT
    Customer_ID,
    ROUND(SUM(Sales), 2) AS total_sales,
    RANK() OVER (
        ORDER BY SUM(Sales) DESC
    ) AS customer_rank
FROM `cleaned dataset 2`
GROUP BY Customer_ID
ORDER BY customer_rank;


-- =====================================================
-- 13. CATEGORY PERFORMANCE
-- =====================================================

SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        (SUM(Profit) / SUM(Sales)) * 100,
        2
    ) AS profit_margin,
    SUM(Quantity) AS quantity_sold,
    RANK() OVER (
        ORDER BY SUM(Profit) DESC
    ) AS profit_rank
FROM `cleaned dataset 2`
GROUP BY Category
ORDER BY profit_rank;


-- =====================================================
-- 14. LOSS-MAKING PRODUCTS WITH RANK
-- =====================================================

SELECT
    Product_Name,
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    RANK() OVER (
        ORDER BY SUM(Profit) ASC
    ) AS loss_rank
FROM `cleaned dataset 2`
GROUP BY Product_Name, Category
HAVING SUM(Profit) < 0
ORDER BY loss_rank;


-- =====================================================
-- 15. AVERAGE ORDER VALUE BY CUSTOMER
-- =====================================================

SELECT
    Customer_ID,
    COUNT(DISTINCT Order_ID) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(
        SUM(Sales) / COUNT(DISTINCT Order_ID),
        2
    ) AS average_order_value
FROM `cleaned dataset 2`
GROUP BY Customer_ID
ORDER BY average_order_value DESC;


-- =====================================================
-- 16. SALES PERCENTAGE BY CATEGORY
-- =====================================================

SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(
        (SUM(Sales) /
        (SELECT SUM(Sales)
         FROM `cleaned dataset 2`)) * 100,
        2
    ) AS sales_contribution_percentage
FROM `cleaned dataset 2`
GROUP BY Category
ORDER BY sales_contribution_percentage DESC;


-- =====================================================
-- 17. PARETO ANALYSIS - CUMULATIVE SALES
-- =====================================================

WITH product_sales AS (
    SELECT
        Product_Name,
        SUM(Sales) AS total_sales
    FROM `cleaned dataset 2`
    GROUP BY Product_Name
)
SELECT
    Product_Name,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(
        SUM(total_sales) OVER (
            ORDER BY total_sales DESC
        ),
        2
    ) AS cumulative_sales,
    ROUND(
        SUM(total_sales) OVER (
            ORDER BY total_sales DESC
        )
        /
        SUM(total_sales) OVER () * 100,
        2
    ) AS cumulative_sales_percentage
FROM product_sales
ORDER BY total_sales DESC;


-- =====================================================
-- 18. BEST MONTH BY SALES
-- =====================================================

WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS month,
        SUM(Sales) AS total_sales
    FROM `cleaned dataset 2`
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
),
ranked_months AS (
    SELECT
        month,
        total_sales,
        RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
    FROM monthly_sales
)
SELECT
    month,
    ROUND(total_sales, 2) AS total_sales
FROM ranked_months
WHERE sales_rank = 1;


-- =====================================================
-- 19. BEST MONTH BY PROFIT
-- =====================================================

WITH monthly_profit AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS month,
        SUM(Profit) AS total_profit
    FROM `cleaned dataset 2`
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
),
ranked_months AS (
    SELECT
        month,
        total_profit,
        RANK() OVER (ORDER BY total_profit DESC) AS profit_rank
    FROM monthly_profit
)
SELECT
    month,
    ROUND(total_profit, 2) AS total_profit
FROM ranked_months
WHERE profit_rank = 1;


-- =====================================================
-- 20. ADVANCED PRODUCT PERFORMANCE
-- =====================================================

SELECT
    Product_Name,
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    SUM(Quantity) AS quantity_sold,
    ROUND(
        (SUM(Profit) / SUM(Sales)) * 100,
        2
    ) AS profit_margin,
    RANK() OVER (
        PARTITION BY Category
        ORDER BY SUM(Profit) DESC
    ) AS category_profit_rank
FROM `cleaned dataset 2`
GROUP BY Product_Name, Category
ORDER BY Category, category_profit_rank;