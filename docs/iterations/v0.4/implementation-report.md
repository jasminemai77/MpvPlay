# Implementation report

The protocol now exposes typed queue commands, queue entries, actual play
order, repeat and shuffle. PlaybackRuntime is the sole mutable queue owner;
JSON persistence records the runtime snapshot without introducing Drift into
playback state. The player queue panel exposes mode controls, entry play,
remove, move, and confirmed clear.

Version Gate: ACCEPTED_WITH_RISK. Windows CI run 30731776988 passed and uploaded the
Release artifact. The known UX risk is documented separately: reordering uses
Move up/Move down rather than drag and drop.
