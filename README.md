# MpvPlay

MpvPlay is an open-source Flutter music player for Windows. v0.2 adds a local
media library: persistent roots, safe incremental scans, metadata, FTS search,
albums/artists, artwork cache, and queue construction from library tracks.

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
Run media-library tests with `dart test packages/media_library`.
