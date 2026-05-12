import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/core/localization/locale_extensions.dart';
import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/profile/domain/entities/farmer_profile.dart';
import 'package:farmmitra_app/features/profile/domain/entities/worker_profile.dart';
import 'package:farmmitra_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:farmmitra_app/features/profile/presentation/widgets/location_action_button.dart';
import 'package:farmmitra_app/features/profile/presentation/widgets/profile_photo_picker.dart';
import 'package:farmmitra_app/features/profile/presentation/widgets/profile_section_card.dart';
import 'package:farmmitra_app/features/profile/presentation/widgets/profile_text_form_field.dart';
import 'package:farmmitra_app/features/profile/presentation/widgets/verified_phone_field.dart';
import 'package:farmmitra_app/features/profile/presentation/widgets/worker_skill_selector.dart';
import 'package:farmmitra_app/shared/widgets/app_error_message.dart';
import 'package:farmmitra_app/shared/widgets/app_loading_view.dart';
import 'package:farmmitra_app/shared/widgets/app_page_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileFormPage extends ConsumerStatefulWidget {
  const ProfileFormPage({required this.isEdit, super.key});

  final bool isEdit;

  @override
  ConsumerState<ProfileFormPage> createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends ConsumerState<ProfileFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _villageController = TextEditingController();
  Set<String> _selectedSkills = const {};
  bool _isAvailable = true;
  bool _hydrated = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _villageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final profileState = ref.watch(profileControllerProvider);
    final role = authState.selectedRole;

    if (role == null) {
      return AppPageScaffold(
        title: context.l10n.profileTitle,
        body: AppLoadingView(message: context.l10n.profileLoading),
      );
    }

    _hydrateOnce(role, authState.phoneNumber);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF6FAEF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6FAEF),
        elevation: 0,
        title: Text(
          widget.isEdit
              ? context.l10n.profileEditTitle
              : context.l10n.profileCompleteTitle,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: _handleBack,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 96),
              children: [
                _ProfileSetupHeader(role: role),
                const SizedBox(height: 16),
                ProfileSectionCard(
                  title: context.l10n.profileBasicDetails,
                  icon: Icons.person_outline,
                  child: Column(
                    children: [
                      ProfileTextFormField(
                        controller: _fullNameController,
                        label: context.l10n.profileFullName,
                        prefixIcon: Icons.badge_outlined,
                        validator: _required,
                      ),
                      const SizedBox(height: 10),
                      VerifiedPhoneField(phoneNumber: _phoneController.text),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                ProfileSectionCard(
                  title: context.l10n.profileLocation,
                  icon: Icons.location_on_outlined,
                  child: Column(
                    children: [
                      ProfileTextFormField(
                        controller: _villageController,
                        label: context.l10n.profileVillageTown,
                        validator: _required,
                      ),
                      const SizedBox(height: 10),
                      const LocationActionButton(),
                    ],
                  ),
                ),
                if (role == UserRole.worker) ...[
                  const SizedBox(height: 12),
                  _WorkerFields(
                    selectedSkills: _selectedSkills,
                    onSkillsChanged: (skills) {
                      setState(() => _selectedSkills = skills);
                    },
                    isAvailable: _isAvailable,
                    onAvailabilityChanged: (value) {
                      setState(() => _isAvailable = value);
                    },
                  ),
                ],
                const SizedBox(height: 12),
                ProfileSectionCard(
                  title: context.l10n.profilePhotoTitle,
                  icon: Icons.photo_camera_outlined,
                  child: const ProfilePhotoPicker(),
                ),
                if (profileState.errorMessage != null) ...[
                  const SizedBox(height: 12),
                  AppErrorMessage(message: profileState.errorMessage!),
                ],
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _ProfileSaveBar(
                label: widget.isEdit
                    ? context.l10n.profileSaveChanges
                    : context.l10n.profileSaveProfile,
                isLoading: profileState.isSaving,
                onPressed: _save,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleBack() async {
    if (widget.isEdit) {
      if (context.canPop()) {
        context.pop();
      } else {
        context.go(AppRoutes.profile);
      }
      return;
    }

    await ref
        .read(authControllerProvider.notifier)
        .clearActiveSessionKeepRole();
    if (mounted) {
      context.go(AppRoutes.phoneLogin);
    }
  }

  void _hydrateOnce(UserRole role, String? phoneNumber) {
    if (_hydrated) {
      return;
    }

    final profile = ref.read(profileControllerProvider).profile;
    _phoneController.text = phoneNumber ?? '';

    if (role == UserRole.farmer) {
      final farmer = profile?.farmer;
      if (farmer != null) {
        _hydrateFarmer(farmer);
      }
    } else {
      final worker = profile?.worker;
      if (worker != null) {
        _hydrateWorker(worker);
      }
    }

    _hydrated = true;
  }

  void _hydrateFarmer(FarmerProfile profile) {
    _fullNameController.text = profile.fullName;
    _phoneController.text = profile.phoneNumber;
    _villageController.text = profile.village;
  }

  void _hydrateWorker(WorkerProfile profile) {
    _fullNameController.text = profile.fullName;
    _phoneController.text = profile.phoneNumber;
    _villageController.text = profile.village;
    _selectedSkills = profile.skills.toSet();
    _isAvailable = profile.isAvailable;
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final role = ref.read(authControllerProvider).selectedRole;
    if (role == null) {
      return;
    }

    final controller = ref.read(profileControllerProvider.notifier);
    final saved = role == UserRole.farmer
        ? await controller.saveFarmerProfile(
            fullName: _fullNameController.text.trim(),
            phoneNumber: _phoneController.text.trim(),
            village: _villageController.text.trim(),
            district: '',
            stateName: '',
            farmType: '',
            landSize: 0,
            preferredCrops: const [],
          )
        : await controller.saveWorkerProfile(
            fullName: _fullNameController.text.trim(),
            phoneNumber: _phoneController.text.trim(),
            village: _villageController.text.trim(),
            district: '',
            stateName: '',
            skills: _selectedSkills.toList(growable: false),
            yearsOfExperience: 0,
            dailyWageExpectation: 0,
            isAvailable: _isAvailable,
          );

    if (saved && mounted) {
      context.go(AppRoutes.home);
    }
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.l10n.commonRequired;
    }
    return null;
  }
}

class _ProfileSetupHeader extends StatelessWidget {
  const _ProfileSetupHeader({required this.role});

  final UserRole role;

  @override
  Widget build(BuildContext context) {
    final isFarmer = role == UserRole.farmer;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFFFF), Color(0xFFEFF8E9)],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFDDE7D7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.045),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0xFFE7F4DF),
              foregroundColor: const Color(0xFF2F7D3C),
              child: Icon(
                isFarmer
                    ? Icons.agriculture_rounded
                    : Icons.engineering_rounded,
                size: 29,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.profileHeaderTitle,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: const Color(0xFF172016),
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    isFarmer
                        ? context.l10n.profileHeaderFarmerSubtitle
                        : context.l10n.profileHeaderWorkerSubtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF66735F),
                      height: 1.32,
                    ),
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

class _ProfileSaveBar extends StatefulWidget {
  const _ProfileSaveBar({
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });

  final String label;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  State<_ProfileSaveBar> createState() => _ProfileSaveBarState();
}

class _ProfileSaveBarState extends State<_ProfileSaveBar> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFF6FAEF).withValues(alpha: 0.96),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 20,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, bottomPadding == 0 ? 14 : 8),
          child: AnimatedScale(
            scale: _isPressed ? 0.985 : 1,
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  colors: [Color(0xFF236F45), Color(0xFF6DA853)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2F7D3C).withValues(alpha: 0.20),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: widget.isLoading ? null : widget.onPressed,
                  onHighlightChanged: (value) {
                    setState(() => _isPressed = value);
                  },
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
                                  context.l10n.commonSaving,
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
                                const Icon(
                                  Icons.save_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  widget.label,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                      ),
                                ),
                              ],
                            ),
                    ),
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

class _WorkerFields extends StatelessWidget {
  const _WorkerFields({
    required this.selectedSkills,
    required this.onSkillsChanged,
    required this.isAvailable,
    required this.onAvailabilityChanged,
  });

  final Set<String> selectedSkills;
  final ValueChanged<Set<String>> onSkillsChanged;
  final bool isAvailable;
  final ValueChanged<bool> onAvailabilityChanged;

  @override
  Widget build(BuildContext context) {
    return ProfileSectionCard(
      title: context.l10n.profileWorkDetails,
      icon: Icons.handyman_outlined,
      child: Column(
        children: [
          WorkerSkillSelector(
            selectedSkills: selectedSkills,
            onChanged: onSkillsChanged,
          ),
          const SizedBox(height: 10),
          DecoratedBox(
            decoration: BoxDecoration(
              color: const Color(0xFFEAF5E2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: SwitchListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              title: Text(context.l10n.profileAvailableForWork),
              subtitle: Text(context.l10n.profileAvailabilitySubtitle),
              value: isAvailable,
              onChanged: onAvailabilityChanged,
              activeThumbColor: const Color(0xFF2F7D3C),
            ),
          ),
        ],
      ),
    );
  }
}
