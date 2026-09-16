def summary(results):
    return f"PASS={results.count('PASS')} REVIEW={results.count('REVIEW')} FAIL={results.count('FAIL')}"
