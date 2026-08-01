# v0.2 Scan Pipeline

The scan coordinator is the transient scan-state authority. Drift remains the
persistent-library authority and PlaybackRuntime remains the sole playback
authority.

1. Normalize the Windows root and reject overlapping roots.
2. Create a generation-scoped scan run and enumerate supported audio files.
3. Match files by `(root_id, locator_key)`, then by a unique Windows File ID,
   then by one same-root quick-fingerprint candidate not already seen in this
   generation.
4. Read tags with `audio_metadata_reader`; on a parser error retain the
   filename fallback and mark metadata `failed` without making the file
   unavailable.
5. Upsert media, track, FTS, artist, album, and genre relations.
6. Only a complete, uncancelled enumeration may perform Missing Finalization.

Windows identities have the format `windows:<volume-serial-hex>:<file-id-hex>`.
They preserve media and track public IDs across same-volume rename/move. A
non-unique identity is treated as a hard-link/duplicate candidate and is never
merged automatically.

The quick fingerprint combines file length and the SHA-256 digest of the first
64 KiB. It is a rename candidate only, never a durable content identity.
