# Sample Tables for Day 015

This lesson uses intentionally messy sample files so learners can practise cleaning:

1. `dirty_customers`
2. `dirty_orders`
3. `dirty_products`
4. `dirty_campaigns`
5. `cleaned_output_examples`

## dirty_customers

| Column Name | Simple Meaning | Possible Messy Issue | Cleaning Idea |
| --- | --- | --- | --- |
| customer_id | Customer ID | Usually clean | Preserve as key |
| customer_name | Customer name | Extra spaces, inconsistent case | `TRIM` |
| country | Customer country | `UK`, `U.K.`, `United Kingdom`, `uk` | `CASE`, `UPPER`, `TRIM` |
| city | Customer city | Blank or spaces | `TRIM`, `COALESCE` |
| signup_date | Signup date | Mostly clean | Preserve |
| email | Email address | Uppercase, spaces, blank | `LOWER`, `TRIM` |
| customer_status | Customer state | `Active`, `active`, blank | `CASE`, `LOWER`, `TRIM` |

## dirty_orders

| Column Name | Simple Meaning | Possible Messy Issue | Cleaning Idea |
| --- | --- | --- | --- |
| order_id | Order ID | Usually clean | Preserve |
| customer_id | Customer ID | Usually clean | Preserve |
| order_date | Order date | Mostly clean | Preserve |
| order_amount | Order value | Some blanks | Inspect and flag |
| order_status | Order state | Case and spaces | `CASE`, `LOWER`, `TRIM` |
| payment_status | Payment state | Case, spaces, blank | `CASE`, `LOWER`, `TRIM` |
| country | Order country | Inconsistent country names | `CASE`, `UPPER`, `TRIM` |

## dirty_products

| Column Name | Simple Meaning | Possible Messy Issue | Cleaning Idea |
| --- | --- | --- | --- |
| product_id | Product ID | Usually clean | Preserve |
| product_name | Product name | Extra spaces | `TRIM` |
| category | Product category | Case differences, blank | `CASE`, `LOWER`, `TRIM` |
| price | Product price | Mostly clean | Preserve |
| is_active | Active flag | `true`, `TRUE`, `Yes`, `Y`, blank | `CASE`, `LOWER`, `TRIM` |

## dirty_campaigns

| Column Name | Simple Meaning | Possible Messy Issue | Cleaning Idea |
| --- | --- | --- | --- |
| campaign_id | Campaign ID | Usually clean | Preserve |
| campaign_name | Campaign name | Extra spaces | `TRIM` |
| channel | Marketing channel | Case differences, blank | `CASE`, `LOWER`, `TRIM` |
| country | Campaign country | Inconsistent country names | `CASE`, `UPPER`, `TRIM` |
| campaign_status | Campaign state | Case differences, blank | `CASE`, `LOWER`, `TRIM` |
| budget | Campaign budget | Mostly clean | Preserve |

## cleaned_output_examples

This file shows small before-and-after cleaning examples.

| Column Name | Simple Meaning |
| --- | --- |
| source_table | Source table name |
| raw_column | Original column |
| raw_value | Dirty value |
| clean_column | Clean output column |
| clean_value | Clean result |
| cleaning_rule | Rule used |
