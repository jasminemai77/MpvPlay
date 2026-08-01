# Dependency inventory

## Application

- Flutter 3.44.8 and Dart 3.12.2
- Riverpod and flutter_riverpod for application composition
- file_picker and path_provider for Windows folder selection and local storage

## Playback

- media_kit and media_kit_libs_windows_audio provide the libmpv adapter only
  inside `packages/playback_engine_mpv`.

## Media library

- Drift 2.32.1 and sqlite3 3.5.0 provide the authoritative local library
  store.
- audio_metadata_reader 1.7.1 reads file tags behind the infrastructure-only
  `AudioMetadataReaderAdapter`.
- ffi 2.1.3 and win32 5.15.0 read Windows `FILE_ID_INFO` behind the
  infrastructure-only `FileIdentityProvider`.
- crypto and uuid provide artwork content identities and public IDs.

No package under `packages/media_library` depends on `media_kit`, Flutter, or
the playback runtime.
