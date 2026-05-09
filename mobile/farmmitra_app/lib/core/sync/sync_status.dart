enum SyncStatus {
  synced,
  pending,
  failed;

  String get label => switch (this) {
    SyncStatus.synced => 'Synced',
    SyncStatus.pending => 'Pending sync',
    SyncStatus.failed => 'Sync failed',
  };

  static SyncStatus fromValue(String value) {
    return SyncStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => SyncStatus.pending,
    );
  }
}
