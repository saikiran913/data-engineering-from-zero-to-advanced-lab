# Cross-Platform Setup

| Task | Linux/macOS | Windows PowerShell |
|---|---|---|
| Check Python | `python3 --version` or `python --version` | `python --version` |
| Create venv | `python3 -m venv .venv` | `python -m venv .venv` |
| Activate | `source .venv/bin/activate` | `.venv\Scripts\Activate.ps1` |
| Deactivate | `deactivate` | `deactivate` |
| Find Python | `command -v python` | `where python` |

## Command Differences

Exact setup depends on installation. Some systems use `python`; others use `python3`.

## PowerShell Activation Issue

PowerShell execution policy may block activation in some environments. Do not weaken security policy casually. Follow approved operating-system or organisation guidance.

## Git Bash and WSL

Git Bash and WSL path styles differ from native Windows paths. Verify the active interpreter after activation.
