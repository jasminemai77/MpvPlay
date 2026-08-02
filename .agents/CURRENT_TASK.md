# Current Task

Version: v0.3.1
Task: Playback history
Status: IN_PROGRESS
Gate: NOT_RUN
Architecture Baseline: Media Library 2.0 + Collections Schema v2 + Playback History Schema v3
Base Commit: c29b222

Scope:
- durable playback start history and cumulative play counts
- Drift Schema v3 migration and retention
- App-layer PlaybackClient snapshot observation
- history-to-playback mapping through the existing App mapper

Forbidden:
- Android
- recommendations
- online playlists and cloud sync
- queue editing or queue-to-playlist conversion
