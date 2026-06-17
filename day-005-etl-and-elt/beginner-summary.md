# Day 005 Beginner Summary

ETL and ELT are two important patterns in Data Engineering. They explain how data is collected, moved, changed, and prepared for reporting or analysis.

ETL stands for Extract, Transform, Load. Extract means collecting data from a source system. A source system can be an application database, API, CSV file, Excel file, payment system, marketing platform, or log file. Transform means cleaning or changing the data into a better format. Load means writing the prepared data into a destination system, such as a data warehouse, database, data lake, or reporting table.

In ETL, transformation happens before loading. For example, an online store may extract order data from its database, remove duplicate orders, fix date formats, calculate total sales, and then load the cleaned data into a warehouse table used by a dashboard.

ELT stands for Extract, Load, Transform. In ELT, data is extracted and loaded first, often in raw form. Transformation happens afterward inside the target platform, such as a cloud data warehouse or data lakehouse. For example, a marketing team may load raw campaign data from several platforms into a warehouse first, then use SQL to clean campaign names, calculate click-through rate, and create final campaign performance tables.

The simple difference is the order. ETL transforms data before loading it into the target system. ELT loads raw data first and transforms it later.

Modern cloud platforms often use ELT because they can store and process large amounts of data. Raw data can be loaded quickly, preserved, and reused for different purposes. This is useful when multiple teams need different transformed outputs from the same original data.

Transformation can be technical or business-focused. Technical transformations fix format and quality problems, such as removing spaces, converting text into numbers, standardizing dates, and removing duplicates. Business transformations apply meaning, such as calculating profit, grouping sales by month, classifying customers as new or returning, and identifying high-value customers.

Data quality checks are important in both ETL and ELT. A pipeline should check for duplicate records, missing values, invalid dates, wrong data types, unusual values, required columns, and row count differences. If bad data reaches a dashboard, business users may make wrong decisions.

Full load and incremental load are two common loading ideas. A full load reloads all records, such as loading the entire customer table every day. It is simple but can be slow for large data. An incremental load loads only new or changed records, such as yesterday's new orders. It is usually faster but more complex.

Data engineers use pipelines because companies need repeatable and reliable data movement. A pipeline can extract data from sources, move it into raw storage, transform it, load it into reporting tables, validate the results, and alert teams when something fails.

ETL and ELT also connect the storage systems from Day 004. Source databases may create operational data. A data lake may keep raw files safely. A data warehouse may store clean business-ready tables. Dashboards then use those tables for reporting and decision-making. This is why pipeline design matters: each step should have a clear purpose.

Before Day 006, remember this: ETL and ELT are not single tools. They are patterns for moving and preparing data. The tools may change, but every data engineer must understand extraction, transformation, loading, validation, monitoring, and the difference between raw data and business-ready data. Once these ideas are clear, batch processing and real-time processing will be much easier to understand.
