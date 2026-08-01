# v0.3 Implementation Report

Implemented Schema v2, real v1-to-v2 migration, persistent favorites,
playlist create/rename/delete, duplicate prevention, ordered item persistence,
transactional reorder, collection providers, Favorites and Playlists pages,
and playback through the existing app-level LibraryPlaybackMapper.

No collection code depends on PlaybackRuntime, PlaybackClient, media_kit, or
Drift from Flutter UI.
