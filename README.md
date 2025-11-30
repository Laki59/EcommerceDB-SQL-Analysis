# EcommerceDB SQL Analysis

This repository contains a comprehensive set of SQL queries written for a sample **Ecommerce database**. The queries demonstrate common business analytics, reporting, and data insights that are relevant for a Junior Data Analyst or SQL Developer portfolio.

---

## Database Overview

The database `EcommerceDB` consists of the following tables:

- **Customers** – Information about registered customers.
- **Products** – Product details, including stock and pricing.
- **Orders** – Orders placed by customers, including order date and status.
- **OrderItems** – Line items of each order, including quantity, price, and discounts.
- **Payments** – Payment details for orders, including payment method and amount.

---

## Purpose

These queries showcase practical skills in:

- **Customer analytics**: identifying top customers, inactive customers, and customer demographics.
- **Order analytics**: monthly orders, largest orders, pending orders, and order trends.
- **Product analytics**: best-selling products, stock analysis, revenue per product, and unused products.
- **Payment analytics**: revenue per payment method, average payments, largest payments.
- **Business metrics**: total revenue, total discount impact, month-over-month revenue growth.

---

## Query Sections

1. **Customer Queries**
   - Customers signed up in February.
   - Customer count per country.
   - Customers with more than 1 order.
   - Customer with the highest total spend.
   - Customers who never placed an order.

2. **Product Queries**
   - Products with stock less than 5.
   - Average price per product category.
   - Top best-selling products.
   - Total stock value.
   - Products never ordered.

3. **Order Queries**
   - Count orders per month.
   - Completed orders with customer names.
   - Total revenue.
   - Largest order amount.
   - Pending orders older than 7 days.

4. **OrderItems Queries**
   - Total quantity sold per product.
   - Orders with discounts applied.
   - Total money lost to discounts.
   - Total revenue per product.
   - Items bought per customer.

5. **Payment Queries**
   - Revenue per payment method.
   - Orders with no payment yet.
   - Average payment amount.
   - Payments sorted by date.
   - Largest single payment.

6. **Advanced Analytics**
   - Month-over-month revenue growth.

## Skills Demonstrated

- SQL Server (T-SQL) proficiency.
- JOINs (INNER, LEFT, RIGHT).
- Aggregate functions: `SUM`, `COUNT`, `AVG`.
- Filtering and grouping (`WHERE`, `GROUP BY`, `HAVING`).
- Window functions (`LAG`) for time-based analytics.
- Ranking and top queries (`TOP`, `ORDER BY`).
- Handling nulls and identifying missing data.
- Business metric calculations (revenue, discounts, MoM growth).

