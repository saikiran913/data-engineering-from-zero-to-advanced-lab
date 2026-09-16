"""Day 052: validation decision summaries."""

source_a_label = "source A"
source_a_record_count = 120
source_a_schema_valid = True
source_a_is_fresh = True

if source_a_record_count > 0 and source_a_schema_valid and source_a_is_fresh:
    source_a_decision = "PASS"
    source_a_reason = "rows exist, schema is valid, and source is fresh"
else:
    source_a_decision = "REVIEW"
    source_a_reason = "one or more checks need attention"

print(source_a_label)
print("decision:", source_a_decision)
print("reason:", source_a_reason)

source_b_label = "source B"
source_b_record_count = 0
source_b_schema_valid = True
source_b_is_fresh = True

if source_b_record_count == 0:
    source_b_decision = "FAIL"
    source_b_reason = "source has zero rows"
elif source_b_schema_valid and source_b_is_fresh:
    source_b_decision = "PASS"
    source_b_reason = "required checks passed"
else:
    source_b_decision = "REVIEW"
    source_b_reason = "schema or freshness needs review"

print(source_b_label)
print("decision:", source_b_decision)
print("reason:", source_b_reason)

source_c_label = "source C"
source_c_record_count = None
source_c_schema_valid = True
source_c_is_fresh = False

if source_c_record_count is None:
    source_c_decision = "REVIEW"
    source_c_reason = "row count is not available"
elif not source_c_is_fresh:
    source_c_decision = "REVIEW"
    source_c_reason = "source is late"
elif source_c_record_count > 0 and source_c_schema_valid:
    source_c_decision = "PASS"
    source_c_reason = "required checks passed"
else:
    source_c_decision = "FAIL"
    source_c_reason = "required checks failed"

print(source_c_label)
print("decision:", source_c_decision)
print("reason:", source_c_reason)
