import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.name,
    required this.role,
    required this.village,
    required this.district,
    this.needsSync = false,
    super.key,
  });

  final String name;
  final UserRole role;
  final String village;
  final String district;
  final bool needsSync;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: scheme.primaryContainer,
              foregroundColor: scheme.onPrimaryContainer,
              child: Icon(
                role == UserRole.farmer ? Icons.agriculture : Icons.engineering,
                size: 30,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text(
                    '${role.label} • $village, $district',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Chip(
                    avatar: Icon(
                      needsSync ? Icons.cloud_upload_outlined : Icons.verified,
                      size: 18,
                    ),
                    label: Text(needsSync ? 'Offline changes saved' : 'Synced'),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
