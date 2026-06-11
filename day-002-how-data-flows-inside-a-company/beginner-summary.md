# Day 002 Beginner Summary

Data flow means the journey data takes from the place where it is created to the place where it is used. In a company, data usually starts when a user does something. For example, a customer places an order, a person clicks an ad, a user watches a video, or someone makes a payment.

That action is captured by an application, website, or mobile app. The application saves the information in an operational database. This database helps the company run its daily business. For example, an order database helps an online store process orders, update order status, and manage customer purchases.

But operational databases are not always the best place for reports and dashboards. They are mainly used to run the application. If many reports directly use the same database, the application may become slow. Also, business reports often need data from many different systems, not just one database.

That is why companies build data flows.

After data is saved in a source system, a data pipeline may ingest the data. Ingestion means collecting data from a source and bringing it into a data platform. The data may come from databases, APIs, CSV files, Excel files, application logs, payment systems, or marketing platforms.

The first place where ingested data is stored is often raw storage. Raw storage keeps data close to its original form. Companies keep raw data for backup, audit, reprocessing, debugging, and history. Even if raw data is messy, it is useful because it shows what the source system originally provided.

Raw data usually needs cleaning. Real-world data may have missing values, duplicate records, wrong date formats, uppercase emails, blank fields, or numbers stored as text. Cleaning makes the data more consistent and trustworthy.

After cleaning, data often needs transformation. Transformation means changing data into a useful structure for business questions. For example, a company may calculate total sales, group orders by country, combine customer and order data, convert currency, or create monthly revenue summaries.

Cleaned and transformed data is often stored in a data warehouse. A data warehouse is designed for analytics and reporting. Tools like BigQuery, Azure Synapse Analytics, and Snowflake are examples of warehouse tools at a high level.

Dashboards and reports use this prepared data. A sales dashboard may show revenue and orders. A marketing dashboard may show ad performance. A finance dashboard may show costs and profit. These dashboards help business users make decisions.

The final purpose of data flow is decision-making. A company may increase marketing budget, fix a product issue, reduce delivery delays, identify best-selling products, detect suspicious transactions, or improve customer experience.

The data engineer plays an important role in this journey. A data engineer helps connect to source systems, ingest data, store raw data, clean data, transform data, validate data, monitor pipelines, and deliver reliable data to reporting teams.

The most important idea to remember today is this: reports and dashboards depend on strong data flows. If the data flow is broken, delayed, duplicated, or incorrect, the final business decision may also be wrong.

