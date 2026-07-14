# Practice Questions

Use the sample tables and SQL files to answer these questions. Keep your answers beginner-friendly and use `SELECT`-based thinking.

## 1. CASE Basics

1. What does a `CASE` expression do?
2. What is the purpose of `WHEN`?
3. What is the purpose of `THEN`?
4. Why is `ELSE` useful?
5. Which keyword closes a `CASE` expression?

## 2. Cleaning Values

1. Why might `active`, ` Active `, and `ACTIVE` cause reporting problems?
2. Which function removes extra spaces?
3. Which function can make text lowercase before comparison?
4. Why should unknown values be labelled clearly?
5. What is one example of country standardisation?

## 3. Derived Columns

1. What is a derived column?
2. Does a derived column change the source table?
3. Give one example of an order value band.
4. Give one example of a product price band.
5. Why are aliases important for derived columns?

## 4. Business-Ready Outputs

1. What makes an output business-ready?
2. Why should column names be clear?
3. Why might a dashboard prefer `Premium` instead of a raw number only?
4. What is the difference between a clean column and a business column?
5. Why should business rules be documented?

## 5. Customer Table Practice

1. Write a rule that turns `yes`, `Y`, and `true` into `true`.
2. Write a rule that turns blank or unexpected customer status values into `Unknown`.
3. Which raw column would you clean to create `clean_email`?
4. Why might you keep both `raw_country` and `clean_country` in a review output?
5. What value should `U.K.` become in this lesson?

## 6. Order Table Practice

1. Which column can be used to create an order value band?
2. What label could you give an order amount of 650?
3. What label could you give a failed payment?
4. Why should `NULL` order amounts get their own label?
5. What is one possible order health label?

## 7. Product and Campaign Practice

1. Which product column can be used to create a price band?
2. Which product column can be standardised into `true`, `false`, or `unknown`?
3. Which campaign column can be standardised into `Search`, `Social`, or `Email`?
4. Which campaign column can be used to create a budget band?
5. Why should campaign status values be standardised?

## 8. Performance Practice

1. Which two columns can help create a performance label?
2. What label could be used when revenue is greater than cost?
3. What label could be used when revenue is zero?
4. Which column can help create a conversion label?
5. Why is a conversion label useful?

## 9. Answer Key

1. `CASE` returns a value based on conditions.
2. `WHEN` defines a condition to test.
3. `THEN` defines the result for a matching condition.
4. `ELSE` gives a fallback when no condition matches.
5. `END` closes a `CASE` expression.
6. They look different to SQL unless cleaned.
7. `TRIM` removes extra spaces.
8. `LOWER` can make text lowercase.
9. Unknown labels make data quality issues visible.
10. `UK`, `U.K.`, and `United Kingdom` can become `UK`.
11. A derived column is a new output column created from existing columns.
12. No, it only appears in the query result.
13. `Premium` is one possible order value band.
14. `Medium` is one possible product price band.
15. Aliases give derived columns readable names.
16. A business-ready output has clean values, clear labels, and useful column names.
17. Clear names help non-technical readers understand the output.
18. `Premium` is faster to scan than a raw number by itself.
19. A clean column standardises data; a business column adds meaning.
20. Documentation helps people trust and maintain rules.
21. Use `CASE WHEN LOWER(TRIM(marketing_opt_in)) IN ('yes','y','true') THEN 'true' ... END`.
22. Use `ELSE 'Unknown'`.
23. Use the `email` column.
24. It helps reviewers compare the source value with the cleaned result.
25. `U.K.` should become `UK`.
26. Use `order_amount`.
27. `Premium`.
28. `Payment Issue`.
29. Missing amounts should not be hidden inside another band.
30. `Healthy`, `Needs Review`, or `Payment Issue`.
31. Use `price`.
32. Use `is_active`.
33. Use `channel`.
34. Use `budget`.
35. Standardised statuses make campaign reporting consistent.
36. `cost` and `revenue`.
37. `Profitable`.
38. `No Revenue`.
39. `conversions`.
40. It makes campaign performance easier to scan.
