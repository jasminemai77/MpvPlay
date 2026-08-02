# Session compatibility

Session JSON v2 persists entries, entry ids, actual order, current entry,
repeat and shuffle. Legacy v0.3.1 URI sessions restore through `LoadQueue`,
which creates fresh entry ids with repeat off and shuffle disabled. Invalid or
corrupt saved queue identity falls back safely without auto-play.
