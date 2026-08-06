import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:playback_protocol/playback_protocol.dart';
import 'package:playback_runtime/playback_runtime.dart';
import 'package:player_core/player_core.dart';

enum WindowsMediaCommandType { play, pause, toggle, previous, next, stop, seek }

final class WindowsMediaCommand {
  const WindowsMediaCommand(this.type, {this.position});
  final WindowsMediaCommandType type;
  final Duration? position;
}

abstract interface class WindowsMediaSessionPort {
  bool get supportsSystemSeekRequest;
  Future<void> initialize();
  Stream<WindowsMediaCommand> get commands;
  Future<void> updatePlaybackState(PlaybackStatus status);
  Future<void> updateMetadata({
    required String title,
    String? artist,
    String? album,
    String? artwork,
  });
  Future<void> updateTimeline({
    required Duration position,
    required Duration duration,
  });
  Future<void> clearMetadata();
  Future<void> setEnabled(bool enabled);
  Future<void> dispose();
}

enum TrayCommandType { show, hide, previous, toggle, next, quit }

final class TrayCommand {
  const TrayCommand(this.type);
  final TrayCommandType type;
}

final class TrayMenuState {
  const TrayMenuState({this.title = 'MpvPlay', this.playing = false});
  final String title;
  final bool playing;
}

abstract interface class DesktopTrayPort {
  Future<void> initialize();
  Stream<TrayCommand> get commands;
  Future<void> updateMenu(TrayMenuState state);
  Future<void> updateTooltip(String value);
  Future<void> dispose();
}

final class WindowCloseRequest {
  const WindowCloseRequest();
}

abstract interface class DesktopWindowPort {
  Stream<WindowCloseRequest> get closeRequests;
  Future<void> initialize();
  Future<void> showAndActivate();
  Future<void> hide();
  Future<void> allowClose();
  Future<void> close();
  Future<void> dispose();
}

final class FakeWindowsMediaSessionPort implements WindowsMediaSessionPort {
  final _commands = StreamController<WindowsMediaCommand>.broadcast();
  final states = <PlaybackStatus>[];
  final metadata = <Map<String, String?>>[];
  final timelines = <({Duration position, Duration duration})>[];
  bool failInitialize = false;
  bool failUpdates = false;
  bool initialized = false;
  bool disposed = false;
  @override
  bool get supportsSystemSeekRequest => false;
  @override
  Stream<WindowsMediaCommand> get commands => _commands.stream;
  void emit(WindowsMediaCommand command) => _commands.add(command);
  @override
  Future<void> initialize() async {
    if (failInitialize) throw StateError('media init failed');
    initialized = true;
  }

  @override
  Future<void> updatePlaybackState(PlaybackStatus status) async {
    if (failUpdates) throw StateError('media update failed');
    states.add(status);
  }

  @override
  Future<void> updateMetadata({
    required String title,
    String? artist,
    String? album,
    String? artwork,
  }) async {
    if (failUpdates) throw StateError('media update failed');
    metadata.add({
      'title': title,
      'artist': artist,
      'album': album,
      'artwork': artwork,
    });
  }

  @override
  Future<void> updateTimeline({
    required Duration position,
    required Duration duration,
  }) async {
    if (failUpdates) throw StateError('media update failed');
    timelines.add((position: position, duration: duration));
  }

  @override
  Future<void> clearMetadata() async {
    if (failUpdates) throw StateError('media update failed');
    metadata.add({
      'title': null,
      'artist': null,
      'album': null,
      'artwork': null,
    });
  }

  bool? enabled;
  @override
  Future<void> setEnabled(bool enabled) async => this.enabled = enabled;
  @override
  Future<void> dispose() async {
    disposed = true;
    await _commands.close();
  }
}

final class FakeDesktopTrayPort implements DesktopTrayPort {
  final _commands = StreamController<TrayCommand>.broadcast();
  bool initialized = false;
  bool disposed = false;
  bool failInitialize = false;
  bool failUpdates = false;
  TrayMenuState? menu;
  String? tooltip;
  @override
  Stream<TrayCommand> get commands => _commands.stream;
  void emit(TrayCommand command) => _commands.add(command);
  @override
  Future<void> initialize() async {
    if (failInitialize) throw StateError('tray init failed');
    initialized = true;
  }

  @override
  Future<void> updateMenu(TrayMenuState state) async {
    if (failUpdates) throw StateError('tray update failed');
    menu = state;
  }

  @override
  Future<void> updateTooltip(String value) async => tooltip = value;
  @override
  Future<void> dispose() async {
    disposed = true;
    await _commands.close();
  }
}

final class FakeDesktopWindowPort implements DesktopWindowPort {
  final _closeRequests = StreamController<WindowCloseRequest>.broadcast();
  bool initialized = false;
  bool disposed = false;
  bool closeAllowed = false;
  bool failInitialize = false;
  bool failHide = false;
  int showCount = 0;
  int hideCount = 0;
  int closeCount = 0;
  @override
  Stream<WindowCloseRequest> get closeRequests => _closeRequests.stream;
  void emitClose() => _closeRequests.add(const WindowCloseRequest());
  @override
  Future<void> initialize() async {
    if (failInitialize) throw StateError('window init failed');
    initialized = true;
  }

  @override
  Future<void> showAndActivate() async => showCount++;
  @override
  Future<void> hide() async {
    if (failHide) throw StateError('window hide failed');
    hideCount++;
  }

  @override
  Future<void> allowClose() async => closeAllowed = true;
  @override
  Future<void> close() async {
    closeCount++;
    closeAllowed = true;
  }

  @override
  Future<void> dispose() async {
    disposed = true;
    await _closeRequests.close();
  }
}

final class PersistedSession {
  const PersistedSession({
    required this.items,
    this.entries = const [],
    this.currentEntryId,
    this.playOrderEntryIds = const [],
    this.repeatMode = RepeatMode.off,
    this.shuffleEnabled = false,
    required this.currentIndex,
    required this.position,
    required this.volume,
    required this.muted,
    this.skippedItems = 0,
  });
  final List<PlayableItem> items;
  final List<PlaybackQueueEntry> entries;
  final String? currentEntryId;
  final List<String> playOrderEntryIds;
  final RepeatMode repeatMode;
  final bool shuffleEnabled;
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
      'version': 2,
      'uris': snapshot.queueItems.map((e) => e.source.uri.toString()).toList(),
      'entries': snapshot.queueEntries
          .map(
            (e) => {
              'entryId': e.entryId,
              'uri': e.item.source.uri.toString(),
              'title': e.item.title,
              'artist': e.item.artist,
            },
          )
          .toList(),
      'currentEntryId': snapshot.currentEntryId,
      'playOrderEntryIds': snapshot.playOrderEntryIds,
      'repeatMode': snapshot.repeatMode.name,
      'shuffleEnabled': snapshot.shuffleEnabled,
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
      final rawEntries = (data['entries'] as List<Object?>?) ?? const [];
      final items = <PlayableItem>[];
      final entries = <PlaybackQueueEntry>[];
      var skipped = 0;
      for (final raw in rawEntries.whereType<Map<Object?, Object?>>()) {
        final id = raw['entryId'] as String?;
        final uriText = raw['uri'] as String?;
        if (id == null || uriText == null) {
          skipped++;
          continue;
        }
        final uri = Uri.tryParse(uriText);
        if (uri == null ||
            uri.scheme != 'file' ||
            !await File.fromUri(uri).exists()) {
          skipped++;
          continue;
        }
        final title =
            raw['title'] as String? ??
            Uri.decodeComponent(File.fromUri(uri).uri.pathSegments.last);
        entries.add(
          PlaybackQueueEntry(
            entryId: id,
            item: PlayableItem(
              id: uriText,
              title: title,
              artist: raw['artist'] as String?,
              source: MediaSource(id: uriText, uri: uri, kind: MediaKind.audio),
            ),
          ),
        );
      }
      // v0.3.1 compatibility: old sessions carry URIs only; runtime creates ids.
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
      if (items.isEmpty && entries.isEmpty) {
        return PersistedSession(
          items: const [],
          currentIndex: -1,
          position: Duration.zero,
          volume: (data['volume'] as num?)?.toDouble() ?? 1,
          muted: data['muted'] as bool? ?? false,
          skippedItems: skipped,
        );
      }
      final validIds = entries.map((e) => e.entryId).toSet();
      final order = ((data['playOrderEntryIds'] as List<Object?>?) ?? const [])
          .whereType<String>()
          .where(validIds.contains)
          .toList();
      final mode =
          RepeatMode.values
              .where((e) => e.name == data['repeatMode'])
              .firstOrNull ??
          RepeatMode.off;
      final rawIndex = (data['currentIndex'] as num?)?.toInt() ?? 0;
      return PersistedSession(
        items: entries.isEmpty ? items : entries.map((e) => e.item).toList(),
        entries: entries,
        currentEntryId: data['currentEntryId'] as String?,
        playOrderEntryIds: order.length == entries.length
            ? order
            : entries.map((e) => e.entryId).toList(),
        repeatMode: mode,
        shuffleEnabled: data['shuffleEnabled'] as bool? ?? false,
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
