# Day 004 Notes - Databases, Data Warehouses, and Data Lakes

## What Data Storage Means

Data storage means keeping data in a system or location so it can be used later.

In Data Engineering, storage is not just about saving data somewhere. It is about saving data in the right place for the right purpose.

Different questions need different storage:

- Is the data needed by an app right now?
- Is the data needed for a dashboard?
- Is the data raw and should be preserved?
- Is the data structured, semi-structured, or unstructured?
- Does the data need to be queried quickly?

## Why Storage Is Important in Data Engineering

Storage is important because every data flow depends on it.

If storage is poorly designed:

- Data may be hard to find.
- Reports may become slow.
- Raw data may be lost.
- Teams may create duplicate files.
- Business users may stop trusting dashboards.

Good storage helps data engineers build reliable pipelines and reporting systems.

## Detailed Explanation of Databases

A database stores organized data that applications use for daily work.

Examples:

- Customer details
- Product details
- Orders
- Payments
- Login information
- Account balances

When a user performs an action in an app, the database often stores or retrieves information.

Example:

```text
Customer places order -> App saves order -> Database stores order record
```

Databases are usually designed for quick actions, such as adding one record, updating one record, or finding one customer.

## Operational Databases

Operational databases support daily business operations.

Examples:

- Online shopping order database
- Bank transaction database
- Student registration database
- Hospital appointment database
- Food delivery order database

They are often called OLTP systems. OLTP stands for Online Transaction Processing.

Beginner meaning:

```text
OLTP = system designed for day-to-day transactions
```

Operational databases are good for:

- Fast inserts
- Fast updates
- Fast lookups
- Current application activity

They are not always the best choice for heavy reporting because reporting can require scanning large amounts of historical data.

## Detailed Explanation of Data Warehouses

A data warehouse stores cleaned, structured, business-ready data for analysis and reporting.

Data warehouses are used to answer business questions like:

- What was total revenue last month?
- Which country had the highest sales?
- Which campaign had the best conversion rate?
- Which product category is growing fastest?

Data warehouses usually contain data that has already been cleaned and transformed.

Example:

```text
Raw orders -> Clean orders -> Daily sales summary -> Warehouse table
```

## Analytical Systems

Data warehouses are analytical systems.

They are often called OLAP systems. OLAP stands for Online Analytical Processing.

Beginner meaning:

```text
OLAP = system designed for analysis and reporting
```

OLAP systems are good for:

- Large queries
- Summaries
- Historical analysis
- Dashboards
- Business reporting

Simple comparison:

| Question | Better System |
| --- | --- |
| Is this customer's login valid? | Database |
| What were total logins by country last month? | Data warehouse |
| Did this payment succeed? | Database |
| What was monthly payment success rate? | Data warehouse |

## Detailed Explanation of Data Lakes

A data lake is a flexible storage area for raw, mixed, or large data.

It can store many formats:

- CSV
- JSON
- Logs
- PDFs
- Images
- Videos
- Audio
- Raw application exports

Data lakes are useful because they do not require all data to be clean and table-shaped before storage.

Example:

```text
API JSON files + CSV exports + logs + images -> Data Lake
```

## Why Data Lakes Are Useful for Raw and Mixed Data

Data lakes are useful because real-world data is not always clean or structured.

Companies keep raw data so they can:

- Reprocess it later
- Audit what originally arrived
- Debug pipeline problems
- Support machine learning and AI
- Store multiple file formats
- Keep long-term history

For example, if a transformation rule was wrong, the raw data can be used to rebuild the correct output.

## Why Warehouses Are Useful for Reporting

Warehouses are useful for reporting because dashboards need clean and organized data.

A dashboard should not usually depend on messy raw files. It should use trusted tables.

Examples of warehouse tables:

- Daily sales summary
- Monthly revenue table
- Customer purchase history
- Product performance table
- Campaign performance table

These tables make reports easier, faster, and more reliable.

## Why Databases Are Useful for Applications

Applications need quick and reliable access to current data.

Examples:

- Login check
- Order placement
- Payment status update
- Appointment booking
- Product stock lookup

Databases are designed for these activities. They help applications work smoothly.

## How Data Engineers Choose Storage Systems

Data engineers choose storage based on the purpose of the data.

| Need | Suitable Storage |
| --- | --- |
| Run an app transaction | Database |
| Store raw files for history | Data lake |
| Store clean reporting tables | Data warehouse |
| Store images or PDFs | Data lake or object storage |
| Create dashboards | Data warehouse |
| Keep API JSON responses | Data lake first, then transform if needed |

The same company may use all three systems together.

## How Day 004 Connects to Day 003 Data Types

Day 003 explained structured, semi-structured, and unstructured data.

Day 004 explains where those data types commonly live.

| Data Type | Common Storage |
| --- | --- |
| Structured | Database or data warehouse |
| Semi-structured | Data lake, object storage, NoSQL database, or warehouse JSON columns |
| Unstructured | Data lake, object storage, document storage, or media storage |

This connection is important because data type affects storage choice.

## Important Beginner Reminder

Do not think of database, data warehouse, and data lake as competitors. They solve different problems.

In many modern companies:

```text
Database -> Data Lake -> Data Warehouse -> Dashboard
```

Each step has a purpose.

