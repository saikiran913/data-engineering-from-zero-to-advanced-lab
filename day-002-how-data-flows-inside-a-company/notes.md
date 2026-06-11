# Day 002 Notes - How Data Flows Inside a Company

## What Data Flow Means

Data flow means the path data follows from the moment it is created to the moment it is used.

In a company, data usually starts in a source system. A source system can be a website, mobile app, database, payment system, marketing platform, or file. After that, the data is collected, stored, cleaned, transformed, and delivered to reporting tools.

Simple flow:

```text
Source system -> Pipeline -> Storage -> Cleaning -> Transformation -> Dashboard
```

The goal of data flow is to make sure useful data reaches the right people at the right time.

## Why Companies Need Data Flow

Companies need data flow because data is created in many places.

For example, an e-commerce company may have:

- Order data in an order system
- Payment data in a payment system
- Customer data in a customer database
- Delivery data in a logistics system
- Marketing data in an advertising platform

If these systems stay separate, it becomes difficult to answer business questions.

Questions like these need data from multiple places:

- How many orders did we receive today?
- Which products sold the most?
- Which ads brought customers?
- Which customers had failed payments?
- Which areas had delivery delays?

Data flow helps connect these pieces.

## Source Systems vs Reporting Systems

Source systems are where data is created or first stored. Reporting systems are where data is used for analysis.

| Type | Purpose | Example |
| --- | --- | --- |
| Source system | Runs daily business activity. | Website, mobile app, payment system, operational database. |
| Reporting system | Helps people understand business performance. | Dashboard, report, analytics platform. |

A source system focuses on actions. A reporting system focuses on questions.

Example:

- Source system: Save a new order quickly.
- Reporting system: Show total sales by month.

## Why Operational Databases Are Not Always Used Directly for Analytics

Operational databases are built to support daily business work. They help applications run smoothly.

For example, an order database helps the website:

- Save new orders
- Update order status
- Check payment status
- Show customer order history

Analytics work is different. Analytics may require reading large amounts of data, joining many tables, calculating summaries, and looking at history.

If dashboards directly use the operational database too heavily, it can slow down the application. That is why companies often move data into separate storage or a data warehouse for reporting.

## What Ingestion Means

Ingestion means collecting data from a source and bringing it into a data platform.

Data can be ingested from:

- Databases
- APIs
- CSV files
- Excel files
- Application logs
- Payment systems
- Marketing platforms

Ingestion may happen in different ways:

| Method | Simple Meaning |
| --- | --- |
| Batch ingestion | Data is collected at scheduled times, such as hourly or daily. |
| Streaming ingestion | Data is collected continuously or very quickly after it is created. |

As a beginner, remember this: ingestion is the collection step.

## What Raw Data Means

Raw data is data stored close to the way it was received from the source.

Example raw order data:

| order_id | customer_email | amount | order_date |
| --- | --- | --- | --- |
| 1001 | `USER@EMAIL.COM` | `"500"` | `11/06/2026` |

Raw data may not be clean, but it is valuable because it shows what came from the source.

Companies keep raw data for:

- Backup
- Audit
- Reprocessing
- Debugging
- Historical tracking

## Why Cleaning Is Needed

Cleaning is needed because real-world data is often messy.

Common problems:

- Missing values
- Duplicate records
- Extra spaces
- Different date formats
- Text stored in different cases
- Numbers stored as text
- Invalid codes or names

Example:

| Problem | Example | Cleaned Version |
| --- | --- | --- |
| Extra spaces | `"  Laptop "` | `"Laptop"` |
| Uppercase email | `USER@EMAIL.COM` | `user@email.com` |
| Text amount | `"500"` | `500` |
| Date format | `11/06/2026` | `2026-06-11` |

Cleaning makes data easier to use and easier to trust.

## What Transformation Means

Transformation means changing data into a more useful structure for business use.

Cleaning fixes problems. Transformation creates meaning.

Examples of transformation:

- Calculate total sales per day.
- Combine order data with customer data.
- Group users by country.
- Convert currency.
- Create monthly revenue summaries.
- Categorize marketing campaigns.

Example transformation:

Raw order rows:

```text
Order 1: 500
Order 2: 700
Order 3: 300
```

Business-ready result:

```text
Total sales = 1500
```

## Why Warehouses Exist

A data warehouse stores clean, organized data for reporting and analytics.

Warehouses exist because business teams need data that is:

- Structured
- Reliable
- Easy to query
- Ready for dashboards
- Designed for analysis

Examples of warehouse tools include BigQuery, Azure Synapse Analytics, and Snowflake.

The warehouse is often the place where analysts and reporting tools get data.

## Why Dashboards Depend on Good Pipelines

A dashboard is only as good as the pipeline behind it.

If the pipeline fails, the dashboard may show old data.

If data is duplicated, the dashboard may show higher sales than reality.

If data is missing, the dashboard may show incomplete results.

If transformation logic is wrong, the dashboard may answer the wrong business question.

This is why data engineers build, test, monitor, and improve data pipelines.

## Problems Data Engineers Solve in Data Flow

Data engineers solve many practical problems:

| Problem | What It Means | Data Engineer's Work |
| --- | --- | --- |
| Data not arriving | Source data is missing or delayed. | Check pipeline, source connection, and schedule. |
| Duplicate data | Same record appears more than once. | Add rules to identify and remove duplicates. |
| Missing values | Important fields are blank. | Add validation and work with source teams. |
| Wrong format | Dates, numbers, or text are inconsistent. | Standardize formats during cleaning. |
| Pipeline failure | The data movement process breaks. | Monitor logs and fix the failure. |
| Old dashboard data | Dashboard did not refresh correctly. | Check pipeline timing and refresh process. |
| Source changes | A source system changes column names or structure. | Update ingestion and transformation logic. |
| Wrong business logic | Calculation rules do not match business meaning. | Confirm logic with business teams and correct transformations. |

## Important Beginner Reminder

Data flow is not only a technical idea. It is also a business idea.

The real goal is not just to move data. The goal is to help people trust the data they use for decisions.

