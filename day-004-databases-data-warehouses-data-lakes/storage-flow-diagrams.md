# Day 004 Storage Flow Diagrams

## Diagram 1: Basic Storage Flow

```text
Application
    |
    v
Database
    |
    v
Data Pipeline
    |
    v
Data Lake
    |
    v
Transformation
    |
    v
Data Warehouse
    |
    v
Dashboard
```

This diagram shows the basic journey from application data to dashboard. The database supports the app, the data lake stores raw data, and the warehouse stores clean reporting data.

## Diagram 2: E-commerce Storage Flow

```text
Website Order
    |
    v
Orders Database
    |
    v
Raw Order Files in Data Lake
    |
    v
Clean Orders Table
    |
    v
Sales Warehouse Table
    |
    v
Sales Dashboard
```

This diagram shows how an online order can move from the website database into raw storage, then into clean warehouse tables for a sales dashboard.

## Diagram 3: Marketing Analytics Storage Flow

```text
Ad Platform
    |
    v
API Export
    |
    v
Raw Campaign Files in Data Lake
    |
    v
Clean Campaign Tables
    |
    v
Campaign Performance Warehouse
    |
    v
Marketing Dashboard
```

This diagram shows how marketing data can be collected from an ad platform, stored as raw files, cleaned, and prepared for campaign reporting.

## Diagram 4: Hospital Storage Flow

```text
Appointment App
    |
    v
Appointment Database
    |
    v
Raw Forms / Logs / Files in Data Lake
    |
    v
Clean Patient Appointment Tables
    |
    v
Hospital Reporting Warehouse
    |
    v
Operations Dashboard
```

This diagram shows how appointment data and related files can move through storage systems before appearing in a hospital operations dashboard.

