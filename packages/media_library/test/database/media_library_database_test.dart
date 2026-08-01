import 'package:drift/native.dart';
import 'package:media_library/src/infrastructure/database/media_library_database.dart';
import 'package:test/test.dart';

void main() {
  test(
    'creates schema version one and rejects duplicate root locators',
    () async {
      final database = MediaLibraryDatabase(NativeDatabase.memory());
      addTearDown(database.close);
      final now = DateTime.now().toUtc();
      await database
          .into(database.libraryRoots)
          .insert(
            LibraryRootsCompanion.insert(
              publicId: 'root-1',
              sourceType: 'windowsDirectory',
              locator: 'C:/Music',
              locatorKey: 'c:/music',
              displayName: 'Music',
              createdAt: now,
              updatedAt: now,
            ),
          );
      expect(database.schemaVersion, 1);
      await expectLater(
        database
            .into(database.libraryRoots)
            .insert(
              LibraryRootsCompanion.insert(
                publicId: 'root-2',
                sourceType: 'windowsDirectory',
                locator: 'C:/MUSIC',
                locatorKey: 'c:/music',
                displayName: 'Duplicate',
                createdAt: now,
                updatedAt: now,
              ),
            ),
        throwsA(isA<Exception>()),
      );
    },
  );
}
