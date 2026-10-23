# Bundled Sample Configuration

`app_config.json` and `pipeline_settings.ini` contain only synthetic, non-secret settings for an in-memory order example. Day 068 scripts read these two files but never overwrite them. Neither file contains passwords, tokens, private URLs, or service identifiers.

JSON preserves numbers, Booleans, and lists as types after `json.load()`. INI text needs explicit conversion: use `getint()` for integers and `getboolean()` for Booleans. Both sources still need validation after reading.

Environment overrides in the deterministic examples are simulated with ordinary in-memory dictionaries. No `.env` file is needed or loaded. The scripts make no network, cloud, or database calls.
