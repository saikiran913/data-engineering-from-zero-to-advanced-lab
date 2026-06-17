# Day 005 Glossary

| Term | Simple Meaning | Beginner Example |
| --- | --- | --- |
| ETL | Extract, Transform, Load; transform before final loading. | Clean orders first, then load the sales table. |
| ELT | Extract, Load, Transform; load first and transform later. | Load raw campaign data, then clean it in the warehouse. |
| Extract | Collect data from a source. | Read yesterday's orders from an order database. |
| Transform | Clean or change data into a useful format. | Convert `"1000"` into number `1000`. |
| Load | Write data into a destination system. | Save clean sales data into a warehouse table. |
| Data Pipeline | A sequence of steps that moves and prepares data. | Extract orders, clean them, load a dashboard table. |
| Source System | Where data comes from. | A database, API, CSV file, or application log. |
| Target System | Where data is loaded. | A data warehouse, data lake, or reporting table. |
| Data Movement | Moving data between systems. | Copying order records from a database to a warehouse. |
| Raw Data | Data close to its original form. | Original JSON response from an API. |
| Clean Data | Data that has been fixed and standardized. | Dates and emails stored consistently. |
| Business-Ready Data | Data prepared for reports and decisions. | Monthly revenue table. |
| Technical Transformation | A change that fixes format or quality. | Remove spaces from names. |
| Business Transformation | A change that applies business meaning. | Calculate profit or classify customer type. |
| Full Load | Loading all records again. | Reload the full customer table. |
| Incremental Load | Loading only new or changed records. | Load only orders updated since yesterday. |
| Data Validation | Checking whether data is acceptable. | Confirm all required columns exist. |
| Data Quality Check | A test that helps confirm data is trustworthy. | Check for duplicate orders. |
| Duplicate Record | The same record appears more than once. | One order is loaded twice. |
| Missing Value | A required value is blank or null. | Country is missing for a customer. |
| Data Standardization | Making values follow one consistent format. | Convert all country codes to uppercase. |
| Data Enrichment | Adding useful extra information. | Add country name from country code. |
| Aggregation | Summarizing many records. | Total sales by month. |
| Join | Combining related datasets. | Combine customer data with order data. |
| Pipeline Failure | A pipeline does not complete successfully. | A file is missing and the load fails. |
| Pipeline Monitoring | Watching pipeline health and results. | Check whether the daily sales pipeline finished. |
| Scheduling | Running a pipeline at planned times. | Run the order pipeline every night at 1:00 AM. |
| Orchestration | Coordinating multiple pipeline steps. | Run extraction, then transformation, then validation. |
| Source-to-Target Check | Comparing source data with loaded data. | Source has 1,000 rows and target should also have 1,000 rows. |
| Stale Data | Old data that has not refreshed. | Dashboard still shows yesterday's numbers. |

