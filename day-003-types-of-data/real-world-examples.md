# Day 003 Real-World Examples

## Example 1: E-commerce Platform

### Business Situation

An e-commerce platform sells products online and tracks customers, orders, payments, searches, reviews, and product images.

### Structured Data Examples

- Customer table
- Product table
- Order table
- Payment transaction table
- Inventory table

### Semi-Structured Data Examples

- JSON API response from payment gateway
- Website clickstream event
- Search filter event log
- Delivery tracking response

### Unstructured Data Examples

- Product images
- Customer review text
- Support chat messages
- PDF invoices

### What a Data Engineer Does With Each Type

Structured data may be stored in databases and warehouses for sales reports. Semi-structured data may be parsed to extract fields such as event time, product ID, and payment status. Unstructured data may be stored in a data lake, with metadata such as file name, product ID, or upload date.

### Final Business Use

The company can understand sales, improve product search, track delivery performance, and study customer feedback.

## Example 2: Food Delivery App

### Business Situation

A food delivery app connects customers, restaurants, and delivery partners.

### Structured Data Examples

- Customer table
- Restaurant table
- Order table
- Payment table
- Delivery partner table

### Semi-Structured Data Examples

- JSON location updates
- Order status event logs
- Delivery partner API response
- App usage events

### Unstructured Data Examples

- Food images
- Customer review comments
- Support chat messages
- Delivery call recordings

### What a Data Engineer Does With Each Type

Structured data can support order and revenue dashboards. Semi-structured tracking data can be parsed to calculate delivery time. Unstructured reviews and chats may be stored and later processed to understand customer experience.

### Final Business Use

The company can reduce delivery delays, improve restaurant quality, and understand customer satisfaction.

## Example 3: Banking System

### Business Situation

A banking system handles accounts, payments, transactions, support requests, and documents.

### Structured Data Examples

- Account table
- Customer table
- Transaction table
- Loan payment table
- Branch table

### Semi-Structured Data Examples

- Payment gateway response
- ATM event logs
- Online banking activity logs
- Notification delivery status

### Unstructured Data Examples

- Scanned documents
- Customer emails
- Call recordings
- PDF statements

### What a Data Engineer Does With Each Type

Structured transaction data may be loaded into a warehouse for reporting. Semi-structured logs may be processed for monitoring and audit. Unstructured documents may be stored securely with metadata for search and review.

### Final Business Use

The bank can prepare reports, monitor transactions, support customers, and review documents when needed.

## Example 4: Marketing Analytics Platform

### Business Situation

A marketing platform tracks campaigns, ad spend, clicks, conversions, creatives, and customer responses.

### Structured Data Examples

- Campaign table
- Click count table
- Cost table
- Conversion table
- Daily performance table

### Semi-Structured Data Examples

- API campaign response
- Event tracking payload
- Web clickstream log
- Ad platform export data

### Unstructured Data Examples

- Video ads
- Banner images
- Customer comments
- Feedback messages

### What a Data Engineer Does With Each Type

Structured metrics can be used directly in dashboards. Semi-structured API data may be flattened into campaign performance tables. Unstructured creative files and comments may be stored and linked to campaigns using metadata.

### Final Business Use

Marketing teams can compare campaign performance, adjust budgets, and understand audience feedback.

## Example 5: Streaming Platform

### Business Situation

A streaming platform tracks users, subscriptions, watch history, search behavior, and media content.

### Structured Data Examples

- User table
- Subscription table
- Payment table
- Content catalog table
- Watch summary table

### Semi-Structured Data Examples

- Watch event logs
- Search event payloads
- Recommendation response data
- Device activity logs

### Unstructured Data Examples

- Video files
- Audio files
- Subtitle documents
- User comments

### What a Data Engineer Does With Each Type

Structured data can support subscription and revenue reporting. Semi-structured watch events can be parsed to calculate watch time. Unstructured media files can be stored in object storage with metadata such as title, genre, and duration.

### Final Business Use

The platform can understand popular content, improve recommendations, and plan future content investment.

## Example 6: Hospital Management System

### Business Situation

A hospital management system tracks appointments, patients, doctors, billing, documents, and feedback.

### Structured Data Examples

- Appointment table
- Patient table
- Doctor table
- Billing table
- Department table

### Semi-Structured Data Examples

- Appointment booking API response
- System activity logs
- Device status messages
- Notification event data

### Unstructured Data Examples

- Scanned reports
- PDF prescriptions
- Doctor notes
- Patient feedback messages

### What a Data Engineer Does With Each Type

Structured appointment and billing data can be used in operational dashboards. Semi-structured logs can be parsed for system monitoring. Unstructured documents can be stored securely and connected with patient or appointment metadata.

### Final Business Use

The hospital can improve scheduling, track department demand, manage billing, and support better patient service.

