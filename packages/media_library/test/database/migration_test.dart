import 'dart:convert';
import 'dart:io';

import 'package:media_library/src/infrastructure/database/database_connection.dart';
import 'package:media_library/src/infrastructure/database/media_library_database.dart';
import 'package:test/test.dart';

void main() {
  test(
    'version one schema snapshot exists and opens as a new database',
    () async {
      final candidates = [
        File('drift_schemas/drift_schema_v1.json'),
        File('packages/media_library/drift_schemas/drift_schema_v1.json'),
      ];
      final snapshot = candidates.firstWhere(
        (file) => file.existsSync(),
        orElse: () => candidates.first,
      );
      expect(await snapshot.exists(), isTrue);
      final schema =
          jsonDecode(await snapshot.readAsString()) as Map<String, dynamic>;
      expect(schema['entities'], isNotEmpty);
      final database = MediaLibraryDatabase(openInMemoryMediaLibraryDatabase());
      addTearDown(database.close);
      expect(database.schemaVersion, 1);
    },
  );
}
