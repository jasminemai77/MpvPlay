# Shuffle semantics

Shuffle is a generated cycle, never a random decision on each Next command.
The current entry is retained when toggled. A completed Repeat All shuffle
cycle is regenerated and avoids an immediate duplicate boundary when possible.
Previous follows traversal history.
