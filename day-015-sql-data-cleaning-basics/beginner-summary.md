# Beginner Summary

Data cleaning means preparing messy data so it becomes easier to use, trust, and report. Raw data often comes from forms, CSV files, APIs, older systems, or manual entry. Because of this, raw values may contain extra spaces, inconsistent capitalization, missing fields, blank strings, and different labels for the same meaning. For example, one source may send `UK`, another may send `U.K.`, and another may send `United Kingdom`.

A key idea in data engineering is that raw data should usually be preserved. Data engineers often keep a raw layer with the original data, a clean layer with standardised values, and a business layer for dashboards and reports. Preserving raw data helps auditing, debugging, and reprocessing if cleaning rules change later.

Day 015 focuses on `SELECT`-based cleaning. This means the queries create cleaned output columns but do not modify the source table. The lesson does not use `UPDATE`, `DELETE`, or `INSERT`. This is safer for beginners and reflects how many ELT pipelines work: load raw data first, then transform it into cleaner outputs.

One important distinction is `NULL` versus blank versus `Unknown`. `NULL` means the database value is missing. A blank string is a text value that looks empty, such as `''` or spaces. `Unknown` is a label that a cleaning rule may create for readability. These are not always the same, and different SQL tools may load blank CSV fields differently.

`TRIM` removes leading and trailing spaces. This is useful for names, emails, countries, statuses, product names, and campaign names. Extra spaces can break filters, create messy grouped summaries, and make values look duplicated.

`LOWER` converts text to lowercase. It is commonly used for emails, such as changing `STUDENT@EMAIL.COM` to `student@email.com`. `UPPER` converts text to uppercase and is useful for short codes such as country codes.

`COALESCE` helps with `NULL` handling by returning the first non-`NULL` value from a list. For example, `COALESCE(city, 'Unknown')` can show `Unknown` when city is missing. However, replacement values need business context. Not every missing value should be hidden with `Unknown`.

Aliases with `AS` create clean output column names. For example, `TRIM(customer_name) AS clean_customer_name` makes the result easier to understand. Clean output names help analysts, dashboards, and future data engineers.

Simple `CASE` expressions can standardise known dirty values. A `CASE` rule can map `uk`, `U.K.`, and `United Kingdom` to `UK`, or map `active`, `ACTIVE`, and `Active` to `Active`. Day 015 uses `CASE` only for beginner cleaning rules.

Cleaning before `GROUP BY` is important because dirty values split summaries. Without cleaning, `UK`, `uk`, and `United Kingdom` may become separate groups. Cleaning before joins also matters because extra spaces or inconsistent values can reduce matches.

Common beginner mistakes include changing raw data too early, replacing missing values without approval, forgetting to trim before comparison, hiding data quality problems, using unclear column names, and failing to document rules. Before Day 016, remember that good cleaning is careful, documented, and based on business meaning.

Cleaned columns also make later SQL work easier. If a dashboard groups by country, clean country values prevent the same place from appearing under several labels. If a pipeline joins datasets using text values or IDs, extra spaces and inconsistent case can reduce matches. If analysts filter by status, standard labels like `Active`, `Pending`, and `Blocked` make filters easier to trust. A good cleaning query should be readable, should keep enough raw context for review, and should make the cleaning rule clear from the alias name. Cleaning is not about making data look perfect. It is about making data more consistent while still being honest about what is missing, uncertain, or suspicious. Accuracy matters too.
