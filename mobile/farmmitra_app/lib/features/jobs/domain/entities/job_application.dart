import 'package:farmmitra_app/core/sync/sync_status.dart';

enum JobApplicationStatus {
  pending,
  accepted,
  rejected,
  withdrawn;

  String get label => switch (this) {
    JobApplicationStatus.pending => 'Pending',
    JobApplicationStatus.accepted => 'Accepted',
    JobApplicationStatus.rejected => 'Rejected',
    JobApplicationStatus.withdrawn => 'Withdrawn',
  };

  static JobApplicationStatus fromValue(String value) {
    return JobApplicationStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => JobApplicationStatus.pending,
    );
  }
}

final class JobApplication {
  const JobApplication({
    required this.id,
    required this.jobId,
    required this.workerLocalUserId,
    required this.status,
    required this.syncStatus,
    required this.needsSync,
    required this.createdAt,
    required this.updatedAt,
    this.message,
  });

  final String id;
  final String jobId;
  final String workerLocalUserId;
  final JobApplicationStatus status;
  final String? message;
  final SyncStatus syncStatus;
  final bool needsSync;
  final DateTime createdAt;
  final DateTime updatedAt;
}
