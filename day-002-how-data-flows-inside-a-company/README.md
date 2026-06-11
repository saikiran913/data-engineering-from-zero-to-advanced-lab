# Day 002 - How Data Flows Inside a Company

## Learning Goal

By the end of Day 002, you will understand how data moves from source systems to dashboards and business decisions.

You will learn how one simple user action, such as placing an order or clicking a button, can travel through many systems before it becomes part of a business report.

## Why Data Flow Matters

Companies do not magically get reports. A dashboard does not appear by itself. Before a business user sees a number on a report, data must usually be collected, moved, stored, cleaned, transformed, checked, and delivered.

Think about these simple actions:

- A customer places an online order.
- A person makes a bank transaction.
- A user watches a YouTube video.
- Someone likes a post on Instagram.
- A customer places a food delivery order.
- A visitor signs up on a website.

Each action creates data. But that data must travel through a company before it can help people make decisions.

## Simple Definition of Data Flow

Data flow is the journey data takes from the place where it is created to the place where it is used.

In simple words, data flow explains how data moves from a user action to a report, dashboard, or business decision.

## The Full Data Flow Journey

```text
User Action
    |
    v
Application / Website / Mobile App
    |
    v
Operational Database
    |
    v
Data Ingestion
    |
    v
Raw Storage
    |
    v
Data Cleaning
    |
    v
Data Transformation
    |
    v
Data Warehouse
    |
    v
Dashboard / Report
    |
    v
Business Decision
```

This is a beginner-friendly version of a company data flow. Real companies may have more steps, but this flow is enough to understand the main idea.

## Step 1: User Action

Data usually starts when a user does something.

Examples:

- A customer places an order.
- A student submits a form.
- A person clicks an ad.
- A user watches a video.
- A customer makes a payment.

The action may look small, but it creates useful information for the company.

## Step 2: Application / Website / Mobile App

The application, website, or mobile app captures the user's action.

Example:

When a customer clicks "Buy Now", the website may capture:

| Data Captured | Example |
| --- | --- |
| Customer ID | CUST1001 |
| Product ID | PROD500 |
| Price | 65000 |
| Timestamp | 2026-06-11 10:30:00 |
| Payment status | Success |

The app is the place where the action happens. It collects the details needed to run the business process.

## Step 3: Operational Database

Applications usually store day-to-day data in operational databases.

An operational database is used to run the business. It helps the application work correctly. For example, when you place an order, the company must save the order so it can process payment, update stock, and arrange delivery.

Common tables may include:

- Orders table
- Customers table
- Payments table
- Products table

Operational databases are very important, but they are not mainly designed for analytics. They are designed to support daily business operations.

## Step 4: Data Ingestion

Data ingestion means bringing data from source systems into a data platform.

Simple meaning:

Data ingestion is like collecting data from different places and bringing it into one area for processing.

Common ingestion sources include:

- Databases
- APIs
- CSV files
- Excel files
- Application logs
- Marketing platforms
- Payment systems

For example, a data pipeline may collect order data from an orders database every hour and move it to a data storage area.

## Step 5: Raw Storage

Raw storage keeps data close to its original form.

Companies keep raw data because it is useful for:

- Backup
- Audit
- Reprocessing
- Debugging
- Historical tracking

For example, if a transformation rule was wrong, the company can go back to the raw data and process it again correctly.

Common tools used for raw storage include:

- Azure Data Lake
- Google Cloud Storage
- Amazon S3

For now, just remember that raw storage is a place where original data is kept safely.

## Step 6: Data Cleaning

Raw data is often messy.

Examples of messy data:

- Missing customer ID
- Duplicate order
- Wrong date format
- Email in uppercase
- Price stored as text
- Blank country field

Cleaning makes data more usable. It helps remove errors, fix formats, and make the data easier to trust.

| Messy Data | Cleaned Data |
| --- | --- |
| `SALES@EMAIL.COM` | `sales@email.com` |
| `"  India "` | `"India"` |
| `"1000"` | `1000` |
| `11/06/2026` | `2026-06-11` |

## Step 7: Data Transformation

Transformation means changing raw or cleaned data into useful business-ready data.

Examples:

- Calculate total sales.
- Convert currency.
- Group orders by country.
- Combine customer and order data.
- Create a monthly revenue table.
- Classify campaign channels.

Cleaning fixes the data. Transformation prepares the data for business questions.

For example, raw order rows may be transformed into a daily sales summary:

| Date | Total Orders | Total Sales |
| --- | --- | --- |
| 2026-06-11 | 250 | 1250000 |

## Step 8: Data Warehouse

A data warehouse stores cleaned and structured data for analytics and reporting.

It is designed to help teams answer business questions. Analysts and dashboards usually use warehouse data because it is organized and easier to work with.

High-level examples of data warehouse tools:

- BigQuery
- Azure Synapse Analytics
- Snowflake

The data warehouse is not usually where the original app first saves data. It is where prepared data is stored for reporting and analysis.

## Step 9: Dashboard / Report

Dashboards help business users understand performance.

Examples:

- Sales dashboard
- Marketing dashboard
- Finance dashboard
- Operations dashboard
- Customer dashboard

Common dashboard tools include:

- Power BI
- Tableau
- Looker Studio

A dashboard may show numbers, charts, trends, and alerts. But the dashboard is only useful if the data behind it is correct.

## Step 10: Business Decision

The final purpose of data is decision-making.

Examples of business decisions:

- Increase marketing budget.
- Fix a product issue.
- Reduce delivery delay.
- Identify the best-selling product.
- Detect a suspicious transaction.
- Improve customer experience.

Good data helps companies make better decisions. Bad data can lead to wrong decisions.

## Complete Example: Online Shopping Order

Imagine a customer buys a laptop online.

1. Customer clicks Buy Now.
2. Website captures order details.
3. Order is saved in an operational database.
4. Data pipeline extracts order data.
5. Raw order data is stored.
6. Data is cleaned.
7. Sales metrics are calculated.
8. Data is loaded into a warehouse.
9. Dashboard shows daily sales.
10. Business team uses the dashboard to make decisions.

Text flow:

```text
Customer buys laptop
    |
    v
Website captures order
    |
    v
Orders database stores the record
    |
    v
Pipeline collects order data
    |
    v
Raw storage keeps original data
    |
    v
Cleaning fixes issues
    |
    v
Transformation creates sales metrics
    |
    v
Warehouse stores business-ready data
    |
    v
Dashboard shows daily sales
    |
    v
Team decides stock, offers, and planning
```

## Raw Layer, Clean Layer, Business Layer

Many data systems use layers to organize data.

| Layer | Meaning | Example |
| --- | --- | --- |
| Raw Layer | Original data as received. | Order records exactly as collected from the website. |
| Clean Layer | Fixed, standardized, validated data. | Orders with correct dates, no duplicates, and valid amounts. |
| Business Layer | Data ready for dashboards and decisions. | Daily sales summary by product and region. |

This is a simple idea, but it is very powerful. Layers help teams understand where data is in its journey.

## What Can Go Wrong in a Data Flow?

Many things can go wrong:

- Data does not arrive.
- Duplicate data is loaded.
- Values are missing.
- Formats are wrong.
- Pipeline fails.
- Dashboard shows old data.
- Source system changes column names.
- Business logic is incorrect.

Data engineers monitor and fix these issues. Their job is not only to move data, but also to make the data flow reliable.

## Role of a Data Engineer in This Flow

| Flow Step | Data Engineer Responsibility |
| --- | --- |
| Source connection | Understand where the data comes from and how to access it. |
| Ingestion | Build or manage the process that collects data. |
| Storage | Store raw and processed data in the right place. |
| Cleaning | Fix common data issues and standardize formats. |
| Transformation | Prepare business-ready tables and summaries. |
| Automation | Make pipelines run on a schedule. |
| Validation | Check that data is complete and accurate. |
| Monitoring | Watch for failures, delays, and quality issues. |
| Delivery | Provide reliable data to analysts and reporting teams. |

## Beginner Analogy: Restaurant Order System

Think about a restaurant order.

```text
Customer places order
    |
    v
Waiter writes order
    |
    v
Kitchen receives order
    |
    v
Food is prepared
    |
    v
Quality is checked
    |
    v
Food is served
    |
    v
Customer gives feedback
```

Now compare it with data flow:

```text
User action
    |
    v
Application captures data
    |
    v
Database stores data
    |
    v
Pipeline moves data
    |
    v
Data is cleaned and transformed
    |
    v
Dashboard shows result
    |
    v
Business makes decision
```

Just like a restaurant needs a clear process to serve food correctly, a company needs a clear data flow to serve correct information.

## Key Takeaways

- Data flow is the journey data takes from creation to usage.
- Most data starts with a user action.
- Applications capture user activity and save it.
- Operational databases support daily business work.
- Data ingestion brings data into a data platform.
- Raw storage keeps original data for backup, audit, and reprocessing.
- Cleaning fixes messy data.
- Transformation creates business-ready data.
- Data warehouses store organized data for reporting.
- Dashboards and reports help companies make decisions.

## Next Day Preview

Day 003 will explain types of data: structured, semi-structured, and unstructured data.

