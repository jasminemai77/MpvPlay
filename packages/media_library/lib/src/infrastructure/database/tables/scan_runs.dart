import 'package:drift/drift.dart';

import 'library_roots.dart';

class ScanRuns extends Table {
  IntColumn get rowId => integer().autoIncrement()();
  TextColumn get publicId => text().unique()();
  IntColumn get rootId =>
      integer().references(LibraryRoots, #rowId, onDelete: KeyAction.cascade)();
  IntColumn get generation => integer()();
  TextColumn get status => text()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get finishedAt => dateTime().nullable()();
  IntColumn get discoveredCount => integer().withDefault(const Constant(0))();
  IntColumn get unchangedCount => integer().withDefault(const Constant(0))();
  IntColumn get parsedCount => integer().withDefault(const Constant(0))();
  IntColumn get insertedCount => integer().withDefault(const Constant(0))();
  IntColumn get updatedCount => integer().withDefault(const Constant(0))();
  IntColumn get missingCount => integer().withDefault(const Constant(0))();
  IntColumn get failedCount => integer().withDefault(const Constant(0))();
  TextColumn get failureCode => text().nullable()();
  TextColumn get failureMessage => text().nullable()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {rootId, generation},
  ];

  @override
  List<String> get customConstraints => const [
    'CHECK (generation >= 0)',
    "CHECK (status IN ('queued', 'enumerating', 'processing', 'committing', 'finalizing', 'completed', 'completedWithIssues', 'cancelled', 'failed'))",
    'CHECK (discovered_count >= 0)',
    'CHECK (unchanged_count >= 0)',
    'CHECK (parsed_count >= 0)',
    'CHECK (inserted_count >= 0)',
    'CHECK (updated_count >= 0)',
    'CHECK (missing_count >= 0)',
    'CHECK (failed_count >= 0)',
  ];
}
