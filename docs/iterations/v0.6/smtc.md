# v0.6 SMTC Contract

- Supported input: Play, Pause, Next, Previous and Stop.
- Synchronized output: playback status, title, artist, timeline position and
  duration; empty queues clear metadata.
- System seek input: `NOT_SUPPORTED` in v0.6 (`supportsSystemSeekRequest` is
  false). Timeline display synchronization remains enabled.
- Native initialization is best-effort. If the plugin fails, playback remains
  available and the controller stops sending updates to that port.
