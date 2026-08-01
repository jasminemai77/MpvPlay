import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

import '../database/media_library_database.dart';

/// Stores artwork bytes on disk and keeps only portable relative paths in Drift.
final class ArtworkStore {
  ArtworkStore(this._database, this._cacheRoot);
  final MediaLibraryDatabase _database;
  final Directory _cacheRoot;
  static const _uuid = Uuid();

  Future<ArtworkAsset> put(List<int> bytes, {required String mimeType}) async {
    final contentHash = sha256.convert(bytes).toString();
    final existing =
        await (_database.select(_database.artworkAssets)
              ..where((asset) => asset.contentHash.equals(contentHash)))
            .getSingleOrNull();
    if (existing != null) return existing;
    final extension = _extensionFor(mimeType);
    final relativePath = 'artwork/$contentHash.$extension';
    final target = File(
      '${_cacheRoot.path}${Platform.pathSeparator}$relativePath',
    );
    await target.parent.create(recursive: true);
    if (!await target.exists()) await target.writeAsBytes(bytes, flush: true);
    final now = DateTime.now().toUtc();
    await _database
        .into(_database.artworkAssets)
        .insert(
          ArtworkAssetsCompanion.insert(
            publicId: _uuid.v7(),
            contentHash: contentHash,
            mimeType: mimeType,
            byteLength: bytes.length,
            relativeCachePath: relativePath,
            createdAt: now,
          ),
        );
    return (_database.select(
      _database.artworkAssets,
    )..where((asset) => asset.contentHash.equals(contentHash))).getSingle();
  }

  File resolve(ArtworkAsset asset) => File(
    '${_cacheRoot.path}${Platform.pathSeparator}${asset.relativeCachePath}',
  );

  String _extensionFor(String mimeType) => switch (mimeType) {
    'image/jpeg' => 'jpg',
    'image/png' => 'png',
    'image/webp' => 'webp',
    _ => 'bin',
  };
}
