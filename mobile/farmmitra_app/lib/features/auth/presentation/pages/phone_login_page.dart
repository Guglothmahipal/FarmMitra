import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/features/auth/domain/entities/mock_google_account.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/auth/presentation/widgets/auth_background.dart';
import 'package:farmmitra_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:farmmitra_app/features/auth/presentation/widgets/google_auth_button.dart';
import 'package:farmmitra_app/features/auth/presentation/widgets/phone_input_field.dart';
import 'package:farmmitra_app/shared/widgets/app_error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PhoneLoginPage extends ConsumerStatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  ConsumerState<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends ConsumerState<PhoneLoginPage> {
  late final TextEditingController _phoneController;
  bool _isOtpSubmitting = false;
  bool _isGoogleSubmitting = false;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final viewInsets = MediaQuery.viewInsetsOf(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: AuthBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 8,
                left: 12,
                child: IconButton.filledTonal(
                  onPressed: () => context.go(AppRoutes.roleSelection),
                  icon: const Icon(Icons.arrow_back_rounded),
                ),
              ),
              AnimatedPadding(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                padding: EdgeInsets.fromLTRB(
                  20,
                  54,
                  20,
                  viewInsets.bottom + 18,
                ),
                child: Center(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 430),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 520),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 18 * (1 - value)),
                              child: child,
                            ),
                          );
                        },
                        child: _AuthCard(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const AuthHeader(
                                title: 'Welcome to KhetRojgar',
                                subtitle:
                                    'Securely login to manage your farm and access opportunities.',
                              ),
                              const SizedBox(height: 22),
                              PhoneInputField(controller: _phoneController),
                              if (authState.errorMessage != null) ...[
                                const SizedBox(height: 12),
                                AppErrorMessage(
                                  message: authState.errorMessage!,
                                ),
                              ],
                              const SizedBox(height: 18),
                              _OtpButton(
                                isLoading: _isOtpSubmitting,
                                onPressed: _isOtpSubmitting ? null : _submit,
                              ),
                              const SizedBox(height: 15),
                              const _DividerLabel(label: 'or continue with'),
                              const SizedBox(height: 14),
                              GoogleAuthButton(
                                isLoading: _isGoogleSubmitting,
                                onPressed: _isGoogleSubmitting
                                    ? null
                                    : _showGoogleMockSheet,
                              ),
                              const SizedBox(height: 20),
                              const _TrustRow(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showGoogleMockSheet() async {
    setState(() => _isGoogleSubmitting = true);
    final role = ref.read(authControllerProvider).selectedRole;
    if (role == null) {
      setState(() => _isGoogleSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a role first.')),
      );
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
      if (mounted) {
        setState(() => _isGoogleSubmitting = false);
      }
      return;
    }

    final signedIn = await ref
        .read(authControllerProvider.notifier)
        .continueWithGoogle(account);
    if (signedIn && mounted) {
      context.go(AppRoutes.home);
      return;
    }

    if (mounted) {
      setState(() => _isGoogleSubmitting = false);
    }
  }

  Future<void> _submit() async {
    setState(() => _isOtpSubmitting = true);
    FocusScope.of(context).unfocus();
    final sent = await ref
        .read(authControllerProvider.notifier)
        .requestOtp(_phoneController.text);

    if (sent && mounted) {
      await context.push(AppRoutes.otpVerify);
      if (mounted) {
        setState(() => _isOtpSubmitting = false);
      }
      return;
    }

    if (mounted) {
      setState(() => _isOtpSubmitting = false);
    }
  }
}

class _AuthCard extends StatelessWidget {
  const _AuthCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFF9FCF5).withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: Colors.white.withValues(alpha: 0.62)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
        child: child,
      ),
    );
  }
}

class _OtpButton extends StatefulWidget {
  const _OtpButton({required this.onPressed, required this.isLoading});

  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  State<_OtpButton> createState() => _OtpButtonState();
}

class _OtpButtonState extends State<_OtpButton> {
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
            colors: [Color(0xFF1F7148), Color(0xFF79A953)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2F7D3C).withValues(alpha: 0.24),
              blurRadius: 18,
              offset: const Offset(0, 9),
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
              height: 54,
              child: Center(
                child: widget.isLoading
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Sending OTP...',
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Continue with OTP',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                          const SizedBox(width: 14),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
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

class _DividerLabel extends StatelessWidget {
  const _DividerLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFD8E0D2))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFF60695B),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFD8E0D2))),
      ],
    );
  }
}

class _TrustRow extends StatelessWidget {
  const _TrustRow();

  @override
  Widget build(BuildContext context) {
    const items = [
      (Icons.verified_user_outlined, 'Secure Login'),
      (Icons.lock_outline_rounded, 'Data Privacy'),
      (Icons.flash_on_rounded, 'Fast OTP'),
    ];

    return Row(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          Expanded(
            child: Column(
              children: [
                Icon(items[i].$1, color: const Color(0xFF6F786B), size: 23),
                const SizedBox(height: 6),
                Text(
                  items[i].$2,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF697461),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          if (i < items.length - 1)
            Container(width: 1, height: 34, color: const Color(0xFFD9E1D2)),
        ],
      ],
    );
  }
}
