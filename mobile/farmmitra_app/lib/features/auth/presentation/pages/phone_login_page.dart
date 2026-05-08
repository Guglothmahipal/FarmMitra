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

class PhoneLoginPage extends ConsumerStatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  ConsumerState<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends ConsumerState<PhoneLoginPage> {
  late final TextEditingController _phoneController;

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
    final role = authState.selectedRole;

    return AuthScaffold(
      title: 'Mobile login',
      showBackButton: true,
      child: AuthCard(
        icon: Icons.phone_android,
        title: 'Verify your number',
        subtitle:
            'We will send an OTP to continue as ${role?.label ?? 'FarmMitra user'}.',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
              controller: _phoneController,
              label: 'Mobile number',
              hintText: '10-digit mobile number',
              prefixIcon: Icons.phone,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              autofocus: true,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),
            if (authState.errorMessage != null) ...[
              const SizedBox(height: 12),
              AppErrorMessage(message: authState.errorMessage!),
            ],
            const SizedBox(height: 20),
            AppPrimaryButton(
              label: 'Send OTP',
              icon: Icons.sms_outlined,
              isLoading: authState.isSubmitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    final sent = await ref
        .read(authControllerProvider.notifier)
        .requestOtp(_phoneController.text);

    if (sent && mounted) {
      context.go(AppRoutes.otpVerify);
    }
  }
}
