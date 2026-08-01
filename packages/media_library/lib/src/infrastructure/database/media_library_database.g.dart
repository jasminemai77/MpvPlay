// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_library_database.dart';

// ignore_for_file: type=lint
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

abstract class _$MediaLibraryDatabase extends GeneratedDatabase {
  _$MediaLibraryDatabase(QueryExecutor e) : super(e);
  $MediaLibraryDatabaseManager get managers =>
      $MediaLibraryDatabaseManager(this);
  late final $LibraryRootsTable libraryRoots = $LibraryRootsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [libraryRoots];
}

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
          (
            LibraryRoot,
            BaseReferences<
              _$MediaLibraryDatabase,
              $LibraryRootsTable,
              LibraryRoot
            >,
          ),
          LibraryRoot,
          PrefetchHooks Function()
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
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
      (
        LibraryRoot,
        BaseReferences<_$MediaLibraryDatabase, $LibraryRootsTable, LibraryRoot>,
      ),
      LibraryRoot,
      PrefetchHooks Function()
    >;

class $MediaLibraryDatabaseManager {
  final _$MediaLibraryDatabase _db;
  $MediaLibraryDatabaseManager(this._db);
  $$LibraryRootsTableTableManager get libraryRoots =>
      $$LibraryRootsTableTableManager(_db, _db.libraryRoots);
}
