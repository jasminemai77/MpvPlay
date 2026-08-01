import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_library/media_library.dart';

import '../application/library_providers.dart';

class LibraryPanel extends ConsumerStatefulWidget {
  const LibraryPanel({super.key, required this.onPlay});
  final Future<void> Function(List<LibraryTrack> tracks, LibraryTrack selected)
  onPlay;

  @override
  ConsumerState<LibraryPanel> createState() => _LibraryPanelState();
}

class _LibraryPanelState extends ConsumerState<LibraryPanel> {
  final _search = TextEditingController();
  final _tokens = <String, ScanCancellationToken>{};
  List<LibraryTrack>? _results;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _addRoot() async {
    final path = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Add music folder',
    );
    if (path == null || !mounted) {
      return;
    }
    try {
      await ref.read(libraryControllerProvider).addDirectory(path);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    }
  }

  Future<void> _searchTracks(String value) async {
    final results = await ref
        .read(libraryFacadeProvider)
        .query
        .searchTracks(value);
    if (mounted) {
      setState(() => _results = results);
    }
  }

  @override
  Widget build(BuildContext context) {
    final roots =
        ref.watch(libraryRootsProvider).value ?? const <LibraryRoot>[];
    final allTracks =
        ref.watch(libraryTracksProvider).value ?? const <LibraryTrack>[];
    final tracks = _results ?? allTracks;
    final progress = ref.watch(libraryScanProgressProvider).value;
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.library_music),
            title: const Text('Local library'),
            trailing: IconButton(
              icon: const Icon(Icons.create_new_folder_outlined),
              tooltip: 'Add folder',
              onPressed: _addRoot,
            ),
          ),
          if (progress != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${progress.status.name}: ${progress.discoveredCount} files',
                    ),
                  ),
                  if (_tokens[progress.rootId] case final token?)
                    TextButton(
                      onPressed: token.cancel,
                      child: const Text('Cancel'),
                    ),
                ],
              ),
            ),
          if (roots.isNotEmpty)
            SizedBox(
              height: 52,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: roots.length,
                itemBuilder: (context, index) {
                  final root = roots[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: InputChip(
                      label: Text(root.displayName),
                      onPressed: () => setState(
                        () => _tokens[root.id] = ref
                            .read(libraryControllerProvider)
                            .rescan(root.id),
                      ),
                      onDeleted: () => ref
                          .read(libraryControllerProvider)
                          .removeRoot(root.id),
                    ),
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _search,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search library',
              ),
              onChanged: _searchTracks,
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: tracks.isEmpty
                ? const Center(
                    child: Text('Add a music folder to build your library'),
                  )
                : ListView.builder(
                    itemCount: tracks.length,
                    itemBuilder: (context, index) {
                      final track = tracks[index];
                      return ListTile(
                        dense: true,
                        leading: const Icon(Icons.music_note),
                        title: Text(track.title),
                        subtitle: Text(
                          track.displayArtist ??
                              track.displayAlbum ??
                              'Local file',
                        ),
                        enabled: track.available,
                        onTap: track.available
                            ? () => widget.onPlay(tracks, track)
                            : null,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
