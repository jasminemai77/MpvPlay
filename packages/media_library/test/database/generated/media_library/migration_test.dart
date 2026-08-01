// dart format width=80
// ignore_for_file: unused_local_variable, unused_import
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:media_library/src/infrastructure/database/media_library_database.dart';
import 'package:test/test.dart';
import 'generated/schema.dart';

import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('simple database migrations', () {
    // These simple tests verify all possible schema updates with a simple (no
    // data) migration. This is a quick way to ensure that written database
    // migrations properly alter the schema.
    const versions = GeneratedHelper.versions;
    for (final (i, fromVersion) in versions.indexed) {
      group('from $fromVersion', () {
        for (final toVersion in versions.skip(i + 1)) {
          test('to $toVersion', () async {
            final schema = await verifier.schemaAt(fromVersion);
            final db = MediaLibraryDatabase(schema.newConnection());
            await verifier.migrateAndValidate(db, toVersion);
            await db.close();
          });
        }
      });
    }
  });

  // The following template shows how to write tests ensuring your migrations
  // preserve existing data.
  // Testing this can be useful for migrations that change existing columns
  // (e.g. by alterating their type or constraints). Migrations that only add
  // tables or columns typically don't need these advanced tests. For more
  // information, see https://drift.simonbinder.eu/migrations/tests/#verifying-data-integrity
  // TODO: This generated template shows how these tests could be written. Adopt
  // it to your own needs when testing migrations with data integrity.
  test('migration from v1 to v2 does not corrupt data', () async {
    // Add data to insert into the old database, and the expected rows after the
    // migration.
    // TODO: Fill these lists
    final oldTrackSearchFtsData = <v1.TrackSearchFtsData>[];
    final expectedNewTrackSearchFtsData = <v2.TrackSearchFtsData>[];

    final oldLibraryRootsData = <v1.LibraryRootsData>[];
    final expectedNewLibraryRootsData = <v2.LibraryRootsData>[];

    final oldScanRunsData = <v1.ScanRunsData>[];
    final expectedNewScanRunsData = <v2.ScanRunsData>[];

    final oldMediaFilesData = <v1.MediaFilesData>[];
    final expectedNewMediaFilesData = <v2.MediaFilesData>[];

    final oldArtworkAssetsData = <v1.ArtworkAssetsData>[];
    final expectedNewArtworkAssetsData = <v2.ArtworkAssetsData>[];

    final oldArtistsData = <v1.ArtistsData>[];
    final expectedNewArtistsData = <v2.ArtistsData>[];

    final oldAlbumsData = <v1.AlbumsData>[];
    final expectedNewAlbumsData = <v2.AlbumsData>[];

    final oldTracksData = <v1.TracksData>[];
    final expectedNewTracksData = <v2.TracksData>[];

    final oldTrackArtistsData = <v1.TrackArtistsData>[];
    final expectedNewTrackArtistsData = <v2.TrackArtistsData>[];

    final oldGenresData = <v1.GenresData>[];
    final expectedNewGenresData = <v2.GenresData>[];

    final oldTrackGenresData = <v1.TrackGenresData>[];
    final expectedNewTrackGenresData = <v2.TrackGenresData>[];

    await verifier.testWithDataIntegrity(
      oldVersion: 1,
      newVersion: 2,
      createOld: v1.DatabaseAtV1.new,
      createNew: v2.DatabaseAtV2.new,
      openTestedDatabase: MediaLibraryDatabase.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.trackSearchFts, oldTrackSearchFtsData);
        batch.insertAll(oldDb.libraryRoots, oldLibraryRootsData);
        batch.insertAll(oldDb.scanRuns, oldScanRunsData);
        batch.insertAll(oldDb.mediaFiles, oldMediaFilesData);
        batch.insertAll(oldDb.artworkAssets, oldArtworkAssetsData);
        batch.insertAll(oldDb.artists, oldArtistsData);
        batch.insertAll(oldDb.albums, oldAlbumsData);
        batch.insertAll(oldDb.tracks, oldTracksData);
        batch.insertAll(oldDb.trackArtists, oldTrackArtistsData);
        batch.insertAll(oldDb.genres, oldGenresData);
        batch.insertAll(oldDb.trackGenres, oldTrackGenresData);
      },
      validateItems: (newDb) async {
        expect(
          expectedNewTrackSearchFtsData,
          await newDb.select(newDb.trackSearchFts).get(),
        );
        expect(
          expectedNewLibraryRootsData,
          await newDb.select(newDb.libraryRoots).get(),
        );
        expect(
          expectedNewScanRunsData,
          await newDb.select(newDb.scanRuns).get(),
        );
        expect(
          expectedNewMediaFilesData,
          await newDb.select(newDb.mediaFiles).get(),
        );
        expect(
          expectedNewArtworkAssetsData,
          await newDb.select(newDb.artworkAssets).get(),
        );
        expect(expectedNewArtistsData, await newDb.select(newDb.artists).get());
        expect(expectedNewAlbumsData, await newDb.select(newDb.albums).get());
        expect(expectedNewTracksData, await newDb.select(newDb.tracks).get());
        expect(
          expectedNewTrackArtistsData,
          await newDb.select(newDb.trackArtists).get(),
        );
        expect(expectedNewGenresData, await newDb.select(newDb.genres).get());
        expect(
          expectedNewTrackGenresData,
          await newDb.select(newDb.trackGenres).get(),
        );
      },
    );
  });
}
