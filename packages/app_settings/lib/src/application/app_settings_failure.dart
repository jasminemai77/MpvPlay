enum AppSettingsFailureCode {
  settingsReadFailure,
  settingsWriteFailure,
  unsupportedSettingsVersion,
  corruptSettingsRecovered,
}

final class AppSettingsFailure implements Exception {
  const AppSettingsFailure(this.code, this.message, {this.cause});
  final AppSettingsFailureCode code;
  final String message;
  final Object? cause;
  @override
  String toString() => '$code: $message';
}
