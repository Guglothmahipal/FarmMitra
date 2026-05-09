import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:farmmitra_app/shared/widgets/voice_instruction_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RoleSelectionPage extends ConsumerWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AuthScaffold(
      title: 'Choose your role',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'FarmMitra will personalize jobs, permissions, and profile setup based on your role.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 12),
          const VoiceInstructionButton(
            instruction:
                'Choose Farmer if you want workers for your farm. Choose Worker if you want farm jobs near you.',
          ),
          const SizedBox(height: 20),
          _RoleOption(
            role: UserRole.farmer,
            icon: Icons.agriculture,
            helperText: 'Post work, set wages, and manage applicants.',
          ),
          const SizedBox(height: 14),
          _RoleOption(
            role: UserRole.worker,
            icon: Icons.engineering,
            helperText: 'Find nearby jobs, apply, and track your work.',
          ),
          const SizedBox(height: 20),
          const _PreviousAccounts(),
        ],
      ),
    );
  }
}

class _RoleOption extends ConsumerWidget {
  const _RoleOption({
    required this.role,
    required this.icon,
    required this.helperText,
  });

  final UserRole role;
  final IconData icon;
  final String helperText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () async {
          await ref.read(authControllerProvider.notifier).selectRole(role);
          if (context.mounted) {
            context.go(AppRoutes.phoneLogin);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: scheme.secondaryContainer,
                foregroundColor: scheme.onSecondaryContainer,
                child: Icon(icon, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      role.label,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      helperText,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class _PreviousAccounts extends ConsumerWidget {
  const _PreviousAccounts();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(localAccountsProvider);

    return accounts.when(
      data: (items) {
        if (items.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Local accounts on this device',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final account in items)
                  ActionChip(
                    avatar: Icon(_iconForRole(account.role), size: 18),
                    label: Text('${account.role.label} ${account.phoneNumber}'),
                    visualDensity: VisualDensity.compact,
                    onPressed: () async {
                      final switched = await ref
                          .read(authControllerProvider.notifier)
                          .switchToAccount(account);
                      if (context.mounted && switched) {
                        context.go(AppRoutes.home);
                      }
                    },
                  ),
              ],
            ),
          ],
        );
      },
      error: (_, _) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
    );
  }

  IconData _iconForRole(UserRole role) {
    return role == UserRole.farmer ? Icons.agriculture : Icons.engineering;
  }
}
