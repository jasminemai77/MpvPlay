# MpvPlay

MpvPlay is an open-source Flutter music player for Windows. v0.4 adds a
runtime-owned editable queue, repeat modes, deterministic-cycle shuffle, and
session restore on top of the local media library and playback history.

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

`PlaybackRuntime` is the only authority for queue entries, actual play order,
current entry, shuffle/repeat policy, and observed playback state. UI renders
`PlaybackSnapshot` and sends `PlaybackCommand`; it neither keeps a
playback-state copy nor imports `media_kit`. `media_kit` appears only in
`packages/playback_engine_mpv`.

The App-layer history observer records the first `playing` snapshot of a
library-track cycle through `MediaLibraryFacade`. It does not feed data back to
PlaybackRuntime; recent history and count data stay in Drift/SQLite.

Run core tests with `dart test packages/playback_runtime` and widget tests with `flutter test apps/player_app`.
Run media-library tests with `dart test packages/media_library`.
