import 'package:drift/drift.dart';

part 'media_library_database.g.dart';

class LibraryRoots extends Table {
  IntColumn get rowId => integer().autoIncrement()();
  TextColumn get publicId => text().unique()();
  TextColumn get sourceType => text()();
  TextColumn get locator => text()();
  TextColumn get locatorKey => text()();
  TextColumn get displayName => text()();
  BoolColumn get recursive => boolean().withDefault(const Constant(true))();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
  IntColumn get scanGeneration => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastScanStartedAt => dateTime().nullable()();
  DateTimeColumn get lastScanCompletedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {sourceType, locatorKey},
  ];
}

@DriftDatabase(tables: [LibraryRoots])
final class MediaLibraryDatabase extends _$MediaLibraryDatabase {
  MediaLibraryDatabase(super.executor);
  @override
  int get schemaVersion => 1;
}
