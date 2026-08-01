# v0.1.1 Known Issues

- Windows physical audio output has been manually verified and is no longer a
  known issue.
- CI validates real silent decode; manual Windows output verification is
  recorded in `manual-audio-test.md`.
- FFmpeg-derived compressed fixture coverage is optional; core WAV is required.
- Bundled libmpv/FFmpeg licensing obligations depend on binary build configuration.
- Android, library indexing, lyrics, video, and DSP remain intentionally unsupported.
