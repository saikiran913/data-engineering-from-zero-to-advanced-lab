"""Compare safe code defaults with synthetic file and environment settings."""


def main() -> None:
    defaults = {"batch_size": 100, "mode": "development", "enabled": False}
    file_settings = {"batch_size": 50, "mode": "validation"}
    simulated_environment = {"batch_size": 25}
    merged = {**defaults, **file_settings, **simulated_environment}

    print("Source records are business data; these settings control processing.")
    print("Priority: code defaults < config file < environment override")
    print(f"batch_size={merged['batch_size']} source=simulated_environment")
    print(f"mode={merged['mode']} source=synthetic_file_settings")
    print(f"enabled={merged['enabled']} source=code_default")


if __name__ == "__main__":
    main()
