from pathlib import Path
from data_utils.formatters import summary
from data_utils.parsers import read_config, read_records
from data_utils.validators import validate_amount

def main():
    base_dir = Path(__file__).resolve().parent
    records = read_records(base_dir / "sample-data" / "records.csv")
    config = read_config(base_dir / "sample-data" / "config.json")
    results = [validate_amount(row["amount"]) for row in records]
    print("Source:", config.get("source_name"))
    print(summary(results))

if __name__ == "__main__":
    main()
