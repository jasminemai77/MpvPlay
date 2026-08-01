# MpvPlay

MpvPlay is an open-source Flutter music player for Windows. Version 0.1 implements the local-file playback loop: multi-file import, queue selection, play/pause/stop, seek, volume/mute, automatic next track, error display, local JSON session restore, and local diagnostics.

## Run

Requirements: Flutter 3.44.8 / Dart 3.12.2 or newer and the Visual Studio 2022 Windows C++ toolchain.

```powershell
flutter pub get
cd apps/player_app
flutter run -d windows
```

Build with `flutter build windows --release` from `apps/player_app`. Supported picker filters are MP3, FLAC, WAV, M4A, AAC, OGG, and Opus; decoder support is determined by bundled libmpv, not the extension.

## Architecture

`UI -> PlaybackClient -> PlaybackRuntime -> PlaybackEngine -> MpvPlaybackEngine -> media_kit/libmpv`

`PlaybackRuntime` is the only authority for the queue and observed playback state. UI renders `PlaybackSnapshot` and sends `PlaybackCommand`; it neither keeps a playback-state copy nor imports `media_kit`. `media_kit` appears only in `packages/playback_engine_mpv`.

Run core tests with `dart test packages/playback_runtime` and widget tests with `flutter test apps/player_app`.
