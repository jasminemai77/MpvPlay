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
