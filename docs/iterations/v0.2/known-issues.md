# v0.2 Known Issues

- Album artwork is persisted by `ArtworkStore`; automatic extraction-to-cache
  wiring is intentionally incremental and may be deferred for malformed tags.
- File ID is Windows-only. Other platforms return no platform identity and
  continue with path/fingerprint matching.
- The Version Gate is not run in this implementation phase.
