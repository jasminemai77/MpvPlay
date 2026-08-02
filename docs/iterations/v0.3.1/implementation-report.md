# v0.3.1 Implementation Report

Schema v3 persists playback start events and aggregate counts behind
`MediaLibraryFacade`. `AppPlaybackHistoryObserver` subscribes to the existing
PlaybackClient snapshot stream in AppBootstrap and serializes best-effort
writes without affecting playback. The History page reuses
LibraryPlaybackMapper through the existing app play callback.
