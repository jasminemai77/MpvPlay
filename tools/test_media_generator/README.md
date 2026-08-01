# Deterministic Test Media Generator

Run from the repository root:

```powershell
dart run tools/test_media_generator/generate.dart
```

The generator creates original sine, silence, and stereo test signals. It does
not download or encode a third-party musical work. If `ffmpeg` is present, it
also creates disposable compressed derivatives; otherwise that part is reported
as `SKIPPED` while the required WAV fixtures still generate.
