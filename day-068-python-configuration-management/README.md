# Day 068 — Python Configuration Management: Environment Variables, Config Files, and Safe Defaults

## Learning Goal

Learn to keep pipeline settings separate from record-processing logic. You will read known sources, apply a documented priority, convert text to the intended types, reject invalid settings, and pass trusted configuration into functions. A configuration error is different from an invalid business record.

## Connection to Earlier Days

Day 059 introduced paths and JSON; Day 060 introduced exceptions; Day 061 covered careful file reading; Day 062 separated pure functions from side effects; Day 065 introduced dataclasses; Day 066 documented function contracts; and Day 067 added safe logging. Day 068 combines those ideas into a small read-only configuration workflow.

Hard-coding a batch size in several processing functions makes changes difficult to reason about. A single configuration contract says where that setting comes from, its type, its allowed range, and who can override it. Source records remain business data; they are not settings.

## First Look

```python
import os
mode = os.getenv("DAY068_MODE", "development")  # Harmless optional default
raw_size = os.getenv("DAY068_BATCH_SIZE")  # A string or None
```

```python
import json
from pathlib import Path

with Path("sample-config/app_config.json").open("r", encoding="utf-8") as file:
    settings = json.load(file)
```

```python
import configparser

parser = configparser.ConfigParser()
read_paths = parser.read("sample-config/pipeline_settings.ini", encoding="utf-8")
if read_paths:
    batch_size = parser.getint("pipeline", "batch_size")
```

These relative paths assume you run from this lesson folder. The runnable scripts use a path derived from `__file__` instead. The teaching priority is **code defaults → config file → environment overrides**; later sources replace only keys they explicitly supply. Parse and validate the final values.

## Safety Rules

> Environment variables are strings. Values such as `"false"` and `"0"` are non-empty strings, so `bool("false")` is `True`; parse Boolean and numeric settings explicitly.

> Safe defaults are appropriate for non-sensitive, optional settings. Required secrets, credentials, and security-critical settings should not silently fall back to hard-coded or insecure values.

> Configuration precedence must be predictable and documented. Changing a setting in the environment should not silently conflict with a config-file value without a known override rule.

> Never commit a real `.env` file or put secrets in examples, console output, error messages, or logs. A file named `.env` is not automatically loaded by Python's standard library.

This lesson uses standard-library modules only. Its scripts read only the two bundled synthetic config files, never write files or modify environment variables, and never contact a network, database, or cloud service. They use no real credentials.

## Learning Order

Read the guides in the order below, then run scripts `01` through `06`, complete the lab, and use the questions to check your understanding.

| Resource | Focus |
|---|---|
| [Revision notes](notes.md) | End-to-end model |
| [Configuration sources](configuration-sources.md) | Defaults, environment, JSON, INI |
| [Environment variables](environment-variables.md) | Process variables and text values |
| [JSON configuration](json-configuration-files.md) | File reading and shape checks |
| [INI configuration](ini-configuration-files.md) | Sections and typed getters |
| [Safe defaults](safe-defaults.md) | Optional versus required values |
| [Configuration precedence](configuration-precedence.md) | Documented overrides |
| [Parsing and validating](parsing-and-validating-config.md) | Type, choice, and bounds checks |
| [Required and optional settings](required-vs-optional-settings.md) | Setting contracts |
| [Secret handling](secret-handling.md) | Value hygiene |
| [Reusable loaders](reusable-config-loaders.md) | Separate I/O and pure logic |
| [Scripts](scripts/) | Six runnable demonstrations |
| [Practice lab](practice-lab.md) | Guided exploration |
| [Practice questions](practice-questions.md) | Exercises and full answers |
| [Cheatsheet](python-configuration-cheatsheet.md) | Quick patterns |
| [Common mistakes](common-mistakes.md) | Avoidable errors |
| [Real-world examples](real-world-examples.md) | Generic decisions |
| [Beginner summary](beginner-summary.md) | Recap |
| [Glossary](glossary.md) | Terms |
| [Troubleshooting](troubleshooting-guide.md) | Diagnostic flow |
| [Bundled examples](sample-config/README.md) | JSON and INI fixture guide |

From this folder run `python scripts/01_configuration_sources.py`, then continue through `06`. On Windows, `py` may be used instead of `python` if that is how Python is installed.

## Navigation

- Previous Day: [Day 067 — Python Logging Fundamentals](../day-067-python-logging-fundamentals/)
- Next Day: [Day 069 — Python Error Handling for Pipelines: Clear Failures, Retries, and Recoverable Errors](../day-069-python-error-handling-for-pipelines/)
- [Back to Main Learning Path](../README.md)
