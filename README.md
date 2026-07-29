# Sales Data Analysis (Adventure Work Lite Sales)
> *SQL- based analysis of retail sales transctions to answer business questions on order value, product line revenue, and customer performance using MySQL.*

---

## ⚙️ Project Type Flags

- [ ] Exploratory Data Analysis (EDA)
- [x] SQL Analysis / Querying
- [ ] Dashboard / Data Visualization
- [ ] Data Pipeline / ETL
- [ ] Predictive Modelling / Machine Learning
- [x] Data Cleaning / Wrangling
- [ ] End-to-End (multiple of the above)
- [ ] Other: ___________

---

## Table of Contents
1. [Project Overview](#1-project-overview)
2. [Key Questions Answered](#2-Key-Questions-Answered)
3. [Objectives](#3-objectives)
4. [Project Scope & Tools](#4-project-scope--tools)
5. [Repository Structure](#5-repository-structure)
6. [Data Workflow](#6-data-workflow)
7. [Data Model & Schema](#7-data-model--schema)
8. [SQL Analysis & Queries](#8-SQL-Analysis-&-Queries)
9. [Key Insights](#9-key-insights)
10. [Recommendations](#10-recommendations)
11. [Deliverables](#11-deliverables)
12. [Author](#12-author)
    
---

## 1. Project Overview

**Context:** The sales_data dataset (Adventure Works Lite Sales) contains transactional order records that needed structured analysis to answer core business questions about revenue, product performance, and customer behavior.

**Problem Statement:**  The dataset had order records stored with an inconsistently formatted date field and no structured analysis to answer key business questions - such as which product lines drive the most revenue, which customers generate the most revenue, and how sales trend over time.

**Approach:** Used SQL in MySQL Workbench to query the sales database, writing structured queries using aggregate functions (SUM, AVG, COUNT), GROUP BY/HAVING, window functions (RANK, ROW_NUMBER, PARTITION BY), and date functions (STR_TO_DATE, YEAR, MONTH) to answer eight key business questions about the sales data.

**Outcome:** Successfully extracted business insights, revealing that Euro Shopping Channel is the top revenue-generating customer (912,294.11 across 259 orders), the USA leads all countries in total revenue (3,627,982.83 across 1,004 orders), the highest single order was 14,082.80 (Vintage Cars, The Sharp Gifts Warehouse), and revenue climbed steadily from 129,753.60 in January 2003 to 201,609.55 by April.

---

## 2.

**Key Questions Answered**

- What are the 10 highest-value single orders, and what product line were they from?
- Which product lines generate the most total revenue?
- What is the average order value and total revenue by country?
- Which customers are the highest revenue generators?
- How do all orders rank from highest to lowest sales value?
- Who is the top customer in each country?
- What is the revenue trend over time (by year and month)?
- What does customer purchasing behaviour look like (orders and spend per customer)?

---

## 3. Objectives
Primary Objective: Write and execute SQL queries in MySQL Workbench to analyze the sales_data dataset and extract actionable business insights.
Secondary Objective 1: Identify top orders, top-performing product lines, and country-level revenue and order value.
Secondary Objective 2: Rank customers by revenue overall and within each country using window functions.
Secondary Objective 3: Analyze revenue trends over time using cleaned date data.
Secondary Objective 4: Demonstrate practical SQL skills including aggregate functions, window functions, date functions, filtering, grouping, and sorting.

---

## 4. Porject Scope & Tools 

###    Scope 

| Dimension | Details |
|-----------|---------|
| **In Scope** | Order-level transaction records including order date, customer name, product line, country, and sales value|
| **Out of Scope** |Customer demographic data, shipping/logistics data, and product cost data - these were not available in the dataset |
| **Time Period** | Order records spanning the full date range present in sales_data |
| **Granularity** | Row-level order data (one row per order) |

### Tools & Technologies

| Category | Tool(s) Used |
|----------|-------------|
| Database Management | MySQL |
| Query Writing & Execution| MySQL Workbench |
| Data Querying | SQL (SELECT, WHERE, GROUP BY, HAVING, ORDER BY) |
| Aggregate Functions | COUNT, SUM, AVG, ROUND |
| Window Functions | RANK(), ROW_NUMBER(), PARTITION BY
| Date Functions | STR_TO_DATE, YEAR, MONTH|
| Data Manipulation | UPDATE (with safe update mode)|
| Documentation | Microsoft Word, GitHub |

---

## 5. Repository Structure

```
Sales-Data-SQL-Analysis/
│
├── data/
│   └── raw/                 # Original, unmodified sales dataset
│
├── docs/                     # Data dictionary and project notes
│
├── queries/
│   ├── exploratory/          # Initial investigative queries
│   └── final/                # Final production-ready queries
│
├── reports/                  # Written summary report
│
├── visuals/                  # Screenshots of query results
│
├── README.md                 # You are here
└── project_metadata.yml      # Project metadata
```

---

## 6. Data Workflow

1. **Source:** One sales table (sales_data) containing order-level transaction records including order number, customer name, product line, sales value, and order date.
2. **Ingestion:**  Dataset loaded into MySQL Workbench as a structured database table (sales_data) within a dedicated sales database.
3. **Cleaning:**  Identified that the ORDERDATE field was stored as text in an inconsistent format; converted it into a proper date column (OrderDateFixed) using STR_TO_DATE, then validated that every row parsed correctly.
4. **Analysis:** Wrote and executed 8 SQL queries covering aggregate analysis, ranking, filtering, grouping, sorting, and date-based trend analysis to answer key business questions.
5.  **Output:**  Query results documented in README, SQL script saved as a .sql file, selected screenshots of query outputs saved in the visuals/ folder, and a written summary report saved in the reports/ folder.
   
---


## 7. Data Model & Schema

The dataset contains order-level records from sales_data (Adventure Works Lite Sales).

### Dataset Dictionary

| Field Name | Data Type | Description | Example Value |
|------------|-----------|-------------|---------------|
| `ORDERNUMBER` |Integer | Unique identifier for each order |10107 |
| `CUSTOMERNAME` | Text | Name of the customer who placed the order | The Sharp Gifts Warehouse. |
| `PRODUCTLINE` | Text | Product line/category of the order | Vintage Cars |
| `COUNTRY` | Text | Country the order was shipped to | USA |
| `SALES` | Float | Sale amount for the order | 14082.80 |
| `ORDERDATE` |Text |Original order date (inconsistent format, as stored)| 2/24/2003 0:00 |
| `OrderDateFixed` | Date| Cleaned order date (converted via STR_TO_DATE) | 2003-02-24 |

Key table: sales_data
Date format: Original text stored inconsistently - converted using STR_TO_DATE in queries

---

## 8.SQL ANALYSIS & Queries

**Q1: What are the 10 highest-value single orders, and what product line were they from?*
```sql
SELECT
    ORDERNUMBER,
    CUSTOMERNAME,
    PRODUCTLINE,
    SALES,
    OrderDateFixed
FROM sales_data
WHERE Sales > 5000
ORDER BY SALES DESC
LIMIT 10;
-- Result: Top orders led by Order #10407 (The Sharp Gifts Warehouse, Vintage Cars, 14,082.80),
-- #10322 (Online Diecast Creations Co., Vintage Cars, 12,536.50),
-- #10424 (Euro Shopping Channel, Classic Cars, 12,001.00),
-- #10412 (Euro Shopping Channel, Classic Cars, 11,887.80),
-- #10403 (UK Collectables Ltd., Motorcycles, 11,886.60), and #10405 (Mini Caravy, Classic Cars, 11,739.70)
```

**Q2: Which product lines generate the most total revenue?*
```sql
SELECT
    PRODUCTLINE,
    COUNT(*) AS TotalOrders,
    SUM(SALES) AS TotalRevenue
FROM sales_data
GROUP BY PRODUCTLINE
HAVING SUM(SALES) > 10000
ORDER BY TotalRevenue DESC;
-- Result: [insert top revenue-generating product line once available]
---

**Q3: What is the average order value and total revenue by country?
 ```sql
 SELECT
    COUNTRY,
    COUNT(*) AS TotalOrders,
    ROUND(AVG(SALES),2) AS AvgOrderValue,
    ROUND(SUM(SALES), 2) AS TotalRevenue
FROM sales_data
GROUP BY COUNTRY
ORDER BY TotalRevenue DESC;
-- Result: USA leads with 1,004 orders, avg order value 3,613.53, total revenue 3,627,982.83;
-- followed by Spain (342 orders, 1,215,686.92), France (314 orders, 1,110,916.52),
-- Australia (185 orders, 630,623.10), UK (144 orders, 478,880.46), Italy (113 orders, 374,674.31)
```
---

**Q4: Which customers are the highest revenue generators?
 ```sql
SELECT
    CUSTOMERNAME,
    SUM(SALES) AS TotalRevenue,
    RANK() OVER (ORDER BY SUM(SALES) DESC) AS CustomerRank
FROM sales_data
GROUP BY CUSTOMERNAME;
-- Result: Euro Shopping Channel (912,294.11, rank 1), Mini Gifts Distributors Ltd. (654,858.06, rank 2),
-- Australian Collectors, Co. (200,995.41, rank 3), Muscle Machine Inc (197,736.94, rank 4),
-- La Rochelle Gifts (180,124.90, rank 5), Dragon Souveniers, Ltd. (172,989.68, rank 6)
```
---

**Q5: How do all orders rank from highest to lowest sales value?
 ```sql
SELECT
    ORDERNUMBER,
    CUSTOMERNAME,
    PRODUCTLINE,
    SALES,
    ROW_NUMBER() OVER (ORDER BY SALES DESC) AS SalesRank
FROM sales_data;
-- Result: Every order individually ranked; #10407 (14,082.80) ranks 1st, #10322 (12,536.50) ranks 2nd,
-- down through #10405 (11,739.70) at rank 6
```
---

**Q6: Who is the top customer in each country?*
```sql
SELECT
    COUNTRY,
    CUSTOMERNAME,
    SUM(SALES) AS TotalRevenue,
    RANK() OVER(
        PARTITION BY COUNTRY
        ORDER BY SUM(SALES) DESC
    ) AS CountryRank
FROM sales_data
GROUP BY COUNTRY, CUSTOMERNAME;
-- Result: In Australia, Australian Collectors, Co. ranks 1st (200,995.41), ahead of Anna's Decorations, Ltd
-- (153,996.13) and Souveniers And Things Co. (151,570.98). In Austria, Salzburg Collectables ranks 1st (149,798.63)
```
---

 **Q7: What is the revenue trend over time (by year and month)?
 ```sql
SELECT
    YEAR(OrderDateFixed) AS Year,
    MONTH(OrderDateFixed) AS Month,
    ROUND(SUM(SALES),2) AS Revenue
FROM sales_data
GROUP BY YEAR(OrderDateFixed), MONTH(OrderDateFixed)
ORDER BY Year, Month;
-- Result: 2003 opened at 129,753.60 in January, rising to 140,836.19 (Feb), 174,504.90 (Mar),
-- peaking at 201,609.55 in April, then 192,673.11 (May) and 168,082.56 (June)
```
---

Q8: What does customer purchasing behaviour look like (orders and spend per customer)?
```sql
SELECT
    CUSTOMERNAME,
    COUNT(*) AS TotalOrders,
    ROUND(SUM(SALES),2) AS TotalSpent
FROM sales_data
GROUP BY CUSTOMERNAME
ORDER BY TotalSpent DESC
LIMIT 10;
-- Result: Euro Shopping Channel leads with 259 orders totaling 912,294.11, followed by Mini Gifts Distributors Ltd.
-- (180 orders, 654,858.06), Australian Collectors, Co. (55 orders, 200,995.41), Muscle Machine Inc (48 orders, 197,736.94),
-- La Rochelle Gifts (53 orders, 180,124.90), and Dragon Souveniers, Ltd. (43 orders, 172,989.68)
```
---

## 9. Key Insights

9. Key Insights
(To be completed once query result screenshots are available — each insight should follow the Gilead format: bolded headline finding — what it suggests for the business.)
[Top order/product line finding] — [what it suggests]
[Top revenue product line finding] — [what it suggests]
[Top country by revenue finding] — [what it suggests]
[Top customer finding] — [what it suggests]
[Revenue trend finding] — [what it suggests]
[Customer purchasing behaviour finding] — [what it suggests]

**Insight 1: [Short descriptive headline]**
[What you found + what it suggests. One short paragraph.]

**Insight 2: [Short descriptive headline]**
[What you found + what it suggests.]

**Insight 3: [Short descriptive headline]**
[What you found + what it suggests.]

**Insight 4 (if applicable): [Short descriptive headline]**
[What you found + what it suggests.]

---

## 10. Recommendations

10. Recommendations
Priority
Recommendation
Based On
Suggested Owner
High
[Recommendation tied to top product line insight]
Insight [#]
Sales / Product team
High
[Recommendation tied to top customer insight]
Insight [#]
Customer Success team
Medium
[Recommendation tied to country-level insight]
Insight [#]
Regional Sales team
Low
[Recommendation tied to revenue trend insight]
Insight [#]
Analytics team

| Priority | Recommendation | Based On | Suggested Owner |
|----------|---------------|----------|-----------------|
| High | [Specific, actionable step] | [Insight it comes from] | [Who should act] |
| Medium | [Specific, actionable step] | [Insight it comes from] | [Who should act] |
| Low | [Exploratory or longer-term suggestion] | [Insight it comes from] | [Who should act] |

---

## 13. Deliverables

| Deliverable | Description | Location |
|-------------|-------------|----------|
| SQL Query File | All 8 queries written and executed in MySQL Workbench | queries/final/sales_data_queries.sql |
| Summary Report |Written Word document summarizing findings and insights | reports/Sales_Data_SQL_Analysis_Report.docx |
| Raw Dataset | Original sales_data dataset file | [`visuals/`] |


---

## 14. Author

**Vivian Okwara**
[Your role or title - current or target]

- 🔗 LinkedIn: https://linkedin.com/in/okwara-vivian
- 💼 [Portfolio or GitHub profile URL]
- 📧 Email: okwaravivian26@gmail.com

---

*Last updated: July 2026*
