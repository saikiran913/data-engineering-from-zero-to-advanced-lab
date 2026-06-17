# Day 005 Pipeline Flow Diagrams

## Diagram 1: Basic ETL

```text
Source
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
Warehouse
    |
    v
Dashboard
```

In ETL, the data is transformed before it reaches the warehouse.

## Diagram 2: Basic ELT

```text
Source
    |
    v
Extract
    |
    v
Load Raw Data
    |
    v
Transform in Warehouse
    |
    v
Business Table
    |
    v
Dashboard
```

In ELT, raw data is loaded first and transformed inside the target platform.

## Diagram 3: E-commerce ETL

```text
Orders Database
    |
    v
Extract Daily Orders
    |
    v
Remove Duplicates
    |
    v
Standardize Dates
    |
    v
Calculate Sales
    |
    v
Load Sales Warehouse
    |
    v
Sales Dashboard
```

This flow prepares order data before loading it into a sales warehouse.

## Diagram 4: Marketing ELT

```text
Google Ads / Social Ads / Email Platform
    |
    v
Extract Through APIs or Files
    |
    v
Load Raw Campaign Data
    |
    v
Transform Using SQL
    |
    v
Campaign Performance Table
    |
    v
Marketing Dashboard
```

This flow loads raw marketing data first, then transforms it for reporting.

## Diagram 5: Data Lake and Warehouse Flow

```text
Source Systems
    |
    v
Raw Data Lake
    |
    v
Cleaned Layer
    |
    v
Business Transformation
    |
    v
Data Warehouse
    |
    v
Reports
```

This flow preserves raw data before creating clean warehouse outputs.

## Diagram 6: Full Load

```text
Entire Source Table
    |
    v
Clear or Replace Target
    |
    v
Load All Records
```

A full load reloads all records from the source.

## Diagram 7: Incremental Load

```text
Find New or Changed Records
    |
    v
Extract Only Changes
    |
    v
Transform Changes
    |
    v
Insert or Update Target
```

An incremental load processes only new or changed records.

