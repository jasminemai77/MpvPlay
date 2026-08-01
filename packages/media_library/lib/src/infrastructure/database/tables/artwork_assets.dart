import 'package:drift/drift.dart';

class ArtworkAssets extends Table {
  IntColumn get rowId => integer().autoIncrement()();
  TextColumn get publicId => text().unique()();
  TextColumn get contentHash => text().unique()();
  TextColumn get mimeType => text()();
  IntColumn get byteLength => integer()();
  TextColumn get relativeCachePath => text().unique()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastAccessedAt => dateTime().nullable()();

  @override
  List<String> get customConstraints => const ['CHECK (byte_length >= 0)'];
}
