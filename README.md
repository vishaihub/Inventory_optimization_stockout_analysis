
# Inventory Optimization & Stockout Analysis
### ABC Industrial Supplies Pvt. Ltd.

An Excel and SQL Server-based business analytics project focused on identifying inventory inefficiencies, investigating stockout causes, evaluating supplier performance, and providing actionable recommendations to improve inventory management.

---

## 📑 Table of Contents

- [Project Summary](#-project-summary)
- [About the Company](#-about-the-company)
- [Business Problem](#-business-problem)
- [Business Objectives](#-business-objectives)
- [Business Questions](#-business-questions)
- [Dataset Summary](#-dataset-summary)
- [Tools & Technologies](#-tools--technologies)
- [Project Structure](#-project-structure)
- [Methodology](#-methodology)
- [Key Findings](#-key-findings)
- [Business Recommendations](#-business-recommendations)
- [How to Review the Project](#-how-to-review-the-project)
- [Author](#-author)

---

## 📌 Project Summary

This project analyzes inventory and supplier performance for ABC Industrial Supplies Pvt. Ltd., using 3,600 records across 150 SKUs and 24 months. Using Excel and SQL Server, it identifies inventory inefficiencies, stockouts, lost sales, and supplier delays to develop actionable business recommendations.

Key Areas: Inventory classification, overstocking, stockouts, slow/dead stock, inventory turnover, lost sales, and supplier performance.
The analysis combines Microsoft Excel and SQL Server to identify operational inefficiencies, investigate stockout root causes, and translate analytical findings into practical business recommendations.

---


## 🏢 About the Company

ABC Industrial Supplies Pvt. Ltd. is a B2B distribution company supplying industrial components, spare parts, bearings, and maintenance-related products to manufacturing units and industrial customers.

The company manages multiple product categories, including: Bearings, Electrical, Fasteners, Fluid Power and Power Transmission

This project simulates a real-world business scenario where management needs better visibility into inventory utilization, product availability, and supplier reliability.

## ⚠️ Business Problem

The company faces inventory management challenges due to a lack of consolidated analysis of inventory, sales, and supplier performance.

- **Overstocking:** Excess inventory ties up working capital and increases storage costs.
- **Stockouts:** Insufficient inventory results in potential lost sales opportunities.
- **Slow-moving and dead stock:** Products with low or no movement occupy warehouse space and block capital.
- **Supplier delays:** Delayed deliveries disrupt replenishment planning and increase stockout risks.
- **Inefficient inventory planning:** Lack of category-wise and product-level insights makes it difficult to prioritize inventory decisions.

## 🎯 Business Objectives

1. **Optimize Inventory Levels:** Identify overstocked, slow-moving, and dead-stock products to reduce excess inventory investment.
2. **Reduce Stockouts:** Identify frequently unavailable products and investigate the factors contributing to stock shortages.
3. **Evaluate Supplier Performance:** Analyze delivery delays and lead-time variations to identify unreliable suppliers.
4. **Minimize Lost Sales:** Understand the impact of inventory shortages on potential sales opportunities.
5. **Improve Inventory Utilization:** Evaluate inventory turnover and category-wise inventory investment to support better working capital management.

## ❓ Business Questions

### Inventory Analysis
1. What is the overall inventory distribution across different stock conditions?
2. Which products are overstocked or understocked?
3. Which products are classified as fast-moving, slow-moving, and dead stock?
4. Which product categories have the highest inventory investment?
5. Which categories demonstrate the highest and lowest inventory turnover?

### Stockout Analysis
6. How many stockout incidents occurred during the analysis period?
7. Which products and categories experienced the highest stockout frequency?
8. How many stockout incidents occurred when actual lead time exceeded planned lead time?
9. What factors contribute to recurring stockouts?
10. What is the potential sales value lost due to inventory shortages?

### Supplier Analysis
11. Which suppliers have the highest late-delivery rates?
12. How much does actual delivery time vary from planned lead time?
13. How do supplier delivery delays affect inventory availability?

## 📊 Dataset Summary

| Dataset Attribute | Description |
|---|---|
| Company | ABC Industrial Supplies Pvt. Ltd. |
| Analysis Period | September 2024 – August 2026 |
| Total Inventory Records | 3,600 |
| Unique SKUs | 150 |
| Monthly Snapshots | 24 |
| Product Categories | 5 |
| Data Granularity | SKU-month level |
| Data Type | Historical inventory and operational records |



## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| Microsoft Excel | Data exploration, Pivot Tables, inventory classification, KPI calculations, and charts |
| SQL Server | Business analysis, aggregations, CTEs, window functions, and stockout root cause investigation |
| Git & GitHub | Project documentation and version control |

## 📁 Project Structure

```text
Inventory_optimization_stockout_analysis/
│
├── data/
│   └── items_and_stock.xlsx
|   └──items_and_stock_raw.csv
|
├── documentation/
│   └── ABC_industrial_supplies_report.pdf
| 
├── Excel_Analysis/
│   └── items_and_stock_analysis2.xlsx
│
├── excel_output/
│   ├── Lead_variance.png/
│   ├── Stockouts_by_units_sold_and_estimates_lost_sales.png/
│   ├── Inventory_turnover.png/
│   ├── overstock_status.png/
│   ├── periodical_analysis.png/
│   └── stock_value_by_sales_movement_and_cover_status.png/
│
│
├── sql_analysis/
│   └── stockout_analysis.sql
│
├── sql_outputs/
│   ├── High_frequency_stockout_items.png/
│   ├── Stockouts_by_Estimated_Lost_Sales_value.png/
│   ├── Stockout_by_Warehouse.png/
│   ├── Stockout_by_Weeks_of_Cover.png/
│   ├── Stockouts_by_lead_variance.png/
|   ├── Stockout_view_by_Stockout_factor.png/
│   └── stockout_factor_by_category.png/
│
│
└── README.md
```

## 🔍 Methodology

The project follows a structured analytical approach, combining Excel-based exploratory analysis with SQL-based business investigation.

### 1. Data Understanding & Preparation
- Examined dataset structure and prepared data for analysis.

### 2. Exploratory Analysis Using Excel
- Analyzed stock levels, inventory classification, and sales movement.
- Evaluated inventory valuation, turnover, and supplier performance using Pivot Tables and charts.

### 3. Business Analysis Using SQL Server
- Investigated stockouts, dead stock, and slow-moving inventory.
- Analyzed supplier delays and lost-sales opportunities using CTEs, aggregations, and window functions 

### 4. Insights & Recommendations
- Identified inventory inefficiencies and stockout patterns.
- Developed recommendations to optimize inventory, improve replenishment, and monitor supplier performance.

## 📈 Key Findings

### 1. Inventory Health
- Approximately **31.67% of inventory was classified as overstocked**, indicating opportunities to optimize excess inventory.
- The overall stockout rate was approximately **3.17%**.
- Slow-moving and dead stock represented approximately **₹26.10 lakh** in aggregated inventory value.
- Total aggregated stock value across the monthly records was approximately **₹3.81 crore**.

### 2. Stockout Analysis
- Identified **114 stockout incidents** across the 24 monthly snapshots.
- The stockout analysis highlighted inventory coverage and supplier delivery delays as important areas requiring investigation.
- Lost-sales share was approximately **1.61%**, indicating potential sales opportunities affected by inventory shortages.

### 3. Supplier Performance
- Eastbrook Co. recorded the highest late-delivery rate at approximately **23.97%**.
- Clearwater recorded the earliest average lead-time variance of approximately **12.62 days**.
- Supplier delivery reliability requires closer monitoring to improve replenishment planning.

**Key Observations:**
- Power Transmission achieved the highest inventory turnover, indicating comparatively efficient inventory utilization.
- Fasteners recorded the lowest turnover, highlighting opportunities to review demand and inventory levels.
- Fluid Power had the highest total stock value at approximately **₹98.29 lakh**, requiring closer monitoring of inventory investment.

## 💡 Business Recommendations

Based on the analysis, the following recommendations were proposed:

1. **Reduce Excess Inventory:** Review overstocked products and adjust procurement quantities to minimize unnecessary working capital investment.
2. **Improve Replenishment Planning:** Establish appropriate reorder levels and safety stock for products with recurring stockouts.
3. **Monitor Slow-moving Products:** Review demand patterns and purchasing decisions for dead-stock and slow-moving items.
4. **Improve Supplier Reliability:** Monitor supplier delivery performance and investigate recurring lead-time deviations.
5. **Prioritize High-Risk Products:** Focus on products experiencing frequent stockouts and potential lost sales.
6. **Optimize Category-wise Inventory:** Align inventory investment with demand and turnover performance across product categories.

## 📖 How to Review the Project

Follow these steps to explore the project:

1. **Start with the Report:** Open `Report/Inventory_Analysis_Report.pdf` to understand the business problem, analysis, key findings, and recommendations.
2. **Review Raw Data:** Explore `Raw_Data/inventory_raw_data.xlsx` to understand the dataset and its attributes.
3. **Explore Excel Analysis:** Open `Excel_Analysis/Inventory_Analysis.xlsx` and review the Pivot Tables, calculations, and visualizations.
4. **Review Excel Results:** Explore the `Excel_Results/` and `Excel_Charts/` folders for individual analytical outputs.
5. **Explore SQL Queries:** Open the SQL scripts inside `SQL_Analysis/SQL_Queries/` to understand the analytical logic and stockout investigation.
6. **Review SQL Outputs:** Explore `SQL_Results/` to examine the results generated from SQL queries.

**For a quick overview, start with the project report, followed by the Excel analysis and SQL queries.**

---

## 👩‍💻 Author

**Vishwabha Meshram**

Data Analyst | SQL | Microsoft Excel | Business Analytics

- **GitHub:** [github.com/vishaihub](https://github.com/vishaihub)
- **Project Repository:** [Inventory Optimization & Stockout Analysis](https://github.com/vishaihub/Inventory_optimization_stockout_analysis)

---

*This project demonstrates how Excel and SQL Server can be used together to investigate real-world inventory management challenges, identify operational inefficiencies, and support data-driven business decisions.*
