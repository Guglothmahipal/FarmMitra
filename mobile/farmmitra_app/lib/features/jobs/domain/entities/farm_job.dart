import 'package:farmmitra_app/core/sync/sync_status.dart';

enum JobStatus {
  draft,
  open,
  filled,
  closed,
  archived;

  String get label => switch (this) {
    JobStatus.draft => 'Draft',
    JobStatus.open => 'Open',
    JobStatus.filled => 'Filled',
    JobStatus.closed => 'Closed',
    JobStatus.archived => 'Archived',
  };

  bool get canApply => this == JobStatus.open;

  static JobStatus fromValue(String value) {
    return JobStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => JobStatus.open,
    );
  }
}

final class FarmJob {
  const FarmJob({
    required this.id,
    required this.farmerLocalUserId,
    required this.title,
    required this.category,
    required this.description,
    required this.workType,
    required this.wage,
    required this.workersRequired,
    required this.workDate,
    required this.location,
    required this.status,
    required this.syncStatus,
    required this.needsSync,
    required this.createdAt,
    required this.updatedAt,
    this.notes,
  });

  final String id;
  final String farmerLocalUserId;
  final String title;
  final String category;
  final String description;
  final String workType;
  final String? notes;
  final int wage;
  final int workersRequired;
  final DateTime workDate;
  final String location;
  final JobStatus status;
  final SyncStatus syncStatus;
  final bool needsSync;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isOpen => status == JobStatus.open;

  bool get canApply => status.canApply;
}
