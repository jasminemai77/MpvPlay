# v0.1.1 Test Report

Automated real libmpv decoding passed on Windows with null audio output.

- `dart test packages/playback_runtime packages/platform_bridge packages/playback_engine_mpv`: **20 passed**.
- Real-engine coverage: legal WAV duration, progression, pause, seek, stop,
  completion, random/corrupt input recovery, missing-file Runtime mapping, and disposal.
- Required fixture SHA-256 values: `tone-440hz.wav`
  `05d7bb1ac4d56960bb48419b3791013a17b25ab8958df7f26e5c3101b3bd4bc2`;
  `short-tone.wav` `b8b9f29ce4dc3a3d704a1aa543efdb0dc8b0f5d394f902eb564aaee1d8b092f9`.

Full Flutter analysis, widget test, and release build are recorded after the
final refactor. CI is defined but cannot be claimed as passed until the branch
is pushed and GitHub executes it.
