import 'package:drift/drift.dart';

import 'library_roots.dart';

@TableIndex(
  name: 'media_files_root_availability',
  columns: {#rootId, #availabilityState},
)
@TableIndex(
  name: 'media_files_root_last_seen_generation',
  columns: {#rootId, #lastSeenGeneration},
)
@TableIndex(name: 'media_files_platform_file_id', columns: {#platformFileId})
@TableIndex(name: 'media_files_quick_fingerprint', columns: {#quickFingerprint})
@TableIndex(name: 'media_files_content_hash', columns: {#contentHash})
class MediaFiles extends Table {
  IntColumn get rowId => integer().autoIncrement()();
  TextColumn get publicId => text().unique()();
  IntColumn get rootId =>
      integer().references(LibraryRoots, #rowId, onDelete: KeyAction.cascade)();
  TextColumn get locator => text()();
  TextColumn get locatorKey => text()();
  TextColumn get relativePath => text()();
  TextColumn get fileName => text()();
  TextColumn get extension => text()();
  IntColumn get sizeBytes => integer()();
  IntColumn get modifiedAtMicros => integer()();
  TextColumn get platformFileId => text().nullable()();
  TextColumn get quickFingerprint => text().nullable()();
  TextColumn get contentHash => text().nullable()();
  TextColumn get availabilityState => text()();
  TextColumn get metadataState => text()();
  IntColumn get lastSeenGeneration => integer()();
  DateTimeColumn get lastSeenAt => dateTime()();
  DateTimeColumn get missingSince => dateTime().nullable()();
  TextColumn get lastErrorCode => text().nullable()();
  TextColumn get lastErrorMessage => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {rootId, locatorKey},
  ];

  @override
  List<String> get customConstraints => const [
    'CHECK (size_bytes >= 0)',
    'CHECK (last_seen_generation >= 0)',
    "CHECK (availability_state IN ('available', 'missing', 'unreadable'))",
    "CHECK (metadata_state IN ('pending', 'ready', 'failed'))",
  ];
}
