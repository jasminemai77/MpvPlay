# v0.1.1 Test Report

Gate: `ACCEPTED`

Windows CI completed successfully for PR #1 at head `b25dde48`. Automated real
libmpv decoding passed with null audio output, and the final Windows manual
audio verification passed.

- `dart test packages/playback_runtime packages/platform_bridge packages/playback_engine_mpv`: **20 passed**.
- Real-engine coverage: legal WAV duration, progression, pause, seek, stop,
  completion, random/corrupt input recovery, missing-file Runtime mapping, and disposal.
- Required fixture SHA-256 values: `tone-440hz.wav`
  `05d7bb1ac4d56960bb48419b3791013a17b25ab8958df7f26e5c3101b3bd4bc2`;
  `short-tone.wav` `b8b9f29ce4dc3a3d704a1aa543efdb0dc8b0f5d394f902eb564aaee1d8b092f9`.

- GitHub Actions passed fixture generation, formatting, static analysis, runtime
  and platform tests, real libmpv decoding and recovery, widget testing, and
  the Windows Release build.
- Manual Windows verification passed: audible 440 Hz output, stereo channels,
  pause/resume, mute/volume, Stop, clean application exit, and no autoplay on
  restart.
