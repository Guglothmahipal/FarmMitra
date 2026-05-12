import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/core/localization/locale_provider.dart';
import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/shared/widgets/app_page_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeControllerProvider).locale;

    return AppPageScaffold(
      title: 'Settings',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.translate_outlined),
              title: const Text('Change Language'),
              subtitle: Text('${locale.nativeLabel} (${locale.englishLabel})'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push(AppRoutes.language),
            ),
          ),
          const SizedBox(height: 12),
          const _AccountSwitcherSection(),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.cloud_done_outlined),
              title: const Text('Offline-first mode'),
              subtitle: const Text(
                'Profile, jobs, and sessions stay available locally.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountSwitcherSection extends ConsumerWidget {
  const _AccountSwitcherSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(localAccountsProvider);
    final activeUserId = ref.watch(authControllerProvider).localUserId;

    return accounts.when(
      data: (items) {
        if (items.isEmpty) {
          return const SizedBox.shrink();
        }

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Switch account',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                for (final account in items)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(_iconForRole(account.role)),
                    title: Text('${account.role.label} ${account.phoneNumber}'),
                    subtitle: Text(
                      account.id == activeUserId
                          ? 'Current account'
                          : 'Saved local account',
                    ),
                    trailing: account.id == activeUserId
                        ? const Chip(
                            label: Text('Active'),
                            visualDensity: VisualDensity.compact,
                          )
                        : TextButton(
                            onPressed: () async {
                              final switched = await ref
                                  .read(authControllerProvider.notifier)
                                  .switchToAccount(account);
                              if (context.mounted && switched) {
                                context.go(AppRoutes.home);
                              }
                            },
                            child: const Text('Switch'),
                          ),
                  ),
              ],
            ),
          ),
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
