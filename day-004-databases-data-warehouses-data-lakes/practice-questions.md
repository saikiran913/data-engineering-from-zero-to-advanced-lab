# Day 004 Practice Questions

## Section 1: Simple Questions

1. What is a database?
2. What is an operational database used for?
3. What does OLTP mean in beginner terms?
4. What is a data warehouse?
5. What does OLAP mean in beginner terms?
6. What is a data lake?
7. Why do companies keep raw data in a data lake?
8. Which storage system is usually best for dashboards?
9. Which storage system is usually closest to the application?
10. Why might a company use a database, data lake, and data warehouse together?

## Section 2: Choose the Right Storage

Choose Database, Data Warehouse, or Data Lake.

1. Live customer login details
2. Raw CSV export from marketing platform
3. Monthly sales summary table
4. Customer order transaction
5. Product image files
6. Cleaned campaign performance table
7. Raw JSON API response
8. Dashboard-ready revenue table
9. Payment transaction record used by app
10. Old Excel files for audit
11. Application logs
12. Country-wise sales report
13. Scanned hospital form
14. Website clickstream files
15. User profile table used by mobile app

## Section 3: Scenario-Based Questions

1. A mobile app becomes slow because dashboards are running heavy queries on the app database. What storage design improvement might help?
2. A company lost raw files after creating reports. Why is this a problem?
3. A marketing team has JSON exports, CSV files, and ad images. Which storage system can keep these mixed formats?
4. A sales team wants fast monthly revenue reports. Should they usually query raw files or warehouse tables? Why?
5. A hospital wants to preserve scanned forms and also create appointment dashboards. Which storage systems might be used?

## Section 4: Think Like a Data Engineer

1. If an application needs to save new orders quickly, where should that data first go?
2. If a company wants to keep original API responses for audit, where might they store them?
3. If analysts need a clean table for daily sales reporting, where should that table usually live?
4. If raw data is messy but may be useful later, should it be deleted immediately? Why or why not?
5. If a dashboard is slow, what storage or design questions would you ask?

## Section 5: Mini Assignment

Choose one company or app.

List:

- What data should go into a database
- What data should go into a data lake
- What data should go into a data warehouse
- What dashboard or report can be created from the warehouse

Try to explain why each type of data belongs in that storage system.

## Answer Key

### Section 1

1. A database stores data used by applications.
2. An operational database supports daily business operations.
3. OLTP means a system designed for day-to-day transactions.
4. A data warehouse stores clean, structured data for reporting and analytics.
5. OLAP means a system designed for analysis, reporting, and large queries.
6. A data lake stores raw, mixed, or large data in many formats.
7. Companies keep raw data for history, audit, reprocessing, debugging, and future use.
8. A data warehouse is usually best for dashboards.
9. A database is usually closest to the application.
10. They use all three because each one has a different purpose in the data flow.

### Section 2

1. Database
2. Data Lake
3. Data Warehouse
4. Database
5. Data Lake
6. Data Warehouse
7. Data Lake
8. Data Warehouse
9. Database
10. Data Lake
11. Data Lake
12. Data Warehouse
13. Data Lake
14. Data Lake
15. Database

