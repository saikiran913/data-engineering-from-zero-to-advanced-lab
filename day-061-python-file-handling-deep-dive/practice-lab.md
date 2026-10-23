# Practice Lab

## Goal

Build a small, safe order-file workflow using only this day's sample data.

1. Read `sample-data/orders_input.csv` with `csv.DictReader`.
2. Read `sample-data/source_config.json` with `json.load`.
3. Verify that every configured required column is present.
4. Normalise the status with `strip().upper()`.
5. Mark blank IDs and invalid or negative amounts as FAIL.
6. Mark unexpected statuses as REVIEW.
7. Write every row to `output/lab_orders_validated.csv` with status and reason columns.
8. Write `output/lab_summary.json` with total, pass, review, fail, and source filename.
9. Reopen both files and verify that they parse.

## Stretch Checks

- Print the CSV row number for every non-PASS result.
- Read `malformed_config.json` and report its parse error without using it.
- Hash `sample-data/orders_input.csv` before and after your script to prove it was not changed.

## Completion Checklist

- Inputs were opened only in read mode.
- Generated files were written only in `output/`.
- Every source row appears in the validation output.
- The summary totals equal the output row count.
