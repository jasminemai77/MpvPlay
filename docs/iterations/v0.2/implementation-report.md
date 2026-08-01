# v0.2 Implementation Report

Implemented: Schema v1, Drift migration snapshots, roots, SQLite persistence,
incremental scans, cancellation safety, Windows File ID and quick-fingerprint
rename handling, hard-link candidate protection, real metadata parsing, artwork cache, FTS5
search with short-query LIKE fallback, artist/album/genre relations, app
providers, local library UI, lifecycle disposal, and playback mapping.

The dependency boundary remains intact: `media_library` has no Flutter,
media_kit, or PlaybackRuntime dependency. UI does not access Drift tables or
DAOs. Only `LibraryPlaybackMapper` sees both library and playback models.
