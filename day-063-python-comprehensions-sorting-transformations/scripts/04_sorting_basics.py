"""Show new-list sorting, in-place sorting, and reverse order."""

amounts = [40, 5, 12]
ordered = sorted(amounts)
largest_first = sorted(amounts, reverse=True)
assert amounts == [40, 5, 12]

working = amounts.copy()
sort_result = working.sort()
assert sort_result is None

countries = ["UK", "India", "USA"]
print("Original amounts:", amounts)
print("Ascending:", ordered)
print("Descending:", largest_first)
print("In place:", working)
print("Country names:", sorted(countries))
