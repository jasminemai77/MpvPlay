import 'package:drift/drift.dart';

@TableIndex(name: 'artists_sort_name', columns: {#sortName})
@TableIndex(name: 'artists_name', columns: {#name})
class Artists extends Table {
  IntColumn get rowId => integer().autoIncrement()();
  TextColumn get publicId => text().unique()();
  TextColumn get name => text()();
  TextColumn get sortName => text()();
  TextColumn get identityKey => text().unique()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
