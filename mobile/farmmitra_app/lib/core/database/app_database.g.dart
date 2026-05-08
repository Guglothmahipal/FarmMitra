// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SyncQueueItemsTable extends SyncQueueItems
    with TableInfo<$SyncQueueItemsTable, SyncQueueItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endpointMeta = const VerificationMeta(
    'endpoint',
  );
  @override
  late final GeneratedColumn<String> endpoint = GeneratedColumn<String>(
    'endpoint',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptCountMeta = const VerificationMeta(
    'attemptCount',
  );
  @override
  late final GeneratedColumn<int> attemptCount = GeneratedColumn<int>(
    'attempt_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
  static const VerificationMeta _lastAttemptAtMeta = const VerificationMeta(
    'lastAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>(
        'last_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    method,
    endpoint,
    payload,
    attemptCount,
    createdAt,
    lastAttemptAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('endpoint')) {
      context.handle(
        _endpointMeta,
        endpoint.isAcceptableOrUnknown(data['endpoint']!, _endpointMeta),
      );
    } else if (isInserting) {
      context.missing(_endpointMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('attempt_count')) {
      context.handle(
        _attemptCountMeta,
        attemptCount.isAcceptableOrUnknown(
          data['attempt_count']!,
          _attemptCountMeta,
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
    if (data.containsKey('last_attempt_at')) {
      context.handle(
        _lastAttemptAtMeta,
        lastAttemptAt.isAcceptableOrUnknown(
          data['last_attempt_at']!,
          _lastAttemptAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      endpoint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}endpoint'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      attemptCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempt_count'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_attempt_at'],
      ),
    );
  }

  @override
  $SyncQueueItemsTable createAlias(String alias) {
    return $SyncQueueItemsTable(attachedDatabase, alias);
  }
}

class SyncQueueItem extends DataClass implements Insertable<SyncQueueItem> {
  final String id;
  final String method;
  final String endpoint;
  final String payload;
  final int attemptCount;
  final DateTime createdAt;
  final DateTime? lastAttemptAt;
  const SyncQueueItem({
    required this.id,
    required this.method,
    required this.endpoint,
    required this.payload,
    required this.attemptCount,
    required this.createdAt,
    this.lastAttemptAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['method'] = Variable<String>(method);
    map['endpoint'] = Variable<String>(endpoint);
    map['payload'] = Variable<String>(payload);
    map['attempt_count'] = Variable<int>(attemptCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    return map;
  }

  SyncQueueItemsCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueItemsCompanion(
      id: Value(id),
      method: Value(method),
      endpoint: Value(endpoint),
      payload: Value(payload),
      attemptCount: Value(attemptCount),
      createdAt: Value(createdAt),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
    );
  }

  factory SyncQueueItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueItem(
      id: serializer.fromJson<String>(json['id']),
      method: serializer.fromJson<String>(json['method']),
      endpoint: serializer.fromJson<String>(json['endpoint']),
      payload: serializer.fromJson<String>(json['payload']),
      attemptCount: serializer.fromJson<int>(json['attemptCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'method': serializer.toJson<String>(method),
      'endpoint': serializer.toJson<String>(endpoint),
      'payload': serializer.toJson<String>(payload),
      'attemptCount': serializer.toJson<int>(attemptCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
    };
  }

  SyncQueueItem copyWith({
    String? id,
    String? method,
    String? endpoint,
    String? payload,
    int? attemptCount,
    DateTime? createdAt,
    Value<DateTime?> lastAttemptAt = const Value.absent(),
  }) => SyncQueueItem(
    id: id ?? this.id,
    method: method ?? this.method,
    endpoint: endpoint ?? this.endpoint,
    payload: payload ?? this.payload,
    attemptCount: attemptCount ?? this.attemptCount,
    createdAt: createdAt ?? this.createdAt,
    lastAttemptAt: lastAttemptAt.present
        ? lastAttemptAt.value
        : this.lastAttemptAt,
  );
  SyncQueueItem copyWithCompanion(SyncQueueItemsCompanion data) {
    return SyncQueueItem(
      id: data.id.present ? data.id.value : this.id,
      method: data.method.present ? data.method.value : this.method,
      endpoint: data.endpoint.present ? data.endpoint.value : this.endpoint,
      payload: data.payload.present ? data.payload.value : this.payload,
      attemptCount: data.attemptCount.present
          ? data.attemptCount.value
          : this.attemptCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueItem(')
          ..write('id: $id, ')
          ..write('method: $method, ')
          ..write('endpoint: $endpoint, ')
          ..write('payload: $payload, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttemptAt: $lastAttemptAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    method,
    endpoint,
    payload,
    attemptCount,
    createdAt,
    lastAttemptAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueItem &&
          other.id == this.id &&
          other.method == this.method &&
          other.endpoint == this.endpoint &&
          other.payload == this.payload &&
          other.attemptCount == this.attemptCount &&
          other.createdAt == this.createdAt &&
          other.lastAttemptAt == this.lastAttemptAt);
}

class SyncQueueItemsCompanion extends UpdateCompanion<SyncQueueItem> {
  final Value<String> id;
  final Value<String> method;
  final Value<String> endpoint;
  final Value<String> payload;
  final Value<int> attemptCount;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastAttemptAt;
  final Value<int> rowid;
  const SyncQueueItemsCompanion({
    this.id = const Value.absent(),
    this.method = const Value.absent(),
    this.endpoint = const Value.absent(),
    this.payload = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncQueueItemsCompanion.insert({
    required String id,
    required String method,
    required String endpoint,
    required String payload,
    this.attemptCount = const Value.absent(),
    required DateTime createdAt,
    this.lastAttemptAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       method = Value(method),
       endpoint = Value(endpoint),
       payload = Value(payload),
       createdAt = Value(createdAt);
  static Insertable<SyncQueueItem> custom({
    Expression<String>? id,
    Expression<String>? method,
    Expression<String>? endpoint,
    Expression<String>? payload,
    Expression<int>? attemptCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastAttemptAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (method != null) 'method': method,
      if (endpoint != null) 'endpoint': endpoint,
      if (payload != null) 'payload': payload,
      if (attemptCount != null) 'attempt_count': attemptCount,
      if (createdAt != null) 'created_at': createdAt,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncQueueItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? method,
    Value<String>? endpoint,
    Value<String>? payload,
    Value<int>? attemptCount,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastAttemptAt,
    Value<int>? rowid,
  }) {
    return SyncQueueItemsCompanion(
      id: id ?? this.id,
      method: method ?? this.method,
      endpoint: endpoint ?? this.endpoint,
      payload: payload ?? this.payload,
      attemptCount: attemptCount ?? this.attemptCount,
      createdAt: createdAt ?? this.createdAt,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (endpoint.present) {
      map['endpoint'] = Variable<String>(endpoint.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (attemptCount.present) {
      map['attempt_count'] = Variable<int>(attemptCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueItemsCompanion(')
          ..write('id: $id, ')
          ..write('method: $method, ')
          ..write('endpoint: $endpoint, ')
          ..write('payload: $payload, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedJobSummariesTable extends CachedJobSummaries
    with TableInfo<$CachedJobSummariesTable, CachedJobSummary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedJobSummariesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _villageMeta = const VerificationMeta(
    'village',
  );
  @override
  late final GeneratedColumn<String> village = GeneratedColumn<String>(
    'village',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _districtMeta = const VerificationMeta(
    'district',
  );
  @override
  late final GeneratedColumn<String> district = GeneratedColumn<String>(
    'district',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wageInRupeesMeta = const VerificationMeta(
    'wageInRupees',
  );
  @override
  late final GeneratedColumn<int> wageInRupees = GeneratedColumn<int>(
    'wage_in_rupees',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workDateMeta = const VerificationMeta(
    'workDate',
  );
  @override
  late final GeneratedColumn<DateTime> workDate = GeneratedColumn<DateTime>(
    'work_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    village,
    district,
    wageInRupees,
    workDate,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_job_summaries';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedJobSummary> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('village')) {
      context.handle(
        _villageMeta,
        village.isAcceptableOrUnknown(data['village']!, _villageMeta),
      );
    } else if (isInserting) {
      context.missing(_villageMeta);
    }
    if (data.containsKey('district')) {
      context.handle(
        _districtMeta,
        district.isAcceptableOrUnknown(data['district']!, _districtMeta),
      );
    } else if (isInserting) {
      context.missing(_districtMeta);
    }
    if (data.containsKey('wage_in_rupees')) {
      context.handle(
        _wageInRupeesMeta,
        wageInRupees.isAcceptableOrUnknown(
          data['wage_in_rupees']!,
          _wageInRupeesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wageInRupeesMeta);
    }
    if (data.containsKey('work_date')) {
      context.handle(
        _workDateMeta,
        workDate.isAcceptableOrUnknown(data['work_date']!, _workDateMeta),
      );
    } else if (isInserting) {
      context.missing(_workDateMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedJobSummary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedJobSummary(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      village: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}village'],
      )!,
      district: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}district'],
      )!,
      wageInRupees: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wage_in_rupees'],
      )!,
      workDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}work_date'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $CachedJobSummariesTable createAlias(String alias) {
    return $CachedJobSummariesTable(attachedDatabase, alias);
  }
}

class CachedJobSummary extends DataClass
    implements Insertable<CachedJobSummary> {
  final String id;
  final String title;
  final String village;
  final String district;
  final int wageInRupees;
  final DateTime workDate;
  final DateTime cachedAt;
  const CachedJobSummary({
    required this.id,
    required this.title,
    required this.village,
    required this.district,
    required this.wageInRupees,
    required this.workDate,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['village'] = Variable<String>(village);
    map['district'] = Variable<String>(district);
    map['wage_in_rupees'] = Variable<int>(wageInRupees);
    map['work_date'] = Variable<DateTime>(workDate);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CachedJobSummariesCompanion toCompanion(bool nullToAbsent) {
    return CachedJobSummariesCompanion(
      id: Value(id),
      title: Value(title),
      village: Value(village),
      district: Value(district),
      wageInRupees: Value(wageInRupees),
      workDate: Value(workDate),
      cachedAt: Value(cachedAt),
    );
  }

  factory CachedJobSummary.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedJobSummary(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      village: serializer.fromJson<String>(json['village']),
      district: serializer.fromJson<String>(json['district']),
      wageInRupees: serializer.fromJson<int>(json['wageInRupees']),
      workDate: serializer.fromJson<DateTime>(json['workDate']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'village': serializer.toJson<String>(village),
      'district': serializer.toJson<String>(district),
      'wageInRupees': serializer.toJson<int>(wageInRupees),
      'workDate': serializer.toJson<DateTime>(workDate),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  CachedJobSummary copyWith({
    String? id,
    String? title,
    String? village,
    String? district,
    int? wageInRupees,
    DateTime? workDate,
    DateTime? cachedAt,
  }) => CachedJobSummary(
    id: id ?? this.id,
    title: title ?? this.title,
    village: village ?? this.village,
    district: district ?? this.district,
    wageInRupees: wageInRupees ?? this.wageInRupees,
    workDate: workDate ?? this.workDate,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  CachedJobSummary copyWithCompanion(CachedJobSummariesCompanion data) {
    return CachedJobSummary(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      village: data.village.present ? data.village.value : this.village,
      district: data.district.present ? data.district.value : this.district,
      wageInRupees: data.wageInRupees.present
          ? data.wageInRupees.value
          : this.wageInRupees,
      workDate: data.workDate.present ? data.workDate.value : this.workDate,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedJobSummary(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('village: $village, ')
          ..write('district: $district, ')
          ..write('wageInRupees: $wageInRupees, ')
          ..write('workDate: $workDate, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    village,
    district,
    wageInRupees,
    workDate,
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedJobSummary &&
          other.id == this.id &&
          other.title == this.title &&
          other.village == this.village &&
          other.district == this.district &&
          other.wageInRupees == this.wageInRupees &&
          other.workDate == this.workDate &&
          other.cachedAt == this.cachedAt);
}

class CachedJobSummariesCompanion extends UpdateCompanion<CachedJobSummary> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> village;
  final Value<String> district;
  final Value<int> wageInRupees;
  final Value<DateTime> workDate;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const CachedJobSummariesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.village = const Value.absent(),
    this.district = const Value.absent(),
    this.wageInRupees = const Value.absent(),
    this.workDate = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedJobSummariesCompanion.insert({
    required String id,
    required String title,
    required String village,
    required String district,
    required int wageInRupees,
    required DateTime workDate,
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       village = Value(village),
       district = Value(district),
       wageInRupees = Value(wageInRupees),
       workDate = Value(workDate),
       cachedAt = Value(cachedAt);
  static Insertable<CachedJobSummary> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? village,
    Expression<String>? district,
    Expression<int>? wageInRupees,
    Expression<DateTime>? workDate,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (village != null) 'village': village,
      if (district != null) 'district': district,
      if (wageInRupees != null) 'wage_in_rupees': wageInRupees,
      if (workDate != null) 'work_date': workDate,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedJobSummariesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? village,
    Value<String>? district,
    Value<int>? wageInRupees,
    Value<DateTime>? workDate,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return CachedJobSummariesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      village: village ?? this.village,
      district: district ?? this.district,
      wageInRupees: wageInRupees ?? this.wageInRupees,
      workDate: workDate ?? this.workDate,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (village.present) {
      map['village'] = Variable<String>(village.value);
    }
    if (district.present) {
      map['district'] = Variable<String>(district.value);
    }
    if (wageInRupees.present) {
      map['wage_in_rupees'] = Variable<int>(wageInRupees.value);
    }
    if (workDate.present) {
      map['work_date'] = Variable<DateTime>(workDate.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedJobSummariesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('village: $village, ')
          ..write('district: $district, ')
          ..write('wageInRupees: $wageInRupees, ')
          ..write('workDate: $workDate, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalUsersTable extends LocalUsers
    with TableInfo<$LocalUsersTable, LocalUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalUsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _lastLoginAtMeta = const VerificationMeta(
    'lastLoginAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastLoginAt = GeneratedColumn<DateTime>(
    'last_login_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    phoneNumber,
    role,
    createdAt,
    lastLoginAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_users';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalUser> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_login_at')) {
      context.handle(
        _lastLoginAtMeta,
        lastLoginAt.isAcceptableOrUnknown(
          data['last_login_at']!,
          _lastLoginAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastLoginAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalUser(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastLoginAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_login_at'],
      )!,
    );
  }

  @override
  $LocalUsersTable createAlias(String alias) {
    return $LocalUsersTable(attachedDatabase, alias);
  }
}

class LocalUser extends DataClass implements Insertable<LocalUser> {
  final String id;
  final String phoneNumber;
  final String role;
  final DateTime createdAt;
  final DateTime lastLoginAt;
  const LocalUser({
    required this.id,
    required this.phoneNumber,
    required this.role,
    required this.createdAt,
    required this.lastLoginAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['phone_number'] = Variable<String>(phoneNumber);
    map['role'] = Variable<String>(role);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['last_login_at'] = Variable<DateTime>(lastLoginAt);
    return map;
  }

  LocalUsersCompanion toCompanion(bool nullToAbsent) {
    return LocalUsersCompanion(
      id: Value(id),
      phoneNumber: Value(phoneNumber),
      role: Value(role),
      createdAt: Value(createdAt),
      lastLoginAt: Value(lastLoginAt),
    );
  }

  factory LocalUser.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalUser(
      id: serializer.fromJson<String>(json['id']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      role: serializer.fromJson<String>(json['role']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastLoginAt: serializer.fromJson<DateTime>(json['lastLoginAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'role': serializer.toJson<String>(role),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastLoginAt': serializer.toJson<DateTime>(lastLoginAt),
    };
  }

  LocalUser copyWith({
    String? id,
    String? phoneNumber,
    String? role,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) => LocalUser(
    id: id ?? this.id,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    role: role ?? this.role,
    createdAt: createdAt ?? this.createdAt,
    lastLoginAt: lastLoginAt ?? this.lastLoginAt,
  );
  LocalUser copyWithCompanion(LocalUsersCompanion data) {
    return LocalUser(
      id: data.id.present ? data.id.value : this.id,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      role: data.role.present ? data.role.value : this.role,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastLoginAt: data.lastLoginAt.present
          ? data.lastLoginAt.value
          : this.lastLoginAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalUser(')
          ..write('id: $id, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('role: $role, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastLoginAt: $lastLoginAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, phoneNumber, role, createdAt, lastLoginAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalUser &&
          other.id == this.id &&
          other.phoneNumber == this.phoneNumber &&
          other.role == this.role &&
          other.createdAt == this.createdAt &&
          other.lastLoginAt == this.lastLoginAt);
}

class LocalUsersCompanion extends UpdateCompanion<LocalUser> {
  final Value<String> id;
  final Value<String> phoneNumber;
  final Value<String> role;
  final Value<DateTime> createdAt;
  final Value<DateTime> lastLoginAt;
  final Value<int> rowid;
  const LocalUsersCompanion({
    this.id = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.role = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastLoginAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalUsersCompanion.insert({
    required String id,
    required String phoneNumber,
    required String role,
    required DateTime createdAt,
    required DateTime lastLoginAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       phoneNumber = Value(phoneNumber),
       role = Value(role),
       createdAt = Value(createdAt),
       lastLoginAt = Value(lastLoginAt);
  static Insertable<LocalUser> custom({
    Expression<String>? id,
    Expression<String>? phoneNumber,
    Expression<String>? role,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastLoginAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (role != null) 'role': role,
      if (createdAt != null) 'created_at': createdAt,
      if (lastLoginAt != null) 'last_login_at': lastLoginAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalUsersCompanion copyWith({
    Value<String>? id,
    Value<String>? phoneNumber,
    Value<String>? role,
    Value<DateTime>? createdAt,
    Value<DateTime>? lastLoginAt,
    Value<int>? rowid,
  }) {
    return LocalUsersCompanion(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastLoginAt.present) {
      map['last_login_at'] = Variable<DateTime>(lastLoginAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalUsersCompanion(')
          ..write('id: $id, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('role: $role, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastLoginAt: $lastLoginAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuthSessionsTable extends AuthSessions
    with TableInfo<$AuthSessionsTable, AuthSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuthSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localUserIdMeta = const VerificationMeta(
    'localUserId',
  );
  @override
  late final GeneratedColumn<String> localUserId = GeneratedColumn<String>(
    'local_user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_users (id)',
    ),
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
  static const VerificationMeta _lastRestoredAtMeta = const VerificationMeta(
    'lastRestoredAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastRestoredAt =
      GeneratedColumn<DateTime>(
        'last_restored_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _loggedOutAtMeta = const VerificationMeta(
    'loggedOutAt',
  );
  @override
  late final GeneratedColumn<DateTime> loggedOutAt = GeneratedColumn<DateTime>(
    'logged_out_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localUserId,
    phoneNumber,
    role,
    isActive,
    createdAt,
    lastRestoredAt,
    loggedOutAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'auth_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuthSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('local_user_id')) {
      context.handle(
        _localUserIdMeta,
        localUserId.isAcceptableOrUnknown(
          data['local_user_id']!,
          _localUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_localUserIdMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
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
    if (data.containsKey('last_restored_at')) {
      context.handle(
        _lastRestoredAtMeta,
        lastRestoredAt.isAcceptableOrUnknown(
          data['last_restored_at']!,
          _lastRestoredAtMeta,
        ),
      );
    }
    if (data.containsKey('logged_out_at')) {
      context.handle(
        _loggedOutAtMeta,
        loggedOutAt.isAcceptableOrUnknown(
          data['logged_out_at']!,
          _loggedOutAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuthSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuthSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      localUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_user_id'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastRestoredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_restored_at'],
      ),
      loggedOutAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_out_at'],
      ),
    );
  }

  @override
  $AuthSessionsTable createAlias(String alias) {
    return $AuthSessionsTable(attachedDatabase, alias);
  }
}

class AuthSession extends DataClass implements Insertable<AuthSession> {
  final String id;
  final String localUserId;
  final String phoneNumber;
  final String role;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? lastRestoredAt;
  final DateTime? loggedOutAt;
  const AuthSession({
    required this.id,
    required this.localUserId,
    required this.phoneNumber,
    required this.role,
    required this.isActive,
    required this.createdAt,
    this.lastRestoredAt,
    this.loggedOutAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['local_user_id'] = Variable<String>(localUserId);
    map['phone_number'] = Variable<String>(phoneNumber);
    map['role'] = Variable<String>(role);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastRestoredAt != null) {
      map['last_restored_at'] = Variable<DateTime>(lastRestoredAt);
    }
    if (!nullToAbsent || loggedOutAt != null) {
      map['logged_out_at'] = Variable<DateTime>(loggedOutAt);
    }
    return map;
  }

  AuthSessionsCompanion toCompanion(bool nullToAbsent) {
    return AuthSessionsCompanion(
      id: Value(id),
      localUserId: Value(localUserId),
      phoneNumber: Value(phoneNumber),
      role: Value(role),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      lastRestoredAt: lastRestoredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastRestoredAt),
      loggedOutAt: loggedOutAt == null && nullToAbsent
          ? const Value.absent()
          : Value(loggedOutAt),
    );
  }

  factory AuthSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuthSession(
      id: serializer.fromJson<String>(json['id']),
      localUserId: serializer.fromJson<String>(json['localUserId']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      role: serializer.fromJson<String>(json['role']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastRestoredAt: serializer.fromJson<DateTime?>(json['lastRestoredAt']),
      loggedOutAt: serializer.fromJson<DateTime?>(json['loggedOutAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'localUserId': serializer.toJson<String>(localUserId),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'role': serializer.toJson<String>(role),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastRestoredAt': serializer.toJson<DateTime?>(lastRestoredAt),
      'loggedOutAt': serializer.toJson<DateTime?>(loggedOutAt),
    };
  }

  AuthSession copyWith({
    String? id,
    String? localUserId,
    String? phoneNumber,
    String? role,
    bool? isActive,
    DateTime? createdAt,
    Value<DateTime?> lastRestoredAt = const Value.absent(),
    Value<DateTime?> loggedOutAt = const Value.absent(),
  }) => AuthSession(
    id: id ?? this.id,
    localUserId: localUserId ?? this.localUserId,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    role: role ?? this.role,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    lastRestoredAt: lastRestoredAt.present
        ? lastRestoredAt.value
        : this.lastRestoredAt,
    loggedOutAt: loggedOutAt.present ? loggedOutAt.value : this.loggedOutAt,
  );
  AuthSession copyWithCompanion(AuthSessionsCompanion data) {
    return AuthSession(
      id: data.id.present ? data.id.value : this.id,
      localUserId: data.localUserId.present
          ? data.localUserId.value
          : this.localUserId,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      role: data.role.present ? data.role.value : this.role,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastRestoredAt: data.lastRestoredAt.present
          ? data.lastRestoredAt.value
          : this.lastRestoredAt,
      loggedOutAt: data.loggedOutAt.present
          ? data.loggedOutAt.value
          : this.loggedOutAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuthSession(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('role: $role, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastRestoredAt: $lastRestoredAt, ')
          ..write('loggedOutAt: $loggedOutAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localUserId,
    phoneNumber,
    role,
    isActive,
    createdAt,
    lastRestoredAt,
    loggedOutAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuthSession &&
          other.id == this.id &&
          other.localUserId == this.localUserId &&
          other.phoneNumber == this.phoneNumber &&
          other.role == this.role &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.lastRestoredAt == this.lastRestoredAt &&
          other.loggedOutAt == this.loggedOutAt);
}

class AuthSessionsCompanion extends UpdateCompanion<AuthSession> {
  final Value<String> id;
  final Value<String> localUserId;
  final Value<String> phoneNumber;
  final Value<String> role;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastRestoredAt;
  final Value<DateTime?> loggedOutAt;
  final Value<int> rowid;
  const AuthSessionsCompanion({
    this.id = const Value.absent(),
    this.localUserId = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.role = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastRestoredAt = const Value.absent(),
    this.loggedOutAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuthSessionsCompanion.insert({
    required String id,
    required String localUserId,
    required String phoneNumber,
    required String role,
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    this.lastRestoredAt = const Value.absent(),
    this.loggedOutAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       localUserId = Value(localUserId),
       phoneNumber = Value(phoneNumber),
       role = Value(role),
       createdAt = Value(createdAt);
  static Insertable<AuthSession> custom({
    Expression<String>? id,
    Expression<String>? localUserId,
    Expression<String>? phoneNumber,
    Expression<String>? role,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastRestoredAt,
    Expression<DateTime>? loggedOutAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localUserId != null) 'local_user_id': localUserId,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (role != null) 'role': role,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (lastRestoredAt != null) 'last_restored_at': lastRestoredAt,
      if (loggedOutAt != null) 'logged_out_at': loggedOutAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuthSessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? localUserId,
    Value<String>? phoneNumber,
    Value<String>? role,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastRestoredAt,
    Value<DateTime?>? loggedOutAt,
    Value<int>? rowid,
  }) {
    return AuthSessionsCompanion(
      id: id ?? this.id,
      localUserId: localUserId ?? this.localUserId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      lastRestoredAt: lastRestoredAt ?? this.lastRestoredAt,
      loggedOutAt: loggedOutAt ?? this.loggedOutAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (localUserId.present) {
      map['local_user_id'] = Variable<String>(localUserId.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastRestoredAt.present) {
      map['last_restored_at'] = Variable<DateTime>(lastRestoredAt.value);
    }
    if (loggedOutAt.present) {
      map['logged_out_at'] = Variable<DateTime>(loggedOutAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuthSessionsCompanion(')
          ..write('id: $id, ')
          ..write('localUserId: $localUserId, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('role: $role, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastRestoredAt: $lastRestoredAt, ')
          ..write('loggedOutAt: $loggedOutAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FarmerProfilesTable extends FarmerProfiles
    with TableInfo<$FarmerProfilesTable, FarmerProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FarmerProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _villageMeta = const VerificationMeta(
    'village',
  );
  @override
  late final GeneratedColumn<String> village = GeneratedColumn<String>(
    'village',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _districtMeta = const VerificationMeta(
    'district',
  );
  @override
  late final GeneratedColumn<String> district = GeneratedColumn<String>(
    'district',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateNameMeta = const VerificationMeta(
    'stateName',
  );
  @override
  late final GeneratedColumn<String> stateName = GeneratedColumn<String>(
    'state_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _farmTypeMeta = const VerificationMeta(
    'farmType',
  );
  @override
  late final GeneratedColumn<String> farmType = GeneratedColumn<String>(
    'farm_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _landSizeMeta = const VerificationMeta(
    'landSize',
  );
  @override
  late final GeneratedColumn<double> landSize = GeneratedColumn<double>(
    'land_size',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _preferredCropsJsonMeta =
      const VerificationMeta('preferredCropsJson');
  @override
  late final GeneratedColumn<String> preferredCropsJson =
      GeneratedColumn<String>(
        'preferred_crops_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _needsSyncMeta = const VerificationMeta(
    'needsSync',
  );
  @override
  late final GeneratedColumn<bool> needsSync = GeneratedColumn<bool>(
    'needs_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("needs_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
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
    id,
    fullName,
    phoneNumber,
    village,
    district,
    stateName,
    farmType,
    landSize,
    preferredCropsJson,
    photoPath,
    latitude,
    longitude,
    needsSync,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'farmer_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<FarmerProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('village')) {
      context.handle(
        _villageMeta,
        village.isAcceptableOrUnknown(data['village']!, _villageMeta),
      );
    } else if (isInserting) {
      context.missing(_villageMeta);
    }
    if (data.containsKey('district')) {
      context.handle(
        _districtMeta,
        district.isAcceptableOrUnknown(data['district']!, _districtMeta),
      );
    } else if (isInserting) {
      context.missing(_districtMeta);
    }
    if (data.containsKey('state_name')) {
      context.handle(
        _stateNameMeta,
        stateName.isAcceptableOrUnknown(data['state_name']!, _stateNameMeta),
      );
    } else if (isInserting) {
      context.missing(_stateNameMeta);
    }
    if (data.containsKey('farm_type')) {
      context.handle(
        _farmTypeMeta,
        farmType.isAcceptableOrUnknown(data['farm_type']!, _farmTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_farmTypeMeta);
    }
    if (data.containsKey('land_size')) {
      context.handle(
        _landSizeMeta,
        landSize.isAcceptableOrUnknown(data['land_size']!, _landSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_landSizeMeta);
    }
    if (data.containsKey('preferred_crops_json')) {
      context.handle(
        _preferredCropsJsonMeta,
        preferredCropsJson.isAcceptableOrUnknown(
          data['preferred_crops_json']!,
          _preferredCropsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_preferredCropsJsonMeta);
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('needs_sync')) {
      context.handle(
        _needsSyncMeta,
        needsSync.isAcceptableOrUnknown(data['needs_sync']!, _needsSyncMeta),
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FarmerProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FarmerProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
      village: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}village'],
      )!,
      district: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}district'],
      )!,
      stateName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state_name'],
      )!,
      farmType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farm_type'],
      )!,
      landSize: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}land_size'],
      )!,
      preferredCropsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preferred_crops_json'],
      )!,
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      needsSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}needs_sync'],
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
  $FarmerProfilesTable createAlias(String alias) {
    return $FarmerProfilesTable(attachedDatabase, alias);
  }
}

class FarmerProfile extends DataClass implements Insertable<FarmerProfile> {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String village;
  final String district;
  final String stateName;
  final String farmType;
  final double landSize;
  final String preferredCropsJson;
  final String? photoPath;
  final double? latitude;
  final double? longitude;
  final bool needsSync;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FarmerProfile({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.village,
    required this.district,
    required this.stateName,
    required this.farmType,
    required this.landSize,
    required this.preferredCropsJson,
    this.photoPath,
    this.latitude,
    this.longitude,
    required this.needsSync,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['full_name'] = Variable<String>(fullName);
    map['phone_number'] = Variable<String>(phoneNumber);
    map['village'] = Variable<String>(village);
    map['district'] = Variable<String>(district);
    map['state_name'] = Variable<String>(stateName);
    map['farm_type'] = Variable<String>(farmType);
    map['land_size'] = Variable<double>(landSize);
    map['preferred_crops_json'] = Variable<String>(preferredCropsJson);
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    map['needs_sync'] = Variable<bool>(needsSync);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FarmerProfilesCompanion toCompanion(bool nullToAbsent) {
    return FarmerProfilesCompanion(
      id: Value(id),
      fullName: Value(fullName),
      phoneNumber: Value(phoneNumber),
      village: Value(village),
      district: Value(district),
      stateName: Value(stateName),
      farmType: Value(farmType),
      landSize: Value(landSize),
      preferredCropsJson: Value(preferredCropsJson),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      needsSync: Value(needsSync),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FarmerProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FarmerProfile(
      id: serializer.fromJson<String>(json['id']),
      fullName: serializer.fromJson<String>(json['fullName']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      village: serializer.fromJson<String>(json['village']),
      district: serializer.fromJson<String>(json['district']),
      stateName: serializer.fromJson<String>(json['stateName']),
      farmType: serializer.fromJson<String>(json['farmType']),
      landSize: serializer.fromJson<double>(json['landSize']),
      preferredCropsJson: serializer.fromJson<String>(
        json['preferredCropsJson'],
      ),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      needsSync: serializer.fromJson<bool>(json['needsSync']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fullName': serializer.toJson<String>(fullName),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'village': serializer.toJson<String>(village),
      'district': serializer.toJson<String>(district),
      'stateName': serializer.toJson<String>(stateName),
      'farmType': serializer.toJson<String>(farmType),
      'landSize': serializer.toJson<double>(landSize),
      'preferredCropsJson': serializer.toJson<String>(preferredCropsJson),
      'photoPath': serializer.toJson<String?>(photoPath),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'needsSync': serializer.toJson<bool>(needsSync),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FarmerProfile copyWith({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? village,
    String? district,
    String? stateName,
    String? farmType,
    double? landSize,
    String? preferredCropsJson,
    Value<String?> photoPath = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    bool? needsSync,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FarmerProfile(
    id: id ?? this.id,
    fullName: fullName ?? this.fullName,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    village: village ?? this.village,
    district: district ?? this.district,
    stateName: stateName ?? this.stateName,
    farmType: farmType ?? this.farmType,
    landSize: landSize ?? this.landSize,
    preferredCropsJson: preferredCropsJson ?? this.preferredCropsJson,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    needsSync: needsSync ?? this.needsSync,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FarmerProfile copyWithCompanion(FarmerProfilesCompanion data) {
    return FarmerProfile(
      id: data.id.present ? data.id.value : this.id,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      village: data.village.present ? data.village.value : this.village,
      district: data.district.present ? data.district.value : this.district,
      stateName: data.stateName.present ? data.stateName.value : this.stateName,
      farmType: data.farmType.present ? data.farmType.value : this.farmType,
      landSize: data.landSize.present ? data.landSize.value : this.landSize,
      preferredCropsJson: data.preferredCropsJson.present
          ? data.preferredCropsJson.value
          : this.preferredCropsJson,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      needsSync: data.needsSync.present ? data.needsSync.value : this.needsSync,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FarmerProfile(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('village: $village, ')
          ..write('district: $district, ')
          ..write('stateName: $stateName, ')
          ..write('farmType: $farmType, ')
          ..write('landSize: $landSize, ')
          ..write('preferredCropsJson: $preferredCropsJson, ')
          ..write('photoPath: $photoPath, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('needsSync: $needsSync, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fullName,
    phoneNumber,
    village,
    district,
    stateName,
    farmType,
    landSize,
    preferredCropsJson,
    photoPath,
    latitude,
    longitude,
    needsSync,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FarmerProfile &&
          other.id == this.id &&
          other.fullName == this.fullName &&
          other.phoneNumber == this.phoneNumber &&
          other.village == this.village &&
          other.district == this.district &&
          other.stateName == this.stateName &&
          other.farmType == this.farmType &&
          other.landSize == this.landSize &&
          other.preferredCropsJson == this.preferredCropsJson &&
          other.photoPath == this.photoPath &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.needsSync == this.needsSync &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FarmerProfilesCompanion extends UpdateCompanion<FarmerProfile> {
  final Value<String> id;
  final Value<String> fullName;
  final Value<String> phoneNumber;
  final Value<String> village;
  final Value<String> district;
  final Value<String> stateName;
  final Value<String> farmType;
  final Value<double> landSize;
  final Value<String> preferredCropsJson;
  final Value<String?> photoPath;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<bool> needsSync;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FarmerProfilesCompanion({
    this.id = const Value.absent(),
    this.fullName = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.village = const Value.absent(),
    this.district = const Value.absent(),
    this.stateName = const Value.absent(),
    this.farmType = const Value.absent(),
    this.landSize = const Value.absent(),
    this.preferredCropsJson = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.needsSync = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FarmerProfilesCompanion.insert({
    required String id,
    required String fullName,
    required String phoneNumber,
    required String village,
    required String district,
    required String stateName,
    required String farmType,
    required double landSize,
    required String preferredCropsJson,
    this.photoPath = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.needsSync = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fullName = Value(fullName),
       phoneNumber = Value(phoneNumber),
       village = Value(village),
       district = Value(district),
       stateName = Value(stateName),
       farmType = Value(farmType),
       landSize = Value(landSize),
       preferredCropsJson = Value(preferredCropsJson),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FarmerProfile> custom({
    Expression<String>? id,
    Expression<String>? fullName,
    Expression<String>? phoneNumber,
    Expression<String>? village,
    Expression<String>? district,
    Expression<String>? stateName,
    Expression<String>? farmType,
    Expression<double>? landSize,
    Expression<String>? preferredCropsJson,
    Expression<String>? photoPath,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<bool>? needsSync,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fullName != null) 'full_name': fullName,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (village != null) 'village': village,
      if (district != null) 'district': district,
      if (stateName != null) 'state_name': stateName,
      if (farmType != null) 'farm_type': farmType,
      if (landSize != null) 'land_size': landSize,
      if (preferredCropsJson != null)
        'preferred_crops_json': preferredCropsJson,
      if (photoPath != null) 'photo_path': photoPath,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (needsSync != null) 'needs_sync': needsSync,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FarmerProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? fullName,
    Value<String>? phoneNumber,
    Value<String>? village,
    Value<String>? district,
    Value<String>? stateName,
    Value<String>? farmType,
    Value<double>? landSize,
    Value<String>? preferredCropsJson,
    Value<String?>? photoPath,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<bool>? needsSync,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FarmerProfilesCompanion(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      village: village ?? this.village,
      district: district ?? this.district,
      stateName: stateName ?? this.stateName,
      farmType: farmType ?? this.farmType,
      landSize: landSize ?? this.landSize,
      preferredCropsJson: preferredCropsJson ?? this.preferredCropsJson,
      photoPath: photoPath ?? this.photoPath,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      needsSync: needsSync ?? this.needsSync,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (village.present) {
      map['village'] = Variable<String>(village.value);
    }
    if (district.present) {
      map['district'] = Variable<String>(district.value);
    }
    if (stateName.present) {
      map['state_name'] = Variable<String>(stateName.value);
    }
    if (farmType.present) {
      map['farm_type'] = Variable<String>(farmType.value);
    }
    if (landSize.present) {
      map['land_size'] = Variable<double>(landSize.value);
    }
    if (preferredCropsJson.present) {
      map['preferred_crops_json'] = Variable<String>(preferredCropsJson.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (needsSync.present) {
      map['needs_sync'] = Variable<bool>(needsSync.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FarmerProfilesCompanion(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('village: $village, ')
          ..write('district: $district, ')
          ..write('stateName: $stateName, ')
          ..write('farmType: $farmType, ')
          ..write('landSize: $landSize, ')
          ..write('preferredCropsJson: $preferredCropsJson, ')
          ..write('photoPath: $photoPath, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('needsSync: $needsSync, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkerProfilesTable extends WorkerProfiles
    with TableInfo<$WorkerProfilesTable, WorkerProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkerProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _villageMeta = const VerificationMeta(
    'village',
  );
  @override
  late final GeneratedColumn<String> village = GeneratedColumn<String>(
    'village',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _districtMeta = const VerificationMeta(
    'district',
  );
  @override
  late final GeneratedColumn<String> district = GeneratedColumn<String>(
    'district',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateNameMeta = const VerificationMeta(
    'stateName',
  );
  @override
  late final GeneratedColumn<String> stateName = GeneratedColumn<String>(
    'state_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skillsJsonMeta = const VerificationMeta(
    'skillsJson',
  );
  @override
  late final GeneratedColumn<String> skillsJson = GeneratedColumn<String>(
    'skills_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yearsOfExperienceMeta = const VerificationMeta(
    'yearsOfExperience',
  );
  @override
  late final GeneratedColumn<int> yearsOfExperience = GeneratedColumn<int>(
    'years_of_experience',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dailyWageExpectationMeta =
      const VerificationMeta('dailyWageExpectation');
  @override
  late final GeneratedColumn<int> dailyWageExpectation = GeneratedColumn<int>(
    'daily_wage_expectation',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isAvailableMeta = const VerificationMeta(
    'isAvailable',
  );
  @override
  late final GeneratedColumn<bool> isAvailable = GeneratedColumn<bool>(
    'is_available',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_available" IN (0, 1))',
    ),
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _needsSyncMeta = const VerificationMeta(
    'needsSync',
  );
  @override
  late final GeneratedColumn<bool> needsSync = GeneratedColumn<bool>(
    'needs_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("needs_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
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
    id,
    fullName,
    phoneNumber,
    village,
    district,
    stateName,
    skillsJson,
    yearsOfExperience,
    dailyWageExpectation,
    isAvailable,
    photoPath,
    latitude,
    longitude,
    needsSync,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'worker_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkerProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('village')) {
      context.handle(
        _villageMeta,
        village.isAcceptableOrUnknown(data['village']!, _villageMeta),
      );
    } else if (isInserting) {
      context.missing(_villageMeta);
    }
    if (data.containsKey('district')) {
      context.handle(
        _districtMeta,
        district.isAcceptableOrUnknown(data['district']!, _districtMeta),
      );
    } else if (isInserting) {
      context.missing(_districtMeta);
    }
    if (data.containsKey('state_name')) {
      context.handle(
        _stateNameMeta,
        stateName.isAcceptableOrUnknown(data['state_name']!, _stateNameMeta),
      );
    } else if (isInserting) {
      context.missing(_stateNameMeta);
    }
    if (data.containsKey('skills_json')) {
      context.handle(
        _skillsJsonMeta,
        skillsJson.isAcceptableOrUnknown(data['skills_json']!, _skillsJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_skillsJsonMeta);
    }
    if (data.containsKey('years_of_experience')) {
      context.handle(
        _yearsOfExperienceMeta,
        yearsOfExperience.isAcceptableOrUnknown(
          data['years_of_experience']!,
          _yearsOfExperienceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_yearsOfExperienceMeta);
    }
    if (data.containsKey('daily_wage_expectation')) {
      context.handle(
        _dailyWageExpectationMeta,
        dailyWageExpectation.isAcceptableOrUnknown(
          data['daily_wage_expectation']!,
          _dailyWageExpectationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dailyWageExpectationMeta);
    }
    if (data.containsKey('is_available')) {
      context.handle(
        _isAvailableMeta,
        isAvailable.isAcceptableOrUnknown(
          data['is_available']!,
          _isAvailableMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isAvailableMeta);
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('needs_sync')) {
      context.handle(
        _needsSyncMeta,
        needsSync.isAcceptableOrUnknown(data['needs_sync']!, _needsSyncMeta),
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkerProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkerProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
      village: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}village'],
      )!,
      district: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}district'],
      )!,
      stateName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state_name'],
      )!,
      skillsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}skills_json'],
      )!,
      yearsOfExperience: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}years_of_experience'],
      )!,
      dailyWageExpectation: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_wage_expectation'],
      )!,
      isAvailable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_available'],
      )!,
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      needsSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}needs_sync'],
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
  $WorkerProfilesTable createAlias(String alias) {
    return $WorkerProfilesTable(attachedDatabase, alias);
  }
}

class WorkerProfile extends DataClass implements Insertable<WorkerProfile> {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String village;
  final String district;
  final String stateName;
  final String skillsJson;
  final int yearsOfExperience;
  final int dailyWageExpectation;
  final bool isAvailable;
  final String? photoPath;
  final double? latitude;
  final double? longitude;
  final bool needsSync;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WorkerProfile({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.village,
    required this.district,
    required this.stateName,
    required this.skillsJson,
    required this.yearsOfExperience,
    required this.dailyWageExpectation,
    required this.isAvailable,
    this.photoPath,
    this.latitude,
    this.longitude,
    required this.needsSync,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['full_name'] = Variable<String>(fullName);
    map['phone_number'] = Variable<String>(phoneNumber);
    map['village'] = Variable<String>(village);
    map['district'] = Variable<String>(district);
    map['state_name'] = Variable<String>(stateName);
    map['skills_json'] = Variable<String>(skillsJson);
    map['years_of_experience'] = Variable<int>(yearsOfExperience);
    map['daily_wage_expectation'] = Variable<int>(dailyWageExpectation);
    map['is_available'] = Variable<bool>(isAvailable);
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    map['needs_sync'] = Variable<bool>(needsSync);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WorkerProfilesCompanion toCompanion(bool nullToAbsent) {
    return WorkerProfilesCompanion(
      id: Value(id),
      fullName: Value(fullName),
      phoneNumber: Value(phoneNumber),
      village: Value(village),
      district: Value(district),
      stateName: Value(stateName),
      skillsJson: Value(skillsJson),
      yearsOfExperience: Value(yearsOfExperience),
      dailyWageExpectation: Value(dailyWageExpectation),
      isAvailable: Value(isAvailable),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      needsSync: Value(needsSync),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WorkerProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkerProfile(
      id: serializer.fromJson<String>(json['id']),
      fullName: serializer.fromJson<String>(json['fullName']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      village: serializer.fromJson<String>(json['village']),
      district: serializer.fromJson<String>(json['district']),
      stateName: serializer.fromJson<String>(json['stateName']),
      skillsJson: serializer.fromJson<String>(json['skillsJson']),
      yearsOfExperience: serializer.fromJson<int>(json['yearsOfExperience']),
      dailyWageExpectation: serializer.fromJson<int>(
        json['dailyWageExpectation'],
      ),
      isAvailable: serializer.fromJson<bool>(json['isAvailable']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      needsSync: serializer.fromJson<bool>(json['needsSync']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fullName': serializer.toJson<String>(fullName),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'village': serializer.toJson<String>(village),
      'district': serializer.toJson<String>(district),
      'stateName': serializer.toJson<String>(stateName),
      'skillsJson': serializer.toJson<String>(skillsJson),
      'yearsOfExperience': serializer.toJson<int>(yearsOfExperience),
      'dailyWageExpectation': serializer.toJson<int>(dailyWageExpectation),
      'isAvailable': serializer.toJson<bool>(isAvailable),
      'photoPath': serializer.toJson<String?>(photoPath),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'needsSync': serializer.toJson<bool>(needsSync),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WorkerProfile copyWith({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? village,
    String? district,
    String? stateName,
    String? skillsJson,
    int? yearsOfExperience,
    int? dailyWageExpectation,
    bool? isAvailable,
    Value<String?> photoPath = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    bool? needsSync,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => WorkerProfile(
    id: id ?? this.id,
    fullName: fullName ?? this.fullName,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    village: village ?? this.village,
    district: district ?? this.district,
    stateName: stateName ?? this.stateName,
    skillsJson: skillsJson ?? this.skillsJson,
    yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
    dailyWageExpectation: dailyWageExpectation ?? this.dailyWageExpectation,
    isAvailable: isAvailable ?? this.isAvailable,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    needsSync: needsSync ?? this.needsSync,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  WorkerProfile copyWithCompanion(WorkerProfilesCompanion data) {
    return WorkerProfile(
      id: data.id.present ? data.id.value : this.id,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      village: data.village.present ? data.village.value : this.village,
      district: data.district.present ? data.district.value : this.district,
      stateName: data.stateName.present ? data.stateName.value : this.stateName,
      skillsJson: data.skillsJson.present
          ? data.skillsJson.value
          : this.skillsJson,
      yearsOfExperience: data.yearsOfExperience.present
          ? data.yearsOfExperience.value
          : this.yearsOfExperience,
      dailyWageExpectation: data.dailyWageExpectation.present
          ? data.dailyWageExpectation.value
          : this.dailyWageExpectation,
      isAvailable: data.isAvailable.present
          ? data.isAvailable.value
          : this.isAvailable,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      needsSync: data.needsSync.present ? data.needsSync.value : this.needsSync,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkerProfile(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('village: $village, ')
          ..write('district: $district, ')
          ..write('stateName: $stateName, ')
          ..write('skillsJson: $skillsJson, ')
          ..write('yearsOfExperience: $yearsOfExperience, ')
          ..write('dailyWageExpectation: $dailyWageExpectation, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('photoPath: $photoPath, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('needsSync: $needsSync, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fullName,
    phoneNumber,
    village,
    district,
    stateName,
    skillsJson,
    yearsOfExperience,
    dailyWageExpectation,
    isAvailable,
    photoPath,
    latitude,
    longitude,
    needsSync,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkerProfile &&
          other.id == this.id &&
          other.fullName == this.fullName &&
          other.phoneNumber == this.phoneNumber &&
          other.village == this.village &&
          other.district == this.district &&
          other.stateName == this.stateName &&
          other.skillsJson == this.skillsJson &&
          other.yearsOfExperience == this.yearsOfExperience &&
          other.dailyWageExpectation == this.dailyWageExpectation &&
          other.isAvailable == this.isAvailable &&
          other.photoPath == this.photoPath &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.needsSync == this.needsSync &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WorkerProfilesCompanion extends UpdateCompanion<WorkerProfile> {
  final Value<String> id;
  final Value<String> fullName;
  final Value<String> phoneNumber;
  final Value<String> village;
  final Value<String> district;
  final Value<String> stateName;
  final Value<String> skillsJson;
  final Value<int> yearsOfExperience;
  final Value<int> dailyWageExpectation;
  final Value<bool> isAvailable;
  final Value<String?> photoPath;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<bool> needsSync;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const WorkerProfilesCompanion({
    this.id = const Value.absent(),
    this.fullName = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.village = const Value.absent(),
    this.district = const Value.absent(),
    this.stateName = const Value.absent(),
    this.skillsJson = const Value.absent(),
    this.yearsOfExperience = const Value.absent(),
    this.dailyWageExpectation = const Value.absent(),
    this.isAvailable = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.needsSync = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkerProfilesCompanion.insert({
    required String id,
    required String fullName,
    required String phoneNumber,
    required String village,
    required String district,
    required String stateName,
    required String skillsJson,
    required int yearsOfExperience,
    required int dailyWageExpectation,
    required bool isAvailable,
    this.photoPath = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.needsSync = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fullName = Value(fullName),
       phoneNumber = Value(phoneNumber),
       village = Value(village),
       district = Value(district),
       stateName = Value(stateName),
       skillsJson = Value(skillsJson),
       yearsOfExperience = Value(yearsOfExperience),
       dailyWageExpectation = Value(dailyWageExpectation),
       isAvailable = Value(isAvailable),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<WorkerProfile> custom({
    Expression<String>? id,
    Expression<String>? fullName,
    Expression<String>? phoneNumber,
    Expression<String>? village,
    Expression<String>? district,
    Expression<String>? stateName,
    Expression<String>? skillsJson,
    Expression<int>? yearsOfExperience,
    Expression<int>? dailyWageExpectation,
    Expression<bool>? isAvailable,
    Expression<String>? photoPath,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<bool>? needsSync,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fullName != null) 'full_name': fullName,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (village != null) 'village': village,
      if (district != null) 'district': district,
      if (stateName != null) 'state_name': stateName,
      if (skillsJson != null) 'skills_json': skillsJson,
      if (yearsOfExperience != null) 'years_of_experience': yearsOfExperience,
      if (dailyWageExpectation != null)
        'daily_wage_expectation': dailyWageExpectation,
      if (isAvailable != null) 'is_available': isAvailable,
      if (photoPath != null) 'photo_path': photoPath,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (needsSync != null) 'needs_sync': needsSync,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkerProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? fullName,
    Value<String>? phoneNumber,
    Value<String>? village,
    Value<String>? district,
    Value<String>? stateName,
    Value<String>? skillsJson,
    Value<int>? yearsOfExperience,
    Value<int>? dailyWageExpectation,
    Value<bool>? isAvailable,
    Value<String?>? photoPath,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<bool>? needsSync,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return WorkerProfilesCompanion(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      village: village ?? this.village,
      district: district ?? this.district,
      stateName: stateName ?? this.stateName,
      skillsJson: skillsJson ?? this.skillsJson,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      dailyWageExpectation: dailyWageExpectation ?? this.dailyWageExpectation,
      isAvailable: isAvailable ?? this.isAvailable,
      photoPath: photoPath ?? this.photoPath,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      needsSync: needsSync ?? this.needsSync,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (village.present) {
      map['village'] = Variable<String>(village.value);
    }
    if (district.present) {
      map['district'] = Variable<String>(district.value);
    }
    if (stateName.present) {
      map['state_name'] = Variable<String>(stateName.value);
    }
    if (skillsJson.present) {
      map['skills_json'] = Variable<String>(skillsJson.value);
    }
    if (yearsOfExperience.present) {
      map['years_of_experience'] = Variable<int>(yearsOfExperience.value);
    }
    if (dailyWageExpectation.present) {
      map['daily_wage_expectation'] = Variable<int>(dailyWageExpectation.value);
    }
    if (isAvailable.present) {
      map['is_available'] = Variable<bool>(isAvailable.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (needsSync.present) {
      map['needs_sync'] = Variable<bool>(needsSync.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkerProfilesCompanion(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('village: $village, ')
          ..write('district: $district, ')
          ..write('stateName: $stateName, ')
          ..write('skillsJson: $skillsJson, ')
          ..write('yearsOfExperience: $yearsOfExperience, ')
          ..write('dailyWageExpectation: $dailyWageExpectation, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('photoPath: $photoPath, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('needsSync: $needsSync, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SyncQueueItemsTable syncQueueItems = $SyncQueueItemsTable(this);
  late final $CachedJobSummariesTable cachedJobSummaries =
      $CachedJobSummariesTable(this);
  late final $LocalUsersTable localUsers = $LocalUsersTable(this);
  late final $AuthSessionsTable authSessions = $AuthSessionsTable(this);
  late final $FarmerProfilesTable farmerProfiles = $FarmerProfilesTable(this);
  late final $WorkerProfilesTable workerProfiles = $WorkerProfilesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    syncQueueItems,
    cachedJobSummaries,
    localUsers,
    authSessions,
    farmerProfiles,
    workerProfiles,
  ];
}

typedef $$SyncQueueItemsTableCreateCompanionBuilder =
    SyncQueueItemsCompanion Function({
      required String id,
      required String method,
      required String endpoint,
      required String payload,
      Value<int> attemptCount,
      required DateTime createdAt,
      Value<DateTime?> lastAttemptAt,
      Value<int> rowid,
    });
typedef $$SyncQueueItemsTableUpdateCompanionBuilder =
    SyncQueueItemsCompanion Function({
      Value<String> id,
      Value<String> method,
      Value<String> endpoint,
      Value<String> payload,
      Value<int> attemptCount,
      Value<DateTime> createdAt,
      Value<DateTime?> lastAttemptAt,
      Value<int> rowid,
    });

class $$SyncQueueItemsTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueItemsTable> {
  $$SyncQueueItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endpoint => $composableBuilder(
    column: $table.endpoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueItemsTable> {
  $$SyncQueueItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endpoint => $composableBuilder(
    column: $table.endpoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueItemsTable> {
  $$SyncQueueItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<String> get endpoint =>
      $composableBuilder(column: $table.endpoint, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => column,
  );
}

class $$SyncQueueItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueItemsTable,
          SyncQueueItem,
          $$SyncQueueItemsTableFilterComposer,
          $$SyncQueueItemsTableOrderingComposer,
          $$SyncQueueItemsTableAnnotationComposer,
          $$SyncQueueItemsTableCreateCompanionBuilder,
          $$SyncQueueItemsTableUpdateCompanionBuilder,
          (
            SyncQueueItem,
            BaseReferences<_$AppDatabase, $SyncQueueItemsTable, SyncQueueItem>,
          ),
          SyncQueueItem,
          PrefetchHooks Function()
        > {
  $$SyncQueueItemsTableTableManager(
    _$AppDatabase db,
    $SyncQueueItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<String> endpoint = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<int> attemptCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueItemsCompanion(
                id: id,
                method: method,
                endpoint: endpoint,
                payload: payload,
                attemptCount: attemptCount,
                createdAt: createdAt,
                lastAttemptAt: lastAttemptAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String method,
                required String endpoint,
                required String payload,
                Value<int> attemptCount = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueItemsCompanion.insert(
                id: id,
                method: method,
                endpoint: endpoint,
                payload: payload,
                attemptCount: attemptCount,
                createdAt: createdAt,
                lastAttemptAt: lastAttemptAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueItemsTable,
      SyncQueueItem,
      $$SyncQueueItemsTableFilterComposer,
      $$SyncQueueItemsTableOrderingComposer,
      $$SyncQueueItemsTableAnnotationComposer,
      $$SyncQueueItemsTableCreateCompanionBuilder,
      $$SyncQueueItemsTableUpdateCompanionBuilder,
      (
        SyncQueueItem,
        BaseReferences<_$AppDatabase, $SyncQueueItemsTable, SyncQueueItem>,
      ),
      SyncQueueItem,
      PrefetchHooks Function()
    >;
typedef $$CachedJobSummariesTableCreateCompanionBuilder =
    CachedJobSummariesCompanion Function({
      required String id,
      required String title,
      required String village,
      required String district,
      required int wageInRupees,
      required DateTime workDate,
      required DateTime cachedAt,
      Value<int> rowid,
    });
typedef $$CachedJobSummariesTableUpdateCompanionBuilder =
    CachedJobSummariesCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> village,
      Value<String> district,
      Value<int> wageInRupees,
      Value<DateTime> workDate,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

class $$CachedJobSummariesTableFilterComposer
    extends Composer<_$AppDatabase, $CachedJobSummariesTable> {
  $$CachedJobSummariesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get village => $composableBuilder(
    column: $table.village,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get district => $composableBuilder(
    column: $table.district,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wageInRupees => $composableBuilder(
    column: $table.wageInRupees,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get workDate => $composableBuilder(
    column: $table.workDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedJobSummariesTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedJobSummariesTable> {
  $$CachedJobSummariesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get village => $composableBuilder(
    column: $table.village,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get district => $composableBuilder(
    column: $table.district,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wageInRupees => $composableBuilder(
    column: $table.wageInRupees,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get workDate => $composableBuilder(
    column: $table.workDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedJobSummariesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedJobSummariesTable> {
  $$CachedJobSummariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get village =>
      $composableBuilder(column: $table.village, builder: (column) => column);

  GeneratedColumn<String> get district =>
      $composableBuilder(column: $table.district, builder: (column) => column);

  GeneratedColumn<int> get wageInRupees => $composableBuilder(
    column: $table.wageInRupees,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get workDate =>
      $composableBuilder(column: $table.workDate, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$CachedJobSummariesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedJobSummariesTable,
          CachedJobSummary,
          $$CachedJobSummariesTableFilterComposer,
          $$CachedJobSummariesTableOrderingComposer,
          $$CachedJobSummariesTableAnnotationComposer,
          $$CachedJobSummariesTableCreateCompanionBuilder,
          $$CachedJobSummariesTableUpdateCompanionBuilder,
          (
            CachedJobSummary,
            BaseReferences<
              _$AppDatabase,
              $CachedJobSummariesTable,
              CachedJobSummary
            >,
          ),
          CachedJobSummary,
          PrefetchHooks Function()
        > {
  $$CachedJobSummariesTableTableManager(
    _$AppDatabase db,
    $CachedJobSummariesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedJobSummariesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedJobSummariesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedJobSummariesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> village = const Value.absent(),
                Value<String> district = const Value.absent(),
                Value<int> wageInRupees = const Value.absent(),
                Value<DateTime> workDate = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedJobSummariesCompanion(
                id: id,
                title: title,
                village: village,
                district: district,
                wageInRupees: wageInRupees,
                workDate: workDate,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String village,
                required String district,
                required int wageInRupees,
                required DateTime workDate,
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedJobSummariesCompanion.insert(
                id: id,
                title: title,
                village: village,
                district: district,
                wageInRupees: wageInRupees,
                workDate: workDate,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedJobSummariesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedJobSummariesTable,
      CachedJobSummary,
      $$CachedJobSummariesTableFilterComposer,
      $$CachedJobSummariesTableOrderingComposer,
      $$CachedJobSummariesTableAnnotationComposer,
      $$CachedJobSummariesTableCreateCompanionBuilder,
      $$CachedJobSummariesTableUpdateCompanionBuilder,
      (
        CachedJobSummary,
        BaseReferences<
          _$AppDatabase,
          $CachedJobSummariesTable,
          CachedJobSummary
        >,
      ),
      CachedJobSummary,
      PrefetchHooks Function()
    >;
typedef $$LocalUsersTableCreateCompanionBuilder =
    LocalUsersCompanion Function({
      required String id,
      required String phoneNumber,
      required String role,
      required DateTime createdAt,
      required DateTime lastLoginAt,
      Value<int> rowid,
    });
typedef $$LocalUsersTableUpdateCompanionBuilder =
    LocalUsersCompanion Function({
      Value<String> id,
      Value<String> phoneNumber,
      Value<String> role,
      Value<DateTime> createdAt,
      Value<DateTime> lastLoginAt,
      Value<int> rowid,
    });

final class $$LocalUsersTableReferences
    extends BaseReferences<_$AppDatabase, $LocalUsersTable, LocalUser> {
  $$LocalUsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AuthSessionsTable, List<AuthSession>>
  _authSessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.authSessions,
    aliasName: $_aliasNameGenerator(
      db.localUsers.id,
      db.authSessions.localUserId,
    ),
  );

  $$AuthSessionsTableProcessedTableManager get authSessionsRefs {
    final manager = $$AuthSessionsTableTableManager(
      $_db,
      $_db.authSessions,
    ).filter((f) => f.localUserId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_authSessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalUsersTableFilterComposer
    extends Composer<_$AppDatabase, $LocalUsersTable> {
  $$LocalUsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastLoginAt => $composableBuilder(
    column: $table.lastLoginAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> authSessionsRefs(
    Expression<bool> Function($$AuthSessionsTableFilterComposer f) f,
  ) {
    final $$AuthSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.authSessions,
      getReferencedColumn: (t) => t.localUserId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AuthSessionsTableFilterComposer(
            $db: $db,
            $table: $db.authSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalUsersTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalUsersTable> {
  $$LocalUsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastLoginAt => $composableBuilder(
    column: $table.lastLoginAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalUsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalUsersTable> {
  $$LocalUsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastLoginAt => $composableBuilder(
    column: $table.lastLoginAt,
    builder: (column) => column,
  );

  Expression<T> authSessionsRefs<T extends Object>(
    Expression<T> Function($$AuthSessionsTableAnnotationComposer a) f,
  ) {
    final $$AuthSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.authSessions,
      getReferencedColumn: (t) => t.localUserId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AuthSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.authSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalUsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalUsersTable,
          LocalUser,
          $$LocalUsersTableFilterComposer,
          $$LocalUsersTableOrderingComposer,
          $$LocalUsersTableAnnotationComposer,
          $$LocalUsersTableCreateCompanionBuilder,
          $$LocalUsersTableUpdateCompanionBuilder,
          (LocalUser, $$LocalUsersTableReferences),
          LocalUser,
          PrefetchHooks Function({bool authSessionsRefs})
        > {
  $$LocalUsersTableTableManager(_$AppDatabase db, $LocalUsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalUsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalUsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalUsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> lastLoginAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalUsersCompanion(
                id: id,
                phoneNumber: phoneNumber,
                role: role,
                createdAt: createdAt,
                lastLoginAt: lastLoginAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String phoneNumber,
                required String role,
                required DateTime createdAt,
                required DateTime lastLoginAt,
                Value<int> rowid = const Value.absent(),
              }) => LocalUsersCompanion.insert(
                id: id,
                phoneNumber: phoneNumber,
                role: role,
                createdAt: createdAt,
                lastLoginAt: lastLoginAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalUsersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({authSessionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (authSessionsRefs) db.authSessions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (authSessionsRefs)
                    await $_getPrefetchedData<
                      LocalUser,
                      $LocalUsersTable,
                      AuthSession
                    >(
                      currentTable: table,
                      referencedTable: $$LocalUsersTableReferences
                          ._authSessionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$LocalUsersTableReferences(
                            db,
                            table,
                            p0,
                          ).authSessionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.localUserId == item.id,
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

typedef $$LocalUsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalUsersTable,
      LocalUser,
      $$LocalUsersTableFilterComposer,
      $$LocalUsersTableOrderingComposer,
      $$LocalUsersTableAnnotationComposer,
      $$LocalUsersTableCreateCompanionBuilder,
      $$LocalUsersTableUpdateCompanionBuilder,
      (LocalUser, $$LocalUsersTableReferences),
      LocalUser,
      PrefetchHooks Function({bool authSessionsRefs})
    >;
typedef $$AuthSessionsTableCreateCompanionBuilder =
    AuthSessionsCompanion Function({
      required String id,
      required String localUserId,
      required String phoneNumber,
      required String role,
      Value<bool> isActive,
      required DateTime createdAt,
      Value<DateTime?> lastRestoredAt,
      Value<DateTime?> loggedOutAt,
      Value<int> rowid,
    });
typedef $$AuthSessionsTableUpdateCompanionBuilder =
    AuthSessionsCompanion Function({
      Value<String> id,
      Value<String> localUserId,
      Value<String> phoneNumber,
      Value<String> role,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime?> lastRestoredAt,
      Value<DateTime?> loggedOutAt,
      Value<int> rowid,
    });

final class $$AuthSessionsTableReferences
    extends BaseReferences<_$AppDatabase, $AuthSessionsTable, AuthSession> {
  $$AuthSessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LocalUsersTable _localUserIdTable(_$AppDatabase db) =>
      db.localUsers.createAlias(
        $_aliasNameGenerator(db.authSessions.localUserId, db.localUsers.id),
      );

  $$LocalUsersTableProcessedTableManager get localUserId {
    final $_column = $_itemColumn<String>('local_user_id')!;

    final manager = $$LocalUsersTableTableManager(
      $_db,
      $_db.localUsers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_localUserIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AuthSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $AuthSessionsTable> {
  $$AuthSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastRestoredAt => $composableBuilder(
    column: $table.lastRestoredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get loggedOutAt => $composableBuilder(
    column: $table.loggedOutAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalUsersTableFilterComposer get localUserId {
    final $$LocalUsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.localUserId,
      referencedTable: $db.localUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalUsersTableFilterComposer(
            $db: $db,
            $table: $db.localUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AuthSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $AuthSessionsTable> {
  $$AuthSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastRestoredAt => $composableBuilder(
    column: $table.lastRestoredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedOutAt => $composableBuilder(
    column: $table.loggedOutAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalUsersTableOrderingComposer get localUserId {
    final $$LocalUsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.localUserId,
      referencedTable: $db.localUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalUsersTableOrderingComposer(
            $db: $db,
            $table: $db.localUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AuthSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuthSessionsTable> {
  $$AuthSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastRestoredAt => $composableBuilder(
    column: $table.lastRestoredAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get loggedOutAt => $composableBuilder(
    column: $table.loggedOutAt,
    builder: (column) => column,
  );

  $$LocalUsersTableAnnotationComposer get localUserId {
    final $$LocalUsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.localUserId,
      referencedTable: $db.localUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalUsersTableAnnotationComposer(
            $db: $db,
            $table: $db.localUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AuthSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuthSessionsTable,
          AuthSession,
          $$AuthSessionsTableFilterComposer,
          $$AuthSessionsTableOrderingComposer,
          $$AuthSessionsTableAnnotationComposer,
          $$AuthSessionsTableCreateCompanionBuilder,
          $$AuthSessionsTableUpdateCompanionBuilder,
          (AuthSession, $$AuthSessionsTableReferences),
          AuthSession,
          PrefetchHooks Function({bool localUserId})
        > {
  $$AuthSessionsTableTableManager(_$AppDatabase db, $AuthSessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuthSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuthSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuthSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> localUserId = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastRestoredAt = const Value.absent(),
                Value<DateTime?> loggedOutAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuthSessionsCompanion(
                id: id,
                localUserId: localUserId,
                phoneNumber: phoneNumber,
                role: role,
                isActive: isActive,
                createdAt: createdAt,
                lastRestoredAt: lastRestoredAt,
                loggedOutAt: loggedOutAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String localUserId,
                required String phoneNumber,
                required String role,
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> lastRestoredAt = const Value.absent(),
                Value<DateTime?> loggedOutAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuthSessionsCompanion.insert(
                id: id,
                localUserId: localUserId,
                phoneNumber: phoneNumber,
                role: role,
                isActive: isActive,
                createdAt: createdAt,
                lastRestoredAt: lastRestoredAt,
                loggedOutAt: loggedOutAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AuthSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({localUserId = false}) {
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
                    if (localUserId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.localUserId,
                                referencedTable: $$AuthSessionsTableReferences
                                    ._localUserIdTable(db),
                                referencedColumn: $$AuthSessionsTableReferences
                                    ._localUserIdTable(db)
                                    .id,
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

typedef $$AuthSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuthSessionsTable,
      AuthSession,
      $$AuthSessionsTableFilterComposer,
      $$AuthSessionsTableOrderingComposer,
      $$AuthSessionsTableAnnotationComposer,
      $$AuthSessionsTableCreateCompanionBuilder,
      $$AuthSessionsTableUpdateCompanionBuilder,
      (AuthSession, $$AuthSessionsTableReferences),
      AuthSession,
      PrefetchHooks Function({bool localUserId})
    >;
typedef $$FarmerProfilesTableCreateCompanionBuilder =
    FarmerProfilesCompanion Function({
      required String id,
      required String fullName,
      required String phoneNumber,
      required String village,
      required String district,
      required String stateName,
      required String farmType,
      required double landSize,
      required String preferredCropsJson,
      Value<String?> photoPath,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<bool> needsSync,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$FarmerProfilesTableUpdateCompanionBuilder =
    FarmerProfilesCompanion Function({
      Value<String> id,
      Value<String> fullName,
      Value<String> phoneNumber,
      Value<String> village,
      Value<String> district,
      Value<String> stateName,
      Value<String> farmType,
      Value<double> landSize,
      Value<String> preferredCropsJson,
      Value<String?> photoPath,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<bool> needsSync,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$FarmerProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $FarmerProfilesTable> {
  $$FarmerProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get village => $composableBuilder(
    column: $table.village,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get district => $composableBuilder(
    column: $table.district,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stateName => $composableBuilder(
    column: $table.stateName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get farmType => $composableBuilder(
    column: $table.farmType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get landSize => $composableBuilder(
    column: $table.landSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preferredCropsJson => $composableBuilder(
    column: $table.preferredCropsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get needsSync => $composableBuilder(
    column: $table.needsSync,
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

class $$FarmerProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $FarmerProfilesTable> {
  $$FarmerProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get village => $composableBuilder(
    column: $table.village,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get district => $composableBuilder(
    column: $table.district,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stateName => $composableBuilder(
    column: $table.stateName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get farmType => $composableBuilder(
    column: $table.farmType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get landSize => $composableBuilder(
    column: $table.landSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferredCropsJson => $composableBuilder(
    column: $table.preferredCropsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get needsSync => $composableBuilder(
    column: $table.needsSync,
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

class $$FarmerProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FarmerProfilesTable> {
  $$FarmerProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get village =>
      $composableBuilder(column: $table.village, builder: (column) => column);

  GeneratedColumn<String> get district =>
      $composableBuilder(column: $table.district, builder: (column) => column);

  GeneratedColumn<String> get stateName =>
      $composableBuilder(column: $table.stateName, builder: (column) => column);

  GeneratedColumn<String> get farmType =>
      $composableBuilder(column: $table.farmType, builder: (column) => column);

  GeneratedColumn<double> get landSize =>
      $composableBuilder(column: $table.landSize, builder: (column) => column);

  GeneratedColumn<String> get preferredCropsJson => $composableBuilder(
    column: $table.preferredCropsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<bool> get needsSync =>
      $composableBuilder(column: $table.needsSync, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$FarmerProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FarmerProfilesTable,
          FarmerProfile,
          $$FarmerProfilesTableFilterComposer,
          $$FarmerProfilesTableOrderingComposer,
          $$FarmerProfilesTableAnnotationComposer,
          $$FarmerProfilesTableCreateCompanionBuilder,
          $$FarmerProfilesTableUpdateCompanionBuilder,
          (
            FarmerProfile,
            BaseReferences<_$AppDatabase, $FarmerProfilesTable, FarmerProfile>,
          ),
          FarmerProfile,
          PrefetchHooks Function()
        > {
  $$FarmerProfilesTableTableManager(
    _$AppDatabase db,
    $FarmerProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FarmerProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FarmerProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FarmerProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<String> village = const Value.absent(),
                Value<String> district = const Value.absent(),
                Value<String> stateName = const Value.absent(),
                Value<String> farmType = const Value.absent(),
                Value<double> landSize = const Value.absent(),
                Value<String> preferredCropsJson = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<bool> needsSync = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FarmerProfilesCompanion(
                id: id,
                fullName: fullName,
                phoneNumber: phoneNumber,
                village: village,
                district: district,
                stateName: stateName,
                farmType: farmType,
                landSize: landSize,
                preferredCropsJson: preferredCropsJson,
                photoPath: photoPath,
                latitude: latitude,
                longitude: longitude,
                needsSync: needsSync,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String fullName,
                required String phoneNumber,
                required String village,
                required String district,
                required String stateName,
                required String farmType,
                required double landSize,
                required String preferredCropsJson,
                Value<String?> photoPath = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<bool> needsSync = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FarmerProfilesCompanion.insert(
                id: id,
                fullName: fullName,
                phoneNumber: phoneNumber,
                village: village,
                district: district,
                stateName: stateName,
                farmType: farmType,
                landSize: landSize,
                preferredCropsJson: preferredCropsJson,
                photoPath: photoPath,
                latitude: latitude,
                longitude: longitude,
                needsSync: needsSync,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FarmerProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FarmerProfilesTable,
      FarmerProfile,
      $$FarmerProfilesTableFilterComposer,
      $$FarmerProfilesTableOrderingComposer,
      $$FarmerProfilesTableAnnotationComposer,
      $$FarmerProfilesTableCreateCompanionBuilder,
      $$FarmerProfilesTableUpdateCompanionBuilder,
      (
        FarmerProfile,
        BaseReferences<_$AppDatabase, $FarmerProfilesTable, FarmerProfile>,
      ),
      FarmerProfile,
      PrefetchHooks Function()
    >;
typedef $$WorkerProfilesTableCreateCompanionBuilder =
    WorkerProfilesCompanion Function({
      required String id,
      required String fullName,
      required String phoneNumber,
      required String village,
      required String district,
      required String stateName,
      required String skillsJson,
      required int yearsOfExperience,
      required int dailyWageExpectation,
      required bool isAvailable,
      Value<String?> photoPath,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<bool> needsSync,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$WorkerProfilesTableUpdateCompanionBuilder =
    WorkerProfilesCompanion Function({
      Value<String> id,
      Value<String> fullName,
      Value<String> phoneNumber,
      Value<String> village,
      Value<String> district,
      Value<String> stateName,
      Value<String> skillsJson,
      Value<int> yearsOfExperience,
      Value<int> dailyWageExpectation,
      Value<bool> isAvailable,
      Value<String?> photoPath,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<bool> needsSync,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$WorkerProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $WorkerProfilesTable> {
  $$WorkerProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get village => $composableBuilder(
    column: $table.village,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get district => $composableBuilder(
    column: $table.district,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stateName => $composableBuilder(
    column: $table.stateName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get skillsJson => $composableBuilder(
    column: $table.skillsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get yearsOfExperience => $composableBuilder(
    column: $table.yearsOfExperience,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dailyWageExpectation => $composableBuilder(
    column: $table.dailyWageExpectation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get needsSync => $composableBuilder(
    column: $table.needsSync,
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

class $$WorkerProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkerProfilesTable> {
  $$WorkerProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get village => $composableBuilder(
    column: $table.village,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get district => $composableBuilder(
    column: $table.district,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stateName => $composableBuilder(
    column: $table.stateName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get skillsJson => $composableBuilder(
    column: $table.skillsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get yearsOfExperience => $composableBuilder(
    column: $table.yearsOfExperience,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dailyWageExpectation => $composableBuilder(
    column: $table.dailyWageExpectation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get needsSync => $composableBuilder(
    column: $table.needsSync,
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

class $$WorkerProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkerProfilesTable> {
  $$WorkerProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get village =>
      $composableBuilder(column: $table.village, builder: (column) => column);

  GeneratedColumn<String> get district =>
      $composableBuilder(column: $table.district, builder: (column) => column);

  GeneratedColumn<String> get stateName =>
      $composableBuilder(column: $table.stateName, builder: (column) => column);

  GeneratedColumn<String> get skillsJson => $composableBuilder(
    column: $table.skillsJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get yearsOfExperience => $composableBuilder(
    column: $table.yearsOfExperience,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dailyWageExpectation => $composableBuilder(
    column: $table.dailyWageExpectation,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<bool> get needsSync =>
      $composableBuilder(column: $table.needsSync, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$WorkerProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkerProfilesTable,
          WorkerProfile,
          $$WorkerProfilesTableFilterComposer,
          $$WorkerProfilesTableOrderingComposer,
          $$WorkerProfilesTableAnnotationComposer,
          $$WorkerProfilesTableCreateCompanionBuilder,
          $$WorkerProfilesTableUpdateCompanionBuilder,
          (
            WorkerProfile,
            BaseReferences<_$AppDatabase, $WorkerProfilesTable, WorkerProfile>,
          ),
          WorkerProfile,
          PrefetchHooks Function()
        > {
  $$WorkerProfilesTableTableManager(
    _$AppDatabase db,
    $WorkerProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkerProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkerProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkerProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<String> village = const Value.absent(),
                Value<String> district = const Value.absent(),
                Value<String> stateName = const Value.absent(),
                Value<String> skillsJson = const Value.absent(),
                Value<int> yearsOfExperience = const Value.absent(),
                Value<int> dailyWageExpectation = const Value.absent(),
                Value<bool> isAvailable = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<bool> needsSync = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkerProfilesCompanion(
                id: id,
                fullName: fullName,
                phoneNumber: phoneNumber,
                village: village,
                district: district,
                stateName: stateName,
                skillsJson: skillsJson,
                yearsOfExperience: yearsOfExperience,
                dailyWageExpectation: dailyWageExpectation,
                isAvailable: isAvailable,
                photoPath: photoPath,
                latitude: latitude,
                longitude: longitude,
                needsSync: needsSync,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String fullName,
                required String phoneNumber,
                required String village,
                required String district,
                required String stateName,
                required String skillsJson,
                required int yearsOfExperience,
                required int dailyWageExpectation,
                required bool isAvailable,
                Value<String?> photoPath = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<bool> needsSync = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => WorkerProfilesCompanion.insert(
                id: id,
                fullName: fullName,
                phoneNumber: phoneNumber,
                village: village,
                district: district,
                stateName: stateName,
                skillsJson: skillsJson,
                yearsOfExperience: yearsOfExperience,
                dailyWageExpectation: dailyWageExpectation,
                isAvailable: isAvailable,
                photoPath: photoPath,
                latitude: latitude,
                longitude: longitude,
                needsSync: needsSync,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkerProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkerProfilesTable,
      WorkerProfile,
      $$WorkerProfilesTableFilterComposer,
      $$WorkerProfilesTableOrderingComposer,
      $$WorkerProfilesTableAnnotationComposer,
      $$WorkerProfilesTableCreateCompanionBuilder,
      $$WorkerProfilesTableUpdateCompanionBuilder,
      (
        WorkerProfile,
        BaseReferences<_$AppDatabase, $WorkerProfilesTable, WorkerProfile>,
      ),
      WorkerProfile,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SyncQueueItemsTableTableManager get syncQueueItems =>
      $$SyncQueueItemsTableTableManager(_db, _db.syncQueueItems);
  $$CachedJobSummariesTableTableManager get cachedJobSummaries =>
      $$CachedJobSummariesTableTableManager(_db, _db.cachedJobSummaries);
  $$LocalUsersTableTableManager get localUsers =>
      $$LocalUsersTableTableManager(_db, _db.localUsers);
  $$AuthSessionsTableTableManager get authSessions =>
      $$AuthSessionsTableTableManager(_db, _db.authSessions);
  $$FarmerProfilesTableTableManager get farmerProfiles =>
      $$FarmerProfilesTableTableManager(_db, _db.farmerProfiles);
  $$WorkerProfilesTableTableManager get workerProfiles =>
      $$WorkerProfilesTableTableManager(_db, _db.workerProfiles);
}
