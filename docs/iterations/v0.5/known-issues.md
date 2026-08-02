# v0.5 known issues

Logical Track identity across multiple physical locations is intentionally
deferred. Supporting it needs a dedicated identity-model migration and is not
represented by Media Library Schema v3.

Directory reachability is checked when managed-root state is queried. It is not
a continuous operating-system file watcher in v0.5.
