# Day 004 - Databases, Data Warehouses, and Data Lakes

## Learning Goal

By the end of Day 004, you will understand the difference between databases, data warehouses, and data lakes.

You will learn:

- What a database is
- What a data warehouse is
- What a data lake is
- Why companies use all three
- How each one fits into a data engineering flow
- Which one is used for applications, analytics, raw storage, and reporting

## Why Storage Matters in Data Engineering

Data must be stored somewhere before it can be used.

Every company stores data:

- An e-commerce website stores orders.
- A bank stores transactions.
- A hospital stores patient appointments.
- A marketing team stores campaign data.
- A streaming app stores watch history.

But not all storage systems have the same purpose. Some storage systems help applications run quickly. Some help analysts create reports. Some keep raw files safely for future processing.

Data engineers need to understand which storage system is right for each purpose.

## Simple Big Picture

```text
Application Data
    |
    v
Database
    |
    v
Data Pipeline
    |
    v
Data Lake / Raw Storage
    |
    v
Data Warehouse
    |
    v
Dashboard / Report
```

In simple words:

- The application creates or captures data.
- The database stores data needed for daily operations.
- A data pipeline moves data out for processing.
- The data lake stores raw or mixed data.
- The data warehouse stores clean, structured data for reporting.
- Dashboards and reports help business teams make decisions.

## What is a Database?

A database stores operational data used by applications.

Examples of data in a database:

- Customers table
- Orders table
- Payments table
- Products table
- Login details

Databases help applications work properly.

For example:

- When a customer logs into an app, the app checks the database.
- When a customer places an order, the order is saved in the database.
- When a product stock changes, the database is updated.

A database is usually close to the application and supports day-to-day actions.

## Operational Database

An operational database is a database used for daily business operations.

Examples:

- Online shopping order database
- Bank transaction database
- Student registration database
- Hospital appointment database

Operational databases are usually optimized for fast inserts, updates, and lookups.

For example, an online shopping app needs to quickly:

- Save a new order
- Update payment status
- Check customer login
- Show current order status

Operational databases are often called OLTP systems. OLTP means Online Transaction Processing. In beginner terms, OLTP systems are designed for day-to-day transactions.

## What is a Data Warehouse?

A data warehouse stores cleaned, structured, business-ready data for analysis and reporting.

Examples of warehouse data:

- Daily sales summary
- Monthly revenue table
- Customer purchase history
- Campaign performance table
- Country-wise sales report

Data warehouses are mainly used by:

- Data analysts
- Business analysts
- Reporting teams
- Dashboard tools
- Data scientists

High-level examples of data warehouse tools:

- BigQuery
- Azure Synapse Analytics
- Snowflake
- Amazon Redshift

You do not need to learn tool setup today. Just remember that data warehouses are built for analytics and reporting.

## Analytical Database / OLAP

Data warehouses are analytical systems.

They are often called OLAP systems. OLAP means Online Analytical Processing. In beginner terms, OLAP systems are designed for analysis, reporting, and large queries.

Simple difference:

```text
Database question:
What happened to this one order?

Data warehouse question:
How many orders happened last month across all countries?
```

Operational databases focus on current business actions. Data warehouses focus on understanding business performance.

## What is a Data Lake?

A data lake stores large amounts of raw or semi-processed data.

A data lake can store:

- CSV files
- JSON files
- Log files
- Images
- Videos
- PDFs
- Raw exports
- Application data
- IoT data

Data lakes are flexible because they can store structured, semi-structured, and unstructured data.

High-level examples of data lake or object storage tools:

- Azure Data Lake Storage
- Google Cloud Storage
- Amazon S3

For now, think of a data lake as a large storage area where many kinds of data can be kept.

## Why Companies Use Data Lakes

Companies use data lakes to:

- Store raw data
- Keep history
- Support reprocessing
- Support machine learning and AI
- Store different file formats
- Reduce dependency on only structured tables
- Keep original copies for audit and debugging

For example, if a sales calculation is wrong, the company can go back to raw data in the data lake and process it again.

## Database vs Data Warehouse vs Data Lake

| Feature | Database | Data Warehouse | Data Lake |
| --- | --- | --- | --- |
| Main purpose | Run applications and daily transactions | Support reporting and analytics | Store raw, mixed, or large data |
| Type of data | Mostly structured operational data | Cleaned structured data | Structured, semi-structured, and unstructured data |
| Used by | Applications and operational teams | Analysts, reporting teams, dashboard tools | Data engineers, data scientists, advanced analytics teams |
| Example data | Customer login, order transaction, payment status | Monthly revenue, daily sales, campaign performance | CSV files, JSON logs, images, PDFs, raw exports |
| Optimized for | Fast inserts, updates, and lookups | Large queries and summaries | Flexible storage and history |
| Common tools | Azure SQL, PostgreSQL, MySQL, SQL Server | BigQuery, Azure Synapse, Snowflake, Redshift | Azure Data Lake, Google Cloud Storage, Amazon S3 |
| Beginner example | A shop billing system | A monthly sales report table | A storage room with raw files |
| Business use | Process current actions | Understand performance | Preserve and process many data formats |

## Simple Analogy: Kitchen, Pantry, and Restaurant Report

Think about a restaurant.

- Database = live kitchen order system
- Data Lake = big storage room where all raw ingredients and records are kept
- Data Warehouse = clean prepared reporting table or menu summary for managers

The kitchen order system helps staff process current orders. The storage room keeps many items, including raw ingredients and records. The manager's report summarizes clean information, such as daily sales and popular dishes.

In the same way, a company uses different storage systems for different jobs.

## Another Analogy: School Example

In a school:

Database:

- Stores student registrations
- Stores attendance entries
- Stores fee payments

Data Lake:

- Stores scanned forms
- Stores PDFs
- Stores Excel sheets
- Stores old attendance exports
- Stores images

Data Warehouse:

- Stores class-wise attendance reports
- Stores monthly fee collection summaries
- Stores exam performance reports

The database supports daily school work. The data lake keeps raw and mixed files. The data warehouse supports reporting.

## How They Work Together

```text
Website / App
    |
    v
Operational Database
    |
    v
Ingestion Pipeline
    |
    v
Raw Files in Data Lake
    |
    v
Cleaning and Transformation
    |
    v
Data Warehouse Tables
    |
    v
Dashboard / Reports
    |
    v
Business Decision
```

Step by step:

| Step | Meaning |
| --- | --- |
| Website / App | User actions are captured. |
| Operational Database | Daily business data is stored. |
| Ingestion Pipeline | Data is moved from the source system. |
| Raw Files in Data Lake | Original or mixed data is kept safely. |
| Cleaning and Transformation | Data is fixed and prepared. |
| Data Warehouse Tables | Business-ready data is stored for reporting. |
| Dashboard / Reports | Users view numbers, charts, and trends. |
| Business Decision | Teams decide what action to take. |

## Where Structured, Semi-Structured, and Unstructured Data Fit

This connects directly to Day 003.

| Data Type | Common Storage | Example |
| --- | --- | --- |
| Structured | Database, data warehouse | Customer table, order table, sales summary table |
| Semi-structured | Data lake, object storage, warehouse JSON columns | JSON files, API responses, application logs |
| Unstructured | Data lake, object storage, document/media storage | PDFs, images, videos, audio files |

## Common Beginner Confusions

1. A database and data warehouse are not always the same.
2. A data lake is not only for big companies.
3. A data warehouse is not mainly for app transactions.
4. A database is not always best for reporting.
5. A data lake can store messy or raw data.
6. A warehouse stores cleaned, structured, reporting-ready data.
7. SQL is mostly used with databases and warehouses.
8. Data lakes often store files, not only tables.

## What Can Go Wrong If Storage Is Poorly Designed?

Poor storage design can cause many problems:

- Dashboards become slow.
- Reports show incorrect numbers.
- Raw data is lost.
- Duplicate data increases.
- Teams do not trust reports.
- Analysts depend on manual Excel files.
- Historical data cannot be reprocessed.
- Business decisions become unreliable.

Good storage design helps data stay organized, traceable, and useful.

## Role of a Data Engineer

A data engineer helps decide:

- Where data should be stored
- How data should move between systems
- How raw data should be preserved
- How clean data should be created
- How warehouse tables should support reporting
- How storage should be reliable, scalable, and organized

| Storage Area | Data Engineer Responsibility |
| --- | --- |
| Database | Understand source data and avoid disturbing application performance. |
| Data Lake | Store raw and mixed data safely with clear organization. |
| Data Warehouse | Create clean tables that support reports and dashboards. |
| Pipeline Between Systems | Move data reliably and monitor failures. |
| Reporting Layer | Make sure business users receive trusted data. |

## Key Takeaways

- Data must be stored before it can be used.
- Databases support applications and daily operations.
- Operational databases are often called OLTP systems.
- Data warehouses support analytics, reports, and dashboards.
- Data warehouses are often called OLAP systems.
- Data lakes store raw, mixed, and large data.
- Data lakes can store structured, semi-structured, and unstructured data.
- Companies often use databases, data lakes, and data warehouses together.
- Poor storage design can create slow, wrong, or untrusted reports.
- Data engineers help design reliable storage and data movement.

## Next Day Preview

Day 005 will introduce ETL and ELT.

