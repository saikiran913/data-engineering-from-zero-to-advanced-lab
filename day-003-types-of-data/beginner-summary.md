# Day 003 Beginner Summary

Data does not always look the same. Some data is neatly stored in tables. Some data has labels and nested sections. Some data comes as images, videos, audio, documents, emails, or comments. In Data Engineering, understanding the type of data is important because different data types need different storage and processing methods.

The first type is structured data. Structured data is organized in rows and columns. It looks like a table or spreadsheet. Examples include customer tables, order tables, payment transaction tables, product tables, student marks tables, and Excel sales sheets. Structured data is usually the easiest type for beginners because it is clear and organized. Each row usually represents one record, and each column represents one detail about that record. SQL works very well with structured data, which is why many data lessons start with tables.

The second type is semi-structured data. Semi-structured data has some organization, but it does not always fit neatly into rows and columns. Examples include JSON, XML, application logs, API responses, and event tracking data. A JSON API response may have fields like customer ID, order ID, and amount, but it may also contain nested sections. Data engineers often parse semi-structured data, extract useful fields, and convert them into structured tables for reporting.

The third type is unstructured data. Unstructured data does not have a fixed table-like structure. Examples include images, videos, audio recordings, PDFs, emails, documents, customer reviews, social media comments, and chat conversations. This data can be very useful, but it is harder to analyze directly. Companies may use OCR, text processing, AI, machine learning, or metadata extraction to work with unstructured data.

One real-world app can create all three types of data. A food delivery app may store customer, restaurant, order, and payment details as structured tables. It may receive delivery location updates and order status events as semi-structured JSON or logs. It may also store food images, customer review text, support chats, and delivery call recordings as unstructured data.

Data engineers care about data type because the type affects almost every decision. It affects where the data is stored, how it is cleaned, how it is transformed, and how it is used in dashboards or analysis. Structured data may go into a database or data warehouse. Semi-structured data may be stored in a data lake or object storage, then parsed. Unstructured data may be stored in object storage or a data lake, with useful metadata extracted for search or analysis.

This is also why data engineers do not start by choosing a tool blindly. First, they look at the data. Is it a table? Is it JSON? Is it a log file? Is it a PDF, image, or video? Once they understand the format, they can decide the next step more safely. The same business system may need more than one approach because it may create more than one type of data.

Before moving to Day 004, remember this simple idea: not all data belongs directly in a table. Tables are important, but real-world companies also work with JSON, logs, files, images, videos, documents, and messages. A good data engineer first understands the format of the data, then chooses the right way to store and process it.
