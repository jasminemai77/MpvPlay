# Media Library 2.0

MediaLibrary and PlaybackRuntime are independent. Drift rows never leave the
library package, media_library never imports media_kit or Flutter, and UI never
accesses DAOs. The database uses public UUIDs plus internal row IDs; paths are
locators, not track IDs. Only successful complete scans may mark absent records
missing; missing records retain identity and are never automatically deleted.
