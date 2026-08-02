# v0.5 Version Gate

Result: **ACCEPTED**.

Pre-delivery HEAD: `15bd5470297b02b877d9aa7acedf4f5d2299703d`

Validated CI: 30740598836 and 30740600057.

Artifact:

- Name: `MpvPlay-windows-release`
- ID: `8831203335`
- Size: 21,593,652 bytes
- SHA-256: `8f4f6143ccadd1cce3cc0102a4a6d8ade66931c694fb9ab9ff39c32342be8409`

Tests: Settings 6; Media Library 48; Runtime 14; Platform 1; real libmpv 8;
Flutter 7; total 84.

The final delivery follow-up adds `packages/app_settings` to Windows CI. This
is delivery hardening only and does not alter the accepted v0.5 architecture,
data model, or user-visible behavior.

The Media Library remains Schema v3. v0.5 intentionally accepts the existing
one-concrete-MediaFile-per-Track identity model; logical multi-location Tracks
remain a future migration.
