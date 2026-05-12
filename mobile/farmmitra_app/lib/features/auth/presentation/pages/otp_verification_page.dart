import 'dart:async';

import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/core/localization/locale_extensions.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/auth/presentation/widgets/auth_background.dart';
import 'package:farmmitra_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:farmmitra_app/features/auth/presentation/widgets/auth_keyboard_safe_body.dart';
import 'package:farmmitra_app/features/auth/presentation/widgets/otp_input_widget.dart';
import 'package:farmmitra_app/shared/widgets/app_error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OtpVerificationPage extends ConsumerStatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  ConsumerState<OtpVerificationPage> createState() =>
      _OtpVerificationPageState();
}

class _OtpVerificationPageState extends ConsumerState<OtpVerificationPage> {
  String _otp = '';
  int _secondsRemaining = 30;
  Timer? _timer;
  bool _isVerifying = false;
  bool _isResending = false;

  @override
  void initState() {
    super.initState();
    _startTimer(notify: false);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final phoneNumber = authState.pendingPhoneNumber ?? 'your mobile number';
    final l10n = context.l10n;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: AuthBackground(
        child: AuthKeyboardSafeBody(
          onBack: _goBackToLogin,
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
                  AuthHeader(
                    icon: Icons.password_rounded,
                    title: l10n.otpTitle,
                    subtitle: l10n.otpSubtitle(phoneNumber),
                  ),
                  const SizedBox(height: 22),
                  OtpInputWidget(
                    onChanged: (value) {
                      setState(() => _otp = value);
                    },
                    onCompleted: (_) => _submit(),
                  ),
                  if (authState.errorMessage != null) ...[
                    const SizedBox(height: 12),
                    AppErrorMessage(message: authState.errorMessage!),
                  ],
                  const SizedBox(height: 18),
                  _VerifyButton(
                    isLoading: _isVerifying,
                    isEnabled:
                        _otp.length == 6 && !_isVerifying && !_isResending,
                    onPressed: _submit,
                  ),
                  const SizedBox(height: 12),
                  _ResendRow(
                    secondsRemaining: _secondsRemaining,
                    isLoading: _isResending,
                    onResend: _resendOtp,
                  ),
                  const SizedBox(height: 2),
                  TextButton(
                    onPressed: _isVerifying || _isResending
                        ? null
                        : _goBackToLogin,
                    child: Text(l10n.otpChangeMobile),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _goBackToLogin() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.phoneLogin);
    }
  }

  void _startTimer({bool notify = true}) {
    _timer?.cancel();
    if (notify) {
      setState(() => _secondsRemaining = 30);
    } else {
      _secondsRemaining = 30;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_secondsRemaining <= 1) {
        timer.cancel();
        setState(() => _secondsRemaining = 0);
        return;
      }

      setState(() => _secondsRemaining--);
    });
  }

  Future<void> _resendOtp() async {
    setState(() => _isResending = true);
    final phoneNumber = ref.read(authControllerProvider).pendingPhoneNumber;
    if (phoneNumber == null) {
      context.go(AppRoutes.phoneLogin);
      return;
    }

    final sent = await ref
        .read(authControllerProvider.notifier)
        .requestOtp(phoneNumber);
    if (sent && mounted) {
      _startTimer();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.otpSentAgain)));
    }
    if (mounted) {
      setState(() => _isResending = false);
    }
  }

  Future<void> _submit() async {
    if (_otp.length != 6) {
      return;
    }

    setState(() => _isVerifying = true);
    FocusScope.of(context).unfocus();
    final verified = await ref
        .read(authControllerProvider.notifier)
        .verifyOtp(_otp);

    if (verified && mounted) {
      context.go(AppRoutes.home);
      return;
    }

    if (mounted) {
      setState(() => _isVerifying = false);
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

class _VerifyButton extends StatefulWidget {
  const _VerifyButton({
    required this.onPressed,
    required this.isLoading,
    required this.isEnabled,
  });

  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;

  @override
  State<_VerifyButton> createState() => _VerifyButtonState();
}

class _VerifyButtonState extends State<_VerifyButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isEnabled || widget.isLoading ? 1 : 0.52,
      duration: const Duration(milliseconds: 180),
      child: AnimatedScale(
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
                color: const Color(0xFF2F7D3C).withValues(alpha: 0.22),
                blurRadius: 18,
                offset: const Offset(0, 9),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(999),
              onTap: widget.isEnabled && !widget.isLoading
                  ? widget.onPressed
                  : null,
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
                              context.l10n.otpVerifying,
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
                              context.l10n.otpVerifyButton,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                            const SizedBox(width: 12),
                            const Icon(
                              Icons.verified_user_outlined,
                              color: Colors.white,
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ResendRow extends StatelessWidget {
  const _ResendRow({
    required this.secondsRemaining,
    required this.isLoading,
    required this.onResend,
  });

  final int secondsRemaining;
  final bool isLoading;
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    final canResend = secondsRemaining == 0 && !isLoading;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: Text(
            canResend
                ? context.l10n.otpResendReady
                : context.l10n.otpResendIn(secondsRemaining),
            key: ValueKey(canResend ? 'ready' : secondsRemaining),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFF60695B),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 4),
        TextButton(
          onPressed: canResend ? onResend : null,
          style: TextButton.styleFrom(
            visualDensity: VisualDensity.compact,
            foregroundColor: const Color(0xFF2F7D3C),
            disabledForegroundColor: const Color(0xFF9BA596),
          ),
          child: Text(context.l10n.otpResendButton),
        ),
      ],
    );
  }
}
