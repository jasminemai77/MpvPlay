# MpvPlay Agent Context Handoff

## Project and version

MpvPlay is a Windows-first Flutter music player. The current task is v0.1.1:
real libmpv playback verification and engineering stabilization.

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
- Keep Android, media-library, video, lyrics, DSP, and database work out of this version.

## Current risks and next work

v0.1 lacked real decoder/output verification. v0.1.1 adds deterministic audio,
silent real-engine tests, failure recovery, Windows CI, UI file split, and a
manual listening checklist. The manual audio result must never be inferred from
silent automation.
