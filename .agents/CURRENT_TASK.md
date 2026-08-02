# Current Task

Version: v0.5
Task: Settings and library management
Status: COMPLETED
Gate: ACCEPTED
Architecture Baseline: Media Library 2.0 + Collections Schema v2 + Playback History Schema v3
Base Commit: d824f4c
Application Version: 0.5.0+6
Media Library Schema: v3 unchanged (existing library_roots.enabled)
Settings Schema: v1

Scope:
- durable theme and scan preferences
- managed library roots, reachability and scan lifecycle presentation
- reversible root disablement and recovery through existing media identity
- scan cancellation safety, startup scan serialization and shutdown draining
- settings, root-management and first-use UI

Frozen semantics:
- Schema v3 models a Track as one concrete MediaFile identity.
- A duplicate file under a different root is an independent Track.
- Root disablement never physically deletes tracks or user relationships.

Forbidden:
- Android
- SMTC or tray integration
- lyrics, EQ/DSP, online music and dynamic plugins
- Track-to-MediaFile relation tables or a Schema v4 migration
