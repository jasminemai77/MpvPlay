# Changelog

## 0.1.1

- Added deterministic original test audio and real libmpv silent integration tests.
- Added adapter-local null audio output configuration for CI.
- Added Windows GitHub Actions validation and release artifact workflow.
- Split application bootstrap, providers, app shell, and player presentation.

## 0.1.0

- Windows local multi-file import and libmpv-backed playback.
- Play, pause, stop, previous/next, queue selection, seek, volume, and mute.
- Runtime state machine with serialized commands, revisions, generation-based stale-event filtering, failure recovery, and queue completion.
- JSON queue/session restoration and path-free local JSONL diagnostics.
