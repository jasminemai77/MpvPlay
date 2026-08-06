# v0.6 Known Issues

## System media seek input

The selected `smtc_windows` Dart wrapper exposes playback-position updates but
does not expose a seek-request event on `SMTCWindows`. MpvPlay therefore
declares `supportsSystemSeekRequest == false` for the current adapter. The
timeline position and duration are still synchronized to Windows; no polling,
FastForward/Rewind emulation, or fabricated `Seek` command is used.

This is an adapter capability limitation and does not change the frozen
`PlaybackRuntime` authority boundary. A future adapter can implement seek
input without changing Runtime ownership.
