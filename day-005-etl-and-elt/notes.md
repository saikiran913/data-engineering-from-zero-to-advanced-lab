# Day 005 Notes - ETL and ELT

## What ETL Means

ETL stands for Extract, Transform, Load.

In ETL, data is collected from source systems, cleaned or changed, and then loaded into the final target system.

```text
Extract -> Transform -> Load
```

ETL is useful when data should be prepared before it reaches the final reporting system.

## What ELT Means

ELT stands for Extract, Load, Transform.

In ELT, data is collected from source systems, loaded into a platform first, and transformed afterward.

```text
Extract -> Load -> Transform
```

ELT is common in modern cloud data platforms because cloud warehouses and lakehouse platforms can process large data after it is loaded.

## Extract

Extract means collect data from a source system.

Common sources:

- Databases
- APIs
- CSV files
- Excel files
- Application logs
- Payment systems
- Marketing platforms
- Cloud storage

Extraction should be careful. A pipeline should collect the required data without slowing down or damaging the source system.

## Transform

Transform means change data into a cleaner or more useful format.

Technical transformations:

- Remove spaces
- Fix date formats
- Convert text to numbers
- Rename columns
- Remove duplicates
- Validate email formats

Business transformations:

- Calculate total revenue
- Classify customers as new or returning
- Assign marketing channel
- Calculate profit
- Identify high-value customers

Transformation is where raw data becomes useful data.

## Load

Load means write data into a destination system.

Destinations:

- Data warehouse
- Database
- Data lake
- Reporting table
- Analytics platform

Loading should be reliable. Data should arrive in the correct place, with the expected number of records, and in the expected format.

## How ETL Differs From ELT

| Topic | ETL | ELT |
| --- | --- | --- |
| Step order | Extract, Transform, Load | Extract, Load, Transform |
| Raw data | May be transformed before final storage | Often preserved first |
| Transformation place | Before final target | Inside target platform |
| Common fit | Traditional controlled pipelines | Modern cloud analytics platforms |

## Why Traditional Systems Often Used ETL

Traditional systems often had limited storage and processing power. It was common to clean and reduce the data before loading it into the warehouse.

ETL helped control:

- Data size
- Data quality
- Warehouse performance
- Sensitive data exposure

## Why Modern Cloud Platforms Often Use ELT

Modern cloud platforms can store and process large amounts of data.

ELT is useful because:

- Raw data can be loaded quickly.
- Original data can be preserved.
- Transformations can happen later.
- Different teams can create different outputs.
- SQL can often be used inside the warehouse.

Examples of tools at a high level include BigQuery, Azure Synapse Analytics, Snowflake, Databricks, and Redshift.

## Full Load

A full load reloads all records.

Example:

```text
Load the full customer table every day.
```

It is simple to understand, but it can be slow and expensive for large datasets.

## Incremental Load

An incremental load loads only new or changed records.

Example:

```text
Load only orders created or updated since yesterday.
```

It is usually faster for large datasets, but it requires a way to identify what changed.

## Data Quality Checks

Data quality checks help confirm that data is trustworthy.

Examples:

- Row count check
- Duplicate check
- Null value check
- Required column check
- Date format check
- Source-to-target comparison
- Total amount check
- Unusual value check

If data quality is poor, dashboards may show wrong results.

## Pipeline Monitoring

Pipeline monitoring means checking whether pipelines run correctly.

Data engineers monitor:

- Did the pipeline start?
- Did it finish?
- Did it fail?
- Did the expected file arrive?
- Did row counts look correct?
- Did the dashboard refresh on time?

Monitoring helps teams find problems before business users depend on incorrect data.

## Why Raw Data Should Sometimes Be Retained

Raw data should sometimes be kept because it helps with:

- Auditing
- Debugging
- Reprocessing
- Historical tracking
- Creating new outputs later

If a transformation rule is wrong, raw data allows the team to rebuild the correct result.

## How ETL and ELT Connect Storage Systems

ETL and ELT connect the systems learned in Day 004.

```text
Database -> Data Pipeline -> Data Lake -> Data Warehouse -> Dashboard
```

The database may be the source. The data lake may store raw data. The warehouse may store clean, business-ready tables. The dashboard uses the final data.

## ETL Is a Concept, Not One Tool

ETL is not one particular product. It is a process pattern.

Many tools can support ETL or ELT:

- SQL tools
- Python tools
- Azure Data Factory
- Azure Databricks
- Azure Synapse
- BigQuery
- Dataflow
- Cloud Composer

The tool can change, but extract, transform, and load remain core ideas.

## Azure and GCP at a High Level

In Azure, data may be moved with Azure Data Factory, stored in Azure Data Lake Storage, transformed with Azure Databricks or Azure Synapse, and reported in Power BI.

In Google Cloud, raw data may be stored in Cloud Storage, analytical data may be stored and transformed in BigQuery, pipelines may use Dataflow or Cloud Composer, and reports may use Looker or Looker Studio.

The important point is not the tool name. The important point is the flow of data from source to trusted reporting output.

