# Secret Handling

A password, token, or private key is a secret; a public demo batch size is not. Source type does not change that distinction. A token stored in an environment variable is still sensitive and must not be printed, logged, or included in a broad config dump.

A `.env` file is a common convention in some projects, but `os.getenv()` does **not** automatically read it. No `.env` file or credential fixture is created here. In a real project, do not commit a real `.env`; maintain an appropriate `.gitignore` policy if such files are used. This lesson does not implement deployment secret storage.

For failures, name the setting rather than its value: `source_name must be non-empty` or, conceptually, `API_TOKEN is required`. Never include the raw value in an exception, console summary, or DEBUG log. Avoid printing the whole merged dictionary because a future field might contain a secret. The bundled JSON and INI contain only harmless synthetic settings.

> Safe defaults are appropriate for non-sensitive, optional settings. Required secrets, credentials, and security-critical settings should not silently fall back to hard-coded or insecure values.

> Never commit a real `.env` file or put secrets in examples, console output, error messages, or logs. A file named `.env` is not automatically loaded by Python's standard library.
