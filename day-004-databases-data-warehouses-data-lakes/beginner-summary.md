# Day 004 Beginner Summary

Data must be stored before it can be used. In Data Engineering, storage is not just about saving data somewhere. It is about saving the right data in the right place for the right purpose. Three important storage concepts are databases, data warehouses, and data lakes.

A database stores operational data used by applications. For example, when a customer logs into an app, places an order, makes a payment, or updates a profile, the application usually reads from or writes to a database. Databases are used for daily business activity. They are good at fast inserts, updates, and lookups. These systems are often called OLTP systems, which means they are designed for day-to-day transactions.

A data warehouse stores cleaned, structured, business-ready data for reporting and analytics. It is used by analysts, reporting teams, dashboard tools, and business users. For example, a data warehouse may contain daily sales summaries, monthly revenue tables, campaign performance tables, and customer purchase history. Data warehouses are often called OLAP systems, which means they are designed for analysis, reporting, and large queries.

A data lake stores large amounts of raw or semi-processed data. It can store many formats, including CSV files, JSON files, logs, PDFs, images, videos, raw exports, and application data. A data lake is flexible because it can store structured, semi-structured, and unstructured data. Companies use data lakes to keep raw history, support reprocessing, store mixed file formats, and preserve original data for audit or debugging.

The simple difference is this: a database helps applications run, a data lake keeps raw and mixed data, and a data warehouse stores clean reporting data.

Most modern companies use all three together. An application stores current business data in a database. A data pipeline moves data into a data lake, where raw files can be preserved. After cleaning and transformation, important business data is loaded into a data warehouse. Dashboards and reports then use the warehouse to show trusted business numbers.

This connects directly to Day 003. Structured data can live in databases and warehouses. Semi-structured data, such as JSON and logs, often lands in a data lake first. Unstructured data, such as images, PDFs, videos, and audio files, is also commonly stored in data lakes or object storage.

Data engineers work with these systems by deciding where data should be stored, how it should move, how raw data should be preserved, and how clean warehouse tables should be created for reporting. They also help organize storage so that data is reliable, searchable, and useful.

Good storage choices also reduce confusion between teams. Application teams can focus on running the product, data engineers can preserve and prepare data, and analysts can use trusted warehouse tables instead of searching through raw files.

Before moving to ETL and ELT, remember this foundation: data movement only makes sense when you know where the data starts, where it should be stored, and where it must go next. Databases, data lakes, and data warehouses are three important places in that journey.
