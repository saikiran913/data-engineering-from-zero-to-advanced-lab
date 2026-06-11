# Day 002 Data Flow Diagrams

## Diagram 1: Generic Company Data Flow

```text
User Action
    |
    v
Application
    |
    v
Operational Database
    |
    v
Data Pipeline
    |
    v
Raw Storage
    |
    v
Cleaned Data
    |
    v
Data Warehouse
    |
    v
Dashboard
    |
    v
Decision
```

This diagram shows the general journey of data inside a company. A user action is captured by an application, stored in a database, moved by a pipeline, cleaned, organized, and finally used in dashboards for decisions.

## Diagram 2: E-commerce Data Flow

```text
Customer Order
    |
    v
Website
    |
    v
Orders Database
    |
    v
Ingestion Pipeline
    |
    v
Raw Orders File
    |
    v
Clean Orders Table
    |
    v
Sales Summary Table
    |
    v
Power BI Dashboard
    |
    v
Sales Team Decision
```

This diagram shows how an online order becomes part of a sales dashboard. The company can use the dashboard to understand revenue, best-selling products, and order trends.

## Diagram 3: Marketing Campaign Data Flow

```text
Ad Click
    |
    v
Marketing Platform
    |
    v
API / Export File
    |
    v
Raw Campaign Data
    |
    v
Clean Campaign Data
    |
    v
Campaign Performance Table
    |
    v
Dashboard
    |
    v
Marketing Budget Decision
```

This diagram shows how marketing data travels from an ad click to a campaign dashboard. The marketing team can use the final report to decide which campaigns deserve more budget.

## Diagram 4: Banking Transaction Flow

```text
Card Payment
    |
    v
Payment System
    |
    v
Transaction Database
    |
    v
Streaming or Batch Pipeline
    |
    v
Raw Transaction Store
    |
    v
Clean Transaction Table
    |
    v
Fraud Monitoring Table
    |
    v
Risk Dashboard
    |
    v
Fraud Alert / Investigation
```

This diagram shows how a bank transaction can move through systems for monitoring. The final dashboard helps risk teams identify unusual activity and decide whether investigation is needed.

