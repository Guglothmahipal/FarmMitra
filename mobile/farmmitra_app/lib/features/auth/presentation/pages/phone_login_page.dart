import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/features/auth/domain/entities/mock_google_account.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/auth/presentation/widgets/auth_card.dart';
import 'package:farmmitra_app/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:farmmitra_app/shared/widgets/app_error_message.dart';
import 'package:farmmitra_app/shared/widgets/app_primary_button.dart';
import 'package:farmmitra_app/shared/widgets/app_text_field.dart';
import 'package:farmmitra_app/shared/widgets/voice_instruction_button.dart';
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
            const VoiceInstructionButton(
              instruction:
                  'Enter your ten digit mobile number. You can use any OTP in this demo app.',
            ),
            const SizedBox(height: 16),
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
              label: authState.isSubmitting ? 'Sending OTP...' : 'Send OTP',
              icon: Icons.sms_outlined,
              isLoading: authState.isSubmitting,
              onPressed: _submit,
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: authState.isSubmitting ? null : _showGoogleMockSheet,
              icon: const Icon(Icons.account_circle_outlined),
              label: const Text('Continue with Google'),
            ),
            const SizedBox(height: 12),
            const _AuthHelpCard(),
          ],
        ),
      ),
    );
  }

  Future<void> _showGoogleMockSheet() async {
    final role = ref.read(authControllerProvider).selectedRole;
    if (role == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a role first.')),
      );
      return;
    }

    final account = await showModalBottomSheet<MockGoogleAccount>(
      context: context,
      showDragHandle: true,
      builder: (context) => Consumer(
        builder: (context, ref, _) {
          final accounts = ref.watch(mockGoogleAccountsProvider(role));

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: accounts.when(
                data: (items) => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose Google account',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Mock Google sign-in for ${role.label}. Real Firebase/Google auth can plug in here later.',
                    ),
                    const SizedBox(height: 12),
                    for (final item in items)
                      Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(item.name.substring(0, 1)),
                          ),
                          title: Text(item.name),
                          subtitle: Text(item.email),
                          trailing: Chip(
                            label: Text(item.preferredRole.label),
                            visualDensity: VisualDensity.compact,
                          ),
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
                  padding: EdgeInsets.all(24),
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

class _AuthHelpCard extends StatelessWidget {
  const _AuthHelpCard();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        dense: true,
        leading: Icon(Icons.info_outline),
        title: Text('MVP login'),
        subtitle: Text(
          'OTP and Google are mocked locally now. Sessions persist on this device.',
        ),
      ),
    );
  }
}
