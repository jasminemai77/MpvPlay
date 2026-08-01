# Architecture Baseline 1.2

`PlaybackRuntime` owns the active queue, index, status, position and revision. Feature/UI code accesses it only through `PlaybackClient`. Engine events carry a load generation; Runtime ignores generations older than the active load. Platform and media-kit types cannot cross the engine adapter boundary.

