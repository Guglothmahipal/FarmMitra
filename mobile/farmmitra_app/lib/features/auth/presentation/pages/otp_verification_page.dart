import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/auth/presentation/widgets/auth_card.dart';
import 'package:farmmitra_app/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:farmmitra_app/shared/widgets/app_error_message.dart';
import 'package:farmmitra_app/shared/widgets/app_primary_button.dart';
import 'package:farmmitra_app/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OtpVerificationPage extends ConsumerStatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  ConsumerState<OtpVerificationPage> createState() =>
      _OtpVerificationPageState();
}

class _OtpVerificationPageState extends ConsumerState<OtpVerificationPage> {
  late final TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final phoneNumber = authState.pendingPhoneNumber ?? 'your mobile number';

    return AuthScaffold(
      title: 'OTP verification',
      showBackButton: true,
      child: AuthCard(
        icon: Icons.password,
        title: 'Enter OTP',
        subtitle: 'Enter the 6-digit code sent to $phoneNumber.',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
              controller: _otpController,
              label: 'OTP',
              hintText: '6-digit code',
              prefixIcon: Icons.lock_outline,
              keyboardType: TextInputType.number,
              maxLength: 6,
              autofocus: true,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
            ),
            if (authState.errorMessage != null) ...[
              const SizedBox(height: 12),
              AppErrorMessage(message: authState.errorMessage!),
            ],
            const SizedBox(height: 20),
            AppPrimaryButton(
              label: authState.isSubmitting
                  ? 'Verifying...'
                  : 'Verify and continue',
              icon: Icons.verified_user_outlined,
              isLoading: authState.isSubmitting,
              onPressed: _submit,
            ),
            const SizedBox(height: 8),
            Text(
              'Resend OTP available in 30 seconds',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: authState.isSubmitting
                  ? null
                  : () => context.go(AppRoutes.phoneLogin),
              child: const Text('Change mobile number'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    final verified = await ref
        .read(authControllerProvider.notifier)
        .verifyOtp(_otpController.text);

    if (verified && mounted) {
      context.go(AppRoutes.home);
    }
  }
}
