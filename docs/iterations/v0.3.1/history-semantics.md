# Playback History Semantics

A play is recorded exactly once when a library track first enters `playing` in
one playback cycle. Loading, selection, pause/resume, seek, buffering, and
duplicate snapshots do not create a new event. A different track, stop,
completion, or failure starts a later cycle. The App-layer observer owns this
observation only; PlaybackRuntime remains the source of playback state.

History uses `LibraryTrack.id` / `tracks.public_id`, never file paths. Missing
files retain history and statistics but are disabled until a scan makes them
available again. The recent event log retains at most 10,000 entries; its
per-track counts remain cumulative until Clear history atomically removes both
events and aggregates.
