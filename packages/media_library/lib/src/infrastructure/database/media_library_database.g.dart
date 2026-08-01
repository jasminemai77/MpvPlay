// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_library_database.dart';

// ignore_for_file: type=lint
class TrackSearchFts extends Table
    with
        TableInfo<TrackSearchFts, TrackSearchFt>,
        VirtualTableInfo<TrackSearchFts, TrackSearchFt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TrackSearchFts(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _trackPublicIdMeta = const VerificationMeta(
    'trackPublicId',
  );
  late final GeneratedColumn<String> trackPublicId = GeneratedColumn<String>(
    'track_public_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
    'artist',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _albumMeta = const VerificationMeta('album');
  late final GeneratedColumn<String> album = GeneratedColumn<String>(
    'album',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  @override
  List<GeneratedColumn> get $columns => [
    trackPublicId,
    title,
    artist,
    album,
    fileName,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'track_search_fts';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrackSearchFt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('track_public_id')) {
      context.handle(
        _trackPublicIdMeta,
        trackPublicId.isAcceptableOrUnknown(
          data['track_public_id']!,
          _trackPublicIdMeta,
        ),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('artist')) {
      context.handle(
        _artistMeta,
        artist.isAcceptableOrUnknown(data['artist']!, _artistMeta),
      );
    }
    if (data.containsKey('album')) {
      context.handle(
        _albumMeta,
        album.isAcceptableOrUnknown(data['album']!, _albumMeta),
      );
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  TrackSearchFt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrackSearchFt(
      trackPublicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}track_public_id'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      artist: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artist'],
      ),
      album: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}album'],
      ),
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      ),
    );
  }

  @override
  TrackSearchFts createAlias(String alias) {
    return TrackSearchFts(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
  @override
  String get moduleAndArgs =>
      'fts5(track_public_id UNINDEXED, title, artist, album, file_name, tokenize = \'trigram\')';
}

class TrackSearchFt extends DataClass implements Insertable<TrackSearchFt> {
  final String? trackPublicId;
  final String? title;
  final String? artist;
  final String? album;
  final String? fileName;
  const TrackSearchFt({
    this.trackPublicId,
    this.title,
    this.artist,
    this.album,
    this.fileName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || trackPublicId != null) {
      map['track_public_id'] = Variable<String>(trackPublicId);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || artist != null) {
      map['artist'] = Variable<String>(artist);
    }
    if (!nullToAbsent || album != null) {
      map['album'] = Variable<String>(album);
    }
    if (!nullToAbsent || fileName != null) {
      map['file_name'] = Variable<String>(fileName);
    }
    return map;
  }

  TrackSearchFtsCompanion toCompanion(bool nullToAbsent) {
    return TrackSearchFtsCompanion(
      trackPublicId: trackPublicId == null && nullToAbsent
          ? const Value.absent()
          : Value(trackPublicId),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      artist: artist == null && nullToAbsent
          ? const Value.absent()
          : Value(artist),
      album: album == null && nullToAbsent
          ? const Value.absent()
          : Value(album),
      fileName: fileName == null && nullToAbsent
          ? const Value.absent()
          : Value(fileName),
    );
  }

  factory TrackSearchFt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrackSearchFt(
      trackPublicId: serializer.fromJson<String?>(json['track_public_id']),
      title: serializer.fromJson<String?>(json['title']),
      artist: serializer.fromJson<String?>(json['artist']),
      album: serializer.fromJson<String?>(json['album']),
      fileName: serializer.fromJson<String?>(json['file_name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'track_public_id': serializer.toJson<String?>(trackPublicId),
      'title': serializer.toJson<String?>(title),
      'artist': serializer.toJson<String?>(artist),
      'album': serializer.toJson<String?>(album),
      'file_name': serializer.toJson<String?>(fileName),
    };
  }

  TrackSearchFt copyWith({
    Value<String?> trackPublicId = const Value.absent(),
    Value<String?> title = const Value.absent(),
    Value<String?> artist = const Value.absent(),
    Value<String?> album = const Value.absent(),
    Value<String?> fileName = const Value.absent(),
  }) => TrackSearchFt(
    trackPublicId: trackPublicId.present
        ? trackPublicId.value
        : this.trackPublicId,
    title: title.present ? title.value : this.title,
    artist: artist.present ? artist.value : this.artist,
    album: album.present ? album.value : this.album,
    fileName: fileName.present ? fileName.value : this.fileName,
  );
  TrackSearchFt copyWithCompanion(TrackSearchFtsCompanion data) {
    return TrackSearchFt(
      trackPublicId: data.trackPublicId.present
          ? data.trackPublicId.value
          : this.trackPublicId,
      title: data.title.present ? data.title.value : this.title,
      artist: data.artist.present ? data.artist.value : this.artist,
      album: data.album.present ? data.album.value : this.album,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrackSearchFt(')
          ..write('trackPublicId: $trackPublicId, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('fileName: $fileName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(trackPublicId, title, artist, album, fileName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrackSearchFt &&
          other.trackPublicId == this.trackPublicId &&
          other.title == this.title &&
          other.artist == this.artist &&
          other.album == this.album &&
          other.fileName == this.fileName);
}

class TrackSearchFtsCompanion extends UpdateCompanion<TrackSearchFt> {
  final Value<String?> trackPublicId;
  final Value<String?> title;
  final Value<String?> artist;
  final Value<String?> album;
  final Value<String?> fileName;
  final Value<int> rowid;
  const TrackSearchFtsCompanion({
    this.trackPublicId = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.album = const Value.absent(),
    this.fileName = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrackSearchFtsCompanion.insert({
    this.trackPublicId = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.album = const Value.absent(),
    this.fileName = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<TrackSearchFt> custom({
    Expression<String>? trackPublicId,
    Expression<String>? title,
    Expression<String>? artist,
    Expression<String>? album,
    Expression<String>? fileName,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (trackPublicId != null) 'track_public_id': trackPublicId,
      if (title != null) 'title': title,
      if (artist != null) 'artist': artist,
      if (album != null) 'album': album,
      if (fileName != null) 'file_name': fileName,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrackSearchFtsCompanion copyWith({
    Value<String?>? trackPublicId,
    Value<String?>? title,
    Value<String?>? artist,
    Value<String?>? album,
    Value<String?>? fileName,
    Value<int>? rowid,
  }) {
    return TrackSearchFtsCompanion(
      trackPublicId: trackPublicId ?? this.trackPublicId,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      fileName: fileName ?? this.fileName,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (trackPublicId.present) {
      map['track_public_id'] = Variable<String>(trackPublicId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (album.present) {
      map['album'] = Variable<String>(album.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrackSearchFtsCompanion(')
          ..write('trackPublicId: $trackPublicId, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('fileName: $fileName, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LibraryRootsTable extends LibraryRoots
    with TableInfo<$LibraryRootsTable, LibraryRoot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LibraryRootsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _rowIdMeta = const VerificationMeta('rowId');
  @override
  late final GeneratedColumn<int> rowId = GeneratedColumn<int>(
    'row_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _publicIdMeta = const VerificationMeta(
    'publicId',
  );
  @override
  late final GeneratedColumn<String> publicId = GeneratedColumn<String>(
    'public_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _sourceTypeMeta = const VerificationMeta(
    'sourceType',
  );
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
    'source_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locatorMeta = const VerificationMeta(
    'locator',
  );
  @override
  late final GeneratedColumn<String> locator = GeneratedColumn<String>(
    'locator',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locatorKeyMeta = const VerificationMeta(
    'locatorKey',
  );
  @override
  late final GeneratedColumn<String> locatorKey = GeneratedColumn<String>(
    'locator_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recursiveMeta = const VerificationMeta(
    'recursive',
  );
  @override
  late final GeneratedColumn<bool> recursive = GeneratedColumn<bool>(
    'recursive',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("recursive" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _scanGenerationMeta = const VerificationMeta(
    'scanGeneration',
  );
  @override
  late final GeneratedColumn<int> scanGeneration = GeneratedColumn<int>(
    'scan_generation',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastScanStartedAtMeta = const VerificationMeta(
    'lastScanStartedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastScanStartedAt =
      GeneratedColumn<DateTime>(
        'last_scan_started_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastScanCompletedAtMeta =
      const VerificationMeta('lastScanCompletedAt');
  @override
  late final GeneratedColumn<DateTime> lastScanCompletedAt =
      GeneratedColumn<DateTime>(
        'last_scan_completed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    rowId,
    publicId,
    sourceType,
    locator,
    locatorKey,
    displayName,
    recursive,
    enabled,
    scanGeneration,
    lastScanStartedAt,
    lastScanCompletedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'library_roots';
  @override
  VerificationContext validateIntegrity(
    Insertable<LibraryRoot> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('row_id')) {
      context.handle(
        _rowIdMeta,
        rowId.isAcceptableOrUnknown(data['row_id']!, _rowIdMeta),
      );
    }
    if (data.containsKey('public_id')) {
      context.handle(
        _publicIdMeta,
        publicId.isAcceptableOrUnknown(data['public_id']!, _publicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_publicIdMeta);
    }
    if (data.containsKey('source_type')) {
      context.handle(
        _sourceTypeMeta,
        sourceType.isAcceptableOrUnknown(data['source_type']!, _sourceTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceTypeMeta);
    }
    if (data.containsKey('locator')) {
      context.handle(
        _locatorMeta,
        locator.isAcceptableOrUnknown(data['locator']!, _locatorMeta),
      );
    } else if (isInserting) {
      context.missing(_locatorMeta);
    }
    if (data.containsKey('locator_key')) {
      context.handle(
        _locatorKeyMeta,
        locatorKey.isAcceptableOrUnknown(data['locator_key']!, _locatorKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_locatorKeyMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('recursive')) {
      context.handle(
        _recursiveMeta,
        recursive.isAcceptableOrUnknown(data['recursive']!, _recursiveMeta),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('scan_generation')) {
      context.handle(
        _scanGenerationMeta,
        scanGeneration.isAcceptableOrUnknown(
          data['scan_generation']!,
          _scanGenerationMeta,
        ),
      );
    }
    if (data.containsKey('last_scan_started_at')) {
      context.handle(
        _lastScanStartedAtMeta,
        lastScanStartedAt.isAcceptableOrUnknown(
          data['last_scan_started_at']!,
          _lastScanStartedAtMeta,
        ),
      );
    }
    if (data.containsKey('last_scan_completed_at')) {
      context.handle(
        _lastScanCompletedAtMeta,
        lastScanCompletedAt.isAcceptableOrUnknown(
          data['last_scan_completed_at']!,
          _lastScanCompletedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {rowId};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {sourceType, locatorKey},
  ];
  @override
  LibraryRoot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LibraryRoot(
      rowId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}row_id'],
      )!,
      publicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}public_id'],
      )!,
      sourceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_type'],
      )!,
      locator: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locator'],
      )!,
      locatorKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locator_key'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      recursive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}recursive'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      scanGeneration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}scan_generation'],
      )!,
      lastScanStartedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_scan_started_at'],
      ),
      lastScanCompletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_scan_completed_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LibraryRootsTable createAlias(String alias) {
    return $LibraryRootsTable(attachedDatabase, alias);
  }
}

class LibraryRoot extends DataClass implements Insertable<LibraryRoot> {
  final int rowId;
  final String publicId;
  final String sourceType;
  final String locator;
  final String locatorKey;
  final String displayName;
  final bool recursive;
  final bool enabled;
  final int scanGeneration;
  final DateTime? lastScanStartedAt;
  final DateTime? lastScanCompletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LibraryRoot({
    required this.rowId,
    required this.publicId,
    required this.sourceType,
    required this.locator,
    required this.locatorKey,
    required this.displayName,
    required this.recursive,
    required this.enabled,
    required this.scanGeneration,
    this.lastScanStartedAt,
    this.lastScanCompletedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['row_id'] = Variable<int>(rowId);
    map['public_id'] = Variable<String>(publicId);
    map['source_type'] = Variable<String>(sourceType);
    map['locator'] = Variable<String>(locator);
    map['locator_key'] = Variable<String>(locatorKey);
    map['display_name'] = Variable<String>(displayName);
    map['recursive'] = Variable<bool>(recursive);
    map['enabled'] = Variable<bool>(enabled);
    map['scan_generation'] = Variable<int>(scanGeneration);
    if (!nullToAbsent || lastScanStartedAt != null) {
      map['last_scan_started_at'] = Variable<DateTime>(lastScanStartedAt);
    }
    if (!nullToAbsent || lastScanCompletedAt != null) {
      map['last_scan_completed_at'] = Variable<DateTime>(lastScanCompletedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LibraryRootsCompanion toCompanion(bool nullToAbsent) {
    return LibraryRootsCompanion(
      rowId: Value(rowId),
      publicId: Value(publicId),
      sourceType: Value(sourceType),
      locator: Value(locator),
      locatorKey: Value(locatorKey),
      displayName: Value(displayName),
      recursive: Value(recursive),
      enabled: Value(enabled),
      scanGeneration: Value(scanGeneration),
      lastScanStartedAt: lastScanStartedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastScanStartedAt),
      lastScanCompletedAt: lastScanCompletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastScanCompletedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LibraryRoot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LibraryRoot(
      rowId: serializer.fromJson<int>(json['rowId']),
      publicId: serializer.fromJson<String>(json['publicId']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      locator: serializer.fromJson<String>(json['locator']),
      locatorKey: serializer.fromJson<String>(json['locatorKey']),
      displayName: serializer.fromJson<String>(json['displayName']),
      recursive: serializer.fromJson<bool>(json['recursive']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      scanGeneration: serializer.fromJson<int>(json['scanGeneration']),
      lastScanStartedAt: serializer.fromJson<DateTime?>(
        json['lastScanStartedAt'],
      ),
      lastScanCompletedAt: serializer.fromJson<DateTime?>(
        json['lastScanCompletedAt'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'rowId': serializer.toJson<int>(rowId),
      'publicId': serializer.toJson<String>(publicId),
      'sourceType': serializer.toJson<String>(sourceType),
      'locator': serializer.toJson<String>(locator),
      'locatorKey': serializer.toJson<String>(locatorKey),
      'displayName': serializer.toJson<String>(displayName),
      'recursive': serializer.toJson<bool>(recursive),
      'enabled': serializer.toJson<bool>(enabled),
      'scanGeneration': serializer.toJson<int>(scanGeneration),
      'lastScanStartedAt': serializer.toJson<DateTime?>(lastScanStartedAt),
      'lastScanCompletedAt': serializer.toJson<DateTime?>(lastScanCompletedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LibraryRoot copyWith({
    int? rowId,
    String? publicId,
    String? sourceType,
    String? locator,
    String? locatorKey,
    String? displayName,
    bool? recursive,
    bool? enabled,
    int? scanGeneration,
    Value<DateTime?> lastScanStartedAt = const Value.absent(),
    Value<DateTime?> lastScanCompletedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => LibraryRoot(
    rowId: rowId ?? this.rowId,
    publicId: publicId ?? this.publicId,
    sourceType: sourceType ?? this.sourceType,
    locator: locator ?? this.locator,
    locatorKey: locatorKey ?? this.locatorKey,
    displayName: displayName ?? this.displayName,
    recursive: recursive ?? this.recursive,
    enabled: enabled ?? this.enabled,
    scanGeneration: scanGeneration ?? this.scanGeneration,
    lastScanStartedAt: lastScanStartedAt.present
        ? lastScanStartedAt.value
        : this.lastScanStartedAt,
    lastScanCompletedAt: lastScanCompletedAt.present
        ? lastScanCompletedAt.value
        : this.lastScanCompletedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LibraryRoot copyWithCompanion(LibraryRootsCompanion data) {
    return LibraryRoot(
      rowId: data.rowId.present ? data.rowId.value : this.rowId,
      publicId: data.publicId.present ? data.publicId.value : this.publicId,
      sourceType: data.sourceType.present
          ? data.sourceType.value
          : this.sourceType,
      locator: data.locator.present ? data.locator.value : this.locator,
      locatorKey: data.locatorKey.present
          ? data.locatorKey.value
          : this.locatorKey,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      recursive: data.recursive.present ? data.recursive.value : this.recursive,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      scanGeneration: data.scanGeneration.present
          ? data.scanGeneration.value
          : this.scanGeneration,
      lastScanStartedAt: data.lastScanStartedAt.present
          ? data.lastScanStartedAt.value
          : this.lastScanStartedAt,
      lastScanCompletedAt: data.lastScanCompletedAt.present
          ? data.lastScanCompletedAt.value
          : this.lastScanCompletedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LibraryRoot(')
          ..write('rowId: $rowId, ')
          ..write('publicId: $publicId, ')
          ..write('sourceType: $sourceType, ')
          ..write('locator: $locator, ')
          ..write('locatorKey: $locatorKey, ')
          ..write('displayName: $displayName, ')
          ..write('recursive: $recursive, ')
          ..write('enabled: $enabled, ')
          ..write('scanGeneration: $scanGeneration, ')
          ..write('lastScanStartedAt: $lastScanStartedAt, ')
          ..write('lastScanCompletedAt: $lastScanCompletedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    rowId,
    publicId,
    sourceType,
    locator,
    locatorKey,
    displayName,
    recursive,
    enabled,
    scanGeneration,
    lastScanStartedAt,
    lastScanCompletedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LibraryRoot &&
          other.rowId == this.rowId &&
          other.publicId == this.publicId &&
          other.sourceType == this.sourceType &&
          other.locator == this.locator &&
          other.locatorKey == this.locatorKey &&
          other.displayName == this.displayName &&
          other.recursive == this.recursive &&
          other.enabled == this.enabled &&
          other.scanGeneration == this.scanGeneration &&
          other.lastScanStartedAt == this.lastScanStartedAt &&
          other.lastScanCompletedAt == this.lastScanCompletedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LibraryRootsCompanion extends UpdateCompanion<LibraryRoot> {
  final Value<int> rowId;
  final Value<String> publicId;
  final Value<String> sourceType;
  final Value<String> locator;
  final Value<String> locatorKey;
  final Value<String> displayName;
  final Value<bool> recursive;
  final Value<bool> enabled;
  final Value<int> scanGeneration;
  final Value<DateTime?> lastScanStartedAt;
  final Value<DateTime?> lastScanCompletedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const LibraryRootsCompanion({
    this.rowId = const Value.absent(),
    this.publicId = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.locator = const Value.absent(),
    this.locatorKey = const Value.absent(),
    this.displayName = const Value.absent(),
    this.recursive = const Value.absent(),
    this.enabled = const Value.absent(),
    this.scanGeneration = const Value.absent(),
    this.lastScanStartedAt = const Value.absent(),
    this.lastScanCompletedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LibraryRootsCompanion.insert({
    this.rowId = const Value.absent(),
    required String publicId,
    required String sourceType,
    required String locator,
    required String locatorKey,
    required String displayName,
    this.recursive = const Value.absent(),
    this.enabled = const Value.absent(),
    this.scanGeneration = const Value.absent(),
    this.lastScanStartedAt = const Value.absent(),
    this.lastScanCompletedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : publicId = Value(publicId),
       sourceType = Value(sourceType),
       locator = Value(locator),
       locatorKey = Value(locatorKey),
       displayName = Value(displayName),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LibraryRoot> custom({
    Expression<int>? rowId,
    Expression<String>? publicId,
    Expression<String>? sourceType,
    Expression<String>? locator,
    Expression<String>? locatorKey,
    Expression<String>? displayName,
    Expression<bool>? recursive,
    Expression<bool>? enabled,
    Expression<int>? scanGeneration,
    Expression<DateTime>? lastScanStartedAt,
    Expression<DateTime>? lastScanCompletedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (rowId != null) 'row_id': rowId,
      if (publicId != null) 'public_id': publicId,
      if (sourceType != null) 'source_type': sourceType,
      if (locator != null) 'locator': locator,
      if (locatorKey != null) 'locator_key': locatorKey,
      if (displayName != null) 'display_name': displayName,
      if (recursive != null) 'recursive': recursive,
      if (enabled != null) 'enabled': enabled,
      if (scanGeneration != null) 'scan_generation': scanGeneration,
      if (lastScanStartedAt != null) 'last_scan_started_at': lastScanStartedAt,
      if (lastScanCompletedAt != null)
        'last_scan_completed_at': lastScanCompletedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LibraryRootsCompanion copyWith({
    Value<int>? rowId,
    Value<String>? publicId,
    Value<String>? sourceType,
    Value<String>? locator,
    Value<String>? locatorKey,
    Value<String>? displayName,
    Value<bool>? recursive,
    Value<bool>? enabled,
    Value<int>? scanGeneration,
    Value<DateTime?>? lastScanStartedAt,
    Value<DateTime?>? lastScanCompletedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return LibraryRootsCompanion(
      rowId: rowId ?? this.rowId,
      publicId: publicId ?? this.publicId,
      sourceType: sourceType ?? this.sourceType,
      locator: locator ?? this.locator,
      locatorKey: locatorKey ?? this.locatorKey,
      displayName: displayName ?? this.displayName,
      recursive: recursive ?? this.recursive,
      enabled: enabled ?? this.enabled,
      scanGeneration: scanGeneration ?? this.scanGeneration,
      lastScanStartedAt: lastScanStartedAt ?? this.lastScanStartedAt,
      lastScanCompletedAt: lastScanCompletedAt ?? this.lastScanCompletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (rowId.present) {
      map['row_id'] = Variable<int>(rowId.value);
    }
    if (publicId.present) {
      map['public_id'] = Variable<String>(publicId.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (locator.present) {
      map['locator'] = Variable<String>(locator.value);
    }
    if (locatorKey.present) {
      map['locator_key'] = Variable<String>(locatorKey.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (recursive.present) {
      map['recursive'] = Variable<bool>(recursive.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (scanGeneration.present) {
      map['scan_generation'] = Variable<int>(scanGeneration.value);
    }
    if (lastScanStartedAt.present) {
      map['last_scan_started_at'] = Variable<DateTime>(lastScanStartedAt.value);
    }
    if (lastScanCompletedAt.present) {
      map['last_scan_completed_at'] = Variable<DateTime>(
        lastScanCompletedAt.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LibraryRootsCompanion(')
          ..write('rowId: $rowId, ')
          ..write('publicId: $publicId, ')
          ..write('sourceType: $sourceType, ')
          ..write('locator: $locator, ')
          ..write('locatorKey: $locatorKey, ')
          ..write('displayName: $displayName, ')
          ..write('recursive: $recursive, ')
          ..write('enabled: $enabled, ')
          ..write('scanGeneration: $scanGeneration, ')
          ..write('lastScanStartedAt: $lastScanStartedAt, ')
          ..write('lastScanCompletedAt: $lastScanCompletedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ScanRunsTable extends ScanRuns with TableInfo<$ScanRunsTable, ScanRun> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScanRunsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _rowIdMeta = const VerificationMeta('rowId');
  @override
  late final GeneratedColumn<int> rowId = GeneratedColumn<int>(
    'row_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _publicIdMeta = const VerificationMeta(
    'publicId',
  );
  @override
  late final GeneratedColumn<String> publicId = GeneratedColumn<String>(
    'public_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _rootIdMeta = const VerificationMeta('rootId');
  @override
  late final GeneratedColumn<int> rootId = GeneratedColumn<int>(
    'root_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES library_roots (row_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _generationMeta = const VerificationMeta(
    'generation',
  );
  @override
  late final GeneratedColumn<int> generation = GeneratedColumn<int>(
    'generation',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _finishedAtMeta = const VerificationMeta(
    'finishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> finishedAt = GeneratedColumn<DateTime>(
    'finished_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _discoveredCountMeta = const VerificationMeta(
    'discoveredCount',
  );
  @override
  late final GeneratedColumn<int> discoveredCount = GeneratedColumn<int>(
    'discovered_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _unchangedCountMeta = const VerificationMeta(
    'unchangedCount',
  );
  @override
  late final GeneratedColumn<int> unchangedCount = GeneratedColumn<int>(
    'unchanged_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _parsedCountMeta = const VerificationMeta(
    'parsedCount',
  );
  @override
  late final GeneratedColumn<int> parsedCount = GeneratedColumn<int>(
    'parsed_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _insertedCountMeta = const VerificationMeta(
    'insertedCount',
  );
  @override
  late final GeneratedColumn<int> insertedCount = GeneratedColumn<int>(
    'inserted_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _updatedCountMeta = const VerificationMeta(
    'updatedCount',
  );
  @override
  late final GeneratedColumn<int> updatedCount = GeneratedColumn<int>(
    'updated_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _missingCountMeta = const VerificationMeta(
    'missingCount',
  );
  @override
  late final GeneratedColumn<int> missingCount = GeneratedColumn<int>(
    'missing_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _failedCountMeta = const VerificationMeta(
    'failedCount',
  );
  @override
  late final GeneratedColumn<int> failedCount = GeneratedColumn<int>(
    'failed_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _failureCodeMeta = const VerificationMeta(
    'failureCode',
  );
  @override
  late final GeneratedColumn<String> failureCode = GeneratedColumn<String>(
    'failure_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _failureMessageMeta = const VerificationMeta(
    'failureMessage',
  );
  @override
  late final GeneratedColumn<String> failureMessage = GeneratedColumn<String>(
    'failure_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    rowId,
    publicId,
    rootId,
    generation,
    status,
    startedAt,
    finishedAt,
    discoveredCount,
    unchangedCount,
    parsedCount,
    insertedCount,
    updatedCount,
    missingCount,
    failedCount,
    failureCode,
    failureMessage,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scan_runs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScanRun> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('row_id')) {
      context.handle(
        _rowIdMeta,
        rowId.isAcceptableOrUnknown(data['row_id']!, _rowIdMeta),
      );
    }
    if (data.containsKey('public_id')) {
      context.handle(
        _publicIdMeta,
        publicId.isAcceptableOrUnknown(data['public_id']!, _publicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_publicIdMeta);
    }
    if (data.containsKey('root_id')) {
      context.handle(
        _rootIdMeta,
        rootId.isAcceptableOrUnknown(data['root_id']!, _rootIdMeta),
      );
    } else if (isInserting) {
      context.missing(_rootIdMeta);
    }
    if (data.containsKey('generation')) {
      context.handle(
        _generationMeta,
        generation.isAcceptableOrUnknown(data['generation']!, _generationMeta),
      );
    } else if (isInserting) {
      context.missing(_generationMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('finished_at')) {
      context.handle(
        _finishedAtMeta,
        finishedAt.isAcceptableOrUnknown(data['finished_at']!, _finishedAtMeta),
      );
    }
    if (data.containsKey('discovered_count')) {
      context.handle(
        _discoveredCountMeta,
        discoveredCount.isAcceptableOrUnknown(
          data['discovered_count']!,
          _discoveredCountMeta,
        ),
      );
    }
    if (data.containsKey('unchanged_count')) {
      context.handle(
        _unchangedCountMeta,
        unchangedCount.isAcceptableOrUnknown(
          data['unchanged_count']!,
          _unchangedCountMeta,
        ),
      );
    }
    if (data.containsKey('parsed_count')) {
      context.handle(
        _parsedCountMeta,
        parsedCount.isAcceptableOrUnknown(
          data['parsed_count']!,
          _parsedCountMeta,
        ),
      );
    }
    if (data.containsKey('inserted_count')) {
      context.handle(
        _insertedCountMeta,
        insertedCount.isAcceptableOrUnknown(
          data['inserted_count']!,
          _insertedCountMeta,
        ),
      );
    }
    if (data.containsKey('updated_count')) {
      context.handle(
        _updatedCountMeta,
        updatedCount.isAcceptableOrUnknown(
          data['updated_count']!,
          _updatedCountMeta,
        ),
      );
    }
    if (data.containsKey('missing_count')) {
      context.handle(
        _missingCountMeta,
        missingCount.isAcceptableOrUnknown(
          data['missing_count']!,
          _missingCountMeta,
        ),
      );
    }
    if (data.containsKey('failed_count')) {
      context.handle(
        _failedCountMeta,
        failedCount.isAcceptableOrUnknown(
          data['failed_count']!,
          _failedCountMeta,
        ),
      );
    }
    if (data.containsKey('failure_code')) {
      context.handle(
        _failureCodeMeta,
        failureCode.isAcceptableOrUnknown(
          data['failure_code']!,
          _failureCodeMeta,
        ),
      );
    }
    if (data.containsKey('failure_message')) {
      context.handle(
        _failureMessageMeta,
        failureMessage.isAcceptableOrUnknown(
          data['failure_message']!,
          _failureMessageMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {rowId};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {rootId, generation},
  ];
  @override
  ScanRun map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScanRun(
      rowId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}row_id'],
      )!,
      publicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}public_id'],
      )!,
      rootId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}root_id'],
      )!,
      generation: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}generation'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      finishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}finished_at'],
      ),
      discoveredCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discovered_count'],
      )!,
      unchangedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unchanged_count'],
      )!,
      parsedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}parsed_count'],
      )!,
      insertedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}inserted_count'],
      )!,
      updatedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_count'],
      )!,
      missingCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}missing_count'],
      )!,
      failedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}failed_count'],
      )!,
      failureCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}failure_code'],
      ),
      failureMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}failure_message'],
      ),
    );
  }

  @override
  $ScanRunsTable createAlias(String alias) {
    return $ScanRunsTable(attachedDatabase, alias);
  }
}

class ScanRun extends DataClass implements Insertable<ScanRun> {
  final int rowId;
  final String publicId;
  final int rootId;
  final int generation;
  final String status;
  final DateTime startedAt;
  final DateTime? finishedAt;
  final int discoveredCount;
  final int unchangedCount;
  final int parsedCount;
  final int insertedCount;
  final int updatedCount;
  final int missingCount;
  final int failedCount;
  final String? failureCode;
  final String? failureMessage;
  const ScanRun({
    required this.rowId,
    required this.publicId,
    required this.rootId,
    required this.generation,
    required this.status,
    required this.startedAt,
    this.finishedAt,
    required this.discoveredCount,
    required this.unchangedCount,
    required this.parsedCount,
    required this.insertedCount,
    required this.updatedCount,
    required this.missingCount,
    required this.failedCount,
    this.failureCode,
    this.failureMessage,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['row_id'] = Variable<int>(rowId);
    map['public_id'] = Variable<String>(publicId);
    map['root_id'] = Variable<int>(rootId);
    map['generation'] = Variable<int>(generation);
    map['status'] = Variable<String>(status);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || finishedAt != null) {
      map['finished_at'] = Variable<DateTime>(finishedAt);
    }
    map['discovered_count'] = Variable<int>(discoveredCount);
    map['unchanged_count'] = Variable<int>(unchangedCount);
    map['parsed_count'] = Variable<int>(parsedCount);
    map['inserted_count'] = Variable<int>(insertedCount);
    map['updated_count'] = Variable<int>(updatedCount);
    map['missing_count'] = Variable<int>(missingCount);
    map['failed_count'] = Variable<int>(failedCount);
    if (!nullToAbsent || failureCode != null) {
      map['failure_code'] = Variable<String>(failureCode);
    }
    if (!nullToAbsent || failureMessage != null) {
      map['failure_message'] = Variable<String>(failureMessage);
    }
    return map;
  }

  ScanRunsCompanion toCompanion(bool nullToAbsent) {
    return ScanRunsCompanion(
      rowId: Value(rowId),
      publicId: Value(publicId),
      rootId: Value(rootId),
      generation: Value(generation),
      status: Value(status),
      startedAt: Value(startedAt),
      finishedAt: finishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(finishedAt),
      discoveredCount: Value(discoveredCount),
      unchangedCount: Value(unchangedCount),
      parsedCount: Value(parsedCount),
      insertedCount: Value(insertedCount),
      updatedCount: Value(updatedCount),
      missingCount: Value(missingCount),
      failedCount: Value(failedCount),
      failureCode: failureCode == null && nullToAbsent
          ? const Value.absent()
          : Value(failureCode),
      failureMessage: failureMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(failureMessage),
    );
  }

  factory ScanRun.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScanRun(
      rowId: serializer.fromJson<int>(json['rowId']),
      publicId: serializer.fromJson<String>(json['publicId']),
      rootId: serializer.fromJson<int>(json['rootId']),
      generation: serializer.fromJson<int>(json['generation']),
      status: serializer.fromJson<String>(json['status']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      finishedAt: serializer.fromJson<DateTime?>(json['finishedAt']),
      discoveredCount: serializer.fromJson<int>(json['discoveredCount']),
      unchangedCount: serializer.fromJson<int>(json['unchangedCount']),
      parsedCount: serializer.fromJson<int>(json['parsedCount']),
      insertedCount: serializer.fromJson<int>(json['insertedCount']),
      updatedCount: serializer.fromJson<int>(json['updatedCount']),
      missingCount: serializer.fromJson<int>(json['missingCount']),
      failedCount: serializer.fromJson<int>(json['failedCount']),
      failureCode: serializer.fromJson<String?>(json['failureCode']),
      failureMessage: serializer.fromJson<String?>(json['failureMessage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'rowId': serializer.toJson<int>(rowId),
      'publicId': serializer.toJson<String>(publicId),
      'rootId': serializer.toJson<int>(rootId),
      'generation': serializer.toJson<int>(generation),
      'status': serializer.toJson<String>(status),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'finishedAt': serializer.toJson<DateTime?>(finishedAt),
      'discoveredCount': serializer.toJson<int>(discoveredCount),
      'unchangedCount': serializer.toJson<int>(unchangedCount),
      'parsedCount': serializer.toJson<int>(parsedCount),
      'insertedCount': serializer.toJson<int>(insertedCount),
      'updatedCount': serializer.toJson<int>(updatedCount),
      'missingCount': serializer.toJson<int>(missingCount),
      'failedCount': serializer.toJson<int>(failedCount),
      'failureCode': serializer.toJson<String?>(failureCode),
      'failureMessage': serializer.toJson<String?>(failureMessage),
    };
  }

  ScanRun copyWith({
    int? rowId,
    String? publicId,
    int? rootId,
    int? generation,
    String? status,
    DateTime? startedAt,
    Value<DateTime?> finishedAt = const Value.absent(),
    int? discoveredCount,
    int? unchangedCount,
    int? parsedCount,
    int? insertedCount,
    int? updatedCount,
    int? missingCount,
    int? failedCount,
    Value<String?> failureCode = const Value.absent(),
    Value<String?> failureMessage = const Value.absent(),
  }) => ScanRun(
    rowId: rowId ?? this.rowId,
    publicId: publicId ?? this.publicId,
    rootId: rootId ?? this.rootId,
    generation: generation ?? this.generation,
    status: status ?? this.status,
    startedAt: startedAt ?? this.startedAt,
    finishedAt: finishedAt.present ? finishedAt.value : this.finishedAt,
    discoveredCount: discoveredCount ?? this.discoveredCount,
    unchangedCount: unchangedCount ?? this.unchangedCount,
    parsedCount: parsedCount ?? this.parsedCount,
    insertedCount: insertedCount ?? this.insertedCount,
    updatedCount: updatedCount ?? this.updatedCount,
    missingCount: missingCount ?? this.missingCount,
    failedCount: failedCount ?? this.failedCount,
    failureCode: failureCode.present ? failureCode.value : this.failureCode,
    failureMessage: failureMessage.present
        ? failureMessage.value
        : this.failureMessage,
  );
  ScanRun copyWithCompanion(ScanRunsCompanion data) {
    return ScanRun(
      rowId: data.rowId.present ? data.rowId.value : this.rowId,
      publicId: data.publicId.present ? data.publicId.value : this.publicId,
      rootId: data.rootId.present ? data.rootId.value : this.rootId,
      generation: data.generation.present
          ? data.generation.value
          : this.generation,
      status: data.status.present ? data.status.value : this.status,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      finishedAt: data.finishedAt.present
          ? data.finishedAt.value
          : this.finishedAt,
      discoveredCount: data.discoveredCount.present
          ? data.discoveredCount.value
          : this.discoveredCount,
      unchangedCount: data.unchangedCount.present
          ? data.unchangedCount.value
          : this.unchangedCount,
      parsedCount: data.parsedCount.present
          ? data.parsedCount.value
          : this.parsedCount,
      insertedCount: data.insertedCount.present
          ? data.insertedCount.value
          : this.insertedCount,
      updatedCount: data.updatedCount.present
          ? data.updatedCount.value
          : this.updatedCount,
      missingCount: data.missingCount.present
          ? data.missingCount.value
          : this.missingCount,
      failedCount: data.failedCount.present
          ? data.failedCount.value
          : this.failedCount,
      failureCode: data.failureCode.present
          ? data.failureCode.value
          : this.failureCode,
      failureMessage: data.failureMessage.present
          ? data.failureMessage.value
          : this.failureMessage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScanRun(')
          ..write('rowId: $rowId, ')
          ..write('publicId: $publicId, ')
          ..write('rootId: $rootId, ')
          ..write('generation: $generation, ')
          ..write('status: $status, ')
          ..write('startedAt: $startedAt, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('discoveredCount: $discoveredCount, ')
          ..write('unchangedCount: $unchangedCount, ')
          ..write('parsedCount: $parsedCount, ')
          ..write('insertedCount: $insertedCount, ')
          ..write('updatedCount: $updatedCount, ')
          ..write('missingCount: $missingCount, ')
          ..write('failedCount: $failedCount, ')
          ..write('failureCode: $failureCode, ')
          ..write('failureMessage: $failureMessage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    rowId,
    publicId,
    rootId,
    generation,
    status,
    startedAt,
    finishedAt,
    discoveredCount,
    unchangedCount,
    parsedCount,
    insertedCount,
    updatedCount,
    missingCount,
    failedCount,
    failureCode,
    failureMessage,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScanRun &&
          other.rowId == this.rowId &&
          other.publicId == this.publicId &&
          other.rootId == this.rootId &&
          other.generation == this.generation &&
          other.status == this.status &&
          other.startedAt == this.startedAt &&
          other.finishedAt == this.finishedAt &&
          other.discoveredCount == this.discoveredCount &&
          other.unchangedCount == this.unchangedCount &&
          other.parsedCount == this.parsedCount &&
          other.insertedCount == this.insertedCount &&
          other.updatedCount == this.updatedCount &&
          other.missingCount == this.missingCount &&
          other.failedCount == this.failedCount &&
          other.failureCode == this.failureCode &&
          other.failureMessage == this.failureMessage);
}

class ScanRunsCompanion extends UpdateCompanion<ScanRun> {
  final Value<int> rowId;
  final Value<String> publicId;
  final Value<int> rootId;
  final Value<int> generation;
  final Value<String> status;
  final Value<DateTime> startedAt;
  final Value<DateTime?> finishedAt;
  final Value<int> discoveredCount;
  final Value<int> unchangedCount;
  final Value<int> parsedCount;
  final Value<int> insertedCount;
  final Value<int> updatedCount;
  final Value<int> missingCount;
  final Value<int> failedCount;
  final Value<String?> failureCode;
  final Value<String?> failureMessage;
  const ScanRunsCompanion({
    this.rowId = const Value.absent(),
    this.publicId = const Value.absent(),
    this.rootId = const Value.absent(),
    this.generation = const Value.absent(),
    this.status = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.finishedAt = const Value.absent(),
    this.discoveredCount = const Value.absent(),
    this.unchangedCount = const Value.absent(),
    this.parsedCount = const Value.absent(),
    this.insertedCount = const Value.absent(),
    this.updatedCount = const Value.absent(),
    this.missingCount = const Value.absent(),
    this.failedCount = const Value.absent(),
    this.failureCode = const Value.absent(),
    this.failureMessage = const Value.absent(),
  });
  ScanRunsCompanion.insert({
    this.rowId = const Value.absent(),
    required String publicId,
    required int rootId,
    required int generation,
    required String status,
    required DateTime startedAt,
    this.finishedAt = const Value.absent(),
    this.discoveredCount = const Value.absent(),
    this.unchangedCount = const Value.absent(),
    this.parsedCount = const Value.absent(),
    this.insertedCount = const Value.absent(),
    this.updatedCount = const Value.absent(),
    this.missingCount = const Value.absent(),
    this.failedCount = const Value.absent(),
    this.failureCode = const Value.absent(),
    this.failureMessage = const Value.absent(),
  }) : publicId = Value(publicId),
       rootId = Value(rootId),
       generation = Value(generation),
       status = Value(status),
       startedAt = Value(startedAt);
  static Insertable<ScanRun> custom({
    Expression<int>? rowId,
    Expression<String>? publicId,
    Expression<int>? rootId,
    Expression<int>? generation,
    Expression<String>? status,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? finishedAt,
    Expression<int>? discoveredCount,
    Expression<int>? unchangedCount,
    Expression<int>? parsedCount,
    Expression<int>? insertedCount,
    Expression<int>? updatedCount,
    Expression<int>? missingCount,
    Expression<int>? failedCount,
    Expression<String>? failureCode,
    Expression<String>? failureMessage,
  }) {
    return RawValuesInsertable({
      if (rowId != null) 'row_id': rowId,
      if (publicId != null) 'public_id': publicId,
      if (rootId != null) 'root_id': rootId,
      if (generation != null) 'generation': generation,
      if (status != null) 'status': status,
      if (startedAt != null) 'started_at': startedAt,
      if (finishedAt != null) 'finished_at': finishedAt,
      if (discoveredCount != null) 'discovered_count': discoveredCount,
      if (unchangedCount != null) 'unchanged_count': unchangedCount,
      if (parsedCount != null) 'parsed_count': parsedCount,
      if (insertedCount != null) 'inserted_count': insertedCount,
      if (updatedCount != null) 'updated_count': updatedCount,
      if (missingCount != null) 'missing_count': missingCount,
      if (failedCount != null) 'failed_count': failedCount,
      if (failureCode != null) 'failure_code': failureCode,
      if (failureMessage != null) 'failure_message': failureMessage,
    });
  }

  ScanRunsCompanion copyWith({
    Value<int>? rowId,
    Value<String>? publicId,
    Value<int>? rootId,
    Value<int>? generation,
    Value<String>? status,
    Value<DateTime>? startedAt,
    Value<DateTime?>? finishedAt,
    Value<int>? discoveredCount,
    Value<int>? unchangedCount,
    Value<int>? parsedCount,
    Value<int>? insertedCount,
    Value<int>? updatedCount,
    Value<int>? missingCount,
    Value<int>? failedCount,
    Value<String?>? failureCode,
    Value<String?>? failureMessage,
  }) {
    return ScanRunsCompanion(
      rowId: rowId ?? this.rowId,
      publicId: publicId ?? this.publicId,
      rootId: rootId ?? this.rootId,
      generation: generation ?? this.generation,
      status: status ?? this.status,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      discoveredCount: discoveredCount ?? this.discoveredCount,
      unchangedCount: unchangedCount ?? this.unchangedCount,
      parsedCount: parsedCount ?? this.parsedCount,
      insertedCount: insertedCount ?? this.insertedCount,
      updatedCount: updatedCount ?? this.updatedCount,
      missingCount: missingCount ?? this.missingCount,
      failedCount: failedCount ?? this.failedCount,
      failureCode: failureCode ?? this.failureCode,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (rowId.present) {
      map['row_id'] = Variable<int>(rowId.value);
    }
    if (publicId.present) {
      map['public_id'] = Variable<String>(publicId.value);
    }
    if (rootId.present) {
      map['root_id'] = Variable<int>(rootId.value);
    }
    if (generation.present) {
      map['generation'] = Variable<int>(generation.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (finishedAt.present) {
      map['finished_at'] = Variable<DateTime>(finishedAt.value);
    }
    if (discoveredCount.present) {
      map['discovered_count'] = Variable<int>(discoveredCount.value);
    }
    if (unchangedCount.present) {
      map['unchanged_count'] = Variable<int>(unchangedCount.value);
    }
    if (parsedCount.present) {
      map['parsed_count'] = Variable<int>(parsedCount.value);
    }
    if (insertedCount.present) {
      map['inserted_count'] = Variable<int>(insertedCount.value);
    }
    if (updatedCount.present) {
      map['updated_count'] = Variable<int>(updatedCount.value);
    }
    if (missingCount.present) {
      map['missing_count'] = Variable<int>(missingCount.value);
    }
    if (failedCount.present) {
      map['failed_count'] = Variable<int>(failedCount.value);
    }
    if (failureCode.present) {
      map['failure_code'] = Variable<String>(failureCode.value);
    }
    if (failureMessage.present) {
      map['failure_message'] = Variable<String>(failureMessage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScanRunsCompanion(')
          ..write('rowId: $rowId, ')
          ..write('publicId: $publicId, ')
          ..write('rootId: $rootId, ')
          ..write('generation: $generation, ')
          ..write('status: $status, ')
          ..write('startedAt: $startedAt, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('discoveredCount: $discoveredCount, ')
          ..write('unchangedCount: $unchangedCount, ')
          ..write('parsedCount: $parsedCount, ')
          ..write('insertedCount: $insertedCount, ')
          ..write('updatedCount: $updatedCount, ')
          ..write('missingCount: $missingCount, ')
          ..write('failedCount: $failedCount, ')
          ..write('failureCode: $failureCode, ')
          ..write('failureMessage: $failureMessage')
          ..write(')'))
        .toString();
  }
}

class $MediaFilesTable extends MediaFiles
    with TableInfo<$MediaFilesTable, MediaFile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediaFilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _rowIdMeta = const VerificationMeta('rowId');
  @override
  late final GeneratedColumn<int> rowId = GeneratedColumn<int>(
    'row_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _publicIdMeta = const VerificationMeta(
    'publicId',
  );
  @override
  late final GeneratedColumn<String> publicId = GeneratedColumn<String>(
    'public_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _rootIdMeta = const VerificationMeta('rootId');
  @override
  late final GeneratedColumn<int> rootId = GeneratedColumn<int>(
    'root_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES library_roots (row_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _locatorMeta = const VerificationMeta(
    'locator',
  );
  @override
  late final GeneratedColumn<String> locator = GeneratedColumn<String>(
    'locator',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locatorKeyMeta = const VerificationMeta(
    'locatorKey',
  );
  @override
  late final GeneratedColumn<String> locatorKey = GeneratedColumn<String>(
    'locator_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _relativePathMeta = const VerificationMeta(
    'relativePath',
  );
  @override
  late final GeneratedColumn<String> relativePath = GeneratedColumn<String>(
    'relative_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _extensionMeta = const VerificationMeta(
    'extension',
  );
  @override
  late final GeneratedColumn<String> extension = GeneratedColumn<String>(
    'extension',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeBytesMeta = const VerificationMeta(
    'sizeBytes',
  );
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
    'size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modifiedAtMicrosMeta = const VerificationMeta(
    'modifiedAtMicros',
  );
  @override
  late final GeneratedColumn<int> modifiedAtMicros = GeneratedColumn<int>(
    'modified_at_micros',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _platformFileIdMeta = const VerificationMeta(
    'platformFileId',
  );
  @override
  late final GeneratedColumn<String> platformFileId = GeneratedColumn<String>(
    'platform_file_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quickFingerprintMeta = const VerificationMeta(
    'quickFingerprint',
  );
  @override
  late final GeneratedColumn<String> quickFingerprint = GeneratedColumn<String>(
    'quick_fingerprint',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentHashMeta = const VerificationMeta(
    'contentHash',
  );
  @override
  late final GeneratedColumn<String> contentHash = GeneratedColumn<String>(
    'content_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _availabilityStateMeta = const VerificationMeta(
    'availabilityState',
  );
  @override
  late final GeneratedColumn<String> availabilityState =
      GeneratedColumn<String>(
        'availability_state',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _metadataStateMeta = const VerificationMeta(
    'metadataState',
  );
  @override
  late final GeneratedColumn<String> metadataState = GeneratedColumn<String>(
    'metadata_state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSeenGenerationMeta =
      const VerificationMeta('lastSeenGeneration');
  @override
  late final GeneratedColumn<int> lastSeenGeneration = GeneratedColumn<int>(
    'last_seen_generation',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSeenAtMeta = const VerificationMeta(
    'lastSeenAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSeenAt = GeneratedColumn<DateTime>(
    'last_seen_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _missingSinceMeta = const VerificationMeta(
    'missingSince',
  );
  @override
  late final GeneratedColumn<DateTime> missingSince = GeneratedColumn<DateTime>(
    'missing_since',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastErrorCodeMeta = const VerificationMeta(
    'lastErrorCode',
  );
  @override
  late final GeneratedColumn<String> lastErrorCode = GeneratedColumn<String>(
    'last_error_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastErrorMessageMeta = const VerificationMeta(
    'lastErrorMessage',
  );
  @override
  late final GeneratedColumn<String> lastErrorMessage = GeneratedColumn<String>(
    'last_error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    rowId,
    publicId,
    rootId,
    locator,
    locatorKey,
    relativePath,
    fileName,
    extension,
    sizeBytes,
    modifiedAtMicros,
    platformFileId,
    quickFingerprint,
    contentHash,
    availabilityState,
    metadataState,
    lastSeenGeneration,
    lastSeenAt,
    missingSince,
    lastErrorCode,
    lastErrorMessage,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'media_files';
  @override
  VerificationContext validateIntegrity(
    Insertable<MediaFile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('row_id')) {
      context.handle(
        _rowIdMeta,
        rowId.isAcceptableOrUnknown(data['row_id']!, _rowIdMeta),
      );
    }
    if (data.containsKey('public_id')) {
      context.handle(
        _publicIdMeta,
        publicId.isAcceptableOrUnknown(data['public_id']!, _publicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_publicIdMeta);
    }
    if (data.containsKey('root_id')) {
      context.handle(
        _rootIdMeta,
        rootId.isAcceptableOrUnknown(data['root_id']!, _rootIdMeta),
      );
    } else if (isInserting) {
      context.missing(_rootIdMeta);
    }
    if (data.containsKey('locator')) {
      context.handle(
        _locatorMeta,
        locator.isAcceptableOrUnknown(data['locator']!, _locatorMeta),
      );
    } else if (isInserting) {
      context.missing(_locatorMeta);
    }
    if (data.containsKey('locator_key')) {
      context.handle(
        _locatorKeyMeta,
        locatorKey.isAcceptableOrUnknown(data['locator_key']!, _locatorKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_locatorKeyMeta);
    }
    if (data.containsKey('relative_path')) {
      context.handle(
        _relativePathMeta,
        relativePath.isAcceptableOrUnknown(
          data['relative_path']!,
          _relativePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relativePathMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('extension')) {
      context.handle(
        _extensionMeta,
        extension.isAcceptableOrUnknown(data['extension']!, _extensionMeta),
      );
    } else if (isInserting) {
      context.missing(_extensionMeta);
    }
    if (data.containsKey('size_bytes')) {
      context.handle(
        _sizeBytesMeta,
        sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeBytesMeta);
    }
    if (data.containsKey('modified_at_micros')) {
      context.handle(
        _modifiedAtMicrosMeta,
        modifiedAtMicros.isAcceptableOrUnknown(
          data['modified_at_micros']!,
          _modifiedAtMicrosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_modifiedAtMicrosMeta);
    }
    if (data.containsKey('platform_file_id')) {
      context.handle(
        _platformFileIdMeta,
        platformFileId.isAcceptableOrUnknown(
          data['platform_file_id']!,
          _platformFileIdMeta,
        ),
      );
    }
    if (data.containsKey('quick_fingerprint')) {
      context.handle(
        _quickFingerprintMeta,
        quickFingerprint.isAcceptableOrUnknown(
          data['quick_fingerprint']!,
          _quickFingerprintMeta,
        ),
      );
    }
    if (data.containsKey('content_hash')) {
      context.handle(
        _contentHashMeta,
        contentHash.isAcceptableOrUnknown(
          data['content_hash']!,
          _contentHashMeta,
        ),
      );
    }
    if (data.containsKey('availability_state')) {
      context.handle(
        _availabilityStateMeta,
        availabilityState.isAcceptableOrUnknown(
          data['availability_state']!,
          _availabilityStateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_availabilityStateMeta);
    }
    if (data.containsKey('metadata_state')) {
      context.handle(
        _metadataStateMeta,
        metadataState.isAcceptableOrUnknown(
          data['metadata_state']!,
          _metadataStateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_metadataStateMeta);
    }
    if (data.containsKey('last_seen_generation')) {
      context.handle(
        _lastSeenGenerationMeta,
        lastSeenGeneration.isAcceptableOrUnknown(
          data['last_seen_generation']!,
          _lastSeenGenerationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastSeenGenerationMeta);
    }
    if (data.containsKey('last_seen_at')) {
      context.handle(
        _lastSeenAtMeta,
        lastSeenAt.isAcceptableOrUnknown(
          data['last_seen_at']!,
          _lastSeenAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastSeenAtMeta);
    }
    if (data.containsKey('missing_since')) {
      context.handle(
        _missingSinceMeta,
        missingSince.isAcceptableOrUnknown(
          data['missing_since']!,
          _missingSinceMeta,
        ),
      );
    }
    if (data.containsKey('last_error_code')) {
      context.handle(
        _lastErrorCodeMeta,
        lastErrorCode.isAcceptableOrUnknown(
          data['last_error_code']!,
          _lastErrorCodeMeta,
        ),
      );
    }
    if (data.containsKey('last_error_message')) {
      context.handle(
        _lastErrorMessageMeta,
        lastErrorMessage.isAcceptableOrUnknown(
          data['last_error_message']!,
          _lastErrorMessageMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {rowId};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {rootId, locatorKey},
  ];
  @override
  MediaFile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaFile(
      rowId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}row_id'],
      )!,
      publicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}public_id'],
      )!,
      rootId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}root_id'],
      )!,
      locator: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locator'],
      )!,
      locatorKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locator_key'],
      )!,
      relativePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relative_path'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      extension: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}extension'],
      )!,
      sizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size_bytes'],
      )!,
      modifiedAtMicros: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}modified_at_micros'],
      )!,
      platformFileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}platform_file_id'],
      ),
      quickFingerprint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quick_fingerprint'],
      ),
      contentHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_hash'],
      ),
      availabilityState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}availability_state'],
      )!,
      metadataState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_state'],
      )!,
      lastSeenGeneration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_seen_generation'],
      )!,
      lastSeenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_seen_at'],
      )!,
      missingSince: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}missing_since'],
      ),
      lastErrorCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error_code'],
      ),
      lastErrorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error_message'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MediaFilesTable createAlias(String alias) {
    return $MediaFilesTable(attachedDatabase, alias);
  }
}

class MediaFile extends DataClass implements Insertable<MediaFile> {
  final int rowId;
  final String publicId;
  final int rootId;
  final String locator;
  final String locatorKey;
  final String relativePath;
  final String fileName;
  final String extension;
  final int sizeBytes;
  final int modifiedAtMicros;
  final String? platformFileId;
  final String? quickFingerprint;
  final String? contentHash;
  final String availabilityState;
  final String metadataState;
  final int lastSeenGeneration;
  final DateTime lastSeenAt;
  final DateTime? missingSince;
  final String? lastErrorCode;
  final String? lastErrorMessage;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MediaFile({
    required this.rowId,
    required this.publicId,
    required this.rootId,
    required this.locator,
    required this.locatorKey,
    required this.relativePath,
    required this.fileName,
    required this.extension,
    required this.sizeBytes,
    required this.modifiedAtMicros,
    this.platformFileId,
    this.quickFingerprint,
    this.contentHash,
    required this.availabilityState,
    required this.metadataState,
    required this.lastSeenGeneration,
    required this.lastSeenAt,
    this.missingSince,
    this.lastErrorCode,
    this.lastErrorMessage,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['row_id'] = Variable<int>(rowId);
    map['public_id'] = Variable<String>(publicId);
    map['root_id'] = Variable<int>(rootId);
    map['locator'] = Variable<String>(locator);
    map['locator_key'] = Variable<String>(locatorKey);
    map['relative_path'] = Variable<String>(relativePath);
    map['file_name'] = Variable<String>(fileName);
    map['extension'] = Variable<String>(extension);
    map['size_bytes'] = Variable<int>(sizeBytes);
    map['modified_at_micros'] = Variable<int>(modifiedAtMicros);
    if (!nullToAbsent || platformFileId != null) {
      map['platform_file_id'] = Variable<String>(platformFileId);
    }
    if (!nullToAbsent || quickFingerprint != null) {
      map['quick_fingerprint'] = Variable<String>(quickFingerprint);
    }
    if (!nullToAbsent || contentHash != null) {
      map['content_hash'] = Variable<String>(contentHash);
    }
    map['availability_state'] = Variable<String>(availabilityState);
    map['metadata_state'] = Variable<String>(metadataState);
    map['last_seen_generation'] = Variable<int>(lastSeenGeneration);
    map['last_seen_at'] = Variable<DateTime>(lastSeenAt);
    if (!nullToAbsent || missingSince != null) {
      map['missing_since'] = Variable<DateTime>(missingSince);
    }
    if (!nullToAbsent || lastErrorCode != null) {
      map['last_error_code'] = Variable<String>(lastErrorCode);
    }
    if (!nullToAbsent || lastErrorMessage != null) {
      map['last_error_message'] = Variable<String>(lastErrorMessage);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MediaFilesCompanion toCompanion(bool nullToAbsent) {
    return MediaFilesCompanion(
      rowId: Value(rowId),
      publicId: Value(publicId),
      rootId: Value(rootId),
      locator: Value(locator),
      locatorKey: Value(locatorKey),
      relativePath: Value(relativePath),
      fileName: Value(fileName),
      extension: Value(extension),
      sizeBytes: Value(sizeBytes),
      modifiedAtMicros: Value(modifiedAtMicros),
      platformFileId: platformFileId == null && nullToAbsent
          ? const Value.absent()
          : Value(platformFileId),
      quickFingerprint: quickFingerprint == null && nullToAbsent
          ? const Value.absent()
          : Value(quickFingerprint),
      contentHash: contentHash == null && nullToAbsent
          ? const Value.absent()
          : Value(contentHash),
      availabilityState: Value(availabilityState),
      metadataState: Value(metadataState),
      lastSeenGeneration: Value(lastSeenGeneration),
      lastSeenAt: Value(lastSeenAt),
      missingSince: missingSince == null && nullToAbsent
          ? const Value.absent()
          : Value(missingSince),
      lastErrorCode: lastErrorCode == null && nullToAbsent
          ? const Value.absent()
          : Value(lastErrorCode),
      lastErrorMessage: lastErrorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(lastErrorMessage),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MediaFile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaFile(
      rowId: serializer.fromJson<int>(json['rowId']),
      publicId: serializer.fromJson<String>(json['publicId']),
      rootId: serializer.fromJson<int>(json['rootId']),
      locator: serializer.fromJson<String>(json['locator']),
      locatorKey: serializer.fromJson<String>(json['locatorKey']),
      relativePath: serializer.fromJson<String>(json['relativePath']),
      fileName: serializer.fromJson<String>(json['fileName']),
      extension: serializer.fromJson<String>(json['extension']),
      sizeBytes: serializer.fromJson<int>(json['sizeBytes']),
      modifiedAtMicros: serializer.fromJson<int>(json['modifiedAtMicros']),
      platformFileId: serializer.fromJson<String?>(json['platformFileId']),
      quickFingerprint: serializer.fromJson<String?>(json['quickFingerprint']),
      contentHash: serializer.fromJson<String?>(json['contentHash']),
      availabilityState: serializer.fromJson<String>(json['availabilityState']),
      metadataState: serializer.fromJson<String>(json['metadataState']),
      lastSeenGeneration: serializer.fromJson<int>(json['lastSeenGeneration']),
      lastSeenAt: serializer.fromJson<DateTime>(json['lastSeenAt']),
      missingSince: serializer.fromJson<DateTime?>(json['missingSince']),
      lastErrorCode: serializer.fromJson<String?>(json['lastErrorCode']),
      lastErrorMessage: serializer.fromJson<String?>(json['lastErrorMessage']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'rowId': serializer.toJson<int>(rowId),
      'publicId': serializer.toJson<String>(publicId),
      'rootId': serializer.toJson<int>(rootId),
      'locator': serializer.toJson<String>(locator),
      'locatorKey': serializer.toJson<String>(locatorKey),
      'relativePath': serializer.toJson<String>(relativePath),
      'fileName': serializer.toJson<String>(fileName),
      'extension': serializer.toJson<String>(extension),
      'sizeBytes': serializer.toJson<int>(sizeBytes),
      'modifiedAtMicros': serializer.toJson<int>(modifiedAtMicros),
      'platformFileId': serializer.toJson<String?>(platformFileId),
      'quickFingerprint': serializer.toJson<String?>(quickFingerprint),
      'contentHash': serializer.toJson<String?>(contentHash),
      'availabilityState': serializer.toJson<String>(availabilityState),
      'metadataState': serializer.toJson<String>(metadataState),
      'lastSeenGeneration': serializer.toJson<int>(lastSeenGeneration),
      'lastSeenAt': serializer.toJson<DateTime>(lastSeenAt),
      'missingSince': serializer.toJson<DateTime?>(missingSince),
      'lastErrorCode': serializer.toJson<String?>(lastErrorCode),
      'lastErrorMessage': serializer.toJson<String?>(lastErrorMessage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MediaFile copyWith({
    int? rowId,
    String? publicId,
    int? rootId,
    String? locator,
    String? locatorKey,
    String? relativePath,
    String? fileName,
    String? extension,
    int? sizeBytes,
    int? modifiedAtMicros,
    Value<String?> platformFileId = const Value.absent(),
    Value<String?> quickFingerprint = const Value.absent(),
    Value<String?> contentHash = const Value.absent(),
    String? availabilityState,
    String? metadataState,
    int? lastSeenGeneration,
    DateTime? lastSeenAt,
    Value<DateTime?> missingSince = const Value.absent(),
    Value<String?> lastErrorCode = const Value.absent(),
    Value<String?> lastErrorMessage = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MediaFile(
    rowId: rowId ?? this.rowId,
    publicId: publicId ?? this.publicId,
    rootId: rootId ?? this.rootId,
    locator: locator ?? this.locator,
    locatorKey: locatorKey ?? this.locatorKey,
    relativePath: relativePath ?? this.relativePath,
    fileName: fileName ?? this.fileName,
    extension: extension ?? this.extension,
    sizeBytes: sizeBytes ?? this.sizeBytes,
    modifiedAtMicros: modifiedAtMicros ?? this.modifiedAtMicros,
    platformFileId: platformFileId.present
        ? platformFileId.value
        : this.platformFileId,
    quickFingerprint: quickFingerprint.present
        ? quickFingerprint.value
        : this.quickFingerprint,
    contentHash: contentHash.present ? contentHash.value : this.contentHash,
    availabilityState: availabilityState ?? this.availabilityState,
    metadataState: metadataState ?? this.metadataState,
    lastSeenGeneration: lastSeenGeneration ?? this.lastSeenGeneration,
    lastSeenAt: lastSeenAt ?? this.lastSeenAt,
    missingSince: missingSince.present ? missingSince.value : this.missingSince,
    lastErrorCode: lastErrorCode.present
        ? lastErrorCode.value
        : this.lastErrorCode,
    lastErrorMessage: lastErrorMessage.present
        ? lastErrorMessage.value
        : this.lastErrorMessage,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MediaFile copyWithCompanion(MediaFilesCompanion data) {
    return MediaFile(
      rowId: data.rowId.present ? data.rowId.value : this.rowId,
      publicId: data.publicId.present ? data.publicId.value : this.publicId,
      rootId: data.rootId.present ? data.rootId.value : this.rootId,
      locator: data.locator.present ? data.locator.value : this.locator,
      locatorKey: data.locatorKey.present
          ? data.locatorKey.value
          : this.locatorKey,
      relativePath: data.relativePath.present
          ? data.relativePath.value
          : this.relativePath,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      extension: data.extension.present ? data.extension.value : this.extension,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      modifiedAtMicros: data.modifiedAtMicros.present
          ? data.modifiedAtMicros.value
          : this.modifiedAtMicros,
      platformFileId: data.platformFileId.present
          ? data.platformFileId.value
          : this.platformFileId,
      quickFingerprint: data.quickFingerprint.present
          ? data.quickFingerprint.value
          : this.quickFingerprint,
      contentHash: data.contentHash.present
          ? data.contentHash.value
          : this.contentHash,
      availabilityState: data.availabilityState.present
          ? data.availabilityState.value
          : this.availabilityState,
      metadataState: data.metadataState.present
          ? data.metadataState.value
          : this.metadataState,
      lastSeenGeneration: data.lastSeenGeneration.present
          ? data.lastSeenGeneration.value
          : this.lastSeenGeneration,
      lastSeenAt: data.lastSeenAt.present
          ? data.lastSeenAt.value
          : this.lastSeenAt,
      missingSince: data.missingSince.present
          ? data.missingSince.value
          : this.missingSince,
      lastErrorCode: data.lastErrorCode.present
          ? data.lastErrorCode.value
          : this.lastErrorCode,
      lastErrorMessage: data.lastErrorMessage.present
          ? data.lastErrorMessage.value
          : this.lastErrorMessage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MediaFile(')
          ..write('rowId: $rowId, ')
          ..write('publicId: $publicId, ')
          ..write('rootId: $rootId, ')
          ..write('locator: $locator, ')
          ..write('locatorKey: $locatorKey, ')
          ..write('relativePath: $relativePath, ')
          ..write('fileName: $fileName, ')
          ..write('extension: $extension, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('modifiedAtMicros: $modifiedAtMicros, ')
          ..write('platformFileId: $platformFileId, ')
          ..write('quickFingerprint: $quickFingerprint, ')
          ..write('contentHash: $contentHash, ')
          ..write('availabilityState: $availabilityState, ')
          ..write('metadataState: $metadataState, ')
          ..write('lastSeenGeneration: $lastSeenGeneration, ')
          ..write('lastSeenAt: $lastSeenAt, ')
          ..write('missingSince: $missingSince, ')
          ..write('lastErrorCode: $lastErrorCode, ')
          ..write('lastErrorMessage: $lastErrorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    rowId,
    publicId,
    rootId,
    locator,
    locatorKey,
    relativePath,
    fileName,
    extension,
    sizeBytes,
    modifiedAtMicros,
    platformFileId,
    quickFingerprint,
    contentHash,
    availabilityState,
    metadataState,
    lastSeenGeneration,
    lastSeenAt,
    missingSince,
    lastErrorCode,
    lastErrorMessage,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaFile &&
          other.rowId == this.rowId &&
          other.publicId == this.publicId &&
          other.rootId == this.rootId &&
          other.locator == this.locator &&
          other.locatorKey == this.locatorKey &&
          other.relativePath == this.relativePath &&
          other.fileName == this.fileName &&
          other.extension == this.extension &&
          other.sizeBytes == this.sizeBytes &&
          other.modifiedAtMicros == this.modifiedAtMicros &&
          other.platformFileId == this.platformFileId &&
          other.quickFingerprint == this.quickFingerprint &&
          other.contentHash == this.contentHash &&
          other.availabilityState == this.availabilityState &&
          other.metadataState == this.metadataState &&
          other.lastSeenGeneration == this.lastSeenGeneration &&
          other.lastSeenAt == this.lastSeenAt &&
          other.missingSince == this.missingSince &&
          other.lastErrorCode == this.lastErrorCode &&
          other.lastErrorMessage == this.lastErrorMessage &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MediaFilesCompanion extends UpdateCompanion<MediaFile> {
  final Value<int> rowId;
  final Value<String> publicId;
  final Value<int> rootId;
  final Value<String> locator;
  final Value<String> locatorKey;
  final Value<String> relativePath;
  final Value<String> fileName;
  final Value<String> extension;
  final Value<int> sizeBytes;
  final Value<int> modifiedAtMicros;
  final Value<String?> platformFileId;
  final Value<String?> quickFingerprint;
  final Value<String?> contentHash;
  final Value<String> availabilityState;
  final Value<String> metadataState;
  final Value<int> lastSeenGeneration;
  final Value<DateTime> lastSeenAt;
  final Value<DateTime?> missingSince;
  final Value<String?> lastErrorCode;
  final Value<String?> lastErrorMessage;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const MediaFilesCompanion({
    this.rowId = const Value.absent(),
    this.publicId = const Value.absent(),
    this.rootId = const Value.absent(),
    this.locator = const Value.absent(),
    this.locatorKey = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.fileName = const Value.absent(),
    this.extension = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.modifiedAtMicros = const Value.absent(),
    this.platformFileId = const Value.absent(),
    this.quickFingerprint = const Value.absent(),
    this.contentHash = const Value.absent(),
    this.availabilityState = const Value.absent(),
    this.metadataState = const Value.absent(),
    this.lastSeenGeneration = const Value.absent(),
    this.lastSeenAt = const Value.absent(),
    this.missingSince = const Value.absent(),
    this.lastErrorCode = const Value.absent(),
    this.lastErrorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MediaFilesCompanion.insert({
    this.rowId = const Value.absent(),
    required String publicId,
    required int rootId,
    required String locator,
    required String locatorKey,
    required String relativePath,
    required String fileName,
    required String extension,
    required int sizeBytes,
    required int modifiedAtMicros,
    this.platformFileId = const Value.absent(),
    this.quickFingerprint = const Value.absent(),
    this.contentHash = const Value.absent(),
    required String availabilityState,
    required String metadataState,
    required int lastSeenGeneration,
    required DateTime lastSeenAt,
    this.missingSince = const Value.absent(),
    this.lastErrorCode = const Value.absent(),
    this.lastErrorMessage = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : publicId = Value(publicId),
       rootId = Value(rootId),
       locator = Value(locator),
       locatorKey = Value(locatorKey),
       relativePath = Value(relativePath),
       fileName = Value(fileName),
       extension = Value(extension),
       sizeBytes = Value(sizeBytes),
       modifiedAtMicros = Value(modifiedAtMicros),
       availabilityState = Value(availabilityState),
       metadataState = Value(metadataState),
       lastSeenGeneration = Value(lastSeenGeneration),
       lastSeenAt = Value(lastSeenAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<MediaFile> custom({
    Expression<int>? rowId,
    Expression<String>? publicId,
    Expression<int>? rootId,
    Expression<String>? locator,
    Expression<String>? locatorKey,
    Expression<String>? relativePath,
    Expression<String>? fileName,
    Expression<String>? extension,
    Expression<int>? sizeBytes,
    Expression<int>? modifiedAtMicros,
    Expression<String>? platformFileId,
    Expression<String>? quickFingerprint,
    Expression<String>? contentHash,
    Expression<String>? availabilityState,
    Expression<String>? metadataState,
    Expression<int>? lastSeenGeneration,
    Expression<DateTime>? lastSeenAt,
    Expression<DateTime>? missingSince,
    Expression<String>? lastErrorCode,
    Expression<String>? lastErrorMessage,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (rowId != null) 'row_id': rowId,
      if (publicId != null) 'public_id': publicId,
      if (rootId != null) 'root_id': rootId,
      if (locator != null) 'locator': locator,
      if (locatorKey != null) 'locator_key': locatorKey,
      if (relativePath != null) 'relative_path': relativePath,
      if (fileName != null) 'file_name': fileName,
      if (extension != null) 'extension': extension,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (modifiedAtMicros != null) 'modified_at_micros': modifiedAtMicros,
      if (platformFileId != null) 'platform_file_id': platformFileId,
      if (quickFingerprint != null) 'quick_fingerprint': quickFingerprint,
      if (contentHash != null) 'content_hash': contentHash,
      if (availabilityState != null) 'availability_state': availabilityState,
      if (metadataState != null) 'metadata_state': metadataState,
      if (lastSeenGeneration != null)
        'last_seen_generation': lastSeenGeneration,
      if (lastSeenAt != null) 'last_seen_at': lastSeenAt,
      if (missingSince != null) 'missing_since': missingSince,
      if (lastErrorCode != null) 'last_error_code': lastErrorCode,
      if (lastErrorMessage != null) 'last_error_message': lastErrorMessage,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MediaFilesCompanion copyWith({
    Value<int>? rowId,
    Value<String>? publicId,
    Value<int>? rootId,
    Value<String>? locator,
    Value<String>? locatorKey,
    Value<String>? relativePath,
    Value<String>? fileName,
    Value<String>? extension,
    Value<int>? sizeBytes,
    Value<int>? modifiedAtMicros,
    Value<String?>? platformFileId,
    Value<String?>? quickFingerprint,
    Value<String?>? contentHash,
    Value<String>? availabilityState,
    Value<String>? metadataState,
    Value<int>? lastSeenGeneration,
    Value<DateTime>? lastSeenAt,
    Value<DateTime?>? missingSince,
    Value<String?>? lastErrorCode,
    Value<String?>? lastErrorMessage,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return MediaFilesCompanion(
      rowId: rowId ?? this.rowId,
      publicId: publicId ?? this.publicId,
      rootId: rootId ?? this.rootId,
      locator: locator ?? this.locator,
      locatorKey: locatorKey ?? this.locatorKey,
      relativePath: relativePath ?? this.relativePath,
      fileName: fileName ?? this.fileName,
      extension: extension ?? this.extension,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      modifiedAtMicros: modifiedAtMicros ?? this.modifiedAtMicros,
      platformFileId: platformFileId ?? this.platformFileId,
      quickFingerprint: quickFingerprint ?? this.quickFingerprint,
      contentHash: contentHash ?? this.contentHash,
      availabilityState: availabilityState ?? this.availabilityState,
      metadataState: metadataState ?? this.metadataState,
      lastSeenGeneration: lastSeenGeneration ?? this.lastSeenGeneration,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
      missingSince: missingSince ?? this.missingSince,
      lastErrorCode: lastErrorCode ?? this.lastErrorCode,
      lastErrorMessage: lastErrorMessage ?? this.lastErrorMessage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (rowId.present) {
      map['row_id'] = Variable<int>(rowId.value);
    }
    if (publicId.present) {
      map['public_id'] = Variable<String>(publicId.value);
    }
    if (rootId.present) {
      map['root_id'] = Variable<int>(rootId.value);
    }
    if (locator.present) {
      map['locator'] = Variable<String>(locator.value);
    }
    if (locatorKey.present) {
      map['locator_key'] = Variable<String>(locatorKey.value);
    }
    if (relativePath.present) {
      map['relative_path'] = Variable<String>(relativePath.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (extension.present) {
      map['extension'] = Variable<String>(extension.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (modifiedAtMicros.present) {
      map['modified_at_micros'] = Variable<int>(modifiedAtMicros.value);
    }
    if (platformFileId.present) {
      map['platform_file_id'] = Variable<String>(platformFileId.value);
    }
    if (quickFingerprint.present) {
      map['quick_fingerprint'] = Variable<String>(quickFingerprint.value);
    }
    if (contentHash.present) {
      map['content_hash'] = Variable<String>(contentHash.value);
    }
    if (availabilityState.present) {
      map['availability_state'] = Variable<String>(availabilityState.value);
    }
    if (metadataState.present) {
      map['metadata_state'] = Variable<String>(metadataState.value);
    }
    if (lastSeenGeneration.present) {
      map['last_seen_generation'] = Variable<int>(lastSeenGeneration.value);
    }
    if (lastSeenAt.present) {
      map['last_seen_at'] = Variable<DateTime>(lastSeenAt.value);
    }
    if (missingSince.present) {
      map['missing_since'] = Variable<DateTime>(missingSince.value);
    }
    if (lastErrorCode.present) {
      map['last_error_code'] = Variable<String>(lastErrorCode.value);
    }
    if (lastErrorMessage.present) {
      map['last_error_message'] = Variable<String>(lastErrorMessage.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediaFilesCompanion(')
          ..write('rowId: $rowId, ')
          ..write('publicId: $publicId, ')
          ..write('rootId: $rootId, ')
          ..write('locator: $locator, ')
          ..write('locatorKey: $locatorKey, ')
          ..write('relativePath: $relativePath, ')
          ..write('fileName: $fileName, ')
          ..write('extension: $extension, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('modifiedAtMicros: $modifiedAtMicros, ')
          ..write('platformFileId: $platformFileId, ')
          ..write('quickFingerprint: $quickFingerprint, ')
          ..write('contentHash: $contentHash, ')
          ..write('availabilityState: $availabilityState, ')
          ..write('metadataState: $metadataState, ')
          ..write('lastSeenGeneration: $lastSeenGeneration, ')
          ..write('lastSeenAt: $lastSeenAt, ')
          ..write('missingSince: $missingSince, ')
          ..write('lastErrorCode: $lastErrorCode, ')
          ..write('lastErrorMessage: $lastErrorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ArtworkAssetsTable extends ArtworkAssets
    with TableInfo<$ArtworkAssetsTable, ArtworkAsset> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArtworkAssetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _rowIdMeta = const VerificationMeta('rowId');
  @override
  late final GeneratedColumn<int> rowId = GeneratedColumn<int>(
    'row_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _publicIdMeta = const VerificationMeta(
    'publicId',
  );
  @override
  late final GeneratedColumn<String> publicId = GeneratedColumn<String>(
    'public_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _contentHashMeta = const VerificationMeta(
    'contentHash',
  );
  @override
  late final GeneratedColumn<String> contentHash = GeneratedColumn<String>(
    'content_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _byteLengthMeta = const VerificationMeta(
    'byteLength',
  );
  @override
  late final GeneratedColumn<int> byteLength = GeneratedColumn<int>(
    'byte_length',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _relativeCachePathMeta = const VerificationMeta(
    'relativeCachePath',
  );
  @override
  late final GeneratedColumn<String> relativeCachePath =
      GeneratedColumn<String>(
        'relative_cache_path',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastAccessedAtMeta = const VerificationMeta(
    'lastAccessedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAccessedAt =
      GeneratedColumn<DateTime>(
        'last_accessed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    rowId,
    publicId,
    contentHash,
    mimeType,
    byteLength,
    relativeCachePath,
    createdAt,
    lastAccessedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'artwork_assets';
  @override
  VerificationContext validateIntegrity(
    Insertable<ArtworkAsset> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('row_id')) {
      context.handle(
        _rowIdMeta,
        rowId.isAcceptableOrUnknown(data['row_id']!, _rowIdMeta),
      );
    }
    if (data.containsKey('public_id')) {
      context.handle(
        _publicIdMeta,
        publicId.isAcceptableOrUnknown(data['public_id']!, _publicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_publicIdMeta);
    }
    if (data.containsKey('content_hash')) {
      context.handle(
        _contentHashMeta,
        contentHash.isAcceptableOrUnknown(
          data['content_hash']!,
          _contentHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentHashMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mimeTypeMeta);
    }
    if (data.containsKey('byte_length')) {
      context.handle(
        _byteLengthMeta,
        byteLength.isAcceptableOrUnknown(data['byte_length']!, _byteLengthMeta),
      );
    } else if (isInserting) {
      context.missing(_byteLengthMeta);
    }
    if (data.containsKey('relative_cache_path')) {
      context.handle(
        _relativeCachePathMeta,
        relativeCachePath.isAcceptableOrUnknown(
          data['relative_cache_path']!,
          _relativeCachePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relativeCachePathMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_accessed_at')) {
      context.handle(
        _lastAccessedAtMeta,
        lastAccessedAt.isAcceptableOrUnknown(
          data['last_accessed_at']!,
          _lastAccessedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {rowId};
  @override
  ArtworkAsset map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArtworkAsset(
      rowId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}row_id'],
      )!,
      publicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}public_id'],
      )!,
      contentHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_hash'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      )!,
      byteLength: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}byte_length'],
      )!,
      relativeCachePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relative_cache_path'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastAccessedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_accessed_at'],
      ),
    );
  }

  @override
  $ArtworkAssetsTable createAlias(String alias) {
    return $ArtworkAssetsTable(attachedDatabase, alias);
  }
}

class ArtworkAsset extends DataClass implements Insertable<ArtworkAsset> {
  final int rowId;
  final String publicId;
  final String contentHash;
  final String mimeType;
  final int byteLength;
  final String relativeCachePath;
  final DateTime createdAt;
  final DateTime? lastAccessedAt;
  const ArtworkAsset({
    required this.rowId,
    required this.publicId,
    required this.contentHash,
    required this.mimeType,
    required this.byteLength,
    required this.relativeCachePath,
    required this.createdAt,
    this.lastAccessedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['row_id'] = Variable<int>(rowId);
    map['public_id'] = Variable<String>(publicId);
    map['content_hash'] = Variable<String>(contentHash);
    map['mime_type'] = Variable<String>(mimeType);
    map['byte_length'] = Variable<int>(byteLength);
    map['relative_cache_path'] = Variable<String>(relativeCachePath);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastAccessedAt != null) {
      map['last_accessed_at'] = Variable<DateTime>(lastAccessedAt);
    }
    return map;
  }

  ArtworkAssetsCompanion toCompanion(bool nullToAbsent) {
    return ArtworkAssetsCompanion(
      rowId: Value(rowId),
      publicId: Value(publicId),
      contentHash: Value(contentHash),
      mimeType: Value(mimeType),
      byteLength: Value(byteLength),
      relativeCachePath: Value(relativeCachePath),
      createdAt: Value(createdAt),
      lastAccessedAt: lastAccessedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAccessedAt),
    );
  }

  factory ArtworkAsset.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ArtworkAsset(
      rowId: serializer.fromJson<int>(json['rowId']),
      publicId: serializer.fromJson<String>(json['publicId']),
      contentHash: serializer.fromJson<String>(json['contentHash']),
      mimeType: serializer.fromJson<String>(json['mimeType']),
      byteLength: serializer.fromJson<int>(json['byteLength']),
      relativeCachePath: serializer.fromJson<String>(json['relativeCachePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastAccessedAt: serializer.fromJson<DateTime?>(json['lastAccessedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'rowId': serializer.toJson<int>(rowId),
      'publicId': serializer.toJson<String>(publicId),
      'contentHash': serializer.toJson<String>(contentHash),
      'mimeType': serializer.toJson<String>(mimeType),
      'byteLength': serializer.toJson<int>(byteLength),
      'relativeCachePath': serializer.toJson<String>(relativeCachePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastAccessedAt': serializer.toJson<DateTime?>(lastAccessedAt),
    };
  }

  ArtworkAsset copyWith({
    int? rowId,
    String? publicId,
    String? contentHash,
    String? mimeType,
    int? byteLength,
    String? relativeCachePath,
    DateTime? createdAt,
    Value<DateTime?> lastAccessedAt = const Value.absent(),
  }) => ArtworkAsset(
    rowId: rowId ?? this.rowId,
    publicId: publicId ?? this.publicId,
    contentHash: contentHash ?? this.contentHash,
    mimeType: mimeType ?? this.mimeType,
    byteLength: byteLength ?? this.byteLength,
    relativeCachePath: relativeCachePath ?? this.relativeCachePath,
    createdAt: createdAt ?? this.createdAt,
    lastAccessedAt: lastAccessedAt.present
        ? lastAccessedAt.value
        : this.lastAccessedAt,
  );
  ArtworkAsset copyWithCompanion(ArtworkAssetsCompanion data) {
    return ArtworkAsset(
      rowId: data.rowId.present ? data.rowId.value : this.rowId,
      publicId: data.publicId.present ? data.publicId.value : this.publicId,
      contentHash: data.contentHash.present
          ? data.contentHash.value
          : this.contentHash,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      byteLength: data.byteLength.present
          ? data.byteLength.value
          : this.byteLength,
      relativeCachePath: data.relativeCachePath.present
          ? data.relativeCachePath.value
          : this.relativeCachePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastAccessedAt: data.lastAccessedAt.present
          ? data.lastAccessedAt.value
          : this.lastAccessedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ArtworkAsset(')
          ..write('rowId: $rowId, ')
          ..write('publicId: $publicId, ')
          ..write('contentHash: $contentHash, ')
          ..write('mimeType: $mimeType, ')
          ..write('byteLength: $byteLength, ')
          ..write('relativeCachePath: $relativeCachePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAccessedAt: $lastAccessedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    rowId,
    publicId,
    contentHash,
    mimeType,
    byteLength,
    relativeCachePath,
    createdAt,
    lastAccessedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArtworkAsset &&
          other.rowId == this.rowId &&
          other.publicId == this.publicId &&
          other.contentHash == this.contentHash &&
          other.mimeType == this.mimeType &&
          other.byteLength == this.byteLength &&
          other.relativeCachePath == this.relativeCachePath &&
          other.createdAt == this.createdAt &&
          other.lastAccessedAt == this.lastAccessedAt);
}

class ArtworkAssetsCompanion extends UpdateCompanion<ArtworkAsset> {
  final Value<int> rowId;
  final Value<String> publicId;
  final Value<String> contentHash;
  final Value<String> mimeType;
  final Value<int> byteLength;
  final Value<String> relativeCachePath;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastAccessedAt;
  const ArtworkAssetsCompanion({
    this.rowId = const Value.absent(),
    this.publicId = const Value.absent(),
    this.contentHash = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.byteLength = const Value.absent(),
    this.relativeCachePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastAccessedAt = const Value.absent(),
  });
  ArtworkAssetsCompanion.insert({
    this.rowId = const Value.absent(),
    required String publicId,
    required String contentHash,
    required String mimeType,
    required int byteLength,
    required String relativeCachePath,
    required DateTime createdAt,
    this.lastAccessedAt = const Value.absent(),
  }) : publicId = Value(publicId),
       contentHash = Value(contentHash),
       mimeType = Value(mimeType),
       byteLength = Value(byteLength),
       relativeCachePath = Value(relativeCachePath),
       createdAt = Value(createdAt);
  static Insertable<ArtworkAsset> custom({
    Expression<int>? rowId,
    Expression<String>? publicId,
    Expression<String>? contentHash,
    Expression<String>? mimeType,
    Expression<int>? byteLength,
    Expression<String>? relativeCachePath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastAccessedAt,
  }) {
    return RawValuesInsertable({
      if (rowId != null) 'row_id': rowId,
      if (publicId != null) 'public_id': publicId,
      if (contentHash != null) 'content_hash': contentHash,
      if (mimeType != null) 'mime_type': mimeType,
      if (byteLength != null) 'byte_length': byteLength,
      if (relativeCachePath != null) 'relative_cache_path': relativeCachePath,
      if (createdAt != null) 'created_at': createdAt,
      if (lastAccessedAt != null) 'last_accessed_at': lastAccessedAt,
    });
  }

  ArtworkAssetsCompanion copyWith({
    Value<int>? rowId,
    Value<String>? publicId,
    Value<String>? contentHash,
    Value<String>? mimeType,
    Value<int>? byteLength,
    Value<String>? relativeCachePath,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastAccessedAt,
  }) {
    return ArtworkAssetsCompanion(
      rowId: rowId ?? this.rowId,
      publicId: publicId ?? this.publicId,
      contentHash: contentHash ?? this.contentHash,
      mimeType: mimeType ?? this.mimeType,
      byteLength: byteLength ?? this.byteLength,
      relativeCachePath: relativeCachePath ?? this.relativeCachePath,
      createdAt: createdAt ?? this.createdAt,
      lastAccessedAt: lastAccessedAt ?? this.lastAccessedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (rowId.present) {
      map['row_id'] = Variable<int>(rowId.value);
    }
    if (publicId.present) {
      map['public_id'] = Variable<String>(publicId.value);
    }
    if (contentHash.present) {
      map['content_hash'] = Variable<String>(contentHash.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (byteLength.present) {
      map['byte_length'] = Variable<int>(byteLength.value);
    }
    if (relativeCachePath.present) {
      map['relative_cache_path'] = Variable<String>(relativeCachePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastAccessedAt.present) {
      map['last_accessed_at'] = Variable<DateTime>(lastAccessedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArtworkAssetsCompanion(')
          ..write('rowId: $rowId, ')
          ..write('publicId: $publicId, ')
          ..write('contentHash: $contentHash, ')
          ..write('mimeType: $mimeType, ')
          ..write('byteLength: $byteLength, ')
          ..write('relativeCachePath: $relativeCachePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAccessedAt: $lastAccessedAt')
          ..write(')'))
        .toString();
  }
}

class $ArtistsTable extends Artists with TableInfo<$ArtistsTable, Artist> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArtistsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _rowIdMeta = const VerificationMeta('rowId');
  @override
  late final GeneratedColumn<int> rowId = GeneratedColumn<int>(
    'row_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _publicIdMeta = const VerificationMeta(
    'publicId',
  );
  @override
  late final GeneratedColumn<String> publicId = GeneratedColumn<String>(
    'public_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortNameMeta = const VerificationMeta(
    'sortName',
  );
  @override
  late final GeneratedColumn<String> sortName = GeneratedColumn<String>(
    'sort_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _identityKeyMeta = const VerificationMeta(
    'identityKey',
  );
  @override
  late final GeneratedColumn<String> identityKey = GeneratedColumn<String>(
    'identity_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    rowId,
    publicId,
    name,
    sortName,
    identityKey,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'artists';
  @override
  VerificationContext validateIntegrity(
    Insertable<Artist> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('row_id')) {
      context.handle(
        _rowIdMeta,
        rowId.isAcceptableOrUnknown(data['row_id']!, _rowIdMeta),
      );
    }
    if (data.containsKey('public_id')) {
      context.handle(
        _publicIdMeta,
        publicId.isAcceptableOrUnknown(data['public_id']!, _publicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_publicIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_name')) {
      context.handle(
        _sortNameMeta,
        sortName.isAcceptableOrUnknown(data['sort_name']!, _sortNameMeta),
      );
    } else if (isInserting) {
      context.missing(_sortNameMeta);
    }
    if (data.containsKey('identity_key')) {
      context.handle(
        _identityKeyMeta,
        identityKey.isAcceptableOrUnknown(
          data['identity_key']!,
          _identityKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_identityKeyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {rowId};
  @override
  Artist map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Artist(
      rowId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}row_id'],
      )!,
      publicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}public_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sortName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sort_name'],
      )!,
      identityKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}identity_key'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ArtistsTable createAlias(String alias) {
    return $ArtistsTable(attachedDatabase, alias);
  }
}

class Artist extends DataClass implements Insertable<Artist> {
  final int rowId;
  final String publicId;
  final String name;
  final String sortName;
  final String identityKey;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Artist({
    required this.rowId,
    required this.publicId,
    required this.name,
    required this.sortName,
    required this.identityKey,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['row_id'] = Variable<int>(rowId);
    map['public_id'] = Variable<String>(publicId);
    map['name'] = Variable<String>(name);
    map['sort_name'] = Variable<String>(sortName);
    map['identity_key'] = Variable<String>(identityKey);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ArtistsCompanion toCompanion(bool nullToAbsent) {
    return ArtistsCompanion(
      rowId: Value(rowId),
      publicId: Value(publicId),
      name: Value(name),
      sortName: Value(sortName),
      identityKey: Value(identityKey),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Artist.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Artist(
      rowId: serializer.fromJson<int>(json['rowId']),
      publicId: serializer.fromJson<String>(json['publicId']),
      name: serializer.fromJson<String>(json['name']),
      sortName: serializer.fromJson<String>(json['sortName']),
      identityKey: serializer.fromJson<String>(json['identityKey']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'rowId': serializer.toJson<int>(rowId),
      'publicId': serializer.toJson<String>(publicId),
      'name': serializer.toJson<String>(name),
      'sortName': serializer.toJson<String>(sortName),
      'identityKey': serializer.toJson<String>(identityKey),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Artist copyWith({
    int? rowId,
    String? publicId,
    String? name,
    String? sortName,
    String? identityKey,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Artist(
    rowId: rowId ?? this.rowId,
    publicId: publicId ?? this.publicId,
    name: name ?? this.name,
    sortName: sortName ?? this.sortName,
    identityKey: identityKey ?? this.identityKey,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Artist copyWithCompanion(ArtistsCompanion data) {
    return Artist(
      rowId: data.rowId.present ? data.rowId.value : this.rowId,
      publicId: data.publicId.present ? data.publicId.value : this.publicId,
      name: data.name.present ? data.name.value : this.name,
      sortName: data.sortName.present ? data.sortName.value : this.sortName,
      identityKey: data.identityKey.present
          ? data.identityKey.value
          : this.identityKey,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Artist(')
          ..write('rowId: $rowId, ')
          ..write('publicId: $publicId, ')
          ..write('name: $name, ')
          ..write('sortName: $sortName, ')
          ..write('identityKey: $identityKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    rowId,
    publicId,
    name,
    sortName,
    identityKey,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Artist &&
          other.rowId == this.rowId &&
          other.publicId == this.publicId &&
          other.name == this.name &&
          other.sortName == this.sortName &&
          other.identityKey == this.identityKey &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ArtistsCompanion extends UpdateCompanion<Artist> {
  final Value<int> rowId;
  final Value<String> publicId;
  final Value<String> name;
  final Value<String> sortName;
  final Value<String> identityKey;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ArtistsCompanion({
    this.rowId = const Value.absent(),
    this.publicId = const Value.absent(),
    this.name = const Value.absent(),
    this.sortName = const Value.absent(),
    this.identityKey = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ArtistsCompanion.insert({
    this.rowId = const Value.absent(),
    required String publicId,
    required String name,
    required String sortName,
    required String identityKey,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : publicId = Value(publicId),
       name = Value(name),
       sortName = Value(sortName),
       identityKey = Value(identityKey),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Artist> custom({
    Expression<int>? rowId,
    Expression<String>? publicId,
    Expression<String>? name,
    Expression<String>? sortName,
    Expression<String>? identityKey,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (rowId != null) 'row_id': rowId,
      if (publicId != null) 'public_id': publicId,
      if (name != null) 'name': name,
      if (sortName != null) 'sort_name': sortName,
      if (identityKey != null) 'identity_key': identityKey,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ArtistsCompanion copyWith({
    Value<int>? rowId,
    Value<String>? publicId,
    Value<String>? name,
    Value<String>? sortName,
    Value<String>? identityKey,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ArtistsCompanion(
      rowId: rowId ?? this.rowId,
      publicId: publicId ?? this.publicId,
      name: name ?? this.name,
      sortName: sortName ?? this.sortName,
      identityKey: identityKey ?? this.identityKey,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (rowId.present) {
      map['row_id'] = Variable<int>(rowId.value);
    }
    if (publicId.present) {
      map['public_id'] = Variable<String>(publicId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortName.present) {
      map['sort_name'] = Variable<String>(sortName.value);
    }
    if (identityKey.present) {
      map['identity_key'] = Variable<String>(identityKey.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArtistsCompanion(')
          ..write('rowId: $rowId, ')
          ..write('publicId: $publicId, ')
          ..write('name: $name, ')
          ..write('sortName: $sortName, ')
          ..write('identityKey: $identityKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AlbumsTable extends Albums with TableInfo<$AlbumsTable, Album> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlbumsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _rowIdMeta = const VerificationMeta('rowId');
  @override
  late final GeneratedColumn<int> rowId = GeneratedColumn<int>(
    'row_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _publicIdMeta = const VerificationMeta(
    'publicId',
  );
  @override
  late final GeneratedColumn<String> publicId = GeneratedColumn<String>(
    'public_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortTitleMeta = const VerificationMeta(
    'sortTitle',
  );
  @override
  late final GeneratedColumn<String> sortTitle = GeneratedColumn<String>(
    'sort_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _identityKeyMeta = const VerificationMeta(
    'identityKey',
  );
  @override
  late final GeneratedColumn<String> identityKey = GeneratedColumn<String>(
    'identity_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _albumArtistIdMeta = const VerificationMeta(
    'albumArtistId',
  );
  @override
  late final GeneratedColumn<int> albumArtistId = GeneratedColumn<int>(
    'album_artist_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES artists (row_id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _releaseYearMeta = const VerificationMeta(
    'releaseYear',
  );
  @override
  late final GeneratedColumn<int> releaseYear = GeneratedColumn<int>(
    'release_year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artworkIdMeta = const VerificationMeta(
    'artworkId',
  );
  @override
  late final GeneratedColumn<int> artworkId = GeneratedColumn<int>(
    'artwork_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES artwork_assets (row_id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    rowId,
    publicId,
    title,
    sortTitle,
    identityKey,
    albumArtistId,
    releaseYear,
    artworkId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'albums';
  @override
  VerificationContext validateIntegrity(
    Insertable<Album> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('row_id')) {
      context.handle(
        _rowIdMeta,
        rowId.isAcceptableOrUnknown(data['row_id']!, _rowIdMeta),
      );
    }
    if (data.containsKey('public_id')) {
      context.handle(
        _publicIdMeta,
        publicId.isAcceptableOrUnknown(data['public_id']!, _publicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_publicIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('sort_title')) {
      context.handle(
        _sortTitleMeta,
        sortTitle.isAcceptableOrUnknown(data['sort_title']!, _sortTitleMeta),
      );
    } else if (isInserting) {
      context.missing(_sortTitleMeta);
    }
    if (data.containsKey('identity_key')) {
      context.handle(
        _identityKeyMeta,
        identityKey.isAcceptableOrUnknown(
          data['identity_key']!,
          _identityKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_identityKeyMeta);
    }
    if (data.containsKey('album_artist_id')) {
      context.handle(
        _albumArtistIdMeta,
        albumArtistId.isAcceptableOrUnknown(
          data['album_artist_id']!,
          _albumArtistIdMeta,
        ),
      );
    }
    if (data.containsKey('release_year')) {
      context.handle(
        _releaseYearMeta,
        releaseYear.isAcceptableOrUnknown(
          data['release_year']!,
          _releaseYearMeta,
        ),
      );
    }
    if (data.containsKey('artwork_id')) {
      context.handle(
        _artworkIdMeta,
        artworkId.isAcceptableOrUnknown(data['artwork_id']!, _artworkIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {rowId};
  @override
  Album map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Album(
      rowId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}row_id'],
      )!,
      publicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}public_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      sortTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sort_title'],
      )!,
      identityKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}identity_key'],
      )!,
      albumArtistId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}album_artist_id'],
      ),
      releaseYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}release_year'],
      ),
      artworkId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}artwork_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AlbumsTable createAlias(String alias) {
    return $AlbumsTable(attachedDatabase, alias);
  }
}

class Album extends DataClass implements Insertable<Album> {
  final int rowId;
  final String publicId;
  final String title;
  final String sortTitle;
  final String identityKey;
  final int? albumArtistId;
  final int? releaseYear;
  final int? artworkId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Album({
    required this.rowId,
    required this.publicId,
    required this.title,
    required this.sortTitle,
    required this.identityKey,
    this.albumArtistId,
    this.releaseYear,
    this.artworkId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['row_id'] = Variable<int>(rowId);
    map['public_id'] = Variable<String>(publicId);
    map['title'] = Variable<String>(title);
    map['sort_title'] = Variable<String>(sortTitle);
    map['identity_key'] = Variable<String>(identityKey);
    if (!nullToAbsent || albumArtistId != null) {
      map['album_artist_id'] = Variable<int>(albumArtistId);
    }
    if (!nullToAbsent || releaseYear != null) {
      map['release_year'] = Variable<int>(releaseYear);
    }
    if (!nullToAbsent || artworkId != null) {
      map['artwork_id'] = Variable<int>(artworkId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AlbumsCompanion toCompanion(bool nullToAbsent) {
    return AlbumsCompanion(
      rowId: Value(rowId),
      publicId: Value(publicId),
      title: Value(title),
      sortTitle: Value(sortTitle),
      identityKey: Value(identityKey),
      albumArtistId: albumArtistId == null && nullToAbsent
          ? const Value.absent()
          : Value(albumArtistId),
      releaseYear: releaseYear == null && nullToAbsent
          ? const Value.absent()
          : Value(releaseYear),
      artworkId: artworkId == null && nullToAbsent
          ? const Value.absent()
          : Value(artworkId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Album.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Album(
      rowId: serializer.fromJson<int>(json['rowId']),
      publicId: serializer.fromJson<String>(json['publicId']),
      title: serializer.fromJson<String>(json['title']),
      sortTitle: serializer.fromJson<String>(json['sortTitle']),
      identityKey: serializer.fromJson<String>(json['identityKey']),
      albumArtistId: serializer.fromJson<int?>(json['albumArtistId']),
      releaseYear: serializer.fromJson<int?>(json['releaseYear']),
      artworkId: serializer.fromJson<int?>(json['artworkId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'rowId': serializer.toJson<int>(rowId),
      'publicId': serializer.toJson<String>(publicId),
      'title': serializer.toJson<String>(title),
      'sortTitle': serializer.toJson<String>(sortTitle),
      'identityKey': serializer.toJson<String>(identityKey),
      'albumArtistId': serializer.toJson<int?>(albumArtistId),
      'releaseYear': serializer.toJson<int?>(releaseYear),
      'artworkId': serializer.toJson<int?>(artworkId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Album copyWith({
    int? rowId,
    String? publicId,
    String? title,
    String? sortTitle,
    String? identityKey,
    Value<int?> albumArtistId = const Value.absent(),
    Value<int?> releaseYear = const Value.absent(),
    Value<int?> artworkId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Album(
    rowId: rowId ?? this.rowId,
    publicId: publicId ?? this.publicId,
    title: title ?? this.title,
    sortTitle: sortTitle ?? this.sortTitle,
    identityKey: identityKey ?? this.identityKey,
    albumArtistId: albumArtistId.present
        ? albumArtistId.value
        : this.albumArtistId,
    releaseYear: releaseYear.present ? releaseYear.value : this.releaseYear,
    artworkId: artworkId.present ? artworkId.value : this.artworkId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Album copyWithCompanion(AlbumsCompanion data) {
    return Album(
      rowId: data.rowId.present ? data.rowId.value : this.rowId,
      publicId: data.publicId.present ? data.publicId.value : this.publicId,
      title: data.title.present ? data.title.value : this.title,
      sortTitle: data.sortTitle.present ? data.sortTitle.value : this.sortTitle,
      identityKey: data.identityKey.present
          ? data.identityKey.value
          : this.identityKey,
      albumArtistId: data.albumArtistId.present
          ? data.albumArtistId.value
          : this.albumArtistId,
      releaseYear: data.releaseYear.present
          ? data.releaseYear.value
          : this.releaseYear,
      artworkId: data.artworkId.present ? data.artworkId.value : this.artworkId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Album(')
          ..write('rowId: $rowId, ')
          ..write('publicId: $publicId, ')
          ..write('title: $title, ')
          ..write('sortTitle: $sortTitle, ')
          ..write('identityKey: $identityKey, ')
          ..write('albumArtistId: $albumArtistId, ')
          ..write('releaseYear: $releaseYear, ')
          ..write('artworkId: $artworkId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    rowId,
    publicId,
    title,
    sortTitle,
    identityKey,
    albumArtistId,
    releaseYear,
    artworkId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Album &&
          other.rowId == this.rowId &&
          other.publicId == this.publicId &&
          other.title == this.title &&
          other.sortTitle == this.sortTitle &&
          other.identityKey == this.identityKey &&
          other.albumArtistId == this.albumArtistId &&
          other.releaseYear == this.releaseYear &&
          other.artworkId == this.artworkId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AlbumsCompanion extends UpdateCompanion<Album> {
  final Value<int> rowId;
  final Value<String> publicId;
  final Value<String> title;
  final Value<String> sortTitle;
  final Value<String> identityKey;
  final Value<int?> albumArtistId;
  final Value<int?> releaseYear;
  final Value<int?> artworkId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const AlbumsCompanion({
    this.rowId = const Value.absent(),
    this.publicId = const Value.absent(),
    this.title = const Value.absent(),
    this.sortTitle = const Value.absent(),
    this.identityKey = const Value.absent(),
    this.albumArtistId = const Value.absent(),
    this.releaseYear = const Value.absent(),
    this.artworkId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AlbumsCompanion.insert({
    this.rowId = const Value.absent(),
    required String publicId,
    required String title,
    required String sortTitle,
    required String identityKey,
    this.albumArtistId = const Value.absent(),
    this.releaseYear = const Value.absent(),
    this.artworkId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : publicId = Value(publicId),
       title = Value(title),
       sortTitle = Value(sortTitle),
       identityKey = Value(identityKey),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Album> custom({
    Expression<int>? rowId,
    Expression<String>? publicId,
    Expression<String>? title,
    Expression<String>? sortTitle,
    Expression<String>? identityKey,
    Expression<int>? albumArtistId,
    Expression<int>? releaseYear,
    Expression<int>? artworkId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (rowId != null) 'row_id': rowId,
      if (publicId != null) 'public_id': publicId,
      if (title != null) 'title': title,
      if (sortTitle != null) 'sort_title': sortTitle,
      if (identityKey != null) 'identity_key': identityKey,
      if (albumArtistId != null) 'album_artist_id': albumArtistId,
      if (releaseYear != null) 'release_year': releaseYear,
      if (artworkId != null) 'artwork_id': artworkId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AlbumsCompanion copyWith({
    Value<int>? rowId,
    Value<String>? publicId,
    Value<String>? title,
    Value<String>? sortTitle,
    Value<String>? identityKey,
    Value<int?>? albumArtistId,
    Value<int?>? releaseYear,
    Value<int?>? artworkId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return AlbumsCompanion(
      rowId: rowId ?? this.rowId,
      publicId: publicId ?? this.publicId,
      title: title ?? this.title,
      sortTitle: sortTitle ?? this.sortTitle,
      identityKey: identityKey ?? this.identityKey,
      albumArtistId: albumArtistId ?? this.albumArtistId,
      releaseYear: releaseYear ?? this.releaseYear,
      artworkId: artworkId ?? this.artworkId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (rowId.present) {
      map['row_id'] = Variable<int>(rowId.value);
    }
    if (publicId.present) {
      map['public_id'] = Variable<String>(publicId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (sortTitle.present) {
      map['sort_title'] = Variable<String>(sortTitle.value);
    }
    if (identityKey.present) {
      map['identity_key'] = Variable<String>(identityKey.value);
    }
    if (albumArtistId.present) {
      map['album_artist_id'] = Variable<int>(albumArtistId.value);
    }
    if (releaseYear.present) {
      map['release_year'] = Variable<int>(releaseYear.value);
    }
    if (artworkId.present) {
      map['artwork_id'] = Variable<int>(artworkId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlbumsCompanion(')
          ..write('rowId: $rowId, ')
          ..write('publicId: $publicId, ')
          ..write('title: $title, ')
          ..write('sortTitle: $sortTitle, ')
          ..write('identityKey: $identityKey, ')
          ..write('albumArtistId: $albumArtistId, ')
          ..write('releaseYear: $releaseYear, ')
          ..write('artworkId: $artworkId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TracksTable extends Tracks with TableInfo<$TracksTable, Track> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TracksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _rowIdMeta = const VerificationMeta('rowId');
  @override
  late final GeneratedColumn<int> rowId = GeneratedColumn<int>(
    'row_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _publicIdMeta = const VerificationMeta(
    'publicId',
  );
  @override
  late final GeneratedColumn<String> publicId = GeneratedColumn<String>(
    'public_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _mediaFileIdMeta = const VerificationMeta(
    'mediaFileId',
  );
  @override
  late final GeneratedColumn<int> mediaFileId = GeneratedColumn<int>(
    'media_file_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES media_files (row_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortTitleMeta = const VerificationMeta(
    'sortTitle',
  );
  @override
  late final GeneratedColumn<String> sortTitle = GeneratedColumn<String>(
    'sort_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayArtistMeta = const VerificationMeta(
    'displayArtist',
  );
  @override
  late final GeneratedColumn<String> displayArtist = GeneratedColumn<String>(
    'display_artist',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _displayAlbumMeta = const VerificationMeta(
    'displayAlbum',
  );
  @override
  late final GeneratedColumn<String> displayAlbum = GeneratedColumn<String>(
    'display_album',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _albumIdMeta = const VerificationMeta(
    'albumId',
  );
  @override
  late final GeneratedColumn<int> albumId = GeneratedColumn<int>(
    'album_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES albums (row_id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _durationMsMeta = const VerificationMeta(
    'durationMs',
  );
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
    'duration_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bitrateBpsMeta = const VerificationMeta(
    'bitrateBps',
  );
  @override
  late final GeneratedColumn<int> bitrateBps = GeneratedColumn<int>(
    'bitrate_bps',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sampleRateHzMeta = const VerificationMeta(
    'sampleRateHz',
  );
  @override
  late final GeneratedColumn<int> sampleRateHz = GeneratedColumn<int>(
    'sample_rate_hz',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _trackNumberMeta = const VerificationMeta(
    'trackNumber',
  );
  @override
  late final GeneratedColumn<int> trackNumber = GeneratedColumn<int>(
    'track_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _trackTotalMeta = const VerificationMeta(
    'trackTotal',
  );
  @override
  late final GeneratedColumn<int> trackTotal = GeneratedColumn<int>(
    'track_total',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _discNumberMeta = const VerificationMeta(
    'discNumber',
  );
  @override
  late final GeneratedColumn<int> discNumber = GeneratedColumn<int>(
    'disc_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _discTotalMeta = const VerificationMeta(
    'discTotal',
  );
  @override
  late final GeneratedColumn<int> discTotal = GeneratedColumn<int>(
    'disc_total',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _releaseYearMeta = const VerificationMeta(
    'releaseYear',
  );
  @override
  late final GeneratedColumn<int> releaseYear = GeneratedColumn<int>(
    'release_year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _metadataSourceMeta = const VerificationMeta(
    'metadataSource',
  );
  @override
  late final GeneratedColumn<String> metadataSource = GeneratedColumn<String>(
    'metadata_source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _metadataRevisionMeta = const VerificationMeta(
    'metadataRevision',
  );
  @override
  late final GeneratedColumn<int> metadataRevision = GeneratedColumn<int>(
    'metadata_revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _searchTextMeta = const VerificationMeta(
    'searchText',
  );
  @override
  late final GeneratedColumn<String> searchText = GeneratedColumn<String>(
    'search_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _artworkIdMeta = const VerificationMeta(
    'artworkId',
  );
  @override
  late final GeneratedColumn<int> artworkId = GeneratedColumn<int>(
    'artwork_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES artwork_assets (row_id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    rowId,
    publicId,
    mediaFileId,
    title,
    sortTitle,
    displayArtist,
    displayAlbum,
    albumId,
    durationMs,
    bitrateBps,
    sampleRateHz,
    trackNumber,
    trackTotal,
    discNumber,
    discTotal,
    releaseYear,
    language,
    metadataSource,
    metadataRevision,
    searchText,
    artworkId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tracks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Track> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('row_id')) {
      context.handle(
        _rowIdMeta,
        rowId.isAcceptableOrUnknown(data['row_id']!, _rowIdMeta),
      );
    }
    if (data.containsKey('public_id')) {
      context.handle(
        _publicIdMeta,
        publicId.isAcceptableOrUnknown(data['public_id']!, _publicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_publicIdMeta);
    }
    if (data.containsKey('media_file_id')) {
      context.handle(
        _mediaFileIdMeta,
        mediaFileId.isAcceptableOrUnknown(
          data['media_file_id']!,
          _mediaFileIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mediaFileIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('sort_title')) {
      context.handle(
        _sortTitleMeta,
        sortTitle.isAcceptableOrUnknown(data['sort_title']!, _sortTitleMeta),
      );
    } else if (isInserting) {
      context.missing(_sortTitleMeta);
    }
    if (data.containsKey('display_artist')) {
      context.handle(
        _displayArtistMeta,
        displayArtist.isAcceptableOrUnknown(
          data['display_artist']!,
          _displayArtistMeta,
        ),
      );
    }
    if (data.containsKey('display_album')) {
      context.handle(
        _displayAlbumMeta,
        displayAlbum.isAcceptableOrUnknown(
          data['display_album']!,
          _displayAlbumMeta,
        ),
      );
    }
    if (data.containsKey('album_id')) {
      context.handle(
        _albumIdMeta,
        albumId.isAcceptableOrUnknown(data['album_id']!, _albumIdMeta),
      );
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
        _durationMsMeta,
        durationMs.isAcceptableOrUnknown(data['duration_ms']!, _durationMsMeta),
      );
    }
    if (data.containsKey('bitrate_bps')) {
      context.handle(
        _bitrateBpsMeta,
        bitrateBps.isAcceptableOrUnknown(data['bitrate_bps']!, _bitrateBpsMeta),
      );
    }
    if (data.containsKey('sample_rate_hz')) {
      context.handle(
        _sampleRateHzMeta,
        sampleRateHz.isAcceptableOrUnknown(
          data['sample_rate_hz']!,
          _sampleRateHzMeta,
        ),
      );
    }
    if (data.containsKey('track_number')) {
      context.handle(
        _trackNumberMeta,
        trackNumber.isAcceptableOrUnknown(
          data['track_number']!,
          _trackNumberMeta,
        ),
      );
    }
    if (data.containsKey('track_total')) {
      context.handle(
        _trackTotalMeta,
        trackTotal.isAcceptableOrUnknown(data['track_total']!, _trackTotalMeta),
      );
    }
    if (data.containsKey('disc_number')) {
      context.handle(
        _discNumberMeta,
        discNumber.isAcceptableOrUnknown(data['disc_number']!, _discNumberMeta),
      );
    }
    if (data.containsKey('disc_total')) {
      context.handle(
        _discTotalMeta,
        discTotal.isAcceptableOrUnknown(data['disc_total']!, _discTotalMeta),
      );
    }
    if (data.containsKey('release_year')) {
      context.handle(
        _releaseYearMeta,
        releaseYear.isAcceptableOrUnknown(
          data['release_year']!,
          _releaseYearMeta,
        ),
      );
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    }
    if (data.containsKey('metadata_source')) {
      context.handle(
        _metadataSourceMeta,
        metadataSource.isAcceptableOrUnknown(
          data['metadata_source']!,
          _metadataSourceMeta,
        ),
      );
    }
    if (data.containsKey('metadata_revision')) {
      context.handle(
        _metadataRevisionMeta,
        metadataRevision.isAcceptableOrUnknown(
          data['metadata_revision']!,
          _metadataRevisionMeta,
        ),
      );
    }
    if (data.containsKey('search_text')) {
      context.handle(
        _searchTextMeta,
        searchText.isAcceptableOrUnknown(data['search_text']!, _searchTextMeta),
      );
    } else if (isInserting) {
      context.missing(_searchTextMeta);
    }
    if (data.containsKey('artwork_id')) {
      context.handle(
        _artworkIdMeta,
        artworkId.isAcceptableOrUnknown(data['artwork_id']!, _artworkIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {rowId};
  @override
  Track map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Track(
      rowId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}row_id'],
      )!,
      publicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}public_id'],
      )!,
      mediaFileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}media_file_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      sortTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sort_title'],
      )!,
      displayArtist: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_artist'],
      ),
      displayAlbum: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_album'],
      ),
      albumId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}album_id'],
      ),
      durationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_ms'],
      ),
      bitrateBps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bitrate_bps'],
      ),
      sampleRateHz: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sample_rate_hz'],
      ),
      trackNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}track_number'],
      ),
      trackTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}track_total'],
      ),
      discNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}disc_number'],
      ),
      discTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}disc_total'],
      ),
      releaseYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}release_year'],
      ),
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      ),
      metadataSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_source'],
      ),
      metadataRevision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}metadata_revision'],
      )!,
      searchText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}search_text'],
      )!,
      artworkId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}artwork_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TracksTable createAlias(String alias) {
    return $TracksTable(attachedDatabase, alias);
  }
}

class Track extends DataClass implements Insertable<Track> {
  final int rowId;
  final String publicId;
  final int mediaFileId;
  final String title;
  final String sortTitle;
  final String? displayArtist;
  final String? displayAlbum;
  final int? albumId;
  final int? durationMs;
  final int? bitrateBps;
  final int? sampleRateHz;
  final int? trackNumber;
  final int? trackTotal;
  final int? discNumber;
  final int? discTotal;
  final int? releaseYear;
  final String? language;
  final String? metadataSource;
  final int metadataRevision;
  final String searchText;
  final int? artworkId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Track({
    required this.rowId,
    required this.publicId,
    required this.mediaFileId,
    required this.title,
    required this.sortTitle,
    this.displayArtist,
    this.displayAlbum,
    this.albumId,
    this.durationMs,
    this.bitrateBps,
    this.sampleRateHz,
    this.trackNumber,
    this.trackTotal,
    this.discNumber,
    this.discTotal,
    this.releaseYear,
    this.language,
    this.metadataSource,
    required this.metadataRevision,
    required this.searchText,
    this.artworkId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['row_id'] = Variable<int>(rowId);
    map['public_id'] = Variable<String>(publicId);
    map['media_file_id'] = Variable<int>(mediaFileId);
    map['title'] = Variable<String>(title);
    map['sort_title'] = Variable<String>(sortTitle);
    if (!nullToAbsent || displayArtist != null) {
      map['display_artist'] = Variable<String>(displayArtist);
    }
    if (!nullToAbsent || displayAlbum != null) {
      map['display_album'] = Variable<String>(displayAlbum);
    }
    if (!nullToAbsent || albumId != null) {
      map['album_id'] = Variable<int>(albumId);
    }
    if (!nullToAbsent || durationMs != null) {
      map['duration_ms'] = Variable<int>(durationMs);
    }
    if (!nullToAbsent || bitrateBps != null) {
      map['bitrate_bps'] = Variable<int>(bitrateBps);
    }
    if (!nullToAbsent || sampleRateHz != null) {
      map['sample_rate_hz'] = Variable<int>(sampleRateHz);
    }
    if (!nullToAbsent || trackNumber != null) {
      map['track_number'] = Variable<int>(trackNumber);
    }
    if (!nullToAbsent || trackTotal != null) {
      map['track_total'] = Variable<int>(trackTotal);
    }
    if (!nullToAbsent || discNumber != null) {
      map['disc_number'] = Variable<int>(discNumber);
    }
    if (!nullToAbsent || discTotal != null) {
      map['disc_total'] = Variable<int>(discTotal);
    }
    if (!nullToAbsent || releaseYear != null) {
      map['release_year'] = Variable<int>(releaseYear);
    }
    if (!nullToAbsent || language != null) {
      map['language'] = Variable<String>(language);
    }
    if (!nullToAbsent || metadataSource != null) {
      map['metadata_source'] = Variable<String>(metadataSource);
    }
    map['metadata_revision'] = Variable<int>(metadataRevision);
    map['search_text'] = Variable<String>(searchText);
    if (!nullToAbsent || artworkId != null) {
      map['artwork_id'] = Variable<int>(artworkId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TracksCompanion toCompanion(bool nullToAbsent) {
    return TracksCompanion(
      rowId: Value(rowId),
      publicId: Value(publicId),
      mediaFileId: Value(mediaFileId),
      title: Value(title),
      sortTitle: Value(sortTitle),
      displayArtist: displayArtist == null && nullToAbsent
          ? const Value.absent()
          : Value(displayArtist),
      displayAlbum: displayAlbum == null && nullToAbsent
          ? const Value.absent()
          : Value(displayAlbum),
      albumId: albumId == null && nullToAbsent
          ? const Value.absent()
          : Value(albumId),
      durationMs: durationMs == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMs),
      bitrateBps: bitrateBps == null && nullToAbsent
          ? const Value.absent()
          : Value(bitrateBps),
      sampleRateHz: sampleRateHz == null && nullToAbsent
          ? const Value.absent()
          : Value(sampleRateHz),
      trackNumber: trackNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(trackNumber),
      trackTotal: trackTotal == null && nullToAbsent
          ? const Value.absent()
          : Value(trackTotal),
      discNumber: discNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(discNumber),
      discTotal: discTotal == null && nullToAbsent
          ? const Value.absent()
          : Value(discTotal),
      releaseYear: releaseYear == null && nullToAbsent
          ? const Value.absent()
          : Value(releaseYear),
      language: language == null && nullToAbsent
          ? const Value.absent()
          : Value(language),
      metadataSource: metadataSource == null && nullToAbsent
          ? const Value.absent()
          : Value(metadataSource),
      metadataRevision: Value(metadataRevision),
      searchText: Value(searchText),
      artworkId: artworkId == null && nullToAbsent
          ? const Value.absent()
          : Value(artworkId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Track.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Track(
      rowId: serializer.fromJson<int>(json['rowId']),
      publicId: serializer.fromJson<String>(json['publicId']),
      mediaFileId: serializer.fromJson<int>(json['mediaFileId']),
      title: serializer.fromJson<String>(json['title']),
      sortTitle: serializer.fromJson<String>(json['sortTitle']),
      displayArtist: serializer.fromJson<String?>(json['displayArtist']),
      displayAlbum: serializer.fromJson<String?>(json['displayAlbum']),
      albumId: serializer.fromJson<int?>(json['albumId']),
      durationMs: serializer.fromJson<int?>(json['durationMs']),
      bitrateBps: serializer.fromJson<int?>(json['bitrateBps']),
      sampleRateHz: serializer.fromJson<int?>(json['sampleRateHz']),
      trackNumber: serializer.fromJson<int?>(json['trackNumber']),
      trackTotal: serializer.fromJson<int?>(json['trackTotal']),
      discNumber: serializer.fromJson<int?>(json['discNumber']),
      discTotal: serializer.fromJson<int?>(json['discTotal']),
      releaseYear: serializer.fromJson<int?>(json['releaseYear']),
      language: serializer.fromJson<String?>(json['language']),
      metadataSource: serializer.fromJson<String?>(json['metadataSource']),
      metadataRevision: serializer.fromJson<int>(json['metadataRevision']),
      searchText: serializer.fromJson<String>(json['searchText']),
      artworkId: serializer.fromJson<int?>(json['artworkId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'rowId': serializer.toJson<int>(rowId),
      'publicId': serializer.toJson<String>(publicId),
      'mediaFileId': serializer.toJson<int>(mediaFileId),
      'title': serializer.toJson<String>(title),
      'sortTitle': serializer.toJson<String>(sortTitle),
      'displayArtist': serializer.toJson<String?>(displayArtist),
      'displayAlbum': serializer.toJson<String?>(displayAlbum),
      'albumId': serializer.toJson<int?>(albumId),
      'durationMs': serializer.toJson<int?>(durationMs),
      'bitrateBps': serializer.toJson<int?>(bitrateBps),
      'sampleRateHz': serializer.toJson<int?>(sampleRateHz),
      'trackNumber': serializer.toJson<int?>(trackNumber),
      'trackTotal': serializer.toJson<int?>(trackTotal),
      'discNumber': serializer.toJson<int?>(discNumber),
      'discTotal': serializer.toJson<int?>(discTotal),
      'releaseYear': serializer.toJson<int?>(releaseYear),
      'language': serializer.toJson<String?>(language),
      'metadataSource': serializer.toJson<String?>(metadataSource),
      'metadataRevision': serializer.toJson<int>(metadataRevision),
      'searchText': serializer.toJson<String>(searchText),
      'artworkId': serializer.toJson<int?>(artworkId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Track copyWith({
    int? rowId,
    String? publicId,
    int? mediaFileId,
    String? title,
    String? sortTitle,
    Value<String?> displayArtist = const Value.absent(),
    Value<String?> displayAlbum = const Value.absent(),
    Value<int?> albumId = const Value.absent(),
    Value<int?> durationMs = const Value.absent(),
    Value<int?> bitrateBps = const Value.absent(),
    Value<int?> sampleRateHz = const Value.absent(),
    Value<int?> trackNumber = const Value.absent(),
    Value<int?> trackTotal = const Value.absent(),
    Value<int?> discNumber = const Value.absent(),
    Value<int?> discTotal = const Value.absent(),
    Value<int?> releaseYear = const Value.absent(),
    Value<String?> language = const Value.absent(),
    Value<String?> metadataSource = const Value.absent(),
    int? metadataRevision,
    String? searchText,
    Value<int?> artworkId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Track(
    rowId: rowId ?? this.rowId,
    publicId: publicId ?? this.publicId,
    mediaFileId: mediaFileId ?? this.mediaFileId,
    title: title ?? this.title,
    sortTitle: sortTitle ?? this.sortTitle,
    displayArtist: displayArtist.present
        ? displayArtist.value
        : this.displayArtist,
    displayAlbum: displayAlbum.present ? displayAlbum.value : this.displayAlbum,
    albumId: albumId.present ? albumId.value : this.albumId,
    durationMs: durationMs.present ? durationMs.value : this.durationMs,
    bitrateBps: bitrateBps.present ? bitrateBps.value : this.bitrateBps,
    sampleRateHz: sampleRateHz.present ? sampleRateHz.value : this.sampleRateHz,
    trackNumber: trackNumber.present ? trackNumber.value : this.trackNumber,
    trackTotal: trackTotal.present ? trackTotal.value : this.trackTotal,
    discNumber: discNumber.present ? discNumber.value : this.discNumber,
    discTotal: discTotal.present ? discTotal.value : this.discTotal,
    releaseYear: releaseYear.present ? releaseYear.value : this.releaseYear,
    language: language.present ? language.value : this.language,
    metadataSource: metadataSource.present
        ? metadataSource.value
        : this.metadataSource,
    metadataRevision: metadataRevision ?? this.metadataRevision,
    searchText: searchText ?? this.searchText,
    artworkId: artworkId.present ? artworkId.value : this.artworkId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Track copyWithCompanion(TracksCompanion data) {
    return Track(
      rowId: data.rowId.present ? data.rowId.value : this.rowId,
      publicId: data.publicId.present ? data.publicId.value : this.publicId,
      mediaFileId: data.mediaFileId.present
          ? data.mediaFileId.value
          : this.mediaFileId,
      title: data.title.present ? data.title.value : this.title,
      sortTitle: data.sortTitle.present ? data.sortTitle.value : this.sortTitle,
      displayArtist: data.displayArtist.present
          ? data.displayArtist.value
          : this.displayArtist,
      displayAlbum: data.displayAlbum.present
          ? data.displayAlbum.value
          : this.displayAlbum,
      albumId: data.albumId.present ? data.albumId.value : this.albumId,
      durationMs: data.durationMs.present
          ? data.durationMs.value
          : this.durationMs,
      bitrateBps: data.bitrateBps.present
          ? data.bitrateBps.value
          : this.bitrateBps,
      sampleRateHz: data.sampleRateHz.present
          ? data.sampleRateHz.value
          : this.sampleRateHz,
      trackNumber: data.trackNumber.present
          ? data.trackNumber.value
          : this.trackNumber,
      trackTotal: data.trackTotal.present
          ? data.trackTotal.value
          : this.trackTotal,
      discNumber: data.discNumber.present
          ? data.discNumber.value
          : this.discNumber,
      discTotal: data.discTotal.present ? data.discTotal.value : this.discTotal,
      releaseYear: data.releaseYear.present
          ? data.releaseYear.value
          : this.releaseYear,
      language: data.language.present ? data.language.value : this.language,
      metadataSource: data.metadataSource.present
          ? data.metadataSource.value
          : this.metadataSource,
      metadataRevision: data.metadataRevision.present
          ? data.metadataRevision.value
          : this.metadataRevision,
      searchText: data.searchText.present
          ? data.searchText.value
          : this.searchText,
      artworkId: data.artworkId.present ? data.artworkId.value : this.artworkId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Track(')
          ..write('rowId: $rowId, ')
          ..write('publicId: $publicId, ')
          ..write('mediaFileId: $mediaFileId, ')
          ..write('title: $title, ')
          ..write('sortTitle: $sortTitle, ')
          ..write('displayArtist: $displayArtist, ')
          ..write('displayAlbum: $displayAlbum, ')
          ..write('albumId: $albumId, ')
          ..write('durationMs: $durationMs, ')
          ..write('bitrateBps: $bitrateBps, ')
          ..write('sampleRateHz: $sampleRateHz, ')
          ..write('trackNumber: $trackNumber, ')
          ..write('trackTotal: $trackTotal, ')
          ..write('discNumber: $discNumber, ')
          ..write('discTotal: $discTotal, ')
          ..write('releaseYear: $releaseYear, ')
          ..write('language: $language, ')
          ..write('metadataSource: $metadataSource, ')
          ..write('metadataRevision: $metadataRevision, ')
          ..write('searchText: $searchText, ')
          ..write('artworkId: $artworkId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    rowId,
    publicId,
    mediaFileId,
    title,
    sortTitle,
    displayArtist,
    displayAlbum,
    albumId,
    durationMs,
    bitrateBps,
    sampleRateHz,
    trackNumber,
    trackTotal,
    discNumber,
    discTotal,
    releaseYear,
    language,
    metadataSource,
    metadataRevision,
    searchText,
    artworkId,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Track &&
          other.rowId == this.rowId &&
          other.publicId == this.publicId &&
          other.mediaFileId == this.mediaFileId &&
          other.title == this.title &&
          other.sortTitle == this.sortTitle &&
          other.displayArtist == this.displayArtist &&
          other.displayAlbum == this.displayAlbum &&
          other.albumId == this.albumId &&
          other.durationMs == this.durationMs &&
          other.bitrateBps == this.bitrateBps &&
          other.sampleRateHz == this.sampleRateHz &&
          other.trackNumber == this.trackNumber &&
          other.trackTotal == this.trackTotal &&
          other.discNumber == this.discNumber &&
          other.discTotal == this.discTotal &&
          other.releaseYear == this.releaseYear &&
          other.language == this.language &&
          other.metadataSource == this.metadataSource &&
          other.metadataRevision == this.metadataRevision &&
          other.searchText == this.searchText &&
          other.artworkId == this.artworkId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TracksCompanion extends UpdateCompanion<Track> {
  final Value<int> rowId;
  final Value<String> publicId;
  final Value<int> mediaFileId;
  final Value<String> title;
  final Value<String> sortTitle;
  final Value<String?> displayArtist;
  final Value<String?> displayAlbum;
  final Value<int?> albumId;
  final Value<int?> durationMs;
  final Value<int?> bitrateBps;
  final Value<int?> sampleRateHz;
  final Value<int?> trackNumber;
  final Value<int?> trackTotal;
  final Value<int?> discNumber;
  final Value<int?> discTotal;
  final Value<int?> releaseYear;
  final Value<String?> language;
  final Value<String?> metadataSource;
  final Value<int> metadataRevision;
  final Value<String> searchText;
  final Value<int?> artworkId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TracksCompanion({
    this.rowId = const Value.absent(),
    this.publicId = const Value.absent(),
    this.mediaFileId = const Value.absent(),
    this.title = const Value.absent(),
    this.sortTitle = const Value.absent(),
    this.displayArtist = const Value.absent(),
    this.displayAlbum = const Value.absent(),
    this.albumId = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.bitrateBps = const Value.absent(),
    this.sampleRateHz = const Value.absent(),
    this.trackNumber = const Value.absent(),
    this.trackTotal = const Value.absent(),
    this.discNumber = const Value.absent(),
    this.discTotal = const Value.absent(),
    this.releaseYear = const Value.absent(),
    this.language = const Value.absent(),
    this.metadataSource = const Value.absent(),
    this.metadataRevision = const Value.absent(),
    this.searchText = const Value.absent(),
    this.artworkId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TracksCompanion.insert({
    this.rowId = const Value.absent(),
    required String publicId,
    required int mediaFileId,
    required String title,
    required String sortTitle,
    this.displayArtist = const Value.absent(),
    this.displayAlbum = const Value.absent(),
    this.albumId = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.bitrateBps = const Value.absent(),
    this.sampleRateHz = const Value.absent(),
    this.trackNumber = const Value.absent(),
    this.trackTotal = const Value.absent(),
    this.discNumber = const Value.absent(),
    this.discTotal = const Value.absent(),
    this.releaseYear = const Value.absent(),
    this.language = const Value.absent(),
    this.metadataSource = const Value.absent(),
    this.metadataRevision = const Value.absent(),
    required String searchText,
    this.artworkId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : publicId = Value(publicId),
       mediaFileId = Value(mediaFileId),
       title = Value(title),
       sortTitle = Value(sortTitle),
       searchText = Value(searchText),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Track> custom({
    Expression<int>? rowId,
    Expression<String>? publicId,
    Expression<int>? mediaFileId,
    Expression<String>? title,
    Expression<String>? sortTitle,
    Expression<String>? displayArtist,
    Expression<String>? displayAlbum,
    Expression<int>? albumId,
    Expression<int>? durationMs,
    Expression<int>? bitrateBps,
    Expression<int>? sampleRateHz,
    Expression<int>? trackNumber,
    Expression<int>? trackTotal,
    Expression<int>? discNumber,
    Expression<int>? discTotal,
    Expression<int>? releaseYear,
    Expression<String>? language,
    Expression<String>? metadataSource,
    Expression<int>? metadataRevision,
    Expression<String>? searchText,
    Expression<int>? artworkId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (rowId != null) 'row_id': rowId,
      if (publicId != null) 'public_id': publicId,
      if (mediaFileId != null) 'media_file_id': mediaFileId,
      if (title != null) 'title': title,
      if (sortTitle != null) 'sort_title': sortTitle,
      if (displayArtist != null) 'display_artist': displayArtist,
      if (displayAlbum != null) 'display_album': displayAlbum,
      if (albumId != null) 'album_id': albumId,
      if (durationMs != null) 'duration_ms': durationMs,
      if (bitrateBps != null) 'bitrate_bps': bitrateBps,
      if (sampleRateHz != null) 'sample_rate_hz': sampleRateHz,
      if (trackNumber != null) 'track_number': trackNumber,
      if (trackTotal != null) 'track_total': trackTotal,
      if (discNumber != null) 'disc_number': discNumber,
      if (discTotal != null) 'disc_total': discTotal,
      if (releaseYear != null) 'release_year': releaseYear,
      if (language != null) 'language': language,
      if (metadataSource != null) 'metadata_source': metadataSource,
      if (metadataRevision != null) 'metadata_revision': metadataRevision,
      if (searchText != null) 'search_text': searchText,
      if (artworkId != null) 'artwork_id': artworkId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TracksCompanion copyWith({
    Value<int>? rowId,
    Value<String>? publicId,
    Value<int>? mediaFileId,
    Value<String>? title,
    Value<String>? sortTitle,
    Value<String?>? displayArtist,
    Value<String?>? displayAlbum,
    Value<int?>? albumId,
    Value<int?>? durationMs,
    Value<int?>? bitrateBps,
    Value<int?>? sampleRateHz,
    Value<int?>? trackNumber,
    Value<int?>? trackTotal,
    Value<int?>? discNumber,
    Value<int?>? discTotal,
    Value<int?>? releaseYear,
    Value<String?>? language,
    Value<String?>? metadataSource,
    Value<int>? metadataRevision,
    Value<String>? searchText,
    Value<int?>? artworkId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return TracksCompanion(
      rowId: rowId ?? this.rowId,
      publicId: publicId ?? this.publicId,
      mediaFileId: mediaFileId ?? this.mediaFileId,
      title: title ?? this.title,
      sortTitle: sortTitle ?? this.sortTitle,
      displayArtist: displayArtist ?? this.displayArtist,
      displayAlbum: displayAlbum ?? this.displayAlbum,
      albumId: albumId ?? this.albumId,
      durationMs: durationMs ?? this.durationMs,
      bitrateBps: bitrateBps ?? this.bitrateBps,
      sampleRateHz: sampleRateHz ?? this.sampleRateHz,
      trackNumber: trackNumber ?? this.trackNumber,
      trackTotal: trackTotal ?? this.trackTotal,
      discNumber: discNumber ?? this.discNumber,
      discTotal: discTotal ?? this.discTotal,
      releaseYear: releaseYear ?? this.releaseYear,
      language: language ?? this.language,
      metadataSource: metadataSource ?? this.metadataSource,
      metadataRevision: metadataRevision ?? this.metadataRevision,
      searchText: searchText ?? this.searchText,
      artworkId: artworkId ?? this.artworkId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (rowId.present) {
      map['row_id'] = Variable<int>(rowId.value);
    }
    if (publicId.present) {
      map['public_id'] = Variable<String>(publicId.value);
    }
    if (mediaFileId.present) {
      map['media_file_id'] = Variable<int>(mediaFileId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (sortTitle.present) {
      map['sort_title'] = Variable<String>(sortTitle.value);
    }
    if (displayArtist.present) {
      map['display_artist'] = Variable<String>(displayArtist.value);
    }
    if (displayAlbum.present) {
      map['display_album'] = Variable<String>(displayAlbum.value);
    }
    if (albumId.present) {
      map['album_id'] = Variable<int>(albumId.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (bitrateBps.present) {
      map['bitrate_bps'] = Variable<int>(bitrateBps.value);
    }
    if (sampleRateHz.present) {
      map['sample_rate_hz'] = Variable<int>(sampleRateHz.value);
    }
    if (trackNumber.present) {
      map['track_number'] = Variable<int>(trackNumber.value);
    }
    if (trackTotal.present) {
      map['track_total'] = Variable<int>(trackTotal.value);
    }
    if (discNumber.present) {
      map['disc_number'] = Variable<int>(discNumber.value);
    }
    if (discTotal.present) {
      map['disc_total'] = Variable<int>(discTotal.value);
    }
    if (releaseYear.present) {
      map['release_year'] = Variable<int>(releaseYear.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (metadataSource.present) {
      map['metadata_source'] = Variable<String>(metadataSource.value);
    }
    if (metadataRevision.present) {
      map['metadata_revision'] = Variable<int>(metadataRevision.value);
    }
    if (searchText.present) {
      map['search_text'] = Variable<String>(searchText.value);
    }
    if (artworkId.present) {
      map['artwork_id'] = Variable<int>(artworkId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TracksCompanion(')
          ..write('rowId: $rowId, ')
          ..write('publicId: $publicId, ')
          ..write('mediaFileId: $mediaFileId, ')
          ..write('title: $title, ')
          ..write('sortTitle: $sortTitle, ')
          ..write('displayArtist: $displayArtist, ')
          ..write('displayAlbum: $displayAlbum, ')
          ..write('albumId: $albumId, ')
          ..write('durationMs: $durationMs, ')
          ..write('bitrateBps: $bitrateBps, ')
          ..write('sampleRateHz: $sampleRateHz, ')
          ..write('trackNumber: $trackNumber, ')
          ..write('trackTotal: $trackTotal, ')
          ..write('discNumber: $discNumber, ')
          ..write('discTotal: $discTotal, ')
          ..write('releaseYear: $releaseYear, ')
          ..write('language: $language, ')
          ..write('metadataSource: $metadataSource, ')
          ..write('metadataRevision: $metadataRevision, ')
          ..write('searchText: $searchText, ')
          ..write('artworkId: $artworkId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TrackArtistsTable extends TrackArtists
    with TableInfo<$TrackArtistsTable, TrackArtist> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrackArtistsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _trackIdMeta = const VerificationMeta(
    'trackId',
  );
  @override
  late final GeneratedColumn<int> trackId = GeneratedColumn<int>(
    'track_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tracks (row_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _artistIdMeta = const VerificationMeta(
    'artistId',
  );
  @override
  late final GeneratedColumn<int> artistId = GeneratedColumn<int>(
    'artist_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES artists (row_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [trackId, artistId, role, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'track_artists';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrackArtist> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('track_id')) {
      context.handle(
        _trackIdMeta,
        trackId.isAcceptableOrUnknown(data['track_id']!, _trackIdMeta),
      );
    } else if (isInserting) {
      context.missing(_trackIdMeta);
    }
    if (data.containsKey('artist_id')) {
      context.handle(
        _artistIdMeta,
        artistId.isAcceptableOrUnknown(data['artist_id']!, _artistIdMeta),
      );
    } else if (isInserting) {
      context.missing(_artistIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {trackId, artistId, role};
  @override
  TrackArtist map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrackArtist(
      trackId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}track_id'],
      )!,
      artistId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}artist_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  $TrackArtistsTable createAlias(String alias) {
    return $TrackArtistsTable(attachedDatabase, alias);
  }
}

class TrackArtist extends DataClass implements Insertable<TrackArtist> {
  final int trackId;
  final int artistId;
  final String role;
  final int position;
  const TrackArtist({
    required this.trackId,
    required this.artistId,
    required this.role,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['track_id'] = Variable<int>(trackId);
    map['artist_id'] = Variable<int>(artistId);
    map['role'] = Variable<String>(role);
    map['position'] = Variable<int>(position);
    return map;
  }

  TrackArtistsCompanion toCompanion(bool nullToAbsent) {
    return TrackArtistsCompanion(
      trackId: Value(trackId),
      artistId: Value(artistId),
      role: Value(role),
      position: Value(position),
    );
  }

  factory TrackArtist.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrackArtist(
      trackId: serializer.fromJson<int>(json['trackId']),
      artistId: serializer.fromJson<int>(json['artistId']),
      role: serializer.fromJson<String>(json['role']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'trackId': serializer.toJson<int>(trackId),
      'artistId': serializer.toJson<int>(artistId),
      'role': serializer.toJson<String>(role),
      'position': serializer.toJson<int>(position),
    };
  }

  TrackArtist copyWith({
    int? trackId,
    int? artistId,
    String? role,
    int? position,
  }) => TrackArtist(
    trackId: trackId ?? this.trackId,
    artistId: artistId ?? this.artistId,
    role: role ?? this.role,
    position: position ?? this.position,
  );
  TrackArtist copyWithCompanion(TrackArtistsCompanion data) {
    return TrackArtist(
      trackId: data.trackId.present ? data.trackId.value : this.trackId,
      artistId: data.artistId.present ? data.artistId.value : this.artistId,
      role: data.role.present ? data.role.value : this.role,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrackArtist(')
          ..write('trackId: $trackId, ')
          ..write('artistId: $artistId, ')
          ..write('role: $role, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(trackId, artistId, role, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrackArtist &&
          other.trackId == this.trackId &&
          other.artistId == this.artistId &&
          other.role == this.role &&
          other.position == this.position);
}

class TrackArtistsCompanion extends UpdateCompanion<TrackArtist> {
  final Value<int> trackId;
  final Value<int> artistId;
  final Value<String> role;
  final Value<int> position;
  final Value<int> rowid;
  const TrackArtistsCompanion({
    this.trackId = const Value.absent(),
    this.artistId = const Value.absent(),
    this.role = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrackArtistsCompanion.insert({
    required int trackId,
    required int artistId,
    required String role,
    required int position,
    this.rowid = const Value.absent(),
  }) : trackId = Value(trackId),
       artistId = Value(artistId),
       role = Value(role),
       position = Value(position);
  static Insertable<TrackArtist> custom({
    Expression<int>? trackId,
    Expression<int>? artistId,
    Expression<String>? role,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (trackId != null) 'track_id': trackId,
      if (artistId != null) 'artist_id': artistId,
      if (role != null) 'role': role,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrackArtistsCompanion copyWith({
    Value<int>? trackId,
    Value<int>? artistId,
    Value<String>? role,
    Value<int>? position,
    Value<int>? rowid,
  }) {
    return TrackArtistsCompanion(
      trackId: trackId ?? this.trackId,
      artistId: artistId ?? this.artistId,
      role: role ?? this.role,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (trackId.present) {
      map['track_id'] = Variable<int>(trackId.value);
    }
    if (artistId.present) {
      map['artist_id'] = Variable<int>(artistId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrackArtistsCompanion(')
          ..write('trackId: $trackId, ')
          ..write('artistId: $artistId, ')
          ..write('role: $role, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GenresTable extends Genres with TableInfo<$GenresTable, Genre> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GenresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _rowIdMeta = const VerificationMeta('rowId');
  @override
  late final GeneratedColumn<int> rowId = GeneratedColumn<int>(
    'row_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _publicIdMeta = const VerificationMeta(
    'publicId',
  );
  @override
  late final GeneratedColumn<String> publicId = GeneratedColumn<String>(
    'public_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _identityKeyMeta = const VerificationMeta(
    'identityKey',
  );
  @override
  late final GeneratedColumn<String> identityKey = GeneratedColumn<String>(
    'identity_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    rowId,
    publicId,
    name,
    identityKey,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'genres';
  @override
  VerificationContext validateIntegrity(
    Insertable<Genre> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('row_id')) {
      context.handle(
        _rowIdMeta,
        rowId.isAcceptableOrUnknown(data['row_id']!, _rowIdMeta),
      );
    }
    if (data.containsKey('public_id')) {
      context.handle(
        _publicIdMeta,
        publicId.isAcceptableOrUnknown(data['public_id']!, _publicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_publicIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('identity_key')) {
      context.handle(
        _identityKeyMeta,
        identityKey.isAcceptableOrUnknown(
          data['identity_key']!,
          _identityKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_identityKeyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {rowId};
  @override
  Genre map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Genre(
      rowId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}row_id'],
      )!,
      publicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}public_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      identityKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}identity_key'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $GenresTable createAlias(String alias) {
    return $GenresTable(attachedDatabase, alias);
  }
}

class Genre extends DataClass implements Insertable<Genre> {
  final int rowId;
  final String publicId;
  final String name;
  final String identityKey;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Genre({
    required this.rowId,
    required this.publicId,
    required this.name,
    required this.identityKey,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['row_id'] = Variable<int>(rowId);
    map['public_id'] = Variable<String>(publicId);
    map['name'] = Variable<String>(name);
    map['identity_key'] = Variable<String>(identityKey);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  GenresCompanion toCompanion(bool nullToAbsent) {
    return GenresCompanion(
      rowId: Value(rowId),
      publicId: Value(publicId),
      name: Value(name),
      identityKey: Value(identityKey),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Genre.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Genre(
      rowId: serializer.fromJson<int>(json['rowId']),
      publicId: serializer.fromJson<String>(json['publicId']),
      name: serializer.fromJson<String>(json['name']),
      identityKey: serializer.fromJson<String>(json['identityKey']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'rowId': serializer.toJson<int>(rowId),
      'publicId': serializer.toJson<String>(publicId),
      'name': serializer.toJson<String>(name),
      'identityKey': serializer.toJson<String>(identityKey),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Genre copyWith({
    int? rowId,
    String? publicId,
    String? name,
    String? identityKey,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Genre(
    rowId: rowId ?? this.rowId,
    publicId: publicId ?? this.publicId,
    name: name ?? this.name,
    identityKey: identityKey ?? this.identityKey,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Genre copyWithCompanion(GenresCompanion data) {
    return Genre(
      rowId: data.rowId.present ? data.rowId.value : this.rowId,
      publicId: data.publicId.present ? data.publicId.value : this.publicId,
      name: data.name.present ? data.name.value : this.name,
      identityKey: data.identityKey.present
          ? data.identityKey.value
          : this.identityKey,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Genre(')
          ..write('rowId: $rowId, ')
          ..write('publicId: $publicId, ')
          ..write('name: $name, ')
          ..write('identityKey: $identityKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(rowId, publicId, name, identityKey, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Genre &&
          other.rowId == this.rowId &&
          other.publicId == this.publicId &&
          other.name == this.name &&
          other.identityKey == this.identityKey &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class GenresCompanion extends UpdateCompanion<Genre> {
  final Value<int> rowId;
  final Value<String> publicId;
  final Value<String> name;
  final Value<String> identityKey;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const GenresCompanion({
    this.rowId = const Value.absent(),
    this.publicId = const Value.absent(),
    this.name = const Value.absent(),
    this.identityKey = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  GenresCompanion.insert({
    this.rowId = const Value.absent(),
    required String publicId,
    required String name,
    required String identityKey,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : publicId = Value(publicId),
       name = Value(name),
       identityKey = Value(identityKey),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Genre> custom({
    Expression<int>? rowId,
    Expression<String>? publicId,
    Expression<String>? name,
    Expression<String>? identityKey,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (rowId != null) 'row_id': rowId,
      if (publicId != null) 'public_id': publicId,
      if (name != null) 'name': name,
      if (identityKey != null) 'identity_key': identityKey,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  GenresCompanion copyWith({
    Value<int>? rowId,
    Value<String>? publicId,
    Value<String>? name,
    Value<String>? identityKey,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return GenresCompanion(
      rowId: rowId ?? this.rowId,
      publicId: publicId ?? this.publicId,
      name: name ?? this.name,
      identityKey: identityKey ?? this.identityKey,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (rowId.present) {
      map['row_id'] = Variable<int>(rowId.value);
    }
    if (publicId.present) {
      map['public_id'] = Variable<String>(publicId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (identityKey.present) {
      map['identity_key'] = Variable<String>(identityKey.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GenresCompanion(')
          ..write('rowId: $rowId, ')
          ..write('publicId: $publicId, ')
          ..write('name: $name, ')
          ..write('identityKey: $identityKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TrackGenresTable extends TrackGenres
    with TableInfo<$TrackGenresTable, TrackGenre> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrackGenresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _trackIdMeta = const VerificationMeta(
    'trackId',
  );
  @override
  late final GeneratedColumn<int> trackId = GeneratedColumn<int>(
    'track_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tracks (row_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _genreIdMeta = const VerificationMeta(
    'genreId',
  );
  @override
  late final GeneratedColumn<int> genreId = GeneratedColumn<int>(
    'genre_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES genres (row_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [trackId, genreId, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'track_genres';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrackGenre> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('track_id')) {
      context.handle(
        _trackIdMeta,
        trackId.isAcceptableOrUnknown(data['track_id']!, _trackIdMeta),
      );
    } else if (isInserting) {
      context.missing(_trackIdMeta);
    }
    if (data.containsKey('genre_id')) {
      context.handle(
        _genreIdMeta,
        genreId.isAcceptableOrUnknown(data['genre_id']!, _genreIdMeta),
      );
    } else if (isInserting) {
      context.missing(_genreIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {trackId, genreId};
  @override
  TrackGenre map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrackGenre(
      trackId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}track_id'],
      )!,
      genreId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}genre_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  $TrackGenresTable createAlias(String alias) {
    return $TrackGenresTable(attachedDatabase, alias);
  }
}

class TrackGenre extends DataClass implements Insertable<TrackGenre> {
  final int trackId;
  final int genreId;
  final int position;
  const TrackGenre({
    required this.trackId,
    required this.genreId,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['track_id'] = Variable<int>(trackId);
    map['genre_id'] = Variable<int>(genreId);
    map['position'] = Variable<int>(position);
    return map;
  }

  TrackGenresCompanion toCompanion(bool nullToAbsent) {
    return TrackGenresCompanion(
      trackId: Value(trackId),
      genreId: Value(genreId),
      position: Value(position),
    );
  }

  factory TrackGenre.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrackGenre(
      trackId: serializer.fromJson<int>(json['trackId']),
      genreId: serializer.fromJson<int>(json['genreId']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'trackId': serializer.toJson<int>(trackId),
      'genreId': serializer.toJson<int>(genreId),
      'position': serializer.toJson<int>(position),
    };
  }

  TrackGenre copyWith({int? trackId, int? genreId, int? position}) =>
      TrackGenre(
        trackId: trackId ?? this.trackId,
        genreId: genreId ?? this.genreId,
        position: position ?? this.position,
      );
  TrackGenre copyWithCompanion(TrackGenresCompanion data) {
    return TrackGenre(
      trackId: data.trackId.present ? data.trackId.value : this.trackId,
      genreId: data.genreId.present ? data.genreId.value : this.genreId,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrackGenre(')
          ..write('trackId: $trackId, ')
          ..write('genreId: $genreId, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(trackId, genreId, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrackGenre &&
          other.trackId == this.trackId &&
          other.genreId == this.genreId &&
          other.position == this.position);
}

class TrackGenresCompanion extends UpdateCompanion<TrackGenre> {
  final Value<int> trackId;
  final Value<int> genreId;
  final Value<int> position;
  final Value<int> rowid;
  const TrackGenresCompanion({
    this.trackId = const Value.absent(),
    this.genreId = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrackGenresCompanion.insert({
    required int trackId,
    required int genreId,
    required int position,
    this.rowid = const Value.absent(),
  }) : trackId = Value(trackId),
       genreId = Value(genreId),
       position = Value(position);
  static Insertable<TrackGenre> custom({
    Expression<int>? trackId,
    Expression<int>? genreId,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (trackId != null) 'track_id': trackId,
      if (genreId != null) 'genre_id': genreId,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrackGenresCompanion copyWith({
    Value<int>? trackId,
    Value<int>? genreId,
    Value<int>? position,
    Value<int>? rowid,
  }) {
    return TrackGenresCompanion(
      trackId: trackId ?? this.trackId,
      genreId: genreId ?? this.genreId,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (trackId.present) {
      map['track_id'] = Variable<int>(trackId.value);
    }
    if (genreId.present) {
      map['genre_id'] = Variable<int>(genreId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrackGenresCompanion(')
          ..write('trackId: $trackId, ')
          ..write('genreId: $genreId, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FavoriteTracksTable extends FavoriteTracks
    with TableInfo<$FavoriteTracksTable, FavoriteTrack> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteTracksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _trackIdMeta = const VerificationMeta(
    'trackId',
  );
  @override
  late final GeneratedColumn<int> trackId = GeneratedColumn<int>(
    'track_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tracks (row_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [trackId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_tracks';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteTrack> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('track_id')) {
      context.handle(
        _trackIdMeta,
        trackId.isAcceptableOrUnknown(data['track_id']!, _trackIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {trackId};
  @override
  FavoriteTrack map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteTrack(
      trackId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}track_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FavoriteTracksTable createAlias(String alias) {
    return $FavoriteTracksTable(attachedDatabase, alias);
  }
}

class FavoriteTrack extends DataClass implements Insertable<FavoriteTrack> {
  final int trackId;
  final DateTime createdAt;
  const FavoriteTrack({required this.trackId, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['track_id'] = Variable<int>(trackId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FavoriteTracksCompanion toCompanion(bool nullToAbsent) {
    return FavoriteTracksCompanion(
      trackId: Value(trackId),
      createdAt: Value(createdAt),
    );
  }

  factory FavoriteTrack.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteTrack(
      trackId: serializer.fromJson<int>(json['trackId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'trackId': serializer.toJson<int>(trackId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FavoriteTrack copyWith({int? trackId, DateTime? createdAt}) => FavoriteTrack(
    trackId: trackId ?? this.trackId,
    createdAt: createdAt ?? this.createdAt,
  );
  FavoriteTrack copyWithCompanion(FavoriteTracksCompanion data) {
    return FavoriteTrack(
      trackId: data.trackId.present ? data.trackId.value : this.trackId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteTrack(')
          ..write('trackId: $trackId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(trackId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteTrack &&
          other.trackId == this.trackId &&
          other.createdAt == this.createdAt);
}

class FavoriteTracksCompanion extends UpdateCompanion<FavoriteTrack> {
  final Value<int> trackId;
  final Value<DateTime> createdAt;
  const FavoriteTracksCompanion({
    this.trackId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FavoriteTracksCompanion.insert({
    this.trackId = const Value.absent(),
    required DateTime createdAt,
  }) : createdAt = Value(createdAt);
  static Insertable<FavoriteTrack> custom({
    Expression<int>? trackId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (trackId != null) 'track_id': trackId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FavoriteTracksCompanion copyWith({
    Value<int>? trackId,
    Value<DateTime>? createdAt,
  }) {
    return FavoriteTracksCompanion(
      trackId: trackId ?? this.trackId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (trackId.present) {
      map['track_id'] = Variable<int>(trackId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteTracksCompanion(')
          ..write('trackId: $trackId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UserPlaylistsTable extends UserPlaylists
    with TableInfo<$UserPlaylistsTable, UserPlaylist> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPlaylistsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _rowIdMeta = const VerificationMeta('rowId');
  @override
  late final GeneratedColumn<int> rowId = GeneratedColumn<int>(
    'row_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _publicIdMeta = const VerificationMeta(
    'publicId',
  );
  @override
  late final GeneratedColumn<String> publicId = GeneratedColumn<String>(
    'public_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedNameMeta = const VerificationMeta(
    'normalizedName',
  );
  @override
  late final GeneratedColumn<String> normalizedName = GeneratedColumn<String>(
    'normalized_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    rowId,
    publicId,
    name,
    normalizedName,
    description,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_playlists';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserPlaylist> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('row_id')) {
      context.handle(
        _rowIdMeta,
        rowId.isAcceptableOrUnknown(data['row_id']!, _rowIdMeta),
      );
    }
    if (data.containsKey('public_id')) {
      context.handle(
        _publicIdMeta,
        publicId.isAcceptableOrUnknown(data['public_id']!, _publicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_publicIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('normalized_name')) {
      context.handle(
        _normalizedNameMeta,
        normalizedName.isAcceptableOrUnknown(
          data['normalized_name']!,
          _normalizedNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedNameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {rowId};
  @override
  UserPlaylist map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPlaylist(
      rowId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}row_id'],
      )!,
      publicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}public_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      normalizedName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserPlaylistsTable createAlias(String alias) {
    return $UserPlaylistsTable(attachedDatabase, alias);
  }
}

class UserPlaylist extends DataClass implements Insertable<UserPlaylist> {
  final int rowId;
  final String publicId;
  final String name;
  final String normalizedName;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserPlaylist({
    required this.rowId,
    required this.publicId,
    required this.name,
    required this.normalizedName,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['row_id'] = Variable<int>(rowId);
    map['public_id'] = Variable<String>(publicId);
    map['name'] = Variable<String>(name);
    map['normalized_name'] = Variable<String>(normalizedName);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserPlaylistsCompanion toCompanion(bool nullToAbsent) {
    return UserPlaylistsCompanion(
      rowId: Value(rowId),
      publicId: Value(publicId),
      name: Value(name),
      normalizedName: Value(normalizedName),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserPlaylist.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPlaylist(
      rowId: serializer.fromJson<int>(json['rowId']),
      publicId: serializer.fromJson<String>(json['publicId']),
      name: serializer.fromJson<String>(json['name']),
      normalizedName: serializer.fromJson<String>(json['normalizedName']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'rowId': serializer.toJson<int>(rowId),
      'publicId': serializer.toJson<String>(publicId),
      'name': serializer.toJson<String>(name),
      'normalizedName': serializer.toJson<String>(normalizedName),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserPlaylist copyWith({
    int? rowId,
    String? publicId,
    String? name,
    String? normalizedName,
    Value<String?> description = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserPlaylist(
    rowId: rowId ?? this.rowId,
    publicId: publicId ?? this.publicId,
    name: name ?? this.name,
    normalizedName: normalizedName ?? this.normalizedName,
    description: description.present ? description.value : this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserPlaylist copyWithCompanion(UserPlaylistsCompanion data) {
    return UserPlaylist(
      rowId: data.rowId.present ? data.rowId.value : this.rowId,
      publicId: data.publicId.present ? data.publicId.value : this.publicId,
      name: data.name.present ? data.name.value : this.name,
      normalizedName: data.normalizedName.present
          ? data.normalizedName.value
          : this.normalizedName,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPlaylist(')
          ..write('rowId: $rowId, ')
          ..write('publicId: $publicId, ')
          ..write('name: $name, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    rowId,
    publicId,
    name,
    normalizedName,
    description,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPlaylist &&
          other.rowId == this.rowId &&
          other.publicId == this.publicId &&
          other.name == this.name &&
          other.normalizedName == this.normalizedName &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserPlaylistsCompanion extends UpdateCompanion<UserPlaylist> {
  final Value<int> rowId;
  final Value<String> publicId;
  final Value<String> name;
  final Value<String> normalizedName;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserPlaylistsCompanion({
    this.rowId = const Value.absent(),
    this.publicId = const Value.absent(),
    this.name = const Value.absent(),
    this.normalizedName = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserPlaylistsCompanion.insert({
    this.rowId = const Value.absent(),
    required String publicId,
    required String name,
    required String normalizedName,
    this.description = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : publicId = Value(publicId),
       name = Value(name),
       normalizedName = Value(normalizedName),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<UserPlaylist> custom({
    Expression<int>? rowId,
    Expression<String>? publicId,
    Expression<String>? name,
    Expression<String>? normalizedName,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (rowId != null) 'row_id': rowId,
      if (publicId != null) 'public_id': publicId,
      if (name != null) 'name': name,
      if (normalizedName != null) 'normalized_name': normalizedName,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserPlaylistsCompanion copyWith({
    Value<int>? rowId,
    Value<String>? publicId,
    Value<String>? name,
    Value<String>? normalizedName,
    Value<String?>? description,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UserPlaylistsCompanion(
      rowId: rowId ?? this.rowId,
      publicId: publicId ?? this.publicId,
      name: name ?? this.name,
      normalizedName: normalizedName ?? this.normalizedName,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (rowId.present) {
      map['row_id'] = Variable<int>(rowId.value);
    }
    if (publicId.present) {
      map['public_id'] = Variable<String>(publicId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (normalizedName.present) {
      map['normalized_name'] = Variable<String>(normalizedName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPlaylistsCompanion(')
          ..write('rowId: $rowId, ')
          ..write('publicId: $publicId, ')
          ..write('name: $name, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $UserPlaylistItemsTable extends UserPlaylistItems
    with TableInfo<$UserPlaylistItemsTable, UserPlaylistItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPlaylistItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _rowIdMeta = const VerificationMeta('rowId');
  @override
  late final GeneratedColumn<int> rowId = GeneratedColumn<int>(
    'row_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _playlistIdMeta = const VerificationMeta(
    'playlistId',
  );
  @override
  late final GeneratedColumn<int> playlistId = GeneratedColumn<int>(
    'playlist_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_playlists (row_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _trackIdMeta = const VerificationMeta(
    'trackId',
  );
  @override
  late final GeneratedColumn<int> trackId = GeneratedColumn<int>(
    'track_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tracks (row_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addedAtMeta = const VerificationMeta(
    'addedAt',
  );
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
    'added_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    rowId,
    playlistId,
    trackId,
    position,
    addedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_playlist_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserPlaylistItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('row_id')) {
      context.handle(
        _rowIdMeta,
        rowId.isAcceptableOrUnknown(data['row_id']!, _rowIdMeta),
      );
    }
    if (data.containsKey('playlist_id')) {
      context.handle(
        _playlistIdMeta,
        playlistId.isAcceptableOrUnknown(data['playlist_id']!, _playlistIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playlistIdMeta);
    }
    if (data.containsKey('track_id')) {
      context.handle(
        _trackIdMeta,
        trackId.isAcceptableOrUnknown(data['track_id']!, _trackIdMeta),
      );
    } else if (isInserting) {
      context.missing(_trackIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('added_at')) {
      context.handle(
        _addedAtMeta,
        addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_addedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {rowId};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {playlistId, trackId},
    {playlistId, position},
  ];
  @override
  UserPlaylistItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPlaylistItem(
      rowId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}row_id'],
      )!,
      playlistId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}playlist_id'],
      )!,
      trackId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}track_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      addedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}added_at'],
      )!,
    );
  }

  @override
  $UserPlaylistItemsTable createAlias(String alias) {
    return $UserPlaylistItemsTable(attachedDatabase, alias);
  }
}

class UserPlaylistItem extends DataClass
    implements Insertable<UserPlaylistItem> {
  final int rowId;
  final int playlistId;
  final int trackId;
  final int position;
  final DateTime addedAt;
  const UserPlaylistItem({
    required this.rowId,
    required this.playlistId,
    required this.trackId,
    required this.position,
    required this.addedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['row_id'] = Variable<int>(rowId);
    map['playlist_id'] = Variable<int>(playlistId);
    map['track_id'] = Variable<int>(trackId);
    map['position'] = Variable<int>(position);
    map['added_at'] = Variable<DateTime>(addedAt);
    return map;
  }

  UserPlaylistItemsCompanion toCompanion(bool nullToAbsent) {
    return UserPlaylistItemsCompanion(
      rowId: Value(rowId),
      playlistId: Value(playlistId),
      trackId: Value(trackId),
      position: Value(position),
      addedAt: Value(addedAt),
    );
  }

  factory UserPlaylistItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPlaylistItem(
      rowId: serializer.fromJson<int>(json['rowId']),
      playlistId: serializer.fromJson<int>(json['playlistId']),
      trackId: serializer.fromJson<int>(json['trackId']),
      position: serializer.fromJson<int>(json['position']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'rowId': serializer.toJson<int>(rowId),
      'playlistId': serializer.toJson<int>(playlistId),
      'trackId': serializer.toJson<int>(trackId),
      'position': serializer.toJson<int>(position),
      'addedAt': serializer.toJson<DateTime>(addedAt),
    };
  }

  UserPlaylistItem copyWith({
    int? rowId,
    int? playlistId,
    int? trackId,
    int? position,
    DateTime? addedAt,
  }) => UserPlaylistItem(
    rowId: rowId ?? this.rowId,
    playlistId: playlistId ?? this.playlistId,
    trackId: trackId ?? this.trackId,
    position: position ?? this.position,
    addedAt: addedAt ?? this.addedAt,
  );
  UserPlaylistItem copyWithCompanion(UserPlaylistItemsCompanion data) {
    return UserPlaylistItem(
      rowId: data.rowId.present ? data.rowId.value : this.rowId,
      playlistId: data.playlistId.present
          ? data.playlistId.value
          : this.playlistId,
      trackId: data.trackId.present ? data.trackId.value : this.trackId,
      position: data.position.present ? data.position.value : this.position,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPlaylistItem(')
          ..write('rowId: $rowId, ')
          ..write('playlistId: $playlistId, ')
          ..write('trackId: $trackId, ')
          ..write('position: $position, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(rowId, playlistId, trackId, position, addedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPlaylistItem &&
          other.rowId == this.rowId &&
          other.playlistId == this.playlistId &&
          other.trackId == this.trackId &&
          other.position == this.position &&
          other.addedAt == this.addedAt);
}

class UserPlaylistItemsCompanion extends UpdateCompanion<UserPlaylistItem> {
  final Value<int> rowId;
  final Value<int> playlistId;
  final Value<int> trackId;
  final Value<int> position;
  final Value<DateTime> addedAt;
  const UserPlaylistItemsCompanion({
    this.rowId = const Value.absent(),
    this.playlistId = const Value.absent(),
    this.trackId = const Value.absent(),
    this.position = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  UserPlaylistItemsCompanion.insert({
    this.rowId = const Value.absent(),
    required int playlistId,
    required int trackId,
    required int position,
    required DateTime addedAt,
  }) : playlistId = Value(playlistId),
       trackId = Value(trackId),
       position = Value(position),
       addedAt = Value(addedAt);
  static Insertable<UserPlaylistItem> custom({
    Expression<int>? rowId,
    Expression<int>? playlistId,
    Expression<int>? trackId,
    Expression<int>? position,
    Expression<DateTime>? addedAt,
  }) {
    return RawValuesInsertable({
      if (rowId != null) 'row_id': rowId,
      if (playlistId != null) 'playlist_id': playlistId,
      if (trackId != null) 'track_id': trackId,
      if (position != null) 'position': position,
      if (addedAt != null) 'added_at': addedAt,
    });
  }

  UserPlaylistItemsCompanion copyWith({
    Value<int>? rowId,
    Value<int>? playlistId,
    Value<int>? trackId,
    Value<int>? position,
    Value<DateTime>? addedAt,
  }) {
    return UserPlaylistItemsCompanion(
      rowId: rowId ?? this.rowId,
      playlistId: playlistId ?? this.playlistId,
      trackId: trackId ?? this.trackId,
      position: position ?? this.position,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (rowId.present) {
      map['row_id'] = Variable<int>(rowId.value);
    }
    if (playlistId.present) {
      map['playlist_id'] = Variable<int>(playlistId.value);
    }
    if (trackId.present) {
      map['track_id'] = Variable<int>(trackId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPlaylistItemsCompanion(')
          ..write('rowId: $rowId, ')
          ..write('playlistId: $playlistId, ')
          ..write('trackId: $trackId, ')
          ..write('position: $position, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$MediaLibraryDatabase extends GeneratedDatabase {
  _$MediaLibraryDatabase(QueryExecutor e) : super(e);
  $MediaLibraryDatabaseManager get managers =>
      $MediaLibraryDatabaseManager(this);
  late final TrackSearchFts trackSearchFts = TrackSearchFts(this);
  late final $LibraryRootsTable libraryRoots = $LibraryRootsTable(this);
  late final $ScanRunsTable scanRuns = $ScanRunsTable(this);
  late final $MediaFilesTable mediaFiles = $MediaFilesTable(this);
  late final $ArtworkAssetsTable artworkAssets = $ArtworkAssetsTable(this);
  late final $ArtistsTable artists = $ArtistsTable(this);
  late final $AlbumsTable albums = $AlbumsTable(this);
  late final $TracksTable tracks = $TracksTable(this);
  late final $TrackArtistsTable trackArtists = $TrackArtistsTable(this);
  late final $GenresTable genres = $GenresTable(this);
  late final $TrackGenresTable trackGenres = $TrackGenresTable(this);
  late final $FavoriteTracksTable favoriteTracks = $FavoriteTracksTable(this);
  late final $UserPlaylistsTable userPlaylists = $UserPlaylistsTable(this);
  late final $UserPlaylistItemsTable userPlaylistItems =
      $UserPlaylistItemsTable(this);
  late final Index mediaFilesRootAvailability = Index(
    'media_files_root_availability',
    'CREATE INDEX media_files_root_availability ON media_files (root_id, availability_state)',
  );
  late final Index mediaFilesRootLastSeenGeneration = Index(
    'media_files_root_last_seen_generation',
    'CREATE INDEX media_files_root_last_seen_generation ON media_files (root_id, last_seen_generation)',
  );
  late final Index mediaFilesPlatformFileId = Index(
    'media_files_platform_file_id',
    'CREATE INDEX media_files_platform_file_id ON media_files (platform_file_id)',
  );
  late final Index mediaFilesQuickFingerprint = Index(
    'media_files_quick_fingerprint',
    'CREATE INDEX media_files_quick_fingerprint ON media_files (quick_fingerprint)',
  );
  late final Index mediaFilesContentHash = Index(
    'media_files_content_hash',
    'CREATE INDEX media_files_content_hash ON media_files (content_hash)',
  );
  late final Index artistsSortName = Index(
    'artists_sort_name',
    'CREATE INDEX artists_sort_name ON artists (sort_name)',
  );
  late final Index artistsName = Index(
    'artists_name',
    'CREATE INDEX artists_name ON artists (name)',
  );
  late final Index albumsSortTitle = Index(
    'albums_sort_title',
    'CREATE INDEX albums_sort_title ON albums (sort_title)',
  );
  late final Index albumsAlbumArtistId = Index(
    'albums_album_artist_id',
    'CREATE INDEX albums_album_artist_id ON albums (album_artist_id)',
  );
  late final Index albumsArtworkId = Index(
    'albums_artwork_id',
    'CREATE INDEX albums_artwork_id ON albums (artwork_id)',
  );
  late final Index tracksAlbumId = Index(
    'tracks_album_id',
    'CREATE INDEX tracks_album_id ON tracks (album_id)',
  );
  late final Index tracksSortTitle = Index(
    'tracks_sort_title',
    'CREATE INDEX tracks_sort_title ON tracks (sort_title)',
  );
  late final Index tracksTitle = Index(
    'tracks_title',
    'CREATE INDEX tracks_title ON tracks (title)',
  );
  late final Index tracksArtworkId = Index(
    'tracks_artwork_id',
    'CREATE INDEX tracks_artwork_id ON tracks (artwork_id)',
  );
  late final Index trackArtistsArtistRolePosition = Index(
    'track_artists_artist_role_position',
    'CREATE INDEX track_artists_artist_role_position ON track_artists (artist_id, role, position)',
  );
  late final Index trackArtistsTrackPosition = Index(
    'track_artists_track_position',
    'CREATE INDEX track_artists_track_position ON track_artists (track_id, position)',
  );
  late final Index trackGenresGenreId = Index(
    'track_genres_genre_id',
    'CREATE INDEX track_genres_genre_id ON track_genres (genre_id)',
  );
  late final Index trackGenresTrackPosition = Index(
    'track_genres_track_position',
    'CREATE INDEX track_genres_track_position ON track_genres (track_id, position)',
  );
  late final Index favoriteTracksCreatedAt = Index(
    'favorite_tracks_created_at',
    'CREATE INDEX favorite_tracks_created_at ON favorite_tracks (created_at, track_id)',
  );
  late final Index userPlaylistsUpdatedAt = Index(
    'user_playlists_updated_at',
    'CREATE INDEX user_playlists_updated_at ON user_playlists (updated_at)',
  );
  late final Index userPlaylistItemsPlaylistPosition = Index(
    'user_playlist_items_playlist_position',
    'CREATE INDEX user_playlist_items_playlist_position ON user_playlist_items (playlist_id, position)',
  );
  Future<int> deleteTrackSearch(int trackRowId) {
    return customUpdate(
      'DELETE FROM track_search_fts WHERE "rowid" = ?1',
      variables: [Variable<int>(trackRowId)],
      updates: {trackSearchFts},
      updateKind: UpdateKind.delete,
    );
  }

  Future<int> insertTrackSearch(
    int trackRowId,
    String? trackPublicId,
    String? title,
    String? artist,
    String? album,
    String? fileName,
  ) {
    return customInsert(
      'INSERT INTO track_search_fts ("rowid", track_public_id, title, artist, album, file_name) VALUES (?1, ?2, ?3, ?4, ?5, ?6)',
      variables: [
        Variable<int>(trackRowId),
        Variable<String>(trackPublicId),
        Variable<String>(title),
        Variable<String>(artist),
        Variable<String>(album),
        Variable<String>(fileName),
      ],
      updates: {trackSearchFts},
    );
  }

  Selectable<SearchTracksFtsResult> searchTracksFts(String query) {
    return customSelect(
      'SELECT "rowid" AS track_row_id, track_public_id, bm25(track_search_fts) AS rank FROM track_search_fts WHERE track_search_fts MATCH ?1 ORDER BY rank, track_public_id',
      variables: [Variable<String>(query)],
      readsFrom: {trackSearchFts},
    ).map(
      (QueryRow row) => SearchTracksFtsResult(
        trackRowId: row.read<int>('track_row_id'),
        trackPublicId: row.readNullable<String>('track_public_id'),
        rank: row.read<double>('rank'),
      ),
    );
  }

  Future<int> clearTrackSearch() {
    return customUpdate(
      'DELETE FROM track_search_fts',
      variables: [],
      updates: {trackSearchFts},
      updateKind: UpdateKind.delete,
    );
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    trackSearchFts,
    libraryRoots,
    scanRuns,
    mediaFiles,
    artworkAssets,
    artists,
    albums,
    tracks,
    trackArtists,
    genres,
    trackGenres,
    favoriteTracks,
    userPlaylists,
    userPlaylistItems,
    mediaFilesRootAvailability,
    mediaFilesRootLastSeenGeneration,
    mediaFilesPlatformFileId,
    mediaFilesQuickFingerprint,
    mediaFilesContentHash,
    artistsSortName,
    artistsName,
    albumsSortTitle,
    albumsAlbumArtistId,
    albumsArtworkId,
    tracksAlbumId,
    tracksSortTitle,
    tracksTitle,
    tracksArtworkId,
    trackArtistsArtistRolePosition,
    trackArtistsTrackPosition,
    trackGenresGenreId,
    trackGenresTrackPosition,
    favoriteTracksCreatedAt,
    userPlaylistsUpdatedAt,
    userPlaylistItemsPlaylistPosition,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'library_roots',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('scan_runs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'library_roots',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('media_files', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'artists',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('albums', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'artwork_assets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('albums', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'media_files',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tracks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'albums',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tracks', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'artwork_assets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tracks', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tracks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('track_artists', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'artists',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('track_artists', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tracks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('track_genres', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'genres',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('track_genres', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tracks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('favorite_tracks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'user_playlists',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('user_playlist_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tracks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('user_playlist_items', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $TrackSearchFtsCreateCompanionBuilder =
    TrackSearchFtsCompanion Function({
      Value<String?> trackPublicId,
      Value<String?> title,
      Value<String?> artist,
      Value<String?> album,
      Value<String?> fileName,
      Value<int> rowid,
    });
typedef $TrackSearchFtsUpdateCompanionBuilder =
    TrackSearchFtsCompanion Function({
      Value<String?> trackPublicId,
      Value<String?> title,
      Value<String?> artist,
      Value<String?> album,
      Value<String?> fileName,
      Value<int> rowid,
    });

class $TrackSearchFtsFilterComposer
    extends Composer<_$MediaLibraryDatabase, TrackSearchFts> {
  $TrackSearchFtsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get trackPublicId => $composableBuilder(
    column: $table.trackPublicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artist => $composableBuilder(
    column: $table.artist,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get album => $composableBuilder(
    column: $table.album,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );
}

class $TrackSearchFtsOrderingComposer
    extends Composer<_$MediaLibraryDatabase, TrackSearchFts> {
  $TrackSearchFtsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get trackPublicId => $composableBuilder(
    column: $table.trackPublicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artist => $composableBuilder(
    column: $table.artist,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get album => $composableBuilder(
    column: $table.album,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );
}

class $TrackSearchFtsAnnotationComposer
    extends Composer<_$MediaLibraryDatabase, TrackSearchFts> {
  $TrackSearchFtsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get trackPublicId => $composableBuilder(
    column: $table.trackPublicId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get artist =>
      $composableBuilder(column: $table.artist, builder: (column) => column);

  GeneratedColumn<String> get album =>
      $composableBuilder(column: $table.album, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);
}

class $TrackSearchFtsTableManager
    extends
        RootTableManager<
          _$MediaLibraryDatabase,
          TrackSearchFts,
          TrackSearchFt,
          $TrackSearchFtsFilterComposer,
          $TrackSearchFtsOrderingComposer,
          $TrackSearchFtsAnnotationComposer,
          $TrackSearchFtsCreateCompanionBuilder,
          $TrackSearchFtsUpdateCompanionBuilder,
          (
            TrackSearchFt,
            BaseReferences<
              _$MediaLibraryDatabase,
              TrackSearchFts,
              TrackSearchFt
            >,
          ),
          TrackSearchFt,
          PrefetchHooks Function()
        > {
  $TrackSearchFtsTableManager(_$MediaLibraryDatabase db, TrackSearchFts table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TrackSearchFtsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TrackSearchFtsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TrackSearchFtsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String?> trackPublicId = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> artist = const Value.absent(),
                Value<String?> album = const Value.absent(),
                Value<String?> fileName = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrackSearchFtsCompanion(
                trackPublicId: trackPublicId,
                title: title,
                artist: artist,
                album: album,
                fileName: fileName,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String?> trackPublicId = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> artist = const Value.absent(),
                Value<String?> album = const Value.absent(),
                Value<String?> fileName = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrackSearchFtsCompanion.insert(
                trackPublicId: trackPublicId,
                title: title,
                artist: artist,
                album: album,
                fileName: fileName,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $TrackSearchFtsProcessedTableManager =
    ProcessedTableManager<
      _$MediaLibraryDatabase,
      TrackSearchFts,
      TrackSearchFt,
      $TrackSearchFtsFilterComposer,
      $TrackSearchFtsOrderingComposer,
      $TrackSearchFtsAnnotationComposer,
      $TrackSearchFtsCreateCompanionBuilder,
      $TrackSearchFtsUpdateCompanionBuilder,
      (
        TrackSearchFt,
        BaseReferences<_$MediaLibraryDatabase, TrackSearchFts, TrackSearchFt>,
      ),
      TrackSearchFt,
      PrefetchHooks Function()
    >;
typedef $$LibraryRootsTableCreateCompanionBuilder =
    LibraryRootsCompanion Function({
      Value<int> rowId,
      required String publicId,
      required String sourceType,
      required String locator,
      required String locatorKey,
      required String displayName,
      Value<bool> recursive,
      Value<bool> enabled,
      Value<int> scanGeneration,
      Value<DateTime?> lastScanStartedAt,
      Value<DateTime?> lastScanCompletedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$LibraryRootsTableUpdateCompanionBuilder =
    LibraryRootsCompanion Function({
      Value<int> rowId,
      Value<String> publicId,
      Value<String> sourceType,
      Value<String> locator,
      Value<String> locatorKey,
      Value<String> displayName,
      Value<bool> recursive,
      Value<bool> enabled,
      Value<int> scanGeneration,
      Value<DateTime?> lastScanStartedAt,
      Value<DateTime?> lastScanCompletedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$LibraryRootsTableReferences
    extends
        BaseReferences<
          _$MediaLibraryDatabase,
          $LibraryRootsTable,
          LibraryRoot
        > {
  $$LibraryRootsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ScanRunsTable, List<ScanRun>> _scanRunsRefsTable(
    _$MediaLibraryDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.scanRuns,
    aliasName: $_aliasNameGenerator(db.libraryRoots.rowId, db.scanRuns.rootId),
  );

  $$ScanRunsTableProcessedTableManager get scanRunsRefs {
    final manager = $$ScanRunsTableTableManager(
      $_db,
      $_db.scanRuns,
    ).filter((f) => f.rootId.rowId.sqlEquals($_itemColumn<int>('row_id')!));

    final cache = $_typedResult.readTableOrNull(_scanRunsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MediaFilesTable, List<MediaFile>>
  _mediaFilesRefsTable(_$MediaLibraryDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.mediaFiles,
        aliasName: $_aliasNameGenerator(
          db.libraryRoots.rowId,
          db.mediaFiles.rootId,
        ),
      );

  $$MediaFilesTableProcessedTableManager get mediaFilesRefs {
    final manager = $$MediaFilesTableTableManager(
      $_db,
      $_db.mediaFiles,
    ).filter((f) => f.rootId.rowId.sqlEquals($_itemColumn<int>('row_id')!));

    final cache = $_typedResult.readTableOrNull(_mediaFilesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LibraryRootsTableFilterComposer
    extends Composer<_$MediaLibraryDatabase, $LibraryRootsTable> {
  $$LibraryRootsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get publicId => $composableBuilder(
    column: $table.publicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locator => $composableBuilder(
    column: $table.locator,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locatorKey => $composableBuilder(
    column: $table.locatorKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get recursive => $composableBuilder(
    column: $table.recursive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scanGeneration => $composableBuilder(
    column: $table.scanGeneration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastScanStartedAt => $composableBuilder(
    column: $table.lastScanStartedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastScanCompletedAt => $composableBuilder(
    column: $table.lastScanCompletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> scanRunsRefs(
    Expression<bool> Function($$ScanRunsTableFilterComposer f) f,
  ) {
    final $$ScanRunsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.scanRuns,
      getReferencedColumn: (t) => t.rootId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScanRunsTableFilterComposer(
            $db: $db,
            $table: $db.scanRuns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mediaFilesRefs(
    Expression<bool> Function($$MediaFilesTableFilterComposer f) f,
  ) {
    final $$MediaFilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.mediaFiles,
      getReferencedColumn: (t) => t.rootId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaFilesTableFilterComposer(
            $db: $db,
            $table: $db.mediaFiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LibraryRootsTableOrderingComposer
    extends Composer<_$MediaLibraryDatabase, $LibraryRootsTable> {
  $$LibraryRootsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publicId => $composableBuilder(
    column: $table.publicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locator => $composableBuilder(
    column: $table.locator,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locatorKey => $composableBuilder(
    column: $table.locatorKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get recursive => $composableBuilder(
    column: $table.recursive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scanGeneration => $composableBuilder(
    column: $table.scanGeneration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastScanStartedAt => $composableBuilder(
    column: $table.lastScanStartedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastScanCompletedAt => $composableBuilder(
    column: $table.lastScanCompletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LibraryRootsTableAnnotationComposer
    extends Composer<_$MediaLibraryDatabase, $LibraryRootsTable> {
  $$LibraryRootsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get rowId =>
      $composableBuilder(column: $table.rowId, builder: (column) => column);

  GeneratedColumn<String> get publicId =>
      $composableBuilder(column: $table.publicId, builder: (column) => column);

  GeneratedColumn<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locator =>
      $composableBuilder(column: $table.locator, builder: (column) => column);

  GeneratedColumn<String> get locatorKey => $composableBuilder(
    column: $table.locatorKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get recursive =>
      $composableBuilder(column: $table.recursive, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<int> get scanGeneration => $composableBuilder(
    column: $table.scanGeneration,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastScanStartedAt => $composableBuilder(
    column: $table.lastScanStartedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastScanCompletedAt => $composableBuilder(
    column: $table.lastScanCompletedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> scanRunsRefs<T extends Object>(
    Expression<T> Function($$ScanRunsTableAnnotationComposer a) f,
  ) {
    final $$ScanRunsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.scanRuns,
      getReferencedColumn: (t) => t.rootId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScanRunsTableAnnotationComposer(
            $db: $db,
            $table: $db.scanRuns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> mediaFilesRefs<T extends Object>(
    Expression<T> Function($$MediaFilesTableAnnotationComposer a) f,
  ) {
    final $$MediaFilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.mediaFiles,
      getReferencedColumn: (t) => t.rootId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaFilesTableAnnotationComposer(
            $db: $db,
            $table: $db.mediaFiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LibraryRootsTableTableManager
    extends
        RootTableManager<
          _$MediaLibraryDatabase,
          $LibraryRootsTable,
          LibraryRoot,
          $$LibraryRootsTableFilterComposer,
          $$LibraryRootsTableOrderingComposer,
          $$LibraryRootsTableAnnotationComposer,
          $$LibraryRootsTableCreateCompanionBuilder,
          $$LibraryRootsTableUpdateCompanionBuilder,
          (LibraryRoot, $$LibraryRootsTableReferences),
          LibraryRoot,
          PrefetchHooks Function({bool scanRunsRefs, bool mediaFilesRefs})
        > {
  $$LibraryRootsTableTableManager(
    _$MediaLibraryDatabase db,
    $LibraryRootsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LibraryRootsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LibraryRootsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LibraryRootsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> rowId = const Value.absent(),
                Value<String> publicId = const Value.absent(),
                Value<String> sourceType = const Value.absent(),
                Value<String> locator = const Value.absent(),
                Value<String> locatorKey = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<bool> recursive = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> scanGeneration = const Value.absent(),
                Value<DateTime?> lastScanStartedAt = const Value.absent(),
                Value<DateTime?> lastScanCompletedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => LibraryRootsCompanion(
                rowId: rowId,
                publicId: publicId,
                sourceType: sourceType,
                locator: locator,
                locatorKey: locatorKey,
                displayName: displayName,
                recursive: recursive,
                enabled: enabled,
                scanGeneration: scanGeneration,
                lastScanStartedAt: lastScanStartedAt,
                lastScanCompletedAt: lastScanCompletedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> rowId = const Value.absent(),
                required String publicId,
                required String sourceType,
                required String locator,
                required String locatorKey,
                required String displayName,
                Value<bool> recursive = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> scanGeneration = const Value.absent(),
                Value<DateTime?> lastScanStartedAt = const Value.absent(),
                Value<DateTime?> lastScanCompletedAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => LibraryRootsCompanion.insert(
                rowId: rowId,
                publicId: publicId,
                sourceType: sourceType,
                locator: locator,
                locatorKey: locatorKey,
                displayName: displayName,
                recursive: recursive,
                enabled: enabled,
                scanGeneration: scanGeneration,
                lastScanStartedAt: lastScanStartedAt,
                lastScanCompletedAt: lastScanCompletedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LibraryRootsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({scanRunsRefs = false, mediaFilesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (scanRunsRefs) db.scanRuns,
                    if (mediaFilesRefs) db.mediaFiles,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (scanRunsRefs)
                        await $_getPrefetchedData<
                          LibraryRoot,
                          $LibraryRootsTable,
                          ScanRun
                        >(
                          currentTable: table,
                          referencedTable: $$LibraryRootsTableReferences
                              ._scanRunsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LibraryRootsTableReferences(
                                db,
                                table,
                                p0,
                              ).scanRunsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.rootId == item.rowId,
                              ),
                          typedResults: items,
                        ),
                      if (mediaFilesRefs)
                        await $_getPrefetchedData<
                          LibraryRoot,
                          $LibraryRootsTable,
                          MediaFile
                        >(
                          currentTable: table,
                          referencedTable: $$LibraryRootsTableReferences
                              ._mediaFilesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LibraryRootsTableReferences(
                                db,
                                table,
                                p0,
                              ).mediaFilesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.rootId == item.rowId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LibraryRootsTableProcessedTableManager =
    ProcessedTableManager<
      _$MediaLibraryDatabase,
      $LibraryRootsTable,
      LibraryRoot,
      $$LibraryRootsTableFilterComposer,
      $$LibraryRootsTableOrderingComposer,
      $$LibraryRootsTableAnnotationComposer,
      $$LibraryRootsTableCreateCompanionBuilder,
      $$LibraryRootsTableUpdateCompanionBuilder,
      (LibraryRoot, $$LibraryRootsTableReferences),
      LibraryRoot,
      PrefetchHooks Function({bool scanRunsRefs, bool mediaFilesRefs})
    >;
typedef $$ScanRunsTableCreateCompanionBuilder =
    ScanRunsCompanion Function({
      Value<int> rowId,
      required String publicId,
      required int rootId,
      required int generation,
      required String status,
      required DateTime startedAt,
      Value<DateTime?> finishedAt,
      Value<int> discoveredCount,
      Value<int> unchangedCount,
      Value<int> parsedCount,
      Value<int> insertedCount,
      Value<int> updatedCount,
      Value<int> missingCount,
      Value<int> failedCount,
      Value<String?> failureCode,
      Value<String?> failureMessage,
    });
typedef $$ScanRunsTableUpdateCompanionBuilder =
    ScanRunsCompanion Function({
      Value<int> rowId,
      Value<String> publicId,
      Value<int> rootId,
      Value<int> generation,
      Value<String> status,
      Value<DateTime> startedAt,
      Value<DateTime?> finishedAt,
      Value<int> discoveredCount,
      Value<int> unchangedCount,
      Value<int> parsedCount,
      Value<int> insertedCount,
      Value<int> updatedCount,
      Value<int> missingCount,
      Value<int> failedCount,
      Value<String?> failureCode,
      Value<String?> failureMessage,
    });

final class $$ScanRunsTableReferences
    extends BaseReferences<_$MediaLibraryDatabase, $ScanRunsTable, ScanRun> {
  $$ScanRunsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LibraryRootsTable _rootIdTable(_$MediaLibraryDatabase db) =>
      db.libraryRoots.createAlias(
        $_aliasNameGenerator(db.scanRuns.rootId, db.libraryRoots.rowId),
      );

  $$LibraryRootsTableProcessedTableManager get rootId {
    final $_column = $_itemColumn<int>('root_id')!;

    final manager = $$LibraryRootsTableTableManager(
      $_db,
      $_db.libraryRoots,
    ).filter((f) => f.rowId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_rootIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ScanRunsTableFilterComposer
    extends Composer<_$MediaLibraryDatabase, $ScanRunsTable> {
  $$ScanRunsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get publicId => $composableBuilder(
    column: $table.publicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get generation => $composableBuilder(
    column: $table.generation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discoveredCount => $composableBuilder(
    column: $table.discoveredCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unchangedCount => $composableBuilder(
    column: $table.unchangedCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get parsedCount => $composableBuilder(
    column: $table.parsedCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get insertedCount => $composableBuilder(
    column: $table.insertedCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedCount => $composableBuilder(
    column: $table.updatedCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get missingCount => $composableBuilder(
    column: $table.missingCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get failedCount => $composableBuilder(
    column: $table.failedCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get failureCode => $composableBuilder(
    column: $table.failureCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get failureMessage => $composableBuilder(
    column: $table.failureMessage,
    builder: (column) => ColumnFilters(column),
  );

  $$LibraryRootsTableFilterComposer get rootId {
    final $$LibraryRootsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rootId,
      referencedTable: $db.libraryRoots,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LibraryRootsTableFilterComposer(
            $db: $db,
            $table: $db.libraryRoots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScanRunsTableOrderingComposer
    extends Composer<_$MediaLibraryDatabase, $ScanRunsTable> {
  $$ScanRunsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publicId => $composableBuilder(
    column: $table.publicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get generation => $composableBuilder(
    column: $table.generation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discoveredCount => $composableBuilder(
    column: $table.discoveredCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unchangedCount => $composableBuilder(
    column: $table.unchangedCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get parsedCount => $composableBuilder(
    column: $table.parsedCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get insertedCount => $composableBuilder(
    column: $table.insertedCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedCount => $composableBuilder(
    column: $table.updatedCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get missingCount => $composableBuilder(
    column: $table.missingCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get failedCount => $composableBuilder(
    column: $table.failedCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get failureCode => $composableBuilder(
    column: $table.failureCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get failureMessage => $composableBuilder(
    column: $table.failureMessage,
    builder: (column) => ColumnOrderings(column),
  );

  $$LibraryRootsTableOrderingComposer get rootId {
    final $$LibraryRootsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rootId,
      referencedTable: $db.libraryRoots,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LibraryRootsTableOrderingComposer(
            $db: $db,
            $table: $db.libraryRoots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScanRunsTableAnnotationComposer
    extends Composer<_$MediaLibraryDatabase, $ScanRunsTable> {
  $$ScanRunsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get rowId =>
      $composableBuilder(column: $table.rowId, builder: (column) => column);

  GeneratedColumn<String> get publicId =>
      $composableBuilder(column: $table.publicId, builder: (column) => column);

  GeneratedColumn<int> get generation => $composableBuilder(
    column: $table.generation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get discoveredCount => $composableBuilder(
    column: $table.discoveredCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unchangedCount => $composableBuilder(
    column: $table.unchangedCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get parsedCount => $composableBuilder(
    column: $table.parsedCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get insertedCount => $composableBuilder(
    column: $table.insertedCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedCount => $composableBuilder(
    column: $table.updatedCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get missingCount => $composableBuilder(
    column: $table.missingCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get failedCount => $composableBuilder(
    column: $table.failedCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get failureCode => $composableBuilder(
    column: $table.failureCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get failureMessage => $composableBuilder(
    column: $table.failureMessage,
    builder: (column) => column,
  );

  $$LibraryRootsTableAnnotationComposer get rootId {
    final $$LibraryRootsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rootId,
      referencedTable: $db.libraryRoots,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LibraryRootsTableAnnotationComposer(
            $db: $db,
            $table: $db.libraryRoots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScanRunsTableTableManager
    extends
        RootTableManager<
          _$MediaLibraryDatabase,
          $ScanRunsTable,
          ScanRun,
          $$ScanRunsTableFilterComposer,
          $$ScanRunsTableOrderingComposer,
          $$ScanRunsTableAnnotationComposer,
          $$ScanRunsTableCreateCompanionBuilder,
          $$ScanRunsTableUpdateCompanionBuilder,
          (ScanRun, $$ScanRunsTableReferences),
          ScanRun,
          PrefetchHooks Function({bool rootId})
        > {
  $$ScanRunsTableTableManager(_$MediaLibraryDatabase db, $ScanRunsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScanRunsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScanRunsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScanRunsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> rowId = const Value.absent(),
                Value<String> publicId = const Value.absent(),
                Value<int> rootId = const Value.absent(),
                Value<int> generation = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> finishedAt = const Value.absent(),
                Value<int> discoveredCount = const Value.absent(),
                Value<int> unchangedCount = const Value.absent(),
                Value<int> parsedCount = const Value.absent(),
                Value<int> insertedCount = const Value.absent(),
                Value<int> updatedCount = const Value.absent(),
                Value<int> missingCount = const Value.absent(),
                Value<int> failedCount = const Value.absent(),
                Value<String?> failureCode = const Value.absent(),
                Value<String?> failureMessage = const Value.absent(),
              }) => ScanRunsCompanion(
                rowId: rowId,
                publicId: publicId,
                rootId: rootId,
                generation: generation,
                status: status,
                startedAt: startedAt,
                finishedAt: finishedAt,
                discoveredCount: discoveredCount,
                unchangedCount: unchangedCount,
                parsedCount: parsedCount,
                insertedCount: insertedCount,
                updatedCount: updatedCount,
                missingCount: missingCount,
                failedCount: failedCount,
                failureCode: failureCode,
                failureMessage: failureMessage,
              ),
          createCompanionCallback:
              ({
                Value<int> rowId = const Value.absent(),
                required String publicId,
                required int rootId,
                required int generation,
                required String status,
                required DateTime startedAt,
                Value<DateTime?> finishedAt = const Value.absent(),
                Value<int> discoveredCount = const Value.absent(),
                Value<int> unchangedCount = const Value.absent(),
                Value<int> parsedCount = const Value.absent(),
                Value<int> insertedCount = const Value.absent(),
                Value<int> updatedCount = const Value.absent(),
                Value<int> missingCount = const Value.absent(),
                Value<int> failedCount = const Value.absent(),
                Value<String?> failureCode = const Value.absent(),
                Value<String?> failureMessage = const Value.absent(),
              }) => ScanRunsCompanion.insert(
                rowId: rowId,
                publicId: publicId,
                rootId: rootId,
                generation: generation,
                status: status,
                startedAt: startedAt,
                finishedAt: finishedAt,
                discoveredCount: discoveredCount,
                unchangedCount: unchangedCount,
                parsedCount: parsedCount,
                insertedCount: insertedCount,
                updatedCount: updatedCount,
                missingCount: missingCount,
                failedCount: failedCount,
                failureCode: failureCode,
                failureMessage: failureMessage,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ScanRunsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({rootId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (rootId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.rootId,
                                referencedTable: $$ScanRunsTableReferences
                                    ._rootIdTable(db),
                                referencedColumn: $$ScanRunsTableReferences
                                    ._rootIdTable(db)
                                    .rowId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ScanRunsTableProcessedTableManager =
    ProcessedTableManager<
      _$MediaLibraryDatabase,
      $ScanRunsTable,
      ScanRun,
      $$ScanRunsTableFilterComposer,
      $$ScanRunsTableOrderingComposer,
      $$ScanRunsTableAnnotationComposer,
      $$ScanRunsTableCreateCompanionBuilder,
      $$ScanRunsTableUpdateCompanionBuilder,
      (ScanRun, $$ScanRunsTableReferences),
      ScanRun,
      PrefetchHooks Function({bool rootId})
    >;
typedef $$MediaFilesTableCreateCompanionBuilder =
    MediaFilesCompanion Function({
      Value<int> rowId,
      required String publicId,
      required int rootId,
      required String locator,
      required String locatorKey,
      required String relativePath,
      required String fileName,
      required String extension,
      required int sizeBytes,
      required int modifiedAtMicros,
      Value<String?> platformFileId,
      Value<String?> quickFingerprint,
      Value<String?> contentHash,
      required String availabilityState,
      required String metadataState,
      required int lastSeenGeneration,
      required DateTime lastSeenAt,
      Value<DateTime?> missingSince,
      Value<String?> lastErrorCode,
      Value<String?> lastErrorMessage,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$MediaFilesTableUpdateCompanionBuilder =
    MediaFilesCompanion Function({
      Value<int> rowId,
      Value<String> publicId,
      Value<int> rootId,
      Value<String> locator,
      Value<String> locatorKey,
      Value<String> relativePath,
      Value<String> fileName,
      Value<String> extension,
      Value<int> sizeBytes,
      Value<int> modifiedAtMicros,
      Value<String?> platformFileId,
      Value<String?> quickFingerprint,
      Value<String?> contentHash,
      Value<String> availabilityState,
      Value<String> metadataState,
      Value<int> lastSeenGeneration,
      Value<DateTime> lastSeenAt,
      Value<DateTime?> missingSince,
      Value<String?> lastErrorCode,
      Value<String?> lastErrorMessage,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$MediaFilesTableReferences
    extends
        BaseReferences<_$MediaLibraryDatabase, $MediaFilesTable, MediaFile> {
  $$MediaFilesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LibraryRootsTable _rootIdTable(_$MediaLibraryDatabase db) =>
      db.libraryRoots.createAlias(
        $_aliasNameGenerator(db.mediaFiles.rootId, db.libraryRoots.rowId),
      );

  $$LibraryRootsTableProcessedTableManager get rootId {
    final $_column = $_itemColumn<int>('root_id')!;

    final manager = $$LibraryRootsTableTableManager(
      $_db,
      $_db.libraryRoots,
    ).filter((f) => f.rowId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_rootIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TracksTable, List<Track>> _tracksRefsTable(
    _$MediaLibraryDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tracks,
    aliasName: $_aliasNameGenerator(db.mediaFiles.rowId, db.tracks.mediaFileId),
  );

  $$TracksTableProcessedTableManager get tracksRefs {
    final manager = $$TracksTableTableManager($_db, $_db.tracks).filter(
      (f) => f.mediaFileId.rowId.sqlEquals($_itemColumn<int>('row_id')!),
    );

    final cache = $_typedResult.readTableOrNull(_tracksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MediaFilesTableFilterComposer
    extends Composer<_$MediaLibraryDatabase, $MediaFilesTable> {
  $$MediaFilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get publicId => $composableBuilder(
    column: $table.publicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locator => $composableBuilder(
    column: $table.locator,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locatorKey => $composableBuilder(
    column: $table.locatorKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get extension => $composableBuilder(
    column: $table.extension,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get modifiedAtMicros => $composableBuilder(
    column: $table.modifiedAtMicros,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get platformFileId => $composableBuilder(
    column: $table.platformFileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quickFingerprint => $composableBuilder(
    column: $table.quickFingerprint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get availabilityState => $composableBuilder(
    column: $table.availabilityState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataState => $composableBuilder(
    column: $table.metadataState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastSeenGeneration => $composableBuilder(
    column: $table.lastSeenGeneration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get missingSince => $composableBuilder(
    column: $table.missingSince,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastErrorCode => $composableBuilder(
    column: $table.lastErrorCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastErrorMessage => $composableBuilder(
    column: $table.lastErrorMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LibraryRootsTableFilterComposer get rootId {
    final $$LibraryRootsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rootId,
      referencedTable: $db.libraryRoots,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LibraryRootsTableFilterComposer(
            $db: $db,
            $table: $db.libraryRoots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> tracksRefs(
    Expression<bool> Function($$TracksTableFilterComposer f) f,
  ) {
    final $$TracksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.tracks,
      getReferencedColumn: (t) => t.mediaFileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TracksTableFilterComposer(
            $db: $db,
            $table: $db.tracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MediaFilesTableOrderingComposer
    extends Composer<_$MediaLibraryDatabase, $MediaFilesTable> {
  $$MediaFilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publicId => $composableBuilder(
    column: $table.publicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locator => $composableBuilder(
    column: $table.locator,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locatorKey => $composableBuilder(
    column: $table.locatorKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get extension => $composableBuilder(
    column: $table.extension,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get modifiedAtMicros => $composableBuilder(
    column: $table.modifiedAtMicros,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platformFileId => $composableBuilder(
    column: $table.platformFileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quickFingerprint => $composableBuilder(
    column: $table.quickFingerprint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get availabilityState => $composableBuilder(
    column: $table.availabilityState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataState => $composableBuilder(
    column: $table.metadataState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastSeenGeneration => $composableBuilder(
    column: $table.lastSeenGeneration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get missingSince => $composableBuilder(
    column: $table.missingSince,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastErrorCode => $composableBuilder(
    column: $table.lastErrorCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastErrorMessage => $composableBuilder(
    column: $table.lastErrorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LibraryRootsTableOrderingComposer get rootId {
    final $$LibraryRootsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rootId,
      referencedTable: $db.libraryRoots,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LibraryRootsTableOrderingComposer(
            $db: $db,
            $table: $db.libraryRoots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MediaFilesTableAnnotationComposer
    extends Composer<_$MediaLibraryDatabase, $MediaFilesTable> {
  $$MediaFilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get rowId =>
      $composableBuilder(column: $table.rowId, builder: (column) => column);

  GeneratedColumn<String> get publicId =>
      $composableBuilder(column: $table.publicId, builder: (column) => column);

  GeneratedColumn<String> get locator =>
      $composableBuilder(column: $table.locator, builder: (column) => column);

  GeneratedColumn<String> get locatorKey => $composableBuilder(
    column: $table.locatorKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get extension =>
      $composableBuilder(column: $table.extension, builder: (column) => column);

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<int> get modifiedAtMicros => $composableBuilder(
    column: $table.modifiedAtMicros,
    builder: (column) => column,
  );

  GeneratedColumn<String> get platformFileId => $composableBuilder(
    column: $table.platformFileId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get quickFingerprint => $composableBuilder(
    column: $table.quickFingerprint,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get availabilityState => $composableBuilder(
    column: $table.availabilityState,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadataState => $composableBuilder(
    column: $table.metadataState,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastSeenGeneration => $composableBuilder(
    column: $table.lastSeenGeneration,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get missingSince => $composableBuilder(
    column: $table.missingSince,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastErrorCode => $composableBuilder(
    column: $table.lastErrorCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastErrorMessage => $composableBuilder(
    column: $table.lastErrorMessage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$LibraryRootsTableAnnotationComposer get rootId {
    final $$LibraryRootsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rootId,
      referencedTable: $db.libraryRoots,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LibraryRootsTableAnnotationComposer(
            $db: $db,
            $table: $db.libraryRoots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> tracksRefs<T extends Object>(
    Expression<T> Function($$TracksTableAnnotationComposer a) f,
  ) {
    final $$TracksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.tracks,
      getReferencedColumn: (t) => t.mediaFileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TracksTableAnnotationComposer(
            $db: $db,
            $table: $db.tracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MediaFilesTableTableManager
    extends
        RootTableManager<
          _$MediaLibraryDatabase,
          $MediaFilesTable,
          MediaFile,
          $$MediaFilesTableFilterComposer,
          $$MediaFilesTableOrderingComposer,
          $$MediaFilesTableAnnotationComposer,
          $$MediaFilesTableCreateCompanionBuilder,
          $$MediaFilesTableUpdateCompanionBuilder,
          (MediaFile, $$MediaFilesTableReferences),
          MediaFile,
          PrefetchHooks Function({bool rootId, bool tracksRefs})
        > {
  $$MediaFilesTableTableManager(
    _$MediaLibraryDatabase db,
    $MediaFilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MediaFilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MediaFilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MediaFilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> rowId = const Value.absent(),
                Value<String> publicId = const Value.absent(),
                Value<int> rootId = const Value.absent(),
                Value<String> locator = const Value.absent(),
                Value<String> locatorKey = const Value.absent(),
                Value<String> relativePath = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<String> extension = const Value.absent(),
                Value<int> sizeBytes = const Value.absent(),
                Value<int> modifiedAtMicros = const Value.absent(),
                Value<String?> platformFileId = const Value.absent(),
                Value<String?> quickFingerprint = const Value.absent(),
                Value<String?> contentHash = const Value.absent(),
                Value<String> availabilityState = const Value.absent(),
                Value<String> metadataState = const Value.absent(),
                Value<int> lastSeenGeneration = const Value.absent(),
                Value<DateTime> lastSeenAt = const Value.absent(),
                Value<DateTime?> missingSince = const Value.absent(),
                Value<String?> lastErrorCode = const Value.absent(),
                Value<String?> lastErrorMessage = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MediaFilesCompanion(
                rowId: rowId,
                publicId: publicId,
                rootId: rootId,
                locator: locator,
                locatorKey: locatorKey,
                relativePath: relativePath,
                fileName: fileName,
                extension: extension,
                sizeBytes: sizeBytes,
                modifiedAtMicros: modifiedAtMicros,
                platformFileId: platformFileId,
                quickFingerprint: quickFingerprint,
                contentHash: contentHash,
                availabilityState: availabilityState,
                metadataState: metadataState,
                lastSeenGeneration: lastSeenGeneration,
                lastSeenAt: lastSeenAt,
                missingSince: missingSince,
                lastErrorCode: lastErrorCode,
                lastErrorMessage: lastErrorMessage,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> rowId = const Value.absent(),
                required String publicId,
                required int rootId,
                required String locator,
                required String locatorKey,
                required String relativePath,
                required String fileName,
                required String extension,
                required int sizeBytes,
                required int modifiedAtMicros,
                Value<String?> platformFileId = const Value.absent(),
                Value<String?> quickFingerprint = const Value.absent(),
                Value<String?> contentHash = const Value.absent(),
                required String availabilityState,
                required String metadataState,
                required int lastSeenGeneration,
                required DateTime lastSeenAt,
                Value<DateTime?> missingSince = const Value.absent(),
                Value<String?> lastErrorCode = const Value.absent(),
                Value<String?> lastErrorMessage = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => MediaFilesCompanion.insert(
                rowId: rowId,
                publicId: publicId,
                rootId: rootId,
                locator: locator,
                locatorKey: locatorKey,
                relativePath: relativePath,
                fileName: fileName,
                extension: extension,
                sizeBytes: sizeBytes,
                modifiedAtMicros: modifiedAtMicros,
                platformFileId: platformFileId,
                quickFingerprint: quickFingerprint,
                contentHash: contentHash,
                availabilityState: availabilityState,
                metadataState: metadataState,
                lastSeenGeneration: lastSeenGeneration,
                lastSeenAt: lastSeenAt,
                missingSince: missingSince,
                lastErrorCode: lastErrorCode,
                lastErrorMessage: lastErrorMessage,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MediaFilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({rootId = false, tracksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (tracksRefs) db.tracks],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (rootId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.rootId,
                                referencedTable: $$MediaFilesTableReferences
                                    ._rootIdTable(db),
                                referencedColumn: $$MediaFilesTableReferences
                                    ._rootIdTable(db)
                                    .rowId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tracksRefs)
                    await $_getPrefetchedData<
                      MediaFile,
                      $MediaFilesTable,
                      Track
                    >(
                      currentTable: table,
                      referencedTable: $$MediaFilesTableReferences
                          ._tracksRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$MediaFilesTableReferences(db, table, p0).tracksRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.mediaFileId == item.rowId,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MediaFilesTableProcessedTableManager =
    ProcessedTableManager<
      _$MediaLibraryDatabase,
      $MediaFilesTable,
      MediaFile,
      $$MediaFilesTableFilterComposer,
      $$MediaFilesTableOrderingComposer,
      $$MediaFilesTableAnnotationComposer,
      $$MediaFilesTableCreateCompanionBuilder,
      $$MediaFilesTableUpdateCompanionBuilder,
      (MediaFile, $$MediaFilesTableReferences),
      MediaFile,
      PrefetchHooks Function({bool rootId, bool tracksRefs})
    >;
typedef $$ArtworkAssetsTableCreateCompanionBuilder =
    ArtworkAssetsCompanion Function({
      Value<int> rowId,
      required String publicId,
      required String contentHash,
      required String mimeType,
      required int byteLength,
      required String relativeCachePath,
      required DateTime createdAt,
      Value<DateTime?> lastAccessedAt,
    });
typedef $$ArtworkAssetsTableUpdateCompanionBuilder =
    ArtworkAssetsCompanion Function({
      Value<int> rowId,
      Value<String> publicId,
      Value<String> contentHash,
      Value<String> mimeType,
      Value<int> byteLength,
      Value<String> relativeCachePath,
      Value<DateTime> createdAt,
      Value<DateTime?> lastAccessedAt,
    });

final class $$ArtworkAssetsTableReferences
    extends
        BaseReferences<
          _$MediaLibraryDatabase,
          $ArtworkAssetsTable,
          ArtworkAsset
        > {
  $$ArtworkAssetsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$AlbumsTable, List<Album>> _albumsRefsTable(
    _$MediaLibraryDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.albums,
    aliasName: $_aliasNameGenerator(
      db.artworkAssets.rowId,
      db.albums.artworkId,
    ),
  );

  $$AlbumsTableProcessedTableManager get albumsRefs {
    final manager = $$AlbumsTableTableManager(
      $_db,
      $_db.albums,
    ).filter((f) => f.artworkId.rowId.sqlEquals($_itemColumn<int>('row_id')!));

    final cache = $_typedResult.readTableOrNull(_albumsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TracksTable, List<Track>> _tracksRefsTable(
    _$MediaLibraryDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tracks,
    aliasName: $_aliasNameGenerator(
      db.artworkAssets.rowId,
      db.tracks.artworkId,
    ),
  );

  $$TracksTableProcessedTableManager get tracksRefs {
    final manager = $$TracksTableTableManager(
      $_db,
      $_db.tracks,
    ).filter((f) => f.artworkId.rowId.sqlEquals($_itemColumn<int>('row_id')!));

    final cache = $_typedResult.readTableOrNull(_tracksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ArtworkAssetsTableFilterComposer
    extends Composer<_$MediaLibraryDatabase, $ArtworkAssetsTable> {
  $$ArtworkAssetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get publicId => $composableBuilder(
    column: $table.publicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get byteLength => $composableBuilder(
    column: $table.byteLength,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relativeCachePath => $composableBuilder(
    column: $table.relativeCachePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAccessedAt => $composableBuilder(
    column: $table.lastAccessedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> albumsRefs(
    Expression<bool> Function($$AlbumsTableFilterComposer f) f,
  ) {
    final $$AlbumsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.albums,
      getReferencedColumn: (t) => t.artworkId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlbumsTableFilterComposer(
            $db: $db,
            $table: $db.albums,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> tracksRefs(
    Expression<bool> Function($$TracksTableFilterComposer f) f,
  ) {
    final $$TracksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.tracks,
      getReferencedColumn: (t) => t.artworkId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TracksTableFilterComposer(
            $db: $db,
            $table: $db.tracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ArtworkAssetsTableOrderingComposer
    extends Composer<_$MediaLibraryDatabase, $ArtworkAssetsTable> {
  $$ArtworkAssetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publicId => $composableBuilder(
    column: $table.publicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get byteLength => $composableBuilder(
    column: $table.byteLength,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relativeCachePath => $composableBuilder(
    column: $table.relativeCachePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAccessedAt => $composableBuilder(
    column: $table.lastAccessedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ArtworkAssetsTableAnnotationComposer
    extends Composer<_$MediaLibraryDatabase, $ArtworkAssetsTable> {
  $$ArtworkAssetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get rowId =>
      $composableBuilder(column: $table.rowId, builder: (column) => column);

  GeneratedColumn<String> get publicId =>
      $composableBuilder(column: $table.publicId, builder: (column) => column);

  GeneratedColumn<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<int> get byteLength => $composableBuilder(
    column: $table.byteLength,
    builder: (column) => column,
  );

  GeneratedColumn<String> get relativeCachePath => $composableBuilder(
    column: $table.relativeCachePath,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAccessedAt => $composableBuilder(
    column: $table.lastAccessedAt,
    builder: (column) => column,
  );

  Expression<T> albumsRefs<T extends Object>(
    Expression<T> Function($$AlbumsTableAnnotationComposer a) f,
  ) {
    final $$AlbumsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.albums,
      getReferencedColumn: (t) => t.artworkId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlbumsTableAnnotationComposer(
            $db: $db,
            $table: $db.albums,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> tracksRefs<T extends Object>(
    Expression<T> Function($$TracksTableAnnotationComposer a) f,
  ) {
    final $$TracksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.tracks,
      getReferencedColumn: (t) => t.artworkId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TracksTableAnnotationComposer(
            $db: $db,
            $table: $db.tracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ArtworkAssetsTableTableManager
    extends
        RootTableManager<
          _$MediaLibraryDatabase,
          $ArtworkAssetsTable,
          ArtworkAsset,
          $$ArtworkAssetsTableFilterComposer,
          $$ArtworkAssetsTableOrderingComposer,
          $$ArtworkAssetsTableAnnotationComposer,
          $$ArtworkAssetsTableCreateCompanionBuilder,
          $$ArtworkAssetsTableUpdateCompanionBuilder,
          (ArtworkAsset, $$ArtworkAssetsTableReferences),
          ArtworkAsset,
          PrefetchHooks Function({bool albumsRefs, bool tracksRefs})
        > {
  $$ArtworkAssetsTableTableManager(
    _$MediaLibraryDatabase db,
    $ArtworkAssetsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArtworkAssetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArtworkAssetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ArtworkAssetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> rowId = const Value.absent(),
                Value<String> publicId = const Value.absent(),
                Value<String> contentHash = const Value.absent(),
                Value<String> mimeType = const Value.absent(),
                Value<int> byteLength = const Value.absent(),
                Value<String> relativeCachePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastAccessedAt = const Value.absent(),
              }) => ArtworkAssetsCompanion(
                rowId: rowId,
                publicId: publicId,
                contentHash: contentHash,
                mimeType: mimeType,
                byteLength: byteLength,
                relativeCachePath: relativeCachePath,
                createdAt: createdAt,
                lastAccessedAt: lastAccessedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> rowId = const Value.absent(),
                required String publicId,
                required String contentHash,
                required String mimeType,
                required int byteLength,
                required String relativeCachePath,
                required DateTime createdAt,
                Value<DateTime?> lastAccessedAt = const Value.absent(),
              }) => ArtworkAssetsCompanion.insert(
                rowId: rowId,
                publicId: publicId,
                contentHash: contentHash,
                mimeType: mimeType,
                byteLength: byteLength,
                relativeCachePath: relativeCachePath,
                createdAt: createdAt,
                lastAccessedAt: lastAccessedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ArtworkAssetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({albumsRefs = false, tracksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (albumsRefs) db.albums,
                if (tracksRefs) db.tracks,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (albumsRefs)
                    await $_getPrefetchedData<
                      ArtworkAsset,
                      $ArtworkAssetsTable,
                      Album
                    >(
                      currentTable: table,
                      referencedTable: $$ArtworkAssetsTableReferences
                          ._albumsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ArtworkAssetsTableReferences(
                            db,
                            table,
                            p0,
                          ).albumsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.artworkId == item.rowId,
                          ),
                      typedResults: items,
                    ),
                  if (tracksRefs)
                    await $_getPrefetchedData<
                      ArtworkAsset,
                      $ArtworkAssetsTable,
                      Track
                    >(
                      currentTable: table,
                      referencedTable: $$ArtworkAssetsTableReferences
                          ._tracksRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ArtworkAssetsTableReferences(
                            db,
                            table,
                            p0,
                          ).tracksRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.artworkId == item.rowId,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ArtworkAssetsTableProcessedTableManager =
    ProcessedTableManager<
      _$MediaLibraryDatabase,
      $ArtworkAssetsTable,
      ArtworkAsset,
      $$ArtworkAssetsTableFilterComposer,
      $$ArtworkAssetsTableOrderingComposer,
      $$ArtworkAssetsTableAnnotationComposer,
      $$ArtworkAssetsTableCreateCompanionBuilder,
      $$ArtworkAssetsTableUpdateCompanionBuilder,
      (ArtworkAsset, $$ArtworkAssetsTableReferences),
      ArtworkAsset,
      PrefetchHooks Function({bool albumsRefs, bool tracksRefs})
    >;
typedef $$ArtistsTableCreateCompanionBuilder =
    ArtistsCompanion Function({
      Value<int> rowId,
      required String publicId,
      required String name,
      required String sortName,
      required String identityKey,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$ArtistsTableUpdateCompanionBuilder =
    ArtistsCompanion Function({
      Value<int> rowId,
      Value<String> publicId,
      Value<String> name,
      Value<String> sortName,
      Value<String> identityKey,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$ArtistsTableReferences
    extends BaseReferences<_$MediaLibraryDatabase, $ArtistsTable, Artist> {
  $$ArtistsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AlbumsTable, List<Album>> _albumsRefsTable(
    _$MediaLibraryDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.albums,
    aliasName: $_aliasNameGenerator(db.artists.rowId, db.albums.albumArtistId),
  );

  $$AlbumsTableProcessedTableManager get albumsRefs {
    final manager = $$AlbumsTableTableManager($_db, $_db.albums).filter(
      (f) => f.albumArtistId.rowId.sqlEquals($_itemColumn<int>('row_id')!),
    );

    final cache = $_typedResult.readTableOrNull(_albumsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TrackArtistsTable, List<TrackArtist>>
  _trackArtistsRefsTable(_$MediaLibraryDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.trackArtists,
        aliasName: $_aliasNameGenerator(
          db.artists.rowId,
          db.trackArtists.artistId,
        ),
      );

  $$TrackArtistsTableProcessedTableManager get trackArtistsRefs {
    final manager = $$TrackArtistsTableTableManager(
      $_db,
      $_db.trackArtists,
    ).filter((f) => f.artistId.rowId.sqlEquals($_itemColumn<int>('row_id')!));

    final cache = $_typedResult.readTableOrNull(_trackArtistsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ArtistsTableFilterComposer
    extends Composer<_$MediaLibraryDatabase, $ArtistsTable> {
  $$ArtistsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get publicId => $composableBuilder(
    column: $table.publicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sortName => $composableBuilder(
    column: $table.sortName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get identityKey => $composableBuilder(
    column: $table.identityKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> albumsRefs(
    Expression<bool> Function($$AlbumsTableFilterComposer f) f,
  ) {
    final $$AlbumsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.albums,
      getReferencedColumn: (t) => t.albumArtistId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlbumsTableFilterComposer(
            $db: $db,
            $table: $db.albums,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> trackArtistsRefs(
    Expression<bool> Function($$TrackArtistsTableFilterComposer f) f,
  ) {
    final $$TrackArtistsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.trackArtists,
      getReferencedColumn: (t) => t.artistId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackArtistsTableFilterComposer(
            $db: $db,
            $table: $db.trackArtists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ArtistsTableOrderingComposer
    extends Composer<_$MediaLibraryDatabase, $ArtistsTable> {
  $$ArtistsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publicId => $composableBuilder(
    column: $table.publicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sortName => $composableBuilder(
    column: $table.sortName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get identityKey => $composableBuilder(
    column: $table.identityKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ArtistsTableAnnotationComposer
    extends Composer<_$MediaLibraryDatabase, $ArtistsTable> {
  $$ArtistsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get rowId =>
      $composableBuilder(column: $table.rowId, builder: (column) => column);

  GeneratedColumn<String> get publicId =>
      $composableBuilder(column: $table.publicId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get sortName =>
      $composableBuilder(column: $table.sortName, builder: (column) => column);

  GeneratedColumn<String> get identityKey => $composableBuilder(
    column: $table.identityKey,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> albumsRefs<T extends Object>(
    Expression<T> Function($$AlbumsTableAnnotationComposer a) f,
  ) {
    final $$AlbumsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.albums,
      getReferencedColumn: (t) => t.albumArtistId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlbumsTableAnnotationComposer(
            $db: $db,
            $table: $db.albums,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> trackArtistsRefs<T extends Object>(
    Expression<T> Function($$TrackArtistsTableAnnotationComposer a) f,
  ) {
    final $$TrackArtistsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.trackArtists,
      getReferencedColumn: (t) => t.artistId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackArtistsTableAnnotationComposer(
            $db: $db,
            $table: $db.trackArtists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ArtistsTableTableManager
    extends
        RootTableManager<
          _$MediaLibraryDatabase,
          $ArtistsTable,
          Artist,
          $$ArtistsTableFilterComposer,
          $$ArtistsTableOrderingComposer,
          $$ArtistsTableAnnotationComposer,
          $$ArtistsTableCreateCompanionBuilder,
          $$ArtistsTableUpdateCompanionBuilder,
          (Artist, $$ArtistsTableReferences),
          Artist,
          PrefetchHooks Function({bool albumsRefs, bool trackArtistsRefs})
        > {
  $$ArtistsTableTableManager(_$MediaLibraryDatabase db, $ArtistsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArtistsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArtistsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ArtistsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> rowId = const Value.absent(),
                Value<String> publicId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> sortName = const Value.absent(),
                Value<String> identityKey = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ArtistsCompanion(
                rowId: rowId,
                publicId: publicId,
                name: name,
                sortName: sortName,
                identityKey: identityKey,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> rowId = const Value.absent(),
                required String publicId,
                required String name,
                required String sortName,
                required String identityKey,
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => ArtistsCompanion.insert(
                rowId: rowId,
                publicId: publicId,
                name: name,
                sortName: sortName,
                identityKey: identityKey,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ArtistsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({albumsRefs = false, trackArtistsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (albumsRefs) db.albums,
                    if (trackArtistsRefs) db.trackArtists,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (albumsRefs)
                        await $_getPrefetchedData<Artist, $ArtistsTable, Album>(
                          currentTable: table,
                          referencedTable: $$ArtistsTableReferences
                              ._albumsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ArtistsTableReferences(
                                db,
                                table,
                                p0,
                              ).albumsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.albumArtistId == item.rowId,
                              ),
                          typedResults: items,
                        ),
                      if (trackArtistsRefs)
                        await $_getPrefetchedData<
                          Artist,
                          $ArtistsTable,
                          TrackArtist
                        >(
                          currentTable: table,
                          referencedTable: $$ArtistsTableReferences
                              ._trackArtistsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ArtistsTableReferences(
                                db,
                                table,
                                p0,
                              ).trackArtistsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.artistId == item.rowId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ArtistsTableProcessedTableManager =
    ProcessedTableManager<
      _$MediaLibraryDatabase,
      $ArtistsTable,
      Artist,
      $$ArtistsTableFilterComposer,
      $$ArtistsTableOrderingComposer,
      $$ArtistsTableAnnotationComposer,
      $$ArtistsTableCreateCompanionBuilder,
      $$ArtistsTableUpdateCompanionBuilder,
      (Artist, $$ArtistsTableReferences),
      Artist,
      PrefetchHooks Function({bool albumsRefs, bool trackArtistsRefs})
    >;
typedef $$AlbumsTableCreateCompanionBuilder =
    AlbumsCompanion Function({
      Value<int> rowId,
      required String publicId,
      required String title,
      required String sortTitle,
      required String identityKey,
      Value<int?> albumArtistId,
      Value<int?> releaseYear,
      Value<int?> artworkId,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$AlbumsTableUpdateCompanionBuilder =
    AlbumsCompanion Function({
      Value<int> rowId,
      Value<String> publicId,
      Value<String> title,
      Value<String> sortTitle,
      Value<String> identityKey,
      Value<int?> albumArtistId,
      Value<int?> releaseYear,
      Value<int?> artworkId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$AlbumsTableReferences
    extends BaseReferences<_$MediaLibraryDatabase, $AlbumsTable, Album> {
  $$AlbumsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ArtistsTable _albumArtistIdTable(_$MediaLibraryDatabase db) =>
      db.artists.createAlias(
        $_aliasNameGenerator(db.albums.albumArtistId, db.artists.rowId),
      );

  $$ArtistsTableProcessedTableManager? get albumArtistId {
    final $_column = $_itemColumn<int>('album_artist_id');
    if ($_column == null) return null;
    final manager = $$ArtistsTableTableManager(
      $_db,
      $_db.artists,
    ).filter((f) => f.rowId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_albumArtistIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ArtworkAssetsTable _artworkIdTable(_$MediaLibraryDatabase db) =>
      db.artworkAssets.createAlias(
        $_aliasNameGenerator(db.albums.artworkId, db.artworkAssets.rowId),
      );

  $$ArtworkAssetsTableProcessedTableManager? get artworkId {
    final $_column = $_itemColumn<int>('artwork_id');
    if ($_column == null) return null;
    final manager = $$ArtworkAssetsTableTableManager(
      $_db,
      $_db.artworkAssets,
    ).filter((f) => f.rowId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_artworkIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TracksTable, List<Track>> _tracksRefsTable(
    _$MediaLibraryDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tracks,
    aliasName: $_aliasNameGenerator(db.albums.rowId, db.tracks.albumId),
  );

  $$TracksTableProcessedTableManager get tracksRefs {
    final manager = $$TracksTableTableManager(
      $_db,
      $_db.tracks,
    ).filter((f) => f.albumId.rowId.sqlEquals($_itemColumn<int>('row_id')!));

    final cache = $_typedResult.readTableOrNull(_tracksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AlbumsTableFilterComposer
    extends Composer<_$MediaLibraryDatabase, $AlbumsTable> {
  $$AlbumsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get publicId => $composableBuilder(
    column: $table.publicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sortTitle => $composableBuilder(
    column: $table.sortTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get identityKey => $composableBuilder(
    column: $table.identityKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get releaseYear => $composableBuilder(
    column: $table.releaseYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ArtistsTableFilterComposer get albumArtistId {
    final $$ArtistsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.albumArtistId,
      referencedTable: $db.artists,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArtistsTableFilterComposer(
            $db: $db,
            $table: $db.artists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArtworkAssetsTableFilterComposer get artworkId {
    final $$ArtworkAssetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.artworkId,
      referencedTable: $db.artworkAssets,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArtworkAssetsTableFilterComposer(
            $db: $db,
            $table: $db.artworkAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> tracksRefs(
    Expression<bool> Function($$TracksTableFilterComposer f) f,
  ) {
    final $$TracksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.tracks,
      getReferencedColumn: (t) => t.albumId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TracksTableFilterComposer(
            $db: $db,
            $table: $db.tracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AlbumsTableOrderingComposer
    extends Composer<_$MediaLibraryDatabase, $AlbumsTable> {
  $$AlbumsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publicId => $composableBuilder(
    column: $table.publicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sortTitle => $composableBuilder(
    column: $table.sortTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get identityKey => $composableBuilder(
    column: $table.identityKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get releaseYear => $composableBuilder(
    column: $table.releaseYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ArtistsTableOrderingComposer get albumArtistId {
    final $$ArtistsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.albumArtistId,
      referencedTable: $db.artists,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArtistsTableOrderingComposer(
            $db: $db,
            $table: $db.artists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArtworkAssetsTableOrderingComposer get artworkId {
    final $$ArtworkAssetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.artworkId,
      referencedTable: $db.artworkAssets,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArtworkAssetsTableOrderingComposer(
            $db: $db,
            $table: $db.artworkAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AlbumsTableAnnotationComposer
    extends Composer<_$MediaLibraryDatabase, $AlbumsTable> {
  $$AlbumsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get rowId =>
      $composableBuilder(column: $table.rowId, builder: (column) => column);

  GeneratedColumn<String> get publicId =>
      $composableBuilder(column: $table.publicId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get sortTitle =>
      $composableBuilder(column: $table.sortTitle, builder: (column) => column);

  GeneratedColumn<String> get identityKey => $composableBuilder(
    column: $table.identityKey,
    builder: (column) => column,
  );

  GeneratedColumn<int> get releaseYear => $composableBuilder(
    column: $table.releaseYear,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ArtistsTableAnnotationComposer get albumArtistId {
    final $$ArtistsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.albumArtistId,
      referencedTable: $db.artists,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArtistsTableAnnotationComposer(
            $db: $db,
            $table: $db.artists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArtworkAssetsTableAnnotationComposer get artworkId {
    final $$ArtworkAssetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.artworkId,
      referencedTable: $db.artworkAssets,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArtworkAssetsTableAnnotationComposer(
            $db: $db,
            $table: $db.artworkAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> tracksRefs<T extends Object>(
    Expression<T> Function($$TracksTableAnnotationComposer a) f,
  ) {
    final $$TracksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.tracks,
      getReferencedColumn: (t) => t.albumId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TracksTableAnnotationComposer(
            $db: $db,
            $table: $db.tracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AlbumsTableTableManager
    extends
        RootTableManager<
          _$MediaLibraryDatabase,
          $AlbumsTable,
          Album,
          $$AlbumsTableFilterComposer,
          $$AlbumsTableOrderingComposer,
          $$AlbumsTableAnnotationComposer,
          $$AlbumsTableCreateCompanionBuilder,
          $$AlbumsTableUpdateCompanionBuilder,
          (Album, $$AlbumsTableReferences),
          Album,
          PrefetchHooks Function({
            bool albumArtistId,
            bool artworkId,
            bool tracksRefs,
          })
        > {
  $$AlbumsTableTableManager(_$MediaLibraryDatabase db, $AlbumsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlbumsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlbumsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlbumsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> rowId = const Value.absent(),
                Value<String> publicId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> sortTitle = const Value.absent(),
                Value<String> identityKey = const Value.absent(),
                Value<int?> albumArtistId = const Value.absent(),
                Value<int?> releaseYear = const Value.absent(),
                Value<int?> artworkId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AlbumsCompanion(
                rowId: rowId,
                publicId: publicId,
                title: title,
                sortTitle: sortTitle,
                identityKey: identityKey,
                albumArtistId: albumArtistId,
                releaseYear: releaseYear,
                artworkId: artworkId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> rowId = const Value.absent(),
                required String publicId,
                required String title,
                required String sortTitle,
                required String identityKey,
                Value<int?> albumArtistId = const Value.absent(),
                Value<int?> releaseYear = const Value.absent(),
                Value<int?> artworkId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => AlbumsCompanion.insert(
                rowId: rowId,
                publicId: publicId,
                title: title,
                sortTitle: sortTitle,
                identityKey: identityKey,
                albumArtistId: albumArtistId,
                releaseYear: releaseYear,
                artworkId: artworkId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$AlbumsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({albumArtistId = false, artworkId = false, tracksRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (tracksRefs) db.tracks],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (albumArtistId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.albumArtistId,
                                    referencedTable: $$AlbumsTableReferences
                                        ._albumArtistIdTable(db),
                                    referencedColumn: $$AlbumsTableReferences
                                        ._albumArtistIdTable(db)
                                        .rowId,
                                  )
                                  as T;
                        }
                        if (artworkId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.artworkId,
                                    referencedTable: $$AlbumsTableReferences
                                        ._artworkIdTable(db),
                                    referencedColumn: $$AlbumsTableReferences
                                        ._artworkIdTable(db)
                                        .rowId,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (tracksRefs)
                        await $_getPrefetchedData<Album, $AlbumsTable, Track>(
                          currentTable: table,
                          referencedTable: $$AlbumsTableReferences
                              ._tracksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AlbumsTableReferences(db, table, p0).tracksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.albumId == item.rowId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AlbumsTableProcessedTableManager =
    ProcessedTableManager<
      _$MediaLibraryDatabase,
      $AlbumsTable,
      Album,
      $$AlbumsTableFilterComposer,
      $$AlbumsTableOrderingComposer,
      $$AlbumsTableAnnotationComposer,
      $$AlbumsTableCreateCompanionBuilder,
      $$AlbumsTableUpdateCompanionBuilder,
      (Album, $$AlbumsTableReferences),
      Album,
      PrefetchHooks Function({
        bool albumArtistId,
        bool artworkId,
        bool tracksRefs,
      })
    >;
typedef $$TracksTableCreateCompanionBuilder =
    TracksCompanion Function({
      Value<int> rowId,
      required String publicId,
      required int mediaFileId,
      required String title,
      required String sortTitle,
      Value<String?> displayArtist,
      Value<String?> displayAlbum,
      Value<int?> albumId,
      Value<int?> durationMs,
      Value<int?> bitrateBps,
      Value<int?> sampleRateHz,
      Value<int?> trackNumber,
      Value<int?> trackTotal,
      Value<int?> discNumber,
      Value<int?> discTotal,
      Value<int?> releaseYear,
      Value<String?> language,
      Value<String?> metadataSource,
      Value<int> metadataRevision,
      required String searchText,
      Value<int?> artworkId,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$TracksTableUpdateCompanionBuilder =
    TracksCompanion Function({
      Value<int> rowId,
      Value<String> publicId,
      Value<int> mediaFileId,
      Value<String> title,
      Value<String> sortTitle,
      Value<String?> displayArtist,
      Value<String?> displayAlbum,
      Value<int?> albumId,
      Value<int?> durationMs,
      Value<int?> bitrateBps,
      Value<int?> sampleRateHz,
      Value<int?> trackNumber,
      Value<int?> trackTotal,
      Value<int?> discNumber,
      Value<int?> discTotal,
      Value<int?> releaseYear,
      Value<String?> language,
      Value<String?> metadataSource,
      Value<int> metadataRevision,
      Value<String> searchText,
      Value<int?> artworkId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$TracksTableReferences
    extends BaseReferences<_$MediaLibraryDatabase, $TracksTable, Track> {
  $$TracksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MediaFilesTable _mediaFileIdTable(_$MediaLibraryDatabase db) =>
      db.mediaFiles.createAlias(
        $_aliasNameGenerator(db.tracks.mediaFileId, db.mediaFiles.rowId),
      );

  $$MediaFilesTableProcessedTableManager get mediaFileId {
    final $_column = $_itemColumn<int>('media_file_id')!;

    final manager = $$MediaFilesTableTableManager(
      $_db,
      $_db.mediaFiles,
    ).filter((f) => f.rowId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mediaFileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AlbumsTable _albumIdTable(_$MediaLibraryDatabase db) => db.albums
      .createAlias($_aliasNameGenerator(db.tracks.albumId, db.albums.rowId));

  $$AlbumsTableProcessedTableManager? get albumId {
    final $_column = $_itemColumn<int>('album_id');
    if ($_column == null) return null;
    final manager = $$AlbumsTableTableManager(
      $_db,
      $_db.albums,
    ).filter((f) => f.rowId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_albumIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ArtworkAssetsTable _artworkIdTable(_$MediaLibraryDatabase db) =>
      db.artworkAssets.createAlias(
        $_aliasNameGenerator(db.tracks.artworkId, db.artworkAssets.rowId),
      );

  $$ArtworkAssetsTableProcessedTableManager? get artworkId {
    final $_column = $_itemColumn<int>('artwork_id');
    if ($_column == null) return null;
    final manager = $$ArtworkAssetsTableTableManager(
      $_db,
      $_db.artworkAssets,
    ).filter((f) => f.rowId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_artworkIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TrackArtistsTable, List<TrackArtist>>
  _trackArtistsRefsTable(_$MediaLibraryDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.trackArtists,
        aliasName: $_aliasNameGenerator(
          db.tracks.rowId,
          db.trackArtists.trackId,
        ),
      );

  $$TrackArtistsTableProcessedTableManager get trackArtistsRefs {
    final manager = $$TrackArtistsTableTableManager(
      $_db,
      $_db.trackArtists,
    ).filter((f) => f.trackId.rowId.sqlEquals($_itemColumn<int>('row_id')!));

    final cache = $_typedResult.readTableOrNull(_trackArtistsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TrackGenresTable, List<TrackGenre>>
  _trackGenresRefsTable(_$MediaLibraryDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.trackGenres,
        aliasName: $_aliasNameGenerator(
          db.tracks.rowId,
          db.trackGenres.trackId,
        ),
      );

  $$TrackGenresTableProcessedTableManager get trackGenresRefs {
    final manager = $$TrackGenresTableTableManager(
      $_db,
      $_db.trackGenres,
    ).filter((f) => f.trackId.rowId.sqlEquals($_itemColumn<int>('row_id')!));

    final cache = $_typedResult.readTableOrNull(_trackGenresRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FavoriteTracksTable, List<FavoriteTrack>>
  _favoriteTracksRefsTable(_$MediaLibraryDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.favoriteTracks,
        aliasName: $_aliasNameGenerator(
          db.tracks.rowId,
          db.favoriteTracks.trackId,
        ),
      );

  $$FavoriteTracksTableProcessedTableManager get favoriteTracksRefs {
    final manager = $$FavoriteTracksTableTableManager(
      $_db,
      $_db.favoriteTracks,
    ).filter((f) => f.trackId.rowId.sqlEquals($_itemColumn<int>('row_id')!));

    final cache = $_typedResult.readTableOrNull(_favoriteTracksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UserPlaylistItemsTable, List<UserPlaylistItem>>
  _userPlaylistItemsRefsTable(_$MediaLibraryDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.userPlaylistItems,
        aliasName: $_aliasNameGenerator(
          db.tracks.rowId,
          db.userPlaylistItems.trackId,
        ),
      );

  $$UserPlaylistItemsTableProcessedTableManager get userPlaylistItemsRefs {
    final manager = $$UserPlaylistItemsTableTableManager(
      $_db,
      $_db.userPlaylistItems,
    ).filter((f) => f.trackId.rowId.sqlEquals($_itemColumn<int>('row_id')!));

    final cache = $_typedResult.readTableOrNull(
      _userPlaylistItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TracksTableFilterComposer
    extends Composer<_$MediaLibraryDatabase, $TracksTable> {
  $$TracksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get publicId => $composableBuilder(
    column: $table.publicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sortTitle => $composableBuilder(
    column: $table.sortTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayArtist => $composableBuilder(
    column: $table.displayArtist,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayAlbum => $composableBuilder(
    column: $table.displayAlbum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bitrateBps => $composableBuilder(
    column: $table.bitrateBps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sampleRateHz => $composableBuilder(
    column: $table.sampleRateHz,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get trackNumber => $composableBuilder(
    column: $table.trackNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get trackTotal => $composableBuilder(
    column: $table.trackTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discNumber => $composableBuilder(
    column: $table.discNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discTotal => $composableBuilder(
    column: $table.discTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get releaseYear => $composableBuilder(
    column: $table.releaseYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataSource => $composableBuilder(
    column: $table.metadataSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get metadataRevision => $composableBuilder(
    column: $table.metadataRevision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MediaFilesTableFilterComposer get mediaFileId {
    final $$MediaFilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaFileId,
      referencedTable: $db.mediaFiles,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaFilesTableFilterComposer(
            $db: $db,
            $table: $db.mediaFiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AlbumsTableFilterComposer get albumId {
    final $$AlbumsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.albumId,
      referencedTable: $db.albums,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlbumsTableFilterComposer(
            $db: $db,
            $table: $db.albums,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArtworkAssetsTableFilterComposer get artworkId {
    final $$ArtworkAssetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.artworkId,
      referencedTable: $db.artworkAssets,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArtworkAssetsTableFilterComposer(
            $db: $db,
            $table: $db.artworkAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> trackArtistsRefs(
    Expression<bool> Function($$TrackArtistsTableFilterComposer f) f,
  ) {
    final $$TrackArtistsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.trackArtists,
      getReferencedColumn: (t) => t.trackId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackArtistsTableFilterComposer(
            $db: $db,
            $table: $db.trackArtists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> trackGenresRefs(
    Expression<bool> Function($$TrackGenresTableFilterComposer f) f,
  ) {
    final $$TrackGenresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.trackGenres,
      getReferencedColumn: (t) => t.trackId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackGenresTableFilterComposer(
            $db: $db,
            $table: $db.trackGenres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> favoriteTracksRefs(
    Expression<bool> Function($$FavoriteTracksTableFilterComposer f) f,
  ) {
    final $$FavoriteTracksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.favoriteTracks,
      getReferencedColumn: (t) => t.trackId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoriteTracksTableFilterComposer(
            $db: $db,
            $table: $db.favoriteTracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> userPlaylistItemsRefs(
    Expression<bool> Function($$UserPlaylistItemsTableFilterComposer f) f,
  ) {
    final $$UserPlaylistItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.userPlaylistItems,
      getReferencedColumn: (t) => t.trackId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPlaylistItemsTableFilterComposer(
            $db: $db,
            $table: $db.userPlaylistItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TracksTableOrderingComposer
    extends Composer<_$MediaLibraryDatabase, $TracksTable> {
  $$TracksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publicId => $composableBuilder(
    column: $table.publicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sortTitle => $composableBuilder(
    column: $table.sortTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayArtist => $composableBuilder(
    column: $table.displayArtist,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayAlbum => $composableBuilder(
    column: $table.displayAlbum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bitrateBps => $composableBuilder(
    column: $table.bitrateBps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sampleRateHz => $composableBuilder(
    column: $table.sampleRateHz,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get trackNumber => $composableBuilder(
    column: $table.trackNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get trackTotal => $composableBuilder(
    column: $table.trackTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discNumber => $composableBuilder(
    column: $table.discNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discTotal => $composableBuilder(
    column: $table.discTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get releaseYear => $composableBuilder(
    column: $table.releaseYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataSource => $composableBuilder(
    column: $table.metadataSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get metadataRevision => $composableBuilder(
    column: $table.metadataRevision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MediaFilesTableOrderingComposer get mediaFileId {
    final $$MediaFilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaFileId,
      referencedTable: $db.mediaFiles,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaFilesTableOrderingComposer(
            $db: $db,
            $table: $db.mediaFiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AlbumsTableOrderingComposer get albumId {
    final $$AlbumsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.albumId,
      referencedTable: $db.albums,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlbumsTableOrderingComposer(
            $db: $db,
            $table: $db.albums,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArtworkAssetsTableOrderingComposer get artworkId {
    final $$ArtworkAssetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.artworkId,
      referencedTable: $db.artworkAssets,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArtworkAssetsTableOrderingComposer(
            $db: $db,
            $table: $db.artworkAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TracksTableAnnotationComposer
    extends Composer<_$MediaLibraryDatabase, $TracksTable> {
  $$TracksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get rowId =>
      $composableBuilder(column: $table.rowId, builder: (column) => column);

  GeneratedColumn<String> get publicId =>
      $composableBuilder(column: $table.publicId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get sortTitle =>
      $composableBuilder(column: $table.sortTitle, builder: (column) => column);

  GeneratedColumn<String> get displayArtist => $composableBuilder(
    column: $table.displayArtist,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayAlbum => $composableBuilder(
    column: $table.displayAlbum,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bitrateBps => $composableBuilder(
    column: $table.bitrateBps,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sampleRateHz => $composableBuilder(
    column: $table.sampleRateHz,
    builder: (column) => column,
  );

  GeneratedColumn<int> get trackNumber => $composableBuilder(
    column: $table.trackNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get trackTotal => $composableBuilder(
    column: $table.trackTotal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get discNumber => $composableBuilder(
    column: $table.discNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get discTotal =>
      $composableBuilder(column: $table.discTotal, builder: (column) => column);

  GeneratedColumn<int> get releaseYear => $composableBuilder(
    column: $table.releaseYear,
    builder: (column) => column,
  );

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get metadataSource => $composableBuilder(
    column: $table.metadataSource,
    builder: (column) => column,
  );

  GeneratedColumn<int> get metadataRevision => $composableBuilder(
    column: $table.metadataRevision,
    builder: (column) => column,
  );

  GeneratedColumn<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$MediaFilesTableAnnotationComposer get mediaFileId {
    final $$MediaFilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaFileId,
      referencedTable: $db.mediaFiles,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaFilesTableAnnotationComposer(
            $db: $db,
            $table: $db.mediaFiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AlbumsTableAnnotationComposer get albumId {
    final $$AlbumsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.albumId,
      referencedTable: $db.albums,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlbumsTableAnnotationComposer(
            $db: $db,
            $table: $db.albums,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArtworkAssetsTableAnnotationComposer get artworkId {
    final $$ArtworkAssetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.artworkId,
      referencedTable: $db.artworkAssets,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArtworkAssetsTableAnnotationComposer(
            $db: $db,
            $table: $db.artworkAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> trackArtistsRefs<T extends Object>(
    Expression<T> Function($$TrackArtistsTableAnnotationComposer a) f,
  ) {
    final $$TrackArtistsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.trackArtists,
      getReferencedColumn: (t) => t.trackId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackArtistsTableAnnotationComposer(
            $db: $db,
            $table: $db.trackArtists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> trackGenresRefs<T extends Object>(
    Expression<T> Function($$TrackGenresTableAnnotationComposer a) f,
  ) {
    final $$TrackGenresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.trackGenres,
      getReferencedColumn: (t) => t.trackId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackGenresTableAnnotationComposer(
            $db: $db,
            $table: $db.trackGenres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> favoriteTracksRefs<T extends Object>(
    Expression<T> Function($$FavoriteTracksTableAnnotationComposer a) f,
  ) {
    final $$FavoriteTracksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.favoriteTracks,
      getReferencedColumn: (t) => t.trackId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoriteTracksTableAnnotationComposer(
            $db: $db,
            $table: $db.favoriteTracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> userPlaylistItemsRefs<T extends Object>(
    Expression<T> Function($$UserPlaylistItemsTableAnnotationComposer a) f,
  ) {
    final $$UserPlaylistItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.rowId,
          referencedTable: $db.userPlaylistItems,
          getReferencedColumn: (t) => t.trackId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UserPlaylistItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.userPlaylistItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TracksTableTableManager
    extends
        RootTableManager<
          _$MediaLibraryDatabase,
          $TracksTable,
          Track,
          $$TracksTableFilterComposer,
          $$TracksTableOrderingComposer,
          $$TracksTableAnnotationComposer,
          $$TracksTableCreateCompanionBuilder,
          $$TracksTableUpdateCompanionBuilder,
          (Track, $$TracksTableReferences),
          Track,
          PrefetchHooks Function({
            bool mediaFileId,
            bool albumId,
            bool artworkId,
            bool trackArtistsRefs,
            bool trackGenresRefs,
            bool favoriteTracksRefs,
            bool userPlaylistItemsRefs,
          })
        > {
  $$TracksTableTableManager(_$MediaLibraryDatabase db, $TracksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TracksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TracksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TracksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> rowId = const Value.absent(),
                Value<String> publicId = const Value.absent(),
                Value<int> mediaFileId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> sortTitle = const Value.absent(),
                Value<String?> displayArtist = const Value.absent(),
                Value<String?> displayAlbum = const Value.absent(),
                Value<int?> albumId = const Value.absent(),
                Value<int?> durationMs = const Value.absent(),
                Value<int?> bitrateBps = const Value.absent(),
                Value<int?> sampleRateHz = const Value.absent(),
                Value<int?> trackNumber = const Value.absent(),
                Value<int?> trackTotal = const Value.absent(),
                Value<int?> discNumber = const Value.absent(),
                Value<int?> discTotal = const Value.absent(),
                Value<int?> releaseYear = const Value.absent(),
                Value<String?> language = const Value.absent(),
                Value<String?> metadataSource = const Value.absent(),
                Value<int> metadataRevision = const Value.absent(),
                Value<String> searchText = const Value.absent(),
                Value<int?> artworkId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TracksCompanion(
                rowId: rowId,
                publicId: publicId,
                mediaFileId: mediaFileId,
                title: title,
                sortTitle: sortTitle,
                displayArtist: displayArtist,
                displayAlbum: displayAlbum,
                albumId: albumId,
                durationMs: durationMs,
                bitrateBps: bitrateBps,
                sampleRateHz: sampleRateHz,
                trackNumber: trackNumber,
                trackTotal: trackTotal,
                discNumber: discNumber,
                discTotal: discTotal,
                releaseYear: releaseYear,
                language: language,
                metadataSource: metadataSource,
                metadataRevision: metadataRevision,
                searchText: searchText,
                artworkId: artworkId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> rowId = const Value.absent(),
                required String publicId,
                required int mediaFileId,
                required String title,
                required String sortTitle,
                Value<String?> displayArtist = const Value.absent(),
                Value<String?> displayAlbum = const Value.absent(),
                Value<int?> albumId = const Value.absent(),
                Value<int?> durationMs = const Value.absent(),
                Value<int?> bitrateBps = const Value.absent(),
                Value<int?> sampleRateHz = const Value.absent(),
                Value<int?> trackNumber = const Value.absent(),
                Value<int?> trackTotal = const Value.absent(),
                Value<int?> discNumber = const Value.absent(),
                Value<int?> discTotal = const Value.absent(),
                Value<int?> releaseYear = const Value.absent(),
                Value<String?> language = const Value.absent(),
                Value<String?> metadataSource = const Value.absent(),
                Value<int> metadataRevision = const Value.absent(),
                required String searchText,
                Value<int?> artworkId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => TracksCompanion.insert(
                rowId: rowId,
                publicId: publicId,
                mediaFileId: mediaFileId,
                title: title,
                sortTitle: sortTitle,
                displayArtist: displayArtist,
                displayAlbum: displayAlbum,
                albumId: albumId,
                durationMs: durationMs,
                bitrateBps: bitrateBps,
                sampleRateHz: sampleRateHz,
                trackNumber: trackNumber,
                trackTotal: trackTotal,
                discNumber: discNumber,
                discTotal: discTotal,
                releaseYear: releaseYear,
                language: language,
                metadataSource: metadataSource,
                metadataRevision: metadataRevision,
                searchText: searchText,
                artworkId: artworkId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TracksTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                mediaFileId = false,
                albumId = false,
                artworkId = false,
                trackArtistsRefs = false,
                trackGenresRefs = false,
                favoriteTracksRefs = false,
                userPlaylistItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (trackArtistsRefs) db.trackArtists,
                    if (trackGenresRefs) db.trackGenres,
                    if (favoriteTracksRefs) db.favoriteTracks,
                    if (userPlaylistItemsRefs) db.userPlaylistItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (mediaFileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.mediaFileId,
                                    referencedTable: $$TracksTableReferences
                                        ._mediaFileIdTable(db),
                                    referencedColumn: $$TracksTableReferences
                                        ._mediaFileIdTable(db)
                                        .rowId,
                                  )
                                  as T;
                        }
                        if (albumId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.albumId,
                                    referencedTable: $$TracksTableReferences
                                        ._albumIdTable(db),
                                    referencedColumn: $$TracksTableReferences
                                        ._albumIdTable(db)
                                        .rowId,
                                  )
                                  as T;
                        }
                        if (artworkId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.artworkId,
                                    referencedTable: $$TracksTableReferences
                                        ._artworkIdTable(db),
                                    referencedColumn: $$TracksTableReferences
                                        ._artworkIdTable(db)
                                        .rowId,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (trackArtistsRefs)
                        await $_getPrefetchedData<
                          Track,
                          $TracksTable,
                          TrackArtist
                        >(
                          currentTable: table,
                          referencedTable: $$TracksTableReferences
                              ._trackArtistsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TracksTableReferences(
                                db,
                                table,
                                p0,
                              ).trackArtistsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.trackId == item.rowId,
                              ),
                          typedResults: items,
                        ),
                      if (trackGenresRefs)
                        await $_getPrefetchedData<
                          Track,
                          $TracksTable,
                          TrackGenre
                        >(
                          currentTable: table,
                          referencedTable: $$TracksTableReferences
                              ._trackGenresRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TracksTableReferences(
                                db,
                                table,
                                p0,
                              ).trackGenresRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.trackId == item.rowId,
                              ),
                          typedResults: items,
                        ),
                      if (favoriteTracksRefs)
                        await $_getPrefetchedData<
                          Track,
                          $TracksTable,
                          FavoriteTrack
                        >(
                          currentTable: table,
                          referencedTable: $$TracksTableReferences
                              ._favoriteTracksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TracksTableReferences(
                                db,
                                table,
                                p0,
                              ).favoriteTracksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.trackId == item.rowId,
                              ),
                          typedResults: items,
                        ),
                      if (userPlaylistItemsRefs)
                        await $_getPrefetchedData<
                          Track,
                          $TracksTable,
                          UserPlaylistItem
                        >(
                          currentTable: table,
                          referencedTable: $$TracksTableReferences
                              ._userPlaylistItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TracksTableReferences(
                                db,
                                table,
                                p0,
                              ).userPlaylistItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.trackId == item.rowId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TracksTableProcessedTableManager =
    ProcessedTableManager<
      _$MediaLibraryDatabase,
      $TracksTable,
      Track,
      $$TracksTableFilterComposer,
      $$TracksTableOrderingComposer,
      $$TracksTableAnnotationComposer,
      $$TracksTableCreateCompanionBuilder,
      $$TracksTableUpdateCompanionBuilder,
      (Track, $$TracksTableReferences),
      Track,
      PrefetchHooks Function({
        bool mediaFileId,
        bool albumId,
        bool artworkId,
        bool trackArtistsRefs,
        bool trackGenresRefs,
        bool favoriteTracksRefs,
        bool userPlaylistItemsRefs,
      })
    >;
typedef $$TrackArtistsTableCreateCompanionBuilder =
    TrackArtistsCompanion Function({
      required int trackId,
      required int artistId,
      required String role,
      required int position,
      Value<int> rowid,
    });
typedef $$TrackArtistsTableUpdateCompanionBuilder =
    TrackArtistsCompanion Function({
      Value<int> trackId,
      Value<int> artistId,
      Value<String> role,
      Value<int> position,
      Value<int> rowid,
    });

final class $$TrackArtistsTableReferences
    extends
        BaseReferences<
          _$MediaLibraryDatabase,
          $TrackArtistsTable,
          TrackArtist
        > {
  $$TrackArtistsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TracksTable _trackIdTable(_$MediaLibraryDatabase db) =>
      db.tracks.createAlias(
        $_aliasNameGenerator(db.trackArtists.trackId, db.tracks.rowId),
      );

  $$TracksTableProcessedTableManager get trackId {
    final $_column = $_itemColumn<int>('track_id')!;

    final manager = $$TracksTableTableManager(
      $_db,
      $_db.tracks,
    ).filter((f) => f.rowId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trackIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ArtistsTable _artistIdTable(_$MediaLibraryDatabase db) =>
      db.artists.createAlias(
        $_aliasNameGenerator(db.trackArtists.artistId, db.artists.rowId),
      );

  $$ArtistsTableProcessedTableManager get artistId {
    final $_column = $_itemColumn<int>('artist_id')!;

    final manager = $$ArtistsTableTableManager(
      $_db,
      $_db.artists,
    ).filter((f) => f.rowId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_artistIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TrackArtistsTableFilterComposer
    extends Composer<_$MediaLibraryDatabase, $TrackArtistsTable> {
  $$TrackArtistsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  $$TracksTableFilterComposer get trackId {
    final $$TracksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.tracks,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TracksTableFilterComposer(
            $db: $db,
            $table: $db.tracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArtistsTableFilterComposer get artistId {
    final $$ArtistsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.artistId,
      referencedTable: $db.artists,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArtistsTableFilterComposer(
            $db: $db,
            $table: $db.artists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrackArtistsTableOrderingComposer
    extends Composer<_$MediaLibraryDatabase, $TrackArtistsTable> {
  $$TrackArtistsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  $$TracksTableOrderingComposer get trackId {
    final $$TracksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.tracks,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TracksTableOrderingComposer(
            $db: $db,
            $table: $db.tracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArtistsTableOrderingComposer get artistId {
    final $$ArtistsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.artistId,
      referencedTable: $db.artists,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArtistsTableOrderingComposer(
            $db: $db,
            $table: $db.artists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrackArtistsTableAnnotationComposer
    extends Composer<_$MediaLibraryDatabase, $TrackArtistsTable> {
  $$TrackArtistsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  $$TracksTableAnnotationComposer get trackId {
    final $$TracksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.tracks,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TracksTableAnnotationComposer(
            $db: $db,
            $table: $db.tracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ArtistsTableAnnotationComposer get artistId {
    final $$ArtistsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.artistId,
      referencedTable: $db.artists,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArtistsTableAnnotationComposer(
            $db: $db,
            $table: $db.artists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrackArtistsTableTableManager
    extends
        RootTableManager<
          _$MediaLibraryDatabase,
          $TrackArtistsTable,
          TrackArtist,
          $$TrackArtistsTableFilterComposer,
          $$TrackArtistsTableOrderingComposer,
          $$TrackArtistsTableAnnotationComposer,
          $$TrackArtistsTableCreateCompanionBuilder,
          $$TrackArtistsTableUpdateCompanionBuilder,
          (TrackArtist, $$TrackArtistsTableReferences),
          TrackArtist,
          PrefetchHooks Function({bool trackId, bool artistId})
        > {
  $$TrackArtistsTableTableManager(
    _$MediaLibraryDatabase db,
    $TrackArtistsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrackArtistsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrackArtistsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrackArtistsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> trackId = const Value.absent(),
                Value<int> artistId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrackArtistsCompanion(
                trackId: trackId,
                artistId: artistId,
                role: role,
                position: position,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int trackId,
                required int artistId,
                required String role,
                required int position,
                Value<int> rowid = const Value.absent(),
              }) => TrackArtistsCompanion.insert(
                trackId: trackId,
                artistId: artistId,
                role: role,
                position: position,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TrackArtistsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({trackId = false, artistId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (trackId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.trackId,
                                referencedTable: $$TrackArtistsTableReferences
                                    ._trackIdTable(db),
                                referencedColumn: $$TrackArtistsTableReferences
                                    ._trackIdTable(db)
                                    .rowId,
                              )
                              as T;
                    }
                    if (artistId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.artistId,
                                referencedTable: $$TrackArtistsTableReferences
                                    ._artistIdTable(db),
                                referencedColumn: $$TrackArtistsTableReferences
                                    ._artistIdTable(db)
                                    .rowId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TrackArtistsTableProcessedTableManager =
    ProcessedTableManager<
      _$MediaLibraryDatabase,
      $TrackArtistsTable,
      TrackArtist,
      $$TrackArtistsTableFilterComposer,
      $$TrackArtistsTableOrderingComposer,
      $$TrackArtistsTableAnnotationComposer,
      $$TrackArtistsTableCreateCompanionBuilder,
      $$TrackArtistsTableUpdateCompanionBuilder,
      (TrackArtist, $$TrackArtistsTableReferences),
      TrackArtist,
      PrefetchHooks Function({bool trackId, bool artistId})
    >;
typedef $$GenresTableCreateCompanionBuilder =
    GenresCompanion Function({
      Value<int> rowId,
      required String publicId,
      required String name,
      required String identityKey,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$GenresTableUpdateCompanionBuilder =
    GenresCompanion Function({
      Value<int> rowId,
      Value<String> publicId,
      Value<String> name,
      Value<String> identityKey,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$GenresTableReferences
    extends BaseReferences<_$MediaLibraryDatabase, $GenresTable, Genre> {
  $$GenresTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TrackGenresTable, List<TrackGenre>>
  _trackGenresRefsTable(_$MediaLibraryDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.trackGenres,
        aliasName: $_aliasNameGenerator(
          db.genres.rowId,
          db.trackGenres.genreId,
        ),
      );

  $$TrackGenresTableProcessedTableManager get trackGenresRefs {
    final manager = $$TrackGenresTableTableManager(
      $_db,
      $_db.trackGenres,
    ).filter((f) => f.genreId.rowId.sqlEquals($_itemColumn<int>('row_id')!));

    final cache = $_typedResult.readTableOrNull(_trackGenresRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GenresTableFilterComposer
    extends Composer<_$MediaLibraryDatabase, $GenresTable> {
  $$GenresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get publicId => $composableBuilder(
    column: $table.publicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get identityKey => $composableBuilder(
    column: $table.identityKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> trackGenresRefs(
    Expression<bool> Function($$TrackGenresTableFilterComposer f) f,
  ) {
    final $$TrackGenresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.trackGenres,
      getReferencedColumn: (t) => t.genreId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackGenresTableFilterComposer(
            $db: $db,
            $table: $db.trackGenres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GenresTableOrderingComposer
    extends Composer<_$MediaLibraryDatabase, $GenresTable> {
  $$GenresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publicId => $composableBuilder(
    column: $table.publicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get identityKey => $composableBuilder(
    column: $table.identityKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GenresTableAnnotationComposer
    extends Composer<_$MediaLibraryDatabase, $GenresTable> {
  $$GenresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get rowId =>
      $composableBuilder(column: $table.rowId, builder: (column) => column);

  GeneratedColumn<String> get publicId =>
      $composableBuilder(column: $table.publicId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get identityKey => $composableBuilder(
    column: $table.identityKey,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> trackGenresRefs<T extends Object>(
    Expression<T> Function($$TrackGenresTableAnnotationComposer a) f,
  ) {
    final $$TrackGenresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.trackGenres,
      getReferencedColumn: (t) => t.genreId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackGenresTableAnnotationComposer(
            $db: $db,
            $table: $db.trackGenres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GenresTableTableManager
    extends
        RootTableManager<
          _$MediaLibraryDatabase,
          $GenresTable,
          Genre,
          $$GenresTableFilterComposer,
          $$GenresTableOrderingComposer,
          $$GenresTableAnnotationComposer,
          $$GenresTableCreateCompanionBuilder,
          $$GenresTableUpdateCompanionBuilder,
          (Genre, $$GenresTableReferences),
          Genre,
          PrefetchHooks Function({bool trackGenresRefs})
        > {
  $$GenresTableTableManager(_$MediaLibraryDatabase db, $GenresTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GenresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GenresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GenresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> rowId = const Value.absent(),
                Value<String> publicId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> identityKey = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => GenresCompanion(
                rowId: rowId,
                publicId: publicId,
                name: name,
                identityKey: identityKey,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> rowId = const Value.absent(),
                required String publicId,
                required String name,
                required String identityKey,
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => GenresCompanion.insert(
                rowId: rowId,
                publicId: publicId,
                name: name,
                identityKey: identityKey,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$GenresTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({trackGenresRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (trackGenresRefs) db.trackGenres],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (trackGenresRefs)
                    await $_getPrefetchedData<Genre, $GenresTable, TrackGenre>(
                      currentTable: table,
                      referencedTable: $$GenresTableReferences
                          ._trackGenresRefsTable(db),
                      managerFromTypedResult: (p0) => $$GenresTableReferences(
                        db,
                        table,
                        p0,
                      ).trackGenresRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.genreId == item.rowId),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$GenresTableProcessedTableManager =
    ProcessedTableManager<
      _$MediaLibraryDatabase,
      $GenresTable,
      Genre,
      $$GenresTableFilterComposer,
      $$GenresTableOrderingComposer,
      $$GenresTableAnnotationComposer,
      $$GenresTableCreateCompanionBuilder,
      $$GenresTableUpdateCompanionBuilder,
      (Genre, $$GenresTableReferences),
      Genre,
      PrefetchHooks Function({bool trackGenresRefs})
    >;
typedef $$TrackGenresTableCreateCompanionBuilder =
    TrackGenresCompanion Function({
      required int trackId,
      required int genreId,
      required int position,
      Value<int> rowid,
    });
typedef $$TrackGenresTableUpdateCompanionBuilder =
    TrackGenresCompanion Function({
      Value<int> trackId,
      Value<int> genreId,
      Value<int> position,
      Value<int> rowid,
    });

final class $$TrackGenresTableReferences
    extends
        BaseReferences<_$MediaLibraryDatabase, $TrackGenresTable, TrackGenre> {
  $$TrackGenresTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TracksTable _trackIdTable(_$MediaLibraryDatabase db) =>
      db.tracks.createAlias(
        $_aliasNameGenerator(db.trackGenres.trackId, db.tracks.rowId),
      );

  $$TracksTableProcessedTableManager get trackId {
    final $_column = $_itemColumn<int>('track_id')!;

    final manager = $$TracksTableTableManager(
      $_db,
      $_db.tracks,
    ).filter((f) => f.rowId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trackIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GenresTable _genreIdTable(_$MediaLibraryDatabase db) =>
      db.genres.createAlias(
        $_aliasNameGenerator(db.trackGenres.genreId, db.genres.rowId),
      );

  $$GenresTableProcessedTableManager get genreId {
    final $_column = $_itemColumn<int>('genre_id')!;

    final manager = $$GenresTableTableManager(
      $_db,
      $_db.genres,
    ).filter((f) => f.rowId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_genreIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TrackGenresTableFilterComposer
    extends Composer<_$MediaLibraryDatabase, $TrackGenresTable> {
  $$TrackGenresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  $$TracksTableFilterComposer get trackId {
    final $$TracksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.tracks,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TracksTableFilterComposer(
            $db: $db,
            $table: $db.tracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GenresTableFilterComposer get genreId {
    final $$GenresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.genreId,
      referencedTable: $db.genres,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GenresTableFilterComposer(
            $db: $db,
            $table: $db.genres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrackGenresTableOrderingComposer
    extends Composer<_$MediaLibraryDatabase, $TrackGenresTable> {
  $$TrackGenresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  $$TracksTableOrderingComposer get trackId {
    final $$TracksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.tracks,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TracksTableOrderingComposer(
            $db: $db,
            $table: $db.tracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GenresTableOrderingComposer get genreId {
    final $$GenresTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.genreId,
      referencedTable: $db.genres,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GenresTableOrderingComposer(
            $db: $db,
            $table: $db.genres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrackGenresTableAnnotationComposer
    extends Composer<_$MediaLibraryDatabase, $TrackGenresTable> {
  $$TrackGenresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  $$TracksTableAnnotationComposer get trackId {
    final $$TracksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.tracks,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TracksTableAnnotationComposer(
            $db: $db,
            $table: $db.tracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GenresTableAnnotationComposer get genreId {
    final $$GenresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.genreId,
      referencedTable: $db.genres,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GenresTableAnnotationComposer(
            $db: $db,
            $table: $db.genres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrackGenresTableTableManager
    extends
        RootTableManager<
          _$MediaLibraryDatabase,
          $TrackGenresTable,
          TrackGenre,
          $$TrackGenresTableFilterComposer,
          $$TrackGenresTableOrderingComposer,
          $$TrackGenresTableAnnotationComposer,
          $$TrackGenresTableCreateCompanionBuilder,
          $$TrackGenresTableUpdateCompanionBuilder,
          (TrackGenre, $$TrackGenresTableReferences),
          TrackGenre,
          PrefetchHooks Function({bool trackId, bool genreId})
        > {
  $$TrackGenresTableTableManager(
    _$MediaLibraryDatabase db,
    $TrackGenresTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrackGenresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrackGenresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrackGenresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> trackId = const Value.absent(),
                Value<int> genreId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrackGenresCompanion(
                trackId: trackId,
                genreId: genreId,
                position: position,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int trackId,
                required int genreId,
                required int position,
                Value<int> rowid = const Value.absent(),
              }) => TrackGenresCompanion.insert(
                trackId: trackId,
                genreId: genreId,
                position: position,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TrackGenresTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({trackId = false, genreId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (trackId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.trackId,
                                referencedTable: $$TrackGenresTableReferences
                                    ._trackIdTable(db),
                                referencedColumn: $$TrackGenresTableReferences
                                    ._trackIdTable(db)
                                    .rowId,
                              )
                              as T;
                    }
                    if (genreId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.genreId,
                                referencedTable: $$TrackGenresTableReferences
                                    ._genreIdTable(db),
                                referencedColumn: $$TrackGenresTableReferences
                                    ._genreIdTable(db)
                                    .rowId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TrackGenresTableProcessedTableManager =
    ProcessedTableManager<
      _$MediaLibraryDatabase,
      $TrackGenresTable,
      TrackGenre,
      $$TrackGenresTableFilterComposer,
      $$TrackGenresTableOrderingComposer,
      $$TrackGenresTableAnnotationComposer,
      $$TrackGenresTableCreateCompanionBuilder,
      $$TrackGenresTableUpdateCompanionBuilder,
      (TrackGenre, $$TrackGenresTableReferences),
      TrackGenre,
      PrefetchHooks Function({bool trackId, bool genreId})
    >;
typedef $$FavoriteTracksTableCreateCompanionBuilder =
    FavoriteTracksCompanion Function({
      Value<int> trackId,
      required DateTime createdAt,
    });
typedef $$FavoriteTracksTableUpdateCompanionBuilder =
    FavoriteTracksCompanion Function({
      Value<int> trackId,
      Value<DateTime> createdAt,
    });

final class $$FavoriteTracksTableReferences
    extends
        BaseReferences<
          _$MediaLibraryDatabase,
          $FavoriteTracksTable,
          FavoriteTrack
        > {
  $$FavoriteTracksTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TracksTable _trackIdTable(_$MediaLibraryDatabase db) =>
      db.tracks.createAlias(
        $_aliasNameGenerator(db.favoriteTracks.trackId, db.tracks.rowId),
      );

  $$TracksTableProcessedTableManager get trackId {
    final $_column = $_itemColumn<int>('track_id')!;

    final manager = $$TracksTableTableManager(
      $_db,
      $_db.tracks,
    ).filter((f) => f.rowId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trackIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FavoriteTracksTableFilterComposer
    extends Composer<_$MediaLibraryDatabase, $FavoriteTracksTable> {
  $$FavoriteTracksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TracksTableFilterComposer get trackId {
    final $$TracksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.tracks,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TracksTableFilterComposer(
            $db: $db,
            $table: $db.tracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FavoriteTracksTableOrderingComposer
    extends Composer<_$MediaLibraryDatabase, $FavoriteTracksTable> {
  $$FavoriteTracksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TracksTableOrderingComposer get trackId {
    final $$TracksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.tracks,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TracksTableOrderingComposer(
            $db: $db,
            $table: $db.tracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FavoriteTracksTableAnnotationComposer
    extends Composer<_$MediaLibraryDatabase, $FavoriteTracksTable> {
  $$FavoriteTracksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$TracksTableAnnotationComposer get trackId {
    final $$TracksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.tracks,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TracksTableAnnotationComposer(
            $db: $db,
            $table: $db.tracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FavoriteTracksTableTableManager
    extends
        RootTableManager<
          _$MediaLibraryDatabase,
          $FavoriteTracksTable,
          FavoriteTrack,
          $$FavoriteTracksTableFilterComposer,
          $$FavoriteTracksTableOrderingComposer,
          $$FavoriteTracksTableAnnotationComposer,
          $$FavoriteTracksTableCreateCompanionBuilder,
          $$FavoriteTracksTableUpdateCompanionBuilder,
          (FavoriteTrack, $$FavoriteTracksTableReferences),
          FavoriteTrack,
          PrefetchHooks Function({bool trackId})
        > {
  $$FavoriteTracksTableTableManager(
    _$MediaLibraryDatabase db,
    $FavoriteTracksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteTracksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteTracksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoriteTracksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> trackId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FavoriteTracksCompanion(
                trackId: trackId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> trackId = const Value.absent(),
                required DateTime createdAt,
              }) => FavoriteTracksCompanion.insert(
                trackId: trackId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FavoriteTracksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({trackId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (trackId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.trackId,
                                referencedTable: $$FavoriteTracksTableReferences
                                    ._trackIdTable(db),
                                referencedColumn:
                                    $$FavoriteTracksTableReferences
                                        ._trackIdTable(db)
                                        .rowId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FavoriteTracksTableProcessedTableManager =
    ProcessedTableManager<
      _$MediaLibraryDatabase,
      $FavoriteTracksTable,
      FavoriteTrack,
      $$FavoriteTracksTableFilterComposer,
      $$FavoriteTracksTableOrderingComposer,
      $$FavoriteTracksTableAnnotationComposer,
      $$FavoriteTracksTableCreateCompanionBuilder,
      $$FavoriteTracksTableUpdateCompanionBuilder,
      (FavoriteTrack, $$FavoriteTracksTableReferences),
      FavoriteTrack,
      PrefetchHooks Function({bool trackId})
    >;
typedef $$UserPlaylistsTableCreateCompanionBuilder =
    UserPlaylistsCompanion Function({
      Value<int> rowId,
      required String publicId,
      required String name,
      required String normalizedName,
      Value<String?> description,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$UserPlaylistsTableUpdateCompanionBuilder =
    UserPlaylistsCompanion Function({
      Value<int> rowId,
      Value<String> publicId,
      Value<String> name,
      Value<String> normalizedName,
      Value<String?> description,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$UserPlaylistsTableReferences
    extends
        BaseReferences<
          _$MediaLibraryDatabase,
          $UserPlaylistsTable,
          UserPlaylist
        > {
  $$UserPlaylistsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$UserPlaylistItemsTable, List<UserPlaylistItem>>
  _userPlaylistItemsRefsTable(_$MediaLibraryDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.userPlaylistItems,
        aliasName: $_aliasNameGenerator(
          db.userPlaylists.rowId,
          db.userPlaylistItems.playlistId,
        ),
      );

  $$UserPlaylistItemsTableProcessedTableManager get userPlaylistItemsRefs {
    final manager = $$UserPlaylistItemsTableTableManager(
      $_db,
      $_db.userPlaylistItems,
    ).filter((f) => f.playlistId.rowId.sqlEquals($_itemColumn<int>('row_id')!));

    final cache = $_typedResult.readTableOrNull(
      _userPlaylistItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UserPlaylistsTableFilterComposer
    extends Composer<_$MediaLibraryDatabase, $UserPlaylistsTable> {
  $$UserPlaylistsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get publicId => $composableBuilder(
    column: $table.publicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userPlaylistItemsRefs(
    Expression<bool> Function($$UserPlaylistItemsTableFilterComposer f) f,
  ) {
    final $$UserPlaylistItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rowId,
      referencedTable: $db.userPlaylistItems,
      getReferencedColumn: (t) => t.playlistId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPlaylistItemsTableFilterComposer(
            $db: $db,
            $table: $db.userPlaylistItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserPlaylistsTableOrderingComposer
    extends Composer<_$MediaLibraryDatabase, $UserPlaylistsTable> {
  $$UserPlaylistsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publicId => $composableBuilder(
    column: $table.publicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserPlaylistsTableAnnotationComposer
    extends Composer<_$MediaLibraryDatabase, $UserPlaylistsTable> {
  $$UserPlaylistsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get rowId =>
      $composableBuilder(column: $table.rowId, builder: (column) => column);

  GeneratedColumn<String> get publicId =>
      $composableBuilder(column: $table.publicId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> userPlaylistItemsRefs<T extends Object>(
    Expression<T> Function($$UserPlaylistItemsTableAnnotationComposer a) f,
  ) {
    final $$UserPlaylistItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.rowId,
          referencedTable: $db.userPlaylistItems,
          getReferencedColumn: (t) => t.playlistId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UserPlaylistItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.userPlaylistItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$UserPlaylistsTableTableManager
    extends
        RootTableManager<
          _$MediaLibraryDatabase,
          $UserPlaylistsTable,
          UserPlaylist,
          $$UserPlaylistsTableFilterComposer,
          $$UserPlaylistsTableOrderingComposer,
          $$UserPlaylistsTableAnnotationComposer,
          $$UserPlaylistsTableCreateCompanionBuilder,
          $$UserPlaylistsTableUpdateCompanionBuilder,
          (UserPlaylist, $$UserPlaylistsTableReferences),
          UserPlaylist,
          PrefetchHooks Function({bool userPlaylistItemsRefs})
        > {
  $$UserPlaylistsTableTableManager(
    _$MediaLibraryDatabase db,
    $UserPlaylistsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPlaylistsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserPlaylistsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserPlaylistsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> rowId = const Value.absent(),
                Value<String> publicId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> normalizedName = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserPlaylistsCompanion(
                rowId: rowId,
                publicId: publicId,
                name: name,
                normalizedName: normalizedName,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> rowId = const Value.absent(),
                required String publicId,
                required String name,
                required String normalizedName,
                Value<String?> description = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => UserPlaylistsCompanion.insert(
                rowId: rowId,
                publicId: publicId,
                name: name,
                normalizedName: normalizedName,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserPlaylistsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userPlaylistItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (userPlaylistItemsRefs) db.userPlaylistItems,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userPlaylistItemsRefs)
                    await $_getPrefetchedData<
                      UserPlaylist,
                      $UserPlaylistsTable,
                      UserPlaylistItem
                    >(
                      currentTable: table,
                      referencedTable: $$UserPlaylistsTableReferences
                          ._userPlaylistItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$UserPlaylistsTableReferences(
                            db,
                            table,
                            p0,
                          ).userPlaylistItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.playlistId == item.rowId,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UserPlaylistsTableProcessedTableManager =
    ProcessedTableManager<
      _$MediaLibraryDatabase,
      $UserPlaylistsTable,
      UserPlaylist,
      $$UserPlaylistsTableFilterComposer,
      $$UserPlaylistsTableOrderingComposer,
      $$UserPlaylistsTableAnnotationComposer,
      $$UserPlaylistsTableCreateCompanionBuilder,
      $$UserPlaylistsTableUpdateCompanionBuilder,
      (UserPlaylist, $$UserPlaylistsTableReferences),
      UserPlaylist,
      PrefetchHooks Function({bool userPlaylistItemsRefs})
    >;
typedef $$UserPlaylistItemsTableCreateCompanionBuilder =
    UserPlaylistItemsCompanion Function({
      Value<int> rowId,
      required int playlistId,
      required int trackId,
      required int position,
      required DateTime addedAt,
    });
typedef $$UserPlaylistItemsTableUpdateCompanionBuilder =
    UserPlaylistItemsCompanion Function({
      Value<int> rowId,
      Value<int> playlistId,
      Value<int> trackId,
      Value<int> position,
      Value<DateTime> addedAt,
    });

final class $$UserPlaylistItemsTableReferences
    extends
        BaseReferences<
          _$MediaLibraryDatabase,
          $UserPlaylistItemsTable,
          UserPlaylistItem
        > {
  $$UserPlaylistItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UserPlaylistsTable _playlistIdTable(_$MediaLibraryDatabase db) =>
      db.userPlaylists.createAlias(
        $_aliasNameGenerator(
          db.userPlaylistItems.playlistId,
          db.userPlaylists.rowId,
        ),
      );

  $$UserPlaylistsTableProcessedTableManager get playlistId {
    final $_column = $_itemColumn<int>('playlist_id')!;

    final manager = $$UserPlaylistsTableTableManager(
      $_db,
      $_db.userPlaylists,
    ).filter((f) => f.rowId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playlistIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TracksTable _trackIdTable(_$MediaLibraryDatabase db) =>
      db.tracks.createAlias(
        $_aliasNameGenerator(db.userPlaylistItems.trackId, db.tracks.rowId),
      );

  $$TracksTableProcessedTableManager get trackId {
    final $_column = $_itemColumn<int>('track_id')!;

    final manager = $$TracksTableTableManager(
      $_db,
      $_db.tracks,
    ).filter((f) => f.rowId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trackIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserPlaylistItemsTableFilterComposer
    extends Composer<_$MediaLibraryDatabase, $UserPlaylistItemsTable> {
  $$UserPlaylistItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UserPlaylistsTableFilterComposer get playlistId {
    final $$UserPlaylistsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playlistId,
      referencedTable: $db.userPlaylists,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPlaylistsTableFilterComposer(
            $db: $db,
            $table: $db.userPlaylists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TracksTableFilterComposer get trackId {
    final $$TracksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.tracks,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TracksTableFilterComposer(
            $db: $db,
            $table: $db.tracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPlaylistItemsTableOrderingComposer
    extends Composer<_$MediaLibraryDatabase, $UserPlaylistItemsTable> {
  $$UserPlaylistItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get rowId => $composableBuilder(
    column: $table.rowId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserPlaylistsTableOrderingComposer get playlistId {
    final $$UserPlaylistsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playlistId,
      referencedTable: $db.userPlaylists,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPlaylistsTableOrderingComposer(
            $db: $db,
            $table: $db.userPlaylists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TracksTableOrderingComposer get trackId {
    final $$TracksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.tracks,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TracksTableOrderingComposer(
            $db: $db,
            $table: $db.tracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPlaylistItemsTableAnnotationComposer
    extends Composer<_$MediaLibraryDatabase, $UserPlaylistItemsTable> {
  $$UserPlaylistItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get rowId =>
      $composableBuilder(column: $table.rowId, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<DateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);

  $$UserPlaylistsTableAnnotationComposer get playlistId {
    final $$UserPlaylistsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playlistId,
      referencedTable: $db.userPlaylists,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPlaylistsTableAnnotationComposer(
            $db: $db,
            $table: $db.userPlaylists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TracksTableAnnotationComposer get trackId {
    final $$TracksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.tracks,
      getReferencedColumn: (t) => t.rowId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TracksTableAnnotationComposer(
            $db: $db,
            $table: $db.tracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPlaylistItemsTableTableManager
    extends
        RootTableManager<
          _$MediaLibraryDatabase,
          $UserPlaylistItemsTable,
          UserPlaylistItem,
          $$UserPlaylistItemsTableFilterComposer,
          $$UserPlaylistItemsTableOrderingComposer,
          $$UserPlaylistItemsTableAnnotationComposer,
          $$UserPlaylistItemsTableCreateCompanionBuilder,
          $$UserPlaylistItemsTableUpdateCompanionBuilder,
          (UserPlaylistItem, $$UserPlaylistItemsTableReferences),
          UserPlaylistItem,
          PrefetchHooks Function({bool playlistId, bool trackId})
        > {
  $$UserPlaylistItemsTableTableManager(
    _$MediaLibraryDatabase db,
    $UserPlaylistItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPlaylistItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserPlaylistItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserPlaylistItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> rowId = const Value.absent(),
                Value<int> playlistId = const Value.absent(),
                Value<int> trackId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<DateTime> addedAt = const Value.absent(),
              }) => UserPlaylistItemsCompanion(
                rowId: rowId,
                playlistId: playlistId,
                trackId: trackId,
                position: position,
                addedAt: addedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> rowId = const Value.absent(),
                required int playlistId,
                required int trackId,
                required int position,
                required DateTime addedAt,
              }) => UserPlaylistItemsCompanion.insert(
                rowId: rowId,
                playlistId: playlistId,
                trackId: trackId,
                position: position,
                addedAt: addedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserPlaylistItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({playlistId = false, trackId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (playlistId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.playlistId,
                                referencedTable:
                                    $$UserPlaylistItemsTableReferences
                                        ._playlistIdTable(db),
                                referencedColumn:
                                    $$UserPlaylistItemsTableReferences
                                        ._playlistIdTable(db)
                                        .rowId,
                              )
                              as T;
                    }
                    if (trackId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.trackId,
                                referencedTable:
                                    $$UserPlaylistItemsTableReferences
                                        ._trackIdTable(db),
                                referencedColumn:
                                    $$UserPlaylistItemsTableReferences
                                        ._trackIdTable(db)
                                        .rowId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserPlaylistItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$MediaLibraryDatabase,
      $UserPlaylistItemsTable,
      UserPlaylistItem,
      $$UserPlaylistItemsTableFilterComposer,
      $$UserPlaylistItemsTableOrderingComposer,
      $$UserPlaylistItemsTableAnnotationComposer,
      $$UserPlaylistItemsTableCreateCompanionBuilder,
      $$UserPlaylistItemsTableUpdateCompanionBuilder,
      (UserPlaylistItem, $$UserPlaylistItemsTableReferences),
      UserPlaylistItem,
      PrefetchHooks Function({bool playlistId, bool trackId})
    >;

class $MediaLibraryDatabaseManager {
  final _$MediaLibraryDatabase _db;
  $MediaLibraryDatabaseManager(this._db);
  $TrackSearchFtsTableManager get trackSearchFts =>
      $TrackSearchFtsTableManager(_db, _db.trackSearchFts);
  $$LibraryRootsTableTableManager get libraryRoots =>
      $$LibraryRootsTableTableManager(_db, _db.libraryRoots);
  $$ScanRunsTableTableManager get scanRuns =>
      $$ScanRunsTableTableManager(_db, _db.scanRuns);
  $$MediaFilesTableTableManager get mediaFiles =>
      $$MediaFilesTableTableManager(_db, _db.mediaFiles);
  $$ArtworkAssetsTableTableManager get artworkAssets =>
      $$ArtworkAssetsTableTableManager(_db, _db.artworkAssets);
  $$ArtistsTableTableManager get artists =>
      $$ArtistsTableTableManager(_db, _db.artists);
  $$AlbumsTableTableManager get albums =>
      $$AlbumsTableTableManager(_db, _db.albums);
  $$TracksTableTableManager get tracks =>
      $$TracksTableTableManager(_db, _db.tracks);
  $$TrackArtistsTableTableManager get trackArtists =>
      $$TrackArtistsTableTableManager(_db, _db.trackArtists);
  $$GenresTableTableManager get genres =>
      $$GenresTableTableManager(_db, _db.genres);
  $$TrackGenresTableTableManager get trackGenres =>
      $$TrackGenresTableTableManager(_db, _db.trackGenres);
  $$FavoriteTracksTableTableManager get favoriteTracks =>
      $$FavoriteTracksTableTableManager(_db, _db.favoriteTracks);
  $$UserPlaylistsTableTableManager get userPlaylists =>
      $$UserPlaylistsTableTableManager(_db, _db.userPlaylists);
  $$UserPlaylistItemsTableTableManager get userPlaylistItems =>
      $$UserPlaylistItemsTableTableManager(_db, _db.userPlaylistItems);
}

class SearchTracksFtsResult {
  final int trackRowId;
  final String? trackPublicId;
  final double rank;
  SearchTracksFtsResult({
    required this.trackRowId,
    this.trackPublicId,
    required this.rank,
  });
}
