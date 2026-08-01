# v0.2 Test Report

The media-library suite verifies physical Schema v1, foreign keys, constraints,
FTS, migrations, artwork deduplication, path overlap, incremental scan states,
cancellation, unavailable-root, enumeration-error, and database-finalization
Missing Finalization safety. It also verifies active-generation exclusion,
File ID rename preservation, repeated-identity hard-link candidate protection,
File-ID failure fallback, metadata failure fallback, relation persistence, and
real WAV/MP3/FLAC/M4A/OGG/Opus parsing.

The MP3 fixture is deterministically generated with title, artist, album, and
genre tags. Compressed fixture generation is permitted to be skipped only when
FFmpeg is unavailable; CI reports that reason.

The media-library suite runs from `packages/media_library` in Windows CI so
the sqlite3 package's native build hook resolves its SQLite asset. The root
workspace command does not activate that asset on a fresh Windows runner.
