import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/core/localization/locale_extensions.dart';
import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
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
    final selectedRole = _selectedRole;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: const Color(0xFFF6FAEF),
      body: Column(
        children: [
          WelcomeHeroSection(
            imageAsset: 'assets/onboarding/webp/Choose_Role.webp',
            title: l10n.appName,
            subtitle: l10n.roleHeroSubtitle,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.roleQuestion,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: const Color(0xFF172016),
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.roleDescription,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF67705F),
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _AnimatedRoleCard(
                    delay: const Duration(milliseconds: 80),
                    child: RoleSelectionCard(
                      title: l10n.roleFarmerTitle,
                      description: l10n.roleFarmerDescription,
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
                      title: l10n.roleWorkerTitle,
                      description: l10n.roleWorkerDescription,
                      icon: Icons.engineering_rounded,
                      isSelected: selectedRole == UserRole.worker,
                      gradient: const [Color(0xFF956625), Color(0xFFE4A843)],
                      onTap: () =>
                          setState(() => _selectedRole = UserRole.worker),
                    ),
                  ),
                  const SizedBox(height: 18),
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
              ? _SelectRoleHint(
                  key: const ValueKey('role-hint'),
                  label: l10n.roleSelectHint,
                )
              : Column(
                  key: const ValueKey('role-actions'),
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _PremiumContinueButton(
                      onPressed: () => _continueWithPhone(selectedRole),
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
      context.push(AppRoutes.phoneLogin);
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
  const _PremiumContinueButton({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  State<_PremiumContinueButton> createState() => _PremiumContinueButtonState();
}

class _PremiumContinueButtonState extends State<_PremiumContinueButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null;

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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.l10n.commonContinue,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
  const _SelectRoleHint({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      key: key,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: const Color(0xFF697461),
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
