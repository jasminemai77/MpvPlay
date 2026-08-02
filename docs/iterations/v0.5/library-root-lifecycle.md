# Library root lifecycle

Disabling a root is reversible. In one database transaction the root becomes
disabled and its media files become Missing. Tracks, their public IDs,
favorites, playlist positions, history and play counts are never physically
deleted.

Re-enabling and scanning the same root first matches the known path, then the
Windows File ID, then a unique quick fingerprint. That restores the original
media-file and Track identity where a match is available.

Schema v3 has one MediaFile per Track. Therefore `Root A/song.mp3` and
`Root B/song.mp3` are separate Tracks even if their audio content is identical.
Disabling Root A does not affect Track B and no automatic identity or relation
merge occurs.

Failed or cancelled scans never execute Missing Finalization. The coordinator
serializes scans globally; a cancellation is awaited before root disablement or
database shutdown proceeds.
