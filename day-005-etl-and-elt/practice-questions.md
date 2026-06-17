# Day 005 Practice Questions

## Section 1: Simple Questions

1. What does ETL stand for?
2. What does ELT stand for?
3. What does extraction mean?
4. What does transformation mean?
5. What does loading mean?
6. What is a data pipeline?
7. What is the main difference between ETL and ELT?
8. Why do modern cloud platforms often support ELT well?
9. What is a full load?
10. What is an incremental load?
11. Why are data quality checks important?
12. What does stale data mean?

## Section 2: Put the Steps in Order

Arrange the steps in the correct order.

1. ETL: Load, Extract, Transform
2. ELT: Transform, Extract, Load
3. E-commerce ETL: Calculate sales, Extract orders, Load warehouse, Remove duplicates
4. Marketing ELT: Transform using SQL, Extract campaign data, Load raw campaign data
5. Full load: Load all records, Read entire source table, Replace target
6. Incremental load: Extract only changes, Insert or update target, Find new or changed records
7. Validation flow: Load target, Compare row counts, Extract source data
8. Data lake flow: Transform, Extract source data, Store raw files, Load warehouse table

## Section 3: ETL or ELT?

Choose ETL, ELT, or either approach.

1. Sensitive data must be cleaned before entering the target.
2. Raw application logs should be preserved and transformed later.
3. A small CSV file is cleaned and loaded into a warehouse.
4. Multiple teams need different outputs from the same raw marketing data.
5. A cloud warehouse can process large data after loading.
6. A company wants to discard invalid records before loading.
7. Raw JSON responses are loaded first for audit and reprocessing.
8. A simple nightly sales process cleans data before loading.
9. A company uses both raw data lake storage and warehouse transformations.
10. A final reporting table needs trusted cleaned data.

## Section 4: Identify the Transformation

Identify the transformation type.

1. Converting `" uk "` to `"UK"`.
2. Removing repeated orders.
3. Calculating monthly revenue.
4. Joining customer and order data.
5. Converting dollars into pounds.
6. Changing a date into `YYYY-MM-DD` format.
7. Removing rows with invalid payment amounts.
8. Combining first name and last name.
9. Classifying a customer as new or returning.
10. Adding a processing timestamp.
11. Grouping sales by country.
12. Validating email format.

## Section 5: Find the Data Quality Problem

Identify the issue.

1. The same order appears twice in the target table.
2. Customer country is blank.
3. A date is stored as `99/99/2026`.
4. Order amount is `-500` for a normal purchase.
5. The daily input file did not arrive.
6. The dashboard still shows last week's data.
7. Source column `order_amount` changed to `amount`.
8. The same batch was loaded two times.

## Section 6: Think Like a Data Engineer

1. Design a simple ETL pipeline for daily orders.
2. Design a simple ELT pipeline for marketing campaign data.
3. What checks would you add before trusting a sales dashboard?
4. When would you choose incremental loading instead of full loading?
5. How would you explain a late dashboard refresh to a business user?

## Section 7: Mini Assignment

Choose one business scenario:

- Online shopping
- Food delivery
- Banking
- Marketing analytics
- Hospital appointments

Document:

1. Source systems
2. Data to extract
3. Cleaning steps
4. Business transformations
5. Target storage
6. ETL or ELT choice
7. Reason for the choice
8. Data quality checks
9. Full or incremental loading
10. Final dashboard or report

## Answer Key

### Section 1

1. Extract, Transform, Load.
2. Extract, Load, Transform.
3. Collecting data from a source system.
4. Cleaning or changing data into a useful format.
5. Writing data into a destination system.
6. A sequence of steps that moves and prepares data.
7. ETL transforms before loading; ELT loads first and transforms later.
8. They have strong storage and computing power.
9. Loading all records again.
10. Loading only new or changed records.
11. They help prevent wrong dashboards and wrong decisions.
12. Old data that has not refreshed.

### Section 2

1. Extract -> Transform -> Load
2. Extract -> Load -> Transform
3. Extract orders -> Remove duplicates -> Calculate sales -> Load warehouse
4. Extract campaign data -> Load raw campaign data -> Transform using SQL
5. Read entire source table -> Replace target -> Load all records
6. Find new or changed records -> Extract only changes -> Insert or update target
7. Extract source data -> Load target -> Compare row counts
8. Extract source data -> Store raw files -> Transform -> Load warehouse table

### Section 3

1. ETL
2. ELT
3. ETL or either
4. ELT
5. ELT
6. ETL
7. ELT
8. ETL
9. Either
10. ETL or either

### Section 4

1. Standardization
2. Deduplication
3. Aggregation or calculation
4. Joining
5. Calculation or standardization
6. Standardization
7. Filtering or validation
8. Formatting or enrichment
9. Classification
10. Enrichment
11. Aggregation
12. Validation

