# v0.1 Known Issues

- Real-media decode and output tests need manually supplied, licensed fixture files. This keeps the release gate at `ACCEPTED_WITH_RISK`.
- media_kit exposes completion without a source token. The adapter tags events with its active generation and Runtime discards stale generations; a native per-source completion token would make this boundary stronger.
- Session persistence intentionally stores only URIs and filename titles. It is not a media library or metadata store.
- Logging is append-only and local; rotation is deferred.
- Windows is the only implemented platform.

## Version Gate

`ACCEPTED_WITH_RISK`: the core loop, architecture checks, automated tests, release build, and startup smoke test pass. Real-media playback verification is the outstanding, documented release risk.
