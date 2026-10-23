# Model Data Records and Pipeline Components with Classes and Dataclasses

1. Verify Python with `python --version`.
2. Run `python scripts/01_class_basics.py`.
3. Run `python scripts/02_record_class.py`.
4. Run `python scripts/03_dataclass_records.py`.
5. Run `python scripts/04_configuration_dataclass.py`.
6. Run `python scripts/05_pipeline_component.py`.
7. Run `python scripts/06_data_engineering_object_workflow.py`.
8. Create two independent `DataSource` instances.
9. Change one instance's `enabled` value and confirm the other is unchanged.
10. Inspect an `OrderRecord` dataclass representation.
11. Add a tag to one `SourceConfig` and confirm the other instance's tags stay empty.
12. Compare a small dictionary record with a dataclass record.
13. Replace a proposed stateless single-method class with a function.
14. Explain why a configured normalizer is a reasonable class.

## Completion Checklist

Explain class, instance, `self`, attributes, methods, dataclass, `default_factory`, frozen configuration, class versus function, and composition. Keep the final design small and directly understandable.
