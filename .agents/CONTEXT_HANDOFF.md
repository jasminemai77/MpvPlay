# MpvPlay Agent Context Handoff

## Project and version

MpvPlay is a Windows-first Flutter music player. v0.1.1 is complete; the
current task is v0.3 favorites and user playlists, built on the frozen Media
Library 2.0 baseline.

## Architecture

`Flutter UI -> PlaybackClient -> PlaybackRuntime -> PlaybackEngine ->
MpvPlaybackEngine -> media_kit -> libmpv`

`PlaybackRuntime` is the single authority for queue, playback state, position,
volume, mute, errors, session, revisions, and load generations. UI only sends
commands and renders snapshots. `media_kit` must remain exclusive to
`packages/playback_engine_mpv`.

## Existing capability

v0.1 provides local multi-file import, queue controls, seek, volume/mute,
completion advance, recoverable failures, JSON session restore, JSONL logs,
and Runtime unit tests.

## Stack and modules

Flutter/Dart, Riverpod, file_picker, path_provider, media_kit 1.2.6 and
media_kit_libs_windows_audio 1.0.9. Core packages are `player_core`,
`playback_protocol`, `playback_engine_api`, `playback_runtime`,
`playback_engine_mpv`, and `platform_bridge`.

## Non-negotiable rules

- Do not import media_kit outside `playback_engine_mpv`.
- Do not add another playback-state authority.
- Do not expose uncontrolled mpv options or platform types above the adapter.
- `media_library` owns Drift/SQLite data and never imports media_kit or Flutter.
- Failed, cancelled, or incomplete scans must never mark files missing.

## Current implementation state

PlaybackRuntime remains the playback authority; MediaLibraryDatabase is the
persistent library authority; LibraryScanCoordinator is the scan-state
authority. Only the app-level mapper may depend on library and playback models.
The local-library core loop is implemented: Schema v1, metadata parsing,
Windows File ID rename preservation, album/artist/genre relations, UI
browsing, FTS, and library-to-playback mapping. `AppBootstrap` owns one
database/facade/scanner and disposes them with the playback snapshot
subscription and playback client.

v0.2 is complete with Gate `ACCEPTED_WITH_RISK`. v0.3 adds favorites and user
playlists through `MediaLibraryFacade`; Drift/SQLite remains the sole durable
authority. Favorites and playlists must never store playback runtime state.
The app-level `LibraryPlaybackMapper` remains the only collection-to-playback
bridge. Missing tracks retain their relations but do not enter playback queues.
