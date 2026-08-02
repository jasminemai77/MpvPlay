# Current Task

Version: v0.4
Task: Settings and library management
Status: IN_PROGRESS
Gate: NOT_RUN
Architecture Baseline: Media Library 2.0 + Collections Schema v2 + Playback History Schema v3
Base Commit: d824f4c
Application Version: 0.5.0+6
Media Library Schema: v3 unchanged (existing library_roots.enabled)
Settings Schema: v1
Current Slice: 2

Scope:
- runtime-owned queue entry identity, play order, shuffle and repeat
- queue editing, session restore compatibility, and queue controls

Forbidden:
- Android
- recommendations
- online playlists and cloud sync
- database schema changes
