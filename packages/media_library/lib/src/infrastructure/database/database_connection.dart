import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sqlite3/sqlite3.dart' show Database;

/// Opens the sole production connection for the local media-library database.
QueryExecutor openMediaLibraryDatabase(File file) {
  return NativeDatabase.createInBackground(
    file,
    readPool: 0,
    setup: _configureConnection,
  );
}

/// Memory executors use the same foreign-key guarantee as production.
QueryExecutor openInMemoryMediaLibraryDatabase() {
  return NativeDatabase.memory(setup: _configureConnection);
}

void _configureConnection(Database database) {
  database.execute('PRAGMA journal_mode = WAL;');
  database.execute('PRAGMA synchronous = NORMAL;');
  database.execute('PRAGMA busy_timeout = 5000;');
  database.execute('PRAGMA foreign_keys = ON;');
}
