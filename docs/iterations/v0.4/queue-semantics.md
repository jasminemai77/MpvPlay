# Queue semantics

Every enqueue creates a `PlaybackQueueEntry` with a unique UUIDv7. Duplicate
tracks are valid because identity is the entry id. Runtime owns base entries,
actual order, current entry, and traversal history. Removing the current entry
selects its actual-order successor when possible; clearing only stops playback
and clears queue runtime state.
