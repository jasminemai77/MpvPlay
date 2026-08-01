import 'package:drift/drift.dart';

class Genres extends Table {
  IntColumn get rowId => integer().autoIncrement()();
  TextColumn get publicId => text().unique()();
  TextColumn get name => text()();
  TextColumn get identityKey => text().unique()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
