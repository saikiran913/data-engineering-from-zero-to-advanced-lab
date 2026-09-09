# Reproducible Python Environments

## What Makes Python Setup Reproducible?

- Python version documented
- dependencies documented
- setup commands documented
- source code in Git
- `.venv` excluded from Git

## `requirements.txt`

A requirements file documents dependencies.

Day 050 example:

```text
# No third-party packages required for Day 050.
```

Future dependency syntax concept:

```text
package-name==x.y.z
```

## `.gitignore`

```text
.venv/
__pycache__/
*.pyc
```

These are local/generated artifacts, not source code.

## Environment Setup README

```text
1. Create .venv
2. Activate
3. Verify Python
4. Install requirements
5. Run script
```

## More Than Package Versions

Reproducibility can also depend on operating system, Python version, external services, configuration, and data.
