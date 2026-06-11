# Day 002 Real-World Examples

## Example 1: E-commerce Order Flow

### Business Situation

An online store wants to track daily orders, revenue, products sold, and delivery performance.

### Where Data Starts

Data starts when a customer places an order on the website or mobile app.

### What Data Is Captured

- Customer ID
- Product ID
- Order amount
- Payment status
- Order time
- Delivery address

### Where Data Is Stored First

The order is stored first in an operational orders database.

### How Data Might Be Cleaned

- Remove duplicate orders.
- Standardize order dates.
- Convert amount from text to number.
- Fix blank or invalid product IDs.

### What Transformation Might Happen

- Calculate total sales per day.
- Group orders by product category.
- Combine order data with customer data.
- Create a daily sales summary table.

### Final Dashboard or Report Use

A sales dashboard shows daily revenue, total orders, top products, and failed payments.

### Business Decision Supported

The sales team may decide to increase stock for best-selling products or investigate failed payments.

## Example 2: Bank Transaction Flow

### Business Situation

A bank wants to monitor transactions, detect unusual activity, and prepare financial reports.

### Where Data Starts

Data starts when a customer makes a card payment, ATM withdrawal, bank transfer, or online payment.

### What Data Is Captured

- Account ID
- Transaction amount
- Transaction time
- Merchant name
- Location
- Payment method
- Transaction status

### Where Data Is Stored First

The transaction is stored first in a transaction database.

### How Data Might Be Cleaned

- Remove duplicate transaction records.
- Standardize timestamps.
- Check missing account IDs.
- Make merchant names consistent.

### What Transformation Might Happen

- Group transactions by account.
- Calculate daily transaction totals.
- Mark high-value transactions.
- Prepare data for monitoring unusual activity.

### Final Dashboard or Report Use

A risk dashboard shows transaction volume, failed transactions, and unusual patterns.

### Business Decision Supported

The bank may investigate suspicious activity or improve transaction monitoring rules.

## Example 3: Marketing Ad Click Flow

### Business Situation

A marketing team runs ads on different platforms and wants to know which campaigns perform well.

### Where Data Starts

Data starts when a person sees or clicks an advertisement.

### What Data Is Captured

- Campaign name
- Ad click time
- Ad platform
- Cost
- User location
- Device type
- Signup or purchase action

### Where Data Is Stored First

The data is first stored in the marketing platform or exported through an API or file.

### How Data Might Be Cleaned

- Standardize campaign names.
- Remove test campaign data.
- Fix missing channel names.
- Convert cost values into a common format.

### What Transformation Might Happen

- Calculate cost per click.
- Calculate leads by campaign.
- Combine ad data with sales data.
- Create campaign performance tables.

### Final Dashboard or Report Use

A marketing dashboard shows clicks, cost, leads, purchases, and return on advertising spend.

### Business Decision Supported

The marketing team may increase budget for successful campaigns and stop campaigns that perform poorly.

## Example 4: Food Delivery Order Flow

### Business Situation

A food delivery app wants to track orders, delivery times, restaurant performance, and customer ratings.

### Where Data Starts

Data starts when a customer places a food order in the app.

### What Data Is Captured

- Customer ID
- Restaurant ID
- Order items
- Order time
- Payment status
- Delivery partner ID
- Delivery time
- Rating

### Where Data Is Stored First

The order is stored first in the app's operational order system.

### How Data Might Be Cleaned

- Fill missing delivery status when possible.
- Standardize restaurant names.
- Remove duplicate order events.
- Fix inconsistent city names.

### What Transformation Might Happen

- Calculate average delivery time.
- Group orders by city.
- Measure restaurant preparation time.
- Create late-delivery summary tables.

### Final Dashboard or Report Use

An operations dashboard shows order volume, late deliveries, restaurant delays, and customer ratings.

### Business Decision Supported

The operations team may improve delivery planning or work with restaurants that often delay orders.

## Example 5: Streaming Platform Watch History Flow

### Business Situation

A streaming platform wants to understand what users watch and which shows are popular.

### Where Data Starts

Data starts when a user watches a movie, episode, or short video.

### What Data Is Captured

- User ID
- Video ID
- Watch start time
- Watch duration
- Device type
- Region
- Like or rating

### Where Data Is Stored First

The activity is stored first in application logs or an operational activity database.

### How Data Might Be Cleaned

- Remove incomplete watch events.
- Standardize device names.
- Fix missing region values.
- Remove test or internal activity.

### What Transformation Might Happen

- Calculate total watch time.
- Group views by show.
- Group users by region.
- Create daily content performance summaries.

### Final Dashboard or Report Use

A content dashboard shows popular shows, total watch hours, active users, and regional trends.

### Business Decision Supported

The platform may promote popular content, improve recommendations, or plan future content investment.

## Example 6: Hospital Appointment Booking Flow

### Business Situation

A hospital wants to track appointment bookings, cancellations, department demand, and patient waiting time.

### Where Data Starts

Data starts when a patient books an appointment through a website, app, call center, or front desk.

### What Data Is Captured

- Appointment ID
- Patient ID
- Department
- Doctor ID
- Appointment date
- Booking time
- Appointment status

### Where Data Is Stored First

The appointment is stored first in the hospital appointment system.

### How Data Might Be Cleaned

- Standardize department names.
- Fix missing appointment status.
- Remove duplicate bookings.
- Standardize date and time values.

### What Transformation Might Happen

- Count appointments by department.
- Calculate cancellation rate.
- Calculate average waiting time.
- Create daily appointment summary tables.

### Final Dashboard or Report Use

A hospital operations dashboard shows appointment volume, cancellations, busy departments, and waiting time.

### Business Decision Supported

The hospital may adjust staffing, improve scheduling, or reduce patient waiting time.

