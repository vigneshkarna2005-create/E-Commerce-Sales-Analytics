# E-Commerce Sales Analytics

SQL and Power BI project analyzing e-commerce sales, profitability, product performance and regional performance.



![Dashboard](E%20Commerce%20Sales%20and%20Profit%20Dashboard%20Screenshot.png)



## Business Problem
Which products, categories and regions drive sales and profit, and how much of the revenue depends on a few products?

## Dataset
- Source: [dataset name / self-created: write what is true]
- About 1.2K orders, [X] rows and [X] columns
- Cleaned version: `CLEANED DATASET 2.csv`

## Data Cleaning (MySQL)
- Removed [X] duplicate records
- Handled [null values / blank fields]
- Fixed [date formats / text inconsistencies]

## Analysis Performed
- **Data cleaning:** `E Commerce data cleaning.sql`
- **KPI analysis:** `E Commerce kpi analysis.sql`
- **Business analysis:** `E Commerce business analysis.sql`
- **Advanced SQL:** `E Commerce advanced sql.sql` (cumulative sales and cumulative percentage by product)
- **Dashboard:** `E Commerce Sales and Profit Dashboard.pbix`

## SQL Skills Used
- Aggregate functions: SUM and GROUP BY for sales by product
- Window functions: running total of sales and cumulative sales percentage
- Sorting and ranking products by sales (ORDER BY)
- Percentage calculations to find which products drive most revenue

## KPIs
- Total Sales: 28.17M
- Total Profit: 5.20M
- Profit Margin: about 18.5%
- Total Orders: about 1.2K
- Total Quantity: about 2K

## Key Insights
1. Total sales are about 28.17M with a profit of about 5.20M, a profit margin of about 18.5%.
2. Electronics is the biggest category in both sales and profit. Furniture contributes less, and Bags and Stationery contribute very little.
3. Laptop is the top product with 10,189,400 in sales, about 36.2% of total sales.
4. The top 3 products (Laptop, Smartphone, Tablet) make up about 63.2% of sales, and the top 5 make up about 79.5%, so a few products drive most revenue.
5. Notebook is the lowest-selling product, with about 79,088 in sales.

## Recommendations
- Keep strong stock and marketing for Laptop, Smartphone and Tablet, since they drive most of the revenue
- Review pricing or promotion for low-selling products and categories such as Notebook, Bags and Stationery
- Reduce dependence on a few products by growing sales in Furniture

## Power BI Dashboard
- KPI cards: Total Sales, Total Profit, Total Orders, Total Quantity
- Monthly Sales Trend, Sales by Category, Profit by Category, Sales by Region
- Slicers for Region and Category

## Screenshots
- `sql data cleaning results.png`
- `sql kpi results.png`
- `sql business analysis results.png`
- `E Commerce advanced sql results.png`

## Tools
MySQL, SQL, Power BI, CSV

## Contact
Vignesh K | vigneshkarna2005@gmail.com | [LinkedIn](https://www.linkedin.com/in/vignesh-k-a46146368)
