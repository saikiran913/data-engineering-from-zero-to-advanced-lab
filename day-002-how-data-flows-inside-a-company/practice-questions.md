# Day 002 Practice Questions

## Section 1: Simple Questions

1. What does data flow mean?
2. Where does data usually start in a company?
3. What does an application or website do with a user action?
4. What is an operational database used for?
5. What does data ingestion mean?
6. Why do companies keep raw data?
7. Why does raw data need cleaning?
8. What does data transformation mean?
9. What is a data warehouse used for?
10. Why do dashboards depend on good data pipelines?

## Section 2: Fill in the Flow

Fill in the missing step.

1. Customer places order -> Website -> ______ -> Data Pipeline -> Raw Storage -> Dashboard
2. Ad Click -> Marketing Platform -> API / Export File -> ______ -> Campaign Dashboard
3. Card Payment -> Payment System -> Transaction Database -> Data Pipeline -> ______ -> Risk Dashboard
4. User watches video -> Streaming App -> Activity Database -> Pipeline -> Clean Watch Data -> ______
5. Patient books appointment -> Hospital App -> Appointment Database -> ______ -> Operations Dashboard

## Section 3: Scenario-Based Questions

1. A sales dashboard shows yesterday's sales as zero, but customers placed orders yesterday. What may have gone wrong in the data flow?
2. A marketing report counts the same ad click twice. What kind of data issue is this?
3. A food delivery dashboard shows city names as `Delhi`, `delhi`, and `DELHI`. Why is this a problem?
4. A bank transaction report is delayed by three hours. How might this affect business users?
5. A source system changes a column name from `order_amount` to `amount`. Why can this break a pipeline?

## Section 4: Think Like a Data Engineer

1. If data is missing from raw storage, which part of the flow would you check first?
2. If a dashboard shows old data, what possible pipeline issues would you investigate?
3. If order amounts are stored as text, how should they be prepared for reporting?
4. If the same customer appears with different email formats, what cleaning step would help?
5. If business users want monthly revenue, what transformation might be needed?

## Section 5: Mini Assignment

Choose one app you use daily. It can be a shopping app, banking app, streaming app, learning app, food delivery app, or fitness app.

Draw a simple data flow:

```text
User Action -> App -> Database -> Pipeline -> Storage -> Dashboard -> Decision
```

Then write short answers:

- What user action creates the data?
- What data might the app capture?
- Where might the data be stored first?
- What cleaning might be needed?
- What dashboard could be created?
- What business decision could the company make?

## Answer Key

### Section 1

1. Data flow means the journey data takes from where it is created to where it is used.
2. Data usually starts with a user action or source system.
3. The application or website captures the action and saves important details.
4. An operational database supports daily business activity.
5. Data ingestion means collecting data from a source and bringing it into a data platform.
6. Companies keep raw data for backup, audit, reprocessing, debugging, and history.
7. Raw data may have missing values, duplicates, wrong formats, or other issues.
8. Data transformation means changing data into a useful business-ready structure.
9. A data warehouse stores clean, structured data for analytics and reporting.
10. Dashboards depend on pipelines because pipelines deliver the data dashboards use.

### Section 2

1. Operational Database
2. Raw Campaign Data
3. Clean Transaction Table or Raw Transaction Store
4. Watch History Dashboard or Content Dashboard
5. Data Pipeline

