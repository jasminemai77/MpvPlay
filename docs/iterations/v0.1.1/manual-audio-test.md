# Manual Windows Audio Test

Status: `MANUAL_VERIFICATION_REQUIRED`

The automated suite uses libmpv's null output and cannot prove audible sound.
Run `flutter run -d windows` from `apps/player_app`, import the generated WAVs,
and record PASS/FAIL for tone audibility, stereo left/right transition, pause,
resume, mute, volume, seek, next, stop, close, and non-autoplay restore.

Environment fields to record: test date, Windows version, CPU architecture,
audio device, connection type, Flutter version, media_kit version, and libmpv
source. Do not mark this PASS until a human listens to the output.
