# MpvPlay v0.5 scope

v0.5 delivers durable application settings and local library-root management.
It includes theme and scan preferences, directory addition, scan/cancel
controls, reachability and scan-result presentation, and first-use guidance.

The media-library schema remains v3. Drift/SQLite continues to be the durable
library authority; `LibraryScanCoordinator` remains the transient scan-state
authority; PlaybackRuntime remains the playback authority.

Excluded: Android, SMTC, tray integration, lyrics, EQ/DSP, online music,
dynamic plugins, and logical Track identities with multiple file locations.
