# Current Task

Version: v0.4
Task: Playback modes and queue management
Status: COMPLETED
Gate: ACCEPTED
Architecture Baseline: Media Library 2.0 + Collections Schema v2 + Playback History Schema v3
Base Commit: bfcf088
Media Library Schema: v3 unchanged

Scope:
- runtime-owned queue entry identity, play order, shuffle and repeat
- queue editing, session restore compatibility, and queue controls

Forbidden:
- Android
- recommendations
- online playlists and cloud sync
- database schema changes
