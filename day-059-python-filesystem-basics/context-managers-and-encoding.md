# Context Managers and Encoding

`with` provides setup, use, and automatic cleanup for a file handle. Use `encoding="utf-8"` when reading ordinary text so the decoding rule is explicit. Bytes need decoding to become text; a mismatch can cause a decoding error. Newline characters mark line boundaries. Binary modes and alternate encodings are outside Day 059.
