# Packages and pip

## Package

A package is reusable Python code installed for a project.

## Dependency

A dependency is a package your project needs.

## pip

Check pip:

```bash
python -m pip --version
```

List packages:

```bash
python -m pip list
```

## Why `python -m pip`

This helps align pip with the interpreter selected by `python`.

## Installing Packages Conceptually

```bash
python -m pip install <package-name>
```

Day 050 does not require any third-party package installation.

## Freeze Concept

```bash
python -m pip freeze
```

This can list installed package versions.

## Version Pinning Concept

```text
package-name==x.y.z
```

Pinning records an intended dependency version.

## Avoid Global Installs

Project dependencies should usually live in a project-specific virtual environment.

## Safety Note

Never install unknown packages blindly.
