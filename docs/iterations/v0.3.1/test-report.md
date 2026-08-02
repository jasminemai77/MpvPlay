# v0.3.1 Test Report

Coverage includes v2-to-v3 and generated chained migrations, history ordering,
cumulative counts, duplicate session idempotency, Missing-track retention and
recovery, 10,000-event retention, atomic clear, cascades, and foreign-key
checks. Observer tests cover first playing, duplicate snapshots, pause/resume,
track changes, terminal cycles, failed writes, retries, and disposal waiting.
