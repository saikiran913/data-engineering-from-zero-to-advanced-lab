# Configure a Small Python Data Pipeline Safely

Run from `day-068-python-configuration-management/`. First check `python --version` for Python 3.9 or newer; on Windows, `py --version` and `py scripts/01_configuration_sources.py` are alternatives. These examples use only the standard library.

Inspect [app_config.json](sample-config/app_config.json) and [pipeline_settings.ini](sample-config/pipeline_settings.ini). Both contain synthetic settings, not records or secrets. Then run in order:

```bash
python scripts/01_configuration_sources.py
python scripts/02_environment_variables.py
python scripts/03_read_json_config.py
python scripts/04_read_ini_config.py
python scripts/05_precedence_and_validation.py
python scripts/06_pipeline_configuration_workflow.py
```

| Step | Observe or try | Check your explanation |
|---|---|---|
| 1 | Script 01's three chosen sources | Which setting won each priority contest? |
| 2 | Script 02's real lookup note | Why is only presence reported, not a fixed value? |
| 3 | Script 02's simulated `"25"` and `"false"` | What are their raw and parsed types? |
| 4 | Missing and empty examples | Why are `None` and `""` different? |
| 5 | Script 03's JSON types | Why is JSON `true` already a bool? |
| 6 | Script 04's typed getters | Why check `read()` first? |
| 7 | Script 05's precedence output | Why does `"false"` override file `True`? |
| 8 | Script 05's controlled bad size | Why is the override rejected instead of ignored? |
| 9 | Script 06's five received records | Reconcile processed, accepted, rejected, deferred |

For optional practice, change a **simulated dictionary entry in a script**, not the host environment or bundled files. Try `DAY068_BATCH_SIZE="2"` in script 06 and predict the summary. Try a simulated invalid size in script 05 and observe the caught `ValueError`. Then restore the examples. Check that a missing or whitespace-only `source_name` would fail validation. No actual secret is needed at any stage.

The scripts only read the two bundled config fixtures; they do not write files, alter `os.environ`, call services, or access records outside memory. Explain that separation and the role of `Path(__file__)` before continuing.

## Completion Check

- I can explain environment text versus parsed Python types.
- I can say which of defaults, file, and approved override wins.
- I can reject an invalid explicit value without a secret leak.
- I can name a required setting and a safe optional default.
- I can reconcile the final pipeline's counts without relying on logs alone.
