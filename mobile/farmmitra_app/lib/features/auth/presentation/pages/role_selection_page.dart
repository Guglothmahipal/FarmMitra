import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/features/auth/domain/entities/mock_google_account.dart';
import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/auth/presentation/widgets/auth_social_button.dart';
import 'package:farmmitra_app/features/auth/presentation/widgets/role_selection_card.dart';
import 'package:farmmitra_app/features/auth/presentation/widgets/welcome_hero_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RoleSelectionPage extends ConsumerStatefulWidget {
  const RoleSelectionPage({super.key});

  @override
  ConsumerState<RoleSelectionPage> createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends ConsumerState<RoleSelectionPage> {
  UserRole? _selectedRole;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final selectedRole = _selectedRole;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF6FAEF),
      body: Column(
        children: [
          const WelcomeHeroSection(
            imageAsset: 'assets/onboarding/choose_role.png',
            title: 'KhetRojgar',
            subtitle: 'Choose your role to continue',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'How will you use KhetRojgar?',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: const Color(0xFF172016),
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Select one option now. You can test farmer and worker accounts separately.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF67705F),
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _AnimatedRoleCard(
                    delay: const Duration(milliseconds: 80),
                    child: RoleSelectionCard(
                      title: 'Farmer',
                      description:
                          'Post labour jobs, find workers and manage farm operations.',
                      icon: Icons.agriculture_rounded,
                      isSelected: selectedRole == UserRole.farmer,
                      gradient: const [Color(0xFF2F7D3C), Color(0xFF5EAE59)],
                      onTap: () =>
                          setState(() => _selectedRole = UserRole.farmer),
                    ),
                  ),
                  const SizedBox(height: 14),
                  _AnimatedRoleCard(
                    delay: const Duration(milliseconds: 160),
                    child: RoleSelectionCard(
                      title: 'Worker',
                      description:
                          'Find nearby farm jobs and manage your daily work.',
                      icon: Icons.engineering_rounded,
                      isSelected: selectedRole == UserRole.worker,
                      gradient: const [Color(0xFF956625), Color(0xFFE4A843)],
                      onTap: () =>
                          setState(() => _selectedRole = UserRole.worker),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const _PreviousAccounts(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.fromLTRB(20, 12, 20, bottomPadding + 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF6FAEF).withValues(alpha: 0.96),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: selectedRole == null ? 0 : 0.08,
              ),
              offset: const Offset(0, -10),
              blurRadius: 24,
            ),
          ],
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 260),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (child, animation) {
            final offset = Tween<Offset>(
              begin: const Offset(0, 0.22),
              end: Offset.zero,
            ).animate(animation);

            return FadeTransition(
              opacity: animation,
              child: SlideTransition(position: offset, child: child),
            );
          },
          child: selectedRole == null
              ? const _SelectRoleHint(key: ValueKey('role-hint'))
              : Column(
                  key: const ValueKey('role-actions'),
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _PremiumContinueButton(
                      isLoading: authState.isSubmitting,
                      onPressed: authState.isSubmitting
                          ? null
                          : () => _continueWithPhone(selectedRole),
                    ),
                    const SizedBox(height: 12),
                    AuthSocialButton(
                      label: 'Continue with Google',
                      isLoading: authState.isSubmitting,
                      onPressed: authState.isSubmitting
                          ? null
                          : () => _showGoogleMockSheet(selectedRole),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> _continueWithPhone(UserRole role) async {
    await ref.read(authControllerProvider.notifier).selectRole(role);
    if (mounted) {
      context.go(AppRoutes.phoneLogin);
    }
  }

  Future<void> _showGoogleMockSheet(UserRole role) async {
    await ref.read(authControllerProvider.notifier).selectRole(role);
    if (!mounted) {
      return;
    }

    final account = await showModalBottomSheet<MockGoogleAccount>(
      context: context,
      showDragHandle: true,
      backgroundColor: const Color(0xFFF8FBF2),
      builder: (context) => Consumer(
        builder: (context, ref, _) {
          final accounts = ref.watch(mockGoogleAccountsProvider(role));

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 4, 18, 18),
              child: accounts.when(
                data: (items) => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose Google account',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Continue as ${role.label} with a saved local account.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF67705F),
                      ),
                    ),
                    const SizedBox(height: 14),
                    for (final item in items)
                      Card(
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: const BorderSide(color: Color(0xFFE2E8DB)),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFFE6F4DE),
                            foregroundColor: const Color(0xFF2F7D3C),
                            child: Text(item.name.substring(0, 1)),
                          ),
                          title: Text(
                            item.name,
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                          subtitle: Text(item.email),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          onTap: () => Navigator.of(context).pop(item),
                        ),
                      ),
                  ],
                ),
                error: (_, _) => const ListTile(
                  leading: Icon(Icons.error_outline),
                  title: Text('Could not load mock Google accounts'),
                ),
                loading: () => const Padding(
                  padding: EdgeInsets.all(28),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          );
        },
      ),
    );

    if (account == null || !mounted) {
      return;
    }

    final signedIn = await ref
        .read(authControllerProvider.notifier)
        .continueWithGoogle(account);
    if (signedIn && mounted) {
      context.go(AppRoutes.home);
    }
  }
}

class _AnimatedRoleCard extends StatelessWidget {
  const _AnimatedRoleCard({required this.child, required this.delay});

  final Widget child;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 520 + delay.inMilliseconds),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        final delayedValue = ((value * 1.18) - 0.18).clamp(0.0, 1.0);
        return Opacity(
          opacity: delayedValue,
          child: Transform.translate(
            offset: Offset(0, 18 * (1 - delayedValue)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class _PremiumContinueButton extends StatefulWidget {
  const _PremiumContinueButton({
    required this.onPressed,
    required this.isLoading,
  });

  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  State<_PremiumContinueButton> createState() => _PremiumContinueButtonState();
}

class _PremiumContinueButtonState extends State<_PremiumContinueButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null && !widget.isLoading;

    return AnimatedScale(
      scale: _isPressed ? 0.98 : 1,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          gradient: const LinearGradient(
            colors: [Color(0xFF2F7D3C), Color(0xFF71BD58)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF43A047).withValues(alpha: 0.34),
              offset: const Offset(0, 14),
              blurRadius: 24,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: isEnabled ? widget.onPressed : null,
            onHighlightChanged: (value) => setState(() => _isPressed = value),
            child: SizedBox(
              height: 58,
              child: Center(
                child: widget.isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.4,
                          color: Colors.white,
                        ),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Continue',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectRoleHint extends StatelessWidget {
  const _SelectRoleHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Select Farmer or Worker to continue',
      key: key,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: const Color(0xFF697461),
        fontWeight: FontWeight.w700,
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
              'Recent accounts',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: const Color(0xFF33402F),
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final account in items)
                  ActionChip(
                    avatar: Icon(_iconForRole(account.role), size: 18),
                    label: Text('${account.role.label} ${account.phoneNumber}'),
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
    return role == UserRole.farmer
        ? Icons.agriculture_rounded
        : Icons.engineering_rounded;
  }
}
