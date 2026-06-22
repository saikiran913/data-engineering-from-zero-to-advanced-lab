# Day 008 Data Quality Dimensions

## What Are Data Quality Dimensions?

Data quality dimensions are categories used to describe different aspects of data quality. They help teams explain what kind of quality problem exists.

## Accuracy

Meaning: data correctly represents reality.

Example: order amount in the data should match the actual payment.

## Completeness

Meaning: required data is present.

Example: every order should have `order_id`, `customer_id`, `order_date`, and `order_amount`.

## Consistency

Meaning: data is represented the same way across systems.

Example: country should not appear as `UK`, `U.K.`, `United Kingdom`, and `Britain` in the same reporting table.

## Validity

Meaning: data follows expected rules or formats.

Example: email should contain `@` symbol.

## Uniqueness

Meaning: records that should appear once should not be duplicated.

Example: a `transaction_id` should not appear twice.

## Timeliness / Freshness

Meaning: data is available when needed.

Example: daily dashboard should be updated before business users start work.

## Integrity

Meaning: relationships between datasets are correct.

Example: every order's `customer_id` should exist in the customer table.

## Reliability

Meaning: users can trust the data repeatedly over time.

Example: the same metric should not randomly change because of unstable pipeline logic.

## Summary Table

| Dimension | Simple Meaning | Example Check |
| --- | --- | --- |
| Accuracy | Data matches reality | Order amount matches payment |
| Completeness | Required data exists | No missing `order_id` |
| Consistency | Values are represented the same way | Country values are standardized |
| Validity | Values follow expected rules | Email contains `@` |
| Uniqueness | Records are not repeated when they should be unique | `transaction_id` appears once |
| Timeliness / Freshness | Data is updated when needed | Dashboard refreshed by 8 AM |
| Integrity | Relationships are correct | Order customer exists in customer table |
| Reliability | Data is trusted over time | Metric is stable and repeatable |

