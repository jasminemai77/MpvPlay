import 'dart:convert';
import 'dart:io';

import 'package:playback_protocol/playback_protocol.dart';
import 'package:playback_runtime/playback_runtime.dart';
import 'package:player_core/player_core.dart';

final class PersistedSession {
  const PersistedSession({
    required this.items,
    required this.currentIndex,
    required this.position,
    required this.volume,
    required this.muted,
    this.skippedItems = 0,
  });
  final List<PlayableItem> items;
  final int currentIndex;
  final Duration position;
  final double volume;
  final bool muted;
  final int skippedItems;
}

final class JsonSessionStore {
  const JsonSessionStore(this.file);
  final File file;
  static Future<void> _writeTail = Future.value();

  /// Serializes writes so frequent position snapshots cannot corrupt the file.
  Future<void> save(PlaybackSnapshot snapshot) {
    final operation = _writeTail.then((_) => _save(snapshot));
    _writeTail = operation.catchError((_) {});
    return operation;
  }

  Future<void> _save(PlaybackSnapshot snapshot) async {
    await file.parent.create(recursive: true);
    final json = <String, Object?>{
      'uris': snapshot.queueItems.map((e) => e.source.uri.toString()).toList(),
      'currentIndex': snapshot.currentIndex,
      'positionMs': snapshot.position.inMilliseconds,
      'volume': snapshot.volume,
      'muted': snapshot.muted,
    };
    // Avoid a delete-and-rename window on Windows during frequent saves.
    await file.writeAsString(jsonEncode(json), flush: true);
  }

  Future<PersistedSession?> restore() async {
    if (!await file.exists()) return null;
    try {
      final data =
          jsonDecode(await file.readAsString()) as Map<String, Object?>;
      final rawUris = (data['uris'] as List<Object?>?) ?? const [];
      final items = <PlayableItem>[];
      var skipped = 0;
      for (final value in rawUris.whereType<String>()) {
        final uri = Uri.parse(value);
        if (uri.scheme != 'file' || !await File.fromUri(uri).exists()) {
          skipped++;
          continue;
        }
        final name = File.fromUri(uri).uri.pathSegments.last;
        items.add(
          PlayableItem(
            id: value,
            title: Uri.decodeComponent(name),
            source: MediaSource(id: value, uri: uri, kind: MediaKind.audio),
          ),
        );
      }
      if (items.isEmpty) {
        return PersistedSession(
          items: const [],
          currentIndex: -1,
          position: Duration.zero,
          volume: (data['volume'] as num?)?.toDouble() ?? 1,
          muted: data['muted'] as bool? ?? false,
          skippedItems: skipped,
        );
      }
      final rawIndex = (data['currentIndex'] as num?)?.toInt() ?? 0;
      return PersistedSession(
        items: items,
        currentIndex: rawIndex.clamp(0, items.length - 1),
        position: Duration(
          milliseconds: (data['positionMs'] as num?)?.toInt() ?? 0,
        ),
        volume: ((data['volume'] as num?)?.toDouble() ?? 1).clamp(0, 1),
        muted: data['muted'] as bool? ?? false,
        skippedItems: skipped,
      );
    } catch (_) {
      return null;
    }
  }
}

/// Append-only local diagnostics. Paths are deliberately never recorded.
final class JsonLinePlaybackLogger {
  JsonLinePlaybackLogger(this.file);
  final File file;
  Future<void> _tail = Future.value();

  void call(PlaybackLogRecord record) {
    final line = jsonEncode({
      'at': DateTime.now().toUtc().toIso8601String(),
      'sessionId': record.sessionId,
      'commandId': record.commandId,
      'snapshotRevision': record.snapshotRevision,
      'loadGeneration': record.loadGeneration,
      'currentItemId': record.currentItemId,
      'commandType': record.commandType,
      'engineEventType': record.engineEventType,
      'playbackStatus': record.playbackStatus.name,
      'errorCode': record.errorCode?.name,
    });
    final operation = _tail.then((_) async {
      await file.parent.create(recursive: true);
      await file.writeAsString('$line\n', mode: FileMode.append, flush: true);
    });
    _tail = operation.catchError((_) {});
  }
}
