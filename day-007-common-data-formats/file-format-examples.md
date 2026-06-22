# Day 007 File Format Examples

## Same Customer Data in Different Formats

Customer data:

```text
customer_id: 101
customer_name: Customer A
country: India
signup_date: 2026-06-01
```

### CSV

```csv
customer_id,customer_name,country,signup_date
101,Customer A,India,2026-06-01
```

### JSON

```json
{
  "customer_id": 101,
  "customer_name": "Customer A",
  "country": "India",
  "signup_date": "2026-06-01"
}
```

### XML

```xml
<customer>
  <customer_id>101</customer_id>
  <customer_name>Customer A</customer_name>
  <country>India</country>
  <signup_date>2026-06-01</signup_date>
</customer>
```

### Conceptual Parquet Table Representation

Parquet is not normally read directly by humans. Conceptually, the data may look like a table:

| customer_id | customer_name | country | signup_date |
| --- | --- | --- | --- |
| 101 | Customer A | India | 2026-06-01 |

Behind the scenes, Parquet stores data efficiently by columns.

### Conceptual Avro-Style Schema and Record

Simplified schema idea:

```text
customer_id: integer
customer_name: string
country: string
signup_date: string
```

Sample record:

```text
101, Customer A, India, 2026-06-01
```

Avro is usually read and written through tools and pipelines.

## CSV Example

```csv
customer_id,customer_name,country
101,Customer A,India
102,Customer B,UK
103,Customer C,USA
```

- Header: first row with column names.
- Delimiter: comma separating values.
- Row: one full record.
- Column: one field such as `country`.

Common issue: a value like `"London, UK"` contains a comma, so it must be handled carefully.

## JSON Example

Simple JSON object:

```json
{
  "customer_id": 101,
  "country": "India"
}
```

Nested JSON object:

```json
{
  "order_id": 5001,
  "customer": {
    "customer_id": 101,
    "country": "India"
  },
  "items": [
    {
      "product_id": "P100",
      "quantity": 2
    }
  ]
}
```

- Key: field name, such as `order_id`.
- Value: data stored for a key, such as `5001`.
- Object: data inside `{ }`.
- Array: list inside `[ ]`.
- Nesting: one object or array inside another.

## XML Example

```xml
<order>
  <order_id>5001</order_id>
  <customer_id>101</customer_id>
  <amount>2500</amount>
</order>
```

- Tag: labelled part of XML.
- Opening tag: `<order_id>`.
- Closing tag: `</order_id>`.
- Nested tag: a tag inside another tag.

## Parquet Conceptual Example

Do not try to display a binary Parquet file directly.

Conceptual table:

| order_id | country | sales_amount |
| --- | --- | --- |
| 5001 | India | 2500 |
| 5002 | UK | 1800 |
| 5003 | India | 3200 |

Parquet stores data efficiently by columns, which helps analytical queries read only the required columns.

## Avro Conceptual Example

Simplified schema-style explanation:

```text
record: order_event
fields:
  order_id: integer
  customer_id: integer
  amount: number
  event_time: string
```

Sample record:

```text
order_id = 5001
customer_id = 101
amount = 2500
event_time = 2026-06-22 10:15:30
```

Avro is usually handled through data tools and pipelines, not manual editing.

## Same Order Data in Multiple Formats

### CSV

```csv
order_id,customer_id,amount
5001,101,2500
```

### JSON

```json
{
  "order_id": 5001,
  "customer_id": 101,
  "amount": 2500
}
```

### XML

```xml
<order>
  <order_id>5001</order_id>
  <customer_id>101</customer_id>
  <amount>2500</amount>
</order>
```

CSV is easiest for simple human viewing. JSON is flexible for applications. XML is useful when a system expects tagged data.

