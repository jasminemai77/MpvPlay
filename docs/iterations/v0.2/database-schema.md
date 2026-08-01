# Media Library Schema Version 1

WP-03 establishes Drift/SQLite Schema Version 1 for the local media library.
It is persistent-library infrastructure only: it does not include DAOs,
scanning, UI, or playback mapping.

## Identity and time

The business tables `library_roots`, `scan_runs`, `media_files`,
`artwork_assets`, `artists`, `albums`, `tracks`, and `genres` use an internal
`row_id INTEGER PRIMARY KEY AUTOINCREMENT` and an externally usable,
non-null, unique `public_id`. `row_id` is for relations and must not be
exposed to UI. `public_id` is intended to hold a UUID v7.

Business timestamps are Drift `DateTimeColumn` values and are UTC by policy.
`media_files.modified_at_micros` is deliberately an integer UTC microsecond
timestamp so scan comparison retains sub-second file-system precision.

## Tables and relations

| Table | Responsibility | Important relations and constraints |
| --- | --- | --- |
| `library_roots` | Configured Windows directories | unique `(source_type, locator_key)`; `windowsDirectory`; non-negative scan generation |
| `scan_runs` | Immutable scan execution record | root cascade; unique `(root_id, generation)`; non-negative counts |
| `media_files` | Files discovered under a root | root cascade; unique `(root_id, locator_key)`; non-negative byte size and generation |
| `artwork_assets` | Cached artwork metadata only | unique content hash and relative cache path; no BLOB or absolute cache path |
| `artists` | Canonical artist identity | unique identity key; sort/name indexes |
| `albums` | Canonical album identity | artist and artwork are `SET NULL`; unique identity key |
| `tracks` | Parsed playback metadata for one media file | media file cascade; album/artwork `SET NULL`; unique media file |
| `track_artists` | Ordered artist roles | composite primary key `(track_id, artist_id, role)`; both parents cascade |
| `genres` | Canonical genre identity | unique identity key |
| `track_genres` | Ordered track genres | composite primary key `(track_id, genre_id)`; both parents cascade |

All foreign-key relations, unique constraints, non-negative counts/sizes, and
index definitions are part of the physical SQLite schema. `platform_file_id`,
`quick_fingerprint`, and `content_hash` in `media_files` are indexed but not
unique so hard links, copies, and same-content paths remain legal.

## Search

`track_search_fts` is a content-owning FTS5 virtual table using the SQLite
`trigram` tokenizer. Its implicit `rowid` matches `tracks.row_id`. Drift
generates `deleteTrackSearch`, `insertTrackSearch`, `searchTracksFts`, and
`clearTrackSearch`; callers rebuild a row by delete then insert in one
transaction. This derived index uses no external-content FTS table.

## Connection and migration baseline

`openMediaLibraryDatabase` creates one background native Drift connection,
without a read pool, and applies `WAL`, `synchronous=NORMAL`, a 5000 ms busy
timeout, and foreign-key enforcement. In-memory tests also enable foreign
keys (WAL is allowed to resolve to SQLite's memory mode).

The pinned toolchain is Flutter 3.44.8, Dart 3.12.2, Drift/drift_dev 2.32.1,
build_runner 2.13.1, sqlite3 3.5.0, analyzer 12.1.0, and sqlparser 0.44.5.
The sqlparser pin avoids the `DartPlaceholder.when` incompatibility from
0.44.6 without upgrading Flutter.

Generate and verify from `packages/media_library`:

```powershell
dart run build_runner build --delete-conflicting-outputs
dart run drift_dev schema dump lib/src/infrastructure/database/media_library_database.dart drift_schemas/
dart run drift_dev make-migrations
```

`drift_schemas/drift_schema_v1.json` is the explicit Schema Version 1
snapshot. Drift 2.32.1's `make-migrations` also writes its database-qualified
snapshot under `drift_schemas/media_library/`; both are generated baseline
artifacts for later step-by-step migrations.
