# v0.3.1 Test Report

Coverage includes v2-to-v3 and generated chained migrations, history ordering,
cumulative counts, duplicate session idempotency, Missing-track retention and
recovery, 10,000-event retention, atomic clear, cascades, and foreign-key
checks. Observer tests cover first playing, duplicate snapshots, pause/resume,
track changes, terminal cycles, failed writes, retries, and disposal waiting.

Local regression passed: 43 media-library tests, 11 PlaybackRuntime tests, 1
platform bridge test, 8 real libmpv tests, and 7 Flutter tests. A Windows
Release executable was also built locally.

Remote evidence: Windows CI run 30730216674 passed source-generation drift
checks, format, analysis, all regressions, real libmpv decoding, Flutter tests,
Windows Release, and `MpvPlay-windows-release` artifact upload.

Local regression passed: 43 media-library tests, 11 PlaybackRuntime tests, 1
platform bridge test, 8 real libmpv tests, and 7 Flutter tests. A Windows
Release executable was also built locally.
