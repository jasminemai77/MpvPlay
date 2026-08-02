# Decisions

## D-001: Deterministic generated media is committed

The small PCM WAV fixtures and manifest are generated from project code and
committed. This lets local development and CI run without downloading music.
Compressed derivatives are generated only when a locally installed FFmpeg is
available and are not required for the core gate.

## D-002: Silent integration tests use adapter-owned configuration

`MpvEngineConfiguration` controls whether the adapter requests mpv's `null`
audio output. The setting is private to `playback_engine_mpv`; it is not part
of domain models, runtime, UI, or a user option surface.

## D-003: CI validates decoding, not human-audible output

Windows CI runs with null output and proves real libmpv parsing, progression,
seek, completion, stop, and failure recovery. Human listening remains a
separate manual checklist.

## D-004: App split follows composition, application, presentation boundaries

Bootstrap owns runtime/session composition, Riverpod providers and command
metadata are application concerns, and widgets only render snapshots and send
commands.

## D-005: v0.2 Drift runtime starts without drift_dev (superseded)

The current Flutter SDK pins an analyzer version incompatible with drift_dev
2.34.3. Drift and sqlite3 runtime dependencies remain fixed as reviewed; v0.2
used explicit schema/query code only until the SDK/codegen compatibility could
be resolved without destabilizing the workspace. This is superseded by the
resolved toolchain decision below.

## RESOLVED: Drift codegen compatibility

Attempted on 2026-08-01: Drift 2.32.1, drift_dev 2.32.1, build_runner 2.13.1,
analyzer 12.1.0, sqlite3 3.5.0, Flutter/Dart workspace SDK 3.44.8/3.12.2.
`dart run build_runner build` initially failed because sqlparser 0.44.6's
DartPlaceholder has no `when` method. Pinning sqlparser 0.44.5 resolved the
issue: Drift generation and the in-memory LibraryRoots database test pass.
No Flutter SDK upgrade, raw sqlite3 replacement, or permanent hand-written
Drift approach was used.

## D-006: Schema Version 1 is the media-library persistence baseline

WP-03 defines all ten relational tables, physical foreign keys and indexes,
and a content-owning FTS5 trigram table in a single `MediaLibraryDatabase`.
Drift remains the authority for generated schema/query code. Production uses
one background connection with no read pool; memory tests enable foreign keys.
The generated Schema Version 1 snapshot is committed before any WP-04 DAO or
scanner work, so future schema changes require a step-by-step migration.

## D-007: Windows identity is advisory and never auto-merges rows

Windows `FILE_ID_INFO` is read only inside the filesystem infrastructure layer.
The scanner first matches root plus normalized path and only accepts a unique
platform File ID as a rename/move match. Multiple records with the same File ID
remain separate hard-link or duplicate candidates.

## D-008: audio_metadata_reader is the tag adapter

The pure-Dart `audio_metadata_reader` package supplies real WAV, MP3, FLAC,
M4A, OGG, and Opus parsing behind an internal adapter. Parser failures keep a
playable file and filename-derived title while recording `metadataState=failed`.

## D-009: Collections are media-library relations, not playback state

Favorites and user playlists are durable Drift relations keyed by internal
`tracks.row_id`. PlaybackRuntime remains the sole source of queue, current
item, state, and progress. The app-level LibraryPlaybackMapper is the only
collection-to-playback bridge.

## D-010: Playlist tracks are unique and ordered transactionally

A track can appear once per user playlist. Position values use gaps of 1024;
reorder validates the exact current track set and updates temporary positions
and final positions inside one short transaction.

## D-011: Playback history is observed in the App layer

`AppPlaybackHistoryObserver` listens to PlaybackClient snapshots and writes
only the first `playing` transition of a library-track playback cycle through
MediaLibraryFacade. PlaybackRuntime and media_library remain mutually unaware.
History events use `tracks.public_id`; a unique playback session identifier
makes persistence idempotent. Retention trims events, never cumulative counts.
