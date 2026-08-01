# v0.1.1 Implementation Report

v0.1.1 closes the automated real-playback gap. `tools/test_media_generator`
creates deterministic original PCM WAV fixtures, corruption inputs, SHA-256
manifest, and optional FFmpeg derivatives. The generated core WAV files are
committed; optional compressed derivatives are ignored and regenerated locally.

`MpvEngineConfiguration` keeps null-output test setup inside
`playback_engine_mpv`. Real integration tests use the actual adapter, media_kit,
and libmpv to verify initialization, load/duration, progress, pause, seek,
stop, completion, corrupt media recovery, Runtime recovery, and disposal.

The application entry point is now limited to bootstrap. Bootstrap owns
composition/session restore; the app shell owns theme; Riverpod providers and
command metadata are application code; the player UI is presentation code.
Windows CI generates fixtures, builds a debug bundle for its libmpv DLL, runs
silent decoding tests, then builds and uploads the release.

No media-library, Android, video, lyrics, DSP, or database feature was added.
