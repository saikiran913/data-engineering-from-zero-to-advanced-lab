# Dependency and Consumer Guide

## Map Upstream Dependencies

List source tables, source columns, expected data types, source grain, filters, joins, and any upstream views.

## Map Downstream Consumers

List reports, dashboards, scheduled extracts, analyst queries, application reports, and downstream views that use the view.

## Identify Critical Consumers

High-sensitivity consumers may depend on exact column names, fixed exports, or important totals.

## Document Expected Grain

Write what one row represents, such as one row per order or one row per campaign-date-channel-country.

## Document Required Columns

Each consumer should have a list of columns it needs. This helps identify rename and removal risk.

## Document Critical Metrics

Critical metrics might include completed order amount, row count, spend, conversions, or issue count.

## Classify Change Sensitivity

Use simple labels such as low, medium, and high review. These are learning labels, not universal standards.

## Avoid Deep View Chains

Long chains are harder to debug. Keep dependencies shallow and documented.

## Communicate Business-Meaning Changes

If a metric keeps the same name but changes meaning, consumers can be misled.

## Reusable Dependency Template

| Item | Notes |
|---|---|
| View name |  |
| Source objects |  |
| Source columns |  |
| Output grain |  |
| Key |  |
| Downstream consumers |  |
| Required columns |  |
| Critical metrics |  |
| Sensitivity |  |
| Owner role |  |
| Known risks |  |
| Validation checks |  |
| Last reviewed date |  |
