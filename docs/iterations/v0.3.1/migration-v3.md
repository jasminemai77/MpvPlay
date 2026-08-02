# Schema v3 Migration

Schema v3 creates only `playback_history_entries` and `track_playback_stats`
plus indexes for recent ordering and track history. The migration does not
rebuild or delete library, favorites, playlist, relation, or FTS tables.

`playback_history_entries.playback_session_id` is unique, which makes duplicate
snapshot writes idempotent. Both new tables reference `tracks.row_id` with
`ON DELETE CASCADE`. Tests verify real v2-to-v3 data preservation and the
generated v1-to-v2-to-v3 migration path.
