import 'package:drift/drift.dart';

@TableIndex(name: 'user_playlists_updated_at', columns: {#updatedAt})
class UserPlaylists extends Table {
  IntColumn get rowId => integer().autoIncrement()();
  TextColumn get publicId => text().unique()();
  TextColumn get name => text()();
  TextColumn get normalizedName => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<String> get customConstraints => const [
    "CHECK (length(trim(name)) > 0)",
    "CHECK (length(trim(normalized_name)) > 0)",
  ];
}
