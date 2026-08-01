# Schema v2 Migration

Schema v2 adds `favorite_tracks`, `user_playlists`, and
`user_playlist_items`. The v1-to-v2 migration creates only these tables and
their indexes; it does not rebuild or remove existing media-library tables or
FTS data.

Relations use internal `tracks.row_id` keys. Public APIs continue to accept
and return `tracks.public_id` values. Playlist deletion cascades only to its
items. Physical Track deletion cascades favorites and playlist items, while a
Missing Track remains present and retains its relations.
