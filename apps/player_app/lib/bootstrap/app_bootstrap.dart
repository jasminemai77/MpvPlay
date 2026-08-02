import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_settings/app_settings.dart';
import 'package:media_library/media_library.dart';
import 'package:path_provider/path_provider.dart';
import 'package:playback_engine_mpv/playback_engine_mpv.dart';
import 'package:playback_protocol/playback_protocol.dart';
import 'package:playback_runtime/playback_runtime.dart';
import 'package:platform_bridge/platform_bridge.dart';

import '../app/mpv_play_app.dart';
import '../features/now_playing/application/playback_providers.dart';
import '../features/library/application/library_providers.dart';
import '../features/history/application/playback_history_observer.dart';
import '../features/settings/application/settings_providers.dart';

final class AppBootstrap {
  AppBootstrap._(
    this._client,
    this._initialSnapshot,
    this._library,
    this._scanner,
    this._historyObserver,
    this._snapshotSubscription,
    this._settings,
  );
  final PlaybackClient _client;
  final PlaybackSnapshot _initialSnapshot;
  final MediaLibraryFacade _library;
  final LibraryScanCoordinator _scanner;
  final AppPlaybackHistoryObserver _historyObserver;
  final StreamSubscription<PlaybackSnapshot> _snapshotSubscription;
  final AppSettingsRepository _settings;

  static Future<AppBootstrap> create() async {
    WidgetsFlutterBinding.ensureInitialized();
    final directory = await getApplicationSupportDirectory();
    final settings = JsonAppSettingsStore(
      File('${directory.path}${Platform.pathSeparator}settings.json'),
    );
    await settings.load();
    final library = MediaLibraryFacade.open(
      File('${directory.path}${Platform.pathSeparator}media_library.sqlite'),
    );
    final scanner = library.createScanCoordinator();
    if (settings.current.scanOnStartup) {
      unawaited(
        Future<void>(() async {
          for (final root in await library.query.listRoots()) {
            if (root.enabled) await scanner.scanAndWait(root.id);
          }
        }),
      );
    }
    final runtime = PlaybackRuntime(
      engine: MpvPlaybackEngine(),
      logSink: JsonLinePlaybackLogger(
        File('${directory.path}${Platform.pathSeparator}playback.log.jsonl'),
      ).call,
    );
    await runtime.initialize();
    final store = JsonSessionStore(
      File('${directory.path}${Platform.pathSeparator}session.json'),
    );
    final restored = await store.restore();
    if (restored != null && restored.items.isNotEmpty) {
      await runtime.send(
        restored.entries.isEmpty
            ? LoadQueue(
                commandId: 'restore',
                sessionId: runtime.runtimeSessionId,
                issuedAt: DateTime.now(),
                items: restored.items,
                initialIndex: restored.currentIndex,
                startPosition: restored.position,
                autoPlay: false,
              )
            : RestoreQueue(
                commandId: 'restore',
                sessionId: runtime.runtimeSessionId,
                issuedAt: DateTime.now(),
                entries: restored.entries,
                currentEntryId: restored.currentEntryId,
                playOrderEntryIds: restored.playOrderEntryIds,
                repeatMode: restored.repeatMode,
                shuffleEnabled: restored.shuffleEnabled,
                startPosition: restored.position,
              ),
      );
      await runtime.send(
        SetVolume(
          commandId: 'restore-volume',
          sessionId: runtime.runtimeSessionId,
          issuedAt: DateTime.now(),
          value: restored.volume,
        ),
      );
      await runtime.send(
        SetMuted(
          commandId: 'restore-muted',
          sessionId: runtime.runtimeSessionId,
          issuedAt: DateTime.now(),
          muted: restored.muted,
        ),
      );
      runtime.reportSessionRestored(
        restoredItems: restored.items.length,
        skippedItems: restored.skippedItems,
      );
    }
    final client = InProcessPlaybackClient(runtime);
    final historyObserver = AppPlaybackHistoryObserver.forLibrary(
      snapshots: client.snapshots,
      library: library,
    );
    final snapshotSubscription = runtime.snapshots.listen(store.save);
    return AppBootstrap._(
      client,
      runtime.currentSnapshot,
      library,
      scanner,
      historyObserver,
      snapshotSubscription,
      settings,
    );
  }

  bool _disposed = false;

  Widget buildApp() => _BootstrapHost(
    bootstrap: this,
    child: ProviderScope(
      overrides: [
        clientProvider.overrideWithValue(_client),
        initialSnapshotProvider.overrideWithValue(_initialSnapshot),
        libraryFacadeProvider.overrideWithValue(_library),
        libraryScanCoordinatorProvider.overrideWithValue(_scanner),
        appSettingsRepositoryProvider.overrideWithValue(_settings),
      ],
      child: const MpvPlayApp(),
    ),
  );

  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    await _historyObserver.close();
    await _snapshotSubscription.cancel();
    await _settings.close();
    await _scanner.close();
    await _library.close();
    await _client.dispose();
  }
}

/// Owns the process-lifetime resources created by [AppBootstrap].
final class _BootstrapHost extends StatefulWidget {
  const _BootstrapHost({required this.bootstrap, required this.child});
  final AppBootstrap bootstrap;
  final Widget child;

  @override
  State<_BootstrapHost> createState() => _BootstrapHostState();
}

final class _BootstrapHostState extends State<_BootstrapHost>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      unawaited(widget.bootstrap.dispose());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(widget.bootstrap.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
