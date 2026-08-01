# v0.2 Performance Report

The first release prioritizes correctness over parallel scan throughput. It
uses one background SQLite connection, WAL, `synchronous=NORMAL`, and a 5000ms
busy timeout. A scan first collects one root's discovered entries so that
duplicate Windows File IDs (hard-link candidates) cannot be merged, then
writes rows incrementally. This has a known peak-memory cost proportional to a
root's file count. No benchmark claim is made yet; large-library benchmark data
is a follow-up before a performance Gate claim.
