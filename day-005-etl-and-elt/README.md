# Day 005 - ETL and ELT: Moving and Transforming Data

## Learning Goal

By the end of Day 005, you will understand what ETL and ELT mean, how data pipelines move data, where transformation happens, why data quality checks matter, and how these ideas connect databases, data lakes, and data warehouses.

## Why ETL and ELT Matter

Data is usually created in many different systems. Before reporting and analysis, companies often need to bring that data together.

Examples:

- Customer data stored in one database
- Order data stored in another database
- Payment data received through an API
- Marketing data received as CSV files
- Website activity stored in log files

ETL and ELT help companies collect, clean, organize, and deliver this data so dashboards and reports can be trusted.

## What is a Data Pipeline?

A data pipeline is a sequence of steps that moves data from one place to another and prepares it for use.

```text
Data Source
    |
    v
Extraction
    |
    v
Movement
    |
    v
Transformation
    |
    v
Loading
    |
    v
Validation
    |
    v
Reporting / Analytics
```

| Stage | Simple Meaning |
| --- | --- |
| Data Source | The place where data starts. |
| Extraction | Collecting data from the source. |
| Movement | Moving data between systems. |
| Transformation | Cleaning or changing data into a useful format. |
| Loading | Writing data into the target system. |
| Validation | Checking whether data is correct and complete. |
| Reporting / Analytics | Using data in dashboards, reports, or analysis. |

## What Does ETL Stand For?

ETL stands for Extract, Transform, Load.

- E = Extract
- T = Transform
- L = Load

In ETL, data is transformed before it is loaded into the final target system.

```text
Source Systems
    |
    v
Extract
    |
    v
Transform
    |
    v
Load
    |
    v
Data Warehouse
```

## Step 1: Extract

Extraction means collecting data from one or more source systems.

Source examples:

- Application database
- CSV file
- Excel file
- API
- Marketing platform
- Payment system
- Application logs
- Cloud storage
- Customer relationship management system

Extraction should collect data safely without interrupting the source system.

Beginner example: an online shop extracts yesterday's orders from its order database.

## Step 2: Transform

Transformation means changing raw data into a cleaner and more useful form.

Common transformation examples:

- Remove duplicate rows
- Handle missing values
- Standardize date formats
- Convert text into numbers
- Convert currency
- Rename columns
- Combine customer and order tables
- Calculate total sales
- Group sales by country
- Classify marketing channels
- Validate email formats
- Remove invalid records

Transformation can include technical cleaning and business logic.

## Step 3: Load

Loading means writing the prepared data into the destination system.

Destination examples:

- Data warehouse
- Database
- Data lake
- Reporting table
- Analytics platform

Beginner example: cleaned order data is loaded into a sales table inside a data warehouse.

## Complete ETL Example

E-commerce ETL example:

1. Extract orders from the application database.
2. Remove duplicate orders.
3. Fix date formats.
4. Convert prices into one currency.
5. Calculate total order value.
6. Load the cleaned data into a data warehouse.
7. Use the warehouse data in a sales dashboard.

```text
Orders Database
    |
    v
Extract Orders
    |
    v
Clean and Transform Orders
    |
    v
Load Sales Warehouse Table
    |
    v
Sales Dashboard
```

## What Does ELT Stand For?

ELT stands for Extract, Load, Transform.

- E = Extract
- L = Load
- T = Transform

In ELT, raw data is loaded into the destination platform first and transformed afterward.

```text
Source Systems
    |
    v
Extract
    |
    v
Load Raw Data
    |
    v
Transform Inside the Platform
    |
    v
Business-Ready Tables
```

## Complete ELT Example

Cloud warehouse example:

1. Extract campaign data from multiple advertising platforms.
2. Load raw data into cloud storage or a cloud warehouse.
3. Keep the original raw data.
4. Use SQL to clean and transform the data.
5. Create campaign performance tables.
6. Connect the final tables to a dashboard.

The tool names can change, but the idea stays the same: load raw data first, then transform it inside a strong data platform.

## ETL vs ELT

| Feature | ETL | ELT |
| --- | --- | --- |
| Full form | Extract, Transform, Load | Extract, Load, Transform |
| Order of steps | Transform before loading | Load before transforming |
| When transformation happens | Before data reaches the final target | After raw data is loaded |
| Where transformation happens | In a separate processing step or tool | Inside the target platform or warehouse |
| Raw data retention | Raw data may not always be kept in the target | Raw data is often preserved |
| Common storage destination | Data warehouse or reporting database | Data lake, cloud warehouse, or lakehouse |
| Typical use | Traditional controlled pipelines | Modern flexible cloud pipelines |
| Traditional or modern approach | More traditional | Common in modern cloud systems |
| Cloud suitability | Useful, but can be less flexible | Strong fit for cloud warehouses |
| Flexibility | Less flexible if raw data is discarded | More flexible because raw data remains available |
| Processing power needed | Processing happens before loading | Target platform needs strong compute power |
| Beginner example | Clean CSV first, then load it | Load CSV first, then clean it in the warehouse |

## Simple ETL Example

```text
CSV File
    |
    v
Clean the CSV
    |
    v
Calculate totals
    |
    v
Load into warehouse
```

## Simple ELT Example

```text
CSV File
    |
    v
Load raw CSV data into warehouse
    |
    v
Clean and calculate using SQL
    |
    v
Create final reporting table
```

## Why Modern Cloud Platforms Often Use ELT

Modern cloud platforms often use ELT because:

- Cloud warehouses have strong computing power.
- Raw data can be loaded quickly.
- Transformation can be done later.
- Original data can be preserved.
- Teams can create different transformed outputs from the same raw data.
- SQL can be used directly inside the warehouse.

High-level examples:

- BigQuery
- Azure Synapse Analytics
- Snowflake
- Databricks
- Redshift

## Where Data Lakes Fit

```text
Source Systems
    |
    v
Extract
    |
    v
Raw Data Lake
    |
    v
Transform
    |
    v
Data Warehouse
    |
    v
Dashboard
```

The data lake can preserve original files while the warehouse holds cleaned and reporting-ready data.

## Transformation Categories

| Transformation Type | Simple Meaning | Example |
| --- | --- | --- |
| Cleaning | Fix messy values | Remove spaces from names |
| Standardization | Make values consistent | Use one date format |
| Validation | Check whether values are acceptable | Confirm email format |
| Filtering | Remove unwanted records | Exclude cancelled orders |
| Deduplication | Remove repeated records | Keep one copy of each order |
| Joining | Combine related data | Join customers with orders |
| Aggregation | Summarize many rows | Total sales by month |
| Calculation | Create new values from existing values | Quantity multiplied by price |
| Classification | Assign categories | New customer or returning customer |
| Enrichment | Add useful extra data | Add country name from country code |
| Formatting | Change display or structure | Rename unclear columns |
| Business-rule application | Apply company logic | Define high-value customer |

## Technical Transformation vs Business Transformation

| Type | Meaning | Examples |
| --- | --- | --- |
| Technical transformation | Fixes structure, format, or quality | Convert string to integer, fix date format, remove spaces, rename columns, remove duplicates |
| Business transformation | Applies business meaning | Calculate profit, classify customer as new or returning, assign campaign channel, calculate monthly revenue, determine high-value customers |

## Batch ETL at a High Level

Batch processing means data is processed in groups at scheduled times.

Data may be processed:

- Every hour
- Every night
- Every week
- At the end of each month

Example: a company processes all yesterday's orders every night at 1:00 AM.

Real-time processing will be explained later.

## Full Load vs Incremental Load

### Full Load

A full load means all data is loaded again.

Example: load the entire customer table every day.

### Incremental Load

An incremental load means only new or changed data is loaded.

Example: load only orders created or updated since yesterday.

| Feature | Full Load | Incremental Load |
| --- | --- | --- |
| Amount of data | All records | Only new or changed records |
| Speed | Slower for large data | Usually faster |
| Complexity | Simpler | More complex |
| Common use | Small tables, simple rebuilds | Large tables, daily updates |
| Beginner example | Reload all customers | Load only yesterday's new orders |

## Data Quality Checks in ETL and ELT

Data should be checked before it is trusted.

Common checks:

- Row count check
- Null value check
- Duplicate check
- Data type check
- Valid date check
- Total amount check
- Source-to-target comparison
- Required column check
- Unusual value check

Bad data can create wrong dashboards and wrong business decisions.

## What Can Go Wrong in ETL or ELT?

Common issues:

- Source data is unavailable.
- API fails.
- File does not arrive.
- Source column name changes.
- Duplicate data is loaded.
- Dates are incorrect.
- Transformation rule is wrong.
- Pipeline runs late.
- Target table is unavailable.
- Dashboard shows stale data.
- Data is loaded twice.
- Records are missing.

Data engineers monitor, investigate, fix, and prevent these problems.

## Role of a Data Engineer

| Pipeline Stage | Data Engineer Responsibility |
| --- | --- |
| Source understanding | Learn where data comes from and what it means. |
| Extraction | Collect data safely from source systems. |
| Data movement | Move data between systems reliably. |
| Raw storage | Preserve original data when needed. |
| Transformation | Clean and prepare useful data. |
| Loading | Write data to the correct destination. |
| Validation | Check data quality and completeness. |
| Scheduling | Make pipelines run at the right time. |
| Monitoring | Watch for failures, delays, and bad data. |
| Failure handling | Investigate and fix pipeline problems. |
| Documentation | Explain sources, rules, and outputs. |
| Supporting reporting teams | Provide trusted data for dashboards. |

## Beginner Analogy: Laundry Process

ETL:

```text
Dirty clothes collected = Extract
Clothes washed and sorted = Transform
Clean clothes placed in wardrobe = Load
```

ELT:

```text
Dirty clothes collected = Extract
Dirty clothes placed in a laundry area = Load
Clothes washed and sorted there = Transform
```

This analogy is simplified, but it helps show the order difference.

## Another Analogy: Cooking

ETL:

```text
Buy ingredients -> Clean and prepare ingredients -> Store prepared meal
```

ELT:

```text
Buy ingredients -> Store ingredients in the kitchen -> Prepare different meals later
```

ELT keeps raw ingredients available, which gives teams more flexibility later.

## ETL and ELT in Azure and Google Cloud

Azure examples:

- Azure Data Factory for moving and orchestrating data
- Azure Data Lake Storage for storing raw files
- Azure Databricks or Azure Synapse for transformation
- Power BI for reporting

Google Cloud examples:

- Cloud Storage for raw data
- BigQuery for storing and transforming analytical data
- Dataflow for data processing
- Cloud Composer for orchestration
- Looker or Looker Studio for reporting

Tools can change, but the ETL and ELT concepts remain the same.

## Common Beginner Confusions

1. ETL is not one single tool.
2. ETL is a process or design pattern.
3. ELT does not mean data is never cleaned.
4. Transformation can happen in many tools.
5. Loading data is not the final step; validation is also required.
6. ETL and ELT can both exist in the same company.
7. A data pipeline can contain more steps than ETL.
8. SQL and Python can both be used for transformation.
9. Raw data and final reporting data should not always be mixed.
10. Data movement alone is not enough; quality and monitoring matter.

## Key Takeaways

- ETL means Extract, Transform, Load.
- ELT means Extract, Load, Transform.
- Extraction collects data from source systems.
- Transformation cleans and prepares data.
- Loading writes data into a destination system.
- ETL transforms data before loading it.
- ELT loads raw data first and transforms it later.
- Modern cloud systems often support ELT well.
- Data lakes help preserve raw data.
- Warehouses often store business-ready reporting data.
- Data quality checks are essential.
- Data engineers build, monitor, and improve pipelines.

## Next Day Preview

Day 006 will explain batch processing and real-time or streaming data processing.

