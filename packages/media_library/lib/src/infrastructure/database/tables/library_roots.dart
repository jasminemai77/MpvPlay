import 'package:drift/drift.dart';

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

  @override
  List<String> get customConstraints => const [
    "CHECK (source_type = 'windowsDirectory')",
    'CHECK (scan_generation >= 0)',
  ];
}
