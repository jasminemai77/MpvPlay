# v0.3 Known Issues

- Reordering uses explicit up/down controls; drag-and-drop is intentionally out
  of scope.
- Playlist positions use gaps of 1024 and are compacted atomically on an
  explicit reorder.
- The Version Gate is not run until local regression, remote Windows CI,
  Release artifact, and Draft PR evidence are complete.
