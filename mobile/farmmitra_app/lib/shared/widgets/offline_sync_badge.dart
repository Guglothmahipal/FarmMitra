import 'package:farmmitra_app/core/sync/sync_status.dart';
import 'package:farmmitra_app/shared/widgets/app_status_chip.dart';
import 'package:flutter/material.dart';

class OfflineSyncBadge extends StatelessWidget {
  const OfflineSyncBadge({required this.status, super.key});

  final SyncStatus status;

  @override
  Widget build(BuildContext context) {
    return AppStatusChip(
      label: status.label,
      icon: switch (status) {
        SyncStatus.synced => Icons.cloud_done_outlined,
        SyncStatus.pending => Icons.cloud_upload_outlined,
        SyncStatus.failed => Icons.cloud_off_outlined,
      },
    );
  }
}
