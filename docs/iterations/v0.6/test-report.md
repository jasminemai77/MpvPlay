# v0.6 Test Report

Release commit: `f37d7b72f31365f72bf9302268fa4a79ae2ba7e9`

Release SHA-256: `D9DC245FE1DC727071117D9B42EB1BD68CBAC93CFE50CD6C3F3B9AC1C01CE60F`

| Suite | Result |
|---|---:|
| Settings | 9 passed |
| Media Library | 48 passed |
| Playback Runtime | 14 passed |
| Platform Bridge | 1 passed |
| Controller | 8 passed |
| real libmpv | 8 passed |
| Flutter app | 16 passed |

`build_runner`, format and `flutter analyze` passed. Release startup/exit
passed with exit code 0. SMTC hardware/media-panel and tray visual checks are
recorded as `NOT_TESTED` in `manual-windows-smoke.md`; system seek is
`NOT_SUPPORTED` by design.

Final Gate: `ACCEPTED_WITH_RISK`.
