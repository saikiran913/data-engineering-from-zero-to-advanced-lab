import csv
import json

def read_records(path):
    with path.open("r", encoding="utf-8", newline="") as file:
        return list(csv.DictReader(file))

def read_config(path):
    with path.open("r", encoding="utf-8") as file:
        return json.load(file)
