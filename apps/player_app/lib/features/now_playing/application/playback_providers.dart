import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playback_protocol/playback_protocol.dart';
import 'package:playback_runtime/playback_runtime.dart';

final clientProvider = Provider<PlaybackClient>(
  (_) => throw UnimplementedError(),
);
final initialSnapshotProvider = Provider<PlaybackSnapshot>(
  (_) => throw UnimplementedError(),
);
final snapshotProvider = StreamProvider<PlaybackSnapshot>(
  (ref) => ref.watch(clientProvider).snapshots,
);

({String commandId, String sessionId, DateTime issuedAt}) commandMetadata(
  PlaybackSnapshot snapshot,
  String name,
) => (
  commandId: '$name-${DateTime.now().microsecondsSinceEpoch}',
  sessionId: snapshot.sessionId,
  issuedAt: DateTime.now(),
);
