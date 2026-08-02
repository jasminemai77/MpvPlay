# Changelog

## 0.3.1 (unreleased)

- Added durable recent playback history and cumulative per-track play counts.
- Added Schema v3 with tested v2-to-v3 and v1-to-v2-to-v3 migrations.
- Added App-layer playback-start observation and History replay/clear UI.

## 0.3.0 (unreleased)

- Added persistent favorite tracks and flat user playlists.
- Added Schema v2 with a tested v1-to-v2 migration and ordered playlist items.
- Added Favorites and Playlists UI with playback through LibraryPlaybackMapper.

## 0.2.0 (unreleased)

- Added Drift/SQLite local-media library Schema v1 and migration baseline.
- Added scan safety, FTS, metadata parsing, artist/album/genre relations, and
  Windows File ID rename preservation.
- Added local-library UI and library-to-playback mapping.

## 0.1.1

- Added deterministic original test audio and real libmpv silent integration tests.
- Added adapter-local null audio output configuration for CI.
- Added Windows GitHub Actions validation and release artifact workflow.
- Split application bootstrap, providers, app shell, and player presentation.
- Completed Windows physical-audio verification and accepted the v0.1.1 Gate.

## 0.1.0

- Windows local multi-file import and libmpv-backed playback.
- Play, pause, stop, previous/next, queue selection, seek, volume, and mute.
- Runtime state machine with serialized commands, revisions, generation-based stale-event filtering, failure recovery, and queue completion.
- JSON queue/session restoration and path-free local JSONL diagnostics.
