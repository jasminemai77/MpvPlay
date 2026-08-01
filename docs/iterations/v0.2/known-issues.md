# v0.2 Known Issues

- Normal album-artwork cache capability is implemented through `ArtworkStore`.
- Malformed or exceptional metadata tags still have limited automatic artwork
  extraction and cover override behavior.
- Large-root enumeration retains the discovered entries for one root, creating
  a peak-memory risk proportional to the root's file count.
- File ID is Windows-only. Other platforms return no platform identity and
  continue with path/fingerprint matching.
- The v0.2 Gate is `ACCEPTED_WITH_RISK`; see `test-report.md` for CI evidence.
