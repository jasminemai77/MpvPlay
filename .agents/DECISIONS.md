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

## D-005: v0.2 Drift runtime starts without drift_dev

The current Flutter SDK pins an analyzer version incompatible with drift_dev
2.34.3. Drift and sqlite3 runtime dependencies remain fixed as reviewed; v0.2
uses explicit schema/query code until the SDK/codegen compatibility can be
resolved without destabilizing the workspace.

## RESOLVED: Drift codegen compatibility

Attempted on 2026-08-01: Drift 2.32.1, drift_dev 2.32.1, build_runner 2.13.1,
analyzer 12.1.0, sqlite3 3.5.0, Flutter/Dart workspace SDK 3.44.8/3.12.2.
`dart run build_runner build` initially failed because sqlparser 0.44.6's
DartPlaceholder has no `when` method. Pinning sqlparser 0.44.5 resolved the
issue: Drift generation and the in-memory LibraryRoots database test pass.
No Flutter SDK upgrade, raw sqlite3 replacement, or permanent hand-written
Drift approach was used.
